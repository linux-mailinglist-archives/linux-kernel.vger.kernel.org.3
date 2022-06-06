Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7C153EAD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiFFPi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240978AbiFFPit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:38:49 -0400
X-Greylist: delayed 365 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Jun 2022 08:38:46 PDT
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A89962A246;
        Mon,  6 Jun 2022 08:38:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C9DA6601E15;
        Mon,  6 Jun 2022 16:31:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654529510;
        bh=B7Xbr/lr3CA4n/XcYJq86VAM8oW7AH2+a1fAdoXr7k0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hmLKFCD4OezKrMDbjVIWmGynZhZUTZQEkqMST4NFu4eL+cnNu8dd4+eniukSS14Pq
         Xn0CR9Gxtn5Qvm8BgyqPiziBVnhJ7SKqurzxCBkqON9M4L62HUTW9ku0zOZb6Bljh9
         boqYE2MaxtOyDqZfz02udbK03ZwheORxX8giFNoFAe0gOGOaSUXaL2mrHR8YJpQ4B8
         ZlE5PEUvLvuLqUmX+vIPIm2JpwZgdSfcEdHBDo1Jp2RwHaj5JEHd5Rnvrv+Jfx9zmw
         nPih97/GYX6fPikr/jMy+hzTHybuA35mFqDV1FYoBhugOrCWwxUapgGI8zkE5ILAGy
         jyFFlCMI+bY6g==
Message-ID: <d7e6fe89-76fc-41ed-f179-80915ef62092@collabora.com>
Date:   Mon, 6 Jun 2022 17:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 2/2] clk: mediatek: add driver for MT8365 SoC
Content-Language: en-US
To:     Fabien Parent <fparent@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220530214434.1012889-1-fparent@baylibre.com>
 <20220530214434.1012889-2-fparent@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220530214434.1012889-2-fparent@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/05/22 23:44, Fabien Parent ha scritto:
> Add clock drivers for MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Hello Fabien,

thanks for these clock drivers! ...but there's a few things to address, check below

> ---
> v2: rename header file (dt-bindings/clock/mediatek,mt8365-clk.h)
> 
>   drivers/clk/mediatek/Kconfig           |   50 +
>   drivers/clk/mediatek/Makefile          |    7 +
>   drivers/clk/mediatek/clk-mt8365-apu.c  |   54 ++
>   drivers/clk/mediatek/clk-mt8365-cam.c  |   56 ++
>   drivers/clk/mediatek/clk-mt8365-mfg.c  |   62 ++
>   drivers/clk/mediatek/clk-mt8365-mm.c   |   95 ++
>   drivers/clk/mediatek/clk-mt8365-vdec.c |   62 ++
>   drivers/clk/mediatek/clk-mt8365-venc.c |   51 +
>   drivers/clk/mediatek/clk-mt8365.c      | 1197 ++++++++++++++++++++++++
>   9 files changed, 1634 insertions(+)
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-apu.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-cam.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-mfg.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-mm.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-vdec.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365-venc.c
>   create mode 100644 drivers/clk/mediatek/clk-mt8365.c
> 
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index d5936cfb3bee..f2ae987485f8 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -608,6 +608,56 @@ config COMMON_CLK_MT8195
>           help
>             This driver supports MediaTek MT8195 clocks.
>   
> +config COMMON_CLK_MT8365
> +	bool "Clock driver for MediaTek MT8365"

Since there's an ongoing process to cleanup the MediaTek clocks API, it'd be nice
if new drivers follow that... especially when there's no real reason to avoid that.

Can you please change this bool to tristate and make sure that all these drivers
can be compiled as modules? It's fairly trivial to do so!

> +	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST

Are you sure that this SoC cannot execute a 32-bit (AArch32) Linux kernel?
...I am pretty sure it can, as the AP is a quad-A53, so it makes no sense
to restrict this clock driver to ARM64, right? :-)

> +	select COMMON_CLK_MEDIATEK
> +	default ARCH_MEDIATEK && ARM64
> +	help
> +	  This driver supports MediaTek MT8365 basic clocks.
> +
> +config COMMON_CLK_MT8365_APU
> +	bool "Clock driver for MediaTek MT8365 apu"

tristate...... (here and everywhere else)

> +	depends on COMMON_CLK_MT8365
> +	default COMMON_CLK_MT8365
> +	help
> +	  This driver supports MediaTek MT8365 apu clocks.
> +

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
> new file mode 100644
> index 000000000000..83d3a27ece6c
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8365-mm.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + * Copyright (c) 2022 BayLibre, SAS
> + */
> +

..snip..

> +
> +static int clk_mt8365_mm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->parent->of_node;
> +	struct clk_hw_onecell_data *clk_data;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
> +
> +	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
> +			clk_data);

Please use the new functions that are using struct device wherever possible;
in this case, you should use mtk_clk_register_gates_with_dev().

Also, you should *really* check the return value.

> +
> +	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);

...and in case of failure, there's a leak: function mtk_alloc_clk_data() is *not*
using (in any case) devm_kzalloc(), but kzalloc().

That's something that has to be fixed for the cases in which the clock driver
can provide a struct device, but it's obviously out of this series' scope...
but still, you should *really* call mtk_free_clk_data() in case anything goes
wrong after the allocation.

Of course, this comment is valid for any instance in all of the new drivers.

> +}
> +
> +static struct platform_driver clk_mt8365_mm_drv = {
> +	.probe = clk_mt8365_mm_probe,
> +	.driver = {
> +		.name = "clk-mt8365-mm",
> +	},
> +};
> +builtin_platform_driver(clk_mt8365_mm_drv);

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
> new file mode 100644
> index 000000000000..6fb8c7cb29d9
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt8365.c
> @@ -0,0 +1,1197 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 MediaTek Inc.
> + */
> +
> +#include <dt-bindings/clock/mediatek,mt8365-clk.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "clk-gate.h"
> +#include "clk-mtk.h"
> +#include "clk-mux.h"
> +#include "clk-pll.h"
> +
> +static DEFINE_SPINLOCK(mt8365_clk_lock);
> +
> +static const struct mtk_fixed_clk top_fixed_clks[] = {
> +	FIXED_CLK(CLK_TOP_CLK_NULL, "clk_null", NULL, 0),

What's that?! A "null" clock?!

> +	FIXED_CLK(CLK_TOP_I2S0_BCK, "i2s0_bck", "clk_null", 26000000),

You can simply declare all of these fixed clocks with a NULL pointer there
instead of "clk_null" ... that's going to work just fine, don't worry.

So... remove CLK_TOP_CLK_NULL, as it's useless, then s/\"clk_null\"/NULL/g.

> +	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSICK, "dsi0_lntc_dsick", "clk26m",
> +		  75000000),
> +	FIXED_CLK(CLK_TOP_VPLL_DPIX, "vpll_dpix", "clk26m", 75000000),
> +	FIXED_CLK(CLK_TOP_LVDSTX_CLKDIG_CTS, "lvdstx_dig_cts", "clk26m",
> +		  52500000),
> +};
> +
> +static const struct mtk_gate_regs pll_cg_regs = {
> +	.set_ofs = 0x204,
> +	.clr_ofs = 0x204,
> +	.sta_ofs = 0x204,
> +};

If set, clear, status offsets are located all at 0x204... are you sure that
this is really a mtk_gate?!

Like this, you don't need any "special" mtk_gate... the common clock framework's
generic clk-gate is what you want here: you will also be able to simplify some
handling in your driver like this, as there's a devm_clk_hw_register_gate() helper
to make the day :-)

> +
> +#define GATE_APMIXED(_id, _name, _parent, _shift) \
> +		GATE_MTK(_id, _name, _parent, &pll_cg_regs, _shift, \
> +			 &mtk_clk_gate_ops_no_setclr_inv)
> +
> +static const struct mtk_gate pll_clks[] = {
> +	/* PLL */
> +	GATE_APMIXED(CLK_APMIXED_UNIV_EN, "univ_en", "univpll2", 0),
> +	GATE_APMIXED(CLK_APMIXED_USB20_EN, "usb20_en", "univ_en", 1),
> +};
> +

..snip..

> +
> +static const char * const axi_parents[] = {
> +	"clk26m_ck",

Hmm... so this is "clk26m_ck" and, in the fixed clocks, you declare a parent
that's called "clk26m" instead.

I can't find any definition of clk26m, nor clk26m_ck in these drivers, so I
assume that you're declaring both as fixed clocks in your devicetree, which
is fine, but this brings a good question:

Why would we need two clocks "clk26m" and "clk26m_ck"? I guess that these
are referring both to the same crystal, aren't they?

So... isn't just "clk26m" enough?

> +	"syspll_d7",
> +	"syspll1_d4",
> +	"syspll3_d2"
> +};
> +

..snip..

> +
> +static struct mtk_composite top_misc_muxes[] = {

Are you really sure that these top_misc clocks are *composite clocks*?

I've noticed that there are a lot of misuses of clk-composite in MediaTek clock
drivers and from how I get it, that driver is made to actually drive clocks that
are actually composed of two different types of controls, for example, one clock
composed by a mux and a gate (at two different offsets, but controlling the same
clock output)...

...from how I get it (again), that's not meant as a "cheat" to register multiple
clocks of different type all at once (and - again - it's not the first time that
I see this in MediaTek clock drivers).

I get that this is not your fault and you're simply following what's done in the
other drivers that you checked, but that ain't right :-(

P.S.: Unless anyone beats me to it, I'm planning to actually fix all of the
       clock drivers that are abusing this, hoping that no more developers get
       confused by that.

> +	/* CLK_CFG_11 */
> +	MUX_GATE(CLK_TOP_MBIST_DIAG_SEL, "mbist_diag_sel", mbist_diag_parents,
> +		0x0ec, 0, 2, 7),

 From how I see it, this one being MUX *and* GATE together is indeed a composite
clock, and it's right - but....

> +	/* CLK_AUDDIV_0 */
> +	MUX(CLK_TOP_APLL_I2S0_SEL, "apll_i2s0_sel", apll_i2s0_parents,
> +		 0x320, 11, 1),

...these ones are just MUX, there's no divider, no gate, nothing else, so it's
actually wrong to throw them into the mix here.

> +	MUX(CLK_TOP_APLL_I2S1_SEL, "apll_i2s1_sel", apll_i2s0_parents,
> +		 0x320, 12, 1),
> +	MUX(CLK_TOP_APLL_I2S2_SEL, "apll_i2s2_sel", apll_i2s0_parents,
> +		 0x320, 13, 1),
> +	MUX(CLK_TOP_APLL_I2S3_SEL, "apll_i2s3_sel", apll_i2s0_parents,
> +		 0x320, 14, 1),
> +	MUX(CLK_TOP_APLL_TDMOUT_SEL, "apll_tdmout_sel", apll_i2s0_parents,
> +		 0x320, 15, 1),
> +	MUX(CLK_TOP_APLL_TDMIN_SEL, "apll_tdmin_sel", apll_i2s0_parents,
> +		 0x320, 16, 1),
> +	MUX(CLK_TOP_APLL_SPDIF_SEL, "apll_spdif_sel", apll_i2s0_parents,
> +		 0x320, 17, 1),
> +};
> +
> +#define MT8365_MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs, _mux_set_ofs,	\
> +			_mux_clr_ofs, _shift, _width, _gate,		\
> +			_upd_ofs, _upd)				\

Unless my eyes are failing me, this macro is exactly the same as
MUX_GATE_CLR_SET_UPD(), defined in clk-mux.h.

In that case, why are you reinventing the (not exactly pretty, btw) wheel?

> +		MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
> +			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
> +			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
> +
> +#define CLK_CFG_UPDATE 0x004
> +#define CLK_CFG_UPDATE1 0x008
> +

..snip..

> +
> +static struct mtk_composite mcu_muxes[] = {
> +	/* bus_pll_divider_cfg */
> +	MUX_GATE_FLAGS(CLK_MCU_BUS_SEL, "mcu_bus_sel", mcu_bus_parents, 0x7C0,
> +		9, 2, -1, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
> +};
> +
> +#define DIV_ADJ_F(_id, _name, _parent, _reg, _shift, _width, _flags) {	\
> +		.id = _id,					\
> +		.name = _name,					\
> +		.parent_name = _parent,				\
> +		.div_reg = _reg,				\
> +		.div_shift = _shift,				\
> +		.div_width = _width,				\
> +		.clk_divider_flags = _flags,			\
> +}
> +
> +static const struct mtk_clk_divider top_adj_divs[] = {
> +	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV0, "apll12_ck_div0", "apll_i2s0_sel",
> +		0x324, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
> +	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV1, "apll12_ck_div1", "apll_i2s1_sel",
> +		0x324, 8, 8, CLK_DIVIDER_ROUND_CLOSEST),
> +	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV2, "apll12_ck_div2", "apll_i2s2_sel",
> +		0x324, 16, 8, CLK_DIVIDER_ROUND_CLOSEST),
> +	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV3, "apll12_ck_div3", "apll_i2s3_sel",
> +		0x324, 24, 8, CLK_DIVIDER_ROUND_CLOSEST),
> +	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV6, "apll12_ck_div6", "apll_spdif_sel",
> +		0x32c, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
> +};
> +
> +static const struct mtk_gate_regs top0_cg_regs = {
> +	.set_ofs = 0x0,
> +	.clr_ofs = 0x0,
> +	.sta_ofs = 0x0,
> +};
> +
> +static const struct mtk_gate_regs top1_cg_regs = {
> +	.set_ofs = 0x104,
> +	.clr_ofs = 0x104,
> +	.sta_ofs = 0x104,
> +};
> +
> +static const struct mtk_gate_regs top2_cg_regs = {
> +	.set_ofs = 0x320,
> +	.clr_ofs = 0x320,
> +	.sta_ofs = 0x320,
> +};

These are again generic gates...

> +
> +#define GATE_TOP0(_id, _name, _parent, _shift) \
> +		GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, \
> +			 &mtk_clk_gate_ops_no_setclr)
> +
> +#define GATE_TOP0_I(_id, _name, _parent, _shift) \
> +		GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, \
> +			 &mtk_clk_gate_ops_no_setclr_inv)

Hint: `.flags = CLK_GATE_SET_TO_DISABLE`

> +

..snip..

> +
> +static const struct mtk_gate_regs ifr0_cg_regs = {
> +	.set_ofs = 0x200,
> +	.clr_ofs = 0x200,
> +	.sta_ofs = 0x200,
> +};
> +
> +static const struct mtk_gate_regs ifr1_cg_regs = {
> +	.set_ofs = 0x74,
> +	.clr_ofs = 0x74,
> +	.sta_ofs = 0x74,
> +};

IFR0 and IFR1 are unused?! What's missing, here?! :-)

..snip..

> +
> +static const struct mtk_gate_regs peri_cg_regs = {
> +	.set_ofs = 0x20c,
> +	.clr_ofs = 0x20c,
> +	.sta_ofs = 0x20c,
> +};

Another instance of a generic gate.....!

> +
> +#define GATE_PERI(_id, _name, _parent, _shift) \
> +		GATE_MTK(_id, _name, _parent, &peri_cg_regs, _shift, \
> +			 &mtk_clk_gate_ops_no_setclr_inv)
> +
> +static const struct mtk_gate peri_clks[] = {
> +	GATE_PERI(CLK_PERIAXI, "periaxi", "axi_sel", 31),
> +};
> +

> +..snip..


> +static int clk_mt8365_apmixed_probe(struct platform_device *pdev)
> +{
> +	struct clk_hw_onecell_data *clk_data;
> +	struct device_node *node = pdev->dev.of_node;
> +	int ret;
> +
> +	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	ret = mtk_clk_register_gates(node, pll_clks, ARRAY_SIZE(pll_clks),
> +				     clk_data);
> +	if (ret)

mtk_clk_register_gates_with_dev() please.

> +		goto free_clk_data;
> +
> +	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
> +	if (ret)
> +		goto unregister_gates;
> +
> +	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> +	if (ret)
> +		goto unregister_plls;
> +
> +	return 0;
> +
> +unregister_plls:
> +	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
> +unregister_gates:
> +	mtk_clk_unregister_gates(pll_clks, ARRAY_SIZE(pll_clks), clk_data);
> +free_clk_data:
> +	mtk_free_clk_data(clk_data);
> +
> +	return ret;
> +}
> +

...snip...


> +
> +static const struct of_device_id of_match_clk_mt8365[] = {
> +	{
> +		.compatible = "mediatek,mt8365-apmixedsys",
> +		.data = clk_mt8365_apmixed_probe,

Define multiple platform drivers, each one with its probe function, instead of
defining the probe functions for each driver as platform data.

That will allow you to *easily* use builtin_platform_driver()... and will also
allow you to add a .remove() callback for all of these clock controllers.
Go for it, please!

Regards,
Angelo
