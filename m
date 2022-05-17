Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8D65299A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239944AbiEQGhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 02:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiEQGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 02:37:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77B92BB16;
        Mon, 16 May 2022 23:37:43 -0700 (PDT)
X-UUID: 1be3c25555d747e0b02388ea4d6ebf8b-20220517
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:c863057f-9fd9-4192-988f-bb7b614463c7,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:4b5473e2-edbf-4bd4-8a34-dfc5f7bb086d,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 1be3c25555d747e0b02388ea4d6ebf8b-20220517
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 838221604; Tue, 17 May 2022 14:37:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 17 May 2022 14:37:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 17 May 2022 14:37:36 +0800
Message-ID: <cf2442b9c7124ebf1ce62ae5df597f003fa447d7.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] memory: mtk-smi: Add support for MT6795 Helio X10
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <konrad.dybcio@somainline.org>, <marijn.suijten@somainline.org>,
        <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>,
        <kernel@collabora.com>, <yi.kuo@mediatek.com>,
        <anthony.huang@mediatek.com>, <wendy-st.lin@mediatek.com>
Date:   Tue, 17 May 2022 14:37:36 +0800
In-Reply-To: <20220513150633.387200-3-angelogioacchino.delregno@collabora.com>
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
         <20220513150633.387200-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-05-13 at 17:06 +0200, AngeloGioacchino Del Regno wrote:
> The MediaTek Helio X10 (MT6795) SoC has 5 LARBs and one common SMI
> instance without any sub-common and without GALS.
> 
> While the smi-common configuration is specific to this SoC, on the
> LARB side, this is similar to MT8173, in the sense that it doesn't
> need the port in LARB, and the register layout is also compatible
> with that one, which makes us able to fully reuse the smi-larb
> platform data struct that was introduced for MT8173.
> 
> Signed-off-by: AngeloGioacchino Del Regno <
> angelogioacchino.delregno@collabora.com>
> ---
>  drivers/memory/mtk-smi.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index 86a3d34f418e..7e7c3ede19e4 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -21,11 +21,13 @@
>  /* SMI COMMON */
>  #define SMI_L1LEN			0x100
>  
> +#define SMI_L1_ARB			0x200
>  #define SMI_BUS_SEL			0x220
>  #define SMI_BUS_LARB_SHIFT(larbid)	((larbid) << 1)
>  /* All are MMU0 defaultly. Only specialize mmu1 here. */
>  #define F_MMU1_LARB(larbid)		(0x1 <<
> SMI_BUS_LARB_SHIFT(larbid))
>  
> +#define SMI_FIFO_TH0			0x230

Does the name come from the coda you got?
It is called SMI_READ_FIFO_TH in my coda.

>  #define SMI_M4U_TH			0x234
>  #define SMI_FIFO_TH1			0x238
>  #define SMI_FIFO_TH2			0x23c
> @@ -360,6 +362,7 @@ static const struct of_device_id
> mtk_smi_larb_of_ids[] = {
>  	{.compatible = "mediatek,mt2701-smi-larb", .data =
> &mtk_smi_larb_mt2701},
>  	{.compatible = "mediatek,mt2712-smi-larb", .data =
> &mtk_smi_larb_mt2712},
>  	{.compatible = "mediatek,mt6779-smi-larb", .data =
> &mtk_smi_larb_mt6779},
> +	{.compatible = "mediatek,mt6795-smi-larb", .data =
> &mtk_smi_larb_mt8173},
>  	{.compatible = "mediatek,mt8167-smi-larb", .data =
> &mtk_smi_larb_mt8167},
>  	{.compatible = "mediatek,mt8173-smi-larb", .data =
> &mtk_smi_larb_mt8173},
>  	{.compatible = "mediatek,mt8183-smi-larb", .data =
> &mtk_smi_larb_mt8183},
> @@ -541,6 +544,13 @@ static struct platform_driver
> mtk_smi_larb_driver = {
>  	}
>  };
>  
> +static const struct mtk_smi_reg_pair
> mtk_smi_common_mt6795_init[SMI_COMMON_INIT_REGS_NR] = {
> +	{SMI_L1_ARB, 0x1b},
> +	{SMI_M4U_TH, 0xce810c85},
> +	{SMI_FIFO_TH1, 0x43214c8},
> +	{SMI_FIFO_TH0, 0x191f},
> +};
> +
>  static const struct mtk_smi_reg_pair
> mtk_smi_common_mt8195_init[SMI_COMMON_INIT_REGS_NR] = {
>  	{SMI_L1LEN, 0xb},
>  	{SMI_M4U_TH, 0xe100e10},
> @@ -565,6 +575,12 @@ static const struct mtk_smi_common_plat
> mtk_smi_common_mt6779 = {
>  		    F_MMU1_LARB(5) | F_MMU1_LARB(6) | F_MMU1_LARB(7),
>  };
>  
> +static const struct mtk_smi_common_plat mtk_smi_common_mt6795 = {
> +	.type	  = MTK_SMI_GEN2,
> +	.bus_sel  = BIT(0),

Like the other larbs, use F_MMU1_LARB(0) here?


After the two changes,

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

Thanks.

> +	.init     = mtk_smi_common_mt6795_init,
> +};
> +
>  static const struct mtk_smi_common_plat mtk_smi_common_mt8183 = {
>  	.type     = MTK_SMI_GEN2,
>  	.has_gals = true,
> @@ -609,6 +625,7 @@ static const struct of_device_id
> mtk_smi_common_of_ids[] = {
>  	{.compatible = "mediatek,mt2701-smi-common", .data =
> &mtk_smi_common_gen1},
>  	{.compatible = "mediatek,mt2712-smi-common", .data =
> &mtk_smi_common_gen2},
>  	{.compatible = "mediatek,mt6779-smi-common", .data =
> &mtk_smi_common_mt6779},
> +	{.compatible = "mediatek,mt6795-smi-common", .data =
> &mtk_smi_common_mt6795},
>  	{.compatible = "mediatek,mt8167-smi-common", .data =
> &mtk_smi_common_gen2},
>  	{.compatible = "mediatek,mt8173-smi-common", .data =
> &mtk_smi_common_gen2},
>  	{.compatible = "mediatek,mt8183-smi-common", .data =
> &mtk_smi_common_mt8183},

