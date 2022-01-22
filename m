Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0B14968E5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 01:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiAVArY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 19:47:24 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:33519 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiAVArX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 19:47:23 -0500
Received: by mail-oi1-f173.google.com with SMTP id x193so16075603oix.0;
        Fri, 21 Jan 2022 16:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tk2viXmE2HDPPuK/8QkfT2jk+/4c5gIWC4M/WJoAeXc=;
        b=tMGzJLg7ddw7xiKmZRF3SS1iP1NBnjzdyJeBKFiu0n8ke1IBEtX6pZH/N4vF7322C/
         m0gEb277bwnMOLZBjVCn3Tr4KkieuBrS+z8JKiY4wW9pyzntUgcAAGPbccNVGkZ5Tdum
         2NJ30IjPU8X2N33WuEKE1HcFBesMM0SuiOFi3+Ja7WCsR4LF9F6GHDpo/l9CYVIvYHFP
         MkqoJoZGAudDVHyh0vLAbpBuSl6IblxIalwFRmkR8xVAQ141z+BM3oflYs66F0j8Vi9E
         LLsoLALqHVzO7Mday90nSakyuLSIgr7Ests0HDz6ADyzFHp45iOjf47ObzxlW4thczz9
         E2iA==
X-Gm-Message-State: AOAM533x98U+SMW9SqQLihlrbWbPX1+6KboHCIuYnIAh7nzpjST/YxB8
        +fMDuQzBp7L5lnOxPQ19Lw==
X-Google-Smtp-Source: ABdhPJwNlde4yj7lkMI3h5a2v/CEJg7ZZ9Z2SVYl+EopsR0EhSyybGtLgaYmAjYp4HViv2SOJN+t2A==
X-Received: by 2002:a05:6808:152a:: with SMTP id u42mr2586789oiw.6.1642812442473;
        Fri, 21 Jan 2022 16:47:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t25sm1773317otk.6.2022.01.21.16.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 16:47:21 -0800 (PST)
Received: (nullmailer pid 1939579 invoked by uid 1000);
        Sat, 22 Jan 2022 00:47:20 -0000
Date:   Fri, 21 Jan 2022 18:47:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, ~okias/devicetree@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC
Message-ID: <YetUGES199JLmpCi@robh.at.kernel.org>
References: <20220111220026.102838-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111220026.102838-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:00:25PM +0100, David Heidelberg wrote:
> Convert Qualcomm SPMI PMIC binding to yaml format.
> 
> Additional changes:
>  - filled many missing compatibles
> 
> Co-developed-by: Caleb Connolly <caleb@connolly.tech>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> to pass tests correctly
> depends on patch "arm64: dts: qcom: pms405: assign device specific compatible"
> 
> v2:
>  - changed author to myself, kept Caleb as co-author
>  - moved nodename to properties
>  - add nodenames for pm* with deprecated property
>  - add ^$ to pattern properties
>  - dropped interrupt-names property
>  - added reg prop. to the nodes which have register in nodename
>  - added compatible pmx55
> 
>  .../bindings/mfd/qcom,spmi-pmic.txt           |  93 -----------
>  .../bindings/mfd/qcom,spmi-pmic.yaml          | 156 ++++++++++++++++++
>  2 files changed, 156 insertions(+), 93 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml


> diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> new file mode 100644
> index 000000000000..595a22b185fd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> @@ -0,0 +1,156 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/qcom,spmi-pmic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SPMI PMICs multi-function device
> +
> +description: |
> +  Some Qualcomm PMICs used with the Snapdragon series SoCs are interfaced
> +  to the chip via the SPMI (System Power Management Interface) bus.
> +  Support for multiple independent functions are implemented by splitting the
> +  16-bit SPMI peripheral address space into 256 smaller fixed-size regions, 256 bytes
> +  each. A function can consume one or more of these fixed-size register regions.
> +
> +  The Qualcomm SPMI series includes the PM8941, PM8841, PMA8084, PM8998 and other
> +  PMICs.  These PMICs use a "QPNP" scheme through SPMI interface.
> +  QPNP is effectively a partitioning scheme for dividing the SPMI extended
> +  register space up into logical pieces, and set of fixed register
> +  locations/definitions within these regions, with some of these regions
> +  specifically used for interrupt handling.
> +
> +maintainers:
> +  - Stephen Boyd <sboyd@kernel.org>
> +
> +properties:
> +  $nodename:
> +    oneOf:
> +      - pattern: '^pmic@.*$'
> +      - pattern: '^pm(a|s)?[0-9]*@.*$'
> +        deprecated: true
> +
> +  compatible:
> +    items:
> +      - enum:
> +          - qcom,pm660
> +          - qcom,pm660l
> +          - qcom,pm6150
> +          - qcom,pm6150l
> +          - qcom,pm6350
> +          - qcom,pm7325
> +          - qcom,pm8004
> +          - qcom,pm8005
> +          - qcom,pm8009
> +          - qcom,pm8019
> +          - qcom,pm8110
> +          - qcom,pm8150
> +          - qcom,pm8150b
> +          - qcom,pm8150l
> +          - qcom,pm8226
> +          - qcom,pm8350
> +          - qcom,pm8350b
> +          - qcom,pm8350c
> +          - qcom,pm8841
> +          - qcom,pm8909
> +          - qcom,pm8916
> +          - qcom,pm8941
> +          - qcom,pm8950
> +          - qcom,pm8994
> +          - qcom,pm8998
> +          - qcom,pma8084
> +          - qcom,pmd9635
> +          - qcom,pmi8950
> +          - qcom,pmi8962
> +          - qcom,pmi8994
> +          - qcom,pmi8998
> +          - qcom,pmk8350
> +          - qcom,pmm8155au
> +          - qcom,pmr735a
> +          - qcom,pmr735b
> +          - qcom,pms405
> +          - qcom,pmx55
> +          - qcom,smb2351
> +      - const: qcom,spmi-pmic
> +
> +  reg: true
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +
> +patternProperties:
> +  '^(labibb|([a-z][a-z0-9]+-)?regulators)$':
> +    type: object
> +
> +    required:
> +      - compatible
> +
> +  '@[0-9a-f]+$':
> +    type: object
> +    description: >
> +      Each child node of the PMIC represents a function of it.
> +
> +    properties:
> +      reg: true
> +
> +      interrupts:
> +        description: >
> +          Interrupts are specified as a 4-tuple. For more information see
> +          Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.yaml
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/spmi/spmi.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    spmi@c440000 {
> +        compatible = "qcom,spmi-pmic-arb";
> +        reg = <0x0c440000 0x1100>,
> +              <0x0c600000 0x2000000>,
> +              <0x0e600000 0x100000>,
> +              <0x0e700000 0xa0000>,
> +              <0x0c40a000 0x26000>;
> +        reg-names = "core", "chnls", "obsrvr", "intr", "cnfg";
> +        interrupt-names = "periph_irq";
> +        interrupts = <GIC_SPI 481 IRQ_TYPE_LEVEL_HIGH>;
> +        qcom,ee = <0>;
> +        qcom,channel = <0>;
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        interrupt-controller;
> +        #interrupt-cells = <4>;

It's preferred if you just have a minimal 'spmi' bus node rather than 
something complete and probably duplicated from the "qcom,spmi-pmic-arb" 
binding.

> +        cell-index = <0>;

That shouldn't be valid.

> +
> +        pmi8998_lsid0: pmic@2 {
> +            compatible = "qcom,pmi8998", "qcom,spmi-pmic";
> +            reg = <0x2 SPMI_USID>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +

Would be nice to show some regulators...

> +            pmi8998_gpio: gpios@c000 {
> +                compatible = "qcom,pmi8998-gpio", "qcom,spmi-gpio";
> +                reg = <0xc000>;
> +                gpio-controller;
> +                gpio-ranges = <&pmi8998_gpio 0 0 14>;
> +                #gpio-cells = <2>;
> +                interrupt-controller;
> +                #interrupt-cells = <2>;
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
