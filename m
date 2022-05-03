Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE46518B02
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240307AbiECR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240280AbiECR2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 13:28:09 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474F03D49F
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:24:36 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e2442907a1so17836331fac.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 10:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CanGUDdfhEs76ZTWOvL6WUlp0ElqSKFQT4n1DiAHFqk=;
        b=kHfnN8Umh4i/iD6UEc5/64MWyrqjKPwTWKNYSFeDp8kyOrC2B/ea2GDNL6zo1FfWpV
         WtvBba+zmGIkCufOtdXHKtAqyV9HQTtN+HH26S9nMTXgNoBRGpg8ijbd4sEOshk3Op5b
         6tQ/iaIYJm5ty+AiAMvUAkpwREnix80i8zHRgA2fX3nSWTtuyIsX7VQFKHwyHeAOcVP5
         qYunaVKNZ6+9uNpa5XJgYVQniwX7nRpTQyKbwzcZysKXnZTHm1EDIXlELRcg93nzlCzH
         8IjDGSSIiuVzO4eE+ltgCOkZH32zZYHIpJbtm2WR8Pg03Fr53/HPLe4XdgkS/BmuFPTm
         FDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CanGUDdfhEs76ZTWOvL6WUlp0ElqSKFQT4n1DiAHFqk=;
        b=AMq+VNWdw1ZT2lx+si9NvVzQpMnSySqN0dd6wRkWa+cSQLdE3QROOZrhOE2O6vIE0h
         lXmEdx+ED9KHuz/jqHASS1pZBNAAoyypeYdUVKn+KwQ8N0lV2G21pDQrMgcHJCi4FUf7
         zrLofa+tgxpPQNXbWW3p5HDpOwsgFQ2x1/uWbiGFGj4PUrzjcItJwR8i6bVmqp1pMQOj
         bT0QMKAxiiMoNgrg7WAA882MkiUcrZooJFwxF0fPSaNJhHQSIndrJ0ZluC+zXkIjtjP0
         f+e64CgjozV14H0e1U2zba6My0MIUy9YspJWBVFr9nI+coazYLJSp5dYSBwfCtIR0b+a
         xifw==
X-Gm-Message-State: AOAM531l50k1KVhJ8TRl38luNfKH7FEA8YbSvE8cQ1XiV2dzgBgivacE
        Kd4SniU9qAcspjsu46d6pU7rmA==
X-Google-Smtp-Source: ABdhPJwjwIDgVBfDq5SUFY1KN95N92pqKI4z57riTKlpijF6mveXktdHp6ZD8ze10wT+gPezQcxhzg==
X-Received: by 2002:a05:6870:d254:b0:db:12b5:da3 with SMTP id h20-20020a056870d25400b000db12b50da3mr2183788oac.211.1651598675425;
        Tue, 03 May 2022 10:24:35 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id eg20-20020a056870989400b000e686d1387asm7158089oab.20.2022.05.03.10.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 10:24:34 -0700 (PDT)
Date:   Tue, 3 May 2022 12:24:30 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Robert Foss <robert.foss@linaro.org>
Cc:     agross@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, jonathan@marek.ca,
        tdas@codeaurora.org, anischal@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
Subject: Re: [PATCH v2 5/8] dt-bindings: clock: Add Qcom SM8350 GPUCC bindings
Message-ID: <YnFlTgd4dJsaMdSB@builder.lan>
References: <20220503130448.520470-1-robert.foss@linaro.org>
 <20220503130448.520470-5-robert.foss@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503130448.520470-5-robert.foss@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03 May 08:04 CDT 2022, Robert Foss wrote:

> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8350 SoCs.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmityr.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,gpucc.yaml |  2 +
>  include/dt-bindings/clock/qcom,gpucc-sm8350.h | 52 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,gpucc-sm8350.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> index 9ebcb1943b0a..4090cc7ea2ae 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
> @@ -20,6 +20,7 @@ description: |
>      dt-bindings/clock/qcom,gpucc-sm6350.h
>      dt-bindings/clock/qcom,gpucc-sm8150.h
>      dt-bindings/clock/qcom,gpucc-sm8250.h
> +    dt-bindings/clock/qcom,gpucc-sm8350.h
>  
>  properties:
>    compatible:
> @@ -31,6 +32,7 @@ properties:
>        - qcom,sm6350-gpucc
>        - qcom,sm8150-gpucc
>        - qcom,sm8250-gpucc
> +      - qcom,sm8350-gpucc
>  
>    clocks:
>      items:
> diff --git a/include/dt-bindings/clock/qcom,gpucc-sm8350.h b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> new file mode 100644
> index 000000000000..d2294e0d527e
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,gpucc-sm8350.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license please (you have the permission to change this)

Regards,
Bjorn

> +/*
> + * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> +#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8350_H
> +
> +/* GPU_CC clocks */
> +#define GPU_CC_AHB_CLK			0
> +#define GPU_CC_CB_CLK			1
> +#define GPU_CC_CRC_AHB_CLK		2
> +#define GPU_CC_CX_APB_CLK		3
> +#define GPU_CC_CX_GMU_CLK		4
> +#define GPU_CC_CX_QDSS_AT_CLK		5
> +#define GPU_CC_CX_QDSS_TRIG_CLK		6
> +#define GPU_CC_CX_QDSS_TSCTR_CLK	7
> +#define GPU_CC_CX_SNOC_DVM_CLK		8
> +#define GPU_CC_CXO_AON_CLK		9
> +#define GPU_CC_CXO_CLK			10
> +#define GPU_CC_FREQ_MEASURE_CLK		11
> +#define GPU_CC_GMU_CLK_SRC		12
> +#define GPU_CC_GX_GMU_CLK		13
> +#define GPU_CC_GX_QDSS_TSCTR_CLK	14
> +#define GPU_CC_GX_VSENSE_CLK		15
> +#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK	16
> +#define GPU_CC_HUB_AHB_DIV_CLK_SRC	17
> +#define GPU_CC_HUB_AON_CLK		18
> +#define GPU_CC_HUB_CLK_SRC		19
> +#define GPU_CC_HUB_CX_INT_CLK		20
> +#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC	21
> +#define GPU_CC_MND1X_0_GFX3D_CLK	22
> +#define GPU_CC_MND1X_1_GFX3D_CLK	23
> +#define GPU_CC_PLL0			24
> +#define GPU_CC_PLL1			25
> +#define GPU_CC_SLEEP_CLK		26
> +
> +/* GPU_CC resets */
> +#define GPUCC_GPU_CC_ACD_BCR		0
> +#define GPUCC_GPU_CC_CB_BCR		1
> +#define GPUCC_GPU_CC_CX_BCR		2
> +#define GPUCC_GPU_CC_FAST_HUB_BCR	3
> +#define GPUCC_GPU_CC_GFX3D_AON_BCR	4
> +#define GPUCC_GPU_CC_GMU_BCR		5
> +#define GPUCC_GPU_CC_GX_BCR		6
> +#define GPUCC_GPU_CC_XO_BCR		7
> +
> +/* GPU_CC GDSCRs */
> +#define GPU_CX_GDSC			0
> +#define GPU_GX_GDSC			1
> +
> +#endif
> -- 
> 2.34.1
> 
