Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58065694AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbiGFVso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiGFVsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:48:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16581277B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 14:48:40 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id o25so29299246ejm.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4i5EO0kaitjPcEHxSXPCNItB8IPvcn++dHMk7MK6Hw=;
        b=Pjb8x1ipLE/t1rhEAMq13iPm3THmr3C5eWVH0XEDA8okDnvhwF353vrjXM4UWu+yP9
         4O5HM0wpxRM+WGN1cDRqzwSgam2HRxCQIS17pDfktOMLEJmEyARYZXXO2DZydElfRxDm
         y4pasVes4lCsGe3PojS/ZN4uwx5V5CJtSNeME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4i5EO0kaitjPcEHxSXPCNItB8IPvcn++dHMk7MK6Hw=;
        b=G/wze6tzLbX0SbA+zjgqEWViLzXU+//N3vCrSlIbgsh05253MRsVhPMueh96+5MLCN
         NVs2UHw7Rnd7Yxzrrj3ClIQOpBgDzhS2nY27ETI6Hvujedm9UstgudvKmQZYtahRu/5U
         Kr0S8o+e9ADMNjZz7Rloy6go7HLpvMuXnn8vO7aizCpFIwACTI83kiGgrYESs3OdQHnW
         yAuZZgxf3HlC+aO/K+3iKYD3jOxDKKLqcFJIfR86GWCKivWJhj/1vYqkRqaS9H+A+xsB
         Lakp1G5aRxEcfXGyAmbqozr9nsLgGosP/zVcPsQC7tQgGVrK3rnJ62OlQmLZL29pCazK
         BvFg==
X-Gm-Message-State: AJIora93yQbOAKvablT+qhBNG1BRD0hHYDsmbYSORh28lfiYwDoVwTWU
        8ifYcTJNibeQ4XT1ix6FNO1iyh2fiLoVi5bx
X-Google-Smtp-Source: AGRyM1tQwGekwvvqjfhk8uPg2wX/vWySI8W+nuak4oOKOTygzR3eDZlQebS7JB2Mn2xgr4rIQBx9pQ==
X-Received: by 2002:a17:907:2c6a:b0:72a:f6e2:9815 with SMTP id ib10-20020a1709072c6a00b0072af6e29815mr5703499ejc.118.1657144119015;
        Wed, 06 Jul 2022 14:48:39 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id u17-20020a1709063b9100b006f3ef214e13sm17785567ejf.121.2022.07.06.14.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 14:48:38 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z12so14191717wrq.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 14:48:38 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr38409660wrd.659.1657144117610; Wed, 06
 Jul 2022 14:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220514215424.1007718-1-bhupesh.sharma@linaro.org> <20220514215424.1007718-6-bhupesh.sharma@linaro.org>
In-Reply-To: <20220514215424.1007718-6-bhupesh.sharma@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 Jul 2022 14:48:25 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W7CQVm0Z-ZvLQaBzMqJxJm4iaKm0+V1A4J8VMjNZAoHw@mail.gmail.com>
Message-ID: <CAD=FV=W7CQVm0Z-ZvLQaBzMqJxJm4iaKm0+V1A4J8VMjNZAoHw@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: qcom: Fix 'reg-names' for sdhci nodes
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        bhupesh.linux@gmail.com, LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
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

On Sat, May 14, 2022 at 2:55 PM Bhupesh Sharma
<bhupesh.sharma@linaro.org> wrote:
>
> Since the Qualcomm sdhci-msm device-tree binding has been converted
> to yaml format, 'make dtbs_check' reports a number of issues with
> ordering of 'reg-names' as various possible combinations
> are possible for different qcom SoC dts files.
>
> Fix the same by updating the offending 'dts' files.
>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/sm6350.dtsi | 2 +-
>  6 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 86dbf8ea04bc..45044083faf0 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -792,7 +792,7 @@ pcie_phy: phy@7786000 {
>                 sdcc1: mmc@7804000 {
>                         compatible = "qcom,qcs404-sdhci", "qcom,sdhci-msm-v5";
>                         reg = <0x07804000 0x1000>, <0x7805000 0x1000>;
> -                       reg-names = "hc", "cqhci";
> +                       reg-names = "hc_mem", "cqe_mem";
>
>                         interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 138 IRQ_TYPE_LEVEL_HIGH>;
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> index 9076892ff4f8..08f2decc7f4f 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -697,7 +697,7 @@ sdhc_1: mmc@7c4000 {
>                         compatible = "qcom,sc7180-sdhci", "qcom,sdhci-msm-v5";
>                         reg = <0 0x7c4000 0 0x1000>,
>                                 <0 0x07c5000 0 0x1000>;
> -                       reg-names = "hc", "cqhci";
> +                       reg-names = "hc_mem", "cqe_mem";
>
>                         iommus = <&apps_smmu 0x60 0x0>;
>                         interrupts = <GIC_SPI 641 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index e63d1a4499f8..eaaccf0184af 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -866,7 +866,7 @@ sdhc_1: mmc@7c4000 {
>
>                         reg = <0 0x007c4000 0 0x1000>,
>                               <0 0x007c5000 0 0x1000>;
> -                       reg-names = "hc", "cqhci";
> +                       reg-names = "hc_mem", "cqe_mem";

Yer breakin' mah build!

The second register here (and probably all boards) needs to be
"cqhci". See the line in the driver that looks like:

/* check and setup CMDQ interface */
cqhci_memres = platform_get_resource_byname(pdev, IORESOURCE_MEM,
                                           "cqhci");

For history, see commit d3392339cae9 ("mmc: cqhci: Update cqhci memory
ioresource name") and commit d79100c91ae5 ("dt-bindings: mmc:
sdhci-msm: Add CQE reg map").

The problem here is not the device trees but the yaml. When you
convert from .txt to .yaml you're not allowed to just rewrite the
binding. It should also be noted that the "_mem" suffix was explicitly
requested to be removed.

Revert posted at:
https://lore.kernel.org/r/20220706144706.1.I48f35820bf3670d54940110462555c2d0a6d5eb2@changeid
