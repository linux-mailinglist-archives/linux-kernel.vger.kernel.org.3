Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645F2574F56
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239503AbiGNNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiGNNi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:38:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A55FAC7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:38:24 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z12so2606088wrq.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=gZbm5v8jczB3m3Zbghv7hORrbzz+8TA8A7EGSVhjSaQ=;
        b=QhSFR35ht5QEM5YZF2rpDWTzxDIE4nFn1yZhWPiMSFmnpD/aDrZwGNbmNuamkHO1XF
         1J4UOj7++gNdTSdZuPgzZvkbRoyZHLZhZb+N2JoI+nCcDQNaD/P8pQ75/GdD+ScQdwp0
         59oDsFg3whwkWU97Rsn5CqHobBGGRYbjWrEOyblVdLZNk34xQRMRGkLoLnzSInu0dPKM
         aZVXK/Fey7k6krYGdUv3TzlEFgETj7JSuoN7kMMtQTCiSSFwqaHVrKTyYziyVfG2EiGk
         5krBajsYVkRMa+oEMQTmJz40cEHzkpD5xdRKxpWJyH+LvNS6bhqZzJy1pKjOn59iCwTx
         9c5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=gZbm5v8jczB3m3Zbghv7hORrbzz+8TA8A7EGSVhjSaQ=;
        b=UwCM6KiHElIeCVBZ2ZxpQPzAQ7tDqjqJX5pSPj8CRrN5R6I0nI/eUpbFndVpFOcRFR
         fCgNUHMwRKbGoniHDuYOOt6wWeVDyH5h5qVRs/mGxSlj6azeJdglfjHsQdVQV5nKN5ry
         PKTe73qgo/EuoD1w+JN1HT1K1AefN/0Sq19sYGEYWWE9hHCSoxkJyBqzO/t5npi44/DI
         MsFkQaHUgNgv9lzOxXFlcaNW7rORaEkR90VQ/qnRhmppw0TCsUUL0DqliFMorUoVwKpq
         qI33blklYFEMZYtq8hTkz5GE+LKNq/dAWvqgFaJkCYpxnho/wSS7ZAOEC2cJ8b/zhWji
         ppEg==
X-Gm-Message-State: AJIora8LN344ygTsoGzbPC4CzFTnt5UCtMH+C5QEWEj9pHnRmCNuP/Uo
        lklddBK7IWl5/5DWtchJXcLarw==
X-Google-Smtp-Source: AGRyM1uxSpQQUohZAVCvRDTDUH1kMNPkjZLHzaAqEsW41la3u7tmhLBotyjHD8UJYEkeF4RD+P0HJw==
X-Received: by 2002:a05:6000:81d:b0:21d:a495:6e3 with SMTP id bt29-20020a056000081d00b0021da49506e3mr8401904wrb.502.1657805903332;
        Thu, 14 Jul 2022 06:38:23 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id n18-20020a05600c4f9200b003a2ec73887fsm8793750wmq.1.2022.07.14.06.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:38:22 -0700 (PDT)
Date:   Thu, 14 Jul 2022 14:38:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 03/19] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YtAcTCUsy9I67L3V@google.com>
References: <20220714122837.20094-1-tinghan.shen@mediatek.com>
 <20220714122837.20094-4-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220714122837.20094-4-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject line should be 'mfd', rather than 'power'.

On Thu, 14 Jul 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  .../bindings/mfd/mediatek,scpsys.yaml         | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> new file mode 100644
> index 000000000000..a8b9220f2f27
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek System Control Processor System
> +
> +maintainers:
> +  - MandyJH Liu <mandyjh.liu@mediatek.com>
> +
> +description:
> +  MediaTek System Control Processor System (SCPSYS) has several
> +  power management tasks. The tasks include MTCMOS power
> +  domain control, thermal measurement, DVFS, etc.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,scpsys
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  reg:
> +    maxItems: 1
> +
> +  power-controller:
> +    $ref: /schemas/power/mediatek,power-controller.yaml#
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    syscon@10006000 {
> +        compatible = "mediatek,scpsys", "syscon", "simple-mfd";

Not sure you need bindings for this.  Seems overkill.

I'll let the DT guys have the final say though.

> +        reg = <0x10006000 0x100>;
> +
> +        spm: power-controller {
> +            compatible = "mediatek,mt8195-power-controller";
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            #power-domain-cells = <1>;
> +
> +            /* sample of power domain nodes */
> +            power-domain@MT8195_POWER_DOMAIN_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +
> +            power-domain@MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY {
> +                    reg = <MT8195_POWER_DOMAIN_SSUSB_PCIE_PHY>;
> +                    #power-domain-cells = <0>;
> +            };
> +        };
> +    };

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
