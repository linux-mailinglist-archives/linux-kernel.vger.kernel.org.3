Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFE568B5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiGFOhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGFOhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:37:06 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0149022511;
        Wed,  6 Jul 2022 07:37:03 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id r133so14177222iod.3;
        Wed, 06 Jul 2022 07:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BO6eBhC7unEc5DAXkBz59T47rbusdIS+hGohLImKruE=;
        b=QKJcI6Bp0B1eSaw6DDpE2N/PfwBMZcWH4b9q4+dWtH9UGM6uJMhF16yeh7nJqDdkzq
         sZi8i0Z7FZqlmGOLA9UJitHnjiqsooO9Z47uohW3LNmnGQXf848j4rRN/WJYueSGsUtk
         YJ03ojbBdp6Jz4rHZMres3hTSJwJsy8i1zOhepXz45l+yUhWO2uYCchf8j9zIhjP4dju
         0NnSrz5J5Bt56mN2NllhCX6fEEPs8ObZrs2MM0D8m3Q/udiBwFTmSnvnp23XgfM0CEm9
         H3LQAvngufkKodbP3VBc1YnDPpjoCSRNBLV7Ng057/aKEmuTdQitSbKp/aKDphDiDXnZ
         1yWw==
X-Gm-Message-State: AJIora8eAgZq1x2Q/3ZsHXPaM2aBkLX6QvPe/U9QTeD2o26fVqYN9TAE
        spJG6XzDBR7NRlIUXdYjEQ==
X-Google-Smtp-Source: AGRyM1uwogNqbjjsWF2UgQe/CajDfMiG+sh6Ni2OjP0BX9xF2QmOazErflXLRz0+SMeIhacevi0Dxg==
X-Received: by 2002:a05:6638:491a:b0:33e:f73f:b138 with SMTP id cx26-20020a056638491a00b0033ef73fb138mr4759038jab.21.1657118222100;
        Wed, 06 Jul 2022 07:37:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g18-20020a05663810f200b00339d5108b60sm15982358jae.17.2022.07.06.07.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:37:01 -0700 (PDT)
Received: (nullmailer pid 5054 invoked by uid 1000);
        Wed, 06 Jul 2022 14:36:58 -0000
Date:   Wed, 6 Jul 2022 08:36:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v7 09/15] dt-bindings: firmware: Add fsl,scu yaml file
Message-ID: <20220706143658.GA4191302-robh@kernel.org>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
 <20220704161541.943696-10-viorel.suman@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704161541.943696-10-viorel.suman@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 07:15:35PM +0300, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch adds the
> fsl,scu.yaml in the firmware bindings folder. This one is only for
> the main SCU node. The old txt file will be removed only after all
> the child nodes have been properly switch to yaml.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu.txt        |  96 -----------
>  .../devicetree/bindings/firmware/fsl,scu.yaml | 160 ++++++++++++++++++
>  2 files changed, 160 insertions(+), 96 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
>  create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> deleted file mode 100644
> index e1cc72741f1f..000000000000
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ /dev/null
> @@ -1,96 +0,0 @@
> -NXP i.MX System Controller Firmware (SCFW)
> ---------------------------------------------------------------------
> -
> -The System Controller Firmware (SCFW) is a low-level system function
> -which runs on a dedicated Cortex-M core to provide power, clock, and
> -resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> -(QM, QP), and i.MX8QX (QXP, DX).
> -
> -The AP communicates with the SC using a multi-ported MU module found
> -in the LSIO subsystem. The current definition of this MU module provides
> -5 remote AP connections to the SC to support up to 5 execution environments
> -(TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
> -with the LSIO DSC IP bus. The SC firmware will communicate with this MU
> -using the MSI bus.
> -
> -System Controller Device Node:
> -============================================================
> -
> -The scu node with the following properties shall be under the /firmware/ node.
> -
> -Required properties:
> --------------------
> -- compatible:	should be "fsl,imx-scu".
> -- mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
> -			       "rx0", "rx1", "rx2", "rx3";
> -		include "gip3" if want to support general MU interrupt.
> -- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
> -		rx, and 1 optional MU channel for general interrupt.
> -		All MU channels must be in the same MU instance.
> -		Cross instances are not allowed. The MU instance can only
> -		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> -		to make sure use the one which is not conflict with other
> -		execution environments. e.g. ATF.
> -		Note:
> -		Channel 0 must be "tx0" or "rx0".
> -		Channel 1 must be "tx1" or "rx1".
> -		Channel 2 must be "tx2" or "rx2".
> -		Channel 3 must be "tx3" or "rx3".
> -		General interrupt rx channel must be "gip3".
> -		e.g.
> -		mboxes = <&lsio_mu1 0 0
> -			  &lsio_mu1 0 1
> -			  &lsio_mu1 0 2
> -			  &lsio_mu1 0 3
> -			  &lsio_mu1 1 0
> -			  &lsio_mu1 1 1
> -			  &lsio_mu1 1 2
> -			  &lsio_mu1 1 3
> -			  &lsio_mu1 3 3>;
> -		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
> -		for detailed mailbox binding.
> -
> -Note: Each mu which supports general interrupt should have an alias correctly
> -numbered in "aliases" node.
> -e.g.
> -aliases {
> -	mu1 = &lsio_mu1;
> -};
> -
> -i.MX SCU Client Device Node:
> -============================================================
> -
> -Client nodes are maintained as children of the relevant IMX-SCU device node.
> -
> -Example (imx8qxp):
> --------------
> -aliases {
> -	mu1 = &lsio_mu1;
> -};
> -
> -lsio_mu1: mailbox@5d1c0000 {
> -	...
> -	#mbox-cells = <2>;
> -};
> -
> -firmware {
> -	scu {
> -		compatible = "fsl,imx-scu";
> -		mbox-names = "tx0", "tx1", "tx2", "tx3",
> -			     "rx0", "rx1", "rx2", "rx3",
> -			     "gip3";
> -		mboxes = <&lsio_mu1 0 0
> -			  &lsio_mu1 0 1
> -			  &lsio_mu1 0 2
> -			  &lsio_mu1 0 3
> -			  &lsio_mu1 1 0
> -			  &lsio_mu1 1 1
> -			  &lsio_mu1 1 2
> -			  &lsio_mu1 1 3
> -			  &lsio_mu1 3 3>;
> -	};
> -};
> -
> -serial@5a060000 {
> -	...
> -};
> diff --git a/Documentation/devicetree/bindings/firmware/fsl,scu.yaml b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> new file mode 100644
> index 000000000000..c1f5b727352e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/fsl,scu.yaml
> @@ -0,0 +1,160 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/fsl,scu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX System Controller Firmware (SCFW)
> +
> +maintainers:
> +  - Dong Aisheng <aisheng.dong@nxp.com>
> +
> +description: System Controller Device Node

The formatting here is not maintained unless you use a literal block 
('|'). But I would just drop this first line.

> +  The System Controller Firmware (SCFW) is a low-level system function
> +  which runs on a dedicated Cortex-M core to provide power, clock, and
> +  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
> +  (QM, QP), and i.MX8QX (QXP, DX).
> +  The AP communicates with the SC using a multi-ported MU module found
> +  in the LSIO subsystem. The current definition of this MU module provides
> +  5 remote AP connections to the SC to support up to 5 execution environments
> +  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
> +  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
> +  using the MSI bus.
> +
> +properties:
> +  compatible:
> +    const: fsl,imx-scu
> +
> +  clock-controller:
> +    description:
> +      Clock controller node that provides the clocks controlled by the SCU
> +    $ref: /schemas/clock/fsl,scu-clk.yaml
> +
> +  ocotp:
> +    description:
> +      OCOTP controller node provided by the SCU
> +    $ref: /schemas/nvmem/fsl,scu-ocotp.yaml
> +
> +  keys:
> +    description:
> +      Keys provided by the SCU
> +    $ref: /schemas/input/fsl,scu-key.yaml
> +
> +  mboxes:
> +    description: |
> +      List of phandle of 4 MU channels for tx, 4 MU channels for
> +      rx, and 1 optional MU channel for general interrupt.
> +      All MU channels must be in the same MU instance.
> +      Cross instances are not allowed. The MU instance can only
> +      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
> +      to make sure use the one which is not conflict with other
> +      execution environments. e.g. ATF.
> +    minItems: 1
> +    maxItems: 10

Based on the description, shouldn't this be:

minItems: 8
maxItems: 9

> +
> +  mbox-names:
> +    description:
> +      include "gip3" if want to support general MU interrupt.

What are all the other names? Needs to be a schema, not freeform text.

> +    minItems: 1
> +    maxItems: 10
> +
> +  pinctrl:
> +    description:
> +      Pin controller provided by the SCU
> +    $ref: /schemas/pinctrl/fsl,scu-pinctrl.yaml
> +
> +  power-controller:
> +    description: |
> +      Power domains controller node that provides the power domains
> +      controlled by the SCU
> +    $ref: /schemas/power/fsl,scu-pd.yaml
> +
> +  rtc:
> +    description:
> +      RTC controller provided by the SCU
> +    $ref: /schemas/rtc/fsl,scu-rtc.yaml
> +
> +  thermal-sensor:
> +    description:
> +      Thermal sensor provided by the SCU
> +    $ref: /schemas/thermal/fsl,scu-thermal.yaml
> +
> +  watchdog:
> +    description:
> +      Watchdog controller provided by the SCU
> +    $ref: /schemas/watchdog/fsl,scu-wdt.yaml
> +
> +required:
> +  - compatible
> +  - mbox-names
> +  - mboxes
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/firmware/imx/rsrc.h>
> +    #include <dt-bindings/input/input.h>
> +    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
> +
> +    firmware {
> +        system-controller {
> +            compatible = "fsl,imx-scu";
> +            mbox-names = "tx0", "tx1", "tx2", "tx3",
> +                         "rx0", "rx1", "rx2", "rx3",
> +                         "gip3";
> +            mboxes = <&lsio_mu1 0 0 &lsio_mu1 0 1 &lsio_mu1 0 2 &lsio_mu1 0 3
> +                      &lsio_mu1 1 0 &lsio_mu1 1 1 &lsio_mu1 1 2 &lsio_mu1 1 3
> +                      &lsio_mu1 3 3>;
> +
> +            clock-controller {
> +                compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
> +                #clock-cells = <2>;
> +            };
> +
> +            pinctrl {
> +                compatible = "fsl,imx8qxp-iomuxc";
> +
> +                pinctrl_lpuart0: lpuart0grp {
> +                    fsl,pins = <
> +                        IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
> +                        IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
> +                    >;
> +                };
> +            };
> +
> +            ocotp {
> +                compatible = "fsl,imx8qxp-scu-ocotp";
> +                #address-cells = <1>;
> +                #size-cells = <1>;
> +
> +                fec_mac0: mac@2c4 {
> +                    reg = <0x2c4 6>;
> +                };
> +            };
> +
> +            power-controller {
> +                compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
> +                #power-domain-cells = <1>;
> +            };
> +
> +            rtc {
> +                compatible = "fsl,imx8qxp-sc-rtc";
> +            };
> +
> +            keys {
> +                compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
> +                linux,keycodes = <KEY_POWER>;
> +            };
> +
> +            watchdog {
> +                compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
> +                timeout-sec = <60>;
> +            };
> +
> +            thermal-sensor {
> +                compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
> +                #thermal-sensor-cells = <1>;
> +            };
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
