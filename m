Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5C570950
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiGKRme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiGKRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:42:32 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFA16E8B0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:42:30 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i21so6314220qtw.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YRKpkfAENwaPRHhB52Yk4IsL9JC0VBqj2njlYrjdEfc=;
        b=Jjs1SJg9ILwBRwrSz85ksnjxvXlcJlYxLcWsAIFy3D+w2CMbVk02Fy90YtRHuT/Gsc
         7w5I36ok/ezLiv0MwRRSqurKUV8r1WuOn8R/X3vRaSNrl827XgHpwFoNz/xUzBRULcci
         L2aqTcvr+66l1s0HQsMiDICOiSJlXIUIv0TPQlgFJWyNl+vWFrPal7NgW67WfkDXCkSC
         On0BlPDuU6OXJUGyN3dDD3HqfV8lELBhAv1dWi6blk7Or/nGbVhfPLfCUMtASG4f0s/h
         L0SaBtWy0rvA4iVO3GMVZsBuyNVP5u3nC7OLidScTPhquFtAT8UtRBmdn5VFJI0EE9bM
         ilRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YRKpkfAENwaPRHhB52Yk4IsL9JC0VBqj2njlYrjdEfc=;
        b=4MfOfS45C2lmkU2wsYCKxUIJ8p+zH8lzQkfWOqEAp+QgAOHpoFE1Jw9mhG/rwxVXM/
         Xr69dJAv6WlvHj+z0aeXTjvAJPEQG1NDW49pDiYnpLi0H7p7jqX618RhqUj1gi7G0XF3
         5u45+rf4I81KknMUiztYETn0x84iaT82p0vsEuZjO8G/E2vUyKx/7bY5Z5rx8PuDZOeN
         96cXab7BjV3l89N5kBXSommqEm+c3ckUhcyiGAfjaPT3MT9V4RcRDvQ6L15Rkp8fbWmP
         g/vIzsn6JubCf08CgrHqpQPNlMH6ZIQfU4hCHVeAW0OHMWzDkIsNEpM1MIWx4jhw5tLO
         P5lQ==
X-Gm-Message-State: AJIora9rlD10E73S2JkjckUhpkc7WkKC/FnjtSPy1/3KYzOmpzQR/jHy
        C6DkxGbcTFYZxlLQTAUZX+kqDt+5roQkwdhoBBhYGw==
X-Google-Smtp-Source: AGRyM1tj3qzQHBkSDWHhizwUEMCkZdcJezeAfWiG+HXdCs+IB9Axc9y1pe7xCYy9X9g/aH4hH/1YmHn6VmM6eMyPTnI=
X-Received: by 2002:a05:622a:198f:b0:31e:b669:9f29 with SMTP id
 u15-20020a05622a198f00b0031eb6699f29mr3742937qtc.629.1657561349814; Mon, 11
 Jul 2022 10:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220711174004.3047516-1-nathan@kernel.org>
In-Reply-To: <20220711174004.3047516-1-nathan@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Mon, 11 Jul 2022 20:42:18 +0300
Message-ID: <CAA8EJppiUhkbE2c=ce7AVkgMPZ0Sz-uuws220WYk4GaXZbrQzA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: qcom: gpucc-sm8350: Fix "initializer element is
 not constant" error
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        kernel test robot <lkp@intel.com>
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

On Mon, 11 Jul 2022 at 20:41, Nathan Chancellor <nathan@kernel.org> wrote:
>
> When building with clang or GCC older than 8, errors along the following
> lines occur:
>
>   drivers/clk/qcom/gpucc-sm8350.c:111:2: error: initializer element is not a compile-time constant
>           gpu_cc_parent,
>           ^~~~~~~~~~~~~
>   drivers/clk/qcom/gpucc-sm8350.c:126:2: error: initializer element is not a compile-time constant
>           gpu_cc_parent,
>           ^~~~~~~~~~~~~
>   2 errors generated.
>
> The C standard allows an implementation to accept other forms of
> constant expressions, which GCC 8+ has chosen to do, but it is not
> required. Just inline the initializer to resolve the error.
>
> Fixes: 160758b05ab1 ("clk: qcom: add support for SM8350 GPUCC")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1660
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>
> v1 -> v2: https://lore.kernel.org/20220711163021.152578-1-nathan@kernel.org/
>
> * Just inline the initializer, rather than using a macro (Dmitry).
>
>  drivers/clk/qcom/gpucc-sm8350.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/gpucc-sm8350.c b/drivers/clk/qcom/gpucc-sm8350.c
> index d13fa813d190..5367ce654ac9 100644
> --- a/drivers/clk/qcom/gpucc-sm8350.c
> +++ b/drivers/clk/qcom/gpucc-sm8350.c
> @@ -108,7 +108,7 @@ static const struct parent_map gpu_cc_parent_map_0[] = {
>  };
>
>  static const struct clk_parent_data gpu_cc_parent_data_0[] = {
> -       gpu_cc_parent,
> +       { .fw_name = "bi_tcxo" },
>         { .hw = &gpu_cc_pll0.clkr.hw },
>         { .hw = &gpu_cc_pll1.clkr.hw },
>         { .fw_name = "gcc_gpu_gpll0_clk_src" },
> @@ -123,7 +123,7 @@ static const struct parent_map gpu_cc_parent_map_1[] = {
>  };
>
>  static const struct clk_parent_data gpu_cc_parent_data_1[] = {
> -       gpu_cc_parent,
> +       { .fw_name = "bi_tcxo" },
>         { .hw = &gpu_cc_pll1.clkr.hw },
>         { .fw_name = "gcc_gpu_gpll0_clk_src" },
>         { .fw_name = "gcc_gpu_gpll0_div_clk_src" },
>
> base-commit: 0dd8e16bfbc003b009f843e75fae4046daa08fe9
> --
> 2.37.0
>


-- 
With best wishes
Dmitry
