Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1047451758E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386578AbiEBRPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386537AbiEBRPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:15:36 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2EC6176
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:12:07 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w19so26314095lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 10:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=tfJfzW5D4/+mvV5ypqeVXDbthQVO2IvgikDBXjGyA60=;
        b=Jk1QN88CqvFdk0UuRuqURJ4UVhpx8OAxnd0T493cwxqjOVXjBnAeoL1MaFMAWTRShO
         dZ69nMzm3LLz5RUjb3A+97DsAxCv5FfIKrQtCD+1CGB0FUNIw5/8axd156kxWuRCeJAZ
         qyxq3e4bZo9MffWtnlr78MZyevS6X1fzaRemUL6vVl5nTs5Gk2ei10hH7srkUh+vhLGA
         YmqbDDOGu3AlNL7Besk0vVhmRFs2Bfg/pA/5v7itsUmoF+AIeMFjnzmVuDZTq/vYdR8K
         hfUwI06aYWpby8NTV7c+BS5wj+dBKJASQ4UK7G8Vsukj6jPKM2qko9QQ955jz4T32Yxs
         5LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tfJfzW5D4/+mvV5ypqeVXDbthQVO2IvgikDBXjGyA60=;
        b=tEMft9fboNowraTKIuOuDKcYiPiKyPN1BaZ1cBikzD+x3n6XAZWQsoJc12+ahv3Aza
         LvFgjL5g9h2IJyF8h9K/sf0+qwcHoMIWmsCch3MDQ1uEVtw+FQV2kNQqfxopEAMd9f+A
         liFr2/8TF2gQmf4jdyiBpAuOoUUjadWZEdVboO/UKRtKV8QtJJxf3wllr00EsLAYxeLV
         mRu3xubIB1u3AhwvHypTsBn11Za1At9sAUY+MwXDXXWii8ChQXz4DXkxyqOwk8c6MCIV
         fK2hSENjLHZJxuE/EMPOjI1n/dFwSaRQMF5SqhBjS4NFFt/OF9q+QiJXwvyq9Nl3EOqt
         AGzg==
X-Gm-Message-State: AOAM5302mxTncmMc6A8XG6H25ij1sNFFPO+w1kiG9NYEaSkBIgV9u1j3
        BuUXMivelJ9eF57W/3LDWmPy5w==
X-Google-Smtp-Source: ABdhPJxK9FbHHdv2wyG8oI74ITCgks3MnQGVEBJhOGVP3JLuuzGptrCfLdlnkkol35ZbWzze7LqIEQ==
X-Received: by 2002:a05:6512:448:b0:472:3c0e:cf7f with SMTP id y8-20020a056512044800b004723c0ecf7fmr9457323lfk.279.1651511525368;
        Mon, 02 May 2022 10:12:05 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id be40-20020a05651c172800b0024f3d1daec5sm1108268ljb.77.2022.05.02.10.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 10:12:05 -0700 (PDT)
Message-ID: <f9dbdfc1-117c-b713-7f1d-40de9726baa1@linaro.org>
Date:   Mon, 2 May 2022 20:12:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] drm/msm/disp/dpu1: avoid clearing hw interrupts if
 hw_intr is null during drm uninit
Content-Language: en-GB
To:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        dianders@chromium.org, swboyd@chromium.org,
        quic_kalyant@quicinc.com, quic_abhinavk@quicinc.com
References: <1651509846-4842-1-git-send-email-quic_vpolimer@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1651509846-4842-1-git-send-email-quic_vpolimer@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 19:44, Vinod Polimera wrote:
> If edp modeset init is failed due to panel being not ready and
> probe defers during drm bind, avoid clearing irqs and derefernce
> hw_intr when hw_intr is null.
> 
> BUG: Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> 
> Call trace:
>   dpu_core_irq_uninstall+0x50/0xb0
>   dpu_irq_uninstall+0x18/0x24
>   msm_drm_uninit+0xd8/0x16c
>   msm_drm_bind+0x580/0x5fc
>   try_to_bring_up_master+0x168/0x1c0
>   __component_add+0xb4/0x178
>   component_add+0x1c/0x28
>   dp_display_probe+0x38c/0x400
>   platform_probe+0xb0/0xd0
>   really_probe+0xcc/0x2c8
>   __driver_probe_device+0xbc/0xe8
>   driver_probe_device+0x48/0xf0
>   __device_attach_driver+0xa0/0xc8
>   bus_for_each_drv+0x8c/0xd8
>   __device_attach+0xc4/0x150
>   device_initial_probe+0x1c/0x28
> 
> Changes in V2:
> - Update commit message and coreect fixes tag.
> 
> Fixes: f25f656608e3 ("drm/msm/dpu: merge struct dpu_irq into struct dpu_hw_intr")
> Signed-off-by: Vinod Polimera <quic_vpolimer@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> index c515b7c..ab28577 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
> @@ -599,6 +599,9 @@ void dpu_core_irq_uninstall(struct dpu_kms *dpu_kms)
>   {
>   	int i;
>   
> +	if (!dpu_kms->hw_intr)
> +		return;
> +
>   	pm_runtime_get_sync(&dpu_kms->pdev->dev);
>   	for (i = 0; i < dpu_kms->hw_intr->total_irqs; i++)
>   		if (!list_empty(&dpu_kms->hw_intr->irq_cb_tbl[i]))


-- 
With best wishes
Dmitry
