Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFD748877D
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 03:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235145AbiAICrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 21:47:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53056 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235091AbiAICrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 21:47:52 -0500
X-UUID: 87e6c757e50c497884fa8f0af50da503-20220109
X-UUID: 87e6c757e50c497884fa8f0af50da503-20220109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 53744251; Sun, 09 Jan 2022 10:47:48 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 9 Jan 2022 10:47:47 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 10:47:46 +0800
Message-ID: <694747210c8da8ae4fc282cd90152e5c81945da5.camel@mediatek.com>
Subject: Re: [PATCH v3 22/33] iommu/mediatek: Add PCIe support
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <chao.hao@mediatek.com>,
        <yen-chang.chen@mediatek.com>
Date:   Sun, 9 Jan 2022 10:47:46 +0800
In-Reply-To: <3b5e7072-0935-4383-27a1-dd8d623cc608@collabora.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
         <20210923115840.17813-23-yong.wu@mediatek.com>
         <3b5e7072-0935-4383-27a1-dd8d623cc608@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-04 at 16:54 +0100, AngeloGioacchino Del Regno wrote:
> Il 23/09/21 13:58, Yong Wu ha scritto:
> > Currently the code for of_iommu_configure_dev_id is like this:
> > 
> > static int of_iommu_configure_dev_id(struct device_node *master_np,
> >                                       struct device *dev,
> >                                       const u32 *id)
> > {
> >         struct of_phandle_args iommu_spec = { .args_count = 1 };
> > 
> >         err = of_map_id(master_np, *id, "iommu-map",
> >                         "iommu-map-mask", &iommu_spec.np,
> >                         iommu_spec.args);
> > ...
> > }
> > 
> > It supports only one id output. BUT our PCIe HW has two ID(one is
> > for
> > writing, the other is for reading). I'm not sure if we should
> > change
> > of_map_id to support output MAX_PHANDLE_ARGS.
> > 
> > Here add the solution in ourselve drivers. If it's pcie case,
> > enable one
> > more bit.
> > 
> > Not all infra iommu support PCIe, thus add a PCIe support flag
> > here.
> > 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++++++-
> >   1 file changed, 20 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index 37d6dfb4feab..3f1fd8036345 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -20,6 +20,7 @@
> >   #include <linux/of_address.h>
> >   #include <linux/of_irq.h>
> >   #include <linux/of_platform.h>
> > +#include <linux/pci.h>
> >   #include <linux/platform_device.h>
> >   #include <linux/pm_runtime.h>
> >   #include <linux/regmap.h>
> > @@ -132,6 +133,7 @@
> >   #define MTK_IOMMU_TYPE_MM		(0x0 << 13)
> >   #define MTK_IOMMU_TYPE_INFRA		(0x1 << 13)
> >   #define MTK_IOMMU_TYPE_MASK		(0x3 << 13)
> > +#define IFA_IOMMU_PCIe_SUPPORT		BIT(15)
> 
> This definition looks like "breaking" the naming convention that's
> used in this
> driver... what about MTK_INFRA_IOMMU_PCIE_SUPPORT?

OK for me. I noticed the "PCIE" should called to "PCIe", thus renamed
this.

> 
> >   
> >   #define MTK_IOMMU_HAS_FLAG(pdata, _x)	(!!(((pdata)->flags) &
> > (_x)))
> >   
> > @@ -401,8 +403,11 @@ static int mtk_iommu_config(struct
> > mtk_iommu_data *data, struct device *dev,
> >   				larb_mmu->mmu &=
> > ~MTK_SMI_MMU_EN(portid);
> >   		} else if (MTK_IOMMU_IS_TYPE(data->plat_data,
> > MTK_IOMMU_TYPE_INFRA)) {
> >   			peri_mmuen_msk = BIT(portid);
> > -			peri_mmuen = enable ? peri_mmuen_msk : 0;
> > +			/* PCIdev has only one output id, enable the
> > next writing bit for PCIe */
> > +			if (dev_is_pci(dev))
> > +				peri_mmuen_msk |= BIT(portid + 1);
> >   
> > +			peri_mmuen = enable ? peri_mmuen_msk : 0;
> >   			ret = regmap_update_bits(data->pericfg,
> > PERICFG_IOMMU_1,
> >   						 peri_mmuen_msk,
> > peri_mmuen);
> >   			if (ret)
> > @@ -977,6 +982,15 @@ static int mtk_iommu_probe(struct
> > platform_device *pdev)
> >   		ret = component_master_add_with_match(dev,
> > &mtk_iommu_com_ops, match);
> >   		if (ret)
> >   			goto out_bus_set_null;
> > +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data,
> > MTK_IOMMU_TYPE_INFRA) &&
> > +		   MTK_IOMMU_HAS_FLAG(data->plat_data,
> > IFA_IOMMU_PCIe_SUPPORT)) {
> > +		#ifdef CONFIG_PCI
> 
> Please fix the indentation of this ifdef (do not indent).

Thanks. Will fix this.

> 
> > +		if (!iommu_present(&pci_bus_type)) {
> > +			ret = bus_set_iommu(&pci_bus_type,
> > &mtk_iommu_ops);
> > +			if (ret) /* PCIe fail don't affect
> > platform_bus. */
> > +				goto out_list_del;
> > +		}
> > +		#endif
> >   	}
> >   	return ret;
> >   
> > @@ -1007,6 +1021,11 @@ static int mtk_iommu_remove(struct
> > platform_device *pdev)
> >   	if (MTK_IOMMU_IS_TYPE(data->plat_data, MTK_IOMMU_TYPE_MM)) {
> >   		device_link_remove(data->smicomm_dev, &pdev->dev);
> >   		component_master_del(&pdev->dev, &mtk_iommu_com_ops);
> > +	} else if (MTK_IOMMU_IS_TYPE(data->plat_data,
> > MTK_IOMMU_TYPE_INFRA) &&
> > +		   MTK_IOMMU_HAS_FLAG(data->plat_data,
> > IFA_IOMMU_PCIe_SUPPORT)) {
> > +		#ifdef CONFIG_PCI
> 
> ditto.
> 
> > +		bus_set_iommu(&pci_bus_type, NULL);
> > +		#endif
> >   	}
> >   	pm_runtime_disable(&pdev->dev);
> >   	devm_free_irq(&pdev->dev, data->irq, data);
> > 
> 
> 

