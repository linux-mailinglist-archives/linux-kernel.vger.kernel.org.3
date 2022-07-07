Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17CD56A58C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiGGOfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiGGOfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:35:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634192F67D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:35:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n8so23454512eda.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6R/ddtNSwfm7ty86Jg8Rk/94EllRS1alXZobv2bNWis=;
        b=nop4+PYaSie6cLDfOoz79jPZj+LmcL3qmT5jqfFfbawptaU2DSYNGb9uCsJ6ie6CBA
         044wbTmELbC6ll9dHCgX/qKoXRUW4Gt58A8QRV6+vaYK5VZxmSNh9JGnRQJEzvaXSXoZ
         p894kw4QPJoW/iXmBPjcZx7ieiwtgw4Ew+ydA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6R/ddtNSwfm7ty86Jg8Rk/94EllRS1alXZobv2bNWis=;
        b=TMZFG0EAwGDdec64Lu7gkRGJYY67OcHivW73cOq372L6z9Ti+K0yNL/VebqGAVZEeV
         cwOj+PeZhvol/7TIaSeUWJrSdjwGK/shvQaAE8OCVNNSnvKCrUpPKAmg6tMR11BmiJWy
         +tbbLFnhEAY0VHEgO/xewXKxpi3ukZ4pXKJwC/nezpvQ0P4ANDAHv9rb2+62i78/WQKK
         sSqjV7Pcw2uVVNmjR57/J7LKF/zposUbZoo6j9DEayMuANzs5O4KYppMR8AeEakbU60r
         1UR1t5+YO72f2738CO9ksjsWFTUX+EX+XVHBE74/t37YvqYO4We4szanrQu0lG1F0yFB
         ZKxA==
X-Gm-Message-State: AJIora920owBV7PSFxx+sAe8yjQvwd2hXRY/ObRoYHeUzXmJ+8k/Vtlu
        WZ51erq3n7E/hyAM0vfasBCnHp4zGv5j9Ng07gA=
X-Google-Smtp-Source: AGRyM1uWSae5yZ2vD2ebnA/MbiOf9usorJ1WcZYO4NaFjKA3QXmOI6ArMG7k4ReF+KWna2/7SdZEiA==
X-Received: by 2002:a05:6402:22a1:b0:437:78c2:d02b with SMTP id cx1-20020a05640222a100b0043778c2d02bmr62070775edb.64.1657204542664;
        Thu, 07 Jul 2022 07:35:42 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709063a0500b00722fadc4279sm18855873eje.124.2022.07.07.07.35.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:35:42 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id s1so26615381wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:35:41 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr45296183wrd.405.1657204541324; Thu, 07
 Jul 2022 07:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-6-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:35:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XOGLH9UH4Bwd3E6RC_PT5A4bf20muhnZoW5Rb8O3b2LA@mail.gmail.com>
Message-ID: <CAD=FV=XOGLH9UH4Bwd3E6RC_PT5A4bf20muhnZoW5Rb8O3b2LA@mail.gmail.com>
Subject: Re: [PATCH 5/5] ARM: dts: qcom: align SDHCI clocks with DT schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Thu, Jul 7, 2022 at 1:04 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The DT schema expects clocks iface-core order.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi    | 12 ++++++------
>  arch/arm/boot/dts/qcom-ipq4019.dtsi    |  4 ++--
>  arch/arm/boot/dts/qcom-msm8226.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974.dtsi    | 18 +++++++++---------
>  arch/arm/boot/dts/qcom-msm8974pro.dtsi |  6 +++---
>  5 files changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
