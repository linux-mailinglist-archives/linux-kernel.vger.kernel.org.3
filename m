Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D271593070
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242712AbiHOOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiHOOGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:06:40 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEF1183B;
        Mon, 15 Aug 2022 07:06:37 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oNajc-00043b-0N; Mon, 15 Aug 2022 16:06:28 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 05/10] soc: sunxi: sram: Fix probe function ordering issues
Date:   Mon, 15 Aug 2022 16:06:27 +0200
Message-ID: <6807552.18pcnM708K@diego>
In-Reply-To: <20220815041248.53268-6-samuel@sholland.org>
References: <20220815041248.53268-1-samuel@sholland.org> <20220815041248.53268-6-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. August 2022, 06:12:42 CEST schrieb Samuel Holland:
> Errors from debugfs are intended to be non-fatal, and should not prevent
> the driver from probing.
> 
> Since debugfs file creation is treated as infallible, move it below the
> parts of the probe function that can fail. This prevents an error
> elsewhere in the probe function from causing the file to leak. Do the
> same for the call to of_platform_populate().
> 
> Finally, checkpatch suggests an octal literal for the file permissions.
> 
> Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Tested-by: Heiko Stuebner <heiko@sntech.de>

but one thing below

> ---
> 
> (no changes since v1)
> 
>  drivers/soc/sunxi/sunxi_sram.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
> index a858a37fcdd4..52d07bed7664 100644
> --- a/drivers/soc/sunxi/sunxi_sram.c
> +++ b/drivers/soc/sunxi/sunxi_sram.c
> @@ -332,9 +332,9 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
>  
>  static int __init sunxi_sram_probe(struct platform_device *pdev)
>  {
> -	struct dentry *d;
>  	struct regmap *emac_clock;
>  	const struct sunxi_sramc_variant *variant;
> +	struct device *dev = &pdev->dev;
>  
>  	sram_dev = &pdev->dev;
>  
> @@ -346,13 +346,6 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
>  	if (IS_ERR(base))
>  		return PTR_ERR(base);
>  
> -	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> -
> -	d = debugfs_create_file("sram", S_IRUGO, NULL, NULL,
> -				&sunxi_sram_fops);
> -	if (!d)
> -		return -ENOMEM;
> -
>  	if (variant->num_emac_clocks > 0) {
>  		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
>  						   &sunxi_sram_emac_clock_regmap);
> @@ -361,6 +354,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
>  			return PTR_ERR(emac_clock);
>  	}
>  
> +	of_platform_populate(dev->of_node, NULL, NULL, dev);

hmm, of_platform_populate() can actually fail [0] it just looks a bit like
sunxi driver seem to ignore that by {chance, design?} [1] .

So I guess this might want to have handling for probably unlikely
possible errors instead?


Heiko

[0] https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L463
[1] https://elixir.bootlin.com/linux/latest/source/drivers/bus/sun50i-de2.c#L22
> +
> +	debugfs_create_file("sram", 0444, NULL, NULL, &sunxi_sram_fops);
> +
>  	return 0;
>  }
>  
> 




