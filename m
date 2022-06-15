Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113B254CB27
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 16:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbiFOOVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 10:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347416AbiFOOVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 10:21:17 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A84544B403
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 07:21:09 -0700 (PDT)
X-UUID: 95235e6e05714a97ab6a52166d268a1a-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c4f47823-d73c-46fb-a21b-2d909cce153f,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:26
X-CID-INFO: VERSION:1.1.6,REQID:c4f47823-d73c-46fb-a21b-2d909cce153f,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:26,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:26
X-CID-META: VersionHash:b14ad71,CLOUDID:dffd58f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:28|100|17|19|48|101,TC:nil,Content:0,EDM:-3,IP:ni
        l,URL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 95235e6e05714a97ab6a52166d268a1a-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1618739428; Wed, 15 Jun 2022 22:21:02 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 22:21:00 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 22:20:59 +0800
From:   <yf.wang@mediatek.com>
To:     <will@kernel.org>
CC:     <Libo.Kang@mediatek.com>, <Yong.Wu@mediatek.com>,
        <iommu@lists.linux-foundation.org>, <isaacm@codeaurora.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <quic_c_gdjako@quicinc.com>, <robin.murphy@arm.com>,
        <sven@svenpeter.dev>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>
Subject: Re: [PATCH v8 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
Date:   Wed, 15 Jun 2022 22:14:11 +0800
Message-ID: <20220615141411.5119-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220614125630.GA8159@willie-the-truck>
References: <20220614125630.GA8159@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-06-14 at 13:56 +0100, Will Deacon wrote:
> Hi,
> 
> For some reason, this series has landed in my spam folder so
> apologies
> for the delay :/
> 
> 
> > +static arm_v7s_iopte paddr_to_iopte(phys_addr_t paddr, int lvl,
> > +				    struct io_pgtable_cfg *cfg)
> > +{
> > +	arm_v7s_iopte pte = paddr & ARM_V7S_LVL_MASK(lvl);
> > +
> > +	if (!arm_v7s_is_mtk_enabled(cfg))
> > +		return pte;
> > +
> > +	return to_iopte_mtk(paddr, pte);
> 
> nit, but can we rename and rework this so it reads a bit better,
> please?
> Something like:
> 
> 
> 	if (arm_v7s_is_mtk_enabled(cfg))
> 		return to_mtk_iopte(paddr, pte);
> 
> 	return pte;
> 
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will modify it.


> >  static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >  				  struct io_pgtable_cfg *cfg)
> >  {
> > @@ -234,6 +239,7 @@ static arm_v7s_iopte *iopte_deref(arm_v7s_iopte
> > pte, int lvl,
> >  static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
> >  				   struct arm_v7s_io_pgtable *data)
> >  {
> > +	gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
> >  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> >  	struct device *dev = cfg->iommu_dev;
> >  	phys_addr_t phys;
> > @@ -241,9 +247,11 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >  	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
> >  	void *table = NULL;
> >  
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> > +		gfp_l1 = GFP_KERNEL | __GFP_ZERO;
> 
> I think it's a bit grotty to override the flags inline like this
> (same for
> the slab flag later on). Something like this is a bit cleaner:
> 
> 
> 	/*
> 	 * Comment explaining why GFP_KERNEL is desirable here.
> 	 * I'm assuming it's because the walker can address all of
> memory.
> 	 */
> 	gfp_l1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> 		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
> 
> 	...
> 
> 	__get_free_pages(gfp_l1 | __GFP_ZERO, ...);
> 
> 
> and similar for the slab flag.
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will modify it.


> >  	if (lvl == 1)
> > -		table = (void *)__get_free_pages(
> > -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA,
> > get_order(size));
> > +		table = (void *)__get_free_pages(gfp_l1,
> > get_order(size));
> >  	else if (lvl == 2)
> >  		table = kmem_cache_zalloc(data->l2_tables, gfp);
> >  
> > @@ -251,7 +259,8 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >  		return NULL;
> >  
> >  	phys = virt_to_phys(table);
> > -	if (phys != (arm_v7s_iopte)phys) {
> > +	if (phys != (arm_v7s_iopte)phys &&
> > +	    !(cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)) {
> >  		/* Doesn't fit in PTE */
> 
> Shouldn't we be checking that the address is within 35 bits here?
> Perhaps we
> should generate a mask from the oas instead of just using the cast.
> 

Hi Will,
Thanks for your suggestion, PATCH v9 version will add checking that the address is within 35 bits:

phys = virt_to_phys(table);
if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
    phys >= (1ULL << cfg->oas) : phys != (arm_v7s_iopte)phys) {
	/* Doesn't fit in PTE */


Thanks,
Yunfei.
