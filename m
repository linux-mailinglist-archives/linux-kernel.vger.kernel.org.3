Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662F64FF551
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiDMLBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiDMLBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:01:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75D15A5A3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:58:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 607FB61D99
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46CC3C385A4;
        Wed, 13 Apr 2022 10:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649847530;
        bh=Fn2dIzbxRTOR59SCxwfCQFPbgzjMcMEZHJv5ka9IDKI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rcSltkzFLmv9wVcwWTMcvoJ+KLPwiW0Bcgm0BWhS8fa2A3pqy4y1p9dnA6xVYBa05
         Vjz4foWMzaRAD0/ZS9LNsHr7gpT8gdxph4RQY6fyl1TO2oC/kRsalYogUzWxwrEuTf
         P4s2u8JOgGGOBd3NDDNund6B1DJdMmTlFr13Ca+U=
Date:   Wed, 13 Apr 2022 12:58:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, sboyd@kernel.org,
        johannes@sipsolutions.net, rafael@kernel.org
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
Message-ID: <Ylas6F75Y7O6R87U@kroah.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
 <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:46:39PM +0530, Mukesh Ojha wrote:
> On Wed, Apr 13, 2022 at 07:34:24AM +0200, Greg KH wrote:
> > On Wed, Apr 13, 2022 at 10:59:22AM +0530, Mukesh Ojha wrote:
> > > Hi All,
> > > 
> > > We are hitting one race due to which try_to_grab_pending() is stuck .
> > 
> > What kernel version are you using?
> 
> 5.10

5.10.0 was released a very long time ago.  Please use a more modern
kernel release :)

> Sorry, for the formatting mess.
> 
> > > In following scenario, while running (p1)dev_coredumpm() devcd device is
> > > added to
> > > the framework and uevent notification sent to userspace that result in the
> > > call to (p2) devcd_data_write()
> > > which eventually try to delete the queued timer which in the racy scenario
> > > timer is not queued yet.
> > > So, debug object report some warning and in the meantime timer is
> > > initialized and queued from p1 path.
> > > and from p2 path it gets overriden again timer->entry.pprev=NULL and
> > > try_to_grab_pending() stuck
> 	p1 					p2(X)
> 
>    dev_coredump() uevent sent to userspace
>    device_add()  =========================> userspace process X reads the uevents
>                                             writes to devcd fd which
>                                             results into writes to
> 
>                                             devcd_data_write()
> 					      mod_delayed_work()
>                                                 try_to_grab_pending()
> 						  del_timer()
> 						   debug_assert_init()
>   INIT_DELAYED_WORK 
>   schedule_delayed_work
> 						    debug_object_fixup()

Why do you have object debugging enabled?  That's going to take a LONG
time, and will find bugs in your code.  Perhaps like this one?

What type of device is this?  What bus?  What driver?

And if you turn object debugging off, what happens?

thanks,

greg k-h
