Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8A50E165
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 15:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238390AbiDYNUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 09:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiDYNU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 09:20:27 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C0F17E0A
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650892644; x=1682428644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qxGOqtPb2bys/C072ZjZKwxLwn9k6n0Y4ZESfIXyK4k=;
  b=v2C6RsB5rzSZByxe8ip/tgWeF3gZHxNATOHX6NUaQNJQQbjEgH/4T9Yh
   c/xJ4tdQzPHZB3zxmHh1/ahiQuNZGetOLuneZSbL5X2szEu2DegzEMXq7
   fmSXpCbVhz6TLoV5FN6VxZ6TZoSrb1KpGymVnxwau6OMeAk+w5RSpb92G
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Apr 2022 06:17:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 06:17:23 -0700
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 25 Apr 2022 06:17:21 -0700
Date:   Mon, 25 Apr 2022 18:47:17 +0530
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <johannes@sipsolutions.net>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] devcoredump : Serialize devcd_del work
Message-ID: <20220425131716.GA16363@hu-mojha-hyd.qualcomm.com>
References: <1650364077-22694-1-git-send-email-quic_mojha@quicinc.com>
 <2a14c4f64ff3e029a76c85d064146e6c303c96bb.camel@sipsolutions.net>
 <e59d076bc05ed319732ac3e234e423affae1cafe.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e59d076bc05ed319732ac3e234e423affae1cafe.camel@sipsolutions.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.47.97.222)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 03:53:35PM +0200, Johannes Berg wrote:
> On Fri, 2022-04-22 at 15:41 +0200, Johannes Berg wrote:
> > On Tue, 2022-04-19 at 15:57 +0530, Mukesh Ojha wrote:
> > > In following scenario(diagram), when one thread X running dev_coredumpm() adds devcd
> > > device to the framework which sends uevent notification to userspace
> > > and another thread Y reads this uevent and call to devcd_data_write()
> > > which eventually try to delete the queued timer that is not initialized/queued yet.
> > > 
> > > So, debug object reports some warning and in the meantime, timer is initialized
> > > and queued from X path. and from Y path, it gets reinitialized again and
> > > timer->entry.pprev=NULL and try_to_grab_pending() stucks.
> > > 
> > > To fix this, introduce mutex to serialize the behaviour.
> > > 
> > >  	cpu0(X)			                      cpu1(Y)
> > > 
> > >     dev_coredump() uevent sent to userspace
> > >     device_add()  =========================> userspace process Y reads the uevents
> > >                                              writes to devcd fd which
> > >                                              results into writes to
> > > 
> > >                                             devcd_data_write()
> > >                                               mod_delayed_work()
> > >                                                 try_to_grab_pending()
> > >                                                   del_timer()
> > >                                                     debug_assert_init()
> > >    INIT_DELAYED_WORK
> > >    schedule_delayed_work
> > > 
> > 
> > Wouldn't it be easier to simply schedule this before adding it to sysfs
> > and sending the uevent?
> > 
> 
> Hm. I think that would solve this problem, but not all of the problems
> here ...
> 
> Even with your change, I believe it's still racy wrt. disabled_store(),
> since that flushes the work but devcd_data_write() remains reachable
> (and might in fact be waiting for the mutex after your change), so I
> think we need an additional flag somewhere (in addition to the mutex) to
> serialize all of these things against each other.

Can we do something like this in v2

https://lore.kernel.org/lkml/1650892193-12888-1-git-send-email-quic_mojha@quicinc.com/

Thanks,
-Mukesh

> 
> johannes
