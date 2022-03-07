Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8834CFCE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241885AbiCGLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbiCGLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:30:19 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB365434
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:14:25 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DAC283F5FD
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 11:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646651663;
        bh=tQXNtOudjM0LTFzk5N/EkuIjQfG4Mk/3HoFYyAAiDBg=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=wapJlPR4J3T5/wXbA75Dc1/4zaowNDTnjuZfSsOHInKbfOxIevMEdUAcmMSZc+7Gs
         bfXxEhJk501zCneANDmuVHzQC8XP5twxaITNn2EB0HlVt23BOeXp5DtDYrLARryJT0
         ZAOF8vQTzcIuWOUGRBYUvocas4ghvh4wLOiGD01qtsiwV2dcw0bGhMDuLwbXzsgjcR
         bgeNTqh36Oaz6+jGsTxv/TSTg2i/SVfVauIVW0amaGib5qaZGMjKr2OAk9V2CNkmwF
         PI8bbwns/z64gDX37fwbx2V4GuZBApQS5fJKYzACW+nEWFhAAda+Mah/fq6RGNgvZY
         VT8EjrOxoa3oA==
Received: by mail-ed1-f70.google.com with SMTP id y10-20020a056402358a00b00410deddea4cso8415887edc.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 03:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tQXNtOudjM0LTFzk5N/EkuIjQfG4Mk/3HoFYyAAiDBg=;
        b=dorovGjOEx4JD1H5GOkD3F8RTUaqlUK6APv0PObG95vujnCb5PY9uQRpp2dptFTmHB
         33UZxVUbMsUv0w7sg/Q85lGJeyf8r+KUG9dVcuoH/S7lnniupfHn9iOzwE0zY6sPExpP
         tqVTjynQOueyVRoKqlrZYzo/jHB/mQb7f08/cL5sx9KXBND31y+9K5KFunFmBwAjZE6g
         3xO1DZWG8bX3UKItGAhnoz9zMtx+ezhlqRXJ3xYDlxmDUYGwkNDAndOh/K/Vpk/CC5gr
         acr6k2EPROTX7Nx39dkRG593wedaUHRcugMcqXMuS7GeNhe9Z5kJtDftGsWNxRSrulR8
         nnZg==
X-Gm-Message-State: AOAM530HleyYvLMTOrAjwKSAyx5FmjBWA2hT2Ju9tDX8024MuE/ZmXP1
        RT0APsMPlikheo+Vr4smB/2FpNjeoMedlt+6h+Z5Du9exhV9N650BnAqsPwKdLroR3t1nH4jN8q
        Hzk2Gx67OOkM3+JVYGDA8Il0i+vh/2IO7yPBWEXMmQw==
X-Received: by 2002:a17:906:3a41:b0:6ce:374d:adfa with SMTP id a1-20020a1709063a4100b006ce374dadfamr8991140ejf.199.1646651661579;
        Mon, 07 Mar 2022 03:14:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx053Nebjc4td+IzjBCvG9YXfmrt1UbWFbYSMufH0B6rvz5SgmzViUi2jL+Zeu/dYpAMC+fEg==
X-Received: by 2002:a17:906:3a41:b0:6ce:374d:adfa with SMTP id a1-20020a1709063a4100b006ce374dadfamr8991042ejf.199.1646651659839;
        Mon, 07 Mar 2022 03:14:19 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id a21-20020a170906275500b006d10c07fabesm4622545ejd.201.2022.03.07.03.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 03:14:19 -0800 (PST)
Message-ID: <1e6893ca-69f4-a2ed-6ecc-23507c04002b@canonical.com>
Date:   Mon, 7 Mar 2022 12:14:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add bindings for Richtek
 RT5190A PMIC
Content-Language: en-US
To:     cy_huang <u0084500@gmail.com>, broonie@kernel.org,
        robh+dt@kernel.org
Cc:     lgirdwood@gmail.com, cy_huang@richtek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1646647704-2331-1-git-send-email-u0084500@gmail.com>
 <1646647704-2331-2-git-send-email-u0084500@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <1646647704-2331-2-git-send-email-u0084500@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 11:08, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add bindings for Richtek RT5190A PMIC.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt5190a-regulator.yaml       | 138 +++++++++++++++++++++
>  1 file changed, 138 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
> new file mode 100644
> index 00000000..b9f5836
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt5190a-regulator.yaml
> @@ -0,0 +1,138 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/richtek,rt5190a-regulator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RT5190A PMIC Regulator
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |
> +  The RT5190A integrates 1 channel buck controller, 3 channels high efficiency
> +  synchronous buck converters, 1 LDO, I2C control interface and peripherial
> +  logical control.
> +
> +  It also supports mute AC OFF depop sound and quick setting storage while
> +  input power is removed.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rt5190a
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vin2-supply:
> +    description: phandle to buck2 input voltage.
> +
> +  vin3-supply:
> +    description: phandle to buck3 input voltage.
> +
> +  vin4-supply:
> +    description: phandle to buck4 input voltage.
> +
> +  vinldo-supply:
> +    description: phandle to ldo input voltage
> +
> +  richtek,buck1-fixed-microvolt:
> +    description: buck1 fixed voltage that depends on the external resistor.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"

You should use standard bindings for it.

> +
> +  richtek,buck4-fixed-microvolt:
> +    description: buck4 fixed voltage that depends on the external resistor.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  richtek,ldo-fixed-microvolt:
> +    description: ldo fixed voltage that depends on the external resistor.
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +
> +  richtek,mute-enable:
> +    description: this can be used to enable mute function.

Please describe what is "mute" function". Your description copied
property name, so it is not useful.

> +    type: boolean
> +
> +  regulators:
> +    type: object
> +
> +    patternProperties:
> +      "^buck[1-4]$|^ldo$":
> +        type: object
> +        $ref: regulator.yaml#
> +        description: |
> +          regulator description for buck[1-4] and ldo.
> +
> +        properties:
> +          richtek,latchup-enable:
> +            type: boolean
> +            description: |
> +              If specified, undervolt protection mode changes from the default
> +              hiccup to latchup.
> +
> +        unevaluatedProperties: false
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - richtek,buck1-fixed-microvolt
> +  - richtek,buck4-fixed-microvolt
> +  - richtek,ldo-fixed-microvolt
> +  - regulators
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      rt5190a@64 {

Generic node name, so "pmic".

> +        compatible = "richtek,rt5190a";
> +        reg = <0x64>;
> +        interrupts-extended = <&gpio26 0 IRQ_TYPE_LEVEL_LOW>;
> +        vin2-supply = <&rt5190_buck1>;
> +        vin3-supply = <&rt5190_buck1>;
> +        vin4-supply = <&rt5190_buck1>;
> +        richtek,buck1-fixed-microvolt = <5090000>;
> +        richtek,buck4-fixed-microvolt = <850000>;
> +        richtek,ldo-fixed-microvolt = <1200000>;
> +
> +        regulators {
> +          rt5190_buck1: buck1 {
> +            regulator-name = "rt5190a-buck1";
> +            regulator-allowed-modes = <0 1>;

Please describe these in header file in bindings and mention as one of
regulator properties with description and enum.



Best regards,
Krzysztof
