Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5867B46E422
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 09:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbhLII3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 03:29:39 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47520 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234801AbhLII3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 03:29:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67D63B823D3;
        Thu,  9 Dec 2021 08:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF6CC341C8;
        Thu,  9 Dec 2021 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639038337;
        bh=PGRspG+sn+JLX0M5QfFVhS9i5Brwi4juS+MT6mzlk5w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=j+LOyea5UU53ueSTop3zf1FmrSzSB+MxWDjwPLDgZ/PrlOc5C/YiAXLgZ3xVaujKR
         7EG6n65RxtE76GBhDO72xqZaMnA9vh7tSa2DX0QCGta/hwcgTmfOUmyFnDu4m6g9MJ
         C/K9HRghafLWR77uLo/Uq7OtQq9HNL5n93tDJKK/UJ9B8Af3BdY++XSn/Ki9CbqtmD
         kpQbIul1BFHHMejK071lMSgdpHH4fk6mC+vk+IUUtzbC/RXzKDAKlzg6D9B3TyverU
         PDzBrPAuBF4cpt9ejZp/nFkkTwM1z7MwCkXzpWLfHq61I9S6WbGKc/weSh+z62PQZD
         MS0qezEN1lzng==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211207114003.100693-3-vkoul@kernel.org>
References: <20211207114003.100693-1-vkoul@kernel.org> <20211207114003.100693-3-vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: Add clock driver for SM8450
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vamsi Krishna Lanka <quic_vamslank@quicinc.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Date:   Thu, 09 Dec 2021 00:25:35 -0800
User-Agent: alot/0.9.1
Message-Id: <20211209082537.1AF6CC341C8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2021-12-07 03:40:03)
> diff --git a/drivers/clk/qcom/gcc-sm8450.c b/drivers/clk/qcom/gcc-sm8450.c
> new file mode 100644
> index 000000000000..82ac419718d7
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sm8450.c
> @@ -0,0 +1,3303 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2021, Linaro Limited
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-sm8450.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "gdsc.h"
> +#include "reset.h"
> +
> +enum {
> +       P_BI_TCXO,
> +       P_GCC_GPLL0_OUT_EVEN,
> +       P_GCC_GPLL0_OUT_MAIN,
> +       P_GCC_GPLL4_OUT_MAIN,
> +       P_GCC_GPLL9_OUT_MAIN,
> +       P_PCIE_0_PIPE_CLK,
> +       P_PCIE_1_PHY_AUX_CLK,
> +       P_PCIE_1_PIPE_CLK,
> +       P_SLEEP_CLK,
> +       P_UFS_PHY_RX_SYMBOL_0_CLK,
> +       P_UFS_PHY_RX_SYMBOL_1_CLK,
> +       P_UFS_PHY_TX_SYMBOL_0_CLK,
> +       P_USB3_PHY_WRAPPER_GCC_USB30_PIPE_CLK,
> +};
> +
> +static struct clk_alpha_pll gcc_gpll0 =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID_EVO],
> +       .clkr =3D {
> +               .enable_reg =3D 0x62018,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){
> +                       .name =3D "gcc_gpll0",
> +                       .parent_data =3D &(const struct clk_parent_data){
> +                               .fw_name =3D "bi_tcxo",

Maybe you want to drop these strings and use the dt index directly? That
may actually be faster because we don't do as many string comparisons
and the code may be smaller if we don't have to store bi_tcxo. I suppose
to make it more readable we could have #defines for each DT index like

 #define DT_BI_TCXO	0
 #define DT_SLEEP_CLK	1

Blaze a new trail!

> +                       },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fixed_lucid_evo_ops,
> +               },
> +       },
> +};
