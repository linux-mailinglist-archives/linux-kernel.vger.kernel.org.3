Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFB9522505
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiEJTt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiEJTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:49:48 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6562689C5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:49:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g6so35047003ejw.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgwVFN5ZXlnWfmxKkcCyw+qVwt2BQmrdrtZrCkyPCa0=;
        b=BM+NJmlQLhHE0L9ymWoYJ4kB8ijA58RwwkGxB+c+rn/XAKZCVn1Cn+VfNX96/eHvGd
         f+OXHbiOVAtesaJYTI1pfk/MRNaHMtTzuX8G+q7Dn3SC37t18dcdhqBhfIoo6DJXm/7B
         hclx4e1LYUQOt7AuRQwhn2/i7BglcQhY6f19s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgwVFN5ZXlnWfmxKkcCyw+qVwt2BQmrdrtZrCkyPCa0=;
        b=uGglfqxk5jWr9zmtLkccPBbCYM+KeTP8CdyKI7+e8pA/B2OCooIdQoUWjcZB2RzJDf
         mKR80DEzgI+hPNiOcWNUOiU4nJtZdV5PxGmj0RBWzO6msqC+zBHop2dVATiwq3vewIPz
         B4Gr3BPC98q7CtlFEVhkFoFpcmZayRdXQGpucpFHHK7qWSm+yggaaXK3q5hQzd1dw0JE
         eZTzQNfGXshae6WPFTWYsr6NwPuQSIvCIcbZhN/4r9Vcsk8zjddteqZT+z+j+RG+yWa8
         60Dt9Ov6cw04YexOHNZzTohR3o4R5iXRJR472ASQKUjo0XO+4OMj027G9CzdYEwXjZKg
         WPhw==
X-Gm-Message-State: AOAM533kIJX8NsBiC/zCGWOFU1fiX+p1uhPof63AQ9tRDdsc8q9EbBBu
        vSEgUlTOeAxlo2qk1vO+KZ+XT8b6yaUyRboO
X-Google-Smtp-Source: ABdhPJzalJz1mYa5eq1Zn/a8XeIAVhwlXLKqiHkEWXI5mwjoS7anRBEV+PMUmrxyvSsMj7AVj8LUtg==
X-Received: by 2002:a17:906:478b:b0:6f8:5850:4da9 with SMTP id cw11-20020a170906478b00b006f858504da9mr17422501ejc.619.1652212185164;
        Tue, 10 May 2022 12:49:45 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id bd23-20020a056402207700b0042617ba63a3sm49285edb.45.2022.05.10.12.49.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 12:49:44 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id v64-20020a1cac43000000b0038cfd1b3a6dso1940485wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 12:49:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3d8c:b0:394:6097:9994 with SMTP id
 bi12-20020a05600c3d8c00b0039460979994mr1474094wmb.29.1652212183882; Tue, 10
 May 2022 12:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
In-Reply-To: <20220510104656.1.Id98b473e08c950f9a461826dde187ef7705a928c@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 May 2022 12:49:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U33QSjnD7ERdVBb+hk4yooGU5=C0FtnhFsDME_MePR0w@mail.gmail.com>
Message-ID: <CAD=FV=U33QSjnD7ERdVBb+hk4yooGU5=C0FtnhFsDME_MePR0w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc7280: Set modem FW path for Chrome OS boards
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 10, 2022 at 10:47 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Specify the path of the modem FW for SC7280 Chrome OS boards in
> the 'remoteproc_mpss' node.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> index 9f4a9c263c35..995c5bd12549 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi
> @@ -89,6 +89,8 @@ &remoteproc_mpss {
>         compatible = "qcom,sc7280-mss-pil";
>         iommus = <&apps_smmu 0x124 0x0>, <&apps_smmu 0x488 0x7>;
>         memory-region = <&mba_mem>, <&mpss_mem>;
> +       firmware-name = "qcom/sc7280-herobrine/modem/mba.mbn",
> +                       "qcom/sc7280-herobrine/modem/qdsp6sw.mbn";

We don't necessarily need to change anything, but a few thoughts:

1. I guess technically we don't actually need the "modem" subdirectory
for herobrine, right? WiFi works differently on sc7280 so we won't
have a "no modem" modem firmware. ...but I guess it doesn't hurt to
have it and it's nice to keep it symmetric.

2. Whenever we're ready to support WiFi only SKUs then I guess it'll
still be OK to specify the firmware name. We'll just set the status of
"&mdss_dp" to "disabled".

3. It's slightly weird that we're using the name "herobrine" but
putting the change in the "chrome-common.dtsi" file. Should it be
"sc7280-chrome" instead?

-Doug
