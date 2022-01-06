Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD6CD48613C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiAFII2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:08:28 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:45646 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236238AbiAFII1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:08:27 -0500
X-UUID: 77c016db4dcc4592a6865c034e7c0b92-20220106
X-UUID: 77c016db4dcc4592a6865c034e7c0b92-20220106
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2011487937; Thu, 06 Jan 2022 16:08:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Jan 2022 16:08:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 16:08:20 +0800
Message-ID: <f53b48c05d38c75c1e02ca5189ed19a36d13bd44.camel@mediatek.com>
Subject: Re: [PATCH v2 3/5] phy: mediatek: add helpers to update bits of
 registers
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Date:   Thu, 6 Jan 2022 16:08:20 +0800
In-Reply-To: <821f9e8b-cf35-2e53-e64f-c19e7bde957b@collabora.com>
References: <20211218082802.5256-1-chunfeng.yun@mediatek.com>
         <20211218082802.5256-3-chunfeng.yun@mediatek.com>
         <047803b9-d09f-d4f8-a674-317cc19dd055@collabora.com>
         <75b2773d1d170f42bae0774dbc58d1458cb25502.camel@mediatek.com>
         <821f9e8b-cf35-2e53-e64f-c19e7bde957b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-01-03 at 09:59 +0100, AngeloGioacchino Del Regno wrote:
> Il 30/12/21 03:06, Chunfeng Yun ha scritto:
> > On Fri, 2021-12-24 at 11:10 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 18/12/21 09:28, Chunfeng Yun ha scritto:
> > > > Add three helpers mtk_phy_clear/set/update_bits() for registers
> > > > operation
> > > > 
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > > v2: new patch, add register access helpers,
> > > >       Add updatel() macro suggested by Vinod, here add more
> > > > ones
> > > > instead.
> > > > ---
> > > >    drivers/phy/mediatek/phy-mtk-io.h | 38
> > > > +++++++++++++++++++++++++++++++
> > > >    1 file changed, 38 insertions(+)
> > > >    create mode 100644 drivers/phy/mediatek/phy-mtk-io.h
> > > > 
> > > > diff --git a/drivers/phy/mediatek/phy-mtk-io.h
> > > > b/drivers/phy/mediatek/phy-mtk-io.h
> > > > new file mode 100644
> > > > index 000000000000..500fcdab165d
> > > > --- /dev/null
> > > > +++ b/drivers/phy/mediatek/phy-mtk-io.h
> > > > @@ -0,0 +1,38 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +/*
> > > > + * Copyright (C) 2021 MediaTek Inc.
> > > > + *
> > > > + * Author: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > + */
> > > > +
> > > > +#ifndef __PHY_MTK_H__
> > > > +#define __PHY_MTK_H__
> > > > +
> > > > +#include <linux/io.h>
> > > > +
> > > > +static inline void mtk_phy_clear_bits(void __iomem *reg, u32
> > > > bits)
> > > > +{
> > > > +	u32 tmp = readl(reg);
> > > > +
> > > > +	tmp &= ~bits;
> > > > +	writel(tmp, reg);
> > > > +}
> > > > +
> > > > +static inline void mtk_phy_set_bits(void __iomem *reg, u32
> > > > bits)
> > > > +{
> > > > +	u32 tmp = readl(reg);
> > > > +
> > > > +	tmp |= bits;
> > > > +	writel(tmp, reg);
> > > > +}
> > > > +
> > > > +static inline void mtk_phy_update_bits(void __iomem *reg, u32
> > > > mask, u32 val)
> > > > +{
> > > > +	u32 tmp = readl(reg);
> > > > +
> > > > +	tmp &= ~mask;
> > > > +	tmp |= val & mask;
> > > > +	writel(tmp, reg);
> > > > +}
> > > > +
> > > > +#endif
> > > > 
> > > 
> > > These helpers are almost exactly duplicating what
> > > regmap_update_bits() is doing.
> > > I appreciate the effort to stop open-coding the same sequences
> > > over
> > > and over by
> > > adding such helper functions,
> > 
> > I agree with you.
> > > but I think that the proper way of doing what you
> > > are proposing is not to add custom functions but rather reuse
> > > what
> > > the Linux APIs
> > > give you.
> > 
> > I also like to use common APIs ASAP, but not found suitable ones.
> > This may be a problem, I found that some similar custom helps
> > already
> > added under phy fold.
> > 
> > > 
> > > What about doing a conversion to use regmap on this driver?
> > 
> > No, we don't use regmap here, these registers are monopolized by t-
> > phy,
> > it's not syscon.
> > 
> > 
> 
> Hello,
> 
> The regmap API allows this kind of usage, registers don't necessarily
> have
> to be part of a syscon.
I'm sorry, I don't want to make it more complex

> 
> Regards,
> - Angelo

