Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C53C56A57B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiGGOdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiGGOdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:33:19 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFED82F672
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:33:18 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ez10so2613130ejc.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoyTQr6cMk+DYKdiMg3NC5XJCceUe1dyjyTAOmKK+S0=;
        b=lroVGXv6SSW4e0FiWRd/MeL568MO0S+YQA+5UXYvLt0cA7bV5CNRO2Vu4OlmIKq1DE
         StvwBV4/hBbWlM69Ll0CA5hEfffF8nojIZ1YTZDOCYGfu8poE/e9HCaQjPz9cb/b1OCA
         H0iQiOnI53icrgv0o5MjZQZTuGu8PZlghwbAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoyTQr6cMk+DYKdiMg3NC5XJCceUe1dyjyTAOmKK+S0=;
        b=slk9Zm3LIDtlhfyfqjIW5u9PV0QnJ7IZlA9ogwcyDT6MNh3VEIsoZcMLi/V140eKBX
         SEAj7rAyb0LF84Hux1P/hqm+X+WeRJ7Zfs8sNUjCA9Wl36d4dr1Kf1gIQ7eX6VG18goY
         WTU3fhcPZFwOIQbVdusM694EobM4DSwlELidmquCvdlWxpHlei56PHyht0YFuiPeyzDc
         ksk+9W/82R93VDbt5rTWN9p6dIREWJWoN1eZ2Kwkk0CzzYBk+pHWiY5DlCt3PmSN9nzs
         +i2ZK2d9I9O+sdq83cjxI+sOPal2EEZlY3Ip2+rgSUgZbps+WIeamJqT4XXyhtDtxJoD
         vuvQ==
X-Gm-Message-State: AJIora/9/Kd5z07zEE8KUBnLN1PP+pT8IwF+xOixLdmICfShGAU2AFNu
        l6WFn0S63vtp6kby3GA8tcV6umCD7sbk3VNo6yI=
X-Google-Smtp-Source: AGRyM1vBFSh0VgcVZoJZG99czzT/+0WSS+R1rtlIliKfpeeODlG/OKabjctbvilFato3XkJ1ICeQQg==
X-Received: by 2002:a17:906:9751:b0:722:e52b:aef7 with SMTP id o17-20020a170906975100b00722e52baef7mr43906159ejy.537.1657204397146;
        Thu, 07 Jul 2022 07:33:17 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906500f00b00722dceb3f8bsm19000672ejj.151.2022.07.07.07.33.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:33:15 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so13589625wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:33:14 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr4905076wms.57.1657204394580; Thu, 07
 Jul 2022 07:33:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-4-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:33:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W8mDtb0Bg4oAFdzn5m+XeXc_aiCrWVMPAz-ZhO1errPw@mail.gmail.com>
Message-ID: <CAD=FV=W8mDtb0Bg4oAFdzn5m+XeXc_aiCrWVMPAz-ZhO1errPw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ARM: dts: qcom: align SDHCI reg-names with DT schema
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
> DT schema requires SDHCI reg names to be hc/core without "_mem" suffix,
> just like TXT bindings were expecting before the conversion.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8084.dtsi | 4 ++--
>  arch/arm/boot/dts/qcom-ipq4019.dtsi | 1 +
>  arch/arm/boot/dts/qcom-msm8226.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-msm8974.dtsi | 6 +++---
>  arch/arm/boot/dts/qcom-sdx65.dtsi   | 2 +-
>  5 files changed, 10 insertions(+), 9 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
