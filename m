Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5634A568157
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbiGFI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbiGFI2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:28:45 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D4224966
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:27:46 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id f14so10567101qkm.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ga7nDnbfUpJ9V6ACUSstOgYZyMVy4dse7zJQzHBX+go=;
        b=XfFD9/MZI+n41MLBK0E9mJU/XfUSFToIxhHGHSeXX5RSI/HMC32byDNxQ3J8hIknCZ
         H1YnXYCpyIF3P6+gRcN12sqyL3OrrdgJnHfVFxdBh9A+Fzqh5DsB+jTuO0Kw6oA0fE5k
         axQXuBptSouPb/ZM8WNzbbnwqwyMb/eHYjuzTCgwAfiAYRez+zIcV41H36FtK0q57/Hb
         fc7EpvpnjHDme0fS5lPpxHSOFzwBYfK2Y5WX+t1XRpgrRfhw+jx8ZonW5P4JfHQ4TdXh
         V2lTIgPSLo52tfTCeUtldlg3qV1M4q/4jBkuN275HUv7/2cJ9TA/4BzJ3azwDDq6fmMy
         vRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ga7nDnbfUpJ9V6ACUSstOgYZyMVy4dse7zJQzHBX+go=;
        b=3c75pSG2hSCyNHMzUWXzmAN/RcR92sBnwKNUgvPdpmdpHieSwQjuZZG9kg5ZgfdVFj
         JohkuuvhoO1l9QOalW3Rbwg7oM5ePwrqiEd5kPdSV6G4rrfHPqGInSLjhxKtWuQH6OS0
         jb8Zek3ZZn1+NZSLzUwfwbAm9gS+PmSYADfJpXj6kC3dCQBFspjCOqbD357UmXM7xppu
         oH5YD11dvErLhyf17uUNFnxe/Mkz3c/7pW/Tc24elf/WinudydIoIQhUZ5XS+myI13CE
         XlpEb7kwG2Vx5gLDqSfc6w6uhgaNvq1LsBcevzV35g1tBNzqI9GLsZe5AzpLqFf3tv36
         Tdrg==
X-Gm-Message-State: AJIora/bMkOl2WL8z3/lRfk7GSUFGd4QmZ18NMmoe4m8IlxFw3zwJ6eE
        6kr6v5XmmZqxnM9TZ3RkDrHcsa8GUvQrB8oJ2ewmSw==
X-Google-Smtp-Source: AGRyM1s0dNFUwGjzYQrSacrH+zKZnt3/yN8zb4JMapiqP581z2KtzHaeLpWvpk2in8PzwyIpExyFMQFqXwJMGqb8DEQ=
X-Received: by 2002:a05:620a:2409:b0:6b1:4464:e401 with SMTP id
 d9-20020a05620a240900b006b14464e401mr26122750qkn.30.1657096065684; Wed, 06
 Jul 2022 01:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220705202837.667-1-ansuelsmth@gmail.com> <20220705202837.667-4-ansuelsmth@gmail.com>
In-Reply-To: <20220705202837.667-4-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Jul 2022 11:27:34 +0300
Message-ID: <CAA8EJpry3pJxEVOL7P7gFL4M9yDktCuDE=2KOGfc6DeAUasYGw@mail.gmail.com>
Subject: Re: [PATCH 3/5] clk: qcom: clk-rpm: convert to parent_data API
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2022 at 23:56, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> Convert clk-rpm driver to parent_data API and change parent names to cxo
> and pxo instead of the board variant as pxo_board is an ancient name and
> pxo should be used instead.
>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/clk/qcom/clk-rpm.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/clk/qcom/clk-rpm.c b/drivers/clk/qcom/clk-rpm.c
> index a18811c38018..d45a8b0fc97c 100644
> --- a/drivers/clk/qcom/clk-rpm.c
> +++ b/drivers/clk/qcom/clk-rpm.c
> @@ -23,6 +23,14 @@
>  #define QCOM_RPM_SCALING_ENABLE_ID                     0x2
>  #define QCOM_RPM_XO_MODE_ON                            0x2
>
> +static const struct clk_parent_data gcc_pxo[] = {
> +       { .fw_name = "pxo", .name = "pxo" },

This means that the core clock would look for the DT clock named 'pxo'
with the fallback to the global clock named 'pxo'. Fallback is
required to keep compatibility with older DT files, not having the
clocks/clock-names properties.
For all other platforms we were using as a fallback  the 'pxo_board'
clock (defined in the DT) rather than the 'pxo' (hackily injected by
the gcc driver).
I'd suggest following this pattern and using .fw_name = "pxo', .name =
"pxo_board".

Same applies to the CXO clock.

> +};
> +


-- 
With best wishes
Dmitry
