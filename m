Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B923E50B085
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444387AbiDVG1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444373AbiDVG1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:27:40 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C69E506F8;
        Thu, 21 Apr 2022 23:24:47 -0700 (PDT)
X-UUID: a4a683bd9aa74ce3a19a7f8c23b5e5aa-20220422
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:68f808bf-3bef-4ea0-9bfb-0fdfdaef7935,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:34
X-CID-INFO: VERSION:1.1.4,REQID:68f808bf-3bef-4ea0-9bfb-0fdfdaef7935,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:54,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:34
X-CID-META: VersionHash:faefae9,CLOUDID:f82f94f0-da02-41b4-b6df-58f4ccd36682,C
        OID:ff4a062f609c,Recheck:0,SF:13|15|28|100|17|19|48|101,TC:nil,Content:1,E
        DM:-3,File:nil,QS:0,BEC:nil
X-UUID: a4a683bd9aa74ce3a19a7f8c23b5e5aa-20220422
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-pk.tsai@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2090162785; Fri, 22 Apr 2022 14:24:42 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 22 Apr 2022 14:24:41 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 22 Apr 2022 14:24:41 +0800
From:   Mark-PK Tsai <mark-pk.tsai@mediatek.com>
To:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <robin.murphy@arm.com>
CC:     <hch@lst.de>, <m.szyprowski@samsung.com>, <matthias.bgg@gmail.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <mark-pk.tsai@mediatek.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH 2/2] remoteproc: Fix dma_mem leak after rproc_shutdown
Date:   Fri, 22 Apr 2022 14:24:36 +0800
Message-ID: <20220422062436.14384-3-mark-pk.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
References: <20220422062436.14384-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Release dma coherent memory before rvdev is free in
rproc_rvdev_release().

Below is the kmemleak report:
unreferenced object 0xffffff8051c1a980 (size 128):
  comm "sh", pid 4895, jiffies 4295026604 (age 15481.896s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000003a0f3ec0>] dma_declare_coherent_memory+0x44/0x11c
    [<00000000ad243164>] rproc_add_virtio_dev+0xb8/0x20c
    [<00000000d219c8e9>] rproc_vdev_do_start+0x18/0x24
    [<00000000e694b468>] rproc_start+0x22c/0x3e0
    [<000000000b938941>] rproc_boot+0x4a4/0x860
    [<000000003c4dc532>] state_store.52856+0x10c/0x1b8
    [<00000000df2297ac>] dev_attr_store+0x34/0x84
    [<0000000083a53bdb>] sysfs_kf_write+0x60/0xbc
    [<000000008ed830df>] kernfs_fop_write+0x198/0x458
    [<0000000072b9ad06>] __vfs_write+0x50/0x210
    [<00000000377d7469>] vfs_write+0xe4/0x1a8
    [<00000000c3fc594e>] ksys_write+0x78/0x144
    [<000000009aef6f4b>] __arm64_sys_write+0x1c/0x28
    [<0000000003496a98>] el0_svc_common+0xc8/0x22c
    [<00000000ea3fe7a3>] el0_svc_compat_handler+0x1c/0x28
    [<00000000d1a85a4e>] el0_svc_compat+0x8/0x24

Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index c510125769b9..8e28290eefa9 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -461,6 +461,7 @@ static void rproc_rvdev_release(struct device *dev)
 	struct rproc_vdev *rvdev = container_of(dev, struct rproc_vdev, dev);
 
 	of_reserved_mem_device_release(dev);
+	dma_release_coherent_memory(dev);
 
 	kfree(rvdev);
 }
-- 
2.18.0

