Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0D47CCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbhLVGHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:07:53 -0500
Received: from mail1.kuutio.org ([54.37.79.207]:41812 "EHLO mail1.kuutio.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230383AbhLVGHu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:07:50 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Dec 2021 01:07:50 EST
Received: from localhost (localhost [127.0.0.1])
        by mail1.kuutio.org (Postfix) with ESMTP id 3345B1FD6F;
        Wed, 22 Dec 2021 07:00:13 +0100 (CET)
Authentication-Results: mail1.kuutio.org (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=lemmela.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lemmela.net; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:date:subject:subject:from:from
        :received:received; s=dkim; t=1640152810; x=1642744811; bh=xUgpP
        ol+J/D01YMKJk7xdnyh/EKXctA1f/i5dPqKCDs=; b=PU73Tc5zX1XAWhfaqY6cQ
        tydHxlioF+UnhHG2xF0xrnsks8LdRcr/F6zMc1C+9FO4YdkELflP8d5iVdqKKl+0
        M7NzvJiodkxm/hjPaCAsErC9ZhRynGEBQrRPvOBjeskX/u73LYkb1cV9dzB0lB7h
        Fy5QzmQxiCproyieIKPkTzPel3XV0T6Xk5EjMZtjwVBaW2awOxUBTUF8PIWuPj/l
        /yHwBWaIn5Rdfq+ABh+4+OYFJmAdxOwvbqFYmwITlsF74uNSoQqV4fB8QHgbn2sb
        Pd7v4QGYVfLBqpq34bm1N0jgbGNDf5gpQkubhy/8irA/Z6Of7ZMa8qeP+qodmulO
        rU41Atvdhlqz8aEshT/lm6L6euOK4iq1MXO1bj/3l7mUlySmAc4PFQy1P+wYtujC
        glTtsGtLOnEadQdssCFKdF88oUYngQLsxKomo0a/9d7fJkikdyyfVadCdDTEdBEo
        NGblTAQZmvNic2BRBxgKv4LUCLCaAPXI2saVTp8YZhvQHJuf07FIfSK/bOzT9vaq
        AGyQ6EWw/ZNLd4spZeAQndos1nWGoMGYDbL0jXiZURXfSVH+oIHD6IkI16vnWuS3
        jf7IyidMAsoz0TT9Gx1HDFZkK/CBtW4bDA/1f7YQp7Mq4AH1cy7Hk9H1/WbJpAk+
        suaxKLO0cCm+mRuABV7FEI=
X-Virus-Scanned: amavisd-new at kuutio.org
Received: from mail1.kuutio.org ([127.0.0.1])
        by localhost (mail1.kuutio.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id HbmWohE7PNsa; Wed, 22 Dec 2021 07:00:10 +0100 (CET)
Received: from build.kuutio.org (unknown [IPv6:2001:998:13:e4::69])
        by mail1.kuutio.org (Postfix) with ESMTPSA id 977111FE00;
        Wed, 22 Dec 2021 07:00:10 +0100 (CET)
From:   Oskari Lemmela <oskari@lemmela.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oskari Lemmela <oskari@lemmela.net>
Subject: [PATCH 1/2] spi: ar934x: fix transfer size
Date:   Wed, 22 Dec 2021 07:59:57 +0200
Message-Id: <20211222055958.1383233-2-oskari@lemmela.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211222055958.1383233-1-oskari@lemmela.net>
References: <20211222055958.1383233-1-oskari@lemmela.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bits_per_word is configured, transfer only word amount
of data per iteration.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 drivers/spi/spi-ar934x.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-ar934x.c b/drivers/spi/spi-ar934x.c
index def32e0aaefe..a2cf37aca234 100644
--- a/drivers/spi/spi-ar934x.c
+++ b/drivers/spi/spi-ar934x.c
@@ -82,7 +82,7 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 	struct spi_device *spi = m->spi;
 	unsigned long trx_done, trx_cur;
 	int stat = 0;
-	u8 term = 0;
+	u8 bpw, term = 0;
 	int div, i;
 	u32 reg;
 	const u8 *tx_buf;
@@ -90,6 +90,11 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 
 	m->actual_length = 0;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (t->bits_per_word >= 8 && t->bits_per_word < 32)
+			bpw = t->bits_per_word >> 3;
+		else
+			bpw = 4;
+
 		if (t->speed_hz)
 			div = ar934x_spi_clk_div(sp, t->speed_hz);
 		else
@@ -105,10 +110,10 @@ static int ar934x_spi_transfer_one_message(struct spi_controller *master,
 		iowrite32(reg, sp->base + AR934X_SPI_REG_CTRL);
 		iowrite32(0, sp->base + AR934X_SPI_DATAOUT);
 
-		for (trx_done = 0; trx_done < t->len; trx_done += 4) {
+		for (trx_done = 0; trx_done < t->len; trx_done += bpw) {
 			trx_cur = t->len - trx_done;
-			if (trx_cur > 4)
-				trx_cur = 4;
+			if (trx_cur > bpw)
+				trx_cur = bpw;
 			else if (list_is_last(&t->transfer_list, &m->transfers))
 				term = 1;
 
@@ -191,7 +196,8 @@ static int ar934x_spi_probe(struct platform_device *pdev)
 	ctlr->mode_bits = SPI_LSB_FIRST;
 	ctlr->setup = ar934x_spi_setup;
 	ctlr->transfer_one_message = ar934x_spi_transfer_one_message;
-	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(24) |
+				   SPI_BPW_MASK(16) | SPI_BPW_MASK(8);
 	ctlr->dev.of_node = pdev->dev.of_node;
 	ctlr->num_chipselect = 3;
 
-- 
2.25.1

