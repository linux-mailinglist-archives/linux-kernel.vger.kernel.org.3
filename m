Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC48497D50
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbiAXKkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:40:23 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:57086 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233316AbiAXKkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:40:21 -0500
X-UUID: d23d858e94544c1cba011559a5dfdaa1-20220124
X-UUID: d23d858e94544c1cba011559a5dfdaa1-20220124
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 155025945; Mon, 24 Jan 2022 18:40:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 24 Jan 2022 18:40:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 24 Jan 2022 18:40:15 +0800
Message-ID: <2404cea17479df35b5a5d55a923a96b10ebae909.camel@mediatek.com>
Subject: Re: [PATCH v21 5/8] soc: mediatek: SVS: add debug commands
From:   Roger Lu <roger.lu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Mon, 24 Jan 2022 18:40:15 +0800
In-Reply-To: <47bcbffc-42f6-335e-dfab-990e0ab5f103@collabora.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com>
         <20220107095200.4389-6-roger.lu@mediatek.com>
         <47bcbffc-42f6-335e-dfab-990e0ab5f103@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Sorry for the late reply and thanks for the advice.

On Fri, 2022-01-07 at 15:34 +0100, AngeloGioacchino Del Regno wrote:
> Il 07/01/22 10:51, Roger Lu ha scritto:
> > The purpose of SVS is to help find the suitable voltages
> > for DVFS. Therefore, if SVS bank voltages are concerned
> > to be wrong, we can adjust SVS bank voltages by this patch.
> > 
> > Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> > ---
> >   drivers/soc/mediatek/mtk-svs.c | 321 ++++++++++++++++++++++++++++++++-
> >   1 file changed, 318 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> > index 042c6e8e9069..93cdaecadd6d 100644
> > --- a/drivers/soc/mediatek/mtk-svs.c
> > +++ b/drivers/soc/mediatek/mtk-svs.c
> 
> ..snip..
> 
> > @@ -605,6 +896,16 @@ static void svs_set_bank_phase(struct svs_platform
> > *svsp,
> >   	}
> >   }
> >   
> > +static inline void svs_save_bank_register_data(struct svs_platform *svsp,
> > +					       enum svsb_phase phase)
> > +{
> > +	struct svs_bank *svsb = svsp->pbank;
> > +	enum svs_reg_index rg_i;
> > +
> 
> I think that it'd be a good idea to add an `enable` parameter, so that we
> don't always do a register dump; after all, this is a debugging feature and
> it's going to be completely irrelevant to the user, so keeping this disabled
> by default would ensure to get no performance degradation (even if small)
> unless really wanted.
> 
> So, in this case, here we'd have
> 
> 	if (!svsp->debug_enabled)
> 		return;

Thanks for pointing out the concern. Excuse us, we really need this to be
enabled by default. If we add a enable flag here, we'll face below problems and
make debug more difficult.

1. If we enable it afterward by cmd, init0[1~2] registers' data cannot be
recorded expectedly because the init flow has been finished already and won't be
run anymore. So, it doesn't work by using cmd to enable the flag.
2. If we add a enable flag here, it means we have to re-build the kernel load in
order to enable this flag. However, we cannot re-build the kernel load and needs
to debug directly sometimes. It's a sad situation... :(

> 
> > +	for (rg_i = DESCHAR; rg_i < SVS_REG_MAX; rg_i++)
> > +		svsb->reg_data[phase][rg_i] = svs_readl_relaxed(svsp, rg_i);
> > +}
> > +
> 
> Of course, this implies adding a new debugfs entry to enable/disable the
> debugging.
> Everything else looks good :)

Oh, excuse us, we have to keep the old design for better instant support and
thanks for the understanding.

> >   static inline void svs_error_isr_handler(struct svs_platform *svsp)
> >   {
> >   	struct svs_bank *svsb = svsp->pbank;
> > @@ -619,6 +920,8 @@ static inline void svs_error_isr_handler(struct
> > svs_platform *svsp)
> >   		svs_readl_relaxed(svsp, SMSTATE1));
> >   	dev_err(svsb->dev, "TEMP = 0x%08x\n", svs_readl_relaxed(svsp, TEMP));
> >   
> > +	svs_save_bank_register_data(svsp, SVSB_PHASE_ERROR);
> > +
> >   	svsb->mode_support = SVSB_MODE_ALL_DISABLE;
> >   	svsb->phase = SVSB_PHASE_ERROR;

[snip]


