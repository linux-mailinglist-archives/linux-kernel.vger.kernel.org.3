Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC6C049B462
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573633AbiAYMyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:54:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59100 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1384313AbiAYMvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:51:16 -0500
X-UUID: b67cbdc283cd4b23861d28af727d9119-20220125
X-UUID: b67cbdc283cd4b23861d28af727d9119-20220125
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1320030013; Tue, 25 Jan 2022 20:51:10 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 25 Jan 2022 20:51:09 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 25 Jan 2022 20:51:09 +0800
Message-ID: <cb048ff99e4bd20eb8b3b70de13baf5a27f52138.camel@mediatek.com>
Subject: Re: [PATCH v2 1/2] soc: mediatek: pwrap: add pwrap driver for
 MT8186 SoC
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Tue, 25 Jan 2022 20:51:09 +0800
In-Reply-To: <f5486d12-b048-c062-e571-cf39da7e4c1b@gmail.com>
References: <20220107104633.7500-1-johnson.wang@mediatek.com>
         <20220107104633.7500-2-johnson.wang@mediatek.com>
         <9949a1f7-1ed5-a137-c7b9-2ef8d8e1caf8@gmail.com>
         <544f5085fc8597ce9ce3eb7dc1b5d08fb1ac8755.camel@mediatek.com>
         <f5486d12-b048-c062-e571-cf39da7e4c1b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On Tue, 2022-01-18 at 14:17 +0100, Matthias Brugger wrote:
> 
> On 18/01/2022 10:25, Johnson Wang wrote:
> > Hi Matthias,
> > 
> > On Fri, 2022-01-14 at 16:46 +0100, Matthias Brugger wrote:
> > > 
> > > On 07/01/2022 11:46, Johnson Wang wrote:
> > > > MT8186 are highly integrated SoC and use PMIC_MT6366 for
> > > > power management. This patch adds pwrap master driver to
> > > > access PMIC_MT6366.
> > > > 
> > > 
> > > It seems this new arbiter is significantly different from the
> > > version
> > > 1. Please
> > > explain that in the commit message.
> > > 
> > > > Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> > > > ---
> > > >    drivers/soc/mediatek/mtk-pmic-wrap.c | 72
> > > > ++++++++++++++++++++++++++++
> > > >    1 file changed, 72 insertions(+)
> > > > 
> > > > diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > > > b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > > > index 952bc554f443..78866ebf7f04 100644
> > > > --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> > > > +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> > > > @@ -30,6 +30,7 @@
> > > >    #define PWRAP_GET_WACS_REQ(x)		(((x) >> 19) &
> > > > 0x00000001)
> > > >    #define PWRAP_STATE_SYNC_IDLE0		BIT(20)
> > > >    #define PWRAP_STATE_INIT_DONE0		BIT(21)
> > > > +#define PWRAP_STATE_INIT_DONE0_V2	BIT(22)
> > > 
> > > That's a strange name, does it come from the datasheet
> > > description?
> > 
> > Thanks for your review.
> > 
> > No, there is only PWRAP_STATE_INIT_DONE0 in MT8186 datasheet.
> > However, it's the 22nd bit in MT8186 and the 21st bit in other
> > SoCs.
> > So we changed its name to avoid redefinition of
> > PWRAP_STATE_INIT_DONE0.
> > 
> > Could you give us some suggestion on proper definition naming?
> > Do you think PWRAP_STATE_INIT_DONE0_MT8186 will be a better choice?
> > 
> 
> Is this a difference that only will show up on the PMIC-wrapper of
> MT8186 or 
> will other SoCs include the same IP? If not, then
> PWRAP_STATE_INIT_DONE0_MT8186 
> should be fine. Otherwise we would need a better name.
> 

In fact, we don't know whether following SoCs will include
the same IP in the future.

Can we just replace _V2 with _MT8186 this time or
please give us some suggestion on it. 

Thanks for your response.

> > > 
> > > >    #define PWRAP_STATE_INIT_DONE1		BIT(15)
> > > >    
> > > >    /* macro for WACS FSM */
> > > > @@ -77,6 +78,8 @@
> > > >    #define PWRAP_CAP_INT1_EN	BIT(3)
> > > >    #define PWRAP_CAP_WDT_SRC1	BIT(4)
> > > >    #define PWRAP_CAP_ARB		BIT(5)
> > > > +#define PWRAP_CAP_MONITOR_V2	BIT(6)
> > > 
> > > Not used capability, please delete.
> > > 
> > > 
> > > Regards,
> > > Matthias
> > 
> > PWRAP_CAP_MONITOR_V2 is not used right now.
> > We can remove it in next version.
> > But this capability will be added when we need it.
> > 
> 
> That's OK, we should add capability definitions once they are added
> to the 
> driver, not before that.
> 
> Thanks,
> Matthias

