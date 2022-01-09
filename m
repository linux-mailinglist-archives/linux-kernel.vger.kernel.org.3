Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A848488763
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 03:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiAICq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 21:46:56 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:54232 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232210AbiAICqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 21:46:55 -0500
X-UUID: 76def63b6d2841baa0155eb7c3a2a142-20220109
X-UUID: 76def63b6d2841baa0155eb7c3a2a142-20220109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 474611172; Sun, 09 Jan 2022 10:46:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 9 Jan 2022 10:46:50 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:46:49 +0800
Message-ID: <214831c674c23d6733d372b5970d8c6754d55b1d.camel@mediatek.com>
Subject: Re: [PATCH v3 26/33] iommu/mediatek: Add mtk_iommu_bank_data
 structure
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <yen-chang.chen@mediatek.com>
Date:   Sun, 9 Jan 2022 10:46:49 +0800
In-Reply-To: <5ac9dd6b-43cd-0f76-eb34-906ab84196c1@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-27-yong.wu@mediatek.com>
         <5ac9dd6b-43cd-0f76-eb34-906ab84196c1@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi AngeloGioacchino,

Thanks very much for reviewing whole the patchset.

On Tue, 2022-01-04 at 16:53 +0100, AngeloGioacchino Del Regno wrote:
> Il 23/09/21 13:58, Yong Wu ha scritto:
> > Prepare for supporting multi-banks for the IOMMU HW, No functional
> > change.
> > 
> > Add a new structure(mtk_iommu_bank_data) for each a bank. Each a
> > bank have
> > the independent HW base/IRQ/tlb-range ops, and each a bank has its
> > special
> > iommu-domain(independent pgtable), thus, also move the domain
> > information
> > into it.
> > 
> > In previous SoC, we have only one bank which could be treated as
> > bank0(
> > bankid always is 0 for the previous SoC).
> > 
> > After adding this structure, the tlb operations and irq could use
> > bank_data as parameter.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---

[...]
  
> > -struct mtk_iommu_data {
> > +struct mtk_iommu_bank_data {
> >   	void __iomem			*base;
> >   	int				irq;
> > +	unsigned int			id;
> > +	struct device			*pdev;
> 
> `pdev` may be a bit misleading, as it's conventionally read as
> "platform device"
> and not as the intended "parent device"... perhaps calling it
> parent_dev would be
> more appropriate.

will rename it. Thanks.

> 
> > +	struct mtk_iommu_data		*pdata;   /* parent data */
> 
> Same here, pdata -> parent_data

Will fix.

> 
> > +	spinlock_t			tlb_lock; /* lock for tlb range
> > flush */
> > +	struct mtk_iommu_domain		*m4u_dom; /* Each bank has
> > a domain */
> > +};
> > +
> > +struct mtk_iommu_data {
> > +	union {
> > +		struct { /* only for gen1 */
> > +			void __iomem		*base;
> > +			int			irq;
> > +			struct mtk_iommu_domain	*m4u_dom;
> > +		};
> > +
> > +		/* only for gen2 that support multi-banks */
> > +		struct mtk_iommu_bank_data	bank[MTK_IOMMU_BANK_MAX];
> > +	};
> 
> Sorry, but I really don't like this union... please, update
> mtk_iommu_v1 to always
> use bank[0] or, more appropriately, dynamically allocate the bank
> array with a
> devm_kzalloc call (as to not waste memory on platforms with less
> available banks).
> 
> In that case, you would have...
> 
> >   	struct device			*dev;
> >   	struct clk			*bclk;
> >   	phys_addr_t			protect_base; /* protect memory
> > base */
> >   	struct mtk_iommu_suspend_reg	reg;
> > -	struct mtk_iommu_domain		*m4u_dom;
> >   	struct iommu_group		*m4u_group[MTK_IOMMU_GROUP_MAX];
> >   	bool                            enable_4GB;
> > -	spinlock_t			tlb_lock; /* lock for tlb range
> > flush */
> 
> 	struct mtk_iommu_bank_data	*banks;
> 	u8				num_banks;
> 
> ... where `num_banks` gets copied from the same in
> mtk_iommu_plat_data, defined
> for each SoC, and where `banks` is dynamically allocated in
> mtk_iommu.c and
> mtk_iommu_v1.c's probe() callback.

Thanks for this idea. I will try this to see if the code will be too
complicate after changing this. If it is, I will use bank[0] always in
mtk_iommu_v1, this looks simpler.

> 
> >   
> >   	struct iommu_device		iommu;
> >   	const struct mtk_iommu_plat_data *plat_data;
> > 
> 
> 

