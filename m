Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480DE561B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235206AbiF3Noc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbiF3Noa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:44:30 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB696C33;
        Thu, 30 Jun 2022 06:44:29 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id i17so12372131ils.12;
        Thu, 30 Jun 2022 06:44:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=F61ursUhOghCCvcGADpml8N5+9VOTyitVooeCIOjB9Y=;
        b=eHW+NJmgjk83Z9zFdAYVt1x1jUCcY6B4XFDgChxjKkFOnwf3ueoNF6wbLJnOLK3398
         B8Q8tfeHmsYoIxaUCwI0AjyisozXdQUr/bQ34krdJqD1jbdUASx32WFi0lDacbrqhEDk
         ME8Vr1iViAyZLzNb1Mg8S2YRTh2xQXKd0TbRsXRnCFozFC4tEoK+fsq9AdImu2kA+kdl
         rc6UdMZGmM/hWaZl7v+0bUMM//da+HeAaNnaEQKnzHVqK2HCEaejFrprjnd6gAp0PEJk
         FYPhgc8wusDneoF2WhaQEF2TCa0ckRs5D3PlI4pSZHGp/CrN1GPTpky91XngLwbVgTnb
         NrHw==
X-Gm-Message-State: AJIora+YD97Ryq3fMVaepAGXTOQ8TcFYFpbhzeoJcO2y9sMplmEr/04b
        f38+TCrGNHKoOuQEIjfc3jZVpJSmMQ==
X-Google-Smtp-Source: AGRyM1va0OfMAzdwHvSEGOAV99yEfmyc7T6+WfNApUwyVgB/zFT14suu4BOYVa6g66ClrDPB/QTk+w==
X-Received: by 2002:a05:6e02:1ba4:b0:2da:dcc1:488a with SMTP id n4-20020a056e021ba400b002dadcc1488amr910311ili.78.1656596669116;
        Thu, 30 Jun 2022 06:44:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id e42-20020a02862d000000b003316536ebc1sm4069472jai.73.2022.06.30.06.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:44:28 -0700 (PDT)
Received: (nullmailer pid 2569455 invoked by uid 1000);
        Thu, 30 Jun 2022 13:44:25 -0000
From:   Rob Herring <robh@kernel.org>
To:     "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        Ming Qian <ming.qian@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Fabio Estevam <festevam@gmail.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        linux-watchdog@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-pm@vger.kernel.org, linux-rtc@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Liu Ying <victor.liu@nxp.com>, linux-kernel@vger.kernel.org,
        Viorel Suman <viorel.suman@nxp.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Zhang Rui <rui.zhang@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220629164414.301813-3-viorel.suman@oss.nxp.com>
References: <20220629164414.301813-1-viorel.suman@oss.nxp.com> <20220629164414.301813-3-viorel.suman@oss.nxp.com>
Subject: Re: [PATCH v6 02/14] dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
Date:   Thu, 30 Jun 2022 07:44:25 -0600
Message-Id: <1656596665.734742.2569454.nullmailer@robh.at.kernel.org>
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

On Wed, 29 Jun 2022 19:44:02 +0300, Viorel Suman (OSS) wrote:
> From: Abel Vesa <abel.vesa@nxp.com>
> 
> In order to replace the fsl,scu txt file from bindings/arm/freescale,
> we need to split it between the right subsystems. This patch documents
> separately the 'iomux/pinctrl' child node of the SCU main node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
> ---
>  .../bindings/pinctrl/fsl,scu-pinctrl.yaml     | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.example.dtb: pinctrl@298c0000: lpuart5grp:fsl,pins:0: [312, 2288, 4, 3, 3, 316, 2284, 4, 3, 3] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [572, 1188, 1276, 0, 0, 320, 576, 1192, 0, 0, 0, 320] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mn-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.example.dtb: pinctrl@443c0000: uart3grp:fsl,pins:0: [72, 504, 1052, 1, 0, 73, 76, 508, 1048, 1, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx93-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [572, 1188, 1276, 0, 0, 320, 576, 1192, 0, 0, 0, 320] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mm-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.example.dtb: pinctrl@30330000: uart5grp:fsl,pins:0: [352, 976, 1812, 1, 0, 126, 356, 980, 0, 1, 0, 118] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.example.dtb: pinctrl@302c0000: gpio1-grp:fsl,pins:0: [8, 56, 0, 0, 0, 89, 12, 60, 0, 0, 0, 89] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx7d-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.example.dtb: pinctrl@30330000: uart1grp:fsl,pins:0: [564, 1180, 1268, 0, 0, 73, 568, 1184, 1268, 0, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mq-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.example.dtb: iomuxc@401f8000: lpuart1grp:fsl,pins:0: [236, 732, 0, 2, 0, 241, 240, 736, 0, 2, 0, 241] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1050.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.example.dtb: pinctrl@30330000: uart2grp:fsl,pins:0: [552, 1160, 1520, 0, 6, 73, 552, 1160, 0, 0, 0, 73] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imx8mp-pinctrl.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.example.dtb: iomuxc@400e8000: lpuart1grp:fsl,pins:0: [364, 944, 1568, 0, 0, 241, 368, 948, 1564, 0, 0, 241] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/fsl,imxrt1170.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

