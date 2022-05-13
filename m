Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9267F526206
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378280AbiEMMd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380298AbiEMMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:33:39 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E2D674E5;
        Fri, 13 May 2022 05:33:33 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id w123so9951190oiw.5;
        Fri, 13 May 2022 05:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WpkJGC/aYt+zei5DfkFr+BBMssSXYh9sm76rTb3A0ss=;
        b=aKaG41Ju89RWMlC+9IFxu3HrnXi6LL1y8txvikjjSsCiZHduYWSwqyjZMv9/ctr3fF
         sxWyYryZ6xNk7pWfWMiFeeSfILVAbniF9ZUR5JG2yxmPeqVLOWP0NPCOyDvM+BSZSMpq
         WkFXvnKhxnwNtYW7oOu+GJItvaEIVkuMQOmWY8DOsyy2NeoMxel/aHqxdUoWwLKqFE93
         PATMvOj4Jq5UVjld00IpbIOvrHM15cMeV/KBEqMsRYpZzXCEMQXRHfBFEAX+R3a8fi7M
         7yjqBAle/u19zF15pgROtb/we9F/Ev5A+DWp1vuhUCrFK+V7oRzeOhYHlfzw2Oew697r
         A9zg==
X-Gm-Message-State: AOAM532KS97UPnBiLxKJzadma4oCpCHtBwtj/h6bF7yYNEnjv6RNG1dp
        Jvp8S0JKrWkX73NNnTpuv/p/Bm9vnQ==
X-Google-Smtp-Source: ABdhPJzn9fuPQjmsnKno893E5/unpG+vKQtmhPIw2Y2xzK157Mm4P3gNUtEWwNRPQjhqkTeNOat/XQ==
X-Received: by 2002:a05:6808:2199:b0:326:90e2:754b with SMTP id be25-20020a056808219900b0032690e2754bmr7528877oib.227.1652445210867;
        Fri, 13 May 2022 05:33:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6a0f000000b006060322124csm900213otn.28.2022.05.13.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 05:33:30 -0700 (PDT)
Received: (nullmailer pid 85855 invoked by uid 1000);
        Fri, 13 May 2022 12:33:21 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        quic_pkondeti@quicinc.com, Stephen Boyd <swboyd@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        quic_vpulyala@quicinc.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        linux-arm-msm@vger.kernel.org
In-Reply-To: <1652379802-8318-2-git-send-email-quic_kriskura@quicinc.com>
References: <1652379802-8318-1-git-send-email-quic_kriskura@quicinc.com> <1652379802-8318-2-git-send-email-quic_kriskura@quicinc.com>
Subject: Re: [v16 1/5] dt-bindings: usb: dwc3: Add wakeup-source property support
Date:   Fri, 13 May 2022 07:33:21 -0500
Message-Id: <1652445201.122658.85854.nullmailer@robh.at.kernel.org>
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

On Thu, 12 May 2022 23:53:18 +0530, Krishna Kurapati wrote:
> From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> 
> Added support for wakeup-source property. This property can be
> used to check and power down the phy during system suspend if
> wake up is not supported.
> 
> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


dwc3@10000000: $nodename:0: 'dwc3@10000000' does not match '^usb(@.*)?'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dwc3@11000000: $nodename:0: 'dwc3@11000000' does not match '^usb(@.*)?'
	arch/arm/boot/dts/qcom-ipq8064-ap148.dtb
	arch/arm/boot/dts/qcom-ipq8064-rb3011.dtb

dwc3@6000000: $nodename:0: 'dwc3@6000000' does not match '^usb(@.*)?'
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

dwc3@6a00000: $nodename:0: 'dwc3@6a00000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb

dwc3@7580000: $nodename:0: 'dwc3@7580000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

dwc3@7600000: $nodename:0: 'dwc3@7600000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/apq8096-db820c.dtb
	arch/arm64/boot/dts/qcom/apq8096-ifc6640.dtb
	arch/arm64/boot/dts/qcom/msm8996-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-pmi8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-dora.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-kagura.dtb
	arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone-keyaki.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dtb
	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dtb

dwc3@78c0000: $nodename:0: 'dwc3@78c0000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/qcs404-evb-1000.dtb
	arch/arm64/boot/dts/qcom/qcs404-evb-4000.dtb

dwc3@8a00000: $nodename:0: 'dwc3@8a00000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dtb
	arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtb
	arch/arm/boot/dts/qcom-ipq4018-jalapeno.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk04.1-c3.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c1.dtb
	arch/arm/boot/dts/qcom-ipq4019-ap.dk07.1-c2.dtb

dwc3@8c00000: $nodename:0: 'dwc3@8c00000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/ipq8074-hk01.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c1.dtb
	arch/arm64/boot/dts/qcom/ipq8074-hk10-c2.dtb

dwc3@9900000: $nodename:0: 'dwc3@9900000' does not match '^usb(@.*)?'
	arch/arm/boot/dts/stih407-b2120.dtb
	arch/arm/boot/dts/stih410-b2120.dtb
	arch/arm/boot/dts/stih410-b2260.dtb
	arch/arm/boot/dts/stih418-b2199.dtb
	arch/arm/boot/dts/stih418-b2264.dtb

dwc3@a600000: $nodename:0: 'dwc3@a600000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/sa8155p-adp.dtb
	arch/arm64/boot/dts/qcom/sc7180-idp.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r5.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-nots-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r4.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-limozeen-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r0.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-kb.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-lazor-r9-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r2-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom-r3-lte.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1.dtb
	arch/arm64/boot/dts/qcom/sc7180-trogdor-r1-lte.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb
	arch/arm64/boot/dts/qcom/sm8150-hdk.dtb
	arch/arm64/boot/dts/qcom/sm8150-microsoft-surface-duo.dtb
	arch/arm64/boot/dts/qcom/sm8150-mtp.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-bahamut.dtb
	arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano-griffin.dtb
	arch/arm/boot/dts/qcom-sdx55-mtp.dtb
	arch/arm/boot/dts/qcom-sdx55-t55.dtb
	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dtb

dwc3@a800000: $nodename:0: 'dwc3@a800000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/qcom/msm8998-asus-novago-tp370ql.dtb
	arch/arm64/boot/dts/qcom/msm8998-fxtec-pro1.dtb
	arch/arm64/boot/dts/qcom/msm8998-hp-envy-x2.dtb
	arch/arm64/boot/dts/qcom/msm8998-lenovo-miix-630.dtb
	arch/arm64/boot/dts/qcom/msm8998-mtp.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-cheeseburger.dtb
	arch/arm64/boot/dts/qcom/msm8998-oneplus-dumpling.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-lilac.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dtb
	arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r1.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r2.dtb
	arch/arm64/boot/dts/qcom/sdm845-cheza-r3.dtb
	arch/arm64/boot/dts/qcom/sdm845-db845c.dtb
	arch/arm64/boot/dts/qcom/sdm845-mtp.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-enchilada.dtb
	arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dtb
	arch/arm64/boot/dts/qcom/sdm845-shift-axolotl.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akari.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-akatsuki.dtb
	arch/arm64/boot/dts/qcom/sdm845-sony-xperia-tama-apollo.dtb
	arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dtb
	arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dtb
	arch/arm64/boot/dts/qcom/sdm850-samsung-w737.dtb

dwusb@19000000: $nodename:0: 'dwusb@19000000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/apm/apm-merlin.dtb
	arch/arm64/boot/dts/apm/apm-mustang.dtb

dwusb@19800000: $nodename:0: 'dwusb@19800000' does not match '^usb(@.*)?'
	arch/arm64/boot/dts/apm/apm-mustang.dtb

usb@38100000: port@0: 'compatible' is a required property
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

usb@38100000: port@1: 'compatible' is a required property
	arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r2.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r3.dtb
	arch/arm64/boot/dts/freescale/imx8mq-librem5-r4.dtb

usb@65a00000: phys: [[41], [42], [43], [44]] is too long
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb

usb@65a00000: phys: [[47], [48], [49], [50]] is too long
	arch/arm/boot/dts/uniphier-ld6b-ref.dtb

usb@65a00000: phys: [[48], [49], [50], [51]] is too long
	arch/arm/boot/dts/uniphier-pxs2-gentil.dtb
	arch/arm/boot/dts/uniphier-pxs2-vodka.dtb

usb@65a00000: phys: [[50], [51], [52], [53], [54], [55]] is too long
	arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dtb

usb@65a00000: phys: [[52], [53], [54], [55], [56], [57]] is too long
	arch/arm64/boot/dts/socionext/uniphier-ld20-akebi96.dtb

usb@65a00000: phys: [[55], [56], [57], [58], [59], [60]] is too long
	arch/arm64/boot/dts/socionext/uniphier-ld20-global.dtb

usb@65c00000: phys: [[55], [56], [57]] is too long
	arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dtb

usb@65c00000: phys: [[56], [57], [58]] is too long
	arch/arm/boot/dts/uniphier-ld6b-ref.dtb

usb@65c00000: phys: [[57], [58], [59]] is too long
	arch/arm/boot/dts/uniphier-pxs2-gentil.dtb
	arch/arm/boot/dts/uniphier-pxs2-vodka.dtb

usb@fe200000: interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@fe300000: interrupt-names: 'oneOf' conditional failed, one must be fixed:
	arch/arm64/boot/dts/xilinx/avnet-ultra96-rev1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-sm-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-smk-k26-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1232-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1254-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1275-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm015-dc1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm016-dc2.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm017-dc3.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm018-dc4.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zc1751-xm019-dc5.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.0.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-rev1.1.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revB.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revC.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dtb
	arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dtb

usb@ff100000: resets: [[31, 144, 8], [31, 144, 7], [31, 144, 6], [31, 144, 5]] is too long
	arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb

usb@ff100000: snps,tx_de_emphasis:0: [0, 0, 0, 1] is too long
	arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb
	arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb

