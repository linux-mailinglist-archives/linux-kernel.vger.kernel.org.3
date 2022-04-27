Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402F1511B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbiD0NmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiD0NmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:42:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880C6D948;
        Wed, 27 Apr 2022 06:38:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 956B71F442A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651066736;
        bh=1QN1p0eSZK217vpy0gh2KrOhLqzPHhjrtvyCvtKYhTw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a8JjF3xZKEK8YYakI94IeHbit/xUc+NIVPgf34JNUrK2ASU/PqnZ2Rz2AUqkWDv4G
         Yb7ZhR/WEIB/3pk6KNLowcOCyBHXOHohxyW4SPvsUROWFUuXj9fhgLSCk4s8ut6WUO
         N5bWehMn06s/zLun16wWL8cf3+oo0UNg6sc1l/jE63Z+RMN/2FbTZbVghViVHaltX9
         YOyEgD/p28wmGR2ekTpzJoO93MfmQ91qbInCdwlISlmK5K18pfZ+37zoy727SYdf4v
         4q+CXFkOQBFMj55XWfTA0WyynWgtkTfRLlNuWKJJArAb1DsTC3bwPGRYCprTXZdziM
         ak8gZYZ6iGJ0w==
Message-ID: <c643d877-bc0a-a92c-d366-bd27bf580739@collabora.com>
Date:   Wed, 27 Apr 2022 15:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH V4 07/15] clk: mediatek: reset: Support nonsequence base
 offsets of reset registers
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, mturquette@baylibre.com,
        sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     p.zabel@pengutronix.de, chun-jie.chen@mediatek.com,
        wenst@chromium.org, runyang.chen@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220427030950.23395-1-rex-bc.chen@mediatek.com>
 <20220427030950.23395-8-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220427030950.23395-8-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/04/22 05:09, Rex-BC Chen ha scritto:
> The bank offsets are not serial for all reset registers.
> For example, there are five infra reset banks for MT8192: 0x120, 0x130,
> 0x140, 0x150 and 0x730.
> 
> To support this,
> - Change reg_ofs to rst_bank_ofs which is a pointer to base offsets of
>    the reset register.
> - Add a new define RST_NR_PER_BANK to define reset number for each
>    reset bank.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>   drivers/clk/mediatek/clk-mt2701-eth.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt2701-g3d.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt2701-hif.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt2701.c     | 11 +++++++----
>   drivers/clk/mediatek/clk-mt2712.c     | 15 +++++++++------
>   drivers/clk/mediatek/clk-mt7622-eth.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt7622-hif.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt7622.c     | 11 +++++++----
>   drivers/clk/mediatek/clk-mt7629-eth.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt7629-hif.c |  6 ++++--
>   drivers/clk/mediatek/clk-mt8135.c     | 11 +++++++----
>   drivers/clk/mediatek/clk-mt8173.c     | 11 +++++++----
>   drivers/clk/mediatek/clk-mt8183.c     | 14 ++++++++++++--
>   drivers/clk/mediatek/reset.c          | 11 ++++++-----
>   drivers/clk/mediatek/reset.h          |  6 ++++--
>   15 files changed, 87 insertions(+), 45 deletions(-)
> 

..snip..

> diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
> index 70a934faa529..ebb1b9975ab0 100644
> --- a/drivers/clk/mediatek/clk-mt2701.c
> +++ b/drivers/clk/mediatek/clk-mt2701.c
> @@ -735,18 +735,21 @@ static const struct mtk_fixed_factor infra_fixed_divs[] = {
>   	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
>   };
>   
> +static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
> +static u16 perfcfg_rst_ofs[] = { 0x0, 0x4, };

Typo: perfcfg -> pericfg ... here and in some more files :))

> +
>   static const struct mtk_clk_rst_desc clk_rst_desc[] = {
>   	/* infrasys */
>   	{
>   		.version = MTK_RST_SIMPLE,
> -		.rst_bank_nr = 2,
> -		.reg_ofs = 0x30,
> +		.rst_bank_ofs = infrasys_rst_ofs,
> +		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
>   	},
>   	/* pericfg */
>   	{
>   		.version = MTK_RST_SIMPLE,
> -		.rst_bank_nr = 2,
> -		.reg_ofs = 0x0,
> +		.rst_bank_ofs = perfcfg_rst_ofs,
> +		.rst_bank_nr = ARRAY_SIZE(perfcfg_rst_ofs),
>   	},
>   };
>   
> diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
> index cef7c79788ec..2a9d70dd97d6 100644
> --- a/drivers/clk/mediatek/clk-mt2712.c
> +++ b/drivers/clk/mediatek/clk-mt2712.c
> @@ -1258,18 +1258,21 @@ static const struct mtk_pll_data plls[] = {
>   		0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
>   };
>   
> +static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
> +static u16 perfcfg_rst_ofs[] = { 0x0, 0x4, };
> +
>   static const struct mtk_clk_rst_desc clk_rst_desc[] = {
> -	/* infra */
> +	/* infrasys */

Instead of renaming these here, if you really want this renamed, can you please
do that in patch [06/15]?

>   	{
>   		.version = MTK_RST_SIMPLE,
> -		.rst_bank_nr = 2,
> -		.reg_ofs = 0x30,
> +		.rst_bank_ofs = infrasys_rst_ofs,
> +		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
>   	},

..snip..

> diff --git a/drivers/clk/mediatek/reset.h b/drivers/clk/mediatek/reset.h
> index 91358e8cb851..83840ecf8b27 100644
> --- a/drivers/clk/mediatek/reset.h
> +++ b/drivers/clk/mediatek/reset.h
> @@ -9,6 +9,8 @@
>   #include <linux/reset-controller.h>
>   #include <linux/types.h>
>   
> +#define RST_NR_PER_BANK 32
> +
>   /**
>    * enum mtk_reset_version - Version of MediaTek clock reset controller.
>    * @MTK_RST_SIMPLE: Use the same registers for bit set and clear.
> @@ -24,12 +26,12 @@ enum mtk_reset_version {
>   /**
>    * struct mtk_clk_rst_desc - Description of MediaTek clock reset.
>    * @version: Reset version which is defined in enum mtk_reset_version.
> - * @reg_ofs: Base offset of the reset register.
> + * @rst_bank_ofs: Pointer to base offsets of the reset register.

Instead of generically saying that this is a pointer, it would be more
appropriate to say that this is a pointer to an array containing base
offsets (etc).

Thanks,
Angelo

>    * @rst_bank_nr: Quantity of reset bank.
>    */
>   struct mtk_clk_rst_desc {
>   	u8 version;
> -	u16 reg_ofs;
> +	u16 *rst_bank_ofs;
>   	u32 rst_bank_nr;
>   };
>   
