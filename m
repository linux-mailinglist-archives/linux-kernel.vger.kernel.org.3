Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83261500C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242644AbiDNLXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiDNLX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:23:28 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E833F286D0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649935263; x=1681471263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d38j63s4NKVUGbWFU/XMKARqUYJTDW2iz9cTRfiEGlo=;
  b=o5yEG0UxY0J5SIOZYKFI7/Zy08HoyUK4rG2Z2nfCZXCMDaiv9Pz8Ckml
   b/Eo1ywNPNK/MWrrknI614rQj/q9MkKKPSHl0BKsoGXJOgAuFEJcHQZ7k
   lqAOuRfSXzqV036sZ3Osho40ioPSrULgcFKlQ9I5Z+2vtREhurM9KekIp
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Apr 2022 04:21:03 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 04:21:02 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 14 Apr 2022 04:20:59 -0700
Date:   Thu, 14 Apr 2022 16:50:55 +0530
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <sboyd@kernel.org>, <johannes@sipsolutions.net>,
        <rafael@kernel.org>
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
Message-ID: <20220414112055.GA14124@hu-mojha-hyd.qualcomm.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
 <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
 <Ylas6F75Y7O6R87U@kroah.com>
 <87pmlkdk6i.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87pmlkdk6i.ffs@tglx>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 12:38:13PM +0200, Thomas Gleixner wrote:
> On Wed, Apr 13 2022 at 12:58, Greg KH wrote:
> > On Wed, Apr 13, 2022 at 03:46:39PM +0530, Mukesh Ojha wrote:
> >> 	p1 					p2(X)
> >> 
> >>    dev_coredump() uevent sent to userspace
> >>    device_add()  =========================> userspace process X reads the uevents
> >>                                             writes to devcd fd which
> >>                                             results into writes to
> >> 
> >>                                             devcd_data_write()
> >> 					      mod_delayed_work()
> >>                                                 try_to_grab_pending()
> >> 						  del_timer()
> >> 						   debug_assert_init()
> >>   INIT_DELAYED_WORK 
> >>   schedule_delayed_work
> >> 						    debug_object_fixup()
> >
> > Why do you have object debugging enabled?  That's going to take a LONG
> > time, and will find bugs in your code.  Perhaps like this one?
> 
> It's not finding bugs in his code. It finds bug in the upstream
> dev_coredump code.
> 
> > And if you turn object debugging off, what happens?
> 
> The debugobject splat goes away, but the problem persists.
> 
>     device_add()        -> uevent
> 
> Preemption or concurrency:
> 
>     devcd_data_write()
>        mod_delayed_work(..., w, 0);      <- Uninitialized.
> 
> The dev_coredump code exposes the device before it is fully initialized
> and a write ending up in devcd_data_write() touches uninitialized work.
> 
> It does not help to move the initialization before device_add() as that
> creates another problem:
> 
>     INIT_DELAYED_WORK(w)
>     ...
>     device_add()        -> uevent
> 
> Preemption or concurrency:
> 
>     devcd_data_write()
>       mod_delayed_work(..., w, 0);      <- Schedules work immediately
> 
>     work_queue_runs()
>       devcd_del(w)
>         device_del()
>         put_device()                    <- Drops the last reference
> 
>     initialization continues...
>     
> So, yes this needs serialization of some sort.

Hi Thomas,

Thanks for understanding the problem.
Can the patch mentioned at below link helps with the first problem ?


https://lore.kernel.org/lkml/57a04278-0a60-cc7d-7ce8-a75c2befd568@quicinc.com/

> 
> Same problem vs. disabled_store().

you mean, while userspace is reading the data and suddenly disable_store() done from
sysfs.

-Mukesh
> 
> Thanks,
> 
>         tglx
