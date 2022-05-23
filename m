Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7584B531380
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbiEWOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236939AbiEWORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:17:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B938359BA0;
        Mon, 23 May 2022 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653315443; x=1684851443;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JI0lcN9SHVIzgJehontYp/EcHZi0BmK64pGfGXgA72E=;
  b=Zj9miZlRKkO1Gr6cHEAKTFiWI0+4eIOsyjdcAgTnv6eHdOZHqYRyYS9F
   tNp2E2rLrEby161sVsFzPqvElXrDeOMg8dCmAN2hShwSqUrqRTRBQSy6c
   3/rPvoRYFx+KZ4s0wUrsGa6gO3vALgo7S5Pj8nXy3TZVkpWHgBFHS5mzx
   6GnSZ+wOSUXTAx+vH8Y1/+Wp9gTHkIYoB+ygy2mQKrFXMYFZomQpW0Ybq
   SKyE5o0j6upL4YDf5yxjupbYyFx226FtTZ/71EZNrec46g5aAXy7uqvSk
   jsaf90S8GvRW4y0mkZDFxa1DGmt2U4hjouEKSyoxKextTvIiAiz48J5NO
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="96932993"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 07:17:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 07:17:13 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 23 May 2022 07:17:12 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH] media: atmel: atmel-isc-base: move cropping settings outside start_dma
Date:   Mon, 23 May 2022 17:17:05 +0300
Message-ID: <20220523141705.98121-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cropping configuration of the Parallel Front Engine (PFE) can be done
just once when the streaming starts. The ISC configuration is in place and
will not be changed while streaming.
It is not effective to keep rewriting the crop registers configuration
everytime start_dma is called, as this can be called for each queued
buffer.
Thus we can configure the cropping at start_streaming time.
This change moves the code to a dedicated function.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 894c22081397..01a2e7f626d0 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -127,12 +127,9 @@ static int isc_buffer_prepare(struct vb2_buffer *vb)
 	return 0;
 }
 
-static void isc_start_dma(struct isc_device *isc)
+static void isc_crop_pfe(struct isc_device *isc)
 {
 	struct regmap *regmap = isc->regmap;
-	u32 sizeimage = isc->fmt.fmt.pix.sizeimage;
-	u32 dctrl_dview;
-	dma_addr_t addr0;
 	u32 h, w;
 
 	h = isc->fmt.fmt.pix.height;
@@ -167,6 +164,14 @@ static void isc_start_dma(struct isc_device *isc)
 	regmap_update_bits(regmap, ISC_PFE_CFG0,
 			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN,
 			   ISC_PFE_CFG0_COLEN | ISC_PFE_CFG0_ROWEN);
+}
+
+static void isc_start_dma(struct isc_device *isc)
+{
+	struct regmap *regmap = isc->regmap;
+	u32 sizeimage = isc->fmt.fmt.pix.sizeimage;
+	u32 dctrl_dview;
+	dma_addr_t addr0;
 
 	addr0 = vb2_dma_contig_plane_dma_addr(&isc->cur_frm->vb.vb2_buf, 0);
 	regmap_write(regmap, ISC_DAD0 + isc->offsets.dma, addr0);
@@ -371,6 +376,7 @@ static int isc_start_streaming(struct vb2_queue *vq, unsigned int count)
 					struct isc_buffer, list);
 	list_del(&isc->cur_frm->list);
 
+	isc_crop_pfe(isc);
 	isc_start_dma(isc);
 
 	spin_unlock_irqrestore(&isc->dma_queue_lock, flags);
-- 
2.25.1

