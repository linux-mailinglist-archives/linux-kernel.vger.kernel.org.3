Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C29D4C7FB4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 01:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbiCAAuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 19:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiCAAuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:50:09 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CB154BEA
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:49:29 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a8so28268695ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LVHH34NO2X0ne4suduo97C3H32Zgs6Op5o0kkQwLtG0=;
        b=nxWqmwdjFtlkys7jSnX/pYz+P1c8pMbgwMbrqLdKOAjolBc8yd5lbH1ZsZwqRtsxwu
         FLJjhSsyt3fh+4GRAdsN3852Q1F+VAhsCv22ko1t0dlnII9geLrhdeziEoSEZYaLsgcV
         b9ht+UrWxG5f5/S50I4EYma/+dXf3mRPKgpGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LVHH34NO2X0ne4suduo97C3H32Zgs6Op5o0kkQwLtG0=;
        b=iwXaR5yrpmj/uRQrWguR35JTVsDZ5mYuY/RJt2AIauqbXgEzr6h2RS8AVs/yp+AlSa
         b0+hLKS+7GTVpw+qBGxOJEai1xOv7N4ke5WYKP6Kj1TvTW22oTR6O+1eNlroT78aNW9O
         +M3eqakpmUHa30hQKJ7cb34tJXjQRFfBHVMrpW9fEPJm30E1m9JBVuAgfai1/kB2GDij
         HBCX4m9Wb7RN1M5KcmnQZfXQ3qY87dF72PwMozrv/fugf/nHSosOremCwTqjoqqKeZIz
         zqF6+qpM6oj1BgFhB9eDAYZ9u+975SSiXI1LQgLcAujTV9kDhmXrIDh9wqZSNYZxfhDa
         qHrQ==
X-Gm-Message-State: AOAM531+Xt822Uu3RuNT2cBMAmNJzvhLvu5at2KaztAB4GKg2Ej/OqzW
        S9LAo2xXbVUG0Hna+JvBDxrPBnsn3Eu3VGjs
X-Google-Smtp-Source: ABdhPJxExhktOysA/D6Va5TaFTBYPXacqj1txNZlARhAxu0qqqReIiRRmQoOX6MP8TnQuX/vAaMRMA==
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id e20-20020a1709061e9400b006cc4382f12emr17179598ejj.482.1646095767441;
        Mon, 28 Feb 2022 16:49:27 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id m3-20020a17090679c300b006cf9ce53354sm4767201ejo.190.2022.02.28.16.49.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 16:49:26 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id p9so17959186wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 16:49:26 -0800 (PST)
X-Received: by 2002:a5d:5112:0:b0:1ed:c1da:4ad2 with SMTP id
 s18-20020a5d5112000000b001edc1da4ad2mr17549704wrt.342.1646095765403; Mon, 28
 Feb 2022 16:49:25 -0800 (PST)
MIME-Version: 1.0
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com> <1644591438-6514-2-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1644591438-6514-2-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Feb 2022 16:49:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XP7uQ+uxt05Gcn0SLeheO1-bMBemvka44s0vjGOApLwQ@mail.gmail.com>
Message-ID: <CAD=FV=XP7uQ+uxt05Gcn0SLeheO1-bMBemvka44s0vjGOApLwQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] arm64: dts: qcom: sc7280: Add nodes for va tx and
 rx macros and external codecs
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Feb 11, 2022 at 6:57 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:
>
> SC7280 has VA, TX and RX macros with SoundWire Controllers to attach with
> codecs like WCD938x, max98360a using soundwire masters and i2s bus.
> Add these nodes for sc7280 based platforms audio use case.
> Add tlmm gpio property in wcd938x node for switching CTIA/OMTP Headset.
>
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280-crd.dts  |   4 +
>  arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 178 +++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> index e2efbdd..dd23b63 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
> @@ -84,6 +84,10 @@ ap_ts_pen_1v8: &i2c13 {
>         pins = "gpio51";
>  };
>
> +&wcd938x {
> +       us-euro-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;

Probably need GPIO 81 pinctrl entry?


> +};
> +
>  &tlmm {
>         tp_int_odl: tp-int-odl {
>                 pins = "gpio7";
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> index 1089fa0..07f8b1e 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
> @@ -38,6 +38,14 @@
>                 };
>         };
>
> +       max98360a: audio-codec-0 {

nit that sorting should be based on node name here, so "audio" should
sort before "gpio-keys"


> +               compatible = "maxim,max98360a";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&amp_en>;

You refer to "amp_en", but I don't see it defined anywhere except in
"herobrine" files, so I don't think this will compile for you, will
it?


> +               sdmode-gpios = <&tlmm 63 GPIO_ACTIVE_HIGH>;
> +               #sound-dai-cells = <0>;
> +       };
> +
>         nvme_3v3_regulator: nvme-3v3-regulator {
>                 compatible = "regulator-fixed";
>                 regulator-name = "VLDO_3V3";
> @@ -49,6 +57,31 @@
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&nvme_pwren>;
>         };
> +
> +       wcd938x: codec {

This is also sorted wrong.


> +               compatible = "qcom,wcd9380-codec";
> +               #sound-dai-cells = <1>;
> +
> +               reset-gpios = <&tlmm 83 GPIO_ACTIVE_HIGH>;

Where's the pinctrl for GPIO 83?


> +               qcom,rx-device = <&wcd_rx>;
> +               qcom,tx-device = <&wcd_tx>;
> +
> +               vdd-rxtx-supply = <&vreg_l18b_1p8>;
> +               vdd-io-supply = <&vreg_l18b_1p8>;
> +               vdd-buck-supply = <&vreg_l17b_1p8>;
> +               vdd-mic-bias-supply = <&vreg_bob>;

"vdd-mic-bias-supply" doesn't appear to be in your bindings.


> +               qcom,micbias1-microvolt = <1800000>;
> +               qcom,micbias2-microvolt = <1800000>;
> +               qcom,micbias3-microvolt = <1800000>;
> +               qcom,micbias4-microvolt = <1800000>;
> +
> +               qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000
> +                                                         500000 500000 500000>;
> +               qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
> +               qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
> +       };
>  };
>
>  &apps_rsc {
> @@ -496,6 +529,148 @@
>         drive-strength = <6>;
>  };
>
> +&soc {
> +       rxmacro: rxmacro@3200000 {

From the bindings document, I believe the node name should be
"codec@3200000", not "rxmacro@..."


> +               pinctrl-names = "default";
> +               pinctrl-0 = <&rx_swr_active>;
> +               compatible = "qcom,sc7280-lpass-rx-macro";
> +               reg = <0 0x3200000 0 0x1000>;

The first two entries should be compatible and reg. Same for many places below.

> +
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                        <&vamacro>;
> +               clock-names = "mclk", "npl", "fsgen";

Bindings document shows 5 clocks. You only specify 3. You either need
the extra clocks or you need to change the binding to allow for fewer.


> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";

Why is power-domain stuff not in the bindings? Oh, I see. It's listed
as clocks there? You need to sort that out in the bindings.


> +               #clock-cells = <0>;
> +               clock-frequency = <9600000>;
> +               clock-output-names = "mclk";
> +               #sound-dai-cells = <1>;
> +       };
> +
> +       swr0: soundwire@3210000 {
> +               reg = <0 0x3210000 0 0x2000>;
> +               compatible = "qcom,soundwire-v1.6.0";
> +               interrupts = <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&rxmacro>;
> +               clock-names = "iface";
> +               label = "RX";

label is not in the bindings.


> +               qcom,din-ports = <0>;
> +               qcom,dout-ports = <5>;
> +               qcom,swrm-hctl-reg = <0x032a90a0>;

qcom,swrm-hctl-reg is not in the bindings, right? It also looks like a
magic value and probably should be broken out into something more
meaningful.


> +               qcom,ports-word-length =        /bits/ 8 <0x01 0x07 0x04 0xFF 0xFF>;
> +               qcom,ports-sinterval-low =      /bits/ 8 <0x03 0x3F 0x1F 0x03 0x03>;
> +               qcom,ports-offset1 =            /bits/ 8 <0x00 0x00 0x0B 0x01 0x01>;
> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x0B 0x00 0x00>;
> +               qcom,ports-lane-control =       /bits/ 8 <0x01 0x00 0x00 0x00 0x00>;
> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0x00 0x01 0xFF 0xFF>;
> +               qcom,ports-hstart =             /bits/ 8 <0xFF 0x03 0xFF 0xFF 0xFF>;
> +               qcom,ports-hstop =              /bits/ 8 <0xFF 0x06 0xFF 0xFF 0xFF>;
> +               qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF 0xFF 0x00>;
> +
> +               #sound-dai-cells = <1>;
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +       };
> +
> +       txmacro: txmacro@3220000 {
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&tx_swr_active>;
> +               compatible = "qcom,sc7280-lpass-tx-macro";
> +               reg = <0 0x3220000 0 0x1000>;
> +
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>,
> +                        <&lpass_aon LPASS_AON_CC_TX_MCLK_2X_CLK>,
> +                        <&vamacro>;
> +               clock-names = "mclk", "npl", "fsgen";
> +
> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";

Again you've got mismatch w/ the bindings on clocks and power-domains.


> +               #clock-cells = <0>;
> +               clock-frequency = <9600000>;
> +               clock-output-names = "mclk";
> +               #address-cells = <2>;
> +               #size-cells = <2>;

Why address and size cells of 2???


> +               #sound-dai-cells = <1>;
> +       };
> +
> +       swr1: soundwire@3230000 {
> +               reg = <0 0x3230000 0 0x2000>;
> +               compatible = "qcom,soundwire-v1.6.0";
> +
> +               interrupts-extended =
> +                               <&intc GIC_SPI 496 IRQ_TYPE_LEVEL_HIGH>,
> +                               <&pdc 130 IRQ_TYPE_LEVEL_HIGH>;
> +               interrupt-names = "swr_master_irq", "swr_wake_irq";
> +               clocks = <&txmacro>;
> +               clock-names = "iface";
> +               label = "TX";
> +
> +               qcom,din-ports = <3>;
> +               qcom,dout-ports = <0>;
> +               qcom,swrm-hctl-reg = <0x032a90a8>;
> +
> +               qcom,ports-sinterval-low =      /bits/ 8 <0x01 0x03 0x03>;
> +               qcom,ports-offset1 =            /bits/ 8 <0x01 0x00 0x02>;
> +               qcom,ports-offset2 =            /bits/ 8 <0x00 0x00 0x00>;
> +               qcom,ports-hstart =             /bits/ 8 <0xFF 0xFF 0xFF>;
> +               qcom,ports-hstop =              /bits/ 8 <0xFF 0xFF 0xFF>;
> +               qcom,ports-word-length =        /bits/ 8 <0xFF 0x0 0xFF>;
> +               qcom,ports-block-pack-mode =    /bits/ 8 <0xFF 0xFF 0xFF>;
> +               qcom,ports-block-group-count =  /bits/ 8 <0xFF 0xFF 0xFF>;
> +               qcom,ports-lane-control =       /bits/ 8 <0x00 0x01 0x00>;
> +               qcom,port-offset = <1>;
> +
> +               #sound-dai-cells = <1>;
> +               #address-cells = <2>;
> +               #size-cells = <0>;
> +       };

Same comments as with swr0.


> +       vamacro: codec@3370000 {
> +               compatible = "qcom,sc7280-lpass-va-macro";
> +               pinctrl-0 = <&dmic01_active>;
> +               pinctrl-names = "default";
> +
> +               reg = <0 0x3370000 0 0x1000>;
> +               clocks = <&lpass_aon LPASS_AON_CC_TX_MCLK_CLK>;
> +               clock-names = "mclk";
> +
> +               power-domains = <&lpass_hm LPASS_CORE_CC_LPASS_CORE_HM_GDSC>,
> +                               <&lpass_aon LPASS_AON_CC_LPASS_AUDIO_HM_GDSC>;
> +               power-domain-names ="macro", "dcodec";

Again mismatch w/ bindings on clocks / power-domains.


> +               #clock-cells = <0>;
> +               clock-frequency = <9600000>;
> +               clock-output-names = "fsgen";
> +               #sound-dai-cells = <1>;
> +       };
> +};
> +
> +&swr0 {

This is in the same file, right? Just put it above right under the node.


> +       wcd_rx: wcd938x-hph-playback {

Please follow the bindings. Use the node name "codec" and include the
unit address, so this should be codec@0,4.


> +               compatible = "sdw20217010d00";
> +               reg = <0 4>;
> +               #sound-dai-cells = <1>;
> +               qcom,rx-port-mapping = <1 2 3 4 5>;
> +       };
> +};
> +
> +&swr1 {
> +       wcd_tx: wcd938x-hph-capture {
> +               compatible = "sdw20217010d00";
> +               reg = <0 3>;
> +               #sound-dai-cells = <1>;
> +               qcom,tx-port-mapping = <1 2 3 4>;
> +       };

Same comments as with swr0.
