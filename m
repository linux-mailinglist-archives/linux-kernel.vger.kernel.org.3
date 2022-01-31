Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF6B4A463C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 12:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376685AbiAaLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 06:51:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:53120 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380347AbiAaLpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 06:45:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20VBjBt6033104;
        Mon, 31 Jan 2022 05:45:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643629511;
        bh=0lGG21FbBmtcnqY5LOZGFiDh425t7aE/LEQNN+eDmA0=;
        h=From:To:CC:Subject:Date;
        b=v2G1sbiv4K9KpR69BQ4AreddokOiMb4Z8WZvd3gwPxr3D9Gz/34DQcJ2cEoRqEsFE
         sQB/lOyfstfvdVQX/Q1gGfCwNTZmJfd2N8irxJHUlQqxnWdFzevr084hFHAi7N1KUS
         5xKSWRjzKKyhtHj+LCbGZeMPzuC7gFK4Y5xc3X8A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20VBjB7g065494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 05:45:11 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 31
 Jan 2022 05:45:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 31 Jan 2022 05:45:11 -0600
Received: from pratyush-4F-325.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20VBj8FN008117;
        Mon, 31 Jan 2022 05:45:09 -0600
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] spi: spi-mem: check if data buffers are on stack
Date:   Mon, 31 Jan 2022 17:15:08 +0530
Message-ID: <20220131114508.1028306-1-p.yadav@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffers passed in the data phase must be DMA-able. Programmers often
don't realise this requirement and pass in buffers that reside on the
stack. This can be hard to spot when reviewing code. Reject ops if their
data buffer is on the stack to avoid this.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/spi/spi-mem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 37f4443ce9a0..b3793a2979ee 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -207,6 +207,15 @@ static int spi_mem_check_op(const struct spi_mem_op *op)
 	    !spi_mem_buswidth_is_valid(op->data.buswidth))
 		return -EINVAL;
 
+	/* Buffers must be DMA-able. */
+	if (op->data.dir == SPI_MEM_DATA_IN &&
+	    object_is_on_stack(op->data.buf.in))
+		return -EINVAL;
+
+	if (op->data.dir == SPI_MEM_DATA_OUT &&
+	    object_is_on_stack(op->data.buf.out))
+		return -EINVAL;
+
 	return 0;
 }
 
-- 
2.34.1

