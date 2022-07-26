Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0B25817CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiGZQrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239110AbiGZQrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:47:13 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43078193F7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:47:12 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id o1so11373228qkg.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnxICBtoZlXeY2qxckxs6f0OS9viGg3qZVl5sr14NPQ=;
        b=AOJquvQXF3u0cj0bpXLnmvkH2wsAFIkusPxlvkS0CINzQSiVA5XrlWwoa4+gBZSSVr
         wAt8O/f6Q+FNWDiplHZgoLIiExJjWyAYPntVKWt6SzfiSs48OKFbatqX34F2umy64Tl4
         b7G7nUPQHeMhPtz5sIb/d3D7qqNt9gWvitP5GgVVj7G9WVcfeMMq9tvHiZT0CkF+h/Ve
         DTUFmwhM2Y4bUDRKq8NSU1sH0XeAdsG/bvT1BqKMr34B+X/R+ijdYwg0uKqTudDOcqDR
         WOd+L3SNBsGc7Ix4qC3CQDzLsGKQHDYPYfuiXoqsJfsS+XInncq9LN5JIGn2Jvk8ATCn
         JP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnxICBtoZlXeY2qxckxs6f0OS9viGg3qZVl5sr14NPQ=;
        b=WNH0cXL4n6bHcPr9cfZ+Ho3PQuf9iN1bePIUVGpiec/mrSZiOVX64zDjfFDnxHomNm
         SBCgPCprU3xIGP3u9NWbkafo+8kGc6/0pXh79jlcdLRrs/TfY8/hZFWDIc3kP+3EY0fV
         k9cokDkmm3eRLK0+qRzDjJ1fV8sGfJU5YQB6R2PWWvU0VRcqSxWpfYHWSTTSJqhV2MNU
         7oP9xZIP1GwZDn2hkPVBV5G3yH4yggcEKTfely5RIUJHmpxcy5CeUL/ufXX7/DkMWem/
         lpJkcWqdsSgH+ruE8iNUaLskDmBGhGdu2dcKg5MqJNHXp2hVCc8HYdp1Ay/Yi+IGP8Ol
         jVtw==
X-Gm-Message-State: AJIora94h8Y+TUGD1bYXpRK04BrJVhq1v4HqWaXuGRLxT4z/2s9nJMOK
        CQE+KTbU1IOwiK477F7qLRVYaQUcP3ZQ+Zo6qXwCwQ==
X-Google-Smtp-Source: AGRyM1sAT4xEHeETZKUH1vdvbqcGWd6LidWqQu8mEf0H2s05xiqpIGOIQfv5aLJQ/oYOa0/aj4fP4SZw2Hx2Su8QFQY=
X-Received: by 2002:ae9:f311:0:b0:6b6:30a9:1bb1 with SMTP id
 p17-20020ae9f311000000b006b630a91bb1mr13340774qkg.30.1658854031375; Tue, 26
 Jul 2022 09:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220726142303.4126434-1-abel.vesa@linaro.org> <20220726142303.4126434-9-abel.vesa@linaro.org>
In-Reply-To: <20220726142303.4126434-9-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 19:47:00 +0300
Message-ID: <CAA8EJprG79PbfLVvrtJiOA7fGtXn6ZrXN4ZT_DiJggx2synefw@mail.gmail.com>
Subject: Re: [RFC 8/9] clk: qcom: gcc-sdm845: Switch to macros to collapse
 rcg2 clocks definitions
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 17:24, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Switch from the expanded rcg2 clocks definitions to the more compact
> macros.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sdm845.c | 712 +++-------------------------------
>  1 file changed, 51 insertions(+), 661 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 2e66256599d3..d9751d7e617c 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c

[skipped]

> +DEFINE_QCOM_CC_CLK(RCG2, gcc_cpuss_ahb_clk_src, 0x48014, 0, 5, gcc_parent_map_0, ftbl_gcc_cpuss_ahb_clk_src, gcc_parent_data_7_ao);
> +DEFINE_QCOM_CC_CLK(RCG2, gcc_cpuss_rbcpr_clk_src, 0x4815c, 0, 5, gcc_parent_map_3, ftbl_gcc_cpuss_rbcpr_clk_src, gcc_parent_data_8_ao);

Well.. Stephen & Bjorn might have other opinions here. But for me
there are just too many pieces of information on a single line. And
different values start to meld into each other.
So, e.g. I find it harder to comprehend what is going on here. What do
0 and 5 mean, etc. So while it takes less space, it looks harder to
read. Compare this with the interconnect drivers, where a few releases
ago we made an opposite switch: from using QNODE macros to the
expanded structures.

[skipped]

>
>  DEFINE_QCOM_CC_CLK(BRANCH, HALT, gcc_aggre_noc_pcie_tbu_clk, 0, 0x90014, 0, 0, 0x90014, BIT(0), 0);

And this is the perfect example. a series of 0, 1 and BIT(0). What do
they mean? And where is the parent, which is defined for the next
clocks?

>  DEFINE_QCOM_CC_CLK(BRANCH, HALT, gcc_aggre_ufs_card_axi_clk, 1, 0x82028, 0x82028, 1, 0x82028, BIT(0), CLK_SET_RATE_PARENT, &gcc_ufs_card_axi_clk_src.clkr.hw);


-- 
With best wishes
Dmitry
