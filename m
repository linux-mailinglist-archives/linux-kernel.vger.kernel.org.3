Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291A65552B1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377406AbiFVRn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377461AbiFVRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:43:36 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F7E2664
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655919815; x=1687455815;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b9SPsk3t0xbrveGWmLHcEXLujqBGzaDu8B9b4Vfmh8w=;
  b=KmedKUC3/ipcajH6Dtg66fbB/I1s1E37aHBFA++6SfrHDnXM8NBAE25S
   1WLITj2cIFkUowJ331ScNYvByLaYkB/FAw8wO22Hz4SFMvuowxjewZZ4B
   vfnLkHGyDWP6d8ZTOifNzZQs5XDhF/EuXNZ8njd+UMtD2guehYLGGzyab
   4=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 22 Jun 2022 10:43:35 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:43:34 -0700
Received: from [10.71.110.111] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 10:43:34 -0700
Message-ID: <cb4b9ffe-ef4c-3925-af69-2c8cd541ff06@quicinc.com>
Date:   Wed, 22 Jun 2022 10:43:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [Freedreno] [PATCH] drm/msm/dpu: Increment vsync_cnt before
 waking up userspace
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Sean Paul <sean@poorly.run>, Mark Yacoub <markyacoub@chromium.org>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <patches@lists.linux.dev>, <freedreno@lists.freedesktop.org>
References: <20220622023855.2970913-1-swboyd@chromium.org>
From:   Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20220622023855.2970913-1-swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/2022 7:38 PM, Stephen Boyd wrote:
> The 'vsync_cnt' is used to count the number of frames for a crtc.
> Unfortunately, we increment the count after waking up userspace via
> dpu_crtc_vblank_callback() calling drm_crtc_handle_vblank().
> drm_crtc_handle_vblank() wakes up userspace processes that have called
> drm_wait_vblank_ioctl(), and if that ioctl is expecting the count to
> increase it won't.
> 
> Increment the count before calling into the drm APIs so that we don't
> have to worry about ordering the increment with anything else in drm.
> This fixes a software video decode test that fails to see frame counts
> increase on Trogdor boards.
> 
> Cc: Mark Yacoub <markyacoub@chromium.org>
> Cc: Jessica Zhang <quic_jesszhan@quicinc.com>
> Fixes: 885455d6bf82 ("drm/msm: Change dpu_crtc_get_vblank_counter to use vsync count.")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Tested-by: Jessica Zhang <quic_jesszhan@quicinc.com> # Trogdor (sc7180)

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 3a462e327e0e..a1b8c4592943 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1251,12 +1251,13 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>   	DPU_ATRACE_BEGIN("encoder_vblank_callback");
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
>   
> +	atomic_inc(&phy_enc->vsync_cnt);
> +
>   	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
>   	if (dpu_enc->crtc)
>   		dpu_crtc_vblank_callback(dpu_enc->crtc);
>   	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
>   
> -	atomic_inc(&phy_enc->vsync_cnt);
>   	DPU_ATRACE_END("encoder_vblank_callback");
>   }
>   
> 
> base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
> -- 
> https://chromeos.dev
> 
