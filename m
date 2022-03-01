Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639654C857B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbiCAHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiCAHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:50:12 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28D43AE8;
        Mon, 28 Feb 2022 23:49:26 -0800 (PST)
X-UUID: 5ddf81f3816d4d73888bb7d609c8aac6-20220301
X-UUID: 5ddf81f3816d4d73888bb7d609c8aac6-20220301
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 555010733; Tue, 01 Mar 2022 15:49:21 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 1 Mar 2022 15:49:20 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Mar 2022 15:49:18 +0800
Message-ID: <5ed9278fa0b72b993512cff2316218ab88cafe50.camel@mediatek.com>
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
From:   Yong Wu <yong.wu@mediatek.com>
To:     Joerg Roedel <joro@8bytes.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
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
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        <yen-chang.chen@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>
Date:   Tue, 1 Mar 2022 15:49:18 +0800
In-Reply-To: <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
         <YhzBSsn/zUlGg5JE@8bytes.org>
         <7ba0ee87-c193-9834-d0b4-ff3e06ced82b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-02-28 at 14:50 +0100, AngeloGioacchino Del Regno wrote:
> Il 28/02/22 13:34, Joerg Roedel ha scritto:
> > Hi Yong Wu,
> > 
> > On Thu, Feb 17, 2022 at 07:34:19PM +0800, Yong Wu wrote:
> > > Yong Wu (34):
> > >    dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
> > >    dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
> > >    iommu/mediatek: Fix 2 HW sharing pgtable issue
> > >    iommu/mediatek: Add list_del in mtk_iommu_remove
> > >    iommu/mediatek: Remove clk_disable in mtk_iommu_remove
> > >    iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
> > >    iommu/mediatek: Add mutex for data in the mtk_iommu_domain
> > >    iommu/mediatek: Adapt sharing and non-sharing pgtable case
> > >    iommu/mediatek: Add 12G~16G support for multi domains
> > >    iommu/mediatek: Add a flag DCM_DISABLE
> > >    iommu/mediatek: Add a flag NON_STD_AXI
> > >    iommu/mediatek: Remove the granule in the tlb flush
> > >    iommu/mediatek: Always enable output PA over 32bits in isr
> > >    iommu/mediatek: Add SUB_COMMON_3BITS flag
> > >    iommu/mediatek: Add IOMMU_TYPE flag
> > >    iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
> > >    iommu/mediatek: Adjust device link when it is sub-common
> > >    iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
> > >    iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
> > >    iommu/mediatek: Add infra iommu support
> > >    iommu/mediatek: Add PCIe support
> > >    iommu/mediatek: Add mt8195 support
> > >    iommu/mediatek: Only adjust code about register base
> > >    iommu/mediatek: Just move code position in hw_init
> > >    iommu/mediatek: Separate mtk_iommu_data for v1 and v2
> > >    iommu/mediatek: Remove mtk_iommu.h
> > >    iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
> > >    iommu/mediatek: Add mtk_iommu_bank_data structure
> > >    iommu/mediatek: Initialise bank HW for each a bank
> > >    iommu/mediatek: Change the domid to iova_region_id
> > >    iommu/mediatek: Get the proper bankid for multi banks
> > >    iommu/mediatek: Initialise/Remove for multi bank dev
> > >    iommu/mediatek: Backup/restore regsiters for multi banks
> > >    iommu/mediatek: mt8195: Enable multi banks for infra iommu
> > 
> > This doesn't apply cleanly, can you please send a version rebased
> > to
> > v5.17-rc4?

As in the cover letter, this patchset doesn't base on v5.17-rc4, it
bases on next-20220216 which has contained [1] and Dafna's patchset
below.

By the way, It still conflicts with the latest next-20220228 which has
just contained[2].

In this case, How should I do? Send a version base on the latest next?

[1] 
https://lore.kernel.org/linux-iommu/20220117070510.17642-1-yong.wu@mediatek.com/

[2] 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?h=next-20220228&qt=grep&q=component_compare

Thanks.

> > 
> > Thanks,
> > 
> > 	Joerg
> 
> Hello Joerg,
> 
> this series depends on the following series:
> 
https://patchwork.kernel.org/project/linux-mediatek/list/?series=592275
> 
> ...which is also well tested and ready to be merged in.
> 
> Applying Yong's series without the mentioned series from Dafna would
> not work.

Yes. Thanks.

> 
> 
> Thanks,
> Angelo

