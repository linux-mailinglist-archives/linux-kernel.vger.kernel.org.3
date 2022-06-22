Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC18E555249
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359750AbiFVRYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344588AbiFVRY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:24:27 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B5824092
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655918666; x=1687454666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+T1Ha1FXIGuZiI7WiovZ/I2vnWbuysSEufGaNGb5xFw=;
  b=pokxT3lrHnUNDT8h5pTJ+SrgaSdCyoK8OczhWQA1cRYza5nOAj2JNfrn
   fvsevM8Xv0q5/uaS6JXy0dqTZY61S83Y5gkRqv4FfT3WSyvBpb7YkUkwi
   knH2RGn1nJFjPyWBOCR94DUT9RS1vhfrJT4j3KMwr4g2IXKj1rZeVq8EA
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2022 10:24:26 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 10:24:25 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 10:24:25 -0700
Received: from [10.111.161.199] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 10:24:23 -0700
Message-ID: <b133b67f-0d99-af6b-94a5-d5ff4b5752f1@quicinc.com>
Date:   Wed, 22 Jun 2022 10:24:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] drm/msm/dpu: Increment vsync_cnt before waking up
 userspace
Content-Language: en-US
To:     Stephen Boyd <swboyd@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>,
        Mark Yacoub <markyacoub@chromium.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>
References: <20220622023855.2970913-1-swboyd@chromium.org>
From:   Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20220622023855.2970913-1-swboyd@chromium.org>
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

This is right, we should increment before drm_crtc_handle_vblank() as 
that will query the vblank counter. This also matches what we do 
downstream, hence

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

One small nit though, shouldnt the fixes tag be

25fdd5933e4c ("drm/msm: Add SDM845 DPU support")

This code has been this way since that commit itself.

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
