Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEECF4CA11C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbiCBJrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240626AbiCBJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:47:02 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B8D7C7B8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 01:46:14 -0800 (PST)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4220D3F5F7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646214372;
        bh=lAb27ZgFQOByFHIClEAhJ0N2dL6QzOfjA77CIlXGrDU=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=Fw/29sbtMEfxFK7RRYIMuK3K+0/eXxhIKUEGyAX730+8KTTyam6Bvg2MfJIbfctnK
         aP1xmnba3wwW6E+9c2TOmHBhk/EWfd8oXlgVeYpcHqwWZY6zBLVFcAqfqFQOU0dhIG
         Yc1hSojoUDusk8wwD8LQ0OBjsGPmLlQg6BkiXRFlHcdTR1SepbHAHd7QW7yIuki+gv
         0GkA6b0A9spB64VMld9BOnIA2bCXHGqGetfhDaW3BBBHlSpTeg8XDGaUUDvRJdgOKy
         1PX9d1aSN37XtHkLL+Wa9Mbf96jNzWXsHM3oA6W8oasHicFkcCBy6LrD83cPToVjLf
         bOtV/Ne/mnnCg==
Received: by mail-ej1-f72.google.com with SMTP id m4-20020a170906160400b006be3f85906eso689368ejd.23
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 01:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lAb27ZgFQOByFHIClEAhJ0N2dL6QzOfjA77CIlXGrDU=;
        b=QsPw/tdXj6KLt3kcUuvoRfN9CI7iBMpAt3sJvRfbvdO5VLIFtEsQKEmYA6poO6k89S
         tassyZh/SxldGmO+X+XHEErKBNvkAmwlo3bEhDw/4hwasKbJ0bCse5dwnuz3Cr8hfQ4a
         Vs/SOhPBD4QV7mTLWVVBk+N/gIIS791LvHvu2aXT6nWFlZ8prf+Mt8dnq5OaFQjLzhqC
         mNT0BBjuoOX6Ay0Sw8z2Dw3XH+NCARGXSiKcOTEylQeqqV+qLM0ddXqw1t1TK1cbz+t/
         eVMF4vttUMY6hpw0QmeckfnApNnZ7zERFbRLK/2LcG4u4kI029rWdRQHjxPZH65iEhTf
         eMSg==
X-Gm-Message-State: AOAM533putIN3TKKhiW2eD+xoFDwYpVqsmsC1OYC/jOV5xSfCYQDuwu+
        rudtFUiY731pj9eESY5LZvIEaNNXLM6xerqLmwwsLg9V17MHQgorh1ndMajXaTevFo1V+OQx3HE
        Qk+9FV9XSQAAwi+yaAk343a7SG/Du8M9ynj56JC1Uig==
X-Received: by 2002:a17:906:c048:b0:6ce:a6f5:b23a with SMTP id bm8-20020a170906c04800b006cea6f5b23amr21987695ejb.350.1646214370261;
        Wed, 02 Mar 2022 01:46:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxt3m08y7YEqtS4flqRepTSs5Wr7s6n2g6prN66QvwsvFQSR8vFMHL5ix5LeZez52FJ+02DBA==
X-Received: by 2002:a17:906:c048:b0:6ce:a6f5:b23a with SMTP id bm8-20020a170906c04800b006cea6f5b23amr21987679ejb.350.1646214369981;
        Wed, 02 Mar 2022 01:46:09 -0800 (PST)
Received: from [192.168.0.136] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm8152603edy.61.2022.03.02.01.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 01:46:09 -0800 (PST)
Message-ID: <6dae47c3-6083-782e-ecab-7be3f0bca0e1@canonical.com>
Date:   Wed, 2 Mar 2022 10:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/5] dt-bindings: Convert ahci-platform DT bindings to
 yaml
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>, devicetree@vger.kernel.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20220301152421.57281-1-linux@fw-web.de>
 <20220301152421.57281-2-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220301152421.57281-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2022 16:24, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Create a yaml file for dtbs_check from the old txt binding.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v4:
>   - fix min vs. max
>   - fix indention of examples
>   - move up sata-common.yaml
>   - reorder compatible
>   - add descriptions/maxitems
>   - fix compatible-structure
>   - fix typo in example achi vs. ahci
>   - add clock-names and reg-names
>   - fix ns2 errors in separate patch
> v3:
>   - add conversion to sata-series
>   - fix some errors in dt_binding_check and dtbs_check
>   - move to unevaluated properties = false
> 
> ---
> 
> imho all errors should be fixed in the dts not in the yaml...
> 
> errors about the subitem requirement that was defined in txt but not fixed some marvell dts
> 
> some dts for Marvell SoC bring error
> 'phys' is a required property
> 'target-supply' is a required property
> 
> problem is in arch/arm64/boot/dts/marvell/armada-cp11x.dtsi:331
> here the sata-port@0 is defined, but not overridden with phy/target-supply in any following dts
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt |  79 ---------
>  .../bindings/ata/ahci-platform.yaml           | 162 ++++++++++++++++++
>  2 files changed, 162 insertions(+), 79 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.txt
>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-platform.yaml
> 
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
> deleted file mode 100644
> index 77091a277642..000000000000
> --- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -* AHCI SATA Controller
> -
> -SATA nodes are defined to describe on-chip Serial ATA controllers.
> -Each SATA controller should have its own node.
> -
> -It is possible, but not required, to represent each port as a sub-node.
> -It allows to enable each port independently when dealing with multiple
> -PHYs.
> -
> -Required properties:
> -- compatible        : compatible string, one of:
> -  - "brcm,iproc-ahci"
> -  - "hisilicon,hisi-ahci"
> -  - "cavium,octeon-7130-ahci"
> -  - "ibm,476gtr-ahci"
> -  - "marvell,armada-380-ahci"
> -  - "marvell,armada-3700-ahci"
> -  - "snps,dwc-ahci"
> -  - "snps,spear-ahci"
> -  - "generic-ahci"
> -- interrupts        : <interrupt mapping for SATA IRQ>
> -- reg               : <registers mapping>
> -
> -Please note that when using "generic-ahci" you must also specify a SoC specific
> -compatible:
> -	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
> -
> -Optional properties:
> -- dma-coherent      : Present if dma operations are coherent
> -- clocks            : a list of phandle + clock specifier pairs
> -- resets            : a list of phandle + reset specifier pairs
> -- target-supply     : regulator for SATA target power
> -- phy-supply        : regulator for PHY power
> -- phys              : reference to the SATA PHY node
> -- phy-names         : must be "sata-phy"
> -- ahci-supply       : regulator for AHCI controller
> -- ports-implemented : Mask that indicates which ports that the HBA supports
> -		      are available for software to use. Useful if PORTS_IMPL
> -		      is not programmed by the BIOS, which is true with
> -		      some embedded SOC's.
> -
> -Required properties when using sub-nodes:
> -- #address-cells    : number of cells to encode an address
> -- #size-cells       : number of cells representing the size of an address
> -
> -Sub-nodes required properties:
> -- reg		    : the port number
> -And at least one of the following properties:
> -- phys		    : reference to the SATA PHY node
> -- target-supply     : regulator for SATA target power
> -
> -Examples:
> -        sata@ffe08000 {
> -		compatible = "snps,spear-ahci";
> -		reg = <0xffe08000 0x1000>;
> -		interrupts = <115>;
> -        };
> -
> -With sub-nodes:
> -	sata@f7e90000 {
> -		compatible = "marvell,berlin2q-achi", "generic-ahci";
> -		reg = <0xe90000 0x1000>;
> -		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&chip CLKID_SATA>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -
> -		sata0: sata-port@0 {
> -			reg = <0>;
> -			phys = <&sata_phy 0>;
> -			target-supply = <&reg_sata0>;
> -		};
> -
> -		sata1: sata-port@1 {
> -			reg = <1>;
> -			phys = <&sata_phy 1>;
> -			target-supply = <&reg_sata1>;;
> -		};
> -	};
> diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> new file mode 100644
> index 000000000000..cf67ddfc6afb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
> @@ -0,0 +1,162 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/ata/ahci-platform.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AHCI SATA Controller
> +description:
> +  SATA nodes are defined to describe on-chip Serial ATA controllers.
> +  Each SATA controller should have its own node.
> +
> +  It is possible, but not required, to represent each port as a sub-node.
> +  It allows to enable each port independently when dealing with multiple
> +  PHYs.
> +
> +maintainers:
> +  - Hans de Goede <hdegoede@redhat.com>
> +  - Jens Axboe <axboe@kernel.dk>
> +
> +allOf:
> +- $ref: "sata-common.yaml#"
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - brcm,iproc-ahci
> +          - marvell,armada-8k-ahci
> +          - marvell,berlin2q-ahci
> +        - const: generic-ahci
> +      - enum:
> +        - brcm,iproc-ahci

This one is already earlier in generic-ahci, so you can skip him here.

> +        - cavium,octeon-7130-ahci
> +        - hisilicon,hisi-ahci
> +        - ibm,476gtr-ahci
> +        - marvell,armada-3700-ahci
> +        - marvell,armada-380-ahci
> +        - snps,dwc-ahci
> +        - snps,spear-ahci
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Clock IDs array as required by the controller.
> +    minItems: 1
> +    maxItems: 3
> +
> +  interrupts:
> +    description:
> +      specifies the interrupt number for the controller.

Skip description, it's obvious.

> +    maxItems: 1
> +
> +  ahci-supply:
> +    description:
> +      regulator for AHCI controller
> +
> +  clock-names:
> +    description:
> +      Names of clocks corresponding to IDs in the clock property.
> +    minItems: 1
> +    maxItems: 3

Put the clock-names next to clocks.

> +
> +  dma-coherent:
> +    true

New line not needed. "dma-coherent: true"

> +
> +  phy-supply:
> +    description:
> +      regulator for PHY power
> +
> +  phys:
> +    description:
> +      List of all PHYs on this controller
> +    maxItems: 1
> +
> +  phy-names:
> +    description:
> +      Name specifier for the PHYs
> +    maxItems: 1
> +
> +  ports-implemented:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description:
> +      Mask that indicates which ports that the HBA supports
> +      are available for software to use. Useful if PORTS_IMPL
> +      is not programmed by the BIOS, which is true with
> +      some embedded SoCs.
> +    maxItems: 1

maxItems are incorrect here, this is not an array.

> +
> +  reg-names:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  target-supply:
> +    description:
> +      regulator for SATA target power
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +patternProperties:
> +  "^sata-port@[0-9a-f]+$":
> +    type: object
> +    description:
> +      Subnode with configuration of the Ports.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      phys:
> +        minItems: 1

maxItems: 1

> +
> +      target-supply:
> +        description:
> +          regulator for SATA target power
> +
> +    required:
> +      - reg
> +
> +    anyOf:
> +      - required: [ phys ]
> +      - required: [ target-supply ]
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    sata@ffe08000 {
> +           compatible = "snps,spear-ahci";
> +           reg = <0xffe08000 0x1000>;
> +           interrupts = <115>;
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/berlin2q.h>
> +    sata@f7e90000 {
> +            compatible = "marvell,berlin2q-ahci", "generic-ahci";
> +            reg = <0xe90000 0x1000>;

You still have wrong address.

> +            interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> +            clocks = <&chip CLKID_SATA>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            sata0: sata-port@0 {
> +                    reg = <0>;
> +                    phys = <&sata_phy 0>;
> +                    target-supply = <&reg_sata0>;
> +            };
> +
> +            sata1: sata-port@1 {
> +                    reg = <1>;
> +                    phys = <&sata_phy 1>;
> +                    target-supply = <&reg_sata1>;
> +            };
> +    };


Best regards,
Krzysztof
