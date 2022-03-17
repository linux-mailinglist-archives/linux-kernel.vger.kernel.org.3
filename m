Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8064DBC85
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 02:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiCQBfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 21:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbiCQBfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 21:35:42 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDA219F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 18:34:24 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 17 Mar
 2022 09:34:25 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 17 Mar
 2022 09:34:21 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     <mchehab@kernel.org>, <arnd@arndb.de>,
        <laurent.pinchart@ideasonboard.com>, <hverkuil-cisco@xs4all.nl>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>
Subject: [PATCH] media: pci: use swap() to make code cleaner
Date:   Thu, 17 Mar 2022 09:34:17 +0800
Message-ID: <1647480857-25469-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/media/pci/saa7134/saa7134-video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 374c8e1..3a0a9ab 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -823,7 +823,7 @@ static int buffer_activate(struct saa7134_dev *dev,
 {
 	struct saa7134_dmaqueue *dmaq = buf->vb2.vb2_buf.vb2_queue->drv_priv;
 	unsigned long base,control,bpl;
-	unsigned long bpl_uv,lines_uv,base2,base3,tmp; /* planar */
+	unsigned long bpl_uv,lines_uv,base2,base3; /* planar */
 
 	video_dbg("buffer_activate buf=%p\n", buf);
 	buf->top_seen = 0;
@@ -868,11 +868,8 @@ static int buffer_activate(struct saa7134_dev *dev,
 		lines_uv = dev->height >> dev->fmt->vshift;
 		base2    = base + bpl * dev->height;
 		base3    = base2 + bpl_uv * lines_uv;
-		if (dev->fmt->uvswap) {
-			tmp = base2;
-			base2 = base3;
-			base3 = tmp;
-		}
+		if (dev->fmt->uvswap)
+			swap(base2, base3);
 		video_dbg("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
 			bpl_uv,lines_uv,base2,base3);
 		if (V4L2_FIELD_HAS_BOTH(dev->field)) {
-- 
2.7.4

