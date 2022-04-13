Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787CD4FEE83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiDMFg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiDMFgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:36:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5B5DF77
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:34:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C83FBB81EA0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 05:34:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95581C385A4;
        Wed, 13 Apr 2022 05:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649828069;
        bh=d+wLUw2ba/p2YOkNrxPyzCBK91oPFy1Toq6zF8gp/LA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HwyU+KrYtcI5jjTiAS+H3LfXovlQ5iBVkLI615x683N/J77LXLpIx9aVdxHrS21Wg
         DDOxrRHGWsCMjXHJdPHoxIQicq/fJ0Lzv8EVCVsryOdFXuy+/KubDn57FpITC/gm3E
         gJdCL6niUv+rH0dLkNKdkD5AD6eZZAa6RLYOgFBg=
Date:   Wed, 13 Apr 2022 07:34:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        johannes@sipsolutions.net, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
Message-ID: <YlZg4KkiAgODr45d@kroah.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:59:22AM +0530, Mukesh Ojha wrote:
> Hi All,
> 
> We are hitting one race due to which try_to_grab_pending() is stuck .

What kernel version are you using?

> In following scenario, while running (p1)dev_coredumpm() devcd device is
> added to
> the framework and uevent notification sent to userspace that result in the
> call to (p2) devcd_data_write()
> which eventually try to delete the queued timer which in the racy scenario
> timer is not queued yet.
> So, debug object report some warning and in the meantime timer is
> initialized and queued from p1 path.
> and from p2 path it gets overriden again timer->entry.pprev=NULL and
> try_to_grab_pending() stuck
> as del_timer() always return 0 as timer_pending() return false.
> 
> P1 P2(X)
> 
> 
>      dev_coredumpm()
> 
>                                           Uevent notification sent to
> userspace
>                                           for device addition
> 
>             device_add() ========================>                 Process X
> reads this uevents
> notification and do write call
> that results in call to
> 
> devcd_data_write()
> mod_delayed_work()
> try_to_grab_pending()
> del_timer()
> debug_assert_init()
> 
>             INIT_DELAYED_WORK
>                    (&devcd->del_wk, devcd_del);
>             schedule_delayed_work(&devcd->del_wk,
>                    DEVCD_TIMEOUT);
> 
> debug_object_fixup()
> timer_fixup_assert_init()
> timer_setup()
> do_init_timer()   ==> reinitialized the timer to timer->entry.pprev=NULL
> 
> timer_pending()
> !hlist_unhashed_lockless(&timer->entry)
> !h->pprev

The above is confusing and not able to be understood due to the
formatting mess.  Care to fix this up and resend?

thanks,

greg k-h
