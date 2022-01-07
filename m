Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312ED487023
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbiAGCFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:05:34 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:58796 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1344474AbiAGCFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:05:33 -0500
X-UUID: a285fb14bf144630bf60d18de7ee7b36-20220107
X-UUID: a285fb14bf144630bf60d18de7ee7b36-20220107
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 312897917; Fri, 07 Jan 2022 10:05:28 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 7 Jan 2022 10:05:27 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 7 Jan 2022 10:05:26 +0800
Message-ID: <9ce7d166768653b70106101c9478aa290dec76a3.camel@mediatek.com>
Subject: Re: [PATCH 1/2] soc: mediatek: pwrap: add pwrap driver for MT8186
 SoC
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 7 Jan 2022 10:05:27 +0800
In-Reply-To: <3dd41039-0151-4ee0-3940-3aceeaff17d1@collabora.com>
References: <20211230114913.9829-1-johnson.wang@mediatek.com>
         <20211230114913.9829-2-johnson.wang@mediatek.com>
         <3dd41039-0151-4ee0-3940-3aceeaff17d1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino, 

On Tue, 2022-01-04 at 10:05 +0100, AngeloGioacchino Del Regno wrote:
> Il 30/12/21 12:49, Johnson Wang ha scritto:
> > MT8186 are highly integrated SoC and use PMIC_MT6366 for
> > power management. This patch adds pwrap master driver to
> > access PMIC_MT6366.
> > 
> > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> 
> Hello Johnson,
> thanks for the patch!
> 
> However, there's something to improve...
> 
> > ---
> >   drivers/soc/mediatek/mtk-pmic-wrap.c | 86
> > ++++++++++++++++++++++++++--
> >   1 file changed, 80 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > index 952bc554f443..4af713274468 100644
> > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > @@ -30,6 +30,7 @@
> >   #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) &
> > 0x00000001)
> >   #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
> >   #define PWRAP_STATE_INIT_DONE0		BIT(21)
> > +#define PWRAP_STATE_INIT_DONE0_V2	BIT(22)
> >   #define PWRAP_STATE_INIT_DONE1		BIT(15)
> >   
> >   /* macro for WACS FSM */
> > @@ -77,6 +78,8 @@
> >   #define PWRAP_CAP_INT1_EN	BIT(3)
> >   #define PWRAP_CAP_WDT_SRC1	BIT(4)
> >   #define PWRAP_CAP_ARB		BIT(5)
> > +#define PWRAP_CAP_MONITOR_V2	BIT(6)
> > +#define PWRAP_CAP_ARB_V2	BIT(8)
> >   
> >   /* defines for slave device wrapper registers */
> >   enum dew_regs {
> > @@ -1063,6 +1066,55 @@ static int mt8516_regs[] = {
> >   	[PWRAP_MSB_FIRST] =		0x170,
> >   };
> >   
> > +static int mt8186_regs[] = {
> > +	[PWRAP_MUX_SEL] =		0x0,
> > +	[PWRAP_WRAP_EN] =		0x4,
> > +	[PWRAP_DIO_EN] =		0x8,
> > +	[PWRAP_RDDMY] =			0x20,
> > +	[PWRAP_CSHEXT_WRITE] =		0x24,
> > +	[PWRAP_CSHEXT_READ] =		0x28,
> > +	[PWRAP_CSLEXT_WRITE] =		0x2C,
> > +	[PWRAP_CSLEXT_READ] =		0x30,
> > +	[PWRAP_EXT_CK_WRITE] =		0x34,
> > +	[PWRAP_STAUPD_CTRL] =		0x3C,
> > +	[PWRAP_STAUPD_GRPEN] =		0x40,
> > +	[PWRAP_EINT_STA0_ADR] =		0x44,
> > +	[PWRAP_EINT_STA1_ADR] =		0x48,
> > +	[PWRAP_INT_CLR] =		0xC8,
> > +	[PWRAP_INT_FLG] =		0xC4,
> > +	[PWRAP_MAN_EN] =		0x7C,
> > +	[PWRAP_MAN_CMD] =		0x80,
> > +	[PWRAP_WACS0_EN] =		0x8C,
> > +	[PWRAP_WACS1_EN] =		0x94,
> > +	[PWRAP_WACS2_EN] =		0x9C,
> > +	[PWRAP_INIT_DONE0] =		0x90,
> > +	[PWRAP_INIT_DONE1] =		0x98,
> > +	[PWRAP_INIT_DONE2] =		0xA0,
> > +	[PWRAP_INT_EN] =		0xBC,
> > +	[PWRAP_INT1_EN] =		0xCC,
> > +	[PWRAP_INT1_FLG] =		0xD4,
> > +	[PWRAP_INT1_CLR] =		0xD8,
> > +	[PWRAP_TIMER_EN] =		0xF0,
> > +	[PWRAP_WDT_UNIT] =		0xF8,
> > +	[PWRAP_WDT_SRC_EN] =		0xFC,
> > +	[PWRAP_WDT_SRC_EN_1] =		0x100,
> > +	[PWRAP_WDT_FLG] =		0x104,
> > +	[PWRAP_SPMINF_STA] =		0x1B4,
> > +	[PWRAP_DCM_EN] =		0x1EC,
> > +	[PWRAP_DCM_DBC_PRD] =		0x1F0,
> > +	[PWRAP_GPSINF_0_STA] =		0x204,
> > +	[PWRAP_GPSINF_1_STA] =		0x208,
> > +	[PWRAP_WACS0_CMD] =		0xC00,
> > +	[PWRAP_WACS0_RDATA] =		0xC04,
> > +	[PWRAP_WACS0_VLDCLR] =		0xC08,
> > +	[PWRAP_WACS1_CMD] =		0xC10,
> > +	[PWRAP_WACS1_RDATA] =		0xC14,
> > +	[PWRAP_WACS1_VLDCLR] =		0xC18,
> > +	[PWRAP_WACS2_CMD] =		0xC20,
> > +	[PWRAP_WACS2_RDATA] =		0xC24,
> > +	[PWRAP_WACS2_VLDCLR] =		0xC28,
> > +};
> > +
> >   enum pmic_type {
> >   	PMIC_MT6323,
> >   	PMIC_MT6351,
> > @@ -1083,6 +1135,7 @@ enum pwrap_type {
> >   	PWRAP_MT8135,
> >   	PWRAP_MT8173,
> >   	PWRAP_MT8183,
> > +	PWRAP_MT8186,
> >   	PWRAP_MT8195,
> >   	PWRAP_MT8516,
> >   };
> > @@ -1535,6 +1588,7 @@ static int pwrap_init_cipher(struct
> > pmic_wrapper *wrp)
> >   	case PWRAP_MT6779:
> >   	case PWRAP_MT6797:
> >   	case PWRAP_MT8173:
> > +	case PWRAP_MT8186:
> >   	case PWRAP_MT8516:
> >   		pwrap_writel(wrp, 1, PWRAP_CIPHER_EN);
> >   		break;
> > @@ -2069,6 +2123,19 @@ static struct pmic_wrapper_type pwrap_mt8516
> > = {
> >   	.init_soc_specific = NULL,
> >   };
> >   
> > +static struct pmic_wrapper_type pwrap_mt8186 = {
> > +	.regs = mt8186_regs,
> > +	.type = PWRAP_MT8186,
> > +	.arb_en_all = 0xfb27f,
> > +	.int_en_all = 0xfffffffe, /* disable WatchDog Timeout for bit 1
> > */
> > +	.int1_en_all =  0x000017ff, /* disable Matching interrupt for
> > bit 13 */
> > +	.spi_w = PWRAP_MAN_CMD_SPI_WRITE,
> > +	.wdt_src = PWRAP_WDT_SRC_MASK_ALL,
> > +	.caps = PWRAP_CAP_INT1_EN | PWRAP_CAP_MONITOR_V2 |
> > PWRAP_CAP_ARB_V2,
> > +	.init_reg_clock = pwrap_common_init_reg_clock,
> > +	.init_soc_specific = NULL,
> > +};
> > +
> >   static const struct of_device_id of_pwrap_match_tbl[] = {
> >   	{
> >   		.compatible = "mediatek,mt2701-pwrap",
> > @@ -2097,6 +2164,9 @@ static const struct of_device_id
> > of_pwrap_match_tbl[] = {
> >   	}, {
> >   		.compatible = "mediatek,mt8183-pwrap",
> >   		.data = &pwrap_mt8183,
> > +	}, {
> > +		.compatible = "mediatek,mt8186-pwrap",
> > +		.data = &pwrap_mt8186,
> >   	}, {
> >   		.compatible = "mediatek,mt8195-pwrap",
> >   		.data = &pwrap_mt8195,
> > @@ -2112,7 +2182,7 @@ MODULE_DEVICE_TABLE(of, of_pwrap_match_tbl);
> >   static int pwrap_probe(struct platform_device *pdev)
> >   {
> >   	int ret, irq;
> > -	u32 mask_done;
> > +	u32 rdata;
> >   	struct pmic_wrapper *wrp;
> >   	struct device_node *np = pdev->dev.of_node;
> >   	const struct of_device_id *of_slave_id = NULL;
> > @@ -2207,12 +2277,16 @@ static int pwrap_probe(struct
> > platform_device *pdev)
> >   		}
> >   	}
> >   
> > -	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> > -		mask_done = PWRAP_STATE_INIT_DONE1;
> > +	if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> > +		rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> > +				    PWRAP_STATE_INIT_DONE0;
> > +	else if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB_V2))
> > +		rdata = pwrap_readl(wrp, PWRAP_WACS2_RDATA) &
> > +				    PWRAP_STATE_INIT_DONE0_V2;
> 
> Why are you changing the logic here?
> I think that assigning to `mask_done` is a good option, reducing
> duplication and
> also reducing the amount of changes for this patch.
> 
> That said, I would simply do it as follows:
> 
> 	if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB))
> 
> 		mask_done = PWRAP_STATE_INIT_DONE1;
> 
> 	else if (HAS_CAP(wrp->master->caps, PWRAP_CAP_ARB_V2))
> 
> 		mask_done = PWRAP_STATE_INIT_DONE0_V2;
> 
> 	else
> 
> 		mask_done = PWRAP_STATE_INIT_DONE0;
> 
> Regards,
> - Angelo

Thank for your review.
Your advice looks good to me.
It makes code more straightforward and have correct logic.
I will update it in next patch.

