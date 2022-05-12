Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C9F5255BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 21:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358052AbiELTdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 15:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350504AbiELTde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 15:33:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341661627;
        Thu, 12 May 2022 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652384010; x=1683920010;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aF38eStTDqNFqz4Gx3c+CKSDyxaee9RhF1zN1sw4C8Q=;
  b=XF3rvfB7DkyN5pmkJuyIX51H2y8IKGCIfdZPKSpHIQKllAvq9mxZYnJ0
   JNxq0u8mGwsqEFHuje31PxpNWL+MRdehcwPiKAHbR/35eb8dDy009vnDq
   Pfy5R9DdwVEp43Jc58ei1pNPizAeE4s/ayg8jVnkihRTgKTcGtRGL1PQc
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 May 2022 12:33:29 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 12:33:29 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 12 May 2022 12:33:28 -0700
Received: from [10.110.33.222] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 12 May
 2022 12:33:27 -0700
Message-ID: <45b7c7fd-9e77-a0f8-022b-27e874f4b3f0@quicinc.com>
Date:   Thu, 12 May 2022 12:33:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v5] drm/msm/dp: Always clear mask bits to disable
 interrupts at dp_ctrl_reset_irq_ctrl()
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
CC:     <agross@kernel.org>, <airlied@linux.ie>,
        <bjorn.andersson@linaro.org>, <daniel@ffwll.ch>,
        <dianders@chromium.org>, <robdclark@gmail.com>, <sean@poorly.run>,
        <vkoul@kernel.org>, <quic_abhinavk@quicinc.com>,
        <quic_aravindh@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1652313768-16286-1-git-send-email-quic_khsieh@quicinc.com>
 <e5c16697-5919-bafa-4ec5-294c94d7a740@linaro.org>
 <CAE-0n53zHrczQAOWM5f_tafUVJxg7JU2NuC4sGcBZddwKr-dGA@mail.gmail.com>
 <CAA8EJppc9d+FjVzAX_KU2-akTc1vSmSHMeKr8dp2ynH2LLOyBQ@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAA8EJppc9d+FjVzAX_KU2-akTc1vSmSHMeKr8dp2ynH2LLOyBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/11/2022 6:03 PM, Dmitry Baryshkov wrote:
> On Thu, 12 May 2022 at 04:01, Stephen Boyd <swboyd@chromium.org> wrote:
>> Quoting Dmitry Baryshkov (2022-05-11 17:41:50)
>>> On 12/05/2022 03:02, Kuogee Hsieh wrote:
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> index af7a80c..f3e333e 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>>>> @@ -1389,8 +1389,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
>>>>
>>>>        dp_catalog_ctrl_reset(ctrl->catalog);
>>>>
>>>> -     if (enable)
>>>> -             dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>>>> +     /*
>>>> +      * all dp controller programmable registers will not
>>>> +      * be reset to default value after DP_SW_RESET
>>>> +      * therefore interrupt mask bits have to be updated
>>>> +      * to enable/disable interrupts
>>>> +      */
>>>> +     dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>>>>    }
>>>>
>>>>    void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> index c388323..79439b8 100644
>>>> --- a/drivers/gpu/drm/msm/dp/dp_display.c
>>>> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
>>>> @@ -98,6 +98,8 @@ struct dp_display_private {
>>>>        struct dp_ctrl    *ctrl;
>>>>        struct dp_debug   *debug;
>>>>
>>>> +     atomic_t suspended;
>>> I think it'd be better to protect it with event_lock rather than using
>>> atomics.
>> Agreed. I think the concern is that the event queue will have "stuff" in
>> it. If the event queue was all a threaded irq we could simply call
>> synchronize_irq() after disabling the irq bit in the DP hardware and
>> then we would know it is safe to power down the DP logic. Unfortunately
>> the event queue is a kthread so we can't do that and we have to rewrite
>> synchronize_irq() by checking that the event queue is empty and waiting
>> for it to empty out otherwise. It's not safe enough to simply do the
>> power operations underneath the event_lock because there's a queue in
>> the kthread that might be waiting to grab the event_lock to process.
> This sounds like a good reason to rewrite event_thread to use
> threaded_irq and/or workqueue.

I think we are facing two problems,

1) event q is not empty after suspend  (this scenario most likely will 
not happen since display is off already) -- anyway it should be  fixed 
by adding "suspended" flag checking

2) new events add after suspend  due to irq mask bits were not cleared 
(this scenario most likely the major culprit) -- this fixed by remove 
"enable" flag check at  dp_ctrl_reset_irq_ctrl().

I will have "suspended" flag protected by event_lock.


>
