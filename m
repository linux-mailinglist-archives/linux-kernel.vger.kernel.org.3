Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA9F586CE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiHAOdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbiHAOcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:32:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8034A1EEF2;
        Mon,  1 Aug 2022 07:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659364374; x=1690900374;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NkCrMrpG7PAAemzFvj7zQriC7ibq+uDZy/7liQTcrfA=;
  b=FC+xKTQYetVUG3hqKkTZ/U4Kh450qG4wnHV4jcEuJLbcM2w+d/vo3JSP
   ETSBQXui4bE1hzXl2K6vCYWM6nWFVOeywk4hL7xdmsRd2nln5C4Ykqf8b
   sjhyPMkoTR9ZPKG7BCjtQIX7LyuzhDoILNM8a0AQnLvzacHoVaFAqV5Zt
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 01 Aug 2022 07:32:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 07:32:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 07:32:52 -0700
Received: from [10.216.14.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 1 Aug 2022
 07:32:46 -0700
Message-ID: <f9ab9c36-5ecd-a15d-57de-0ad999d575e4@quicinc.com>
Date:   Mon, 1 Aug 2022 20:02:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3 1/8] drm/msm: Remove unnecessary pm_runtime_get/put
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
 <20220730150952.v3.1.Icf1e8f0c9b3e7e9933c3b48c70477d0582f3243f@changeid>
 <CAF6AEGsOzd8wMbgpt7bGNdCspNoH4shQfTknwwdyVde8k4zcZw@mail.gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <CAF6AEGsOzd8wMbgpt7bGNdCspNoH4shQfTknwwdyVde8k4zcZw@mail.gmail.com>
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

On 7/31/2022 9:25 PM, Rob Clark wrote:
> On Sat, Jul 30, 2022 at 2:41 AM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
>> We already enable gpu power from msm_gpu_submit(), so avoid a duplicate
>> pm_runtime_get/put from msm_job_run().
>>
>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
>> ---
>>
>> (no changes since v1)
>>
>>   drivers/gpu/drm/msm/msm_ringbuffer.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.c b/drivers/gpu/drm/msm/msm_ringbuffer.c
>> index 56eecb4..cad4c35 100644
>> --- a/drivers/gpu/drm/msm/msm_ringbuffer.c
>> +++ b/drivers/gpu/drm/msm/msm_ringbuffer.c
>> @@ -29,8 +29,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>>                  msm_gem_unlock(obj);
>>          }
>>
>> -       pm_runtime_get_sync(&gpu->pdev->dev);
>> -
> This is removing a _get_sync() and simply relying on a _get() (async)
> in msm_gpu_submit().. that seems pretty likely to go badly?  I think
> it should probably replace the _get() in msm_gpu_submit() with
> _get_sync() (but also since this is changing position of
> resume/suspend vs active_lock, please make sure you test with lockdep
> enabled)
>
> BR,
> -R
As discussed in the other patch, this is correctly handled in 
msm_gpu_submit(). And from active_lock perspective, there is no change 
actually. GPU is ON by the time we touch active_lock in both cases.

-Akhil.
>>          /* TODO move submit path over to using a per-ring lock.. */
>>          mutex_lock(&gpu->lock);
>>
>> @@ -38,8 +36,6 @@ static struct dma_fence *msm_job_run(struct drm_sched_job *job)
>>
>>          mutex_unlock(&gpu->lock);
>>
>> -       pm_runtime_put(&gpu->pdev->dev);
>> -
>>          return dma_fence_get(submit->hw_fence);
>>   }
>>
>> --
>> 2.7.4
>>

