Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8B4FEE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbiDMFb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbiDMFbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:31:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA338B3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649827773; x=1681363773;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=zHc/eSuSzLhEiicksQsx6yIGwYqTpOAuN15XI+c+tmU=;
  b=nZjn0Z2J8f3KzAkErDq8Rt1Lpv7LpWLwJbbk3KIY6Apvm2rNOs5wi0lI
   t23O7PQ+ysDdNhtALq15nNnAbI2BcvA2AXmz0tTwsfa6rLq+1HcbRFRF/
   e2ESm1abqFFFtwp65orbKx8ux7t7LBqfy8K4yachrQLZw3vFRHIjgZ1PY
   E=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Apr 2022 22:29:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 22:29:30 -0700
Received: from [10.110.69.201] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.47.97.222) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 12 Apr
 2022 22:29:27 -0700
Message-ID: <2e1f81e2-428c-f11f-ce92-eb11048cb271@quicinc.com>
Date:   Wed, 13 Apr 2022 10:59:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     <linux-kernel@vger.kernel.org>
CC:     <tglx@linutronix.de>, <sboyd@kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Possible race in dev_coredumpm()-del_timer() path
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
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

Hi All,

We are hitting one race due to which try_to_grab_pending() is stuck .
In following scenario, while running (p1)dev_coredumpm() devcd device is 
added to
the framework and uevent notification sent to userspace that result in 
the call to (p2) devcd_data_write()
which eventually try to delete the queued timer which in the racy 
scenario timer is not queued yet.
So, debug object report some warning and in the meantime timer is 
initialized and queued from p1 path.
and from p2 path it gets overriden again timer->entry.pprev=NULL and 
try_to_grab_pending() stuck
as del_timer() always return 0 as timer_pending() return false.

P1 P2(X)


      dev_coredumpm()

                                           Uevent notification sent to 
userspace
                                           for device addition

             device_add() ========================>                 
Process X reads this uevents
notification and do write call
that results in call to

devcd_data_write()
mod_delayed_work()
try_to_grab_pending()
del_timer()
debug_assert_init()

             INIT_DELAYED_WORK
                    (&devcd->del_wk, devcd_del);
             schedule_delayed_work(&devcd->del_wk,
                    DEVCD_TIMEOUT);

debug_object_fixup()
timer_fixup_assert_init()
timer_setup()
do_init_timer()   ==> reinitialized the timer to timer->entry.pprev=NULL

timer_pending()
!hlist_unhashed_lockless(&timer->entry)
!h->pprev



Thanks.
Mukesh

