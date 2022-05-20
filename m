Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA10E52F4A4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 22:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353528AbiETUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiETUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 16:50:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC35F197F69
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id ck4so13405464ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waJb9YRlR/dVVHiz9FXpjWhUHca9QxD4Ut989/pMyqc=;
        b=Z5NWGsXuwDWGDkysB5pxuzCkviPdIlqUWpd8FicJ9ML8hvWY5AI1rXenD1t5ctMa43
         OjMhGDwsk/f/EkI0kopeEttr37fwC8cpOCRcIstmjW31St81Ccjy0J5VXYurN17MAm/2
         u0movrLLB0W4IIVrM69FBgpT1qPElBKoePMq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waJb9YRlR/dVVHiz9FXpjWhUHca9QxD4Ut989/pMyqc=;
        b=UL1otM3N4dgq852J8i/ZLHI8tjT0/DVeYAgDe4I6TTt4Y5nXn1IS0RIDPZpkkWKoQR
         G52VBw2wypZxXthnt3PmERrbvdsTIMdq9kMwDgkK2NMaEbG6awn/K7dpksCPi01GjW0Z
         6RBHV/djY3ebpGv66bQz4bBhqZ77inqqXwVEHN7atMegqWmfC6KcaDzCjl8uGWba2ox8
         Nwm9eXWCEE/hK6yvtqMzBlpWUROCPbk8LY6ggyd592iBVLXJ6ejEdFZCytC910vj/Hn8
         aa2Hksya0K51Aq2UUqQX73B43qF3jN7+S6J6n5iksSQ6fk+eTsLIsSLUtr4QkyZoerc2
         gToQ==
X-Gm-Message-State: AOAM53385sguOqfmtNqM7GiKMPBzZDGwz92uUqS1QTpdH9o5GxADM4KH
        ceeUQ2Gw9xs+6sQ61Qem1cFR3dsSN3/oveHOMck=
X-Google-Smtp-Source: ABdhPJw1lyqQHiAsk5fH1jqf+ucNE4Ad1A0WYSUqUtRe9TxRd/TeIPeslMZsMVs//Qx9P/2DnyYNww==
X-Received: by 2002:a17:906:4fc3:b0:6e0:66a5:d59c with SMTP id i3-20020a1709064fc300b006e066a5d59cmr10177567ejw.131.1653079804190;
        Fri, 20 May 2022 13:50:04 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709064f8800b006f3ef214ddbsm3505780eju.65.2022.05.20.13.50.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 13:50:02 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id h5so11843624wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 13:50:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2c1:b0:20c:5e37:3ed1 with SMTP id
 o1-20020a05600002c100b0020c5e373ed1mr9695141wry.342.1653079801669; Fri, 20
 May 2022 13:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220520161004.1141554-1-judyhsiao@chromium.org> <20220520161004.1141554-3-judyhsiao@chromium.org>
In-Reply-To: <20220520161004.1141554-3-judyhsiao@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 20 May 2022 13:49:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X9TqwUKY54RTCkQ_55BNHqWbGuc4sGQtwgKxWrLwX5QQ@mail.gmail.com>
Message-ID: <CAD=FV=X9TqwUKY54RTCkQ_55BNHqWbGuc4sGQtwgKxWrLwX5QQ@mail.gmail.com>
Subject: Re: [v2 2/3] arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Jimmy Cheng-Yi Chiang <cychiang@google.com>,
        Judy Hsiao <judyhsiao@google.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 20, 2022 at 9:10 AM Judy Hsiao <judyhsiao@chromium.org> wrote:
>
> Audio dtsi for sc7280 boards that using rt5682 headset codec:
> 1. Add dt nodes for sound card which use I2S playback and record
>    through rt5682s and I2S playback through max98357a.
> 2. Enable lpass cpu node and add pin control and dai-links.
>
> Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
> ---
>  .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 120 ++++++++++++++++++
>  1 file changed, 120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> new file mode 100644
> index 000000000000..d83e99f1d417
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + *
> + * This file defines the common audio settings for the child boards using rt5682 codec.
> + *
> + * Copyright 2022 Google LLC.
> + */
> +
> +/ {
> +       /* BOARD-SPECIFIC TOP LEVEL NODES */
> +       sound: sound {
> +               compatible = "google,sc7280-herobrine";
> +               model = "sc7280-rt5682-max98360a-1mic";
> +
> +               status = "okay";
> +               audio-routing =
> +                       "Headphone Jack", "HPOL",
> +                       "Headphone Jack", "HPOR";
> +
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               dai-link@0 {
> +                       link-name = "MAX98360";
> +                       reg = <0>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_SECONDARY>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&max98360a>;
> +                       };
> +               };
> +
> +               dai-link@1 {
> +                       link-name = "ALC5682";
> +                       reg = <1>;
> +
> +                       cpu {
> +                               sound-dai = <&lpass_cpu MI2S_PRIMARY>;
> +                       };
> +
> +                       codec {
> +                               sound-dai = <&alc5682 0 /* aif1 */>;
> +                       };
> +               };
> +       };
> +};
> +
> +hp_i2c: &i2c2 {
> +       status = "okay";
> +       clock-frequency = <400000>;
> +
> +       alc5682: codec@1a {
> +               compatible = "realtek,rt5682s";
> +               reg = <0x1a>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hp_irq>;
> +
> +               #sound-dai-cells = <1>;
> +
> +               interrupt-parent = <&tlmm>;
> +               interrupts = <101 IRQ_TYPE_EDGE_BOTH>;
> +
> +               AVDD-supply = <&pp1800_alc5682>;
> +               MICVDD-supply = <&pp3300_codec>;
> +
> +               realtek,dmic1-data-pin = <1>;
> +               realtek,dmic1-clk-pin = <2>;
> +               realtek,jd-src = <1>;
> +               realtek,dmic-clk-rate-hz = <2048000>;
> +       };
> +};
> +
> +&lpass_cpu {
> +       status = "okay";
> +
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mi2s0_data0 &mi2s0_data1 &mi2s0_mclk &mi2s0_sclk &mi2s0_ws
> +                    &mi2s1_data0 &mi2s1_sclk &mi2s1_ws>;
> +
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       dai-link@0 {
> +               reg = <MI2S_PRIMARY>;
> +               qcom,playback-sd-lines = <1>;
> +               qcom,capture-sd-lines = <0>;
> +       };
> +
> +       dai-link@1 {
> +               reg = <MI2S_SECONDARY>;
> +               qcom,playback-sd-lines = <0>;
> +       };
> +};
> +
> +&mi2s0_data0 {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_data1 {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_mclk {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_sclk {
> +       drive-strength = <6>;
> +       bias-disable;
> +};
> +
> +&mi2s0_ws {
> +       drive-strength = <6>;

Just like for patch #1, I think you want "bias-disable" here, too.

-Doug
