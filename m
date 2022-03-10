Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE36A4D43D6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiCJJxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240962AbiCJJx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:53:28 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0111113C262;
        Thu, 10 Mar 2022 01:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646905943; x=1678441943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8pGmp/P6DW09QNCZnxhFBr88c90cP0y+5hBJacUv2zo=;
  b=Upcrjkn32XPm8iMmfxXIDuz81hNCk3k6YsgFudeqPZzT4Lg7vFZmIJe2
   9iDE1QlLAxDS9ivwfxWlKj2nsd4dV/ZspEIxNuiK9+1a9begPH70Neu8K
   ZHNeWAOC5KE9UDfWiWpW3ocU97XIchxp1YFspM9maAWb1wnghAmvI2sMB
   U8qgXLy5DM/W0plxEoqV9Tm0bx99e3KFex+JbGKLq7vUhoc5kokVmowK5
   acI9Bsx48Sq0ICnPdMSUb9Oq/xWrPhRGeqC8pK+Iw8w7BmRsFLWXxuZLi
   Zb1ADhikyu/BMiY/4qinArivcN13Xa7Gj+yTHsBHGH7vag1+RSmNLHcbS
   g==;
X-IronPort-AV: E=Sophos;i="5.90,170,1643698800"; 
   d="scan'208";a="151541402"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 02:52:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 02:52:21 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 10 Mar 2022 02:52:15 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v9 01/13] media: atmel: atmel-isc-base: use streaming status when queueing buffers
Date:   Thu, 10 Mar 2022 11:51:50 +0200
Message-ID: <20220310095202.2701399-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220310095202.2701399-1-eugen.hristev@microchip.com>
References: <20220310095202.2701399-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During experiments with libcamera, it looks like vb2_is_streaming returns
true before our start streaming is called.
Order of operations is streamon -> queue -> start_streaming
ISC would have started the DMA immediately when a buffer is being added
to the vbqueue if the queue is streaming.
It is more safe to start the DMA after the start streaming of the driver is
called.
Thus, even if vb2queue is streaming, add the buffer to the dma queue of the
driver instead of actually starting the DMA process, if the start streaming
has not been called yet.
Tho achieve this, we have to use vb2_start_streaming_called instead of
vb2_is_streaming.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Reviewed-by: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index db15770d5b88..d2cc6c99984f 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -442,7 +442,7 @@ static void isc_buffer_queue(struct vb2_buffer *vb)
 
 	spin_lock_irqsave(&isc->dma_queue_lock, flags);
 	if (!isc->cur_frm && list_empty(&isc->dma_queue) &&
-		vb2_is_streaming(vb->vb2_queue)) {
+		vb2_start_streaming_called(vb->vb2_queue)) {
 		isc->cur_frm = buf;
 		isc_start_dma(isc);
 	} else
-- 
2.25.1

