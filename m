Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01622569698
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiGFXvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbiGFXvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:51:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0EB72D1C3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:51:31 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v12so8523842edc.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m+ISb8AxgC/6jZga1CYYiS5A3OoMCJzV7su7cB+cDXM=;
        b=Ggkd5GvzrFEjZXhMOm/slahbINqpaFIXEhywspF40HQWbaeGmBTB+NOPIi0ofUywBV
         aHxxoSQmgpHrZfdwG1Lr+C+u0hqSp5GMf33RbcbsY41Mv90q5qvyI0pPzQ85HBfMQzb9
         piQ5eIPitFdFpRKotBQNu7Q5HB+oErr4/KnMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m+ISb8AxgC/6jZga1CYYiS5A3OoMCJzV7su7cB+cDXM=;
        b=aQ67LBZdu5DHzadWloU5yF0819h0/ov2NHjQ9YO0fxCYCUChnxHpL6E6j2ee22LOnx
         bUpbfd9AwnYMEsFg8idG7rtK2L/fF1AxlbI1Ax4MGG6EHnVW7LN6cUrB9/CwFlew2Qi9
         EyYo2ecd/+uGFZjUmZXCTL99W1wA/PYLCqtKO5X3HEdaI0TSmf2o+oIBK68ASI/d8s56
         kdZThqoS1REkdq4c/r29F0FcoAFZDnjxV+0MMXhKlDQAaJ7taV9er4VcSMNxU+kusqdW
         z07lO9Cjp2WbS8z3KZNsdMel1rzGBuGENff6jg9hQakMOiSxXrJk8RBkc11cAnBDEa1w
         geLg==
X-Gm-Message-State: AJIora+DJCXuCSGSWPteX329ofVn5svJqjVqIuftrtZHDVt1iNwoo3Yd
        k5sPthgTlikYUes0pyMhcuyqPUrgp2p3O56jR80=
X-Google-Smtp-Source: AGRyM1sj6eEfVoRegCqg7izXmPxd3d7YTri8OL+gBfXKcg0yHOS2CevUGX49D4II3KwxXlPBSWXftA==
X-Received: by 2002:a05:6402:3224:b0:435:80fd:333 with SMTP id g36-20020a056402322400b0043580fd0333mr58373088eda.76.1657151489978;
        Wed, 06 Jul 2022 16:51:29 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm6293753edu.33.2022.07.06.16.51.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 16:51:29 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id h17so10916098wrx.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 16:51:28 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr40806666wrr.617.1657151488472; Wed, 06
 Jul 2022 16:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
In-Reply-To: <SG2PR03MB500697A11DA5D0B45DE41B0ECC819@SG2PR03MB5006.apcprd03.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 16:51:16 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V94WCJLuGB+_MdTi90MZvecr569uastACc1afT9k_0nw@mail.gmail.com>
Message-ID: <CAD=FV=V94WCJLuGB+_MdTi90MZvecr569uastACc1afT9k_0nw@mail.gmail.com>
Subject: Re: [PATCH 2/2] [PATCH v2 2/2] arm64: dts: qcom: Add LTE SKUs for
 sc7280-villager family
To:     Jimmy Chen <jinghung.chen3@hotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Alan Huang <alan-huang@quanta.corp-partner.google.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 4, 2022 at 7:22 PM Jimmy Chen <jinghung.chen3@hotmail.com> wrote:
>
> This adds LTE skus for villager device tree files.
>
> Signed-off-by: Jimmy Chen <jinghung.chen3@hotmail.com>
> ---
>
>  arch/arm64/boot/dts/qcom/Makefile                 |  2 ++
>  .../arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 11 -----------
>  arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts |  1 +
>  .../dts/qcom/sc7280-herobrine-herobrine-r1.dts    |  1 +
>  .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi   | 15 +++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r0-lte.dts | 14 ++++++++++++++
>  .../dts/qcom/sc7280-herobrine-villager-r1-lte.dts | 14 ++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts           |  1 +
>  8 files changed, 48 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts

High level comment: your threading is very strange here. Can you use
"git send-email" to send your patches? It's definitely hard to follow
things. Patch #2 in the series should be "In-Reply-To" patch #1.


> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index bb9f4eb3e65a0..6d81ff12f5af2 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -103,6 +103,8 @@ dtb-$(CONFIG_ARCH_QCOM)     += sc7180-trogdor-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-crd.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-herobrine-r1.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r0.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r0-lte.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sc7280-herobrine-villager-r1-lte.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-idp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-idp2.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += sc7280-crd-r3.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index cfe2741456a1a..25f31c81b2b74 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -83,17 +83,6 @@ spi_flash: flash@0 {
>         };
>  };
>
> -/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> -&remoteproc_mpss {
> -       status = "okay";
> -       compatible = "qcom,sc7280-mss-pil";
> -       iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> -       interconnects = <&mc_virt MASTER_LLCC 0 &mc_virt SLAVE_EBI1 0>;
> -       memory-region = <&mba_mem>, <&mpss_mem>;
> -       firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> -                       "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> -};
> -
>  &remoteproc_wpss {
>         status = "okay";
>         firmware-name = "ath11k/WCN6750/hw1.0/wpss.mdt";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> index e9ca6c5d24a16..921eccfec39ae 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
> @@ -9,6 +9,7 @@
>
>  #include "sc7280-herobrine.dtsi"
>  #include "sc7280-herobrine-audio-wcd9385.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>
>  / {
>         model = "Qualcomm Technologies, Inc. sc7280 CRD platform (rev5+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> index c1647a85a371a..c1a6719687252 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> @@ -8,6 +8,7 @@
>  /dts-v1/;
>
>  #include "sc7280-herobrine.dtsi"
> +#include "sc7280-herobrine-lte-sku.dtsi"
>
>  / {
>         model = "Google Herobrine (rev1+)";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> new file mode 100644
> index 0000000000000..a4809dd2f4e8a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Herobrine dts fragment for LTE SKUs
> + *
> + * Copyright 2022 Google LLC.
> + */

Blank line here please.

> +/* Modem setup is different on Chrome setups than typical Qualcomm setup */
> +&remoteproc_mpss {
> +       status = "okay";
> +       compatible = "qcom,sc7280-mss-pil";
> +       iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
> +       memory-region = <&mba_mem>, <&mpss_mem>;
> +       firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> +                       "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> new file mode 100644
> index 0000000000000..672cb78e3088f
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r0.dts"
> +#include "sc7280-herobrine-lte-sku.dtsi"
> +
> +/ {
> +       model = "Google Villager (rev0) with LTE";
> +       compatible = "google,villager-rev0-sku0", "qcom,sc7280";
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> new file mode 100644
> index 0000000000000..2f05a19cc388e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1-lte.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Google Villager board device tree source
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +#include "sc7280-herobrine-villager-r1.dts"

You can't include this file because it doesn't exist upstream. It
wouldn't be hard for you to post a patch adding it, though. You could
make a 3-patch series. Patch #1 is the bindings, patch #2 adds
villager-r1, and patch #3 adds the LTE bits.
