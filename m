Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9901A4BA221
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241489AbiBQN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:57:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241461AbiBQN5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:57:52 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AE17BCFE;
        Thu, 17 Feb 2022 05:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106258; x=1676642258;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZaYSKtA1O7qxouP3wb+9mrJGwNtoT++RyRl6T1YABRU=;
  b=XC+R6ZDLToFpJmSkaVeiKLUF+MaGiYPzkSmGrneNzbF2HxfkqOSw1rfs
   CpgM9m95mkzxVo37KPzdAHhyhb+Tc/qU6rr3ZSqQoqPVNtXEM9qmwv+A6
   6t2/ODOUtt4J23jMHsyPeNCL2DrYWpL4SU1LfiMkt4Hz78LJFGhpamIHi
   iSxkSLiGKvHbPHmsk2JsVoXsiAvL8xJjjfeaHjRtO+peabpQNhNmNt7Ba
   n7v4agtlwa1F4VaDlPmpRTN+t0QBlBiFulf4QOxxDU4UHfpBPsXxYa/IR
   uBdEBFzbETNx/SXdmSiyMFREy9GcAisClKHbF2L2BJ3DPYc9g/wMVornb
   w==;
IronPort-SDR: AoTl3KjTNUNer6KXMevhQNk8QL7VpRuMBPgjxmvwanWZWUwkxK0qJn+MzuOm2N3hEvux986l/N
 mYHuhMacrdQ9jxMB9t2Vmzcr9zaVgDlvwV0zWEyGRNpGkuDb5aAf/c6uJbd4zHf55wihv34rrL
 FBtKVb0tdG/agbZ9y9iMZSLx7lXmRBXPEMDVkkRVMtyGhDJXLe6k3e+JvISgGOaBVEhzYmFiVW
 BEB73XndZqb/uy7d+4ypppbYLuSNaWe30us0JKf8IuxesvlFzLinil0dIGHaTrgOyIQ37I82Nh
 GdZ4nFv00Qyz/wOtiyDsrJ5a
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="153432049"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 06:57:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 06:57:36 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 06:57:24 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 01/13] media: atmel: atmel-isc-base: use streaming status when queueing buffers
Date:   Thu, 17 Feb 2022 15:56:33 +0200
Message-ID: <20220217135645.1427466-2-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

