Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE2F554011
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 03:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354597AbiFVB3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 21:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbiFVB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 21:29:01 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE8C32ED9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 18:29:00 -0700 (PDT)
X-UUID: dafd4677dfb24b0a972f7a508371cfc2-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:b6e29bde-d88d-4d96-8ba2-de15ea8d5e73,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:15
X-CID-META: VersionHash:b14ad71,CLOUDID:a10fb02d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: dafd4677dfb24b0a972f7a508371cfc2-20220622
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 312043959; Wed, 22 Jun 2022 09:28:57 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Jun 2022 09:28:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 22 Jun 2022 09:28:55 +0800
Message-ID: <1ce1947984043bc4284abe94b53888c11a072345.camel@mediatek.com>
Subject: Re: [PATCH v10 1/2] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
From:   Yong Wu <yong.wu@mediatek.com>
To:     <yf.wang@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
CC:     <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        "Miles Chen" <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Sven Peter <sven@svenpeter.dev>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 22 Jun 2022 09:28:55 +0800
In-Reply-To: <20220616120713.12728-2-yf.wang@mediatek.com>
References: <20220616120713.12728-1-yf.wang@mediatek.com>
         <20220616120713.12728-2-yf.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 20:07 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Single memory zone feature will remove ZONE_DMA32 and ZONE_DMA and
> cause pgtable PA size larger than 32bit.
> 
> Since Mediatek IOMMU hardware support at most 35bit PA in pgtable,
> so add a quirk to allow the PA of pgtables support up to bit35.
> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 67 +++++++++++++++++++++++-----
> --
>  include/linux/io-pgtable.h         | 15 ++++---
>  2 files changed, 63 insertions(+), 19 deletions(-)

[...]

>  	/* TTBR */
> -	cfg->arm_v7s_cfg.ttbr = virt_to_phys(data->pgd) |
> ARM_V7S_TTBR_S |
> +	paddr = virt_to_phys(data->pgd);
> +	cfg->arm_v7s_cfg.ttbr = paddr | ARM_V7S_TTBR_S |
>  				(cfg->coherent_walk ? (ARM_V7S_TTBR_NOS
> |
>  				 ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_WBW
> A) |
>  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_WBW
> A)) :
>  				(ARM_V7S_TTBR_IRGN_ATTR(ARM_V7S_RGN_NC)
> |
>  				 ARM_V7S_TTBR_ORGN_ATTR(ARM_V7S_RGN_NC)
> ));
> +
> +	if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT)
> +		cfg->arm_v7s_cfg.ttbr = (paddr & GENMASK(31, 7)) |
> +					upper_32_bits(paddr);

If we keep ttbr u32, we have to put the special logic here. This line
is ok for all the MediaTek cases, not only for this quirk. It means:

    if (arm_v7s_is_mtk_enabled(cfg))
           cfg->arm_v7s_cfg.ttbr = (virt_to_phys(data->pgd) &
GENMASK(31, 7)) | upper_32_bits(paddr);
    else
           xxx
 
     Then we don't need add "& MMU_PT_ADDR_MASK" in mtk_iommu.c since
you have done it here.

> +
>  	return &data->iop;
>  

