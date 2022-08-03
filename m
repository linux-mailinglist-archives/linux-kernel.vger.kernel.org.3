Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9B35887B0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbiHCHCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiHCHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:02:39 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D1639B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:02:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id z4so3297851ljn.8
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 00:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ERBLD//5Rxus/cD9VPLqlwRlILuoKA5rTudtuRc8t+k=;
        b=fgmIvjvkdynK95/GPR1fzwSA1Q6P3h4BOHxxY08oHzP0oUcHLOorxwuK6+q/6dPfCq
         vEqE/vIOU5yX6CaOAQz3pbm8AVR4cwULgb2bqwP4C7aksbdDI27wQ/7dm6Y0RsbPaOR5
         2MFfhcK2dxkX9STfoHVK+5bzOXlqdqmeuaVGt8iCgW0CwXmcdyMtNjyx0U6dPyAsJi49
         7UHSM5Ly0iWY/P7uEFQTM3LLKUW2ozvIPCzbUqrzGu3EokqLgroqZ+nzA68Y9RCxsLVQ
         RHcDjW30zXL5ABQAQduDFgcOqoBxkKG8oaiyPxOp5vnDi6hBAZCd8HaLxq/Rd+ZFRTPv
         53uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ERBLD//5Rxus/cD9VPLqlwRlILuoKA5rTudtuRc8t+k=;
        b=r/CcQLyog5nrPp9JL8bjX0dq/61XHwFGAV5rNstrsjcblzq8r8qqyquQ6a+n0ME3gQ
         hutJmNE3ejGVGbu2CBJErYRrl04tySPSyf4sqo27lWuwTx1dUJOT4X5dUPjHNyp8r0A+
         F6UzXgaxYv7Zd8nS3qvbF1dow0uXFkl89r1XvgSZ6hu88SErZA4zjkpLtGPvPJj0sBbP
         6qcypdc1sRaIvIkUNe2J0hNIKf/GyrC5gZ7qQTl7zPvt7GPtc923cElZ3L7K0JXNZekX
         V8qnudk5YQkpFOjM1bd4u+2jgujlD2856FBCOPJQI3cf1hiUrpA7UxCkJLI1cAB/2ycZ
         tcaw==
X-Gm-Message-State: ACgBeo27Tex8vxvL7oAHkxroBakAS3q9ngaKibkWfTmhI+gRypasf3Gm
        BoTA57LxSs9mqN1t8AHCDl5EIg==
X-Google-Smtp-Source: AA6agR4jON1tKEksi3I4Vq4PlB22Ex/PiBV2zVW/0xnyca+mCjolZrKI4ojvPaOe4SLUdWU9n8Tc2A==
X-Received: by 2002:a2e:5455:0:b0:25e:4b87:9714 with SMTP id y21-20020a2e5455000000b0025e4b879714mr4560693ljd.463.1659510154998;
        Wed, 03 Aug 2022 00:02:34 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id o24-20020a056512053800b00489d1896c06sm1436681lfc.125.2022.08.03.00.02.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 00:02:34 -0700 (PDT)
Message-ID: <b375ac1e-312d-d669-48a8-bef2e7e0e424@linaro.org>
Date:   Wed, 3 Aug 2022 10:02:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/6] drm/msm/dsi: Fix number of regulators for SDM660
Content-Language: en-GB
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20220802223738.898592-1-dianders@chromium.org>
 <20220802153434.v3.2.I94b3c3e412b7c208061349f05659e126483171b1@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220802153434.v3.2.I94b3c3e412b7c208061349f05659e126483171b1@changeid>
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
> 1 regulators is specified listed but the number 2 is specified. This
> presumably means we try to get a regulator with no name. Fix it.
> 
> Fixes: 033f47f7f121 ("drm/msm/dsi: Add DSI configuration for SDM660")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
> 
> (no changes since v2)
> 
> Changes in v2:
> - ("Fix number of regulators for SDM660") new for v2.
> 
>   drivers/gpu/drm/msm/dsi/dsi_cfg.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> index 02000a7b7a18..72c018e26f47 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
> @@ -148,7 +148,7 @@ static const char * const dsi_sdm660_bus_clk_names[] = {
>   static const struct msm_dsi_config sdm660_dsi_cfg = {
>   	.io_offset = DSI_6G_REG_SHIFT,
>   	.reg_cfg = {
> -		.num = 2,
> +		.num = 1,
>   		.regs = {
>   			{"vdda", 12560, 4 },	/* 1.2 V */

We should find some time and switch the reg_cfg.regs to be the external 
array, so that we can use ARRAY_SIZE for the amount of regs. However it 
is definitely not a showstopper for this series.



-- 
With best wishes
Dmitry

