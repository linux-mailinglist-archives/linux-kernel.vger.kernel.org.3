Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64E7C54DABC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358671AbiFPGdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359170AbiFPGdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:33:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5F25537E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:33:24 -0700 (PDT)
X-UUID: 7608da4f38054f698be63d429a124dd1-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:17ee88ea-ae02-41b8-96b4-b4d9ff41cafd,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:fa9671f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7608da4f38054f698be63d429a124dd1-20220616
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1452309844; Thu, 16 Jun 2022 14:33:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 14:33:17 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Jun 2022 14:33:16 +0800
From:   <yf.wang@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <Libo.Kang@mediatek.com>, <Yong.Wu@mediatek.com>,
        <iommu@lists.linux-foundation.org>, <isaacm@codeaurora.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <quic_c_gdjako@quicinc.com>, <sven@svenpeter.dev>,
        <will@kernel.org>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>
Subject: Re: [PATCH v9 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
Date:   Thu, 16 Jun 2022 14:26:28 +0800
Message-ID: <20220616062628.10101-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <5083aed9-fa31-b91c-6ca6-29dbc4d0807a@arm.com>
References: <5083aed9-fa31-b91c-6ca6-29dbc4d0807a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-15 at 18:03 +0100, Robin Murphy wrote:
> On 2022-06-15 17:12, yf.wang@mediatek.com wrote:
> > 
> >   static phys_addr_t iopte_to_paddr(arm_v7s_iopte pte, int lvl,
> >   				  struct io_pgtable_cfg *cfg)
> >   {
> > @@ -240,10 +245,17 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >   	dma_addr_t dma;
> >   	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
> >   	void *table = NULL;
> > +	gfp_t gfp_l1;
> > +
> > +	/*
> > +	 * ARM_MTK_TTBR_EXT extend the translation table base support
> > all
> > +	 * memory address.
> > +	 */
> > +	gfp_l1 = cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> > +		 GFP_KERNEL : ARM_V7S_TABLE_GFP_DMA;
> >   
> >   	if (lvl == 1)
> > -		table = (void *)__get_free_pages(
> > -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA,
> > get_order(size));
> > +		table = (void *)__get_free_pages(gfp_l1 | __GFP_ZERO,
> > get_order(size));
> >   	else if (lvl == 2)
> >   		table = kmem_cache_zalloc(data->l2_tables, gfp);
> >   
> > @@ -251,7 +263,8 @@ static void *__arm_v7s_alloc_table(int lvl,
> > gfp_t gfp,
> >   		return NULL;
> >   
> >   	phys = virt_to_phys(table);
> > -	if (phys != (arm_v7s_iopte)phys) {
> > +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT ?
> > +	    phys >= (1ULL << cfg->oas) : phys != (arm_v7s_iopte)phys) {
> 
> Given that the comment above says it supports all of memory, how
> would 
> phys >= (1ULL << cfg->oas) ever be true?
> 

Hi Robin,

Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
so add a quirk to allow the PA of pgtables support up to bit35,
but need to check oas do error hanlde.


> >   		/* Doesn't fit in PTE */
> >   		dev_err(dev, "Page table does not fit in PTE: %pa",
> > &phys);
> >   		goto out_free;
> > arm_v7s_install_table(arm_v7s_iopte *table,
> >   					   arm_v7s_iopte curr,
> >   					   struct io_pgtable_cfg *cfg)

...
 
> > diff --git a/include/linux/io-pgtable.h b/include/linux/io-
> > pgtable.h
> > index 86af6f0a00a2..c9189716f6bd 100644
> > --- a/include/linux/io-pgtable.h
> > +++ b/include/linux/io-pgtable.h
> > @@ -74,17 +74,22 @@ struct io_pgtable_cfg {
> >   	 *	to support up to 35 bits PA where the bit32, bit33 and
> > bit34 are
> >   	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
> >   	 *
> > +	 * IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT: (ARM v7s format) MediaTek
> > IOMMUs
> > +	 *	extend the translation table base support up to 35 bits PA,
> > the
> > +	 *	encoding format is same with IO_PGTABLE_QUIRK_ARM_MTK_EXT.
> > +	 *
> >   	 * IO_PGTABLE_QUIRK_ARM_TTBR1: (ARM LPAE format) Configure the
> > table
> >   	 *	for use in the upper half of a split address space.
> >   	 *
> >   	 * IO_PGTABLE_QUIRK_ARM_OUTER_WBWA: Override the outer-
> > cacheability
> >   	 *	attributes set in the TCR for a non-coherent page-table
> > walker.
> >   	 */
> > -	#define IO_PGTABLE_QUIRK_ARM_NS		BIT(0)
> > -	#define IO_PGTABLE_QUIRK_NO_PERMS	BIT(1)
> > -	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT	BIT(3)
> > -	#define IO_PGTABLE_QUIRK_ARM_TTBR1	BIT(5)
> > -	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA	BIT(6)
> > +	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
> > +	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> > +	#define IO_PGTABLE_QUIRK_ARM_MTK_EXT		BIT(3)
> > +	#define IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT	BIT(4)
> > +	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
> > +	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
> >   	unsigned long			quirks;
> >   	unsigned long			pgsize_bitmap;
> >   	unsigned int			ias;
> > @@ -122,7 +127,7 @@ struct io_pgtable_cfg {
> >   		} arm_lpae_s2_cfg;
> >   
> >   		struct {
> > -			u32	ttbr;
> > +			u64	ttbr;
> 
> The point of this is to return an encoded TTBR register value, not a
> raw 
> base address. I see from the other patches that your register is
> still 
> 32 bits, so I'd prefer to follow the standard pattern and not need
> this 
> change.
> 
> Thanks,
> Robin.
> 

Hi Robin,
Thanks for your suggestion, next version will recovery ttbr to 32 bits,
will modify arm_v7s_alloc_pgtable to return an encoded TTBR, encoded
PA bits[34:32] to to lower bits, as follows:

/* TTBR */
phys_addr_t paddr;
paddr = virt_to_phys(data->pgd);
cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) | ARM_V7S_TTBR_S |
			(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS |
			 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBWA) |
			 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBWA)) :
			(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC) |
			 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)));

if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
	cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
				upper_32_bits(paddr);

Thanks,
Yunfei.

> >   			u32	tcr;
> >   			u32	nmrr;
> >   			u32	prrr;
