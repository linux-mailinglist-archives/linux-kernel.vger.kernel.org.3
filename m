Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D574953F16D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 23:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiFFVJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 17:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiFFVJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 17:09:22 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E3222D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 14:09:18 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-f33f0f5b1dso20670283fac.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KjZUeR41V+hdVlsqMk8d6AC7MYE0tWAvsjnkRUTqWy0=;
        b=pFvU4CCOoui9Xxwvj+qmAzvOiXI5aFvbgInYPFz5KR8vAZcLHD+eEK+zBnSYabG76Y
         MRbf1UnC8j/xo4HYq+uQIv7B4Yo4XSCQVBFX4QN+29ohKySkRHLH8O6dLfXIRcEhoZHk
         F+kZ7/hlhRgAU6+FKMAK4AcL0Zy1S2foyOzvqfUfQP4ii2fFfQPSFElUi+vip+WNdGs2
         aJy5/A7s8iEQiAMgum4CAooOH52UZzohQgmE3lxqlDPwx39Z0rbT1T65u5ahuNxZgHri
         XpAhd6N9EMVKAo2hPVj7k5YB+vDf1PNUK2WXKIL44ij8uok/rG3Qeu7OsWtHTFwEkoJ5
         kWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjZUeR41V+hdVlsqMk8d6AC7MYE0tWAvsjnkRUTqWy0=;
        b=H12vQL1s1cgxoGI7QxzzJnZVn8VvXsYCxJE+uKagsYsytSHsGVHSnFJyx2D0TJPJtZ
         keOdbyH5UzfWA0Sldyh9MY7LKiBS+Gz7RPRif4hY5ZwyG+/8zY2D0SE7r6ZamEd5a4EV
         YqDGyjNU9PFMHBuCbc3vygLoCJKfmIHYgPnOPuA+DvOS8srqyLSaM81h6fRYfbj9DMPt
         QfVc987fZnAWs9tesGRPmTw2XurB+H1tIZE0np3/fvmcUiTiYT24LIFUFsoAOem1SN0a
         hDwlvDE8mT3C0EfzlK4pURyn8lnFBEkVdMceuR6gAa+oYCanpyNS5YTzLrO7RNMz+hiC
         qZ6w==
X-Gm-Message-State: AOAM530g5wor49/NfUdwaq2ZYT4kKaIVvJgOJCUq59jQmq7JuXwH56YB
        O/pQzLu4Fix6v3OWR1dveyON/w==
X-Google-Smtp-Source: ABdhPJyFpCdTs573Aa9BUetYgzmOYdpif+0Pijgsdtagi9smmxL5Z1AK44PHxIkjGftSEl++FYBRGQ==
X-Received: by 2002:a05:6870:b14c:b0:fa:e853:9a7e with SMTP id a12-20020a056870b14c00b000fae8539a7emr9763440oal.186.1654549757512;
        Mon, 06 Jun 2022 14:09:17 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id q28-20020a05683022dc00b0060c00c3fde5sm1108100otc.72.2022.06.06.14.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 14:09:16 -0700 (PDT)
Date:   Mon, 6 Jun 2022 14:11:41 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 1/4] dt-bindings: interconnect: qcom,sdm845-cpu-bwmon:
 add BWMON device
Message-ID: <Yp5tjUICIEUptKSx@ripper>
References: <20220601101140.170504-1-krzysztof.kozlowski@linaro.org>
 <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601101140.170504-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01 Jun 03:11 PDT 2022, Krzysztof Kozlowski wrote:

> Add bindings for the Qualcomm Bandwidth Monitor device providing
> performance data on interconnects.  The bindings describe only BWMON
> version 4, e.g. the instance on SDM845 between CPU and Last Level Cache
> Controller.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Georgi Djakov <djakov@kernel.org>
> ---
>  .../interconnect/qcom,sdm845-cpu-bwmon.yaml   | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> new file mode 100644
> index 000000000000..8c82e06ee432
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sdm845-cpu-bwmon.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sdm845-cpu-bwmon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Interconnect Bandwidth Monitor
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +
> +description:
> +  Bandwidth Monitor measures current throughput on buses between various NoC
> +  fabrics and provides information when it crosses configured thresholds.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sdm845-cpu-bwmon       # BWMON v4

It seems the thing that's called bwmon v4 is compatible with a number of
different platforms, should we add a generic compatible to the binding
as well, to avoid having to update the implementation for each SoC?

(I.e. "qcom,sdm845-cpu-bwmon", "qcom,bwmon-v4")

Regards,
Bjorn

> +
> +  interconnects:
> +    maxItems: 2
> +
> +  interconnect-names:
> +    items:
> +      - const: ddr
> +      - const: l3c
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  operating-points-v2: true
> +  opp-table: true
> +
> +  reg:
> +    # Currently described BWMON v4 and v5 use one register address space.
> +    # BWMON v2 uses two register spaces - not yet described.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - interconnects
> +  - interconnect-names
> +  - interrupts
> +  - operating-points-v2
> +  - opp-table
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/qcom,osm-l3.h>
> +    #include <dt-bindings/interconnect/qcom,sdm845.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    pmu@1436400 {
> +        compatible = "qcom,sdm845-cpu-bwmon";
> +        reg = <0x01436400 0x600>;
> +
> +        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        interconnects = <&gladiator_noc MASTER_APPSS_PROC 3 &mem_noc SLAVE_EBI1 3>,
> +                        <&osm_l3 MASTER_OSM_L3_APPS &osm_l3 SLAVE_OSM_L3>;
> +        interconnect-names = "ddr", "l3c";
> +
> +        operating-points-v2 = <&cpu_bwmon_opp_table>;
> +
> +        cpu_bwmon_opp_table: opp-table {
> +            compatible = "operating-points-v2";
> +
> +            opp-0 {
> +                opp-peak-kBps = <800000 4800000>;
> +            };
> +            opp-1 {
> +                opp-peak-kBps = <1804000 9216000>;
> +            };
> +            opp-2 {
> +                opp-peak-kBps = <2188000 11980800>;
> +            };
> +            opp-3 {
> +                opp-peak-kBps = <3072000 15052800>;
> +            };
> +            opp-4 {
> +                opp-peak-kBps = <4068000 19353600>;
> +            };
> +            opp-5 {
> +                opp-peak-kBps = <5412000 20889600>;
> +            };
> +            opp-6 {
> +                opp-peak-kBps = <6220000 22425600>;
> +            };
> +            opp-7 {
> +                opp-peak-kBps = <7216000 25497600>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
