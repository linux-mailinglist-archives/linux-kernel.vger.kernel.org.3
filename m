Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41B54B829E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 09:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbiBPIMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:12:07 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiBPIMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:12:06 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B3FD30;
        Wed, 16 Feb 2022 00:11:50 -0800 (PST)
X-UUID: a6b76a8b6fc2411d975007c926b4c662-20220216
X-UUID: a6b76a8b6fc2411d975007c926b4c662-20220216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 328284359; Wed, 16 Feb 2022 16:11:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 16 Feb 2022 16:11:43 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Feb 2022 16:11:42 +0800
Message-ID: <75a08f8d97e112f6c584f7b62934aa178eca8bc4.camel@mediatek.com>
Subject: Re: [PATCH v4 08/35] iommu/mediatek: Use kmalloc for protect buffer
From:   Yong Wu <yong.wu@mediatek.com>
To:     Tomasz Figa <tfiga@chromium.org>
CC:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>, <youlin.pei@mediatek.com>,
        <anan.sun@mediatek.com>, <xueqi.zhang@mediatek.com>,
        <yen-chang.chen@mediatek.com>, <mingyuan.ma@mediatek.com>,
        <yf.wang@mediatek.com>, <libo.kang@mediatek.com>,
        <chengci.xu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Will Deacon" <will@kernel.org>
Date:   Wed, 16 Feb 2022 16:11:42 +0800
In-Reply-To: <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
         <20220125085634.17972-9-yong.wu@mediatek.com>
         <ca47becf-adc9-f11e-5e59-03f203920344@collabora.com>
         <d9637b40196873f392ac9cebfe369106a6f0eee7.camel@mediatek.com>
         <CAAFQd5Cqg2xPwtzcom_EZ1tw1tOBsND_i1YAQCO4kF=+eWePBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-02-16 at 14:59 +0900, Tomasz Figa wrote:
> On Wed, Feb 16, 2022 at 2:55 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > 
> > On Thu, 2022-01-27 at 12:08 +0100, AngeloGioacchino Del Regno
> > wrote:
> > > Il 25/01/22 09:56, Yong Wu ha scritto:
> > > > No need zero for the protect buffer that is only accessed by
> > > > the
> > > > IOMMU HW
> > > > translation fault happened.
> > > > 
> > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > 
> > > I would rather keep this a devm_kzalloc instead... the cost is
> > > very
> > > minimal and
> > > this will be handy when new hardware will be introduced, as it
> > > may
> > > require a bigger
> > > buffer: in that case, "older" platforms will use only part of it
> > > and
> > > we may get
> > > garbage data at the end.
> > 
> > Currently this is to avoid zero 512 bytes for all the platforms.
> > 
> > Sorry, I don't understand why it is unnecessary when the new
> > hardware
> > requires a bigger buffer. If the buffer becomes bigger, then
> > clearing
> > it to 0 need more cost. then this patch is more helpful?
> > 
> > The content in this buffer is garbage, we won't care about or
> > analyse
> > it.
> 
> I think we should zero it for security reasons regardless of any
> other
> aspects. With this patch it's leaking kernel data to the hardware.
> 
> At the same time, we're talking here about something executed just 1
> time when the driver probes. I don't think the cost would really
> matter.

OK. I will remove this patch in next version.

Thanks.

> 
> Best regards,
> Tomasz
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek

