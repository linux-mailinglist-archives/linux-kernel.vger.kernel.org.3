Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65655566059
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiGEAvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbiGEAvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:51:08 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFFAE0BE;
        Mon,  4 Jul 2022 17:51:04 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id a7so6398657ilj.2;
        Mon, 04 Jul 2022 17:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UNRYiUHboxd9yPgEvdNoBbUGsS1csNkOTp+t6rR1iOw=;
        b=N3+VYrqDkPY4pwojKBguJGzXP29NPhLGBxkodqPGqOGukI+ozXmtDCaRCks+sgvUCR
         DpdW5sbkdISyrjC2zPTH8sQfka1ARVDda4Uv12VDx76jjGNPKlxwIApU7VErbJHQnk1P
         udjVAR1DGNFP/bWP2HYyLOQceS91tG8dSi/LZPW93GWx4E72LLY8I9sYlZp+q0db7Eu1
         XS8JfoB6zrH02YTsa0i5vtfiphtHdO7J2TXpPhivy08h58fnHDsdaWV4v2+eIzSDpSWl
         RLu7kTpu7HdhaQGXa0l7eoNdrFpTzH6c3BcimsyUvqNBKkBoyL7+OHAksJs+jhQuAX4r
         APzA==
X-Gm-Message-State: AJIora/uR3E3745p6NYMvneRC+wseI1pmvGC+Me/sQe+1x3ApE7+wlyh
        9kTB91we3e75Wr+0y/3Ciw==
X-Google-Smtp-Source: AGRyM1tS8v3PEUEp2o1+Ur7pauJQIS26mvX+Hsl3rcFPHzkKRTm2fuynyCuuK1DgeB/T2XOG7W4mdg==
X-Received: by 2002:a05:6e02:1a29:b0:2da:9310:a5fa with SMTP id g9-20020a056e021a2900b002da9310a5famr18049069ile.179.1656982263375;
        Mon, 04 Jul 2022 17:51:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id y10-20020a92090a000000b002dc11cf02e0sm1719265ilg.20.2022.07.04.17.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 17:51:02 -0700 (PDT)
Received: (nullmailer pid 640440 invoked by uid 1000);
        Tue, 05 Jul 2022 00:50:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     linux-clk@vger.kernel.org, Abel Vesa <abelvesa@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Amit Kucheria <amitk@kernel.org>, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        linux-watchdog@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Abel Vesa <abel.vesa@nxp.com>, Stefan Agner <stefan@agner.ch>,
        devicetree@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ming Qian <ming.qian@nxp.com>, Zhang Rui <rui.zhang@intel.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-input@vger.kernel.org,
        Oliver Graute <oliver.graute@kococonnector.com>
In-Reply-To: <20220704161541.943696-3-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com> <20220704161541.943696-3-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH v7 02/15] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Mon, 04 Jul 2022 18:50:55 -0600
Message-Id: <1656982255.094130.640439.nullmailer@robh.at.kernel.org>
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

On Mon, 04 Jul 2022 19:15:28 +0300, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'iomux/pinctrl' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/arm/freescale/fsl,scu.txt        | 40 ----------
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 74 +++++++++++++++++++
>  2 files changed, 74 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.example.dtb: iomuxc@400e8000: lpuart1grp:fsl,pins:0: [364, 944, 1568, 0, 0, 241, 368, 948, 1564, 0, 0, 241] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.example.dtb: pinctrl: lpuart0grp:fsl,pins:0: [111, 0, 100663328, 112, 0, 100663328] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.example.dtb: pinctrl@443c0000: uart3grp:fsl,pins:0: [72, 504, 1052, 1, 0, 73, 76, 508, 1048, 1, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.example.dtb: pinctrl@30330000: uart5grp:fsl,pins:0: [352, 976, 1812, 1, 0, 126, 356, 980, 0, 1, 0, 118] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.example.dtb: pinctrl@302c0000: gpio1-grp:fsl,pins:0: [8, 56, 0, 0, 0, 89, 12, 60, 0, 0, 0, 89] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.example.dtb: iomuxc@401f8000: lpuart1grp:fsl,pins:0: [236, 732, 0, 2, 0, 241, 240, 736, 0, 2, 0, 241] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [572, 1188, 1276, 0, 0, 320, 576, 1192, 0, 0, 0, 320] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.example.dtb: pinctrl@30330000: uart1grp:fsl,pins:0: [564, 1180, 1268, 0, 0, 73, 568, 1184, 1268, 0, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [572, 1188, 1276, 0, 0, 320, 576, 1192, 0, 0, 0, 320] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [552, 1160, 1520, 0, 6, 73, 552, 1160, 0, 0, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

