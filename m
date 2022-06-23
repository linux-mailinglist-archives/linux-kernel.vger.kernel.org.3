Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5A5574F7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiFWIJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFWII6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:08:58 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3BC48338
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:08:46 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 4HtFoR1HLEMbD4HtFo9Fxz; Thu, 23 Jun 2022 10:08:44 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 23 Jun 2022 10:08:44 +0200
X-ME-IP: 90.11.190.129
Message-ID: <9a320833-e951-7a0f-e2bd-3f8deb7e705b@wanadoo.fr>
Date:   Thu, 23 Jun 2022 10:08:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 06/18] clk: npcm8xx: add clock controller
Content-Language: fr
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220621131424.162355-1-tmaimon77@gmail.com>
 <20220621131424.162355-7-tmaimon77@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220621131424.162355-7-tmaimon77@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 21/06/2022 à 15:14, Tomer Maimon a écrit :
> Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller which
> generates and supplies clocks to all modules within the BMC.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>   drivers/clk/Kconfig       |   6 +
>   drivers/clk/Makefile      |   1 +
>   drivers/clk/clk-npcm8xx.c | 594 ++++++++++++++++++++++++++++++++++++++
>   3 files changed, 601 insertions(+)
>   create mode 100644 drivers/clk/clk-npcm8xx.c
> 

[...]

> +static int npcm8xx_clk_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *npcm8xx_clk_data;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *clk_base;
> +	struct clk_hw *hw;
> +	int i;
> +
> +	npcm8xx_clk_data = devm_kzalloc(dev, struct_size(npcm8xx_clk_data, hws,
> +							 NPCM8XX_NUM_CLOCKS),
> +					GFP_KERNEL);
> +	if (!npcm8xx_clk_data)
> +		return -ENOMEM;
> +
> +	clk_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(clk_base))
> +		return PTR_ERR(clk_base);
> +
> +	npcm8xx_clk_data->num = NPCM8XX_NUM_CLOCKS;
> +
> +	for (i = 0; i < NPCM8XX_NUM_CLOCKS; i++)
> +		npcm8xx_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
> +
> +	/* Reference 25MHz clock */
> +	hw = clk_hw_register_fixed_rate(dev, "refclk", NULL, 0, NPCM8XX_REF_CLK);
> +	if (IS_ERR(hw))
> +		return PTR_ERR(hw);
> +	npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK] = hw;
> +
> +	/* Register plls */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_plls); i++) {
> +		const struct npcm8xx_clk_pll_data *pll_data = &npcm8xx_plls[i];
> +
> +		hw = npcm8xx_clk_register_pll(dev, clk_base + pll_data->reg,
> +					      pll_data->name,
> +					      pll_data->parent_name,
> +					      pll_data->flags);
> +		if (IS_ERR(hw)) {
> +			dev_err(dev, "npcm8xx_clk: Can't register pll\n");
> +			goto unregister_refclk;

goto err_mux_clk?

(so that we unregister what has already been registered in the loop ; 
and unregister_refclk becomes useless)

> +		}
> +
> +		if (pll_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[pll_data->onecell_idx] = hw;
> +	}
> +
> +	/* Register fixed dividers */
> +	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL1_DIV2,
> +					       NPCM8XX_CLK_S_PLL1, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "npcm8xx_clk: Can't register fixed div\n");
> +		goto unregister_refclk;
> +	}
> +
> +	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PLL2_DIV2,
> +					       NPCM8XX_CLK_S_PLL2, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "npcm8xx_clk: Can't register pll div2\n");
> +		goto unregister_refclk;
> +	}
> +
> +	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_PRE_CLK,
> +					       NPCM8XX_CLK_S_CPU_MUX, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "npcm8xx_clk: Can't register ckclk div2\n");
> +		goto unregister_refclk;
> +	}
> +
> +	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_AXI,
> +					       NPCM8XX_CLK_S_TH, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "npcm8xx_clk: Can't register axi div2\n");
> +		goto unregister_refclk;
> +	}
> +
> +	hw = devm_clk_hw_register_fixed_factor(dev, NPCM8XX_CLK_S_ATB,
> +					       NPCM8XX_CLK_S_AXI, 0, 1, 2);
> +	if (IS_ERR(hw)) {
> +		dev_err(dev, "npcm8xx_clk: Can't register atb div2\n");
> +		goto unregister_refclk;
> +	}
> +
> +	/* Register clock dividers specified in npcm8xx_divs */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_divs); i++) {
> +		const struct npcm8xx_clk_div_data *div_data = &npcm8xx_divs[i];
> +
> +		hw = devm_clk_hw_register_divider(dev, div_data->name,
> +						  div_data->parent_name,
> +						  div_data->flags,
> +						  clk_base + div_data->reg,
> +						  div_data->shift,
> +						  div_data->width,
> +						  div_data->clk_divider_flags,
> +						  &npcm8xx_clk_lock);
> +		if (IS_ERR(hw)) {
> +			dev_err(dev, "npcm8xx_clk: Can't register div table\n");
> +			goto unregister_refclk;
> +		}
> +
> +		if (div_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[div_data->onecell_idx] = hw;
> +	}
> +
> +	/* Register muxes */
> +	for (i = 0; i < ARRAY_SIZE(npcm8xx_muxes); i++) {
> +		const struct npcm8xx_clk_mux_data *mux_data = &npcm8xx_muxes[i];
> +
> +		hw = clk_hw_register_mux_table(dev, mux_data->name,
> +					       mux_data->parent_names,
> +					       mux_data->num_parents,
> +					       mux_data->flags,
> +					       clk_base + NPCM8XX_CLKSEL,
> +					       mux_data->shift,
> +					       mux_data->mask, 0,
> +					       mux_data->table,
> +					       &npcm8xx_clk_lock);
> +
> +		if (IS_ERR(hw)) {
> +			dev_err(dev, "npcm8xx_clk: Can't register mux\n");
> +			goto err_mux_clk;
> +		}
> +
> +		if (mux_data->onecell_idx >= 0)
> +			npcm8xx_clk_data->hws[mux_data->onecell_idx] = hw;
> +	}
> +
> +	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
> +					   npcm8xx_clk_data);

If this fails, I think we should also "goto err_mux_clk;"

> +
> +err_mux_clk:
> +	while (i--) {
> +		if (npcm8xx_muxes[i].onecell_idx >= 0)
> +			clk_hw_unregister_mux(npcm8xx_clk_data->hws[npcm8xx_muxes[i].onecell_idx]);
> +	}
> +unregister_refclk:
> +	clk_hw_unregister(npcm8xx_clk_data->hws[NPCM8XX_CLK_REFCLK]);
> +	return PTR_ERR(hw);
> +}

Does a .remove() function is needed to match this error handling path? 
(or use devm_add_action_or_reset())?

CJ
> +
> +static const struct of_device_id npcm8xx_clk_dt_ids[] = {
> +	{ .compatible = "nuvoton,npcm845-clk", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, npcm8xx_clk_dt_ids);
> +
> +static struct platform_driver npcm8xx_clk_driver = {
> +	.probe  = npcm8xx_clk_probe,
> +	.driver = {
> +		.name = "npcm8xx_clk",
> +		.of_match_table = npcm8xx_clk_dt_ids,
> +	},
> +};
> +
> +static int __init npcm8xx_clk_driver_init(void)
> +{
> +	return platform_driver_register(&npcm8xx_clk_driver);
> +}
> +arch_initcall(npcm8xx_clk_driver_init);
> +

