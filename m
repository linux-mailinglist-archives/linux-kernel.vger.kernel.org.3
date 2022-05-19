Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908FB52CBE9
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiESG2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiESG2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:28:06 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27D76340
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 23:28:04 -0700 (PDT)
X-UUID: b62dcbed06474a8e88f93930327a0936-20220519
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:0bc9d3c8-58d6-4f9c-928b-0be75cd998c4,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:2a19b09,CLOUDID:3f05d279-5ef6-470b-96c9-bdb8ced32786,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: b62dcbed06474a8e88f93930327a0936-20220519
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 397011629; Thu, 19 May 2022 14:27:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 19 May 2022 14:27:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 May 2022 14:27:56 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <yf.wang@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <Yong.Wu@mediatek.com>,
        <iommu@lists.linux-foundation.org>, <isaacm@codeaurora.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <ning.li@mediatek.com>, <quic_c_gdjako@quicinc.com>,
        <robin.murphy@arm.com>, <sven@svenpeter.dev>, <will@kernel.org>,
        <wsd_upstream@mediatek.com>
Subject: Re: [PATCH v5 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow pgtable PA up to 35bit
Date:   Thu, 19 May 2022 14:27:56 +0800
Message-ID: <20220519062756.14447-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220516141608.11709-2-yf.wang@mediatek.com>
References: <20220516141608.11709-2-yf.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunfei,

> The calling to kmem_cache_alloc for level 2 pgtable allocation may run
> in atomic context, and it fails sometimes when DMA32 zone runs out of
> memory.
> 
> Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> so add a quirk to allow the PA of pgtables support up to bit35.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 56 ++++++++++++++++++++++--------
>  include/linux/io-pgtable.h         | 15 +++++---
>  2 files changed, 52 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c

...snip...

> +	gfp_t gfp_l1 = __GFP_ZERO | ARM_V7S_TABLE_GFP_DMA;
>  	struct io_pgtable_cfg *cfg = &data->iop.cfg;
>  	struct device *dev = cfg->iommu_dev;
>  	phys_addr_t phys;
> @@ -241,9 +251,11 @@ static void *__arm_v7s_alloc_table(int lvl, gfp_t gfp,
>  	size_t size = ARM_V7S_TABLE_SIZE(lvl, cfg);
>  	void *table = NULL;
>  
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		gfp_l1 = __GFP_ZERO;

__GFP_ZERO is an action modifier, if we do not want
ARM_V7S_TABLE_GFP_DMA (GFP_DMA/GFP_DMA32), use gfp_l1 = (GFP_KERNEL | __GFP_ZERO)

thanks,
Miles
> +
>  	if (lvl == 1)
> -		table = (void *)__get_free_pages(
> -			__GFP_ZERO | ARM_V7S_TABLE_GFP_DMA, get_order(size));
> +		table = (void *)__get_free_pages(gfp_l1, get_order(size));
>  	else if (lvl == 2)
>  		table = kmem_cache_zalloc(data->l2_tables, gfp);
>  
