Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEB4B5570C1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378121AbiFWB7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378070AbiFWB6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:58:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18448334
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:55:10 -0700 (PDT)
X-UUID: 5997c256dc0d48849e0a4781ec098522-20220623
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:88c7e930-efc3-41f6-98bf-236f94738288,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:5332cc2d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 5997c256dc0d48849e0a4781ec098522-20220623
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1236942881; Thu, 23 Jun 2022 09:54:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 23 Jun 2022 09:54:45 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Thu, 23 Jun 2022 09:54:44 +0800
Message-ID: <a53c4a4d9922c9a3fc774976494dea6da1bd8daa.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Add error path for loop of
 mm_dts_parse
From:   Yong Wu <yong.wu@mediatek.com>
To:     Robin Murphy <robin.murphy@arm.com>
CC:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        <mingyuan.ma@mediatek.com>, <yf.wang@mediatek.com>,
        <libo.kang@mediatek.com>, <chengci.xu@mediatek.com>,
        <youlin.pei@mediatek.com>, <anan.sun@mediatek.com>,
        <xueqi.zhang@mediatek.com>, Guenter Roeck <groeck@chromium.org>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Date:   Thu, 23 Jun 2022 09:54:44 +0800
In-Reply-To: <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
References: <20220616054203.11365-1-yong.wu@mediatek.com>
         <20220616054203.11365-3-yong.wu@mediatek.com>
         <e2091397-b6e2-7296-1378-dc10b24c6ef4@arm.com>
         <b2ea919315d0084adb465378e6970dbfa4f0829e.camel@mediatek.com>
         <521ed82e-f213-f635-6f5e-3e35ff8cc020@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-16 at 11:31 +0100, Robin Murphy wrote:
> On 2022-06-16 11:08, Yong Wu wrote:
> > On Thu, 2022-06-16 at 09:59 +0100, Robin Murphy wrote:
> > > On 2022-06-16 06:42, Yong Wu wrote:
> > > > The mtk_iommu_mm_dts_parse will parse the smi larbs nodes. if
> > > > the
> > > > i+1
> > > > larb is parsed fail(return -EINVAL), we should of_node_put for
> > > > the
> > > > 0..i
> > > > larbs. In the fail path, one of_node_put matches with
> > > > of_parse_phandle in
> > > > it.
> > > > 
> > > > Fixes: d2e9a1102cfc ("iommu/mediatek: Contain MM IOMMU flow
> > > > with
> > > > the MM TYPE")
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > ---
> > > >    drivers/iommu/mtk_iommu.c | 21 ++++++++++++++++-----
> > > >    1 file changed, 16 insertions(+), 5 deletions(-)

[snip..]

> > > > +err_larbnode_put:
> > > > +	while (i--) {
> > > > +		larbnode = of_parse_phandle(dev->of_node,
> > > > "mediatek,larbs", i);
> > > > +		if (larbnode &&
> > > > of_device_is_available(larbnode)) {
> > > > +			of_node_put(larbnode);
> > > > +			of_node_put(larbnode);
> > > > +		}
> > > 
> > > This looks a bit awkward - could we not just iterate through
> > > data->larb_imu and put dev->of_node for each valid dev?
> > 
> > It should work. Thanks very much.
> > 
> > > 
> > > Also, of_find_device_by_node() takes a reference on the struct
> > > device
> > > itself, so strictly we should be doing put_device() on those as
> > > well
> > > if we're bailing out.
> > 
> > Thanks for this hint. A new reference for me. I will add it.
> 
> In fact, thinking about it some more we may as well do the
> of_node_put() 
> unconditionally immediately after the of_find_device_by_node() call, 

of_node_put is called in component_release_of in the normal case, thus
we shouldn't call of_node_put unconditionally. Right?

(Sorry for reply late)

> so 
> then it's *only* the device references we'd need to worry about
> cleaning 
> up in the failure path.
> 
> Robin.

