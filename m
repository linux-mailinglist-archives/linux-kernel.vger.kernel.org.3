Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53C51598F9A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 23:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345883AbiHRVeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 17:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344516AbiHRVeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 17:34:07 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B41B590185
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:34:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w3so3469455edc.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qErRFIQ0nHVnmKdsLBSakvXDlQR0goAZInCyznmckxY=;
        b=hn7koqt0JXqitWaXAGRzTAAniDctUWCyarxNwwp0EBoRHiVHG2Z8guogWJs3qdpLxM
         sLC4QzABjP6CVSwvyA2aTXNBT3wYYecTtJy3D2wo/pb8fEjaHShM3tJj1Pj1pW70lTL9
         diCnHQTdiwzzzyzVdV2SmaYpPJuGyKUjY310Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qErRFIQ0nHVnmKdsLBSakvXDlQR0goAZInCyznmckxY=;
        b=omOtqpM38eQiPLnsQuYgSbMh8HOo2FCEnxhlU1Djz0XDlLUscmWbBpiJoGsBVXX9OP
         FoY8gS3ThF74uRKYtJU20yjsYyWBm34Ni/qAxiZf9nMhAp8SwOWEXz19IcUHsdan6Enr
         NAWocsP3S0dB1akWdGtVesYol5oDLOGz6UxiI0btTKu/+1cBtdQvXQQpWyy1sbiobZq4
         fhSMH2g3DtWWNAdS7rexNyDTAwuMgqsCOynV2Vb1p9PxvovNVtXkVTz5ZD0+Xab8pIp9
         Xt0enZSgrvfBXriTDV2mnNlPOitFSN/IFF8WHlBT7f45hM0qc/QTF94SdF5R8BXFV7gE
         97tA==
X-Gm-Message-State: ACgBeo0pkAkH93cG6BiGDquT4HuqcL7TPcwjEfCIUudHZLEJVR2W2KDy
        ACZhZSNWtKYfCvyXKrKDynz17Kyr/R4jUlv9
X-Google-Smtp-Source: AA6agR4qxoihVJvqAM9/PB7Kp5O8bFGQ5Gr8AMNFMYTpJsCix5n8OHvpfBkWDp7zSo5+s2BG2U88jg==
X-Received: by 2002:a05:6402:551a:b0:446:1526:85ea with SMTP id fi26-20020a056402551a00b00446152685eamr3121768edb.188.1660858444108;
        Thu, 18 Aug 2022 14:34:04 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id kv22-20020a17090778d600b00705cdfec71esm1363154ejc.7.2022.08.18.14.34.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 14:34:01 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so1604781wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 14:34:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3a6:1ab9:5b3d with SMTP id
 o20-20020a05600c511400b003a61ab95b3dmr2859717wms.93.1660858441222; Thu, 18
 Aug 2022 14:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220816093644.764259-1-judyhsiao@chromium.org>
In-Reply-To: <20220816093644.764259-1-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Aug 2022 14:33:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XLsBcbrjb0DwG+Yhia_hk4kcKT2S0_vMT=k3cWxh=NRg@mail.gmail.com>
Message-ID: <CAD=FV=XLsBcbrjb0DwG+Yhia_hk4kcKT2S0_vMT=k3cWxh=NRg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7280: Use "PP1800_L2C" as the DMIC
 power source.
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 16, 2022 at 2:36 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Use "PP1800_L2C" as the DMIC power source to match the hardware
> schematic.
> It fixes the DMIC no sound issue of villager-r1.
>
>
> Co-developed-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
> Changes since V1:
>     -- Update the commit message.
>
>
> This patch depends on:
> arm64: dts: qcom: sc7280: Add herobrine-villager-r1. [1]
>
> [1]
> https://patchwork.kernel.org/patch/12926099/
>
>
>  .../dts/qcom/sc7280-herobrine-villager-r1.dts | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> index c03b3ae4de50..983defa7c76d 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r1.dts
> @@ -12,3 +12,31 @@ / {
>         model = "Google Villager (rev1+)";
>         compatible = "google,villager", "qcom,sc7280";
>  };
> +
> +&lpass_va_macro {
> +       vdd-micb-supply = <&pp1800_l2c>;
> +};
> +
> +&sound {
> +       audio-routing =
> +                       "IN1_HPHL", "HPHL_OUT",
> +                       "IN2_HPHR", "HPHR_OUT",
> +                       "AMIC1", "MIC BIAS1",
> +                       "AMIC2", "MIC BIAS2",
> +                       "VA DMIC0", "vdd-micb",
> +                       "VA DMIC1", "vdd-micb",
> +                       "VA DMIC2", "vdd-micb",
> +                       "VA DMIC3", "vdd-micb",
> +                       "TX SWR_ADC0", "ADC1_OUTPUT",
> +                       "TX SWR_ADC1", "ADC2_OUTPUT",
> +                       "TX SWR_ADC2", "ADC3_OUTPUT",
> +                       "TX SWR_DMIC0", "DMIC1_OUTPUT",
> +                       "TX SWR_DMIC1", "DMIC2_OUTPUT",
> +                       "TX SWR_DMIC2", "DMIC3_OUTPUT",
> +                       "TX SWR_DMIC3", "DMIC4_OUTPUT",
> +                       "TX SWR_DMIC4", "DMIC5_OUTPUT",
> +                       "TX SWR_DMIC5", "DMIC6_OUTPUT",
> +                       "TX SWR_DMIC6", "DMIC7_OUTPUT",
> +                       "TX SWR_DMIC7", "DMIC8_OUTPUT";

In v1, Stephen pointed out that the subject and description of your
patch talk about adjusting the supply. However, your patch _also_
adjusts the audio routing.

It feels like the audio routing should be done in a separate patch and
that patch.

-Doug
