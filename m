Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38756A57F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiGGOd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235638AbiGGOd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:33:58 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469852A732
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:33:55 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z41so23433866ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Qaml/77EQfjVhTCPwJZGqOZHtYBkRsro8IPW1LDth0=;
        b=nGfPTVAksZnzIOYm3NKGz8gMMXNR8VQHECNNmE3N0p4ZtbshAnhr3JQ4+Fisy6PmVw
         DRHRkgubLyYcUlKfxZq/e8nSnXjAtIKNR3YM3AT3ODuVedDkx5EZ0mPt9QtVzWFQFaSO
         y1eXzyiTvypdbAAfNwawa+5t2TnhAqO0Z6WLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Qaml/77EQfjVhTCPwJZGqOZHtYBkRsro8IPW1LDth0=;
        b=knfQDA/+iyB2l3CbcMGkR4tm3NlfutSsmDWCuAkgEqDEt7VAUqfZOEfys/lwI/aqXx
         TUQs8NYp6V29XTrJTfpS4a9a0mHmDWI5OAF+RWFMNJ5jDA++Q4dw5W4lqNEQSccVKs/u
         krGmuhANms+7bb86DsUbt87JUXQBqQEuKA2HUBIclAMQTEQS0jRqGdIwIfZYBRMjFcsb
         ltXZ7bCrGHdvNrerU0LFetsYRfGwuqIVh8i+KxqlNRWlcsRPpxzy3EL3G0i60lIPNT3v
         0I5zjDXpYHGPMIYeJLhKKLO6sTvmipFCJSspZrNaSwuQNRknPUA1vKgZEtZuz90Zv1jC
         +qbQ==
X-Gm-Message-State: AJIora/1mtBB1FYJey5d1ePx80zLLcjB6Zzg+2xbqgOYXZIDBNyLqnhC
        zj0HIwfuaUBmEvrQHFEih7V4ndJVqoe6ca16GS8=
X-Google-Smtp-Source: AGRyM1s1AdGpfizhNKrt5a94Ly1QyhweIAmwuzTH1p0H2+lJpxV0XDZdLabwGjf6MrWprXpvq/i/5g==
X-Received: by 2002:a05:6402:3486:b0:43a:9b82:6d8a with SMTP id v6-20020a056402348600b0043a9b826d8amr4785391edc.23.1657204433713;
        Thu, 07 Jul 2022 07:33:53 -0700 (PDT)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id kw11-20020a170907770b00b0072af890f52dsm2624169ejc.88.2022.07.07.07.33.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 07:33:52 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so10834499wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:33:52 -0700 (PDT)
X-Received: by 2002:a05:600c:2049:b0:3a0:536b:c01b with SMTP id
 p9-20020a05600c204900b003a0536bc01bmr4978327wmg.151.1657204431600; Thu, 07
 Jul 2022 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220707075151.67335-1-krzysztof.kozlowski@linaro.org> <20220707075151.67335-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220707075151.67335-5-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 7 Jul 2022 07:33:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W2d_TCqr+YHV0ep=4o9eqLY7YvF8Khxm2Vsi3uG11nPg@mail.gmail.com>
Message-ID: <CAD=FV=W2d_TCqr+YHV0ep=4o9eqLY7YvF8Khxm2Vsi3uG11nPg@mail.gmail.com>
Subject: Re: [PATCH 4/5] arm64: dts: qcom: align SDHCI reg-names with DT schema
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
>  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
>  arch/arm64/boot/dts/qcom/msm8916.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8953.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8994.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 ++--
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 2 +-
>  6 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
