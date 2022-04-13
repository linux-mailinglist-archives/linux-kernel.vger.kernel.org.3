Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716454FF488
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbiDMKTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiDMKTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:19:07 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436E84ECD6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649845007; x=1681381007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y9gnYaeAwpLAQx9B4FH7QDMsiGhCZyR1tmQrDyEyLLw=;
  b=gZlLkdur2A+ZA3+aTcFe52i5iHAZHf5uKUa4zkI1kHprlomxcZayF3iB
   bzw5AZne5PrFNaJMJ2Q/VO1zWYiQIcyhb8uYbmnrvAnhRP2kinM7a9jFt
   YcAw0bYnpdUE+WQTVv3eadflE/ir1odQ1lg3z3jBn08ttCLfTugQwUlBL
   c=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 03:16:46 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 03:16:46 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 13 Apr 2022 03:16:43 -0700
Date:   Wed, 13 Apr 2022 15:46:39 +0530
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <tglx@linutronix.de>,
        <sboyd@kernel.org>, <johannes@sipsolutions.net>,
        <rafael@kernel.org>
Subject: Re: Possible race in dev_coredumpm()-del_timer() path
Message-ID: <20220413101639.GA24349@hu-mojha-hyd.qualcomm.com>
References: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
 <YlZg4KkiAgODr45d@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YlZg4KkiAgODr45d@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On Wed, Apr 13, 2022 at 07:34:24AM +0200, Greg KH wrote:
> On Wed, Apr 13, 2022 at 10:59:22AM +0530, Mukesh Ojha wrote:
> > Hi All,
> > 
> > We are hitting one race due to which try_to_grab_pending() is stuck .
> 
> What kernel version are you using?

5.10

Sorry, for the formatting mess.

> > In following scenario, while running (p1)dev_coredumpm() devcd device is
> > added to
> > the framework and uevent notification sent to userspace that result in the
> > call to (p2) devcd_data_write()
> > which eventually try to delete the queued timer which in the racy scenario
> > timer is not queued yet.
> > So, debug object report some warning and in the meantime timer is
> > initialized and queued from p1 path.
> > and from p2 path it gets overriden again timer->entry.pprev=NULL and
> > try_to_grab_pending() stuck
	p1 					p2(X)

   dev_coredump() uevent sent to userspace
   device_add()  =========================> userspace process X reads the uevents
                                            writes to devcd fd which
                                            results into writes to

                                            devcd_data_write()
					      mod_delayed_work()
                                                try_to_grab_pending()
						  del_timer()
						   debug_assert_init()
  INIT_DELAYED_WORK 
  schedule_delayed_work
						    debug_object_fixup()
						      timer_fixup_assert_init()
							timer_setup()
							  do_init_timer()   ==> reinitialized the timer to timer->entry.pprev=NULL
							
					          timer_pending()
						  !hlist_unhashed_lockless(&timer->entry)
						  !h->pprev  ==> del_timer checks and finds to be NULL
								 stuck in try_to_grab_pending

Thanks,Mukesh
> 
> 
> > In following scenario, while running (p1)dev_coredumpm() devcd device is
> > added to
> > the framework and uevent notification sent to userspace that result in the
> > call to (p2) devcd_data_write()
> > which eventually try to delete the queued timer which in the racy scenario
> > timer is not queued yet.
> > So, debug object report some warning and in the meantime timer is
> > initialized and queued from p1 path.
> > and from p2 path it gets overriden again timer->entry.pprev=NULL and
> > try_to_grab_pending() stuck
> > as del_timer() always return 0 as timer_pending() return false.
> > 
> > P1 P2(X)
> > 
> > 
> >      dev_coredumpm()
> > 
> >                                           Uevent notification sent to
> > userspace
> >                                           for device addition
> > 
> >             device_add() ========================>                 Process X
> > reads this uevents
> > notification and do write call
> > that results in call to
> > 
> > devcd_data_write()
> > mod_delayed_work()
> > try_to_grab_pending()
> > del_timer()
> > debug_assert_init()
> > 
> >             INIT_DELAYED_WORK
> >                    (&devcd->del_wk, devcd_del);
> >             schedule_delayed_work(&devcd->del_wk,
> >                    DEVCD_TIMEOUT);
> > 
> > debug_object_fixup()
> > timer_fixup_assert_init()
> > timer_setup()
> > do_init_timer()   ==> reinitialized the timer to timer->entry.pprev=NULL
> > 
> > timer_pending()
> > !hlist_unhashed_lockless(&timer->entry)
> > !h->pprev
> 
> The above is confusing and not able to be understood due to the
> formatting mess.  Care to fix this up and resend?
> 
> thanks,
> 
> greg k-h
