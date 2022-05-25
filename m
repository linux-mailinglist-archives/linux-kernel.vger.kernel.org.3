Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC30533688
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 07:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244041AbiEYFnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 01:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEYFne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 01:43:34 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3484160A9A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 22:43:26 -0700 (PDT)
X-UUID: a469481094374202937f5807fca7138d-20220525
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:67c377b9-f005-46ce-a6a0-97813ced0dbe,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:56
X-CID-INFO: VERSION:1.1.5,REQID:67c377b9-f005-46ce-a6a0-97813ced0dbe,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:56
X-CID-META: VersionHash:2a19b09,CLOUDID:f5cf24b8-3c45-407b-8f66-25095432a27a,C
        OID:31c0f6e3944e,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: a469481094374202937f5807fca7138d-20220525
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1084376180; Wed, 25 May 2022 13:43:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 25 May 2022 13:43:20 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 25 May 2022 13:43:19 +0800
From:   <yf.wang@mediatek.com>
To:     <yong.wu@mediatek.com>
CC:     <Libo.Kang@mediatek.com>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <ning.li@mediatek.com>, <robin.murphy@arm.com>, <will@kernel.org>,
        <wsd_upstream@mediatek.com>, <yf.wang@mediatek.com>
Subject: Re: [PATCH v5 2/2] iommu/mediatek: Allow page table PA up to 35bit
Date:   Wed, 25 May 2022 13:36:42 +0800
Message-ID: <20220525053642.29653-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
References: <1625ec1f4cded0f825d93743d3d03fcf83cad5aa.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
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

There is no DMA32 zone in some mediatek smartphone chip for single normal zone.

The level 1 and level 2 pgtable are both allocated in ZONE_DMA32, and may have two possible problem:
1.The level 2 pgtable is allocated in ZONE_DMA32 with atomic flag, and it may fail if ZONE_DMA32 memory is used out.
2.Single memory feature will make ZONE_DMA32 empty, and cause level 1 and level 2 pgtable PA more than 32bit.

Solution:
Add the quirk IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT support, so that level 1 and level 2 pgtable can support at most 35bit PA.

I will update the commit message in next version.

Thanks,
Yunfei.
