Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD9B4DCFA2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiCQUrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiCQUrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:47:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACCA19D61A;
        Thu, 17 Mar 2022 13:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647549944; x=1679085944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hl8P+qRLRH8B9uYa1kVh8yuL9rMFyQViq9H9Yb65PJM=;
  b=vE5TOZz1Gk0i3j52GTzgvr0DXUksiyaTynqh4zMNIn2x7iUQqk8rjOvu
   dlcbNnSjNg5duqEApe10Ny1h5BosQa4ipCbxAFsxfcyTHBTcgT6YR9XES
   EwqDy6BZoNgc3plVpljsxsvkD2XZkFhbe8WP6fTJxifkP2YIc26LeaBBX
   k=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 17 Mar 2022 13:45:44 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:45:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 17 Mar 2022 13:45:42 -0700
Received: from [10.216.15.137] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 17 Mar
 2022 13:45:37 -0700
Message-ID: <3b066b63-c180-09c6-e39f-b408464b5bc1@quicinc.com>
Date:   Fri, 18 Mar 2022 02:15:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [Freedreno] [PATCH 3/3] drm/msm/gpu: Remove mutex from wait_event
 condition
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     Rob Clark <robdclark@chromium.org>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        <linux-arm-msm@vger.kernel.org>,
        "Vladimir Lypak" <vladimir.lypak@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220310234611.424743-1-robdclark@gmail.com>
 <20220310234611.424743-4-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220310234611.424743-4-robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/2022 5:16 AM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
>
> The mutex wasn't really protecting anything before.  Before the previous
> patch we could still be racing with the scheduler's kthread, as that is
> not necessarily frozen yet.  Now that we've parked the sched threads,
> the only race is with jobs retiring, and that is harmless, ie.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/adreno/adreno_device.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> index 0440a98988fc..661dfa7681fb 100644
> --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> @@ -607,15 +607,6 @@ static int adreno_runtime_resume(struct device *dev)
>   	return gpu->funcs->pm_resume(gpu);
>   }
>   
> -static int active_submits(struct msm_gpu *gpu)
> -{
> -	int active_submits;
> -	mutex_lock(&gpu->active_lock);
> -	active_submits = gpu->active_submits;
> -	mutex_unlock(&gpu->active_lock);
I assumed that this lock here was to ensure proper barriers while 
reading active_submits. Is that not required?

-Akhil.
> -	return active_submits;
> -}
> -
>   static int adreno_runtime_suspend(struct device *dev)
>   {
>   	struct msm_gpu *gpu = dev_to_gpu(dev);
> @@ -669,7 +660,7 @@ static int adreno_system_suspend(struct device *dev)
>   	suspend_scheduler(gpu);
>   
>   	remaining = wait_event_timeout(gpu->retire_event,
> -				       active_submits(gpu) == 0,
> +				       gpu->active_submits == 0,
>   				       msecs_to_jiffies(1000));
>   	if (remaining == 0) {
>   		dev_err(dev, "Timeout waiting for GPU to suspend\n");

