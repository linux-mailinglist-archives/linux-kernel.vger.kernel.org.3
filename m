Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4235658A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbiGDObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGDObI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:31:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2212C38A4;
        Mon,  4 Jul 2022 07:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B249B61667;
        Mon,  4 Jul 2022 14:31:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D15C3411E;
        Mon,  4 Jul 2022 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656945064;
        bh=abX2vFyPPxtUJL8wR+WOgxjRHK6sRVK3yADC3+pFltw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=haqBElDu9pTENB2dVUV2nrZD5Uk0XFiKbqJc2LFiDC8sy+CbpiUEMZ43KKyPpqV1x
         wDKhunuPle1p/Hsmj8Zbs1/T1Pr9JwbUFBtP4g9uE3vIjIg2iH4FfgWs918wPTj54n
         AL0mouy/oyRePOLwILDmV2KyPST9gEVWWUnaPpuc=
Date:   Mon, 4 Jul 2022 16:31:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsL5pUuydMWJ9dSQ@kroah.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 09:34:04PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 20:01, Greg KH wrote:
> > On Mon, Jul 04, 2022 at 07:25:44PM +0900, Tetsuo Handa wrote:
> >> On 2022/07/04 16:29, Greg KH wrote:
> >>> On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
> >>>> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
> >>>> misc_open() might sleep for long with misc_mtx held whereas userspace can
> >>>> flood with concurrent misc_open() requests. Mitigate this problem by making
> >>>> misc_open() and misc_register() killable.
> >>>
> >>> I do not understand, why not just fix snapshot_open()?  Why add this
> >>> complexity to the misc core for a foolish individual misc device?  Why
> >>> not add the fix there where it is spinning instead?
> >>
> >> Quoting an example from [1]. Multiple processes are calling misc_open() and
> >> all but one processes are blocked at mutex_lock(&misc_mtx). The one which is
> >> not blocked at mutex_lock(&misc_mtx) is also holding system_transition_mutex.
> > 
> > And that is because of that one misc device, right?  Why not fix that
> > instead of papering over the issue in the misc core?
> 
> Since "struct file_operations"->open() is allowed to sleep, calling
> "struct file_operations"->open() via reassignment by "struct miscdevice"->fops
> with locks held can cause problems.
> 
> Assuming that this is not a deadlock hidden by device_initialize(), current
> mutex_lock(&misc_mtx) is as problematic as major_names_lock mentioned at
> https://lkml.kernel.org/r/b2af8a5b-3c1b-204e-7f56-bea0b15848d6@i-love.sakura.ne.jp .
> 
> >> If you don't like mutex_lock_killable(&misc_mtx), we will need to consider moving
> >> file->f_op->open() from misc_open() to after mutex_unlock(&misc_mtx).
> 
> Below is minimal changes for avoid calling "struct file_operations"->open() with
> misc_mtx held. This would be nothing but moving hung task warning from misc_open()
> to snapshot_open() (and therefore we would need to introduce killable version of
> lock_system_sleep()), but we can avoid making misc_mtx like major_names_lock above.
> 
> Greg, can you accept this minimal change?
> 
>  drivers/char/misc.c        | 4 ++++
>  include/linux/miscdevice.h | 1 +
>  kernel/power/user.c        | 1 +
>  3 files changed, 6 insertions(+)

I don't understand what you are trying to "fix" here.  What is userspace
doing (as a normal user) that is causing a problem, and what problem is
it causing and for what device/hardware/driver is this a problem?

Yes, you can sleep in open(), but you shouldn't sleep long, if at all
possible as it can be annoying.  So why not fix up the offending driver
not to sleep to long?

thanks,

greg k-h
