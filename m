Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF76B4FE873
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358177AbiDLTH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355179AbiDLTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:07:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656C5419A0;
        Tue, 12 Apr 2022 12:05:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC93561B5D;
        Tue, 12 Apr 2022 19:05:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 092A1C385A5;
        Tue, 12 Apr 2022 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649790335;
        bh=ZbSkaC5MBfF62iamJnsXlTvwu8C3ghdAlvLgcGBAFjo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=kqBrKtUiARnFtFQ4c56T+sZHxkMznV0/BHbnW0R3BzLCLsIwLkw/macH4R4XL6GGQ
         cLSTuq75Gf0TfAXsz/nrYkfGBISUsBWa2jBuPDlhtJcWq2m4omI2LZQPnwR+wAp//r
         VApgztD69V7jhEf1/4tUeve7dDegd1saJntevQn2zZZuOXx+is5a+sdjDJKvIRLAoS
         nc74datHUPpbeHcgDQJuLcKpiWNPtPV+cSO+J3cOIrt3516Ke7TWMbzvzN/5NlFPFr
         51ofQynDkxS8vMaj7x1ce/1c4l5ZK0/XG/sLysQP9eLi8PS/8yI/QJyO9RluiBtHSZ
         CctreOpAWwA/Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220408224321.627126-2-bjorn.andersson@linaro.org>
References: <20220408224321.627126-1-bjorn.andersson@linaro.org> <20220408224321.627126-2-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 2/2] clk: qcom: add sc8280xp GCC driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 12 Apr 2022 12:05:33 -0700
User-Agent: alot/0.10
Message-Id: <20220412190535.092A1C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-08 15:43:21)
> diff --git a/drivers/clk/qcom/gcc-sc8280xp.c b/drivers/clk/qcom/gcc-sc828=
0xp.c
> new file mode 100644
> index 000000000000..e621a25a4a40
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-sc8280xp.c
> @@ -0,0 +1,7463 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2022, Linaro Ltd.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
[...]
> +
> +static struct clk_alpha_pll gcc_gpll0 =3D {
> +       .offset =3D 0x0,
> +       .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
> +       .clkr =3D {
> +               .enable_reg =3D 0x52028,
> +               .enable_mask =3D BIT(0),
> +               .hw.init =3D &(struct clk_init_data){

const

> +                       .name =3D "gcc_gpll0",
> +                       .parent_data =3D &(const struct clk_parent_data){
> +                               .fw_name =3D "bi_tcxo",

This can't be shared for multiple PLLs?

> +                       },
> +                       .num_parents =3D 1,
> +                       .ops =3D &clk_alpha_pll_fixed_lucid_5lpe_ops,
> +               },
> +       },
> +};
> +
