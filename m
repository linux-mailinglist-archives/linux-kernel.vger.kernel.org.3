Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405984E1ED0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344030AbiCUBkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231352AbiCUBka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:40:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D666110A5;
        Sun, 20 Mar 2022 18:39:01 -0700 (PDT)
X-UUID: 9774075e367b47f4875db3038c7d7046-20220321
X-UUID: 9774075e367b47f4875db3038c7d7046-20220321
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <irui.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 400680502; Mon, 21 Mar 2022 09:38:55 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 21 Mar 2022 09:38:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Mar
 2022 09:38:52 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 09:38:51 +0800
Message-ID: <9fe3230c05f12623e951f5c1f9c741222f326c64.camel@mediatek.com>
Subject: Re: [PATCH v3, 00/10] Enable two H264 encoder core on MT8195
From:   Irui Wang <irui.wang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>
CC:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Mon, 21 Mar 2022 09:38:49 +0800
In-Reply-To: <aae7c675-6be4-03f1-a8fb-121faae320c2@collabora.com>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
         <aae7c675-6be4-03f1-a8fb-121faae320c2@collabora.com>
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

Dear Angelo,

Thanks for your comments.
On Fri, 2022-03-18 at 15:04 +0100, AngeloGioacchino Del Regno wrote:
> Il 17/03/22 09:22, Irui Wang ha scritto:
> > MT8195 has two H264 encoder cores, they have their own power-
> > domains,
> > clocks, interrupts, register base. The two H264 encoder cores can
> > work
> > together to achieve higher performance, it's a core mode called
> > frame-racing, one core has 4K@30fps performance, two cores can
> > achieve
> > 4K@60fps.
> > The two encoder core encoding process looks like this:
> > 
> >      VENC Core0: frm#0....frm#2....frm#4....
> >      VENC Core1: ..frm#1....frm#3....frm#5....
> > 
> > This series of patches are used to enable the two H264 encoder
> > cores,
> > encoding process will be changed:
> > As-Is: Synchronous
> > V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> wait encoder
> > IRQ -->
> > encoding done with result --> job_finish
> > V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> wait encoder
> > IRQ -->
> > encoding done with result --> job_finish
> > ...
> > 
> > To-Be: Asynchronous
> > V4L2_VIDIOC_QBUF#0 --> device_run(triger encoder) --> job_finish
> > ..V4l2_VIDIOC_QBUF#1 --> device_run(triger encoder) --> job_finish
> > (venc core0 may encode done here, done the encoding result to
> > client)
> > V4L2_VIDIOC_QBUF#2 --> device_run(triger encoder) --> job_finish.
> > 
> > There is no "wait encoder IRQ" synchronous call during frame-racing 
> > mode
> > encoding process, it can full use the two encoder cores to achieve
> > higher
> > performance.
> > 
> 
> Hello Irui,
> like v1 and v2, also this version of the series will crash the kernel
> when
> trying to encode.

As mentioned before, dual core encoding need more encoding working
buffers in patch-8:
media: mtk-vcodec: Add more extra processing for venc_multi_core mode
a new structure, struct venc_multi_core_vsi defined for it,

encoding processing like this: 
kernel --> ipi message --> scp firmware(userspace), vsi is a share
memory to transfer data between kernel and user, so, the definition of
vsi must be the same in kernel and userspace. otherwise, errors will be
occurred, for example, kernel crash.

When we enable dual core encoding in this patch, the
venc_multi_core_vsi used in kernel, but scp(userspace) still use the
older one vsi(struct venc_h264_vsi), the crash happened.

Maybe we would find out how to resolve the limitations, many thanks for
your review.
> 
> Before pushing the next series, you shall ensure that it is not
> crashing
> the entire kernel, hence, please test your code with gstreamer.
> 
> 
> Please use the following pipeline to test:
> 
> gst-launch-1.0 videotestsrc num-buffers=100 ! v4l2h264enc ! queue !
> h264parse ! 
> qtmux ! filesink location=test.mov
> 
> 
> Regards,
> Angelo

Thanks
Best Regards

