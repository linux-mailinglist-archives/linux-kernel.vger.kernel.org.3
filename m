Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4D75817D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239443AbiGZQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiGZQsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:48:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232126AF9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:48:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id y9so10859320qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d55skeM4MmgFUfCiTeEJDFYaJC6xKxNo35w6mzrGP+g=;
        b=n4MuAymIchLUx8QBvL/QTx5QA+6PfOFPGtNIfUovn6s/J5vSbT0dvLKZW0tLLBpduP
         js6ZX+YETo/VZfDb2pAk7RltO8k2PfdyRMI9kk+VlhJuQ7CmoPyYObfcQHPlhDoZvuu0
         9QNXMyfHTQ4khY6+x1o5iRMZz31leW4a/6NUcabCAvfprfhrH7TT+uOi41mQTrMtQWxb
         p69OPQ+uJhORMetG3s/8PGz102CAkopUY/Q1CZNO6QZ8GFhLP/XhQ2nVqnQleFlSjRjk
         Hd5KQU3tcqJJvr8G4kfRQ2tTPErfbnsvdLeBgZmhmyjX4Mzn40cMKdOMI2WG3r4Vs3Yl
         odwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d55skeM4MmgFUfCiTeEJDFYaJC6xKxNo35w6mzrGP+g=;
        b=Zo+YqnW8/CVn0JD7aoJgWcg+Bx9sg2sWZ5oOwCeEHIfj9klx2M6D5l91cqA/BfqCHB
         IBZ02ASv4Jf1LHLNNSN5HKmRsjcmiH//9QH6DEGy03fd7abXzbW/SGurcsw/xY6HzMeV
         LnFkDqxtydZUn/xALviCFMThcuM+ZQK3Hf5l+G1AZVxMHHpEsBw9mf7j7x6WThUPiVW0
         l1KP98h5U2b+mmlAx09JQz1d/hjO/StqA3byYqDdzsfMI3fvC6e8m770FLhO8TifW0bd
         HB1GgQ8RBVVqPaqWGxpt6oYmEK0ntz/kDrua62mYn/I3pV9SluOGqlVp8MHhnuAhHqPt
         PzVg==
X-Gm-Message-State: AJIora8S8/EpEkGg0+FJH3g1YcDx17S4Kbd2dEPudq1+3fAlRYGu4vBx
        uM3hq1DFe/i/+wHvU732G+Rs9YiaZM0Os2KlL9Mc2Q==
X-Google-Smtp-Source: AGRyM1vhmuv0mCM1ZrW2Y1qJDJZKsI+4TTGB5uIo187UYnvAsIDZEXwmWK+76gXk1LuuYBOyqcsIh+2CkUGr1lb+rIU=
X-Received: by 2002:a05:622a:178a:b0:31e:f9ff:c685 with SMTP id
 s10-20020a05622a178a00b0031ef9ffc685mr15655785qtk.62.1658854113483; Tue, 26
 Jul 2022 09:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220726142303.4126434-1-abel.vesa@linaro.org> <20220726142303.4126434-7-abel.vesa@linaro.org>
In-Reply-To: <20220726142303.4126434-7-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 19:48:22 +0300
Message-ID: <CAA8EJpoGkC44wM8ZQnEtQ29YjOr_ALN2kHDSL793TKE4a080cA@mail.gmail.com>
Subject: Re: [RFC 6/9] clk: qcom: common: Add macro wrapper for all clock types
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 17:23, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Add a generic macro that uses the clk_type to figure out which
> clock type specific macro to call.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/common.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> index 9c8f7b798d9f..475febd19dba 100644
> --- a/drivers/clk/qcom/common.h
> +++ b/drivers/clk/qcom/common.h
> @@ -19,6 +19,9 @@ struct clk_hw;
>  #define PLL_VOTE_FSM_ENA       BIT(20)
>  #define PLL_VOTE_FSM_RESET     BIT(21)
>
> +#define DEFINE_QCOM_CC_CLK(clk_type, ...)      \
> +       DEFINE_QCOM_CC_CLK_##clk_type(__VA_ARGS__)

Please drop this macro. It would make extremely hard to follow the
definitions. Without it I can just jump-tag to follow the
DEFINE_QCOM_CC_CLK_RCG2_SHARED_SOMETHING_EXTRA. With this macro in
place there would be no way to do this.

-- 
With best wishes
Dmitry
