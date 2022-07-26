Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC555581785
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239480AbiGZQhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGZQhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:37:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6B713DE6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:36:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w29so10814844qtv.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 09:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBKyD5smnK7tno71jb1bB9yhbMUK8NKS22ZzIA9O3cQ=;
        b=DtXe2RdpyxH0D5KqKHKi59fBpof0YzZrWR6No+xlI0oi7Jt7fJ5wN/sJw71Vbuck2k
         NvRvLftsDA4vov5yU9aFQJBK8yyNGpw5CaYrXUm5/kmALBWuHvLxo8BVSHrT89FzINqG
         rgBOJlRtAtrAgS396nYc2Xn1ZJtfsXZLMDJWAWfEfq297whVWAC/8QqlBQJpxSb0hsGP
         RIyu1gFQb8CNeV3kF7YehN7TVtID0tbCJrl7D5Iu9St4EfEQqXeKDQSVpt7zStBmTL8J
         XLd7zzqzz14NuHZXQlN43ME0SjtGrqmk9mskuneJcnJK7lGUUCdYhN07xWLb1T5MKDyT
         EuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBKyD5smnK7tno71jb1bB9yhbMUK8NKS22ZzIA9O3cQ=;
        b=EJerEHYEYNX+mkmVS8GmLx4ndqKd9U/BMBITDYHCSNUx8a5/A186O/PfP04HtM4zPE
         L3se3hY+jLc/C/Px5kZ/EdqtwYvCompFSKlfN7C4GSraYiDkUuIfL5fQ6t1NIa8z3Tjb
         KXmz/KRNqH7PXinxBOdfH1xv2me7sNCahEw46fOvFURy0QYlsSd0DX1SCqgDCjTXrLlR
         NMYQR5Bfr3zTZCFJPTz9VCpZM2ybTkybZwExt6p0v5Xn96PAD1176bn4xwDrjos1wIzr
         ySBBVQUqPuJgDOZeIx079bT80HRrWfvxQ8y4ZsCqvc55f/Pb3mEkHg/7QhC6dVobwGxL
         DtlA==
X-Gm-Message-State: AJIora9uIBiyH1b3UUuzSl6rj0LheAfT7fHnWe0f5X9AN5gG/KDMNssp
        4YYQy3iR83w6Vndlvt+IR9dmzb2ZJUF9v9NZqmRpcw==
X-Google-Smtp-Source: AGRyM1tYtlb4ZulItXV1x+MgURqOpyK61O09vosQqjXlSyMFwfYI+g7X37g/XlaW76RZhndSbC0nkJ7wm8eXKsKZJsc=
X-Received: by 2002:a05:622a:19a1:b0:31e:d34f:c9c5 with SMTP id
 u33-20020a05622a19a100b0031ed34fc9c5mr15207878qtc.629.1658853417335; Tue, 26
 Jul 2022 09:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220726142303.4126434-1-abel.vesa@linaro.org> <20220726142303.4126434-2-abel.vesa@linaro.org>
In-Reply-To: <20220726142303.4126434-2-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 19:36:46 +0300
Message-ID: <CAA8EJprrV4vb6j6617T+KoD38hOUwD+7x53B9i51tMke5iHH5g@mail.gmail.com>
Subject: Re: [RFC 1/9] clk: qcom: qcc-sdm845: Collapse gdsc structs into macros
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
> Collapse gdsc structs definitions into macros to make them
> more compact visually.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/clk/qcom/gcc-sdm845.c | 129 ++++------------------------------
>  drivers/clk/qcom/gdsc.h       |  10 +++
>  2 files changed, 23 insertions(+), 116 deletions(-)
>
> diff --git a/drivers/clk/qcom/gcc-sdm845.c b/drivers/clk/qcom/gcc-sdm845.c
> index 58aa3ec9a7fc..8529e9c8c90c 100644
> --- a/drivers/clk/qcom/gcc-sdm845.c
> +++ b/drivers/clk/qcom/gcc-sdm845.c
> @@ -3191,122 +3191,19 @@ static struct clk_branch gcc_lpass_sway_clk = {
>  };
>  #endif
>
> -static struct gdsc pcie_0_gdsc = {
> -       .gdscr = 0x6b004,
> -       .pd = {
> -               .name = "pcie_0_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc pcie_1_gdsc = {
> -       .gdscr = 0x8d004,
> -       .pd = {
> -               .name = "pcie_1_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc ufs_card_gdsc = {
> -       .gdscr = 0x75004,
> -       .pd = {
> -               .name = "ufs_card_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc ufs_phy_gdsc = {
> -       .gdscr = 0x77004,
> -       .pd = {
> -               .name = "ufs_phy_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc usb30_prim_gdsc = {
> -       .gdscr = 0xf004,
> -       .pd = {
> -               .name = "usb30_prim_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc usb30_sec_gdsc = {
> -       .gdscr = 0x10004,
> -       .pd = {
> -               .name = "usb30_sec_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = POLL_CFG_GDSCR,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc = {
> -       .gdscr = 0x7d030,
> -       .pd = {
> -               .name = "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc = {
> -       .gdscr = 0x7d03c,
> -       .pd = {
> -               .name = "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu1_gdsc = {
> -       .gdscr = 0x7d034,
> -       .pd = {
> -               .name = "hlos1_vote_aggre_noc_mmu_tbu1_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_aggre_noc_mmu_tbu2_gdsc = {
> -       .gdscr = 0x7d038,
> -       .pd = {
> -               .name = "hlos1_vote_aggre_noc_mmu_tbu2_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc = {
> -       .gdscr = 0x7d040,
> -       .pd = {
> -               .name = "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc = {
> -       .gdscr = 0x7d048,
> -       .pd = {
> -               .name = "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> -
> -static struct gdsc hlos1_vote_mmnoc_mmu_tbu_sf_gdsc = {
> -       .gdscr = 0x7d044,
> -       .pd = {
> -               .name = "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc",
> -       },
> -       .pwrsts = PWRSTS_OFF_ON,
> -       .flags = VOTABLE,
> -};
> +DEFINE_QCOM_CC_GDSC(pcie_0_gdsc, 0x6b004, "pcie_0_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(pcie_1_gdsc, 0x8d004, "pcie_1_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(ufs_card_gdsc, 0x75004, "ufs_card_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(ufs_phy_gdsc, 0x77004, "ufs_phy_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(usb30_prim_gdsc, 0xf004, "usb30_prim_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(usb30_sec_gdsc, 0x10004, "usb30_sec_gdsc", PWRSTS_OFF_ON, POLL_CFG_GDSCR);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc, 0x7d030, "hlos1_vote_aggre_noc_mmu_audio_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc, 0x7d03c, "hlos1_vote_aggre_noc_mmu_pcie_tbu_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu1_gdsc, 0x7d034, "hlos1_vote_aggre_noc_mmu_tbu1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_aggre_noc_mmu_tbu2_gdsc, 0x7d038, "hlos1_vote_aggre_noc_mmu_tbu2_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc, 0x7d040, "hlos1_vote_mmnoc_mmu_tbu_hf0_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc, 0x7d048, "hlos1_vote_mmnoc_mmu_tbu_hf1_gdsc", PWRSTS_OFF_ON, VOTABLE);
> +DEFINE_QCOM_CC_GDSC(hlos1_vote_mmnoc_mmu_tbu_sf_gdsc, 0x7d044, "hlos1_vote_mmnoc_mmu_tbu_sf_gdsc", PWRSTS_OFF_ON, VOTABLE);
>
>  static struct clk_regmap *gcc_sdm845_clocks[] = {
>         [GCC_AGGRE_NOC_PCIE_TBU_CLK] = &gcc_aggre_noc_pcie_tbu_clk.clkr,
> diff --git a/drivers/clk/qcom/gdsc.h b/drivers/clk/qcom/gdsc.h
> index 5de48c9439b2..c0e616b49dee 100644
> --- a/drivers/clk/qcom/gdsc.h
> +++ b/drivers/clk/qcom/gdsc.h
> @@ -78,6 +78,16 @@ struct gdsc_desc {
>         size_t num;
>  };
>
> +#define DEFINE_QCOM_CC_GDSC(_name, _gdscr, _pd_name, _pwrsts, _flags) \

IMO just #define QCOM_CC_GDSC

> +       static struct gdsc _name = {                    \
> +               .gdscr = _gdscr,                \
> +               .pd = {                         \
> +                       .name = _pd_name,       \

.name = # _name

This would allos us to get rid of _pd_name.
Also if you want to take another step further, I'd define

#define QCOM_GDSC_VOTABLE(name, _gdscr) QCOM_CC_GDSC(_name, _gdscr,
PWRSTS_OFF_ON, VOTABLE)
and use it

> +               },                              \
> +               .pwrsts = _pwrsts,              \
> +               .flags = _flags,                \
> +       }
> +
>  #ifdef CONFIG_QCOM_GDSC
>  int gdsc_register(struct gdsc_desc *desc, struct reset_controller_dev *,
>                   struct regmap *);
> --
> 2.34.3
>


-- 
With best wishes
Dmitry
