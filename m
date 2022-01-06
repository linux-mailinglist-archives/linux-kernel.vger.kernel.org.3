Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C60C3486193
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiAFInu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiAFInt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:43:49 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5983DC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 00:43:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id w20so3326660wra.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 00:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=pIDlf07KfcsY6fe92f2PW6IjMqStOr5iLkGsE/MalFo=;
        b=UWnOW9TVfVMoRUpP+shOxrRc3ANSL8O0sHx88JAVv909hRf/D3FfGj474ecvfCFUg1
         4lclyCEe/hTfeoGPemkm/SntJMczPGTpiXtod8zwhhg8q7K5BP4s6ZNlq/KBqYKG7j9n
         WgFSwZpxuAlqE28oVRVtMtrkBkMmfwZllgNAW07gcbkgx6X/wF7SSQoFMNZeZkMX8XoN
         pRY6R7rpRTv9pEST7vRNsrEjgrKCLTbxLSE4f33u01Ku2v4jD4QyxFmR6UWHl1p9ZVjy
         YmSsB+oFGIqD+iggnDqxnnq7lvhcltlvrkj377NrVleNDnIcA9RF+wquSCiFkXpuOA9a
         tTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=pIDlf07KfcsY6fe92f2PW6IjMqStOr5iLkGsE/MalFo=;
        b=r6FZh0tTHQOgnwfS9lyc8TJdUcHvOm/+DNoeJYXnQYKJrfYYUPiGrGScymlhgxqvka
         yITEfm9CcHegpQIB7M0OyN57PGhAU3N1WGRtd5h/C3rbN5yihRjL/rPbBZe3vtDCIUcE
         1jZq5H/LbhpVXnk7zq4cl2S7lDK/chDd2BPV2tZQ89WLs1WiCyq5b2qaC6ovMHrrxf4D
         yD4jTHqe43yQDoinJj7QAOZmch5ffQHlHY9CF+9zxrTchYeGy03Nc9sxUG9/CFkXD+HT
         CLM/IiGBhsTQw/O5C2rBs9uZhftGFV/RfLMo/Y/u4CVexZTVrEYI4F/43syt4JjsBDDr
         XDgQ==
X-Gm-Message-State: AOAM532grX9sZop+X93thCJSKugeQjjDxgjEOEDnC5K5g2/8VK7uwp/J
        fFX3cvL2m/taFzYilwXJ8kvmIw==
X-Google-Smtp-Source: ABdhPJz/5rNQJd6iDMvvX1sX8yjw7k+rLwrID0+eMTfmAZxiGvDh2aM9RpJSY3eBbcMEPGKD5HBHCg==
X-Received: by 2002:a5d:4c4a:: with SMTP id n10mr51048842wrt.100.1641458627896;
        Thu, 06 Jan 2022 00:43:47 -0800 (PST)
Received: from localhost (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.gmail.com with ESMTPSA id o3sm1594273wry.98.2022.01.06.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 00:43:47 -0800 (PST)
References: <20220106032504.23310-1-liang.yang@amlogic.com>
User-agent: mu4e 1.6.10; emacs 27.1
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: meson: fix the clock after discarding
 sd_emmc_c_clkc
Date:   Thu, 06 Jan 2022 09:16:44 +0100
In-reply-to: <20220106032504.23310-1-liang.yang@amlogic.com>
Message-ID: <1jfsq1z22l.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu 06 Jan 2022 at 11:25, Liang Yang <liang.yang@amlogic.com> wrote:

> Because EMMC and NAND have the same control clock register, so we
> implement a 'sd_emmc_c_clkc'. Previously DTS is defined as below:
>
> 	sd_emmc_c_clkc: mmc@7000 {
> 		compatible = "amlogic,meson-axg-mmc-clkc", "syscon";
> 		reg = <0x0 0x7000 0x0 0x800>;
> 	};
>
> 	nand-controller@7800 {
> 		......
>
> 		clocks = <&clkc CLKID_SD_EMMC_C>,
> 			<&sd_emmc_c_clkc CLKID_MMC_DIV>,
> 			<&sd_emmc_c_clkc CLKID_MMC_PHASE_RX>,
> 			<&sd_emmc_c_clkc CLKID_MMC_PHASE_TX>;
> 		clock-names = "core", "device", "rx", "tx";
> 		amlogic,mmc-syscon = <&sd_emmc_c_clkc>;
>
> 		......
> 	}
>
> but in fact, above implementation is rejected. so now registering
> a nand_divider.

Can you give a bit of context ? a link to the discussion rejecting this

As far as remember, things were getting done for A1 and stopped before
clock part was finished. I'm saying the change is wrong, just that a
discussion is needed before a decision is made.

>
> Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997
> Signed-off-by: Liang Yang <liang.yang@amlogic.com>
> ---
>  drivers/mtd/nand/raw/meson_nand.c | 88 +++++++++++++++++--------------
>  1 file changed, 49 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
> index ac3be92872d0..4472363059c2 100644
> --- a/drivers/mtd/nand/raw/meson_nand.c
> +++ b/drivers/mtd/nand/raw/meson_nand.c
> @@ -2,7 +2,7 @@
>  /*
>   * Amlogic Meson Nand Flash Controller Driver
>   *
> - * Copyright (c) 2018 Amlogic, inc.
> + * Copyright (c) 2018-2021 Amlogic, inc.
>   * Author: Liang Yang <liang.yang@amlogic.com>
>   */
>  
> @@ -10,6 +10,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
>  #include <linux/clk.h>
> +#include <linux/clk-provider.h>
>  #include <linux/mtd/rawnand.h>
>  #include <linux/mtd/mtd.h>
>  #include <linux/mfd/syscon.h>
> @@ -55,6 +56,7 @@
>  #define NFC_REG_VER		0x38
>  
>  #define NFC_RB_IRQ_EN		BIT(21)
> +#define NFC_CMD_FIFO_RESET	BIT(31)
>  
>  #define CMDRWGEN(cmd_dir, ran, bch, short_mode, page_size, pages)	\
>  	(								\
> @@ -104,6 +106,9 @@
>  
>  #define PER_INFO_BYTE		8
>  
> +#define CLK_DIV_SHIFT		0
> +#define CLK_DIV_WIDTH		6
> +
>  struct meson_nfc_nand_chip {
>  	struct list_head node;
>  	struct nand_chip nand;
> @@ -151,15 +156,15 @@ struct meson_nfc {
>  	struct nand_controller controller;
>  	struct clk *core_clk;
>  	struct clk *device_clk;
> -	struct clk *phase_tx;
> -	struct clk *phase_rx;

I would have been nice to explain why these clock are no longer
required, in the change description maybe ?

> +	struct clk *nand_clk;
> +	struct clk_divider nand_divider;
>  
>  	unsigned long clk_rate;
>  	u32 bus_timing;
>  
>  	struct device *dev;
>  	void __iomem *reg_base;
> -	struct regmap *reg_clk;
> +	void __iomem *reg_clk;
>  	struct completion completion;
>  	struct list_head chips;
>  	const struct meson_nfc_data *data;
> @@ -406,12 +411,14 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
>  	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
>  		| nfc->param.chip_select | nfc->timing.tbers_max;
>  	writel(cmd, nfc->reg_base + NFC_REG_CMD);
> -
> +	meson_nfc_drain_cmd(nfc);

is this clock related ?

>  	ret = wait_for_completion_timeout(&nfc->completion,
>  					  msecs_to_jiffies(timeout_ms));
>  	if (ret == 0)
>  		ret = -1;
>  
> +	/* reset command fifo to avoid lock */
> +	writel(NFC_CMD_FIFO_RESET, nfc->reg_base + NFC_REG_CMD);

Again, not seem to be clock related - does not belong in this patch

>  	return ret;
>  }
>  
> @@ -988,8 +995,9 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
>  static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  {
>  	int ret;
> +	struct clk_init_data init = {0};
> +	const char *fix_div2_pll_name[1];
>  
> -	/* request core clock */

Why is the comment bothering you ?

>  	nfc->core_clk = devm_clk_get(nfc->dev, "core");
>  	if (IS_ERR(nfc->core_clk)) {
>  		dev_err(nfc->dev, "failed to get core clock\n");
> @@ -1002,21 +1010,25 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  		return PTR_ERR(nfc->device_clk);
>  	}
>  
> -	nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
> -	if (IS_ERR(nfc->phase_tx)) {
> -		dev_err(nfc->dev, "failed to get TX clk\n");
> -		return PTR_ERR(nfc->phase_tx);
> -	}
> -
> -	nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
> -	if (IS_ERR(nfc->phase_rx)) {
> -		dev_err(nfc->dev, "failed to get RX clk\n");
> -		return PTR_ERR(nfc->phase_rx);
> -	}
> +	init.name = devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);
> +	init.ops = &clk_divider_ops;
> +	fix_div2_pll_name[0] = __clk_get_name(nfc->device_clk);

You should be using "fw_name" so CCF looks a DT directly, instead of this

> +	init.parent_names = fix_div2_pll_name;
> +	init.num_parents = 1;
> +	nfc->nand_divider.reg = nfc->reg_clk;
> +	nfc->nand_divider.shift = CLK_DIV_SHIFT;
> +	nfc->nand_divider.width = CLK_DIV_WIDTH;
> +	nfc->nand_divider.hw.init = &init;
> +	nfc->nand_divider.flags = CLK_DIVIDER_ONE_BASED |
> +				  CLK_DIVIDER_ROUND_CLOSEST |
> +          			  CLK_DIVIDER_ALLOW_ZERO;
> +
> +	nfc->nand_clk = devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
> +	if (IS_ERR(nfc->nand_clk))
> +		return PTR_ERR(nfc->nand_clk);
>  
>  	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
> -	regmap_update_bits(nfc->reg_clk,
> -			   0, CLK_SELECT_NAND, CLK_SELECT_NAND);
> +	writel(CLK_SELECT_NAND | readl(nfc->reg_clk), nfc->reg_clk);
>  
>  	ret = clk_prepare_enable(nfc->core_clk);
>  	if (ret) {
> @@ -1030,29 +1042,21 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  		goto err_device_clk;
>  	}
>  
> -	ret = clk_prepare_enable(nfc->phase_tx);
> +	ret = clk_prepare_enable(nfc->nand_clk);
>  	if (ret) {
> -		dev_err(nfc->dev, "failed to enable TX clock\n");
> -		goto err_phase_tx;
> -	}
> -
> -	ret = clk_prepare_enable(nfc->phase_rx);
> -	if (ret) {
> -		dev_err(nfc->dev, "failed to enable RX clock\n");
> -		goto err_phase_rx;
> +		dev_err(nfc->dev, "pre enable NFC divider fail\n");
> +		goto err_nand_clk;
>  	}
>  
>  	ret = clk_set_rate(nfc->device_clk, 24000000);
>  	if (ret)
> -		goto err_disable_rx;
> +		goto err_disable_clk;
>  
>  	return 0;
>  
> -err_disable_rx:
> -	clk_disable_unprepare(nfc->phase_rx);
> -err_phase_rx:
> -	clk_disable_unprepare(nfc->phase_tx);
> -err_phase_tx:
> +err_disable_clk:
> +	clk_disable_unprepare(nfc->nand_clk);
> +err_nand_clk:
>  	clk_disable_unprepare(nfc->device_clk);
>  err_device_clk:
>  	clk_disable_unprepare(nfc->core_clk);
> @@ -1061,8 +1065,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
>  
>  static void meson_nfc_disable_clk(struct meson_nfc *nfc)
>  {
> -	clk_disable_unprepare(nfc->phase_rx);
> -	clk_disable_unprepare(nfc->phase_tx);
> +	clk_disable_unprepare(nfc->nand_clk);
>  	clk_disable_unprepare(nfc->device_clk);
>  	clk_disable_unprepare(nfc->core_clk);
>  }
> @@ -1375,6 +1378,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct meson_nfc *nfc;
>  	struct resource *res;
> +	u32 ext_clk_reg;
>  	int ret, irq;
>  
>  	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
> @@ -1396,9 +1400,15 @@ static int meson_nfc_probe(struct platform_device *pdev)
>  	if (IS_ERR(nfc->reg_base))
>  		return PTR_ERR(nfc->reg_base);
>  
> -	nfc->reg_clk =
> -		syscon_regmap_lookup_by_phandle(dev->of_node,
> -						"amlogic,mmc-syscon");
> +	ret = of_property_read_u32(pdev->dev.of_node,
> +				   "sd_emmc_c_clkc",
> +				   &ext_clk_reg);
> +	if (ret) {
> +		dev_err(dev, "failed to get NAND external clock register\n");
> +		return ret;
> +	}
> +
> +	nfc->reg_clk = devm_ioremap(&pdev->dev, ext_clk_reg, sizeof(int));

That's how you should get a register region.
If you want an example of a device claiming several region on amlogic,
have a look at the pinctrl driver. 

>  	if (IS_ERR(nfc->reg_clk)) {
>  		dev_err(dev, "Failed to lookup clock base\n");
>  		return PTR_ERR(nfc->reg_clk);

