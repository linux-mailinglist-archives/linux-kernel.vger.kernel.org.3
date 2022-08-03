Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD35A5892E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbiHCTwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbiHCTwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:52:35 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A73206C;
        Wed,  3 Aug 2022 12:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659556352; x=1691092352;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kPJ0bv7qD5e3QqW3xXd4I/PtJrU1pHCZsHBtKoPlWvs=;
  b=tEUk2aNrZl6iVqoMvtc+5O9miFM/5DPDY1ecp6666psLC3N1Ur2n1C2X
   U5LpRosIlvgPYKw4Cfl/VFJyDSAinIl0zFPXEnB9CVfo+U+mk67NjLBbt
   AJxR2NAb8yvi/cG7b0H3lCCxBiMD1VJHaBjn7PN140SgfqhhBqLkTPKYd
   w=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Aug 2022 12:52:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 12:52:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 3 Aug 2022 12:52:30 -0700
Received: from [10.216.4.234] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 3 Aug 2022
 12:52:26 -0700
Message-ID: <c80d70b6-a7ad-5900-ea7a-f0f2157e4a40@quicinc.com>
Date:   Thu, 4 Aug 2022 01:22:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] drm/msm: Move hangcheck timer restart
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>, <dri-devel@lists.freedesktop.org>
CC:     <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
        "Rob Clark" <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
References: <20220803172302.1976981-1-robdclark@gmail.com>
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
In-Reply-To: <20220803172302.1976981-1-robdclark@gmail.com>
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

On 8/3/2022 10:53 PM, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Don't directly restart the hangcheck timer from the timer handler, but
> instead start it after the recover_worker replays remaining jobs.
> 
> If the kthread is blocked for other reasons, there is no point to
> immediately restart the timer.  Fixes a random symptom of the problem
> fixed in the next patch.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>   drivers/gpu/drm/msm/msm_gpu.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> index fba85f894314..8f9c48eabf7d 100644
> --- a/drivers/gpu/drm/msm/msm_gpu.c
> +++ b/drivers/gpu/drm/msm/msm_gpu.c
> @@ -328,6 +328,7 @@ find_submit(struct msm_ringbuffer *ring, uint32_t fence)
>   }
>   
>   static void retire_submits(struct msm_gpu *gpu);
> +static void hangcheck_timer_reset(struct msm_gpu *gpu);
>   
>   static void get_comm_cmdline(struct msm_gem_submit *submit, char **comm, char **cmd)
>   {
> @@ -420,6 +421,8 @@ static void recover_worker(struct kthread_work *work)
>   	}
>   
>   	if (msm_gpu_active(gpu)) {
> +		bool restart_hangcheck = false;
> +
>   		/* retire completed submits, plus the one that hung: */
>   		retire_submits(gpu);
>   
> @@ -436,10 +439,15 @@ static void recover_worker(struct kthread_work *work)
>   			unsigned long flags;
>   
>   			spin_lock_irqsave(&ring->submit_lock, flags);
> -			list_for_each_entry(submit, &ring->submits, node)
> +			list_for_each_entry(submit, &ring->submits, node) {
>   				gpu->funcs->submit(gpu, submit);
> +				restart_hangcheck = true;
> +			}
>   			spin_unlock_irqrestore(&ring->submit_lock, flags);
>   		}
> +
> +		if (restart_hangcheck)
> +			hangcheck_timer_reset(gpu);
>   	}
>   
>   	mutex_unlock(&gpu->lock);
> @@ -515,10 +523,6 @@ static void hangcheck_handler(struct timer_list *t)
>   		kthread_queue_work(gpu->worker, &gpu->recover_work);
>   	}
>   
> -	/* if still more pending work, reset the hangcheck timer: */
In the scenario mentioned here, shouldn't we restart the timer?

-Akhil.
> -	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
> -		hangcheck_timer_reset(gpu);
> -
>   	/* workaround for missing irq: */
>   	msm_gpu_retire(gpu);
>   }
> 

