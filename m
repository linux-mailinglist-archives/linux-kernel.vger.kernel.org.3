Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6B15887AB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiHCHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHCHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:01:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32316A185
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:01:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s9so11974135ljs.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=6iA1iDDg2wT5L45f8xQzKm/33un6F5eze6/xZZLONzc=;
        b=LkvUnyrn95oArIe+LqyBPWpm1Tt2+ZtXN95srDZ5S+5JY8SHMNFCerf6bdm4APJdn6
         pkJKDqEuHtWTkYZikpsKLdLZMI3efKjCne42dk/2e8BoavLopWbtWPcWkepqIG+FNaVx
         PUeKEZEz+dUPctCW73YN2EegSF+mACNF2p8RL+wXldyT9iUEVHK6baWiqjsg2wk4kpo7
         ISKUm5jCmT9QM+8c0lca0bzNeZqvKaY95u3FVnNWawRL6ViswAhd2UDHVVMO3ILYeXip
         gWXQY9ROaAm7zs/4Rl0dspJ+EIFeUBrQewxwxcOAQquWoukUL+ok3egO167EgYiTnPDF
         OOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=6iA1iDDg2wT5L45f8xQzKm/33un6F5eze6/xZZLONzc=;
        b=sYMzs3hQa8NpSTO8U9zrIDE0aHc7Q6+jk/R5mx2ALM/zrUASjkeDJUyHjHRrgT41Oq
         RuK3EHCpsnvhslqhjRSizgYbaBWuP4U+Qce9MLv7feZGOKkAq9Hct+PkaY9/dwFt4VuJ
         BI16itahRHgm2bRRUAdIhvFgz0ScyWFBgPrc0kPBC5x5VPcc/i43BEuwsdxNWckh729M
         KXNfaZv4D7+9w9erbthXxg6RHhFP36JICX7GQ83HD/X/pxbaAxGcNd0MRylLE0nHXxga
         OKmGe5m2vzadjvS228r080y8BBbUsIwefl6FUChDrqN3xWu/FhrI5NfEH6lkgnkASCNx
         Wp0w==
X-Gm-Message-State: AJIora/4Bv7fz+xbqrI6GvyF3Wz3K6PY4FjfqanSLpAFKGXNDhmSKmlE
        +ghcviwmIHVRhINylpKw6FEipg==
X-Google-Smtp-Source: AGRyM1s5IdB0FWkmOIReBn0TOtbL6cM9VogND3jzcIcT1PiaxHFmSz63MP1zi2G7w0ZRDn/hAlW+kg==
X-Received: by 2002:a05:651c:1584:b0:25d:c6ad:6237 with SMTP id h4-20020a05651c158400b0025dc6ad6237mr7395214ljq.509.1659510075506;
        Wed, 03 Aug 2022 00:01:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f34-20020a0565123b2200b0048ad13756dcsm2118746lfv.223.2022.08.03.00.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:01:15 -0700 (PDT)
Message-ID: <6723fb49-4768-c40b-0d00-6be594adccf0@linaro.org>
Date:   Wed, 3 Aug 2022 10:01:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 1/6] drm/msm/dsi: Fix number of regulators for
 msm8996_dsi_cfg
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Archit Taneja <architt@codeaurora.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220802153434.v3.1.I1056ee3f77f71287f333279efe4c85f88d403f65@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 01:37, Douglas Anderson wrote:
> 3 regulators are specified listed but the number 2 is specified. Fix
> it.
> 
> Fixes: 3a3ff88a0fc1 ("drm/msm/dsi: Add 8x96 info in dsi_cfg")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - ("Fix number of regulators for msm8996_dsi_cfg") new for v2.
> 
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 2c23324a2296..02000a7b7a18 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -109,7 +109,7 @@ static const char * const dsi_8996_bus_clk_names[] = {
>   static const struct msm_dsi_config msm8996_dsi_cfg = {
>   	.io_offset = DSI_6G_REG_SHIFT,
>   	.reg_cfg = {
> -		.num = 2,
> +		.num = 3,
>   		.regs = {
>   			{"vdda", 18160, 1 },	/* 1.25 V */
>   			{"vcca", 17000, 32 },	/* 0.925 V */


-- 
With best wishes
Dmitry
