Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF3757E4B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbiGVQtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235870AbiGVQtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:49:04 -0400
Received: from out28-173.mail.aliyun.com (out28-173.mail.aliyun.com [115.124.28.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACAF93638;
        Fri, 22 Jul 2022 09:48:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07772149|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00248871-9.81933e-05-0.997413;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047204;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Ob0cnJp_1658508527;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Ob0cnJp_1658508527)
          by smtp.aliyun-inc.com;
          Sat, 23 Jul 2022 00:48:49 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: [PATCH 1/3] mtd: spi-nor: Use the spi-mem poll status APIs.
Date:   Sat, 23 Jul 2022 00:48:28 +0800
Message-Id: <1658508510-15400-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With advanced controllers (such as Ingenic SFC), it is possible to poll
the status register of the device. This could be done to offload the CPU
during a erase or write operation. Make use of spi-mem poll status APIs
to handle this feature.

Previously, when erasing large area (e.g. 32MiB), in non-offload case,
CPU load could reach ~90% and would generate ~3.92 million interrupts,
now it decrease to ~15% CPU load and 0.15 million interrupts.

This should also fix the high CPU usage for system which don't have a
dedicated poll status block logic (decrease to ~80% CPU load and ~1.61
million interrupts.).

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 drivers/mtd/spi-nor/core.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 502967c..6a31132 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -617,19 +617,41 @@ static int spi_nor_wait_till_ready_with_timeout(struct spi_nor *nor,
 	unsigned long deadline;
 	int timeout = 0, ret;
 
-	deadline = jiffies + timeout_jiffies;
+	if (nor->spimem && !nor->params->ready) {
+		struct spi_mem_op op = SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_RDSR, 0),
+						       SPI_MEM_OP_NO_ADDR,
+						       SPI_MEM_OP_NO_DUMMY,
+						       SPI_MEM_OP_DATA_IN(1, nor->bouncebuf, 0));
 
-	while (!timeout) {
-		if (time_after_eq(jiffies, deadline))
-			timeout = 1;
+		if (nor->reg_proto == SNOR_PROTO_8_8_8_DTR) {
+			op.addr.nbytes = nor->params->rdsr_addr_nbytes;
+			op.dummy.nbytes = nor->params->rdsr_dummy;
+			/*
+			 * We don't want to read only one byte in DTR mode. So,
+			 * read 2 and then discard the second byte.
+			 */
+			op.data.nbytes = 2;
+		}
 
-		ret = spi_nor_ready(nor);
-		if (ret < 0)
-			return ret;
-		if (ret)
-			return 0;
+		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
+
+		return spi_mem_poll_status(nor->spimem, &op, SR_WIP, 0, 0, 10,
+						       jiffies_to_msecs(timeout_jiffies));
+	} else {
+		deadline = jiffies + timeout_jiffies;
 
-		cond_resched();
+		while (!timeout) {
+			if (time_after_eq(jiffies, deadline))
+				timeout = 1;
+
+			ret = spi_nor_ready(nor);
+			if (ret < 0)
+				return ret;
+			if (ret)
+				return 0;
+
+			cond_resched();
+		}
 	}
 
 	dev_dbg(nor->dev, "flash operation timed out\n");
-- 
2.7.4

