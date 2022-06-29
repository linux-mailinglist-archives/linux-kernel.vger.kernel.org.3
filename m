Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9951A560072
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 14:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbiF2MvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 08:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF2MvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 08:51:09 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE7532EC9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 05:51:07 -0700 (PDT)
X-UUID: dfe6b9e3523a4b43891c40f87b43b53c-20220629
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.7,REQID:f30fd70c-5076-48ad-aaf4-061616af7cea,OB:10,L
        OB:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:50
X-CID-INFO: VERSION:1.1.7,REQID:f30fd70c-5076-48ad-aaf4-061616af7cea,OB:10,LOB
        :0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:50
X-CID-META: VersionHash:87442a2,CLOUDID:558df762-0b3f-4b2c-b3a6-ed5c044366a0,C
        OID:b851f965efbe,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dfe6b9e3523a4b43891c40f87b43b53c-20220629
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1556319841; Wed, 29 Jun 2022 20:51:01 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 29 Jun 2022 20:50:59 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 29 Jun 2022 20:50:58 +0800
From:   <yf.wang@mediatek.com>
To:     <yong.wu@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <iommu@lists.linux-foundation.org>,
        <isaacm@codeaurora.org>, <joro@8bytes.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <quic_c_gdjako@quicinc.com>, <robin.murphy@arm.com>,
        <sven@svenpeter.dev>, <will@kernel.org>,
        <wsd_upstream@mediatek.com>, <yf.wang@mediatek.com>
Subject: Re: [PATCH v10 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
Date:   Wed, 29 Jun 2022 20:44:03 +0800
Message-ID: <20220629124403.18122-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
References: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-22 at 09:28 +0800, Yong Wu wrote:
> On Thu, 2022-06-16 at 20:07 +0800, yf.wang@mediatek.com wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> > cause pgtable PA size larger than 32bit.
> > 
> > Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> > so add a quirk to allow the PA of pgtables support up to bit35.
> > 
> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >  drivers/iommu/io-pgtable-arm-v7s.c | 67 +++++++++++++++++++++++---
> > --
> > --
> >  include/linux/io-pgtable.h         | 15 ++++---
> >  2 files changed, 63 insertions(+), 19 deletions(-)
> 
> [...]
> 
> >  	/* TTBR */
> > -	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) |
> > ARM_V7S_TTBR_S |
> > +	paddr = virt_to_phys(data->pgd);
> > +	cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
> >  				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS
> > > 
> > 
> >  				 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBW
> > A) |
> >  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBW
> > A)) :
> >  				(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC)
> > > 
> > 
> >  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)
> > ));
> > +
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +		cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
> > +					upper_32_bits(paddr);
> 
> If we keep ttbr u32, we have to put the special logic here. This line
> is ok for all the MediaTek cases, not only for this quirk. It means:
> 
>     if (arm_v7s_is_mtk_enabled(cfg))
>            cfg->arm_v7s_cfg.ttbr = (virt_to_phys(data->pgd) &
> GENMASK(31, 7)) | upper_32_bits(paddr);
>     else
>            xxx
>  
>      Then we don't need add "& MMU_PT_ADDR_MASK" in mtk_iommu.c since
> you have done it here.
> 

Hi Yong,
Thanks for your suggestion, PATCH v11 version will modify it.

Thanks,
Yunfei.

> > +
> >  	return &data->iop;
> >  
