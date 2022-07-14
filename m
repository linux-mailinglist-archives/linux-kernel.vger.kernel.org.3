Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3B85740AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 02:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiGNA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 20:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGNA5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 20:57:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC521AD94;
        Wed, 13 Jul 2022 17:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657760257; x=1689296257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AyqFPxpKqHws1B6uYvn/9BGSTZiFdKuQSIxr0nM/4H0=;
  b=OZZskzHDFK78rn2agjF9CkGKgYXt5If9Wz41xn33L+vPBktj9r94eQxz
   4SwDzO2sTOrSIbc9y9GnL504f8OJhQnV0OUp7Tz4UFzOuAovpsswo12KW
   xtbae/cjUM8Zn00S/jAu24PMAJx+i0aMWh/7Mlig8Ok+Cb8iWYDo3oK81
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Jul 2022 17:57:37 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 17:57:36 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Jul
 2022 17:57:36 -0700
Date:   Wed, 13 Jul 2022 17:57:35 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Rajendra Nayak <quic_rjendra@quicinc.com>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "David Heidelberg" <david@ixit.cz>,
        Robert Marko <robimarko@gmail.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: Re: [PATCH 5/5] firmware: qcom: scm: Add wait-queue handling logic
Message-ID: <20220714005735.GA22183@quicinc.com>
References: <1656359076-13018-1-git-send-email-quic_gurus@quicinc.com>
 <1656359076-13018-6-git-send-email-quic_gurus@quicinc.com>
 <ec04538b-93e2-fa93-4043-c489a0f228e8@quicinc.com>
 <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ad5e875d-e5d7-3b6f-4915-98ba08df8c5d@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 01 2022 16:51, Rajendra Nayak wrote:
> 
> 
> On 7/1/2022 4:32 PM, Rajendra Nayak wrote:
> >
> >
> >On 6/28/2022 1:14 AM, Guru Das Srinagesh wrote:
> >>Add logic to handle QCOM_SCM_WAITQ_SLEEP or QCOM_SCM_WAITQ_WAKE return
> >>codes.
> >>
> >>Scenario 1: Requests made by 2 different VMs:
> >>
> >>   VM_1                     VM_2                            Firmware
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │      REQUEST_1         │                                 │
> >>     ├────────────────────────┼─────────────────────────────────┤
> >>     │                        │                                 │
> >>     │                        │                              ┌──┼──┐
> >>     │                        │                              │  │  │
> >>     │                        │     REQUEST_2                │  │  │
> >>     │                        ├──────────────────────────────┼──┤  │
> >>     │                        │                              │  │  │Resource
> >>     │                        │                              │  │  │is busy
> >>     │                        │       {WQ_SLEEP}             │  │  │
> >>     │                        │◄─────────────────────────────┼──┤  │
> >>     │                        │  wq_ctx, smc_call_ctx        │  │  │
> >>     │                        │                              └──┼──┘
> >>     │   REQUEST_1 COMPLETE   │                                 │
> >>     │◄───────────────────────┼─────────────────────────────────┤
> >>     │                        │                                 │
> >>     │                        │         IRQ                     │
> >>     │                        │◄─-------------------------------│
> >>     │                        │                                 │
> >>     │                        │      get_wq_ctx()               │
> >>     │                        ├────────────────────────────────►│
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │                        │◄────────────────────────────────┤
> >>     │                        │   wq_ctx, flags, and            │
> >>     │                        │        more_pending             │
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │                        │ wq_resume(smc_call_ctx)         │
> >>     │                        ├────────────────────────────────►│
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>     │                        │      REQUEST_2 COMPLETE         │
> >>     │                        │◄────────────────────────────────┤
> >>     │                        │                                 │
> >>     │                        │                                 │
> >>
> >>Scenario 2: Two Requests coming in from same VM:
> >>
> >>   VM_1                                                     Firmware
> >>     │                                                          │
> >>     │                                                          │
> >>     │                                                          │
> >>     │                                                          │
> >>     │      REQUEST_1                                           │
> >>     ├──────────────────────────────────────────────────────────┤
> >>     │                                                          │
> >>     │                                                     ┌────┼───┐
> >>     │                                                     │    │   │
> >>     │                                                     │    │   │
> >>     │                                                     │    │   │
> >>     │      REQUEST_2                                      │    │   │
> >>     ├─────────────────────────────────────────────────────┼───►│   │
> >>     │                                                     │    │   │Resource
> >>     │                                                     │    │   │is busy
> >>     │      {WQ_SLEEP}                                     │    │   │
> >>     │◄────────────────────────────────────────────────────┼────┤   │
> >>     │      wq_ctx, req2_smc_call_ctx                      │    │   │
> >>     │                                                     │    │   │
> >>     │                                                     └────┼───┘
> >>     │                                                          │
> >>     │      {WQ_WAKE}                                           │
> >>     │◄─────────────────────────────────────────────────────────┤
> >>     │      wq_ctx, req1_smc_call_ctx, flags                    │
> >
> >
> >This is perhaps the same thing I asked on the previous patch,
> >I am guessing {WQ_WAKE} is returned in respone to REQUEST_1?
> >How do you know in this case if REQUEST_1 was a success or failure?
> >
> 
> Ok looking at this some more, I think what we are saying is that the FW returns
> {WQ_WAKE} to REQUEST_1, we then call wq_wake_ack and the return of
> *that* will tell if REQUEST_1 was success or failure?
> Did I get it right?

Yes, that is correct. I should have added an explanatory note in the commit
message to this effect:


     │      {WQ_WAKE}                         <-- Return value  │
     │◄─────────────────────────────────────────────────────────┤
     │      wq_ctx, req1_smc_call_ctx, flags  <-- Its payload   │

What this means is that the WQ_WAKE is sent by the FW to VM1 (direction of
arrow is from right to left) and that the additional data packed as payload
indicate that it is meant for REQUEST_1 (`req1_smc_call_ctx`).

Hopefully this will help understand the diagram better.

Thank you.

Guru Das.
