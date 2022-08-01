Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA266586D71
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiHAPK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiHAPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:10:23 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491964C1;
        Mon,  1 Aug 2022 08:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659366623; x=1690902623;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a7fStmEkXQqjNzeaJ60mZgYwtUwEj9JVdHOtlh68THc=;
  b=RCL4muJ59/OoNG/KmwETe2YdwtxX5hrd7So1BxEcH/PV5MQ9CZFoMofD
   760dz6j5GL5pWHEqDbSZkUvrHOawCnr++o7rCaxxa1f+ZlaZhl+bGKYaT
   3yz02C0HUPIlE6WLCe3ysxMYKmo2KWrqjmi5UM5EdtXSXyP1v5r2g77tW
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Aug 2022 08:10:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 08:10:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 08:10:20 -0700
Received: from [10.216.14.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 08:10:13 -0700
Message-ID: <e18b057b-f5da-48a4-7086-9bc64d3819fb@quicinc.com>
Date:   Mon, 1 Aug 2022 20:40:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 4/8] drm/msm: Fix cx collapse issue during recovery
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
CC:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Jonathan Marek <jonathan@marek.ca>,
        "Douglas Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Chia-I Wu <olvaffe@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        <linux-kernel@vger.kernel.org>
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730150952.v3.4.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
 <CAF6AEGuqptUzOtcjG+oA4BQha3Jk-UzDK-8SF_8v5A+8Dg71uQ@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGuqptUzOtcjG+oA4BQha3Jk-UzDK-8SF_8v5A+8Dg71uQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/31/2022 9:52 PM, Rob Clark wrote:
> On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> There are some hardware logic under CX domain. For a successful
>> recovery, we should ensure cx headswitch collapses to ensure all the
>> stale states are cleard out. This is especially true to for a6xx family
>> where we can GMU co-processor.
>>
>> Currently, cx doesn't collapse due to a devlink between gpu and its
>> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
>> that the iommu driver removes its vote on cx gdsc.
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>> Changes in v3:
>> - Simplied the pm refcount drop since we have just a single refcount now
>> for all active submits
>>
>>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 24 +++++++++++++++++++++---
>>   drivers/gpu/drm/msm/msm_gpu.c         |  4 +---
>>   2 files changed, 22 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> index 42ed9a3..1b049c5 100644
>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
>> @@ -1193,7 +1193,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
>>   {
>>          struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
>>          struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
>> -       int i;
>> +       int i, active_submits;
>>
>>          adreno_dump_info(gpu);
>>
>> @@ -1210,8 +1210,26 @@ static void a6xx_recover(struct msm_gpu *gpu)
>>           */
>>          gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
>>
>> -       gpu->funcs->pm_suspend(gpu);
>> -       gpu->funcs->pm_resume(gpu);
>> +       pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
>> +
>> +       /* active_submit won't change until we make a submission */
>> +       mutex_lock(&gpu->active_lock);
>> +       active_submits = gpu->active_submits;
>> +       mutex_unlock(&gpu->active_lock);
>> +
>> +       /* Drop the rpm refcount from active submits */
>> +       if (active_submits)
>> +               pm_runtime_put(&gpu->pdev->dev);
> Couldn't this race with an incoming submit triggering active_submits
> to transition 0 -> 1?  Moving the mutex_unlock() would solve this.
>
> Actually, maybe just move the mutex_unlock() to the end of the entire
> sequence.  You could also clear gpu->active_submits and restore it
> before unlocking, so you can drop the removal of the WARN_ON_ONCE
> (patch 6/8) which should otherwise be squashed into this patch to keep
> things bisectable
Because we are holding gpu->lock, there won't be any new submissions to 
gpu. But I agree with your both suggestions.

-Akhil.
>
>> +
>> +       /* And the final one from recover worker */
>> +       pm_runtime_put_sync(&gpu->pdev->dev);
>> +
>> +       pm_runtime_use_autosuspend(&gpu->pdev->dev);
>> +
>> +       if (active_submits)
>> +               pm_runtime_get(&gpu->pdev->dev);
>> +
>> +       pm_runtime_get_sync(&gpu->pdev->dev);
>>
>>          msm_gpu_hw_init(gpu);
>>   }
>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>> index 1945efb..07e55a6 100644
>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>> @@ -426,9 +426,7 @@ static void recover_worker(struct kthread_work *work)
>>                  /* retire completed submits, plus the one that hung: */
>>                  retire_submits(gpu);
>>
>> -               pm_runtime_get_sync(&gpu->pdev->dev);
>>                  gpu->funcs->recover(gpu);
>> -               pm_runtime_put_sync(&gpu->pdev->dev);
> Hmm, could this have some fallout on earlier gens?
>
> I guess I should extend the igt msm_recovery test to run on things
> prior to a6xx..
>
> BR,
> -R
No, because of patch 3/8 in this series.

-Akhil.
>
>>                  /*
>>                   * Replay all remaining submits starting with highest priority
>> @@ -445,7 +443,7 @@ static void recover_worker(struct kthread_work *work)
>>                  }
>>          }
>>
>> -       pm_runtime_put_sync(&gpu->pdev->dev);
>> +       pm_runtime_put(&gpu->pdev->dev);
>>
>>          mutex_unlock(&gpu->lock);
>>
>> --
>> 2.7.4
>>

