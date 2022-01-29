Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98ACB4A2B7C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 04:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352311AbiA2Dlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 22:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345056AbiA2Dla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 22:41:30 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C65C061714;
        Fri, 28 Jan 2022 19:41:27 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id f6so5408864vsa.5;
        Fri, 28 Jan 2022 19:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNEO6NZFFUT3tUjdLKmLDb1Z96reNNvzPGOdn0B6DJI=;
        b=qd/JZvkmKz1WVQkQZZs9sGYcx6VIp+pQ5G9ObGdypVIRkx9CEMXcdtwZ72f3ftegB9
         /Ty5wTQt+DbMgalX9kgtRSul38hIxjbOmPmYNWHiywBs1S7VdAg1M5UO9I+4XjZvAurk
         kMx8jtedW90K2PeDugTuXBdWw338Z8KfY0gjkSmaQgPHV86H+sdQPHE55cZk/2gBsO+N
         Be8WQkImpmLJwcqtMl1SlMNAkbwO7yvqQLOqJEmg5kluzipzVD+kH4WG938e5jCw5nKq
         wUhMhdKg1U0G3gk05fZZz/CycfcGUEqm/iFNkzCELhA6JSewH1tx5glqJyeBF0fZHiEA
         8n/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNEO6NZFFUT3tUjdLKmLDb1Z96reNNvzPGOdn0B6DJI=;
        b=Z+7tRZK+6jS2kBLOu8EB3+wBVpyaisZ4GYFAr1ov2lf6EMNgXzh4r7c7gZOxdMwWVZ
         anMXVGyJePWRmNusu4Nq7IPCmymY6XFbo8vtszpSEXSo4wRqytGdeIUoibQH+hb/+vp3
         yv8XUSLUWH8qGvR+vfxAjpSDlAlRcYBd3RmJ9HoSVbm0IAnQmO0/A5aXTa3hhcp0Jh8h
         tSyM+dgoPE3ZIF+lqX2Ce/fEZ0T5CpWTfHh9POi2SBpymu7v3VEI5VGIjRA1tmPQ2rjp
         Ys5hWLkzhETFXaop5u2bqipurQqX6DtZchKg9b1czCoIIF/A/5TRh9VX9mx49P1wNjUN
         5iKw==
X-Gm-Message-State: AOAM533Ja8UZRYyV1rIEJAp1SkP8XhwBapbUSA8WdXg1gon9Czrvzzsx
        q5CjVe/Hj5cfphmJ0clhl4ew6FAWcsoU0g==
X-Google-Smtp-Source: ABdhPJymTuo7GVSCGQb5UXk9Xj1nYER7T+2JPW0EoGvWY4W/sFewsQamZXBA1yEDljuQODCbcIvLvg==
X-Received: by 2002:a67:ee4b:: with SMTP id g11mr5251153vsp.32.1643427686238;
        Fri, 28 Jan 2022 19:41:26 -0800 (PST)
Received: from tresc043793.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id b191sm2013261vkb.32.2022.01.28.19.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 19:41:25 -0800 (PST)
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH net-next] spi: ath79: add mem_ops for fast-read
Date:   Sat, 29 Jan 2022 00:40:47 -0300
Message-Id: <20220129034047.12555-1-luizluca@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reading from memory is 3x faster than bit-bang read operation. Also,
for tl-wr2543nd, the bit-bang read was sporadically returning random
data, possibly a HW defect, while fast-read works as expected.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/spi/spi-ath79.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index d1e287d2d9cd..607e7a49fb89 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
 #include <linux/spi/spi_bitbang.h>
 #include <linux/bitops.h>
 #include <linux/clk.h>
@@ -133,6 +134,38 @@ static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 	return ath79_spi_rr(sp, AR71XX_SPI_REG_RDS);
 }
 
+static int ath79_exec_mem_op(struct spi_mem *mem,
+			     const struct spi_mem_op *op)
+{
+	struct ath79_spi *sp = ath79_spidev_to_sp(mem->spi);
+
+	/* Ensures that reading is performed on device connected to hardware cs0 */
+	if (mem->spi->chip_select || mem->spi->cs_gpiod)
+		return -ENOTSUPP;
+
+	/* Only use for fast-read op. */
+	if (op->cmd.opcode != 0x0b || op->data.dir != SPI_MEM_DATA_IN ||
+	    op->addr.nbytes != 3 || op->dummy.nbytes != 1)
+		return -ENOTSUPP;
+
+	/* disable GPIO mode */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, 0);
+
+	memcpy_fromio(op->data.buf.in, sp->base + op->addr.val, op->data.nbytes);
+
+	/* enable GPIO mode */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_FS, AR71XX_SPI_FS_GPIO);
+
+	/* restore IOC register */
+	ath79_spi_wr(sp, AR71XX_SPI_REG_IOC, sp->ioc_base);
+
+	return 0;
+}
+
+static const struct spi_controller_mem_ops ath79_mem_ops = {
+	.exec_op = ath79_exec_mem_op,
+};
+
 static int ath79_spi_probe(struct platform_device *pdev)
 {
 	struct spi_master *master;
@@ -154,6 +187,7 @@ static int ath79_spi_probe(struct platform_device *pdev)
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
 	master->flags = SPI_MASTER_GPIO_SS;
 	master->num_chipselect = 3;
+	master->mem_ops = &ath79_mem_ops;
 
 	sp->bitbang.master = master;
 	sp->bitbang.chipselect = ath79_spi_chipselect;
-- 
2.34.1

