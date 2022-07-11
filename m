Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1A57065B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiGKO5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiGKO5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:57:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F8672EC4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:57:46 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id fd6so6583472edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L4SJVp/qzuXB498bzW4+sHZWl8AD/7fDDuoRe4m/EV8=;
        b=eHy9FfeC30Gz/vqEEBhx3TlSwaqVg0Lo38v2BmIMbogsyk534NkhsoHhrbDW8BKxue
         9i5Z32wVVMbSt4fuloxWzRgcJ5o7Y8006NOeM1a1Qni/ZccipA8oQIDdmXsFRmbj1BcJ
         4XIJvr6Q2JkJqRZudHd0x1ZoJ1nMLEgkcyr5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L4SJVp/qzuXB498bzW4+sHZWl8AD/7fDDuoRe4m/EV8=;
        b=acpyjeLstm45TjMvB+0Di7jBBd8vmJ+sPTrSdEF1C6xJLPYdIC+HlVi6bvREuAAlID
         s7Hlc9NVzyo2XaJe7HX2LwGhA4LHQpdO4sDIN934cs2R2NUJ7I314ufyn2lj4JwWxtuz
         H6f468dlg0r5CbZIFUlQ6NfV9jH00Ct8GG9TmJCPFCCwUIX8JPQF/uTXvB60aeVfhn0T
         X0GwMAOWF+VaZkoJUqEAzoFgYeNhNy3a+CvaGxJmjuk1Xd/HYDbtiOFePy1H1WM9wgHO
         SGcm8QdVOKNuDuDJofLOeqTsUPTfHtwLsmn9G7pj3OD/rbRlBENamQqCJ76mmArAcDPK
         UeJQ==
X-Gm-Message-State: AJIora/TK4e+peLjuGZiVYbhgsjTX4nezTZn+XN0VgLzONMXXARqZgiO
        xWZBKlgTwvhhjlR2IuuHW75cjY+9X/Xf5pHG
X-Google-Smtp-Source: AGRyM1u2dfG2sU8Rv0ZemgyeFEZk0m0qZJTonE84T/ti84cD/XLH0y+QFDmPYf4rjG0YL3CT0cgSEw==
X-Received: by 2002:a05:6402:510a:b0:43a:91ff:3f4b with SMTP id m10-20020a056402510a00b0043a91ff3f4bmr25294087edd.187.1657551464845;
        Mon, 11 Jul 2022 07:57:44 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id i17-20020a05640200d100b00435c10b5daesm4466212edu.34.2022.07.11.07.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 07:57:44 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id h17so7421241wrx.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:57:44 -0700 (PDT)
X-Received: by 2002:adf:d1c1:0:b0:21b:a5e9:b7b2 with SMTP id
 b1-20020adfd1c1000000b0021ba5e9b7b2mr17494906wrd.405.1657551463678; Mon, 11
 Jul 2022 07:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220711082648.38987-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220711082648.38987-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 07:57:29 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WMJ1BX-uA4eavocbAGjpSsEYhoYGSha9gBYsqAXhHX-g@mail.gmail.com>
Message-ID: <CAD=FV=WMJ1BX-uA4eavocbAGjpSsEYhoYGSha9gBYsqAXhHX-g@mail.gmail.com>
Subject: Re: [PATCH RFT] arm64: dts: qcom: sm6125: fix SDHCI CQE reg names
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 1:26 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> SM6125 comes with SDCC (SDHCI controller) v5, so the second range of
> registers is cqhci, not core.
>
> Fixes: cff4bbaf2a2d ("arm64: dts: qcom: Add support for SM6125")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> ---
>
> Not tested on hardware, but no practical impact is expected, because
> supports-cqe is not defined.

Maybe the schema should enforce this? If "cqhci" is in reg-names then
you must have supports-cqe and vice versa?


> ---
>  arch/arm64/boot/dts/qcom/sm6125.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> index 77bff81af433..7664ef7e4da9 100644
> --- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
> @@ -438,7 +438,7 @@ rpm_msg_ram: sram@45f0000 {
>                 sdhc_1: mmc@4744000 {
>                         compatible = "qcom,sm6125-sdhci", "qcom,sdhci-msm-v5";
>                         reg = <0x04744000 0x1000>, <0x04745000 0x1000>;
> -                       reg-names = "hc", "core";
> +                       reg-names = "hc", "cqhci";

Another possible fix would be to just delete the second register
range. Then it could be added back in once "supports-cqe" was added.

-Doug
