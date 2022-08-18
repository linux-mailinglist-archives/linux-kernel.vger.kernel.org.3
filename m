Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9A5598AA1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 19:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbiHRRoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239531AbiHRRn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 13:43:58 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B79E61D47
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:43:56 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id i2so1124506vkk.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1b9aTxIIz9/74/jYE0z5xvzqLFfDp/MoiZcviUgQWJ8=;
        b=Du+adRQQBzyfPvEtwcg6Q6ErkgIm3DL4MsEH4J9V/VihvaXqlIpoazABA4ake/s+QY
         SdIjmTgU4xgML/xDG3oW1BVlUEHH50QwzUHSU8HexnO1MQjTKXqD0ZxuQToamtoYJ55g
         LJF93G4W48p1Eqd9GdnglIwVnNmxi7s6oGhC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1b9aTxIIz9/74/jYE0z5xvzqLFfDp/MoiZcviUgQWJ8=;
        b=CRUTiFa8Gxrb/h4mzmEkHVD2TwknSJMeL8M0oZ+OXliacrYY761F8wFE0dv06bVLN3
         UzhALVjAEXAc4O11jLoGbYLYElORLlckuw/9G2VcODFVY2O23xX9lz7HClByVw1V+GSy
         /VLG1s8WXN9guzugoY3o870iw19kBH9LtUlnNcoQH5GvVSE5QtGm5UXlY8FXPNgWQNzd
         p93Z1D7nBp9i8S1qKz4VAHHNyM7XNdSYKCFfUgoMTOHEcRJFKmvxEktF+AFQYcgVP8Gt
         XnlhGIP7YXSHgHARkwHrMHe3XPd/oRhjaNqVOpAYxnhekfl0LbYm4ifg9bhqzgh1cbWM
         x9Ig==
X-Gm-Message-State: ACgBeo2DrVMxipJHShzsFYkr/mYZ9rvAcY/yXhaQcL5zXMnU9xly6Awp
        dwQ2KWUodaf2QLIMd04GV4ErOcegAUcqtg==
X-Google-Smtp-Source: AA6agR6Ed3bJ1tj/eY87c9qpCUscsbdXgkaboJGfRdNeE6zRI15LSQjq+lxuIgjOSciGs8M3sKk2Ww==
X-Received: by 2002:a1f:2d06:0:b0:380:679d:fb9b with SMTP id t6-20020a1f2d06000000b00380679dfb9bmr1667591vkt.25.1660844635509;
        Thu, 18 Aug 2022 10:43:55 -0700 (PDT)
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com. [209.85.217.51])
        by smtp.gmail.com with ESMTPSA id q206-20020a1fa7d7000000b0038030db4c79sm1266049vke.54.2022.08.18.10.43.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 10:43:54 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id k2so2197875vsk.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 10:43:54 -0700 (PDT)
X-Received: by 2002:a67:a20d:0:b0:388:5ed2:7c7b with SMTP id
 l13-20020a67a20d000000b003885ed27c7bmr1621593vse.5.1660844633605; Thu, 18 Aug
 2022 10:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
In-Reply-To: <20220818084216.1.I5c2b6fea19c4c0dec67fd4931f03df8e5ccaca95@changeid>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Thu, 18 Aug 2022 10:43:17 -0700
X-Gmail-Original-Message-ID: <CAHNYxRzRgqXPq0s3Pop_t0K+yAyO4MX1D1jY0buqw7s8kv0F=A@mail.gmail.com>
Message-ID: <CAHNYxRzRgqXPq0s3Pop_t0K+yAyO4MX1D1jY0buqw7s8kv0F=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Add sleep state for alc5682 codec
To:     "Joseph S. Barrera III" <joebar@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 8:42 AM Joseph S. Barrera III
<joebar@chromium.org> wrote:
>
> Add sleep state to acl5682. In default, gpio28 (HP_IRQ) is bias-pull-up.
> To save power, in the new sleep state, gpio28 is bias-disable.
>
> sleeping, /sys/kernel/debug/gpio shows gpio28 as "no pull". When codec
> is awake (microphone plugged in and in use), it shows gpio28 as "pull up".
>
> Signed-off-by: Joseph S. Barrera III <joebar@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> index b5f534db135a..94dd6c34d997 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
> @@ -755,8 +755,9 @@ hp_i2c: &i2c9 {
>         alc5682: codec@1a {
>                 compatible = "realtek,rt5682i";
>                 reg = <0x1a>;
> -               pinctrl-names = "default";
> +               pinctrl-names = "default", "sleep";
>                 pinctrl-0 = <&hp_irq>;
> +               pinctrl-1 = <&hp_sleep>;
>
>                 #sound-dai-cells = <1>;
>
> @@ -1336,6 +1337,18 @@ pinconf {
>                 };
>         };
>
> +       hp_sleep: hp-sleep {
> +               pinmux {
> +                       pins = "gpio28";
> +                       function = "gpio";
> +               };
> +
> +               pinconf {
> +                       pins = "gpio28";
> +                       bias-disable;
> +               };
> +       };
> +
>         pen_irq_l: pen-irq-l {
>                 pinmux {
>                         pins = "gpio21";
> --
> 2.31.0
>

Thanks, this should save us a current leak.

Reviewed-by: Alexandru Stan <amstan@chromium.org>
