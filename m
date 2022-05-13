Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB5C5261FB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380290AbiEMMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380288AbiEMMdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:31 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E127866AC3;
        Fri, 13 May 2022 05:33:27 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-ed9ac77cbbso10350761fac.1;
        Fri, 13 May 2022 05:33:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lUdxUmoC6AyHdkcWvdx9VlKPC81VZH+h60hTT3amCoQ=;
        b=473rBQlWKkYrhr0mMwoXfjMU4uOiMjj+BAOaEgMV3cu9Ehv2Luvxbh+Zdw6dl0IuJX
         v0w5XUegLUH+URDuZl/Ql5Z9P6mySElg0vyoPwvwD12QB13rQAprdYCMxLMdR9cQE+mL
         xrEOFG4xPVaNqS8ESaHLMg4ZoenXY/bmgWAB07i99Sf0Mx+CygsSg7RWinex6lXAv0nG
         T7PzHY6VGBp0ruQ5AZPU7VIMjaXYHRAXG784ds3yJ9iC1dx1skf1/V62m2f24gZP5YLZ
         9jUQQi8iYTTlgGz8IXBu/e0zcjNekcal4lziwmx8L5anXB6BBqErh+dlJ4TdsR+wvjL6
         7SEw==
X-Gm-Message-State: AOAM530t41cevYMhPXohAQUTONfrSisVTqa2IcMSjk3gcuxoUTBcTR2f
        e6N60+xdC8K654Gq+DSJfQ==
X-Google-Smtp-Source: ABdhPJwW9fYS1IRmER3P/d4RWEBAga2b8rGnX2iOmbkJwYsghlIR0DqRwVLq0v5qyLEMKEsVapgaZQ==
X-Received: by 2002:a05:6870:b492:b0:ed:b309:a71d with SMTP id y18-20020a056870b49200b000edb309a71dmr7765171oap.201.1652445205234;
        Fri, 13 May 2022 05:33:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s7-20020a056870630700b000e686d13887sm1281oao.33.2022.05.13.05.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:24 -0700 (PDT)
Received: (nullmailer pid 85847 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, ashishsingha@nvidia.com,
        skomatineni@nvidia.com, jonathanh@nvidia.com, ldewangan@nvidia.com,
        linux-tegra@vger.kernel.org, robh+dt@kernel.org,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, thierry.reding@gmail.com
In-Reply-To: <20220513080828.22079-3-kyarlagadda@nvidia.com>
References: <20220513080828.22079-1-kyarlagadda@nvidia.com> <20220513080828.22079-3-kyarlagadda@nvidia.com>
Subject: Re: [Patch V2 2/3] spi: dt-bindings: split peripheral prods
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.099165.85846.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2022 13:38:27 +0530, Krishna Yarlagadda wrote:
> Move peripheral properties for Tegra QSPI controller to
> nvidia,tegra210-quad-peripheral-props.yaml and add reference
> to spi-peripheral-props.yaml file.
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  ...nvidia,tegra210-quad-peripheral-props.yaml | 45 +++++++++++++++++++
>  .../bindings/spi/nvidia,tegra210-quad.yaml    | 32 -------------
>  .../bindings/spi/spi-peripheral-props.yaml    |  1 +
>  3 files changed, 46 insertions(+), 32 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/spi/nvidia,tegra210-quad-peripheral-props.yaml:42:7: [warning] wrong indentation: expected 2 but found 6 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.example.dtb: spi: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'm25p,fast-read', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.example.dtb: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'm25p,fast-read', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dtb: spi: flash@0: Unevaluated properties are not allowed ('compatible', 'label' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'label' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dtb: spi: flash@0: Unevaluated properties are not allowed ('compatible', 'otp-1', 'otp-2' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mtd.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'otp-1', 'otp-2' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/microchip,mchp48l640.example.dtb: spi: eeram@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.example.dtb: spi@c1108c80: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.example.dtb: spi@c1108c80: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.example.dtb: spi@c1108c80: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson6-spifc.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: flash@0: Unevaluated properties are not allowed ('compatible', 'nand-ecc-engine' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: flash@0: Unevaluated properties are not allowed ('compatible', 'nand-ecc-engine' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: flash@0: Unevaluated properties are not allowed ('compatible', 'nand-ecc-engine' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: flash@0: Unevaluated properties are not allowed ('compatible', 'nand-ecc-engine' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/mxicy,nand-ecc-engine.example.dtb: spi@43c30000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dtb: spi@88df000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dtb: spi@88df000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dtb: spi@88df000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.example.dtb: spi@1550000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.example.dtb: spi@1550000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.example.dtb: spi@1550000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dtb: spi@ff705000: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dtb: spi@ff705000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dtb: spi@ff705000: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,qspi-nor.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.example.dtb: spi@c1108d80: display@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.example.dtb: spi@c1108d80: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.example.dtb: spi@c1108d80: display@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dtb: spi@58003000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dtb: spi@58003000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dtb: spi@58003000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/st,stm32-qspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0:spi-rx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0:spi-tx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'spi-rx-bus-width', 'spi-tx-bus-width' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0:spi-rx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0:spi-tx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: spi@20c0000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'spi-rx-bus-width', 'spi-tx-bus-width' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: flash@0: spi-rx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: flash@0: spi-tx-bus-width:0:0: 8 is not one of [1, 2, 4]
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-nxp-fspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'spi-rx-bus-width', 'spi-tx-bus-width' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: display@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: sensor@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: flash@2:reg: [[2], [3]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: flash@2: Unevaluated properties are not allowed ('compatible', 'reg', 'spi-max-frequency', 'stacked-memories' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'display@0', 'flash@2', 'sensor@1' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mxs-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: display@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: sensor@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: flash@2:reg: [[2], [3]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: spi@80010000: flash@2: Unevaluated properties are not allowed ('compatible', 'reg', 'spi-max-frequency', 'stacked-memories' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: flash@2: reg: [[2], [3]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.example.dtb: flash@2: Unevaluated properties are not allowed ('compatible', 'reg', 'spi-max-frequency', 'stacked-memories' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dtb: spi@70410000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dtb: spi@70410000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dtb: spi@70410000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'reg' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@f03e3400: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@f03e3400: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@f03e3400: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@66470200: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@66470200: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0', 'num-cs' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/brcm,spi-bcm-qspi.example.dtb: spi@66470200: flash@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi: spi@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'flash@0', 'mux-controls', 'sensor@1', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: sensor@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: sensor@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'flash@0', 'mux-controls', 'sensor@1', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: spi@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0', 'reg', 'sensor@1', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-mux.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: m25p80@1: Unevaluated properties are not allowed ('compatible', 'pl022,com-mode', 'pl022,ctrl-len', 'pl022,duplex', 'pl022,interface', 'pl022,rx-level-trig', 'pl022,tx-level-trig', 'pl022,wait-state', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: m25p80@1: Unevaluated properties are not allowed ('compatible', 'pl022,com-mode', 'pl022,ctrl-len', 'pl022,duplex', 'pl022,interface', 'pl022,rx-level-trig', 'pl022,tx-level-trig', 'pl022,wait-state', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dtb: spi@e0100000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/samsung,spi.example.dtb: spi@14d30000: audio-codec@0: Unevaluated properties are not allowed ('#gpio-cells', '#interrupt-cells', 'AVDD-supply', 'CPVDD-supply', 'DBVDD1-supply', 'DBVDD2-supply', 'DBVDD3-supply', 'SPKVDDL-supply', 'SPKVDDR-supply', 'clock-names', 'clocks', 'compatible', 'controller-data', 'gpio-controller', 'interrupt-controller', 'interrupts', 'spi-max-frequency', 'wlf,gpsw', 'wlf,hpdet-channel', 'wlf,inmode', 'wlf,ldoena', 'wlf,micd-bias-start-time', 'wlf,micd-configs', 'wlf,micd-dbtime', 'wlf,micd-detect-debounce', 'wlf,micd-force-micbias', 'wlf,micd-rate', 'wlf,reset' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/samsung,spi.example.dtb: spi@14d30000: audio-codec@0: Unevaluated properties are not allowed ('#gpio-cells', '#interrupt-cells', 'AVDD-supply', 'CPVDD-supply', 'DBVDD1-supply', 'DBVDD2-supply', 'DBVDD3-supply', 'SPKVDDL-supply', 'SPKVDDR-supply', 'clock-names', 'clocks', 'compatible', 'controller-data', 'gpio-controller', 'interrupt-controller', 'interrupts', 'spi-max-frequency', 'wlf,gpsw', 'wlf,hpdet-channel', 'wlf,inmode', 'wlf,ldoena', 'wlf,micd-bias-start-time', 'wlf,micd-configs', 'wlf,micd-dbtime', 'wlf,micd-detect-debounce', 'wlf,micd-force-micbias', 'wlf,micd-rate', 'wlf,reset' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/samsung,spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/samsung,spi.example.dtb: spi@14d30000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'audio-codec@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/samsung,spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dtb: spi@ff3a0000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dtb: spi@ff3a0000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dtb: spi@ff3a0000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/rockchip-sfc.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dtb: spi@fff00000: flash@1: Unevaluated properties are not allowed ('compatible', 'rx-sample-delay-ns' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dtb: spi@fff00000: flash@1: Unevaluated properties are not allowed ('compatible', 'rx-sample-delay-ns' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.example.dtb: spi@fff00000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'cs-gpios' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb: spi@1100d000: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb: spi@1100d000: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb: spi@1100d000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-mtk-nor.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.example.dtb: spi@f0020000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.example.dtb: spi@f0020000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.example.dtb: spi@f0020000: Unevaluated properties are not allowed ('flash@0' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/atmel,quadspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: spi@a0010000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: spi@a0010000: flash@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: spi@a0010000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: spi@a0010000: flash@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: spi@a0010000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'flash@0', 'flash@1' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/cdns,xspi.example.dtb: flash@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.example.dtb: spi: wifi@0: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible', 'enable-gpios', 'interrupts', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/micrel,ks8851.example.dtb: spi: ethernet@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'reset-gpios', 'vdd-io-supply', 'vdd-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/nfc/marvell,nci.example.dtb: spi: nfc@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'reset-n-io', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/nfc/st,st-nci.example.dtb: spi: nfc@0: Unevaluated properties are not allowed ('compatible', 'ese-present', 'interrupts', 'reset-gpios', 'spi-max-frequency', 'uicc-present' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/nfc/st,st95hf.example.dtb: spi: nfc@0: Unevaluated properties are not allowed ('compatible', 'enable-gpio', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.example.dtb: spi: ethernet-switch@1: Unevaluated properties are not allowed ('compatible', 'ethernet-ports' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/davicom,dm9051.example.dtb: spi: ethernet@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'local-mac-address', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/regulator/google,cros-ec-regulator.example.dtb: ec@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'regulator@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/gpio/fairchild,74hc595.example.dtb: spi: gpio5@0: Unevaluated properties are not allowed ('#gpio-cells', 'compatible', 'gpio-controller', 'registers-number', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dtb: spi@ee200000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dtb: spi@ee200000: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dtb: spi@ee200000: Unevaluated properties are not allowed ('#address-cells', '#size-cells' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.example.dtb: flash@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/extcon/extcon-usbc-cros-ec.example.dtb: cros-ec@0: Unevaluated properties are not allowed ('compatible', 'extcon0', 'extcon1' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/adi,ltc2947.example.dtb: spi: ltc2947@0: Unevaluated properties are not allowed ('adi,accumulator-ctl-pol', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.example.dtb: spi: display@0: Unevaluated properties are not allowed ('compatible', 'iovcc-supply', 'port', 'vcc-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.example.dtb: display@0: Unevaluated properties are not allowed ('compatible', 'iovcc-supply', 'port', 'vcc-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9322.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dtb: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/abt,y030xx067a.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.example.dtb: spi: display@0: Unevaluated properties are not allowed ('compatible', 'port', 'reset-gpios', 'spi-max-frequency', 'vci-supply', 'vdd3-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.example.dtb: display@0: Unevaluated properties are not allowed ('compatible', 'port', 'reset-gpios', 'spi-max-frequency', 'vci-supply', 'vdd3-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dtb: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms397kf04.example.dtb: spi: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'panel@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/tpo,td.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'label', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/tpo,td.example.dtb: panel@0: Unevaluated properties are not allowed ('compatible', 'label', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/tpo,td.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sony,acx565akm.example.dtb: spi: panel@2: Unevaluated properties are not allowed ('compatible', 'label', 'port', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sony,acx565akm.example.dtb: panel@2: Unevaluated properties are not allowed ('compatible', 'label', 'port', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/sony,acx565akm.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9163.example.dtb: spi: display@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'dc-gpios', 'reset-gpios', 'rotation', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-3wire', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.example.dtb: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-3wire', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,ld9040.example.dtb: spi: lcd@0: Unevaluated properties are not allowed ('compatible', 'display-timings', 'panel-height-mm', 'panel-width-mm', 'port', 'power-on-delay', 'reset-delay', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vci-supply', 'vdd3-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,ld9040.example.dtb: lcd@0: Unevaluated properties are not allowed ('compatible', 'display-timings', 'panel-height-mm', 'panel-width-mm', 'port', 'power-on-delay', 'reset-delay', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vci-supply', 'vdd3-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,ld9040.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.example.dtb: spi: display@0: Unevaluated properties are not allowed ('compatible', 'dc-gpios', 'port', 'spi-3wire', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/lg,lg4573.example.dtb: spi: display@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/tpo,tpg110.example.dtb: spi: display@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'grestb-gpios', 'height-mm', 'port', 'spi-3wire', 'spi-max-frequency', 'width-mm' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'enable-gpios', 'label', 'port', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.example.dtb: panel@0: Unevaluated properties are not allowed ('compatible', 'enable-gpios', 'label', 'port', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.example.dtb: spi: display@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'dc-gpios', 'height-mm', 'panel-timing', 'reset-gpios', 'spi-max-frequency', 'width-mm', 'write-only' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.example.dtb: display@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'dc-gpios', 'height-mm', 'panel-timing', 'reset-gpios', 'spi-max-frequency', 'width-mm', 'write-only' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,s6d27a1.example.dtb: spi: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'panel@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/innolux,ej030na.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/innolux,ej030na.example.dtb: panel@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'port', 'power-supply', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/innolux,ej030na.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.example.dtb: spi: panel@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'port', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vccio-supply', 'vci-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/panel/samsung,lms380kf01.example.dtb: spi: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'panel@0' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-gpio.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/ilitek,ili9486.example.dtb: spi: display@0: Unevaluated properties are not allowed ('backlight', 'compatible', 'dc-gpios', 'reset-gpios', 'rotation', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/display/sitronix,st7735r.example.dtb: spi: display@0: Unevaluated properties are not allowed ('compatible', 'dc-gpios', 'reset-gpios', 'rotation', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.example.dtb: ec@0: Unevaluated properties are not allowed ('compatible', 'typec' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/eeprom-93xx46.example.dtb: spi: eeprom@0: Unevaluated properties are not allowed ('compatible', 'data-size', 'select-gpios', 'spi-cs-high', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dtb: spi: spi@1:reg: [[1], [0]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/ge-achc.example.dtb: spi: spi@1: Unevaluated properties are not allowed ('clocks', 'compatible', 'reg', 'reset-gpios' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/i2c/google,cros-ec-i2c-tunnel.example.dtb: cros-ec@0: Unevaluated properties are not allowed ('compatible', 'i2c-tunnel', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/wlf,wm8978.example.dtb: spi: codec@0: Unevaluated properties are not allowed ('#sound-dai-cells', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/cirrus,cs35l41.example.dtb: spi: cs35l41@2: Unevaluated properties are not allowed ('#sound-dai-cells', 'VA-supply', 'VP-supply', 'cirrus,boost-cap-microfarad', 'cirrus,boost-ind-nanohenry', 'cirrus,boost-peak-milliamp', 'compatible', 'reset-gpios' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dtb: spi: cros-ec@0: Unevaluated properties are not allowed ('codecs', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dtb: cros-ec@0: Unevaluated properties are not allowed ('codecs', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/adi,adau1977.example.dtb: spi: adau1977@0: Unevaluated properties are not allowed ('AVDD-supply', 'DVDD-supply', 'adi,micbias', 'compatible', 'reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/staging/net/wireless/silabs,wfx.example.dtb: spi: wifi@0: Unevaluated properties are not allowed ('compatible', 'interrupts-extended', 'reset-gpios', 'spi-max-frequency', 'wakeup-gpios' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/maxim,max31856.example.dtb: spi: temp-sensor@0: Unevaluated properties are not allowed ('compatible', 'spi-cpha', 'spi-max-frequency', 'thermocouple-type' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/maxim,max31865.example.dtb: spi: temp_sensor@0: Unevaluated properties are not allowed ('compatible', 'maxim,3-wire', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.example.dtb: spi: temp-sensor@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/maxim,max31855k.example.dtb: spi: temp-sensor@1: Unevaluated properties are not allowed ('compatible', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.example.dtb: spi: ltc2983@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adc@10', 'compatible', 'diode@5', 'interrupts', 'rsense@2', 'rtd@14', 'thermistor@12', 'thermocouple@18', 'thermocouple@20' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/filter/adi,admv8818.example.dtb: spi: admv8818@0: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/imu/adi,adis16480.example.dtb: spi: imu@0: Unevaluated properties are not allowed ('adi,ext-clk-pin', 'clock-names', 'clocks', 'compatible', 'interrupt-names', 'interrupts', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/imu/bosch,bmi160.example.dtb: spi: bmi160@0: Unevaluated properties are not allowed ('compatible', 'interrupt-names', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/imu/adi,adis16475.example.dtb: spi: adis16475-3@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/health/ti,afe4403.example.dtb: spi: heart_mon@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'reset-gpios', 'spi-max-frequency', 'tx-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.example.dtb: spi: gyro@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/samsung,sensorhub-rinato.example.dtb: spi: sensorhub@0: Unevaluated properties are not allowed ('ap-mcu-gpios', 'compatible', 'interrupts', 'mcu-ap-gpios', 'mcu-reset-gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.example.dtb: spi: ad74413r@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'compatible', 'interrupts', 'refin-supply', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/afe/voltage-divider.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/amplifiers/adi,ada4250.example.dtb: spi: amplifier@0: Unevaluated properties are not allowed ('avdd-supply', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/st,st-sensors.example.dtb: spi: gyroscope@0: Unevaluated properties are not allowed ('compatible', 'st,drdy-int-pin', 'vdd-supply', 'vddio-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp41010.example.dtb: spi: potentiometer@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/potentiometer/microchip,mcp4131.example.dtb: spi: potentiometer@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/resolver/adi,ad2s90.example.dtb: spi: resolver@0: Unevaluated properties are not allowed ('compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5761.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5449.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('VREF-supply', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5449.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('VREFA-supply', 'VREFB-supply', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5770r.example.dtb: spi: ad5770r@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adi,external-resistor', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'channel@4', 'channel@5', 'compatible', 'reset-gpios', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac7311.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5624r.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad8801.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vrefh-supply', 'vrefl-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad7303.example.dtb: spi: dac@4: Unevaluated properties are not allowed ('REF-supply', 'Vdd-supply', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/microchip,mcp4922.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5064.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5064.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5504.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'vcc-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ltc2688.example.dtb: spi: ltc2688@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@1', 'compatible', 'iovcc-supply', 'vcc-supply', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5686.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vcc-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5791.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vdd-supply', 'vss-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dtb: spi: ad3552r@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@1', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5766.example.dtb: spi: ad5766@0: Unevaluated properties are not allowed ('compatible', 'output-range-microvolts', 'reset-gpios', 'spi-cpol', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5421.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac7512.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad7293.example.dtb: spi: ad7293@0: Unevaluated properties are not allowed ('avdd-supply', 'compatible', 'reset-gpios', 'spi-max-frequency', 'vdrive-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5360.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref0-supply', 'vref1-supply', 'vref2-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5380.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac082s085.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'spi-cpol', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: spi: addac@0: Unevaluated properties are not allowed ('#address-cells', '#gpio-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'channel@4', 'channel@5', 'channel@6', 'channel@7', 'compatible', 'gpio-controller', 'reset-gpios', 'spi-cpol', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5592r.example.dtb: spi: ad5593r@10: Unevaluated properties are not allowed ('#address-cells', '#gpio-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@6', 'compatible', 'gpio-controller' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5758.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('adi,dc-dc-ilim-microamp', 'adi,dc-dc-mode', 'adi,range-microvolt', 'adi,slew-time-us', 'compatible', 'reset-gpios', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/ti,dac7612.example.dtb: spi: dac@1: Unevaluated properties are not allowed ('compatible', 'ti,loaddacs-gpios' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5755.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adi,dc-dc-freq-hz', 'adi,dc-dc-max-microvolt', 'adi,dc-dc-phase', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'compatible', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/adi,ad5764.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'vrefAB-supply', 'vrefCD-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.example.dtb: spi: dac@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,adrf6780.example.dtb: spi: adrf6780@0: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv1014.example.dtb: spi: converter@0: Unevaluated properties are not allowed ('adi,detector-enable', 'adi,p1db-compensation-enable', 'adi,quad-se-mode', 'clock-names', 'clocks', 'compatible', 'spi-max-frequency', 'vcc-bg-supply', 'vcc-if-bb-supply', 'vcc-lna-1p5-supply', 'vcc-lna-3p3-supply', 'vcc-mixer-supply', 'vcc-quad-supply', 'vcc-vga-supply', 'vcc-vva-supply', 'vcm-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,adf4350.example.dtb: spi: pll@4: Unevaluated properties are not allowed ('adi,channel-spacing', 'adi,charge-pump-current', 'adi,mute-till-lock-enable', 'adi,output-power', 'adi,phase-detector-polarity-positive-enable', 'adi,power-up-frequency', 'clock-names', 'clocks', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv4420.example.dtb: spi: mixer@0: Unevaluated properties are not allowed ('adi,lo-freq-khz', 'adi,ref-ext-single-ended-en', 'compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/frequency/adi,admv1013.example.dtb: spi: admv1013@0: Unevaluated properties are not allowed ('adi,detector-enable', 'adi,quad-se-mode', 'clock-names', 'clocks', 'compatible', 'spi-max-frequency', 'vcm-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl313.example.dtb: spi: accelerometer@0: Unevaluated properties are not allowed ('compatible', 'interrupt-names', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl367.example.dtb: spi: accelerometer@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/adi,adxl355.example.dtb: spi: accelerometer@0: Unevaluated properties are not allowed ('compatible', 'interrupt-names', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/murata,sca3300.example.dtb: spi: accelerometer@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/fsl,mma7455.example.dtb: spi: accelerometer@0: Unevaluated properties are not allowed ('avdd-supply', 'compatible', 'interrupt-names', 'interrupts', 'spi-max-frequency', 'vddio-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bma255.example.dtb: spi: accel@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/bosch,bmi088.example.dtb: spi: bmi088-accel@1: Unevaluated properties are not allowed ('compatible', 'interrupt-names', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/accel/kionix,kxsd9.example.dtb: spi: accel@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/proximity/ams,as3935.example.dtb: spi: lightning@0: Unevaluated properties are not allowed ('ams,nflwdth', 'ams,tuning-capacitor-pf', 'compatible', 'interrupts', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/pressure/meas,ms5611.example.dtb: spi: pressure@0: Unevaluated properties are not allowed ('compatible', 'vdd-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/pressure/murata,zpa2326.example.dtb: spi: pressure@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc0832.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads8344.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#io-channel-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'channel@4', 'channel@5', 'channel@6', 'channel@7', 'compatible', 'interrupts-extended', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc128s052.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7923.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'refin-supply', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7476.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vcc-supply', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3201.example.dtb: spi: adc@1: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,tlc4541.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/maxim,max1241.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'shutdown-gpios', 'spi-max-frequency', 'vdd-supply', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads124s08.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'reset-gpios', 'spi-cpha', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc161s626.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vdda-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/maxim,max11100.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7280a.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('adi,acquisition-time-ns', 'adi,thermistor-termination', 'adi,voltage-alert-last-chan', 'compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad9467.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('clock-names', 'clocks', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc084s021.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc12138.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'clocks', 'compatible', 'interrupts', 'spi-max-frequency', 'ti,acquisition-time', 'vref-p-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7298.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/lltc,ltc2496.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,adc108s102.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads7950.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/maxim,max1118.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7949.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7949.example.dtb: spi: adc@1: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'compatible', 'vrefin-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7949.example.dtb: spi: adc@2: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adi,internal-ref-microvolt', 'compatible' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/maxim,max1027.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#io-channel-cells', 'compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/holt,hi8435.example.dtb: spi: threshold-detector@0: Unevaluated properties are not allowed ('compatible', 'gpios', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads8688.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('compatible', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/ti,ads131e08.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'channel@4', 'channel@5', 'channel@6', 'channel@7', 'clock-names', 'clocks', 'compatible', 'interrupts', 'spi-cpha', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('clocks', 'compatible', 'interrupts', 'microchip,device-addr', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7124.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@1', 'channel@2', 'channel@3', 'clock-names', 'clocks', 'compatible', 'interrupts', 'refin1-supply', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7292.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'channel@0', 'channel@2', 'channel@3', 'channel@4', 'channel@5', 'channel@6', 'channel@7', 'compatible', 'spi-cpha', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/adi,ad7768-1.example.dtb: spi: adc@0: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'adi,sync-in-gpios', 'channel@0', 'clock-names', 'clocks', 'compatible', 'interrupts', 'reset-gpios', 'spi-cpha', 'spi-cpol', 'spi-max-frequency', 'vref-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/touchscreen/cypress,cy8ctma340.example.dtb: spi: touchscreen@0: Unevaluated properties are not allowed ('active-interval-ms', 'bootloader-key', 'compatible', 'interrupts', 'lowpower-interval-ms', 'reset-gpios', 'touch-timeout-ms', 'touchscreen-size-x', 'touchscreen-size-y', 'vcpin-supply', 'vdd-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/touchscreen/ti,tsc2005.example.dtb: spi: touchscreen@0: Unevaluated properties are not allowed ('compatible', 'interrupts-extended', 'reset-gpios', 'spi-max-frequency', 'ti,esd-recovery-timeout-ms', 'ti,x-plate-ohms', 'touchscreen-fuzz-pressure', 'touchscreen-fuzz-x', 'touchscreen-fuzz-y', 'touchscreen-max-pressure', 'touchscreen-size-x', 'touchscreen-size-y', 'vio-supply' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/input/ariel-pwrbutton.example.dtb: spi: power-button@0: Unevaluated properties are not allowed ('compatible', 'interrupts', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.example.dtb: cros-ec@0: Unevaluated properties are not allowed ('cbas', 'compatible', 'google,cros-ec-spi-msg-delay', 'google,cros-ec-spi-pre-delay', 'interrupts', 'proximity', 'spi-max-frequency' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dtb: spi: cros-ec@0: Unevaluated properties are not allowed ('compatible', 'pwm' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-controller.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/google,cros-ec-pwm.example.dtb: cros-ec@0: Unevaluated properties are not allowed ('compatible', 'pwm' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

