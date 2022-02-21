Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1FC4BE3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357479AbiBUMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 07:10:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357326AbiBUMIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 07:08:52 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D36265A6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 04:08:28 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4A2EC223EF;
        Mon, 21 Feb 2022 13:08:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1645445307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BewPUYl7ALanqbEPhDcl7g1lZEpz+MjVY87ZkoEXHuI=;
        b=Z88OJcJde7mtyl3erugqsv3vrtCD2O4jWvmKZcNVKeakXD5UMtklmEMfKdieeJNJ3iuuvS
        byeuHvVjmvSqn8jaiobpH5DkogIoUoISADGWrz17N+tX+4Oq2N+hYIGWtJ+I3kmFiybrp1
        VobBFe5RKFoGchTxipBKue0QIM6CqHQ=
From:   Michael Walle <michael@walle.cc>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        yaliang.wang@windriver.com, Michael Walle <michael@walle.cc>
Subject: [PATCH v4 19/32] mtd: spi-nor: export more function to be used in vendor modules
Date:   Mon, 21 Feb 2022 13:07:56 +0100
Message-Id: <20220221120809.1531502-20-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220221120809.1531502-1-michael@walle.cc>
References: <20220221120809.1531502-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We will move vendor specific code into the vendor modules and thus we
will have to export these functions so they can be called.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
 drivers/mtd/spi-nor/core.c | 10 +++++-----
 drivers/mtd/spi-nor/core.h |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 390a9ab413b7..8481272533a3 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -157,8 +157,8 @@ static int spi_nor_spimem_exec_op(struct spi_nor *nor, struct spi_mem_op *op)
 	return spi_mem_exec_op(nor->spimem, op);
 }
 
-static int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
-					   u8 *buf, size_t len)
+int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
+				    u8 *buf, size_t len)
 {
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		return -EOPNOTSUPP;
@@ -166,8 +166,8 @@ static int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
 	return nor->controller_ops->read_reg(nor, opcode, buf, len);
 }
 
-static int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
-					    const u8 *buf, size_t len)
+int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
+				     const u8 *buf, size_t len)
 {
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		return -EOPNOTSUPP;
@@ -683,7 +683,7 @@ static void spi_nor_clear_sr(struct spi_nor *nor)
  *
  * Return: 1 if ready, 0 if not ready, -errno on errors.
  */
-static int spi_nor_sr_ready(struct spi_nor *nor)
+int spi_nor_sr_ready(struct spi_nor *nor)
 {
 	int ret = spi_nor_read_sr(nor, nor->bouncebuf);
 
diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
index fdc8c0f31f5c..446218b0e017 100644
--- a/drivers/mtd/spi-nor/core.h
+++ b/drivers/mtd/spi-nor/core.h
@@ -558,6 +558,7 @@ int spi_nor_sr1_bit6_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit1_quad_enable(struct spi_nor *nor);
 int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor);
 int spi_nor_read_sr(struct spi_nor *nor, u8 *sr);
+int spi_nor_sr_ready(struct spi_nor *nor);
 int spi_nor_read_cr(struct spi_nor *nor, u8 *cr);
 int spi_nor_write_sr(struct spi_nor *nor, const u8 *sr, size_t len);
 int spi_nor_write_sr_and_check(struct spi_nor *nor, u8 sr1);
@@ -603,6 +604,11 @@ void spi_nor_try_unlock_all(struct spi_nor *nor);
 void spi_nor_set_mtd_locking_ops(struct spi_nor *nor);
 void spi_nor_set_mtd_otp_ops(struct spi_nor *nor);
 
+int spi_nor_controller_ops_read_reg(struct spi_nor *nor, u8 opcode,
+				    u8 *buf, size_t len);
+int spi_nor_controller_ops_write_reg(struct spi_nor *nor, u8 opcode,
+				     const u8 *buf, size_t len);
+
 static inline struct spi_nor *mtd_to_spi_nor(struct mtd_info *mtd)
 {
 	return container_of(mtd, struct spi_nor, mtd);
-- 
2.30.2

