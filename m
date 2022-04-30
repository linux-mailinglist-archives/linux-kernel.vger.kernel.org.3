Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B79D515F4F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383156AbiD3QoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383144AbiD3Qnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:43:55 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB14193E7
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:40:32 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so9305396pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2c/Ky9Liyh4deI3k85Qj56knYUJOmGyYJ4Gh53Qh+0=;
        b=J5tLkjIho8qSRImFkS1JBZAIDt9Ckhz6NfJO5EXdo3g2Ymj5amtXNa2+bD4AoMJhLZ
         Y5LMBAWd991sE8c6GjPHpvqW1j2mXKZpcghBuiusmjaiTIemotTUluRJ7ANg66zn82us
         K7QA1yuJ6CwfpZlUTcuQ4+3fB6NrEy/Es4lwfosyFf0Txv8KC+IUuY7xsoCYIVVbqMuO
         dH+Uxp4PAkT+eHESeGJ6OkhWwN2/4TaOYtkgWSwICI7Lce3msZCvPDJLPeYmjyO0Nhfz
         sXPMerTuxdzEddifZvICyrGFVHFfNN7MKJPDJVNmto9wNv1j1hPre6HHMt4R1beXw3fD
         9WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2c/Ky9Liyh4deI3k85Qj56knYUJOmGyYJ4Gh53Qh+0=;
        b=pQ0HAL2uaa3fWaTVe4NAbzMFGKQSs3V9gR021wHMixnXOeh26GcPWODe1PIDJ3Bto2
         L185BN22xY+bBHWN8zWa/+lzmKiihgrVMGqoDphXDUr/HbDD5a8IoY5CgBx2Oba4E+Rv
         MIZdSC6qjo/hv104h3A6UzVcHJ9N0RRQ4iXH7H1HpElmL+Hq0KbEP3eeO2OdFmNQn5Mq
         SbCPejJjGSPu2cIah67o+RBCgeyvo0AXUNBBdTos6puZjzf/CEN/APca2GUmUeagT7Ek
         7GUePUpLaeCYRSW2yBH47an1/hGLK0RdOvMcTqiDoZmFqxG6hlBg9x30l7XWbzPkd3e1
         VPww==
X-Gm-Message-State: AOAM533Xgt8ZRZz5p9xN4xDELlmvfDpxhdvzosWjqYGqLNl4OkIB/uvW
        H1xMzWSr1WqH6hzgBQbM1t4KDmHAg6GyNA==
X-Google-Smtp-Source: ABdhPJwQtMRNhpB/tnTOiMm2a7Q1CLofcPJd1tvvxjrklVDysFZf85RlMKFZG2pRbtqvxaP+Kag8bQ==
X-Received: by 2002:a63:4f1e:0:b0:3a6:68b7:cedc with SMTP id d30-20020a634f1e000000b003a668b7cedcmr3625624pgb.29.1651336832350;
        Sat, 30 Apr 2022 09:40:32 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:c0f1:53a1:ea79:5d2f])
        by smtp.gmail.com with ESMTPSA id bm2-20020a056a00320200b0050dc76281dbsm1736816pfb.181.2022.04.30.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:40:32 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: nand: ecc-mtk: add external ecc engine support
Date:   Sun,  1 May 2022 00:40:21 +0800
Message-Id: <20220430164021.537668-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for using ecc-mtk as an external ECC engine.

The implemented OOB layout follows the convention to put all ECC data
at the end of OOB. As a result, the data layout is incompatible with
MTK NFI piplined ECC mode.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/ecc-mtk.c | 335 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 331 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/ecc-mtk.c b/drivers/mtd/nand/ecc-mtk.c
index 9f9b201fe706..998276ada671 100644
--- a/drivers/mtd/nand/ecc-mtk.c
+++ b/drivers/mtd/nand/ecc-mtk.c
@@ -15,6 +15,7 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/mutex.h>
+#include <linux/mtd/nand.h>
 #include <linux/mtd/nand-ecc-mtk.h>
 
 #define ECC_IDLE_MASK		BIT(0)
@@ -26,12 +27,14 @@
 #define ECC_ENCCON		(0x00)
 #define ECC_ENCCNFG		(0x04)
 #define		ECC_MS_SHIFT		(16)
+#define		ECC_MAX_MS		(8191)
 #define ECC_ENCDIADDR		(0x08)
 #define ECC_ENCIDLE		(0x0C)
 #define ECC_DECCON		(0x100)
 #define ECC_DECCNFG		(0x104)
 #define		DEC_EMPTY_EN		BIT(31)
 #define		DEC_CNFG_CORRECT	(0x3 << 12)
+#define ECC_DECDIADDR		(0x108)
 #define ECC_DECIDLE		(0x10C)
 #define ECC_DECENUM0		(0x114)
 
@@ -59,11 +62,23 @@ struct mtk_ecc {
 
 	struct completion done;
 	struct mutex lock;
+	struct nand_ecc_engine ecc_eng;
 	u32 sectors;
+	u32 refcnt;
 
 	u8 *eccdata;
 };
 
+struct mtk_ecc_host_ctx {
+	struct mtk_ecc_config cfg;
+	struct nand_ecc_req_tweak_ctx req_ctx;
+	u8 *buf;
+	dma_addr_t buf_dma;
+	u32 free_len;
+	u32 parity_len;
+	u32 steps;
+};
+
 /* ecc strength that each IP supports */
 static const u8 ecc_strength_mt2701[] = {
 	4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 28, 32, 36,
@@ -75,6 +90,8 @@ static const u8 ecc_strength_mt2712[] = {
 	40, 44, 48, 52, 56, 60, 68, 72, 80
 };
 
+static const u8 ecc_strength_mt7621[] = { 4 };
+
 static const u8 ecc_strength_mt7622[] = {
 	4, 6, 8, 10, 12
 };
@@ -115,6 +132,13 @@ static int mt7622_ecc_regs[] = {
 	[ECC_DECIRQ_STA] =      0x144,
 };
 
+static struct mtk_ecc *nand_to_mtk_ecc(struct nand_device *nand)
+{
+	struct nand_ecc_engine *eng = nand->ecc.engine;
+
+	return container_of(eng, struct mtk_ecc, ecc_eng);
+}
+
 static inline void mtk_ecc_wait_idle(struct mtk_ecc *ecc,
 				     enum mtk_ecc_operation op)
 {
@@ -204,6 +228,11 @@ static int mtk_ecc_config(struct mtk_ecc *ecc, struct mtk_ecc_config *config)
 
 		if (config->sectors)
 			ecc->sectors = 1 << (config->sectors - 1);
+
+		if (config->mode != ECC_NFI_MODE)
+			writel(lower_32_bits(config->addr),
+			       ecc->regs + ECC_DECDIADDR);
+
 	}
 
 	return 0;
@@ -239,8 +268,14 @@ EXPORT_SYMBOL(mtk_ecc_get_stats);
 
 void mtk_ecc_release(struct mtk_ecc *ecc)
 {
-	clk_disable_unprepare(ecc->clk);
-	put_device(ecc->dev);
+	mutex_lock(&ecc->lock);
+
+	ecc->refcnt--;
+	if (!ecc->refcnt) {
+		clk_disable_unprepare(ecc->clk);
+		put_device(ecc->dev);
+	}
+	mutex_unlock(&ecc->lock);
 }
 EXPORT_SYMBOL(mtk_ecc_release);
 
@@ -257,6 +292,7 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 {
 	struct platform_device *pdev;
 	struct mtk_ecc *ecc;
+	int ret;
 
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
@@ -268,8 +304,17 @@ static struct mtk_ecc *mtk_ecc_get(struct device_node *np)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
-	clk_prepare_enable(ecc->clk);
-	mtk_ecc_hw_init(ecc);
+	ret = mutex_lock_interruptible(&ecc->lock);
+	if (ret) {
+		dev_err(ecc->dev, "interrupted when attempting to lock\n");
+		return ERR_PTR(ret);
+	}
+	if (!ecc->refcnt) {
+		clk_prepare_enable(ecc->clk);
+		mtk_ecc_hw_init(ecc);
+	}
+	ecc->refcnt++;
+	mutex_unlock(&ecc->lock);
 
 	return ecc;
 }
@@ -450,6 +495,283 @@ unsigned int mtk_ecc_get_parity_bits(struct mtk_ecc *ecc)
 }
 EXPORT_SYMBOL(mtk_ecc_get_parity_bits);
 
+static int mtk_ecc_host_ooblayout_ecc(struct mtd_info *mtd, int section,
+				      struct mtd_oob_region *oobecc)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
+
+	if (section)
+		return -ERANGE;
+
+	oobecc->offset = ctx->free_len + 1;
+	oobecc->length = ctx->steps * ctx->parity_len;
+	return 0;
+}
+
+static int mtk_ecc_host_ooblayout_free(struct mtd_info *mtd, int section,
+				       struct mtd_oob_region *oobfree)
+{
+	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
+
+	if (section)
+		return -ERANGE;
+
+	oobfree->offset = 1;
+	oobfree->length = ctx->free_len;
+	return 0;
+}
+
+static const struct mtd_ooblayout_ops mtk_ecc_host_ooblayout = {
+	.ecc = mtk_ecc_host_ooblayout_ecc,
+	.free = mtk_ecc_host_ooblayout_free,
+};
+
+static int mtk_ecc_host_init_ctx(struct nand_device *nand)
+{
+	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
+	struct nand_ecc_props *conf = &nand->ecc.ctx.conf;
+	struct nand_ecc_props *reqs = &nand->ecc.requirements;
+	struct nand_ecc_props *user = &nand->ecc.user_conf;
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	const u8 *ecc_strength = ecc->caps->ecc_strength;
+	int step_size = 0, strength = 0;
+	int ret = 0;
+	struct mtk_ecc_host_ctx *ctx;
+	int steps, parity_len;
+	int i;
+	u32 parity_bits;
+
+	if (user->step_size && user->strength) {
+		step_size = user->step_size;
+		strength = user->strength;
+	} else if (reqs->step_size && reqs->strength) {
+		step_size = reqs->step_size;
+		strength = reqs->strength;
+	} else {
+		dev_err(ecc->dev, "please specify a desired ECC capability.");
+		return -EINVAL;
+	}
+
+	if (step_size * 8 > ECC_MAX_MS ||
+	    strength > ecc_strength[ecc->caps->num_ecc_strength - 1]) {
+		dev_err(ecc->dev, "unable to fulfill ECC capability.");
+		return -EOPNOTSUPP;
+	}
+
+	for (i = 0; i < ecc->caps->num_ecc_strength; i++) {
+		if (strength <= ecc_strength[i]) {
+			strength = ecc_strength[i];
+			break;
+		}
+	}
+
+	parity_bits = fls(1 + 8 * step_size);
+	steps = mtd->writesize / step_size;
+	parity_len = parity_bits * strength;
+	parity_len = DIV_ROUND_UP(parity_len, 8);
+
+	if (parity_len * steps > mtd->oobsize - 1) {
+		dev_err(ecc->dev, "OOB is too small for %d bytes of ECC data.",
+			parity_len * steps);
+		return -EOPNOTSUPP;
+	}
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	nand->ecc.ctx.priv = ctx;
+
+	ctx->cfg.mode = ECC_DMA_MODE;
+	ctx->cfg.strength = strength;
+	ctx->cfg.sectors = 1;
+	ctx->cfg.len = step_size;
+
+	ctx->steps = steps;
+	ctx->free_len = mtd->oobsize - 1 - parity_len * steps;
+	ctx->parity_len = parity_len;
+
+	mtd_set_ooblayout(mtd, &mtk_ecc_host_ooblayout);
+	conf->step_size = step_size;
+	conf->strength = strength;
+
+	ctx->buf = dma_alloc_coherent(ecc->dev, step_size + parity_len,
+				      &ctx->buf_dma, GFP_KERNEL);
+	if (!ctx->buf) {
+		ret = -ENOMEM;
+		goto free_ctx;
+	}
+	ret = nand_ecc_init_req_tweaking(&ctx->req_ctx, nand);
+	if (ret)
+		goto free_buf;
+
+	dev_info(ecc->dev, "OOB: free: %u bytes, ECC: %u bytes", ctx->free_len,
+		 ctx->parity_len * ctx->steps);
+	dev_info(ecc->dev, "ECC strength: %d bits per %d bytes\n", strength,
+		 step_size);
+	return 0;
+free_buf:
+	dma_free_coherent(ecc->dev, step_size + parity_len, ctx->buf,
+			  ctx->buf_dma);
+free_ctx:
+	kfree(ctx);
+	return ret;
+}
+
+static void mtk_ecc_host_cleanup_ctx(struct nand_device *nand)
+{
+	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
+	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
+
+	nand_ecc_cleanup_req_tweaking(&ctx->req_ctx);
+	dma_free_coherent(ecc->dev, ctx->cfg.len + ctx->parity_len, ctx->buf,
+			  ctx->buf_dma);
+	kfree(ctx);
+}
+
+static int mtk_ecc_host_prepare_io_req(struct nand_device *nand,
+				       struct nand_page_io_req *req)
+{
+	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
+	int ret, step;
+
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	nand_ecc_tweak_req(&ctx->req_ctx, req);
+
+	if (req->type == NAND_PAGE_READ)
+		return 0;
+
+	ctx->cfg.op = ECC_ENCODE;
+
+	for (step = 0; step < ctx->steps; step++) {
+		ctx->cfg.addr = dma_map_single(
+			ecc->dev, (u8 *)req->databuf.out + step * ctx->cfg.len,
+			ctx->cfg.len, DMA_TO_DEVICE);
+		ret = dma_mapping_error(ecc->dev, ctx->cfg.addr);
+		if (ret) {
+			dev_err(ecc->dev, "DMA mapping failed.\n");
+			return ret;
+		}
+		ret = mtk_ecc_enable(ecc, &ctx->cfg);
+		if (ret) {
+			dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
+					 DMA_TO_DEVICE);
+			return ret;
+		}
+
+		ret = mtk_ecc_wait_done(ecc, ECC_ENCODE);
+		if (ret) {
+			mtk_ecc_disable(ecc);
+			dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
+					 DMA_TO_DEVICE);
+			return ret;
+		}
+
+		mtk_ecc_wait_idle(ecc, ECC_ENCODE);
+		dma_unmap_single(ecc->dev, ctx->cfg.addr, ctx->cfg.len,
+				 DMA_TO_DEVICE);
+		__ioread32_copy(ecc->eccdata,
+				ecc->regs + ecc->caps->ecc_regs[ECC_ENCPAR00],
+				round_up(ctx->parity_len, 4));
+		mtd_ooblayout_set_eccbytes(mtd, ecc->eccdata,
+					   (void *)req->oobbuf.out,
+					   ctx->parity_len * step,
+					   ctx->parity_len);
+		mtk_ecc_disable(ecc);
+	}
+
+	return ret;
+}
+
+static int mtk_ecc_host_finish_io_req(struct nand_device *nand,
+				      struct nand_page_io_req *req)
+{
+	struct mtk_ecc *ecc = nand_to_mtk_ecc(nand);
+	struct mtd_info *mtd = nanddev_to_mtd(nand);
+	struct mtk_ecc_host_ctx *ctx = nand_to_ecc_ctx(nand);
+	u32 bitflips = 0, failed = 0;
+	int ret, step, i;
+	u32 err;
+
+	/* Nothing to do for a raw operation */
+	if (req->mode == MTD_OPS_RAW)
+		return 0;
+
+	/* This engine does not provide BBM/free OOB bytes protection */
+	if (!req->datalen)
+		return 0;
+
+	/* No more preparation for page write */
+	if (req->type == NAND_PAGE_WRITE) {
+		nand_ecc_restore_req(&ctx->req_ctx, req);
+		return 0;
+	}
+
+	ctx->cfg.op = ECC_DECODE;
+	ctx->cfg.addr = ctx->buf_dma;
+
+	for (step = 0; step < ctx->steps; step++) {
+		memcpy(ctx->buf, req->databuf.in + step * ctx->cfg.len,
+		       ctx->cfg.len);
+		mtd_ooblayout_get_eccbytes(mtd, ctx->buf + ctx->cfg.len,
+					   req->oobbuf.in,
+					   ctx->parity_len * step,
+					   ctx->parity_len);
+
+		ret = mtk_ecc_enable(ecc, &ctx->cfg);
+		if (ret)
+			break;
+
+		ret = mtk_ecc_wait_done(ecc, ECC_DECODE);
+		if (ret)
+			break;
+
+		mtk_ecc_wait_idle(ecc, ECC_DECODE);
+
+		memcpy(req->databuf.in + step * ctx->cfg.len, ctx->buf,
+		       ctx->cfg.len);
+		mtd_ooblayout_set_eccbytes(mtd, ctx->buf + ctx->cfg.len,
+					   req->oobbuf.in,
+					   ctx->parity_len * step,
+					   ctx->parity_len);
+		err = readl(ecc->regs + ECC_DECENUM0);
+		err &= ecc->caps->err_mask;
+		if (err == ecc->caps->err_mask) {
+			// skip empty page
+			for (i = 0 ; i < ctx->cfg.len + ctx->parity_len ; i++)
+				if (ctx->buf[i] != 0xff)
+					break;
+
+			if (i != ctx->cfg.len + ctx->parity_len)
+				failed++;
+		} else {
+			mtd->ecc_stats.corrected += err;
+			bitflips = max_t(u32, bitflips, err);
+		}
+
+		mtk_ecc_disable(ecc);
+	}
+
+	nand_ecc_restore_req(&ctx->req_ctx, req);
+	if (ret)
+		return ret;
+	mtd->ecc_stats.failed += failed;
+	return failed ? -EBADMSG : bitflips;
+}
+
+static struct nand_ecc_engine_ops mtk_ecc_engine_ops = {
+	.init_ctx = mtk_ecc_host_init_ctx,
+	.cleanup_ctx = mtk_ecc_host_cleanup_ctx,
+	.prepare_io_req = mtk_ecc_host_prepare_io_req,
+	.finish_io_req = mtk_ecc_host_finish_io_req,
+};
+
 static const struct mtk_ecc_caps mtk_ecc_caps_mt2701 = {
 	.err_mask = 0x3f,
 	.err_shift = 8,
@@ -546,6 +868,11 @@ static int mtk_ecc_probe(struct platform_device *pdev)
 
 	ecc->dev = dev;
 	mutex_init(&ecc->lock);
+	ecc->ecc_eng.dev = dev;
+	ecc->ecc_eng.integration = NAND_ECC_ENGINE_INTEGRATION_EXTERNAL;
+	ecc->ecc_eng.ops = &mtk_ecc_engine_ops;
+
+	nand_ecc_register_on_host_hw_engine(&ecc->ecc_eng);
 	platform_set_drvdata(pdev, ecc);
 	dev_info(dev, "probed\n");
 
-- 
2.35.1

