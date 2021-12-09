Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B4446E512
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhLIJJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:09:29 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42786 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhLIJIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:08:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C2EB6CE2532;
        Thu,  9 Dec 2021 09:05:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8A7C341C8;
        Thu,  9 Dec 2021 09:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639040714;
        bh=56D4wDk6WCfR2u3H5Yd+PdyMNYGcoMQcE4p2PmSM+20=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIi42gd0u7atthYnTy3wTEYy4r9csWENa57T/Ex+8aaVsQyz6AfCLBBAQnq0i8xi1
         h6JEWZ1wp0BNVOtu5RsXeXEqtfMWKc6IJyAEAx0SLyEWpgWTD9oDjWCXRaFJoWtxRy
         a/B+2subWfT5VEOYhFXBfuuEat0BxOtAlJDowiym0QNJr8JJ81UwWAa85K554Ytdrj
         n1qOOJq7LbL8LjlVPySiQ5iLyc+rLuPRqlu9QiGnF9g25H4UuE/xyUPBgIn62osGJZ
         Q7z4+Xgkrz/2jgLwot8octX48MfqQXWiYRHPK3QP+4bq3ySrskKklmNIXLItXgCEs9
         JGa0g5CtLkpUA==
From:   Roger Quadros <rogerq@kernel.org>
To:     miquel.raynal@bootlin.com, richard@nod.at
Cc:     vigneshr@ti.com, kishon@ti.com, nm@ti.com, tony@atomide.com,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 3/6] mtd: rawnand: omap2: move to exec_op interface
Date:   Thu,  9 Dec 2021 11:04:55 +0200
Message-Id: <20211209090458.24830-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209090458.24830-1-rogerq@kernel.org>
References: <20211209090458.24830-1-rogerq@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop using legacy interface and move to the exec_op interface.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 490 +++++++++++++++--------------------
 1 file changed, 211 insertions(+), 279 deletions(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index b26d4947af02..224c91282c87 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -19,7 +19,7 @@
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/partitions.h>
 #include <linux/omap-dma.h>
-#include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -164,6 +164,7 @@ struct omap_nand_info {
 	u_char				*buf;
 	int					buf_len;
 	/* Interface to GPMC */
+	void __iomem			*fifo;
 	struct gpmc_nand_regs		reg;
 	struct gpmc_nand_ops		*ops;
 	bool				flash_bbt;
@@ -175,6 +176,11 @@ struct omap_nand_info {
 	unsigned int			nsteps_per_eccpg;
 	unsigned int			eccpg_size;
 	unsigned int			eccpg_bytes;
+	void (*data_in)(struct nand_chip *chip, void *buf,
+			unsigned int len, bool force_8bit);
+	void (*data_out)(struct nand_chip *chip,
+			 const void *buf, unsigned int len,
+			 bool force_8bit);
 };
 
 static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
@@ -182,6 +188,13 @@ static inline struct omap_nand_info *mtd_to_omap(struct mtd_info *mtd)
 	return container_of(mtd_to_nand(mtd), struct omap_nand_info, nand);
 }
 
+static void omap_nand_data_in(struct nand_chip *chip, void *buf,
+			      unsigned int len, bool force_8bit);
+
+static void omap_nand_data_out(struct nand_chip *chip,
+			       const void *buf, unsigned int len,
+			       bool force_8bit);
+
 /**
  * omap_prefetch_enable - configures and starts prefetch transfer
  * @cs: cs (chip select) number
@@ -241,169 +254,70 @@ static int omap_prefetch_reset(int cs, struct omap_nand_info *info)
 }
 
 /**
- * omap_hwcontrol - hardware specific access to control-lines
- * @chip: NAND chip object
- * @cmd: command to device
- * @ctrl:
- * NAND_NCE: bit 0 -> don't care
- * NAND_CLE: bit 1 -> Command Latch
- * NAND_ALE: bit 2 -> Address Latch
- *
- * NOTE: boards may use different bits for these!!
+ * omap_nand_data_in_pref - NAND data in using prefetch engine
  */
-static void omap_hwcontrol(struct nand_chip *chip, int cmd, unsigned int ctrl)
+static void omap_nand_data_in_pref(struct nand_chip *chip, void *buf,
+				   unsigned int len, bool force_8bit)
 {
 	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
-
-	if (cmd != NAND_CMD_NONE) {
-		if (ctrl & NAND_CLE)
-			writeb(cmd, info->reg.gpmc_nand_command);
-
-		else if (ctrl & NAND_ALE)
-			writeb(cmd, info->reg.gpmc_nand_address);
-
-		else /* NAND_NCE */
-			writeb(cmd, info->reg.gpmc_nand_data);
-	}
-}
-
-/**
- * omap_read_buf8 - read data from NAND controller into buffer
- * @mtd: MTD device structure
- * @buf: buffer to store date
- * @len: number of bytes to read
- */
-static void omap_read_buf8(struct mtd_info *mtd, u_char *buf, int len)
-{
-	struct nand_chip *nand = mtd_to_nand(mtd);
-
-	ioread8_rep(nand->legacy.IO_ADDR_R, buf, len);
-}
-
-/**
- * omap_write_buf8 - write buffer to NAND controller
- * @mtd: MTD device structure
- * @buf: data buffer
- * @len: number of bytes to write
- */
-static void omap_write_buf8(struct mtd_info *mtd, const u_char *buf, int len)
-{
-	struct omap_nand_info *info = mtd_to_omap(mtd);
-	u_char *p = (u_char *)buf;
-	bool status;
-
-	while (len--) {
-		iowrite8(*p++, info->nand.legacy.IO_ADDR_W);
-		/* wait until buffer is available for write */
-		do {
-			status = info->ops->nand_writebuffer_empty();
-		} while (!status);
-	}
-}
-
-/**
- * omap_read_buf16 - read data from NAND controller into buffer
- * @mtd: MTD device structure
- * @buf: buffer to store date
- * @len: number of bytes to read
- */
-static void omap_read_buf16(struct mtd_info *mtd, u_char *buf, int len)
-{
-	struct nand_chip *nand = mtd_to_nand(mtd);
-
-	ioread16_rep(nand->legacy.IO_ADDR_R, buf, len / 2);
-}
-
-/**
- * omap_write_buf16 - write buffer to NAND controller
- * @mtd: MTD device structure
- * @buf: data buffer
- * @len: number of bytes to write
- */
-static void omap_write_buf16(struct mtd_info *mtd, const u_char * buf, int len)
-{
-	struct omap_nand_info *info = mtd_to_omap(mtd);
-	u16 *p = (u16 *) buf;
-	bool status;
-	/* FIXME try bursts of writesw() or DMA ... */
-	len >>= 1;
-
-	while (len--) {
-		iowrite16(*p++, info->nand.legacy.IO_ADDR_W);
-		/* wait until buffer is available for write */
-		do {
-			status = info->ops->nand_writebuffer_empty();
-		} while (!status);
-	}
-}
-
-/**
- * omap_read_buf_pref - read data from NAND controller into buffer
- * @chip: NAND chip object
- * @buf: buffer to store date
- * @len: number of bytes to read
- */
-static void omap_read_buf_pref(struct nand_chip *chip, u_char *buf, int len)
-{
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct omap_nand_info *info = mtd_to_omap(mtd);
 	uint32_t r_count = 0;
 	int ret = 0;
 	u32 *p = (u32 *)buf;
+	unsigned int pref_len;
 
-	/* take care of subpage reads */
-	if (len % 4) {
-		if (info->nand.options & NAND_BUSWIDTH_16)
-			omap_read_buf16(mtd, buf, len % 4);
-		else
-			omap_read_buf8(mtd, buf, len % 4);
-		p = (u32 *) (buf + len % 4);
-		len -= len % 4;
+	if (force_8bit) {
+		omap_nand_data_in(chip, buf, len, force_8bit);
+		return;
 	}
 
+	/* read 32-bit words using prefetch and remaining bytes normally */
+
 	/* configure and start prefetch transfer */
+	pref_len = len - (len & 3);
 	ret = omap_prefetch_enable(info->gpmc_cs,
-			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x0, info);
+			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, pref_len, 0x0, info);
 	if (ret) {
-		/* PFPW engine is busy, use cpu copy method */
-		if (info->nand.options & NAND_BUSWIDTH_16)
-			omap_read_buf16(mtd, (u_char *)p, len);
-		else
-			omap_read_buf8(mtd, (u_char *)p, len);
+		/* prefetch engine is busy, use CPU copy method */
+		omap_nand_data_in(chip, buf, len, false);
 	} else {
 		do {
 			r_count = readl(info->reg.gpmc_prefetch_status);
 			r_count = PREFETCH_STATUS_FIFO_CNT(r_count);
 			r_count = r_count >> 2;
-			ioread32_rep(info->nand.legacy.IO_ADDR_R, p, r_count);
+			ioread32_rep(info->fifo, p, r_count);
 			p += r_count;
-			len -= r_count << 2;
-		} while (len);
-		/* disable and stop the PFPW engine */
+			pref_len -= r_count << 2;
+		} while (pref_len);
+		/* disable and stop the Prefetch engine */
 		omap_prefetch_reset(info->gpmc_cs, info);
+		/* fetch any remaining bytes */
+		if (len & 3)
+			omap_nand_data_in(chip, p, len & 3, false);
 	}
 }
 
 /**
- * omap_write_buf_pref - write buffer to NAND controller
- * @chip: NAND chip object
- * @buf: data buffer
- * @len: number of bytes to write
+ * omap_nand_data_out_pref - NAND data out using Write Posting engine
  */
-static void omap_write_buf_pref(struct nand_chip *chip, const u_char *buf,
-				int len)
+static void omap_nand_data_out_pref(struct nand_chip *chip,
+				    const void *buf, unsigned int len,
+				    bool force_8bit)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	uint32_t w_count = 0;
 	int i = 0, ret = 0;
 	u16 *p = (u16 *)buf;
 	unsigned long tim, limit;
 	u32 val;
 
+	if (force_8bit) {
+		omap_nand_data_out(chip, buf, len, force_8bit);
+		return;
+	}
+
 	/* take care of subpage writes */
 	if (len % 2 != 0) {
-		writeb(*buf, info->nand.legacy.IO_ADDR_W);
+		writeb(*(u8 *)buf, info->fifo);
 		p = (u16 *)(buf + 1);
 		len--;
 	}
@@ -412,18 +326,15 @@ static void omap_write_buf_pref(struct nand_chip *chip, const u_char *buf,
 	ret = omap_prefetch_enable(info->gpmc_cs,
 			PREFETCH_FIFOTHRESHOLD_MAX, 0x0, len, 0x1, info);
 	if (ret) {
-		/* PFPW engine is busy, use cpu copy method */
-		if (info->nand.options & NAND_BUSWIDTH_16)
-			omap_write_buf16(mtd, (u_char *)p, len);
-		else
-			omap_write_buf8(mtd, (u_char *)p, len);
+		/* write posting engine is busy, use CPU copy method */
+		omap_nand_data_out(chip, buf, len, false);
 	} else {
 		while (len) {
 			w_count = readl(info->reg.gpmc_prefetch_status);
 			w_count = PREFETCH_STATUS_FIFO_CNT(w_count);
 			w_count = w_count >> 1;
 			for (i = 0; (i < w_count) && len; i++, len -= 2)
-				iowrite16(*p++, info->nand.legacy.IO_ADDR_W);
+				iowrite16(*p++, info->fifo);
 		}
 		/* wait for data to flushed-out before reset the prefetch */
 		tim = 0;
@@ -451,15 +362,16 @@ static void omap_nand_dma_callback(void *data)
 
 /*
  * omap_nand_dma_transfer: configure and start dma transfer
- * @mtd: MTD device structure
+ * @chip: nand chip structure
  * @addr: virtual address in RAM of source/destination
  * @len: number of data bytes to be transferred
  * @is_write: flag for read/write operation
  */
-static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
-					unsigned int len, int is_write)
+static inline int omap_nand_dma_transfer(struct nand_chip *chip,
+					 const void *addr, unsigned int len,
+					 int is_write)
 {
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
 	struct dma_async_tx_descriptor *tx;
 	enum dma_data_direction dir = is_write ? DMA_TO_DEVICE :
 							DMA_FROM_DEVICE;
@@ -521,49 +433,41 @@ static inline int omap_nand_dma_transfer(struct mtd_info *mtd, void *addr,
 out_copy_unmap:
 	dma_unmap_sg(info->dma->device->dev, &sg, 1, dir);
 out_copy:
-	if (info->nand.options & NAND_BUSWIDTH_16)
-		is_write == 0 ? omap_read_buf16(mtd, (u_char *) addr, len)
-			: omap_write_buf16(mtd, (u_char *) addr, len);
-	else
-		is_write == 0 ? omap_read_buf8(mtd, (u_char *) addr, len)
-			: omap_write_buf8(mtd, (u_char *) addr, len);
+	is_write == 0 ? omap_nand_data_in(chip, (void *)addr, len, false)
+		      : omap_nand_data_out(chip, addr, len, false);
+
 	return 0;
 }
 
 /**
- * omap_read_buf_dma_pref - read data from NAND controller into buffer
- * @chip: NAND chip object
- * @buf: buffer to store date
- * @len: number of bytes to read
+ * omap_nand_data_in_dma_pref - NAND data in using DMA and Prefetch
  */
-static void omap_read_buf_dma_pref(struct nand_chip *chip, u_char *buf,
-				   int len)
+static void omap_nand_data_in_dma_pref(struct nand_chip *chip, void *buf,
+				       unsigned int len, bool force_8bit)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	if (len <= mtd->oobsize)
-		omap_read_buf_pref(chip, buf, len);
+		omap_nand_data_in_pref(chip, buf, len, false);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, buf, len, 0x0);
+		omap_nand_dma_transfer(chip, buf, len, 0x0);
 }
 
 /**
- * omap_write_buf_dma_pref - write buffer to NAND controller
- * @chip: NAND chip object
- * @buf: data buffer
- * @len: number of bytes to write
+ * omap_nand_data_out_dma_pref - NAND data out using DMA and write posting
  */
-static void omap_write_buf_dma_pref(struct nand_chip *chip, const u_char *buf,
-				    int len)
+static void omap_nand_data_out_dma_pref(struct nand_chip *chip,
+					const void *buf, unsigned int len,
+					bool force_8bit)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
 
 	if (len <= mtd->oobsize)
-		omap_write_buf_pref(chip, buf, len);
+		omap_nand_data_out_pref(chip, buf, len, false);
 	else
 		/* start transfer in DMA mode */
-		omap_nand_dma_transfer(mtd, (u_char *)buf, len, 0x1);
+		omap_nand_dma_transfer(chip, buf, len, 0x1);
 }
 
 /*
@@ -587,13 +491,13 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 			bytes = info->buf_len;
 		else if (!info->buf_len)
 			bytes = 0;
-		iowrite32_rep(info->nand.legacy.IO_ADDR_W, (u32 *)info->buf,
+		iowrite32_rep(info->fifo, (u32 *)info->buf,
 			      bytes >> 2);
 		info->buf = info->buf + bytes;
 		info->buf_len -= bytes;
 
 	} else {
-		ioread32_rep(info->nand.legacy.IO_ADDR_R, (u32 *)info->buf,
+		ioread32_rep(info->fifo, (u32 *)info->buf,
 			     bytes >> 2);
 		info->buf = info->buf + bytes;
 
@@ -613,20 +517,17 @@ static irqreturn_t omap_nand_irq(int this_irq, void *dev)
 }
 
 /*
- * omap_read_buf_irq_pref - read data from NAND controller into buffer
- * @chip: NAND chip object
- * @buf: buffer to store date
- * @len: number of bytes to read
+ * omap_nand_data_in_irq_pref - NAND data in using Prefetch and IRQ
  */
-static void omap_read_buf_irq_pref(struct nand_chip *chip, u_char *buf,
-				   int len)
+static void omap_nand_data_in_irq_pref(struct nand_chip *chip, void *buf,
+				       unsigned int len, bool force_8bit)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
+	struct mtd_info *mtd = nand_to_mtd(&info->nand);
 	int ret = 0;
 
-	if (len <= mtd->oobsize) {
-		omap_read_buf_pref(chip, buf, len);
+	if (len <= mtd->oobsize || force_8bit) {
+		omap_nand_data_in(chip, buf, len, force_8bit);
 		return;
 	}
 
@@ -637,9 +538,11 @@ static void omap_read_buf_irq_pref(struct nand_chip *chip, u_char *buf,
 	/*  configure and start prefetch transfer */
 	ret = omap_prefetch_enable(info->gpmc_cs,
 			PREFETCH_FIFOTHRESHOLD_MAX/2, 0x0, len, 0x0, info);
-	if (ret)
+	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
-		goto out_copy;
+		omap_nand_data_in(chip, buf, len, false);
+		return;
+	}
 
 	info->buf_len = len;
 
@@ -652,31 +555,23 @@ static void omap_read_buf_irq_pref(struct nand_chip *chip, u_char *buf,
 	/* disable and stop the PFPW engine */
 	omap_prefetch_reset(info->gpmc_cs, info);
 	return;
-
-out_copy:
-	if (info->nand.options & NAND_BUSWIDTH_16)
-		omap_read_buf16(mtd, buf, len);
-	else
-		omap_read_buf8(mtd, buf, len);
 }
 
 /*
- * omap_write_buf_irq_pref - write buffer to NAND controller
- * @chip: NAND chip object
- * @buf: data buffer
- * @len: number of bytes to write
+ * omap_nand_data_out_irq_pref - NAND out using write posting and IRQ
  */
-static void omap_write_buf_irq_pref(struct nand_chip *chip, const u_char *buf,
-				    int len)
+static void omap_nand_data_out_irq_pref(struct nand_chip *chip,
+					const void *buf, unsigned int len,
+					bool force_8bit)
 {
-	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct omap_nand_info *info = mtd_to_omap(mtd);
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
+	struct mtd_info *mtd = nand_to_mtd(&info->nand);
 	int ret = 0;
 	unsigned long tim, limit;
 	u32 val;
 
-	if (len <= mtd->oobsize) {
-		omap_write_buf_pref(chip, buf, len);
+	if (len <= mtd->oobsize || force_8bit) {
+		omap_nand_data_out(chip, buf, len, force_8bit);
 		return;
 	}
 
@@ -687,9 +582,11 @@ static void omap_write_buf_irq_pref(struct nand_chip *chip, const u_char *buf,
 	/* configure and start prefetch transfer : size=24 */
 	ret = omap_prefetch_enable(info->gpmc_cs,
 		(PREFETCH_FIFOTHRESHOLD_MAX * 3) / 8, 0x0, len, 0x1, info);
-	if (ret)
+	if (ret) {
 		/* PFPW engine is busy, use cpu copy method */
-		goto out_copy;
+		omap_nand_data_out(chip, buf, len, false);
+		return;
+	}
 
 	info->buf_len = len;
 
@@ -711,12 +608,6 @@ static void omap_write_buf_irq_pref(struct nand_chip *chip, const u_char *buf,
 	/* disable and stop the PFPW engine */
 	omap_prefetch_reset(info->gpmc_cs, info);
 	return;
-
-out_copy:
-	if (info->nand.options & NAND_BUSWIDTH_16)
-		omap_write_buf16(mtd, buf, len);
-	else
-		omap_write_buf8(mtd, buf, len);
 }
 
 /**
@@ -981,50 +872,6 @@ static void omap_enable_hwecc(struct nand_chip *chip, int mode)
 	writel(val, info->reg.gpmc_ecc_config);
 }
 
-/**
- * omap_wait - wait until the command is done
- * @this: NAND Chip structure
- *
- * Wait function is called during Program and erase operations and
- * the way it is called from MTD layer, we should wait till the NAND
- * chip is ready after the programming/erase operation has completed.
- *
- * Erase can take up to 400ms and program up to 20ms according to
- * general NAND and SmartMedia specs
- */
-static int omap_wait(struct nand_chip *this)
-{
-	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(this));
-	unsigned long timeo = jiffies;
-	int status;
-
-	timeo += msecs_to_jiffies(400);
-
-	writeb(NAND_CMD_STATUS & 0xFF, info->reg.gpmc_nand_command);
-	while (time_before(jiffies, timeo)) {
-		status = readb(info->reg.gpmc_nand_data);
-		if (status & NAND_STATUS_READY)
-			break;
-		cond_resched();
-	}
-
-	status = readb(info->reg.gpmc_nand_data);
-	return status;
-}
-
-/**
- * omap_dev_ready - checks the NAND Ready GPIO line
- * @chip: NAND chip object
- *
- * Returns true if ready and false if busy.
- */
-static int omap_dev_ready(struct nand_chip *chip)
-{
-	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
-
-	return gpiod_get_value(info->ready_gpiod);
-}
-
 /**
  * omap_enable_hwecc_bch - Program GPMC to perform BCH ECC calculation
  * @chip: NAND chip object
@@ -1543,8 +1390,8 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 		chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 		/* Write data */
-		chip->legacy.write_buf(chip, buf + (eccpg * info->eccpg_size),
-				       info->eccpg_size);
+		info->data_out(chip, buf + (eccpg * info->eccpg_size),
+			       info->eccpg_size, false);
 
 		/* Update ecc vector from GPMC result registers */
 		ret = omap_calculate_ecc_bch_multi(mtd,
@@ -1562,7 +1409,7 @@ static int omap_write_page_bch(struct nand_chip *chip, const uint8_t *buf,
 	}
 
 	/* Write ecc vector to OOB area */
-	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
+	info->data_out(chip, chip->oob_poi, mtd->oobsize, false);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -1607,8 +1454,8 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 		chip->ecc.hwctl(chip, NAND_ECC_WRITE);
 
 		/* Write data */
-		chip->legacy.write_buf(chip, buf + (eccpg * info->eccpg_size),
-				       info->eccpg_size);
+		info->data_out(chip, buf + (eccpg * info->eccpg_size),
+			       info->eccpg_size, false);
 
 		for (step = 0; step < info->nsteps_per_eccpg; step++) {
 			unsigned int base_step = eccpg * info->nsteps_per_eccpg;
@@ -1641,7 +1488,7 @@ static int omap_write_subpage_bch(struct nand_chip *chip, u32 offset,
 	}
 
 	/* write OOB buffer to NAND device */
-	chip->legacy.write_buf(chip, chip->oob_poi, mtd->oobsize);
+	info->data_out(chip, chip->oob_poi, mtd->oobsize, false);
 
 	return nand_prog_page_end_op(chip);
 }
@@ -1984,8 +1831,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 	/* Re-populate low-level callbacks based on xfer modes */
 	switch (info->xfer_type) {
 	case NAND_OMAP_PREFETCH_POLLED:
-		chip->legacy.read_buf = omap_read_buf_pref;
-		chip->legacy.write_buf = omap_write_buf_pref;
+		info->data_in = omap_nand_data_in_pref;
+		info->data_out = omap_nand_data_out_pref;
 		break;
 
 	case NAND_OMAP_POLLED:
@@ -2017,8 +1864,9 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 					err);
 				return err;
 			}
-			chip->legacy.read_buf = omap_read_buf_dma_pref;
-			chip->legacy.write_buf = omap_write_buf_dma_pref;
+
+			info->data_in = omap_nand_data_in_dma_pref;
+			info->data_out = omap_nand_data_out_dma_pref;
 		}
 		break;
 
@@ -2049,9 +1897,8 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 			return err;
 		}
 
-		chip->legacy.read_buf = omap_read_buf_irq_pref;
-		chip->legacy.write_buf = omap_write_buf_irq_pref;
-
+		info->data_in = omap_nand_data_in_irq_pref;
+		info->data_out = omap_nand_data_out_irq_pref;
 		break;
 
 	default:
@@ -2217,8 +2064,105 @@ static int omap_nand_attach_chip(struct nand_chip *chip)
 	return 0;
 }
 
+static void omap_nand_data_in(struct nand_chip *chip, void *buf,
+			      unsigned int len, bool force_8bit)
+{
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
+	u32 alignment = ((uintptr_t)buf | len) & 3;
+
+	if (force_8bit || (alignment & 1))
+		ioread8_rep(info->fifo, buf, len);
+	else if (alignment & 3)
+		ioread16_rep(info->fifo, buf, len >> 1);
+	else
+		ioread32_rep(info->fifo, buf, len >> 2);
+}
+
+static void omap_nand_data_out(struct nand_chip *chip,
+			       const void *buf, unsigned int len,
+			       bool force_8bit)
+{
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
+	u32 alignment = ((uintptr_t)buf | len) & 3;
+
+	if (force_8bit || (alignment & 1))
+		iowrite8_rep(info->fifo, buf, len);
+	else if (alignment & 3)
+		iowrite16_rep(info->fifo, buf, len >> 1);
+	else
+		iowrite32_rep(info->fifo, buf, len >> 2);
+}
+
+static int omap_nand_exec_instr(struct nand_chip *chip,
+				const struct nand_op_instr *instr)
+{
+	struct omap_nand_info *info = mtd_to_omap(nand_to_mtd(chip));
+	unsigned int i;
+	int ret;
+
+	switch (instr->type) {
+	case NAND_OP_CMD_INSTR:
+		iowrite8(instr->ctx.cmd.opcode,
+			 info->reg.gpmc_nand_command);
+		break;
+
+	case NAND_OP_ADDR_INSTR:
+		for (i = 0; i < instr->ctx.addr.naddrs; i++) {
+			iowrite8(instr->ctx.addr.addrs[i],
+				 info->reg.gpmc_nand_address);
+		}
+		break;
+
+	case NAND_OP_DATA_IN_INSTR:
+		info->data_in(chip, instr->ctx.data.buf.in,
+			      instr->ctx.data.len,
+			      instr->ctx.data.force_8bit);
+		break;
+
+	case NAND_OP_DATA_OUT_INSTR:
+		info->data_out(chip, instr->ctx.data.buf.out,
+			       instr->ctx.data.len,
+			       instr->ctx.data.force_8bit);
+		break;
+
+	case NAND_OP_WAITRDY_INSTR:
+		ret = info->ready_gpiod ?
+			nand_gpio_waitrdy(chip, info->ready_gpiod, instr->ctx.waitrdy.timeout_ms) :
+			nand_soft_waitrdy(chip, instr->ctx.waitrdy.timeout_ms);
+		if (ret)
+			return ret;
+		break;
+	}
+
+	if (instr->delay_ns)
+		ndelay(instr->delay_ns);
+
+	return 0;
+}
+
+static int omap_nand_exec_op(struct nand_chip *chip,
+			     const struct nand_operation *op,
+			     bool check_only)
+{
+	unsigned int i;
+
+	if (check_only)
+		return 0;
+
+	for (i = 0; i < op->ninstrs; i++) {
+		int ret;
+
+		ret = omap_nand_exec_instr(chip, &op->instrs[i]);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct nand_controller_ops omap_nand_controller_ops = {
 	.attach_chip = omap_nand_attach_chip,
+	.exec_op = omap_nand_exec_op,
 };
 
 /* Shared among all NAND instances to synchronize access to the ECC Engine */
@@ -2233,6 +2177,7 @@ static int omap_nand_probe(struct platform_device *pdev)
 	int				err;
 	struct resource			*res;
 	struct device			*dev = &pdev->dev;
+	void __iomem *vaddr;
 
 	info = devm_kzalloc(&pdev->dev, sizeof(struct omap_nand_info),
 				GFP_KERNEL);
@@ -2266,10 +2211,11 @@ static int omap_nand_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nand_chip->legacy.IO_ADDR_R = devm_ioremap_resource(&pdev->dev, res);
-	if (IS_ERR(nand_chip->legacy.IO_ADDR_R))
-		return PTR_ERR(nand_chip->legacy.IO_ADDR_R);
+	vaddr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(vaddr))
+		return PTR_ERR(vaddr);
 
+	info->fifo = vaddr;
 	info->phys_base = res->start;
 
 	if (!omap_gpmc_controller_initialized) {
@@ -2280,9 +2226,6 @@ static int omap_nand_probe(struct platform_device *pdev)
 
 	nand_chip->controller = &omap_gpmc_controller;
 
-	nand_chip->legacy.IO_ADDR_W = nand_chip->legacy.IO_ADDR_R;
-	nand_chip->legacy.cmd_ctrl  = omap_hwcontrol;
-
 	info->ready_gpiod = devm_gpiod_get_optional(&pdev->dev, "rb",
 						    GPIOD_IN);
 	if (IS_ERR(info->ready_gpiod)) {
@@ -2290,27 +2233,16 @@ static int omap_nand_probe(struct platform_device *pdev)
 		return PTR_ERR(info->ready_gpiod);
 	}
 
-	/*
-	 * If RDY/BSY line is connected to OMAP then use the omap ready
-	 * function and the generic nand_wait function which reads the status
-	 * register after monitoring the RDY/BSY line. Otherwise use a standard
-	 * chip delay which is slightly more than tR (AC Timing) of the NAND
-	 * device and read status register until you get a failure or success
-	 */
-	if (info->ready_gpiod) {
-		nand_chip->legacy.dev_ready = omap_dev_ready;
-		nand_chip->legacy.chip_delay = 0;
-	} else {
-		nand_chip->legacy.waitfunc = omap_wait;
-		nand_chip->legacy.chip_delay = 50;
-	}
-
 	if (info->flash_bbt)
 		nand_chip->bbt_options |= NAND_BBT_USE_FLASH;
 
 	/* scan NAND device connected to chip controller */
 	nand_chip->options |= info->devsize & NAND_BUSWIDTH_16;
 
+	/* default operations */
+	info->data_in = omap_nand_data_in;
+	info->data_out = omap_nand_data_out;
+
 	err = nand_scan(nand_chip, 1);
 	if (err)
 		goto return_error;
-- 
2.17.1

