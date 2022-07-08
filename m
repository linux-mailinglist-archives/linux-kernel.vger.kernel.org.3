Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C2F56BAF4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238368AbiGHNiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238180AbiGHNiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ABC2B263;
        Fri,  8 Jul 2022 06:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD5B9627C7;
        Fri,  8 Jul 2022 13:38:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDDDBC341C0;
        Fri,  8 Jul 2022 13:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657287491;
        bh=wK8QI0KUUCmliRxXY/niLWlbOMMhz5LkuejgEQenrck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JVqCQDj+8dtEox91DR71hKsaQLCPHqCNS01zsg2jz+W1Wop9LCEOtQ7NylzWY4QSS
         aZN2mWaSrTsj+BNqMmnmpJrtcCc0K9jmevFgFV1X8BcXDX+wL0fd+7/679Vo1CtbZE
         SE/2UC9C0ogyl2RWR4RAyjruluzzHKqjgHNAxDiQ=
Date:   Fri, 8 Jul 2022 15:37:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Oliver Neukum <oneukum@suse.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsgzHc54onQ1DeFc@kroah.com>
References: <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
 <YsRHwy6+5gask+KT@kroah.com>
 <064bbe2a-c18e-203e-9e01-b32fe9baa390@I-love.SAKURA.ne.jp>
 <7ddb25ff-60e5-75be-8080-2a7465cca68c@I-love.SAKURA.ne.jp>
 <YsUtBERm94k/iZTy@kroah.com>
 <a6d98824-56c8-6d92-bb1b-eb065b57cb81@I-love.SAKURA.ne.jp>
 <815866b5-842e-4829-5ed8-26a5f1e856a4@suse.com>
 <22c61a75-8140-c62d-ffe0-efd6e9fa38ee@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22c61a75-8140-c62d-ffe0-efd6e9fa38ee@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:06:38PM +0900, Tetsuo Handa wrote:
> Let's summarize current location:
> 
> (1) Greg wants me to fix snapshot_open() not to sleep for too long, instead of
>     making misc_open() killable.
> 
> (2) I found snapshot_open() calls wait_for_device_probe() which might sleep
>     long enough to consider as hung up due to:
> 
>       (a) One of existing probe request got stuck due to unresponsive hardware.
> 
>       (b) New probe requests come in before existing probe requests complete.
> 
> (3) Because of (2), it is difficult to guarantee snapshot_open() not to sleep for
>     too long.
> 
> (4) Because of (3), calling file->f_op->open(inode, file) with misc_mtx held can
>     block mutex_lock(&misc_mtx) too long. This is the phenomenon syzbot is reporting.
> 
> Initial mitigation was to replace mutex_lock(&misc_mtx) with mutex_lock_killable(&misc_mtx)
> so that /dev/raw-gadget users can terminate upon SIGKILL and khungtaskd will not complain
> about misc_mtx.
> 
> Next mitigation was not to call file->f_op->open() with misc_mtx held.
> Wedson worried that this approach breaks modules which call misc_deregister(), but
> I think we can use this approach for modules which do not need to call misc_deregister()
> given that this approach is opt-in basis.
> 
> I also think that we can bring wait_for_device_probe() in snapshot_open() to before
> lock_system_sleep(), for system_transition_mutex will not be required for waiting for
> the image device to appear. If we can accept the "not to call file->f_op->open() with
> misc_mtx held" mitigation, wait_for_device_probe() in snapshot_open() can be called
> without locks.
> 
> Finding universally safe timeout value is beyond what I can do for this report.
> Regarding this report, I think we can lower the risk of regression if we apply
> timeout for atomic_read(&probe_count) == 0 from only snapshot_open().
> Can we make below changes?
> 
> ------------------------------------------------------------
> 
>  drivers/base/dd.c             |   14 ++++++++++++++
>  drivers/char/misc.c           |    4 ++++
>  include/linux/device/driver.h |    1 +
>  include/linux/miscdevice.h    |    1 +
>  kernel/power/user.c           |   31 ++++++++++++++++++-------------
>  5 files changed, 38 insertions(+), 13 deletions(-)

Can you make this a patch series, it's hard to tease out what the
different things are attempting to do here :(

thanks,

greg k-h
