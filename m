Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA64515C26
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 12:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382568AbiD3KJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 06:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382575AbiD3KJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 06:09:33 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C02D1F6
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 03:06:08 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C1EDB3F735;
        Sat, 30 Apr 2022 12:06:06 +0200 (CEST)
Date:   Sat, 30 Apr 2022 12:06:05 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20220430100605.vn4wf33mft3vdm5w@SoMainline.org>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220303214300.59468-1-bjorn.andersson@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-03 13:42:59, Bjorn Andersson wrote:
> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Apart the nits below:

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> ---
> 
> Changes since v13:
> - None
> 
> Changes since v12:
> - None
> 
>  .../bindings/leds/leds-qcom-lpg.yaml          | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> new file mode 100644
> index 000000000000..336bd8e10efd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-qcom-lpg.yaml
> @@ -0,0 +1,173 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-qcom-lpg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Light Pulse Generator
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: >
> +  The Qualcomm Light Pulse Generator consists of three different hardware blocks;
> +  a ramp generator with lookup table, the light pulse generator and a three
> +  channel current sink. These blocks are found in a wide range of Qualcomm PMICs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pm8150b-lpg
> +      - qcom,pm8150l-lpg
> +      - qcom,pm8916-pwm
> +      - qcom,pm8941-lpg
> +      - qcom,pm8994-lpg
> +      - qcom,pmc8180c-lpg
> +      - qcom,pmi8994-lpg
> +      - qcom,pmi8998-lpg
> +
> +  "#pwm-cells":
> +    const: 2
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  qcom,power-source:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      power-source used to drive the output, as defined in the datasheet.
> +      Should be specified if the TRILED block is present
> +    enum: [0, 1, 3]
> +
> +  qcom,dtest:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    description: >
> +      A list of integer pairs, where each pair represent the dtest line the
> +      particular channel should be connected to and the flags denoting how the
> +      value should be outputed, as defined in the datasheet. The number of

Nit: I think outputed is with double-t, though just using "output" here
should work as well.

> +      pairs should be the same as the number of channels.
> +    items:
> +      items:
> +        - description: dtest line to attach
> +        - description: flags for the attachment
> +
> +  multi-led:

As mentioned on IRC, doesn't this need an @[0-9a-f] designator, as
specified in leds-class-multicolor.yaml and to match `#address-cells` on
this level?  Same for the examples.

> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-9a-f]$":
> +        type: object
> +        $ref: common.yaml#

I'm not familiar enough with DT bindings - doesn't this need the
requirements for `reg` just like the identical patternProperties for
led@ below?

> +
> +patternProperties:
> +  "^led@[0-9a-f]$":
> +    type: object
> +    $ref: common.yaml#
> +
> +    properties:
> +      reg: true
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      qcom,dtest = <0 0>,
> +                   <0 0>,
> +                   <0 0>,
> +                   <4 1>;
> +
> +      led@1 {
> +        reg = <1>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        function = LED_FUNCTION_INDICATOR;
> +        function-enumerator = <1>;
> +      };
> +
> +      led@2 {
> +        reg = <2>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        function = LED_FUNCTION_INDICATOR;
> +        function-enumerator = <0>;
> +        default-state = "on";
> +      };
> +
> +      led@3 {
> +        reg = <3>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        function = LED_FUNCTION_INDICATOR;
> +        function-enumerator = <2>;
> +      };
> +
> +      led@4 {
> +        reg = <4>;
> +        color = <LED_COLOR_ID_GREEN>;
> +        function = LED_FUNCTION_INDICATOR;
> +        function-enumerator = <3>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/leds/common.h>
> +
> +    led-controller {
> +      compatible = "qcom,pmi8994-lpg";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      qcom,power-source = <1>;
> +
> +      multi-led {
> +        color = <LED_COLOR_ID_RGB>;
> +        function = LED_FUNCTION_STATUS;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        led@1 {
> +          reg = <1>;
> +          color = <LED_COLOR_ID_RED>;
> +        };
> +
> +        led@2 {
> +          reg = <2>;
> +          color = <LED_COLOR_ID_GREEN>;
> +        };
> +
> +        led@3 {
> +          reg = <3>;
> +          color = <LED_COLOR_ID_BLUE>;
> +        };
> +      };
> +    };
> +  - |
> +    pwm-controller {
> +      compatible = "qcom,pm8916-pwm";
> +      #pwm-cells = <2>;
> +    };
> +...
> -- 
> 2.33.1
> 
