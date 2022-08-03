Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F68588A39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 12:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235622AbiHCKQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 06:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237852AbiHCKQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 06:16:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5AF06;
        Wed,  3 Aug 2022 03:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659521750; x=1691057750;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gKBgXLRR0hWOgoc86Un+U/06R5IbHRPejFWIKcL61Zo=;
  b=LyhjQloktr2LJzoP71iu10gGRBZkSY4ob9/V22izbfkd0IzYEYVycDvW
   JA3+zW9fWs4Tj7G+8Iefex3xDV0bV43aFem1rG66wMLkBOYbFCVd6aHfw
   hGXSLOl/+EJlsmu1A4STf2qXmgb2WcOdHKFbpMF89O/GCphpdAjjItmNc
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Aug 2022 03:15:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 03:15:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 03:15:49 -0700
Received: from [10.216.24.92] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 03:15:44 -0700
Message-ID: <0a81938b-f30e-fa78-fd73-c753af4e324b@quicinc.com>
Date:   Wed, 3 Aug 2022 15:45:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 5/8] drm/msm/a6xx: Ensure CX collapse during gpu
 recovery
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>
CC:     Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        Douglas Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730150952.v3.5.I176567525af2b9439a7e485d0ca130528666a55c@changeid>
 <8715e07f-9d58-1ae3-9a3a-25828b545905@linaro.org>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <8715e07f-9d58-1ae3-9a3a-25828b545905@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/2022 12:44 PM, Dmitry Baryshkov wrote:
> On 30/07/2022 12:40, Akhil P Oommen wrote:
>> Because there could be transient votes from other drivers/tz/hyp which
>> may keep the cx gdsc enabled, we should poll until cx gdsc collapses.
>> We can use the reset framework to poll for cx gdsc collapse from gpucc
>> clk driver.
>>
>> This feature requires support from the platform's gpucc driver.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>> Changes in v3:
>> - Use reset interface from gpucc driver to poll for cx gdsc collapse
>>    https://patchwork.freedesktop.org/series/106860/
>>
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 4 ++++
>>   drivers/gpu/drm/msm/msm_gpu.c         | 4 ++++
>>   drivers/gpu/drm/msm/msm_gpu.h         | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c 
>> b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 1b049c5..721d5e6 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -10,6 +10,7 @@
>>     #include <linux/bitfield.h>
>>   #include <linux/devfreq.h>
>> +#include <linux/reset.h>
>>   #include <linux/soc/qcom/llcc-qcom.h>
>>     #define GPU_PAS_ID 13
>> @@ -1224,6 +1225,9 @@ static void a6xx_recover(struct msm_gpu *gpu)
>>       /* And the final one from recover worker */
>>       pm_runtime_put_sync(&gpu->pdev->dev);
>>   +    /* Call into gpucc driver to poll for cx gdsc collapse */
>> +    reset_control_reset(gpu->cx_collapse);
>
> Do we have a race between the last pm_runtime_put_sync(), this polling 
> and other voters removing their votes beforehand?
I can't see any issue with a race here. reset_control_reset() will 
return immediately in that case.

-Akhil.
>
>> +
>>       pm_runtime_use_autosuspend(&gpu->pdev->dev);
>>         if (active_submits)
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c 
>> b/drivers/gpu/drm/msm/msm_gpu.c
>> index 07e55a6..4a57627 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -14,6 +14,7 @@
>>   #include <generated/utsrelease.h>
>>   #include <linux/string_helpers.h>
>>   #include <linux/devcoredump.h>
>> +#include <linux/reset.h>
>>   #include <linux/sched/task.h>
>>     /*
>> @@ -903,6 +904,9 @@ int msm_gpu_init(struct drm_device *drm, struct 
>> platform_device *pdev,
>>       if (IS_ERR(gpu->gpu_cx))
>>           gpu->gpu_cx = NULL;
>>   +    gpu->cx_collapse = devm_reset_control_get_optional(&pdev->dev,
>> +            "cx_collapse");
>> +
>>       gpu->pdev = pdev;
>>       platform_set_drvdata(pdev, &gpu->adreno_smmu);
>>   diff --git a/drivers/gpu/drm/msm/msm_gpu.h 
>> b/drivers/gpu/drm/msm/msm_gpu.h
>> index 6def008..ab59fd2 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.h
>> +++ b/drivers/gpu/drm/msm/msm_gpu.h
>> @@ -13,6 +13,7 @@
>>   #include <linux/interconnect.h>
>>   #include <linux/pm_opp.h>
>>   #include <linux/regulator/consumer.h>
>> +#include <linux/reset.h>
>>     #include "msm_drv.h"
>>   #include "msm_fence.h"
>> @@ -268,6 +269,9 @@ struct msm_gpu {
>>       bool hw_apriv;
>>         struct thermal_cooling_device *cooling;
>> +
>> +    /* To poll for cx gdsc collapse during gpu recovery */
>> +    struct reset_control *cx_collapse;
>>   };
>>     static inline struct msm_gpu *dev_to_gpu(struct device *dev)
>
>

