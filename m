Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC6A588185
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 20:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiHBSAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 14:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiHBR71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 13:59:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B465F5005A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 10:59:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z16so18752416wrh.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgBNPFA6iH7qw2lvPfZZWo2zsFGuQgHM3NShlMf43pY=;
        b=PF6fBnKlQ88A9aTw15wV58rFsRu/CLh/WhHzPYx/W3mpot5tutkCFEV2KkEEweaKqi
         ZMdSlXszL6AV+LTJWr+A5j5c3xEhliVkvKrOkPwqMoH+dR4I0cY4XnT/2MrKuvE3QAdE
         JTMqFuCcuO2RR+lraL6es3E1oqaa6FQyibyfHy1mZlOflz7eaKjem3HZkR1SUqBe2x5B
         otpaJtQqp/5F0xv2A6zFs9659cBYzAnpxF83u+f0nbHfo1Gf2z9z4TqTkYCJR2Yfnir+
         y315Prw9EJAwO1lRVfbmJds8Hxxts6cIoOR/w2dcCLDE1PwLI8Z2FpC6DsXqvWIy7+iC
         34LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgBNPFA6iH7qw2lvPfZZWo2zsFGuQgHM3NShlMf43pY=;
        b=QWT0GDFFKpWd2jYsKF14XZG4GqFgXUivoTaNFavr0vwhB9N6WRpme1NQkimlZP/Eno
         VkIinxGTFfFW6Y0duDNIHhUdlFLNQhjtDTpDUkoliKvcBEevMIy8K1Jtxutm/THg5sY2
         tuJwKmEbKTy6qXdVjdYRn/8CgTL675JbVB+9tlckPw7SgC+dvpqXFER134D+Qqw+3/q8
         hFCcNzZj+eg3U/QdS7SVWNO/1/rZ3uz8nXmlljrT95WLf5A1cXLvj8syN74zgyB9SB//
         gtSlnDaDvYXgt0HMKvHJAhgJbQyH3KJbPrfJoL8MCvxt2PPE6ximi4SzzA1CB/vr0AUO
         MWrA==
X-Gm-Message-State: ACgBeo1EsYrJSGDtdZiIPmLH1brjVgC6RLZJh3mX/YG2Z6aNc0pgbIws
        1vR6WaKNDP18T1b4ThKlP1cZ8Q==
X-Google-Smtp-Source: AA6agR4+Xe7fQqjK1UteZlARwyFQQy84pkaf8BFmW88PyIz3BjbwgCCLs+QpO1C+QFvSgB9IjCv0Lg==
X-Received: by 2002:adf:ebc5:0:b0:21d:640e:dc2f with SMTP id v5-20020adfebc5000000b0021d640edc2fmr13819804wrn.227.1659463160197;
        Tue, 02 Aug 2022 10:59:20 -0700 (PDT)
Received: from debian.office.codethink.co.uk ([2405:201:8005:8149:e5c9:c0ac:4d82:e94b])
        by smtp.gmail.com with ESMTPSA id 9-20020a05600c020900b003a3187a2d4csm23318222wmi.22.2022.08.02.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 10:59:19 -0700 (PDT)
From:   Sudip Mukherjee <sudip.mukherjee@sifive.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     greentime.hu@sifive.com, jude.onyenegecha@sifive.com,
        william.salmon@sifive.com, adnan.chowdhury@sifive.com,
        ben.dooks@sifive.com, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jeegar.lakhani@sifive.com,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Subject: [PATCH 09/11] spi: dw: prepare the transfer routine for enhanced mode
Date:   Tue,  2 Aug 2022 18:57:53 +0100
Message-Id: <20220802175755.6530-10-sudip.mukherjee@sifive.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
References: <20220802175755.6530-1-sudip.mukherjee@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The transfer routine of dual/quad/octal is similar to standard SPI mode
except that we do not need to worry about CS being de-asserted and we
will be writing the address to a single FIFO location.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@sifive.com>
---
 drivers/spi/spi-dw-core.c | 141 +++++++++++++++++++++++++++++++++-----
 1 file changed, 125 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
index 2564a2276572..d6afa75e7023 100644
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -712,6 +712,28 @@ static int dw_spi_wait_mem_op_done(struct dw_spi *dws)
 	return 0;
 }
 
+static void ext_transfer_delay(struct dw_spi *dws)
+{
+	struct spi_delay delay;
+	unsigned long ns, us;
+	u32 nents;
+
+	nents = dw_readl(dws, DW_SPI_TXFLR);
+	ns = NSEC_PER_SEC / dws->current_freq * nents;
+	ns *= dws->n_bytes * BITS_PER_BYTE;
+	if (ns <= NSEC_PER_USEC) {
+		delay.unit = SPI_DELAY_UNIT_NSECS;
+		delay.value = ns;
+	} else {
+		us = DIV_ROUND_UP(ns, NSEC_PER_USEC);
+		delay.unit = SPI_DELAY_UNIT_USECS;
+		delay.value = clamp_val(us, 0, USHRT_MAX);
+	}
+	/* wait until there is some space in TX FIFO */
+	while (!(dw_readl(dws, DW_SPI_SR) & DW_SPI_SR_TF_NOT_FULL))
+		spi_delay_exec(&delay, NULL);
+}
+
 static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 {
 	dw_spi_enable_chip(dws, 0);
@@ -719,6 +741,82 @@ static void dw_spi_stop_mem_op(struct dw_spi *dws, struct spi_device *spi)
 	dw_spi_enable_chip(dws, 1);
 }
 
+static int enhanced_transfer(struct dw_spi *dws, struct spi_device *spi,
+			     const struct spi_mem_op *op)
+{
+	u32 max, txw = 0, rxw;
+	bool cs_done = false;
+	void *buf = dws->tx;
+	int ret;
+
+	/* Send cmd as 32 bit value */
+	if (buf) {
+		txw = *(u32 *)(buf);
+		dw_write_io_reg(dws, DW_SPI_DR, txw);
+		buf += 4;
+		dws->tx_len--;
+		if (op->addr.nbytes) {
+			/*
+			 * Send address as 32 bit value if address
+			 * is present in the instruction.
+			 */
+			txw = *(u32 *)(buf);
+			dw_write_io_reg(dws, DW_SPI_DR, txw);
+			buf += 4;
+			dws->tx_len--;
+		}
+	}
+
+	do {
+		max = min_t(u32, dws->tx_len, dws->fifo_len -
+			    dw_readl(dws, DW_SPI_TXFLR));
+		while (max--) {
+			if (buf) {
+				txw = *(u8 *)(buf);
+				buf += dws->n_bytes;
+			}
+			dw_write_io_reg(dws, DW_SPI_DR, txw);
+			--dws->tx_len;
+		}
+		/* Enable CS after filling up FIFO */
+		if (!cs_done) {
+			dw_spi_set_cs(spi, false);
+			cs_done = true;
+		}
+		ext_transfer_delay(dws);
+		if (!dws->tx_len && !dws->rx_len) {
+			/*
+			 * We only need to wait for done if there is
+			 * nothing to receive and there is nothing more
+			 * to transmit. If we are receiving, then the
+			 * wait cycles will make sure we wait.
+			 */
+			ret = dw_spi_wait_mem_op_done(dws);
+			if (ret)
+				return ret;
+		}
+	} while (dws->tx_len);
+
+	buf = dws->rx;
+	while (dws->rx_len) {
+		max = dw_spi_rx_max(dws);
+
+		while (max--) {
+			rxw = dw_read_io_reg(dws, DW_SPI_DR);
+			if (buf) {
+				*(u8 *)(buf) = rxw;
+				buf += dws->n_bytes;
+			}
+			--dws->rx_len;
+		}
+
+		ret = dw_spi_check_status(dws, true);
+		if (ret)
+			return ret;
+	}
+	return 0;
+}
+
 static void update_spi_ctrl0(struct dw_spi *dws, const struct spi_mem_op *op, bool enable)
 {
 	u32 spi_ctrlr0;
@@ -846,25 +944,36 @@ static int dw_spi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	 * manually restricting the SPI bus frequency using the
 	 * dws->max_mem_freq parameter.
 	 */
-	local_irq_save(flags);
-	preempt_disable();
+	if (!enhanced_spi) {
+		local_irq_save(flags);
+		preempt_disable();
 
-	ret = dw_spi_write_then_read(dws, mem->spi);
+		ret = dw_spi_write_then_read(dws, mem->spi);
 
-	local_irq_restore(flags);
-	preempt_enable();
+		local_irq_restore(flags);
+		preempt_enable();
 
-	/*
-	 * Wait for the operation being finished and check the controller
-	 * status only if there hasn't been any run-time error detected. In the
-	 * former case it's just pointless. In the later one to prevent an
-	 * additional error message printing since any hw error flag being set
-	 * would be due to an error detected on the data transfer.
-	 */
-	if (!ret) {
-		ret = dw_spi_wait_mem_op_done(dws);
-		if (!ret)
-			ret = dw_spi_check_status(dws, true);
+		/*
+		 * Wait for the operation being finished and check the
+		 * controller status only if there hasn't been any
+		 * run-time error detected. In the former case it's
+		 * just pointless. In the later one to prevent an
+		 * additional error message printing since any hw error
+		 * flag being set would be due to an error detected on
+		 * the data transfer.
+		 */
+		if (!ret) {
+			ret = dw_spi_wait_mem_op_done(dws);
+			if (!ret)
+				ret = dw_spi_check_status(dws, true);
+		}
+	} else {
+		/*
+		 * We donot need to disable IRQs as clock stretching will
+		 * be enabled in enhanced mode which will prevent CS
+		 * from being de-assert.
+		 */
+		ret = enhanced_transfer(dws, mem->spi, op);
 	}
 
 	dw_spi_stop_mem_op(dws, mem->spi);
-- 
2.30.2

