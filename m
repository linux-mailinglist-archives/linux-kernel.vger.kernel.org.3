Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A584152EED0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350671AbiETPMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiETPMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:12:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC50D8AE52;
        Fri, 20 May 2022 08:12:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D6FFA1F46045
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653059537;
        bh=dM+dtww2MjUV3EO6VLGR/tvde0qsMUnXBPbKpDoQ3xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qb5Bkom9rqi1bHDGk7du6o4c58uBM1hqdlfe6uY6M8LUyEPi0b0iRFKmGxRuFys2K
         3Y08v7welt57mQDEjS39tiRdSCgWKjg6fyJ5/zCAqmQOX5PPdadT3M1kKC0hJsV0QM
         w+b/obwU3zIlURh1ygNWq8N5vFknX5CbNXEHXmRBXK3ukBEEjCIIw0gb5pblqxRamw
         3pFxM4XT7j8NJcslhc7NVxqLw2NAlwQ2y7KS5L2+WUSssjEb7lSgNb7X55gY+H4bkE
         GIVPivKRFAudr52IE85Wf/gyHaAdljblNbtuUmtWbrIGe/r8KmIlo5zDWv1nlJZRmR
         10X6f+xMkcmUQ==
Date:   Fri, 20 May 2022 11:12:12 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        chun-jie.chen@mediatek.com, wenst@chromium.org,
        runyang.chen@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v7 05/19] clk: mediatek: reset: Merge and revise reset
 register function
Message-ID: <20220520151212.rrrtekst7uhnojds@notapiano>
References: <20220519125527.18544-1-rex-bc.chen@mediatek.com>
 <20220519125527.18544-6-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220519125527.18544-6-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rex,

On Thu, May 19, 2022 at 08:55:13PM +0800, Rex-BC Chen wrote:
> There are two versions for clock reset register control for MediaTek
> SoCs. The old hardware is one bit per reset control, and does not
> have separate registers for bit set, clear and read-back operations.
> This matches the scheme supported by the simple reset driver.
> 
> However, because we need to use different data structure from
> reset_simple_data, we can not use the operation of simple reset
> driver.
> For this reason, we keep the original functions and name this version
> as "MTK_RST_SIMPLE".
> 
> In this patch:
> - Add a version enumeration to separate different reset hardware.
> - Merge the reset register function of simple and set_clr into one
>   function "mtk_register_reset_controller".
> - Rename input variable "num_regs" to "rst_bank_nr" to avoid
>   confusion. This variable is used to define the quantity of reset bank.
> - Document mtk_reset_version and mtk_register_reset_controller.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

<snip>

> index 764a8affe206..2a39eec9cff7 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -9,16 +9,32 @@
>  #include <linux/reset-controller.h>
>  #include <linux/types.h>
>  
> +/**
> + * enum mtk_reset_version - Version of MediaTek clock reset controller.
> + * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
> + * @MTK_RST_SET_CLR: Use separate registers for bit set and clear.
> + * @MTK_RST_MAX: Total quantity of version for MediaTek clock reset controller.
> + */
> +enum mtk_reset_version {
> +	MTK_RST_SIMPLE = 0,
> +	MTK_RST_SET_CLR,
> +	MTK_RST_MAX,
> +};
> +
>  struct mtk_reset {
>  	struct regmap *regmap;
>  	int regofs;
>  	struct reset_controller_dev rcdev;
>  };
>  
> +/**
> + * mtk_register_reset_controller - Register MediaTek clock reset controller
> + * @np: Pointer to device node.
> + * @rst_bank_nr: Quantity of reset bank.
> + * @reg_ofs: Base offset of the reset register.
> + * @version: Version of MediaTek clock reset controller.
> + */
>  void mtk_register_reset_controller(struct device_node *np,
> -				   unsigned int num_regs, int regofs);
> -
> -void mtk_register_reset_controller_set_clr(struct device_node *np,
> -					   unsigned int num_regs, int regofs);
> +				   u32 rst_bank_nr, u16 reg_ofs, u8 version);

Why not use 'enum mtk_reset_version' instead of a generic u8? Same thing when
you move it to a struct in patch 6.

Thanks,
Nícolas
