Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AC573AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiGMP6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiGMP6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:58:02 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC9850058
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:58:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dn9so20614959ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/Vj1VhdY5NW6ohPgoVwI8+jslVLxU7aofSuN+zvekk=;
        b=oUXldJ8ZPFnIrUN6j4zP6t/M60/eQCX1n+2O4QAs8x351TwUOianbZzOD/qVR5Xbc1
         VgSyE5rPJF83VQ4d0XEI/Dg0M49+YbqXCJDEM1JqYcaQBRedJVat7BoSiFToqHh60rwm
         6mQxbKhfNx7JevSsNTK0eoU3OPJfhmJvL0syA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/Vj1VhdY5NW6ohPgoVwI8+jslVLxU7aofSuN+zvekk=;
        b=lTaxTL56Gvuk/Ep23EdWQ5njqYoZqa2zy1QktRni8FdgoxMUcz+annHZo9Jled91+i
         j/OBFRRCXTCEqTHuKEvuY3siXAiQqf5MxUb8tT7hFhadyyhlljhS/6NSmd3VaJNmUjJA
         1cyGXREgWdbn9FybKb4076u1fw8arFUTvWUPYPI8GRazzXr/fGt17sgu6tQZmoKetPLO
         I5N76yFuqg06FAuvYWg1RHcR46DVmdR1+i6E5Dj8JTTKt0ns7weDYMoP11drqvs0txWB
         sz9MPN9O5QaXflPtDIGx3nUjN7Z9uUUeUnO69Isn05NHph5uUhqrn62rEcUXBFpUT7fw
         9qIg==
X-Gm-Message-State: AJIora/jWhhxvlhWdDYyke0YYmstMMdzBtfWj6cG7nTRAfnM2DuOcDsE
        lqauytQ9920sJfR4B+ZU+976n6T/kVhJcZ+Z
X-Google-Smtp-Source: AGRyM1vjUbRP82TvnxQQR2qARY5tr7GOaAJ7YQceD0LEyRM5FbVS9ZODS6LIal/7zlLN2o/X+450Fg==
X-Received: by 2002:a17:907:2855:b0:72b:67b7:2c28 with SMTP id el21-20020a170907285500b0072b67b72c28mr4060623ejc.331.1657727879635;
        Wed, 13 Jul 2022 08:57:59 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id c5-20020aa7c745000000b0043a706d3a48sm8243625eds.76.2022.07.13.08.57.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 08:57:58 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id b26so16134493wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:57:57 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr4002688wrr.617.1657727877212; Wed, 13
 Jul 2022 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220712150219.20539-1-krzysztof.kozlowski@linaro.org> <20220712150219.20539-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712150219.20539-4-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Jul 2022 08:57:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VPHwkKUjanLtaM+cXdp+VGPExJ_XDe=-O8j=ayGNtnVQ@mail.gmail.com>
Message-ID: <CAD=FV=VPHwkKUjanLtaM+cXdp+VGPExJ_XDe=-O8j=ayGNtnVQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-msm: drop redundant of_device_id entries
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 12, 2022 at 8:02 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> This reverts three commits:
> 1. Revert "mmc: sdhci-msm: Add compatible string check for sdx65"
>    This reverts commit 953706844f0f2fd4dc6984cc010fe6cf51c041f2.
>
> 2. Revert "mmc: sdhci-msm: Add compatible string check for sm8150"
>    This reverts commit 5acd6adb65802cc6f9986be3750179a820580d37.
>
> 3. Revert "mmc: sdhci-msm: Add SoC specific compatibles"
>    This reverts commit 466614a9765c6fb67e1464d0a3f1261db903834b.
>
> The oldest commit 466614a9765c ("mmc: sdhci-msm: Add SoC specific
> compatibles") did not specify what benefits such multiple compatibles
> bring, therefore assume there is none.  On the other hand such approach
> brings a lot of churn to driver maintenance by expecting commit for
> every new compatible, even though it is already covered by the fallback.
>
> There is really no sense in duplicating of_device_id for each
> variant, which is already covered by generic compatible fallback
> qcom,sdhci-msm-v4 or qcom,sdhci-msm-v5.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Personally, I would have taken the extra step and added a comment in
the code to prevent someone from doing this again. Maybe like this:

/*
 * In the device tree, all boards are required to have _two_ compatible
 * strings listed: a SoC-specific one followed by a more generic one.
 * Normally we can just rely on the generic string, but we always
 * include both so that if we ever find a bug on a specific SoC that
 * we need to workaround (like in sdm845/sc7180) that we can quickly
 * work around it without any changes to the dts.
 */

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
