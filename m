Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546CF5473BC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 12:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiFKK1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 06:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiFKK1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 06:27:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5FF46CBE
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 03:27:37 -0700 (PDT)
X-UUID: 7c31f1b7d9594a21a4944d47d526e54e-20220611
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:d8de2fa8-8b75-48a0-a16f-78419e69c8db,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:5c1385e7-1f03-4449-90ad-e6cb8f3d1399,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: 7c31f1b7d9594a21a4944d47d526e54e-20220611
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 57457508; Sat, 11 Jun 2022 18:27:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Jun 2022 18:27:25 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Jun 2022 18:27:24 +0800
From:   <yf.wang@mediatek.com>
To:     <yong.wu@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <ning.li@mediatek.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <miles.chen@mediatek.com>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>
Subject: Re: [PATCH v5 2/2] iommu/mediatek: Allow page table PA up to 35bit
Date:   Sat, 11 Jun 2022 18:20:38 +0800
Message-ID: <20220611102038.10890-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
References: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-05-19 at 14:58 +0800, Yong Wu wrote:
> On Mon, 2022-05-16 at 22:16 +0800, yf.wang@mediatek.com wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
> > allows
> > page table PA up to 35bit, not only in ZONE_DMA32.
> 
> Comment why this is needed.
> 
> e.g. For single normal zone.
> 


Hi Yong,

There is no DMA32 zone in some mediatek smartphone chip for single
normal zone.

The level 1 and level 2 pgtable are both allocated in ZONE_DMA32,
and may have two possible problem:
1.The level 2 pgtable is allocated in ZONE_DMA32 with atomic flag,
 and it may fail if ZONE_DMA32 memory is used out.
2.Single memory feature will make ZONE_DMA32 empty, and cause level
 1 and level 2 pgtable PA more than 32bit.

Solution:
Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that
level 1 and level 2 pgtable can support at most 35bit PA.

I had updated the commit message in V7 version.


> >  		data->m4u_dom = dom;
> > -		writel(dom->cfg.arm_v7s_cfg.ttbr & MMU_PT_ADDR_MASK,
> > -		       data->base + REG_MMU_PT_BASE_ADDR);
> > +
> > +		/* Bits[6:3] are invalid for mediatek platform */
> > +		if (MTK_IOMMU_HAS_FLAG(data->plat_data,
> > PGTABLE_PA_35_EN))
> > +			regval = (dom->cfg.arm_v7s_cfg.ttbr &
> > MMU_PT_ADDR_MASK) |
> > +				 (dom->cfg.arm_v7s_cfg.ttbr &
> > MMU_PT_ADDR_2_0_MASK);
> 
> The bits[2:0] has already handled in ARM_V7S_TTBR_35BIT_PA of
> patch[1/2], we need calculate it again here?
> 
> 1) Extend arm_v7s_cfg.ttbr to u64, then we could put the special ttbr
> logical into our file.
> 
> 2) if 1) is not allowed, We have to put this in v7s.
> if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT) {
>        cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
> upper_32_bits(paddr);
>        return &data->iop;
> }
> 
> This need Robin/Will confirm.
> 


Hi Yong,

V7 version had extended arm_v7s_cfg.ttbr to u64, then put the special
ttbr logical into MediaTek file.


> > +		else
> > +			regval = dom->cfg.arm_v7s_cfg.ttbr &
> > MMU_PT_ADDR_MASK;
> 
> Save this value to our data. then we don't need calculate it again in
> the resume cb.   
> 

Hi Yong,

V8 version will Save the special ttbr to mtk_iommu_domain avoid
calculate it again.

Thanks,
Yunfei.
