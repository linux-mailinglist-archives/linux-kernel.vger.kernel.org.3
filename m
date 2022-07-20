Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2105057B947
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241106AbiGTPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiGTPMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:12:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B41B56BB5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:12:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf4so33633063ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11rz+JYqlvtFNaz848/ywMV3WKlyEeWTOPJoIhEg7l0=;
        b=axp8CEyArBd2gp/VntDKi5fRS3SHOMbd5Ibbk50UObxhktGhuxOVTKctQdl4U58siE
         YsCugznl9jaGkMgtO2FuHOcEVfXzdAZLxFP0RL3lVdM6xfhoH91ep9Kp83blQ4mhR0qC
         Q413WH4qWJCxehLVlqGAr9HtjoO3BfsrCSdkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11rz+JYqlvtFNaz848/ywMV3WKlyEeWTOPJoIhEg7l0=;
        b=Pnto3D6/zPwVoYo5z4KFOWFKLabBdwcazg5dt7Tf7GBU2+i7dpV5fqoqFtaxZuEyZZ
         SK4Rcsj/9YtpbbsdO5un3cilndw0qRAO4/Rs6kiSGjglY/XePicaod4HHWMYn8KOtAK7
         GUWKYFXIlqOeRpqc9YowWXhsC3RFjfPg29Zo2HPp6HvT64EVajN4abVZg0pqsjoxUWvE
         AwH2B9ezJQCCIFHOalcf9IMMLtAnyxuvfZcZx/oyAo6UG2zvU+Dl8le2gDqEx9LRPcDm
         ccI48zuvEIO5irG8AuNDLPj6lvMT3op2e2flEP6/Rgr5pI6h6KzFlUXsUScIRXspTS+o
         nvUw==
X-Gm-Message-State: AJIora9F/yeWF1O8VvvDs7SNpmigwMtQfC1uGNyijsyqO0wivqtTUbq6
        7MoOPu/8wuEPTVAd/lsuhjo2P0t95R75OxUoGaM=
X-Google-Smtp-Source: AGRyM1t7j1My6S5vVFMxNYc5s8awz9rCOsBztyysGh904ZnevlPs16l2Mg8qcj5irCKqEyzmhwsbnA==
X-Received: by 2002:a17:907:7da6:b0:72f:136d:dba4 with SMTP id oz38-20020a1709077da600b0072f136ddba4mr21025288ejc.472.1658329924345;
        Wed, 20 Jul 2022 08:12:04 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id b18-20020a17090630d200b0072f5c1f05a4sm1696307ejb.44.2022.07.20.08.12.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 08:12:03 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id z13so6992658wro.13
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:12:03 -0700 (PDT)
X-Received: by 2002:adf:ead2:0:b0:21d:8b49:6138 with SMTP id
 o18-20020adfead2000000b0021d8b496138mr31641595wrn.138.1658329923136; Wed, 20
 Jul 2022 08:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220720073604.1.I249596c011ff05da5a95d72fc321e115ef859803@changeid>
In-Reply-To: <20220720073604.1.I249596c011ff05da5a95d72fc321e115ef859803@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Jul 2022 08:11:50 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XaDTJp+JLrwW7Hh5-7g0y_Vhqqtiv01quBh6wZZWQgmw@mail.gmail.com>
Message-ID: <CAD=FV=XaDTJp+JLrwW7Hh5-7g0y_Vhqqtiv01quBh6wZZWQgmw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Add SKU6 for sc7180-trogdor-pazquel-lte-parade
To:     Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Henry Sun <henrysun@google.com>,
        Bob Moragues <moragues@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 20, 2022 at 12:37 AM Yunlong Jia
<yunlong.jia@ecs.corp-partner.google.com> wrote:
>
> SKU6 is LTE(w/o eSIM)+WIFI+Parade
>
> Signed-off-by: Yunlong Jia <yunlong.jia@ecs.corp-partner.google.com>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> index 764c451c1a857..767cb7450c0d8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel-lte-parade.dts
> @@ -14,7 +14,7 @@
>
>  / {
>         model = "Google Pazquel (Parade,LTE)";
> -       compatible = "google,pazquel-sku4", "qcom,sc7180";
> +       compatible = "google,pazquel-sku6", "google,pazquel-sku4", "qcom,sc7180";

Now this doesn't match the bindings. The bindings list 4 first and
then 6. You are listing 6 first then 4. The order doesn't really
matter, but the two places need to match.

As Krzysztof says, you should be incrementing the version of your
patches, adding some history, and you should also put the two patches
in one series.

I believe you're using patman, so something like this and have _both_
changes applied and send them out.

In patch #1 (the bindings):

Series-changes: 3
- Bindings and dts in the same series.

In patch #2 (the dts):

Series-version: 3

Series-changes: 2
- Put sku6 before sku4

Series-changes: 3
- Bindings and dts in the same series.

-Doug
