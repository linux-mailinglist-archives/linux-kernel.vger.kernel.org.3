Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9127C495BE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:26:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379570AbiAUI01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:26:27 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60518
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231208AbiAUI0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:26:24 -0500
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 43DAE3FFDD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642753577;
        bh=WFaN2NaRLA9rIp327g1xVjFRTrxCMZQ865lGwbwG9Rk=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=AHehVNRhEXawGtsLWdVJn/T6EwhenYKgrTe39COmL72rBxRgsM6fBL55UWbZu6hSh
         W8PZsGwF4ci6heRnt5PdCvCOZ4/ZG1wxlQz3bSuLclnwHNd5nxcCv/64SkccPKdA7i
         UFEIC3kRqPUbZA2P+n4bDzqB8YX+KvUq6vFN+5q+2sPK2g3zdLSIrkJSmzmJDgQvpa
         REx7faqkW0zMMLOJZBeHhaHK8808ZFM2VwjDnrKUn6q1PDmF6PleUOqzMADGONAFl8
         pMCPuHvcn3X+T/ncqkUMzXl67BqsG+HHC5qyxmqayB80Auo1SRwRhVkX/kwLueMo10
         FzYORSZXY3lbg==
Received: by mail-ed1-f69.google.com with SMTP id ej6-20020a056402368600b00402b6f12c3fso8420843edb.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WFaN2NaRLA9rIp327g1xVjFRTrxCMZQ865lGwbwG9Rk=;
        b=Z/ifikZSBhg3U/0nBHXheBp76PJhll5eazStnNo2JQhs2xQpJLI0W2x/rharpHoyZU
         E/JgSIHkyE34vQz7mBi9p/MOL3PNoo2hGUpferpxYZzmoYfxt6MwPL+v6wgAHd4umQTS
         JrX43x9FSf4gLv2oB2ev0HRi74WMm6NM5M30+/3xR6rVVp7Cl/LD0mW9/s5Z2jGgRWFm
         Ozs5Y8cziPwWWhx2jBt4wSh2pXa7jw6MzBOLKsTU4jhGir/2I1X+pelOOlCdbBFXqx9t
         7EPhZZGwt4YqUAwYdPS4aegviL9q1aT00x+xMAo3MRZaVeFZHZe8VoEEIbMhlZbQWZMG
         8eEw==
X-Gm-Message-State: AOAM532JKJtKb8fHPB/ZsAean7F5SddT4oCjXLbTbbkQkMIvWfaR4P8S
        63ER8odACGiaziN5DulTmC150EpwAHjAYbVPBqYroEtrWmJAeInk66l3R6oi2L2lhzWYFsYliKQ
        GLfQvDFteR4v9ODhaxWX1frLd81cHkZ6vTztcxFT2sg==
X-Received: by 2002:aa7:d949:: with SMTP id l9mr3339685eds.54.1642753576910;
        Fri, 21 Jan 2022 00:26:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM9vD86mwMtX+h2FjjQlccFgtkFev6o5qFbfunrbz4ISkFfscZEMnftrRS9hu6u4qvlPa49w==
X-Received: by 2002:aa7:d949:: with SMTP id l9mr3339671eds.54.1642753576763;
        Fri, 21 Jan 2022 00:26:16 -0800 (PST)
Received: from [192.168.0.50] (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id cf13sm1821768ejb.141.2022.01.21.00.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 00:26:16 -0800 (PST)
Message-ID: <9a006308-cabb-7ee2-0556-860d425b251f@canonical.com>
Date:   Fri, 21 Jan 2022 09:26:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [RFC 1/3] dt-bindings: iommu: Add bindings for samsung,sysmmu-v8
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Hyesoo Yu <hyesoo.yu@samsung.com>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Jinkyu Yang <jinkyu1.yang@samsung.com>,
        Alex <acnwigwe@google.com>, Carlos Llamas <cmllamas@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        Erick Reyes <erickreyes@google.com>,
        "J . Avila" <elavila@google.com>, Jonglin Lee <jonglin@google.com>,
        Mark Salyzyn <salyzyn@google.com>,
        Thierry Strudel <tstrudel@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220120201958.2649-1-semen.protsenko@linaro.org>
 <20220120201958.2649-2-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220120201958.2649-2-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2022 21:19, Sam Protsenko wrote:
> Only example of usage and header for now.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../bindings/iommu/samsung,sysmmu-v8.txt      | 31 +++++++++++++

Please, don't copy paste bindings or entire drviers from vendor kernel.
It looks very bad. Instead, submit them in dtschema.

NAK.

>  include/dt-bindings/soc/samsung,sysmmu-v8.h   | 43 +++++++++++++++++++
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
>  create mode 100644 include/dt-bindings/soc/samsung,sysmmu-v8.h
> 
> diff --git a/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
> new file mode 100644
> index 000000000000..d6004ea4a746
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/samsung,sysmmu-v8.txt
> @@ -0,0 +1,31 @@
> +Example (Exynos850, IOMMU for DPU usage):
> +
> +	#include <dt-bindings/soc/samsung,sysmmu-v8.h>
> +
> +	/* IOMMU group info */
> +	iommu_group_dpu: iommu_group_dpu {
> +		compatible = "samsung,sysmmu-group";
> +	};
> +
> +	sysmmu_dpu: sysmmu@130c0000 {
> +		compatible = "samsung,sysmmu-v8";
> +		reg = <0x130c0000 0x9000>;
> +		interrupts = <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
> +		qos = <15>;
> +
> +		clocks = <&cmu_dpu CLK_GOUT_DPU_SMMU_CLK>;
> +		clock-names = "gate";
> +
> +		sysmmu,secure-irq;
> +		sysmmu,secure_base = <0x130d0000>;
> +		sysmmu,default_tlb = <TLB_CFG(BL1, PREFETCH_PREDICTION)>;
> +		sysmmu,tlb_property =
> +			<1 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x2, 0xF)>,
> +			<2 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x4, 0xF)>,
> +			<3 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x6, 0xF)>,
> +			<4 TLB_CFG(BL1, PREFETCH_PREDICTION) (DIR_READ | (1 << 16)) SYSMMU_ID_MASK(0x8, 0xF)>;
> +		port-name = "DPU";
> +		#iommu-cells = <0>;
> +		//power-domains = <&pd_dpu>;

We try not to store dead code in kernel.



Best regards,
Krzysztof
