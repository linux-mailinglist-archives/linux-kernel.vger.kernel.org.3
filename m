Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C77E54C1EE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353599AbiFOGcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiFOGcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:32:43 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4FD19028
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:32:40 -0700 (PDT)
X-UUID: dcbc5ea542084fe7a5cea6244c90db68-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:3b517620-0903-442b-9e0b-b63c47245006,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:45
X-CID-INFO: VERSION:1.1.6,REQID:3b517620-0903-442b-9e0b-b63c47245006,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,RULE:Release_Ham,ACTIO
        N:release,TS:45
X-CID-META: VersionHash:b14ad71,CLOUDID:2c498c48-4c92-421c-ad91-b806c0f58b2a,C
        OID:f536385ec483,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: dcbc5ea542084fe7a5cea6244c90db68-20220615
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 720961827; Wed, 15 Jun 2022 14:32:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 14:32:36 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 14:32:31 +0800
Message-ID: <9ef61bb49dec1526b807f6dc7a36297a2cebab88.camel@mediatek.com>
Subject: Re: [PATCH v8 1/3] iommu/io-pgtable-arm-v7s: Add a quirk to allow
 pgtable PA up to 35bit
From:   Yong Wu <yong.wu@mediatek.com>
To:     Will Deacon <will@kernel.org>, <yf.wang@mediatek.com>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        "Sven Peter" <sven@svenpeter.dev>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Libo Kang <Libo.Kang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Date:   Wed, 15 Jun 2022 14:32:31 +0800
In-Reply-To: <20220614125630.GA8159@willie-the-truck>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
         <20220611102656.10954-2-yf.wang@mediatek.com>
         <20220614125630.GA8159@willie-the-truck>
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

On Tue, 2022-06-14 at 13:56 +0100, Will Deacon wrote:
> > @@ -74,17 +74,22 @@ struct io_pgtable_cfg {
> >  	 *	to support up to 35 bits PA where the bit32, bit33 and
> > bit34 are
> >  	 *	encoded in the bit9, bit4 and bit5 of the PTE respectively.
> >  	 *
> > +	 * IO_PGTABLE_QUIRK_ARM_MTK_TTBR_EXT: (ARM v7s format) MediaTek
> > IOMMUs
> > +	 *	extend the translation table base support up to 35 bits PA,
> > the
> > +	 *	encoding format is same with IO_PGTABLE_QUIRK_ARM_MTK_EXT.
> > +	 *
> 
> One thing I don't get is how the existing driver handles this. It
> seems
> as though if the HAS_4GB_MODE flag is not set, then we set oas to 35
> but
> without any pgtable changes. How does this work?

Regarding the pgtable, we already use the quirk
IO_PGTABLE_QUIRK_ARM_MTK_EXT to support 35bits oas.

HAS_4GB_MODE is the flag for the previous SoC that only supports 33bits
oas, it also is covered by IO_PGTABLE_QUIRK_ARM_MTK_EXT. and in 4GB
mode we add PA32 manually in mtk_iommu_map.

> 
> If it turns out that the existing devices can't handle 35-bit PAs,
> then
> could we use an oas of 35 to indicate that this new format is in use
> instead of introducing another quirk?

The existed devices can handle 35bits oas. The problem is that if
the pgtable PA could support up to 35bits. The previous SoC like mt8173
can't support while the lastest SoC can. This is the purpose of this
new quick. therefore we need GFP_DMA/DMA32 for pgtable allocating in
mt8173 and GFP_DMA/DMA32 is not needed in the new quirk.

> 
> Will

