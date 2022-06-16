Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5B654DAB4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359202AbiFPGbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233903AbiFPGbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:31:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2E05677B;
        Wed, 15 Jun 2022 23:31:09 -0700 (PDT)
X-UUID: e2f21dbf73474e5f9da3f5ed59914ac8-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:88c4ec7a-a239-46ba-bf62-aefc6af4ef11,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:9b7d71f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: e2f21dbf73474e5f9da3f5ed59914ac8-20220616
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1300391025; Thu, 16 Jun 2022 14:31:03 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 14:31:02 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 16 Jun 2022 14:31:00 +0800
Message-ID: <2d0f49294a8bac34dd5dd1ce4201f009a207b7a7.camel@mediatek.com>
Subject: Re: [PATCH v3 6/6] iommu: mtk_iommu: Lookup phandle to retrieve
 syscon to pericfg
From:   Yong Wu <yong.wu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski@linaro.org>
Date:   Thu, 16 Jun 2022 14:30:57 +0800
In-Reply-To: <80c7fa61-e25a-fc45-bdcb-60ac3796b96e@collabora.com>
References: <20220609100802.54513-1-angelogioacchino.delregno@collabora.com>
         <20220609100802.54513-7-angelogioacchino.delregno@collabora.com>
         <db422fe4d0b5391ee2aacae989d7e48209e1095f.camel@mediatek.com>
         <80c7fa61-e25a-fc45-bdcb-60ac3796b96e@collabora.com>
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

On Mon, 2022-06-13 at 10:13 +0200, AngeloGioacchino Del Regno wrote:
> Il 13/06/22 07:32, Yong Wu ha scritto:
> > On Thu, 2022-06-09 at 12:08 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > On some SoCs (of which only MT8195 is supported at the time of
> > > writing),
> > > the "R" and "W" (I/O) enable bits for the IOMMUs are in the
> > > pericfg_ao
> > > register space and not in the IOMMU space: as it happened already
> > > with
> > > infracfg, it is expected that this list will grow.
> > 
> > Currently I don't see the list will grow. As commented before, In
> > the
> > lastest SoC, The IOMMU enable bits for IOMMU will be in ATF, rather
> > than in this pericfg register region. In this case, Is this patch
> > unnecessary? or we could add this patch when there are 2 SoCs use
> > this
> > setting at least?  what's your opinion?
> > 
> 
> Perhaps I've misunderstood... besides, can you please check if
> there's any
> other SoC (not just chromebooks, also smartphone SoCs) that need this
> logic?

As far as I know, SmartPhone SoCs don't enable the infra iommu until
now. they don't have this logic. I don't object this patch, I think we
could add it when at least 2 SoCs need this.

Thanks very much for help improving here.

> 
> Thanks,
> Angelo
> 
> 

