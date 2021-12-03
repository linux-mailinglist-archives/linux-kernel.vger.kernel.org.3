Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC20466E67
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 01:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240358AbhLCAWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 19:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbhLCAWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 19:22:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77610C06174A;
        Thu,  2 Dec 2021 16:18:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCAD7B82250;
        Fri,  3 Dec 2021 00:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E7FC00446;
        Fri,  3 Dec 2021 00:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638490724;
        bh=eCmuVJ2jHQacfGspdr0NSDv3DCXYWN5TVlbwLDLU8P8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=a0qBlRrUyJCpD1AcuoYGKiJxFm6lj3pIMsgylvXsetI+KfX3N4xwEEFOuMergjKTO
         ISQ9MzzWBEqxqEsUUDq2grvAtfK38jXG83+EXyIoQbFcHtK2UAtdCdP2ZLosre2mHZ
         UGiMXRzD/C0OX5MGWrbSsJ8B7YuTpw1Ux5x6Fbk6bLLxcb7T7cUF2/88weD2fp948E
         5KA0S6TRwWPj/2QCq/nRwOJv4nIROZzAXA4ZEuRXZ4eMGWUgdeq1AVV+jBI3ZUuzuT
         bdVcU6NuUNai01q+JVkRxxQb9G4qCKZXZfQ2Vx7jFy35HDg5W/NxLUurdDnwyntdEb
         rNTwf0LMC4ezQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <7e1805ef3f7cddc1222906d8b8e5b79548b46f63.1638402361.git.quic_vamslank@quicinc.com>
References: <cover.1638402361.git.quic_vamslank@quicinc.com> <7e1805ef3f7cddc1222906d8b8e5b79548b46f63.1638402361.git.quic_vamslank@quicinc.com>
Subject: Re: [PATCH v6 2/5] clk: qcom: Add LUCID_EVO PLL type for SDX65
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        manivannan.sadhasivam@linaro.org,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        Vinod Koul <vkoul@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, maz@kernel.org,
        mturquette@baylibre.com, quic_vamslank@quicinc.com,
        robh+dt@kernel.org, tglx@linutronix.de
Date:   Thu, 02 Dec 2021 16:18:43 -0800
User-Agent: alot/0.9.1
Message-Id: <20211203001844.78E7FC00446@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting quic_vamslank@quicinc.com (2021-12-01 16:21:32)
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alph=
a-pll.c
> index eaedcceb766f..e0c67b76d8ac 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1741,35 +1760,47 @@ static int alpha_pll_lucid_5lpe_set_rate(struct c=
lk_hw *hw, unsigned long rate,
>                                           LUCID_5LPE_ALPHA_PLL_ACK_LATCH);
>  }
> =20
> +static int __clk_lucid_pll_postdiv_set_rate(struct clk_hw *hw, unsigned =
long rate,
> +                                            unsigned long parent_rate, u=
nsigned long enable_vote_run)
> +{
> +        struct clk_alpha_pll_postdiv *pll =3D to_clk_alpha_pll_postdiv(h=
w);
> +       struct regmap *regmap =3D pll->clkr.regmap;

What's going on with the tabbing here?

> +        int i, val =3D 0, div, ret;

Do we need to initialize to 0?

> +        u32 mask;
> +
> +        /*
> +         * If the PLL is in FSM mode, then treat set_rate callback as a
> +         * no-operation.
> +         */
> +        ret =3D regmap_read(regmap, PLL_USER_CTL(pll), &val);
> +        if (ret)
> +                return ret;
> +
> +        if (val & enable_vote_run)
> +                return 0;
> +
> +        if (!pll->post_div_table) {
> +                pr_err("Missing the post_div_table for the PLL\n");

Probably useful to know which PLL is missing a table here.
