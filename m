Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AC5670D4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGEOUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiGEOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E199FF8;
        Tue,  5 Jul 2022 07:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B5E961975;
        Tue,  5 Jul 2022 14:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448FDC341C7;
        Tue,  5 Jul 2022 14:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657030598;
        bh=KxRgDso37euMOKlGomCI79juLH2/Cs+Mjwd2v0X7HXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BpITVrTaEQ0TRB6FUw/PXNszTp7SaijtskEb/RN6eliN8yisPIRqprrh1BWfVuLEf
         JMWggip8/9rUDrmegj/uwsURwq2oAhSiZ32RTzRKEtL4n7am5x7RIvxrEU6yT023fV
         eWHXMWI89MBRFEFa0jg4IxDK/IqbNIUs3eMwPE6w=
Date:   Tue, 5 Jul 2022 16:16:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsRHwy6+5gask+KT@kroah.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
 <YsKW6VvWqvcMRBSl@kroah.com>
 <100f445e-9fa8-4f37-76aa-8359f0008c59@I-love.SAKURA.ne.jp>
 <YsLIepAXeBKT0AF/@kroah.com>
 <01a93294-e323-b9ca-7e95-a33d4b89dc47@I-love.SAKURA.ne.jp>
 <YsL5pUuydMWJ9dSQ@kroah.com>
 <617f64e3-74c8-f98b-3430-bd476867e483@I-love.SAKURA.ne.jp>
 <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5665ccb2-b92b-9e1f-8bb5-a950986450ec@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 11:01:38PM +0900, Tetsuo Handa wrote:
> On 2022/07/05 14:21, Tetsuo Handa wrote:
> > Possible locations where snapshot_open() might sleep with system_transition_mutex held are
> > pm_notifier_call_chain_robust()/wait_for_device_probe()/create_basic_memory_bitmaps().
> > But I think we can exclude pm_notifier_call_chain_robust() because lockdep does not report
> > that that process is holding "struct blocking_notifier_head"->rwsem. I suspect that
> > that process is sleeping at wait_for_device_probe(), for it waits for probe operations.
> > 
> > ----------------------------------------
> > void wait_for_device_probe(void)
> > {
> > 	/* wait for the deferred probe workqueue to finish */
> > 	flush_work(&deferred_probe_work);
> > 
> > 	/* wait for the known devices to complete their probing */
> > 	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
> > 	async_synchronize_full();
> > }
> > ----------------------------------------
> 
> syzbot confirmed that snapshot_open() is unable to proceed due to
> atomic_read(&probe_count) == 2 for 145 seconds.
> 
> ----------------------------------------
> [   86.794300][ T4209] Held system_transition_mutex.
> [   86.821486][ T4209] Calling wait_for_device_probe()
> [   86.841374][ T4209] Calling flush_work(&deferred_probe_work)
> [   86.867398][ T4209] Calling wait_event(probe_waitqueue)
> [   87.966188][ T4209] Calling probe_count=2
> (...snipped...)
> [  233.554473][ T4209] Calling probe_count=2
> [  234.444800][   T28] INFO: task syz-executor.4:4146 blocked for more than 143 seconds.
> ----------------------------------------
> 
> Apart from whether we should fuzz snapshot code or not,
> there seems to be a bug that causes wait_for_device_probe() to hung.

What else is going on in the system at this point in time?  Are devices
still being added as part of boot init sequences?  Or has boot finished
properly and these are devices being removed?

Some device is being probed at the moment, maybe we have a deadlock
somewhere here...

thanks,

greg k-h
