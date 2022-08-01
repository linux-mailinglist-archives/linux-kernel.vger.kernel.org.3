Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1826586CF2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiHAOgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbiHAOgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:36:37 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070D33206B;
        Mon,  1 Aug 2022 07:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659364596; x=1690900596;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Z1q6yWbe6ZKJFIdTiO5T8PBqxZ1ZPjO7H90GXR9+67U=;
  b=LRpWrRheL3eiemN78HAwiOQSpAY+kGDEzNPodqCdoNCoX1WgxVh6d7h4
   nwgXCZrTfSTRZvbPX+bmxO3qcDOj2RtFbZM3KHLyna1980JVLyaIncbZa
   9hlIJjgu0u7Qa81RFgweHnpNQMzCpK0LBqGnZHfVkSd5S9OY4SKp9JsLj
   g=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 07:36:36 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 07:36:35 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 07:36:05 -0700
Received: from [10.216.14.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 07:35:58 -0700
Message-ID: <f08be233-77ae-f645-df88-d264f2336725@quicinc.com>
Date:   Mon, 1 Aug 2022 20:05:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 2/8] drm/msm: Take single rpm refcount on behalf of all
 submits
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
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, <linux-kernel@vger.kernel.org>
References: <1659174051-27816-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730150952.v3.2.Ifee853f6d8217a0fdacc459092bbc9e81a8a7ac7@changeid>
 <CAF6AEGs7zKDoRY=ijxFQvaZig=UiSPgWkJFA-PY2MTxKWr5bpw@mail.gmail.com>
 <d7f95663-c0f7-8227-dbc0-fac43bdf6faa@quicinc.com>
 <CAF6AEGt5H=T_0HOLrNqRHZOYNicfk74bgZrQH56k2bYpi5JsRA@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGt5H=T_0HOLrNqRHZOYNicfk74bgZrQH56k2bYpi5JsRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2022 3:45 AM, Rob Clark wrote:
> On Sun, Jul 31, 2022 at 9:33 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> On 7/31/2022 9:26 PM, Rob Clark wrote:
>>> On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>>>> Instead of separate refcount for each submit, take single rpm refcount
>>>> on behalf of all the submits. This makes it easier to drop the rpm
>>>> refcount during recovery in an upcoming patch.
>>>>
>>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>>>> ---
>>>>
>>>> (no changes since v1)
>>> I see no earlier version of this patch?
My bad, that is incorrect. This is a new patch included in the current 
series.

-Akhil.
>>>
>>>>    drivers/gpu/drm/msm/msm_gpu.c | 12 ++++++++----
>>>>    1 file changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
>>>> index c8cd9bf..e1dd3cc 100644
>>>> --- a/drivers/gpu/drm/msm/msm_gpu.c
>>>> +++ b/drivers/gpu/drm/msm/msm_gpu.c
>>>> @@ -663,11 +663,12 @@ static void retire_submit(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>>>>           mutex_lock(&gpu->active_lock);
>>>>           gpu->active_submits--;
>>>>           WARN_ON(gpu->active_submits < 0);
>>>> -       if (!gpu->active_submits)
>>>> +       if (!gpu->active_submits) {
>>>>                   msm_devfreq_idle(gpu);
>>>> -       mutex_unlock(&gpu->active_lock);
>>>> +               pm_runtime_put_autosuspend(&gpu->pdev->dev);
>>>> +       }
>>>>
>>>> -       pm_runtime_put_autosuspend(&gpu->pdev->dev);
>>>> +       mutex_unlock(&gpu->active_lock);
>>>>
>>>>           msm_gem_submit_put(submit);
>>>>    }
>>>> @@ -756,14 +757,17 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
>>>>
>>>>           /* Update devfreq on transition from idle->active: */
>>>>           mutex_lock(&gpu->active_lock);
>>>> -       if (!gpu->active_submits)
>>>> +       if (!gpu->active_submits) {
>>>> +               pm_runtime_get(&gpu->pdev->dev);
>>>>                   msm_devfreq_active(gpu);
>>>> +       }
>>>>           gpu->active_submits++;
>>>>           mutex_unlock(&gpu->active_lock);
>>>>
>>>>           gpu->funcs->submit(gpu, submit);
>>>>           gpu->cur_ctx_seqno = submit->queue->ctx->seqno;
>>>>
>>>> +       pm_runtime_put(&gpu->pdev->dev);
>>> this looks unbalanced?
>> There is another pm_runtime_get_sync at the top of this function. Just
>> before hw_init().
>> https://elixir.bootlin.com/linux/v5.19-rc8/source/drivers/gpu/drm/msm/msm_gpu.c#L737
> oh, right.. sorry, I was looking at my local stack of WIP patches
> which went the opposite direction and moved the runpm into just
> msm_job_run().. I'll drop that one
>
> BR,
> -R
>
>> -Akhil.
>>> BR,
>>> -R
>>>
>>>>           hangcheck_timer_reset(gpu);
>>>>    }
>>>>
>>>> --
>>>> 2.7.4
>>>>

