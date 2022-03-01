Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002714C8025
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 02:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiCABLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 20:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiCABLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 20:11:08 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FB5F6D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:10:28 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id hw13so28289566ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BbqDwcjXsXCL6kTMj0YCp6PGwzr/251RPmtgzCoFEyg=;
        b=Ik+NVh3CPD8GsoJYQqmUUGgp15DF5ACPGNAA3aEa+OtKST1rLe5gBLLmayjH3liIyT
         zYsDmk39c7rHmGbFKJ4PImoNKy5RX5cy1kfe2mXgGT1zSW4ymL3cmNbnY7EaK9CpzaUe
         bj+bd/arywMdD8u8U+Xuwf26B5pjNxrE1+n/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BbqDwcjXsXCL6kTMj0YCp6PGwzr/251RPmtgzCoFEyg=;
        b=49FyQ+MOjmFVR7k7u9JxlDfenp9r7K7H8A6pwypGPwLuiJRXLYcak/CDGomzHXORDo
         Z63P3bBBCoopziaQwPrBSI0ZucH1AP8r1qeeZSsuZxF4qX5kConaWabGIdsG9wzcjeWD
         Lbg/GKKaUjmWgjApKMTsqSsC35lXj8G001bgp/mSON2IxuxG3uBYD3PHbThLRIhEcytN
         P8js6Js8n2ALgc7mlIg2mGkbtWOghG2XAiWcwhEgRbvfSPzI0vhnbifviSubpR6pHPOP
         RfYAQFALsj9BjZz15YZKwjiBnVkysw5W4l3LqG6jXlV8ahqbGFbmKsdLonAm2sM7tmHU
         kZMQ==
X-Gm-Message-State: AOAM530n41JrR5EejFuk3gT5T0SmAZ8yysZISXg2Pxi3Yt9ye1DgAUq8
        36ihent7TJfsR1RS9aGRUbjzCPKovA0BppuD
X-Google-Smtp-Source: ABdhPJzxzfBpUxm+TCLQLxaR8GLE6FG88snbyOjd2PUV74pyMJUGXR2IhJezd3BMJujT3X3UHkzqJg==
X-Received: by 2002:a17:906:f87:b0:6d6:dd04:147b with SMTP id q7-20020a1709060f8700b006d6dd04147bmr2495479ejj.80.1646097026688;
        Mon, 28 Feb 2022 17:10:26 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id y12-20020a50eb8c000000b00410f02e577esm6849368edr.7.2022.02.28.17.10.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 17:10:25 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id i8so964177wrr.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 17:10:24 -0800 (PST)
X-Received: by 2002:a5d:62cb:0:b0:1ef:5d3f:7b56 with SMTP id
 o11-20020a5d62cb000000b001ef5d3f7b56mr14343243wrv.513.1646097024460; Mon, 28
 Feb 2022 17:10:24 -0800 (PST)
MIME-Version: 1.0
References: <1644591438-6514-1-git-send-email-quic_srivasam@quicinc.com> <1644591438-6514-3-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1644591438-6514-3-git-send-email-quic_srivasam@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 28 Feb 2022 17:10:12 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xm7UVXX9NQfKs+BymsZpG+aoYqvXXRL5WhJjEZRqi7ug@mail.gmail.com>
Message-ID: <CAD=FV=Xm7UVXX9NQfKs+BymsZpG+aoYqvXXRL5WhJjEZRqi7ug@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: qcom: sc7280: Add lpass cpu node
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
> @@ -1750,6 +1751,64 @@
>                         #clock-cells = <1>;
>                 };
>
> +               lpass_cpu: audio-subsystem@3260000 {
> +                       compatible = "qcom,sc7280-lpass-cpu";
> +                       reg = <0 0x3260000 0 0xC000>,
> +                             <0 0x3280000 0 0x29000>,
> +                             <0 0x3340000 0 0x29000>,
> +                             <0 0x336C000 0 0x3000>,
> +                             <0 0x3987000 0 0x68000>,
> +                             <0 0x3B00000 0 0x29000>;

Lower case hex, please. ...and pad the address to 8 digits here (just
don't do it in the unit address in the node name).


> +                       reg-names = "lpass-rxtx-cdc-dma-lpm",
> +                                   "lpass-rxtx-lpaif",
> +                                   "lpass-va-lpaif",
> +                                   "lpass-va-cdc-dma-lpm",
> +                                   "lpass-hdmiif",
> +                                   "lpass-lpaif";

The order of "reg" and "reg-names" needs to match the bindings
exactly. It's almost certainly easier to change your device tree since
the bindings have already landed.

That means that "lpass-hdmiif" will be first. ...and it will also
change your node name since the first "reg" listed will now be
3987000.


> +                       iommus = <&apps_smmu 0x1820 0>,
> +                                <&apps_smmu 0x1821 0>,
> +                                <&apps_smmu 0x1832 0>;
> +                       status = "disabled";
> +
> +                       power-domains = <&rpmhpd SC7280_LCX>;
> +                       power-domain-names = "lcx";

power-domain-names is not in the bindings.


> +                       required-opps = <&rpmhpd_opp_nom>;
> +
> +                       clocks = <&lpass_aon LPASS_AON_CC_AUDIO_HM_H_CLK>,
> +                                <&lpasscore LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK>,
> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM_CLK>,
> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM0_CLK>,
> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM1_CLK>,
> +                                <&lpass_audiocc LPASS_AUDIO_CC_CODEC_MEM2_CLK>,
> +                                <&lpasscore LPASS_CORE_CC_EXT_IF0_IBIT_CLK>,
> +                                <&lpasscore LPASS_CORE_CC_EXT_IF1_IBIT_CLK>,
> +                                <&lpass_aon LPASS_AON_CC_VA_MEM0_CLK>;
> +                       clock-names = "aon_cc_audio_hm_h",
> +                                     "core_cc_sysnoc_mport_core",
> +                                     "audio_cc_codec_mem",
> +                                     "audio_cc_codec_mem0",
> +                                     "audio_cc_codec_mem1",
> +                                     "audio_cc_codec_mem2",
> +                                     "core_cc_ext_if0_ibit",
> +                                     "core_cc_ext_if1_ibit",
> +                                     "aon_cc_va_mem0";

Clocks do not match bindings.


> +                       #sound-dai-cells = <1>;
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       interrupts = <GIC_SPI 160 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 180 IRQ_TYPE_LEVEL_HIGH>,
> +                                    <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       interrupt-names = "lpass-irq-lpaif",
> +                                         "lpass-irq-vaif",
> +                                         "lpass-irq-rxtxif",
> +                                         "lpass-irq-hdmi";

interrupt-names ordering does not match bindings.


-Doug
