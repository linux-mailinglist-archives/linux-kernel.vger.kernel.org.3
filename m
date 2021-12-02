Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BBE465CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhLBDje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:39:34 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:52306 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1355206AbhLBDjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:39:20 -0500
X-UUID: 35066ef134af4aa2affe830ba67adfab-20211202
X-UUID: 35066ef134af4aa2affe830ba67adfab-20211202
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1064289280; Thu, 02 Dec 2021 11:35:53 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 2 Dec 2021 11:35:52 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 2 Dec
 2021 11:35:51 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Dec 2021 11:35:51 +0800
Message-ID: <0d3f33e26b67cabc82246c49c0e952194a9a88c1.camel@mediatek.com>
Subject: Re: [PATCH v9 7/7] media: platform: mtk-mdp3: add Mediatek MDP3
 driver
From:   moudy ho <moudy.ho@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
CC:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        <tfiga@chromium.org>, <drinkcat@chromium.org>,
        <pihsun@chromium.org>, <hsinyi@google.com>,
        "Maoguang Meng" <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        <menghui.lin@mediatek.com>, <sj.huang@mediatek.com>,
        <allen-kh.cheng@mediatek.com>, <randy.wu@mediatek.com>,
        <jason-jh.lin@mediatek.com>, <roy-cw.yeh@mediatek.com>,
        <river.cheng@mediatek.com>, <srv_heupstream@mediatek.com>
Date:   Thu, 2 Dec 2021 11:35:51 +0800
In-Reply-To: <103b1664-d04c-c1fc-ff4c-e2c92ce45ee8@collabora.com>
References: <20211201095031.31606-1-moudy.ho@mediatek.com>
         <20211201095031.31606-8-moudy.ho@mediatek.com>
         <103b1664-d04c-c1fc-ff4c-e2c92ce45ee8@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-12-01 at 11:37 +0100, AngeloGioacchino Del Regno wrote:
> Il 01/12/21 10:50, Moudy Ho ha scritto:
> > This patch adds driver for Mediatek's Media Data Path ver.3 (MDP3).
> > It provides the following functions:
> >    color transform, format conversion, resize, crop, rotate, flip
> >    and additional image quality enhancement.
> > 
> > The MDP3 driver is mainly used for Google Chromebook products to
> > import the new architecture to set the HW settings as shown below:
> >    User -> V4L2 framework
> >      -> MDP3 driver -> SCP (setting calculations)
> >        -> MDP3 driver -> CMDQ (GCE driver) -> HW
> > 
> > Each modules' related operation control is sited in mtk-mdp3-comp.c
> > Each modules' register table is defined in file with "mdp_reg_"
> > prefix
> > GCE related API, operation control  sited in mtk-mdp3-cmdq.c
> > V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
> > Probe, power, suspend/resume, system level functions are defined in
> > mtk-mdp3-core.c
> > 
> > Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
> > Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
> > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> > ---
> >   drivers/media/platform/Kconfig                |   19 +
> >   drivers/media/platform/Makefile               |    2 +
> >   drivers/media/platform/mtk-mdp3/Makefile      |    6 +
> >   .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   19 +
> >   drivers/media/platform/mtk-mdp3/mdp_reg_isp.h |   27 +
> >   .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   65 +
> >   drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |   39 +
> >   .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |   47 +
> >   .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   55 +
> >   drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  280 ++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  514 +++++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   46 +
> >   .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1264
> > +++++++++++++++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  147 ++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  338 +++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   76 +
> >   .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  789 ++++++++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   49 +
> >   .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  737 ++++++++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  372 +++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  312 ++++
> >   .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   78 +
> >   22 files changed, 5281 insertions(+)
> >   create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
> >   create mode 100644 drivers/media/platform/mtk-
> > mdp3/mdp_reg_ccorr.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > cmdq.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > cmdq.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > comp.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > comp.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > core.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > core.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > regs.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
> > regs.h
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
> >   create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
> > 
> 
> snip...
> 
> > diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> > b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> > new file mode 100644
> > index 000000000000..a643f3ee928b
> > --- /dev/null
> > +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
> > @@ -0,0 +1,514 @@
> 
> Looks like you forgot to check my review comments to this entire
> file.
> Can you please send a new version after applying the changes to this
> file
> suggested in my review of series v8?
Hi Angelo,

Thanks for the reminder and sorry for my carelessness. Considering the
compatibility of subsequent chips and function independence, I plan to
move those mutex mod definition to the corresponding driver, and
release next version ASAP.

Thanks & Regards,
Moudy Ho
> Thanks.

