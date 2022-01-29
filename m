Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73E84A2B8A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 05:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352328AbiA2EFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 23:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbiA2EFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 23:05:17 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5513C061714;
        Fri, 28 Jan 2022 20:05:17 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id v67so16157713oie.9;
        Fri, 28 Jan 2022 20:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNEO6NZFFUT3tUjdLKmLDb1Z96reNNvzPGOdn0B6DJI=;
        b=igbcMb5GBjQd7Ocj8jzYOARhuDK0cqEXUQqwuz2Tj5+XjnhV886ZIDsGjANjup0ed/
         F0fDaKVGzMfDUis3nWPG88cjJKdzW3E4E1RzOEDYDnymgVWo8QrNu47Og4lMbK+ZaLAC
         ViyKFmYcx+0re8Sj7iY3O+3/D8lCPkfa+HkR/t3lQCrwuggQGIzc+FZfIaLK4gHwpXK/
         lv24B1kZRYOdh021QoHdiRUAL6KferIbKm0cOuGtnBrm8mskLURP67+VqDP41ERaJpt1
         4fvUXyCNDO3rzjMcrYgmztWf7LT2hKeCcHhMVuWuewwnDOlMIb/ibvMuuSDeJ1PUqsv8
         54jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jNEO6NZFFUT3tUjdLKmLDb1Z96reNNvzPGOdn0B6DJI=;
        b=DfU8CLpE02gpLEkvioT3ED+Jcr9QTd4JsePjZorYbI6v84qxUvV7XtlfAMHhzZOj8f
         rAmHaASVFNM4We5JpudZhsOuXF11CmkEfKnpYDkNgXaOjVx8SMndUBz4tV/eeQcUdn17
         hyBnY7Fo7D5GoNIgfNnxbDQrdlX1n3bT5g6dMi6fhJyNm+Gh0IfeviYnQ9SgUfM7GXFs
         MGiWepkEQAuQVzBPBCJGjBy1xBvhtOUmtwvKIfiBR7hlT40Uws31bVELodI1oGdQbVPK
         yJJBOHkd1JGTRtkKw3VMdfEvbhEij/zsbjlErKHZU4+el8iUj34CEFBPbsYfmlcBZrS4
         LFEg==
X-Gm-Message-State: AOAM533tOSx9h6RZuXGapXmTRxrJ1k7jm6X6wInx9y5TeDTJRDTLpsu6
        fTA4MZBFz+2G3U8BwbhMsJVDOPmXvJK+pg==
X-Google-Smtp-Source: ABdhPJwq0INgcVMtR5xe30Ih6oGN40MYwPGxEFDORwAmHPbXnEb7LiVVrL7YOAid95SUdwTnL2kJmQ==
X-Received: by 2002:aca:42c2:: with SMTP id p185mr7417306oia.192.1643429116629;
        Fri, 28 Jan 2022 20:05:16 -0800 (PST)
Received: from tresc043793.tre-sc.gov.br ([187.94.103.218])
        by smtp.gmail.com with ESMTPSA id t21sm4972622oor.4.2022.01.28.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 20:05:15 -0800 (PST)
From:   Luiz Angelo Daros de Luca <luizluca@gmail.com>
To:     linux-spi@vger.kernel.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>
Subject: [PATCH] spi: ath79: add mem_ops for fast-read
Date:   Sat, 29 Jan 2022 01:04:53 -0300
Message-Id: <20220129040453.8476-1-luizluca@gmail.com>
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

