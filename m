Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C652490552
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbiAQJlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 04:41:46 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39042 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238561AbiAQJlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 04:41:25 -0500
X-UUID: dd2a1725b31d4dfe9851067031719254-20220117
X-UUID: dd2a1725b31d4dfe9851067031719254-20220117
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 476358148; Mon, 17 Jan 2022 17:41:22 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 17 Jan 2022 17:41:20 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 17 Jan 2022 17:41:19 +0800
Message-ID: <ebbe29162688b230aec208a45762f795c850e396.camel@mediatek.com>
Subject: Re: [PATCH v9 12/15] media: mtk-vcodec: enc: Remove
 mtk_vcodec_release_enc_pm
From:   Yong Wu <yong.wu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Dafna Hirschfeld" <dafna.hirschfeld@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        <dri-devel@lists.freedesktop.org>, <yf.wang@mediatek.com>,
        <anthony.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        Irui Wang <irui.wang@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>, <mingyuan.ma@mediatek.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <libo.kang@mediatek.com>, <yi.kuo@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        <anan.sun@mediatek.com>, <srv_heupstream@mediatek.com>,
        <acourbot@chromium.org>, <linux-kernel@vger.kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        <iommu@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Robin Murphy" <robin.murphy@arm.com>
Date:   Mon, 17 Jan 2022 17:41:18 +0800
In-Reply-To: <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
References: <20211112105509.12010-1-yong.wu@mediatek.com>
         <20211112105509.12010-13-yong.wu@mediatek.com>
         <68c3a573-8453-38e9-93b2-2067bedcd06f@collabora.com>
         <4bd9e849-96dd-6f1c-2841-979459366ee5@collabora.com>
         <fa9b2b73-c6bb-5737-93ac-ba2ab6b3b771@xs4all.nl>
         <e940d705-2057-4d5e-0a21-8464ca04caaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-13 at 17:10 +0100, Matthias Brugger wrote:
> Hi Hans,
> 
> On 13/01/2022 11:15, Hans Verkuil wrote:
> > On 13/01/2022 11:11, AngeloGioacchino Del Regno wrote:
> > > Il 11/01/22 11:57, AngeloGioacchino Del Regno ha scritto:
> > > > Il 12/11/21 11:55, Yong Wu ha scritto:
> > > > > After this patchset, mtk_vcodec_release_enc_pm has only one
> > > > > line.
> > > > > then remove that function, use pm_runtime_disable instead.
> > > > > 
> > > > > meanwhile, mtk_vcodec_init_enc_pm only operate for the
> > > > > clocks,
> > > > > rename it from the _pm to _clk.
> > > > > 
> > > > > No functional change.
> > > > > 
> > > > > CC: Tiffany Lin <tiffany.lin@mediatek.com>
> > > > > CC: Irui Wang <irui.wang@mediatek.com>
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > 
> > > > Reviewed-by: AngeloGioacchino Del Regno <
> > > > angelogioacchino.delregno@collabora.com>
> > > > 
> > > 
> > > Hello Yong,
> > > the mtk-vcodec patches were merged in Yunfei's vcodec patch
> > > series and Hans has
> > > scheduled that for v5.18.
> > > 
> > > Can you please send a v10 and drop patches 10/15, 11/15, 12/15
> > > (all of the
> > > media: mtk-vcodec: *) from this series?

Hi Angelo,

   I have dropped 11/15 and 12/15 in v10 and rebase 10/15 on media tree
manually, thus I didn't keep your A-y for that one.

   Please take a look at that one.
 
   Thanks.

> > > 
> > > For the records, I think that after sending v10 this series is
> > > ready to be merged,
> > > as it was well reviewed and also tested on many MTK platforms.
> > 
> > Good to know. When I have the v10 I'll try to prioritize reviewing
> > it and running
> > my usual tests.

Hi Hans/Matthias,

v10: 
https://patchwork.linuxtv.org/project/linux-media/list/?series=7130

Please help take a look that one.

> > 
> > Yong, please make sure you run 'checkpatch.pl --strict' over the
> > v10 patches and fix
> > any issues (using common sense).

   Have run this on v10.

Thanks.
> > 
> 
> Can you please take me in the look when you take the patches. I'll
> take the DTS 
> related as soon as you queue up the others.
> 
> Thanks!
> Matthias
> 
> > Regards,
> > 
> > 	Hans
> > 
> > > 
> > > Thank you,
> > > - Angelo

