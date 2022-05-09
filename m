Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B26520742
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiEIWAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiEIWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:00:19 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FE2B49;
        Mon,  9 May 2022 14:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652133382; x=1683669382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GwD4emTXef5p3pl41+VvL4mBFnWgmWVI8WShlGTsE8Y=;
  b=eTER/1pAJnWX411DSod6gjCO115mDKXAzwqqLu2nbvszOhRUols1v2RQ
   d0n72SOZQrIVi4ka4ZH4jFdY/efkNMLQ79PNwq3GjzcwzfeFv2pdLd9bk
   XcIzeywSG2mZBvNHlJqrUxBt+s1FyUMm4lz1oL5oe8ydX0wmfU5lZRt63
   w=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 May 2022 14:56:21 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 14:56:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 9 May 2022 14:56:21 -0700
Received: from [10.110.21.19] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 9 May 2022
 14:56:19 -0700
Message-ID: <0276a7f8-538f-a601-cdb5-46e3ad636e8f@quicinc.com>
Date:   Mon, 9 May 2022 14:56:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/msm/dp: Always clear mask bits to disable interrupts
 at dp_ctrl_reset_irq_ctrl()
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>, <agross@kernel.org>,
        <airlied@linux.ie>, <bjorn.andersson@linaro.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <vkoul@kernel.org>
CC:     <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1651873267-18220-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n52HvhT_RFbJHhijKCCt8jQM70fo6ceAbnYEfOfO-dRxVA@mail.gmail.com>
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <CAE-0n52HvhT_RFbJHhijKCCt8jQM70fo6ceAbnYEfOfO-dRxVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/6/2022 5:29 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2022-05-06 14:41:07)
>> dp_catalog_ctrl_reset() will software reset DP controller. But it will
>> not reset programmable registers to default value. DP driver still have
>> to clear mask bits to interrupt status registers to disable interrupts
>> after software reset of controller. This patch removes the enable flag
>> condition checking to always clear mask bits of interrupt status
>> registers to disable interrupts if enable flag is false.
> Another paragraph is needed which is that this (partially?) fixes the
> suspend path where we call dp_catalog_ctrl_reset() but the irq is still
> unmasked and can come in while we're suspending. This leads to bus hangs
> if the irq is handled after we power down the DP hardware because we run
> the irq handler and access a device register assuming that no irq could
> ever come in if we powered down the device. We don't know when the irq
> will be handled though, so it's possible the irq is pending from before
> we disable the irq in the hardware. Don't we need some irq synchronize
> to make sure it doesn't run?

Since irqs are converted into events and executed in event thread 
context, as long as no irq disabled then event q will be emptied 
accordingly.

Also, i think synchronize_irq() have higher risk of deadlocking if 
resources are hold by others.

>> Fixes: ba0a422be723 ("drm/msm/dp: do not initialize phy until plugin interrupt received")
>> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
>> ---
>>   drivers/gpu/drm/msm/dp/dp_ctrl.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> index 38026f2..cbf3399 100644
>> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
>> @@ -1379,8 +1379,13 @@ void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable)
>>
>>          dp_catalog_ctrl_reset(ctrl->catalog);
>>
>> -       if (enable)
>> -               dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>> +       /*
>> +        * all dp controller programmable registers will not
>> +        * be reset to default value after DP_SW_RESET
>> +        * therefore interrupt mask bits have to be updated
>> +        * to enable/disable interrupts
>> +        */
>> +       dp_catalog_ctrl_enable_irq(ctrl->catalog, enable);
>>   }
>>
>>   void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
