Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07324C5A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiB0KBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiB0KBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:01:39 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1B75B898;
        Sun, 27 Feb 2022 02:01:03 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K5zY44n28z9sSG;
        Sun, 27 Feb 2022 11:00:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jcT6yo0T7hlH; Sun, 27 Feb 2022 11:00:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K5zY25gj6z9sSf;
        Sun, 27 Feb 2022 11:00:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DEA6B8B774;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XCJvHrToxK_C; Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.62])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9B70A8B76E;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21RA0kvx262875
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 11:00:46 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21RA0kI3262874;
        Sun, 27 Feb 2022 11:00:46 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] spi: fsl-spi: Implement trailing clock mode
Date:   Sun, 27 Feb 2022 11:00:35 +0100
Message-Id: <f66ae24b31f10f7c3a999a77a6cfab7b2d073c6a.1645950971.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645950971.git.christophe.leroy@csgroup.eu>
References: <cover.1645950971.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645956034; l=1641; s=20211009; h=from:subject:message-id; bh=+/edlFsipl1R0bA5PHoJ/lea+KiQ9syUn/TTp9M1b1Y=; b=Pkged1be6SnqRV4Kv1E8B7mE0+6VpfL/P2ti9pyN5c9goG1XAy5+eB1ruUfz9J96BQlB94rE8TWf beWCdbvLAVWGoC1kFFrkyaFRRU8PLMBEUkDxTVt24FuiygFOaxmf
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support IDT 801034 QUAD PCM CODEC, implement the
trailing clock mode.

On fsl SPI, the minimum we can implement is a 4 bits shot.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-lib.c |  2 +-
 drivers/spi/spi-fsl-spi.c | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lib.c b/drivers/spi/spi-fsl-lib.c
index 76e1192eb025..a13f3b4db55f 100644
--- a/drivers/spi/spi-fsl-lib.c
+++ b/drivers/spi/spi-fsl-lib.c
@@ -88,7 +88,7 @@ void mpc8xxx_spi_probe(struct device *dev, struct resource *mem,
 
 	/* the spi->mode bits understood by this driver: */
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH
-			| SPI_LSB_FIRST | SPI_LOOP;
+			| SPI_LSB_FIRST | SPI_LOOP | SPI_TRAILING;
 
 	master->dev.of_node = dev->of_node;
 
diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1a..6a52955d9051 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -424,13 +424,24 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 	}
 
-	m->status = status;
-
 	if (status || !cs_change) {
 		ndelay(nsecs);
 		fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 	}
 
+	if (!status && spi->mode & SPI_TRAILING) {
+		struct spi_transfer t = {
+			.len = 1,
+			.tx_buf = "",
+			.bits_per_word = 4
+		};
+
+		status = fsl_spi_setup_transfer(spi, &t);
+		if (!status)
+			status = fsl_spi_bufs(spi, &t, 0);
+	}
+	m->status = status;
+
 	fsl_spi_setup_transfer(spi, NULL);
 	spi_finalize_current_message(master);
 	return 0;
-- 
2.34.1

