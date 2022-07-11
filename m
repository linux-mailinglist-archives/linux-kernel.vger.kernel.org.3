Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AA356FFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiGKLCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiGKLCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:02:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3AC83DF16
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:07:17 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e28so4264142lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=A+12PiH2LqD12N0givzbYnxs7pL3Ommy49WfEm1JYnE=;
        b=u4u2wM60nmFPaBP48IHMmOf4RAZVAMPW1ftGly4/jaB2DyJOofAeu95LMFy+PBaWgc
         EQgGhwi0FFG1df3Jdb2Lavml7SWfSsb5rbOZq0hJTf394fqrzbP8OOemUEFW00W833F6
         4XMDF4XUsxnr2AKX6clAEdoAbJ2XO0oJ9ym/+FWSgmgOGV26lhQ9tahA6EKFUuDxvXp1
         oxYfB1OOhcHPHDabMAW3zUNemaSUB3+QbGfM7OidbyoGNHu0z/H8BgYnccOPKBnv22oT
         4Hr+KXpvhvg5jBVjQP7WWps0dgWz1P+MH/X256VDdJAy/6a+NB1HBOwPiW4aeyw3BOo6
         KC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=A+12PiH2LqD12N0givzbYnxs7pL3Ommy49WfEm1JYnE=;
        b=5wH4E9Vozzrm+Xl8oLFwUK8QejyKUVdGlE8fZHLpTVfNXS3KXvm6a/YkF+kux0LoO7
         tnX5zGG6a96KbCfD4m6Li3FafzcfJ93qeZxo7FOocGRql1EfPA5Rx4GarTk9HMqWUvMU
         mdx0tiIjOqzefTlQOOaLA4lGI/DIdDNYZQHTzYbsDSnSDZgJiX4C/E7erBXOx9qp0+ZV
         2ixLkn4mf5b5kGIBFYBICC39oRVax/1tC2ggO4ejgkcPhqxTfxgYontcnZ+Ke4RO4DAQ
         E+G5k8y7GvUyIK8SnPxAfAkM6ibnhNJd5K61cjxpYR4c+JN31+ggEGEpO9D7Y3x7muu2
         o2VA==
X-Gm-Message-State: AJIora9CewoFzTTxdMCaX/PcPM/npa5u0SSMT8YhQno+LxBdZxmiEil0
        1crqq87mLTZaelETGTdRHG4Vew==
X-Google-Smtp-Source: AGRyM1tk4TMiXWJl6aRFHyOzmk4vE4/OL/FVkCrUJAh1h7Q05lZHaEHkJKgxW1odUY9+DupbYyWUWQ==
X-Received: by 2002:a05:6512:b0d:b0:481:5cb4:cf1e with SMTP id w13-20020a0565120b0d00b004815cb4cf1emr10827054lfu.442.1657534036167;
        Mon, 11 Jul 2022 03:07:16 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b9-20020a056512070900b00489b1876923sm1446922lfs.298.2022.07.11.03.07.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 03:07:15 -0700 (PDT)
Message-ID: <77b0daf0-1467-b663-05e4-13130826c32e@linaro.org>
Date:   Mon, 11 Jul 2022 13:07:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v5 01/10] drm/msm/disp/dpu1: clear dpu_assign_crtc and get
 crtc from connector state instead of dpu_enc
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_khsieh@quicinc.com,
        quic_vproddut@quicinc.com, bjorn.andersson@linaro.org,
        quic_aravindh@quicinc.com, quic_abhinavk@quicinc.com,
        quic_sbillaka@quicinc.com
References: <1657532880-12897-1-git-send-email-quic_vpolimer@quicinc.com>
 <1657532880-12897-2-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1657532880-12897-2-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 12:47, Vinod Polimera wrote:
> Update crtc retrieval from dpu_enc to dpu_enc connector state,
> since new links get set as part of the dpu enc virt mode set.
> The dpu_enc->crtc cache is no more needed, hence cleaning it as
> part of this change.
> 
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c    |  4 ----
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 29 ++++++++++++++---------------
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h |  8 --------
>   3 files changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> index b56f777..f91e3d1 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
> @@ -972,7 +972,6 @@ static void dpu_crtc_disable(struct drm_crtc *crtc,
>   		 */
>   		if (dpu_encoder_get_intf_mode(encoder) == INTF_MODE_VIDEO)
>   			release_bandwidth = true;
> -		dpu_encoder_assign_crtc(encoder, NULL);
>   	}
>   
>   	/* wait for frame_event_done completion */
> @@ -1042,9 +1041,6 @@ static void dpu_crtc_enable(struct drm_crtc *crtc,
>   	trace_dpu_crtc_enable(DRMID(crtc), true, dpu_crtc);
>   	dpu_crtc->enabled = true;
>   
> -	drm_for_each_encoder_mask(encoder, crtc->dev, crtc->state->encoder_mask)
> -		dpu_encoder_assign_crtc(encoder, crtc);
> -
>   	/* Enable/restore vblank irq handling */
>   	drm_crtc_vblank_on(crtc);
>   }
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> index 52516eb..8fb3e15 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
> @@ -1245,6 +1245,7 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>   		struct dpu_encoder_phys *phy_enc)
>   {
>   	struct dpu_encoder_virt *dpu_enc = NULL;
> +	struct drm_crtc *crtc;
>   	unsigned long lock_flags;
>   
>   	if (!drm_enc || !phy_enc)
> @@ -1253,9 +1254,14 @@ static void dpu_encoder_vblank_callback(struct drm_encoder *drm_enc,
>   	DPU_ATRACE_BEGIN("encoder_vblank_callback");
>   	dpu_enc = to_dpu_encoder_virt(drm_enc);
>   
> +	if (!dpu_enc->connector || !dpu_enc->connector->state)
> +		return;
> +
> +	crtc = dpu_enc->connector->state->crtc;
> +
>   	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	if (dpu_enc->crtc)
> -		dpu_crtc_vblank_callback(dpu_enc->crtc);
> +	if (crtc)
> +		dpu_crtc_vblank_callback(crtc);
>   	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
>   
>   	atomic_inc(&phy_enc->vsync_cnt);
> @@ -1280,29 +1286,22 @@ static void dpu_encoder_underrun_callback(struct drm_encoder *drm_enc,
>   	DPU_ATRACE_END("encoder_underrun_callback");
>   }
>   
> -void dpu_encoder_assign_crtc(struct drm_encoder *drm_enc, struct drm_crtc *crtc)
> -{
> -	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> -	unsigned long lock_flags;
> -
> -	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	/* crtc should always be cleared before re-assigning */
> -	WARN_ON(crtc && dpu_enc->crtc);
> -	dpu_enc->crtc = crtc;
> -	spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
> -}

Please also remove the dpu_encoder_virt::crtc pointer.

> -
>   void dpu_encoder_toggle_vblank_for_crtc(struct drm_encoder *drm_enc,
>   					struct drm_crtc *crtc, bool enable)
>   {
>   	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
> +	struct drm_crtc *new_crtc;
>   	unsigned long lock_flags;
>   	int i;
>   
>   	trace_dpu_enc_vblank_cb(DRMID(drm_enc), enable);
>   
> +	if (!dpu_enc->connector || !dpu_enc->connector->state)
> +		return;
> +
> +	new_crtc = dpu_enc->connector->state->crtc;
>   	spin_lock_irqsave(&dpu_enc->enc_spinlock, lock_flags);
> -	if (dpu_enc->crtc != crtc) {
> +	if (!new_crtc || crtc != crtc) {

Second condition is always false.

>   		spin_unlock_irqrestore(&dpu_enc->enc_spinlock, lock_flags);
>   		return;
>   	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> index 781d41c..edba815 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h
> @@ -39,14 +39,6 @@ struct msm_display_info {
>   };
>   
>   /**
> - * dpu_encoder_assign_crtc - Link the encoder to the crtc it's assigned to
> - * @encoder:	encoder pointer
> - * @crtc:	crtc pointer
> - */
> -void dpu_encoder_assign_crtc(struct drm_encoder *encoder,
> -			     struct drm_crtc *crtc);
> -
> -/**
>    * dpu_encoder_toggle_vblank_for_crtc - Toggles vblank interrupts on or off if
>    *	the encoder is assigned to the given crtc
>    * @encoder:	encoder pointer


-- 
With best wishes
Dmitry
