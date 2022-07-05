Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36125662D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiGEFhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiGEFh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:37:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEB913CFD;
        Mon,  4 Jul 2022 22:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BD691CE1A3C;
        Tue,  5 Jul 2022 05:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E86FC341C7;
        Tue,  5 Jul 2022 05:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656999444;
        bh=mvpa4gKzseUX82ww/tYk5JY4OCyIABqzLqgbEy8cqIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHhaEiDKMW7LBlP9x/Cw0CgekdwLm+FQNdCoiPVPg8333K7x/fm94BVs1aCHXot5J
         rIQh3fg3xCTs3FpXsT8muVTTdK4tFUGH1eUUAOqibQsWfFj89vXqrc64FJZVwSsEfB
         W+gONI6dDMT3wayLok7FhHmaKM0cq+BUjH6I4jKY=
Date:   Tue, 5 Jul 2022 07:37:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsPOEYU7ZqmpD8dw@kroah.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 02:21:17PM +0900, Tetsuo Handa wrote:
> On 2022/07/04 23:31, Greg KH wrote:
> > I don't understand what you are trying to "fix" here.  What is userspace
> > doing (as a normal user) that is causing a problem, and what problem is
> > it causing and for what device/hardware/driver is this a problem?
> 
> Currently the root cause is unknown.
> This might be another example of deadlock hidden by device_initialize().
> 
> We can see from https://syzkaller.appspot.com/text?tag=CrashReport&x=11feb7e0080000 that
> when khungtaskd reports that a process is blocked waiting for misc_mtx at misc_open(),
> there is a process which is holding system_transition_mutex from snapshot_open().

/dev/snapshot is not read/writable by anyone but root for obvious
reasons.

And perhaps it's something that syzbot shouldn't be fuzzing unless it
wants to take the system down easily :)

thanks,

greg k-h
