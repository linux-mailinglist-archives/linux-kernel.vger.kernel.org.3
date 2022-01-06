Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 456D8485CC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245716AbiAFACs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:02:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39740 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239653AbiAFACk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:02:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 68E46619AC;
        Thu,  6 Jan 2022 00:02:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D33C36AEB;
        Thu,  6 Jan 2022 00:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641427359;
        bh=LgWpScTlaLqYHFK8lobVRo2ot5LNdzJ8EJo8mKwcmbw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Y8J2O8Zp8lwwSv9TL1P4m2ZUQL20fqJs5IlKmJ1Io7eLzeOFPEMO4XuEhNaXr0ZwI
         U87Pcn9teJWabi9W/lmj/Ct5fUa6afHAeVc8uInJe5lHi1VP0/DAzo+FJgi/rxrHyk
         K3yjvsXQPXnuziGln7CnYEUm+HuRiynUFR/OrdEKfPaA9L4PI27GrnP2F38wEl1Ere
         O0xHGR9Lq9nl0bIh/VIwpz8nSqTXHFjwfRUXFR3JW9LpgPjJATSjeUWQ0WlJK3Ei7g
         0lNVOeAPar90tYvnzsl2YSQnbcCjglY/4i1hpwre+69KrNJ3UHnBVsuYlDe3V2HLh9
         eJEw14YLoCYYw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
References: <1640018638-19436-1-git-send-email-tdas@codeaurora.org> <1640018638-19436-6-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 5/5] clk: qcom: lpass: Add support for LPASS clock controller for SC7280
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org, robh+dt@kernel.org,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Wed, 05 Jan 2022 16:02:38 -0800
User-Agent: alot/0.9.1
Message-Id: <20220106000239.B6D33C36AEB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2021-12-20 08:43:58)
> diff --git a/drivers/clk/qcom/lpasscorecc-sc7280.c b/drivers/clk/qcom/lpa=
sscorecc-sc7280.c
> new file mode 100644
> index 0000000..dd79847
> --- /dev/null
> +++ b/drivers/clk/qcom/lpasscorecc-sc7280.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
[...]
> +       [LPASS_CORE_CC_EXT_IF0_CLK_SRC] =3D &lpass_core_cc_ext_if0_clk_sr=
c.clkr,
> +       [LPASS_CORE_CC_EXT_IF0_IBIT_CLK] =3D &lpass_core_cc_ext_if0_ibit_=
clk.clkr,
> +       [LPASS_CORE_CC_EXT_IF1_CLK_SRC] =3D &lpass_core_cc_ext_if1_clk_sr=
c.clkr,
> +       [LPASS_CORE_CC_EXT_IF1_IBIT_CLK] =3D &lpass_core_cc_ext_if1_ibit_=
clk.clkr,
> +       [LPASS_CORE_CC_LPM_CORE_CLK] =3D &lpass_core_cc_lpm_core_clk.clkr,
> +       [LPASS_CORE_CC_LPM_MEM0_CORE_CLK] =3D &lpass_core_cc_lpm_mem0_cor=
e_clk.clkr,
> +       [LPASS_CORE_CC_SYSNOC_MPORT_CORE_CLK] =3D &lpass_core_cc_sysnoc_m=
port_core_clk.clkr,
> +};
> +
> +static struct regmap_config lpass_core_cc_sc7280_regmap_config =3D {

Can this be const?

> +       .reg_bits =3D 32,
> +       .reg_stride =3D 4,
> +       .val_bits =3D 32,
> +       .fast_io =3D true,

Any .max_register?

> +};
> +
> +static const struct qcom_cc_desc lpass_core_cc_sc7280_desc =3D {
> +       .config =3D &lpass_core_cc_sc7280_regmap_config,
> +       .clks =3D lpass_core_cc_sc7280_clocks,
> +       .num_clks =3D ARRAY_SIZE(lpass_core_cc_sc7280_clocks),
> +};
> +
> +static const struct of_device_id lpass_core_cc_sc7280_match_table[] =3D {
> +       { .compatible =3D "qcom,sc7280-lpasscorecc" },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(of, lpass_core_cc_sc7280_match_table);
> +
> +static struct gdsc *lpass_core_hm_sc7280_gdscs[] =3D {
> +       [LPASS_CORE_CC_LPASS_CORE_HM_GDSC] =3D &lpass_core_cc_lpass_core_=
hm_gdsc,
> +};
> +
> +static const struct qcom_cc_desc lpass_core_hm_sc7280_desc =3D {
> +       .config =3D &lpass_core_cc_sc7280_regmap_config,
> +       .gdscs =3D lpass_core_hm_sc7280_gdscs,
> +       .num_gdscs =3D ARRAY_SIZE(lpass_core_hm_sc7280_gdscs),
> +};
> +
> +static int lpass_core_cc_sc7280_probe(struct platform_device *pdev)
> +{
> +       struct regmap *regmap;
> +
> +       regmap =3D qcom_cc_map(pdev, &lpass_core_cc_sc7280_desc);
> +       if (IS_ERR(regmap))
> +               return PTR_ERR(regmap);
> +
> +       clk_lucid_pll_configure(&lpass_core_cc_dig_pll, regmap, &lpass_co=
re_cc_dig_pll_config);
> +
> +       return qcom_cc_really_probe(pdev, &lpass_core_cc_sc7280_desc, reg=
map);
> +}
> +
> +static struct platform_driver lpass_core_cc_sc7280_driver =3D {
> +       .probe =3D lpass_core_cc_sc7280_probe,
> +       .driver =3D {
> +               .name =3D "lpass_core_cc-sc7280",
> +               .of_match_table =3D lpass_core_cc_sc7280_match_table,
> +       },
> +};
> +
> +static int lpass_hm_core_probe(struct platform_device *pdev)
> +{
> +       const struct qcom_cc_desc *desc;
> +       int ret;
> +
> +       lpass_core_cc_sc7280_regmap_config.name =3D "lpass_hm_core";
> +       desc =3D &lpass_core_hm_sc7280_desc;
> +
> +       ret =3D qcom_cc_probe_by_index(pdev, 0, desc);

Why don't we use the desc directly here?

> +       if (ret)
> +               goto destroy_clk;
> +
> +       return 0;
> +
> +destroy_clk:
> +       return ret;

This can be simplified and the goto removed.

> +}
> +
