Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D914C706C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:16:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiB1PQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiB1PQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:16:47 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3675C1B;
        Mon, 28 Feb 2022 07:16:04 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K6kVB6QSZz9sSL;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fzavmv33hufI; Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K6kVB5XX2z9sS3;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9CDCA8B773;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id blT9pc0ZQP4q; Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.66])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CB818B763;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21SFFteL354888
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 16:15:55 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21SFFt9J354887;
        Mon, 28 Feb 2022 16:15:55 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] spi: fsl-spi: Implement trailing bits
Date:   Mon, 28 Feb 2022 16:15:46 +0100
Message-Id: <fe4a3946a66ede73f6d6871700f2aaf0171372a1.1646060734.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646060734.git.christophe.leroy@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646061343; l=1346; s=20211009; h=from:subject:message-id; bh=qCaXmMDXzweW6jL3WZK6Vn2roRlk3PB7M8Y/Eji0zEk=; b=41JKsiGTp/F8WyixBoVKFmKHZF87yBY9H3hqz+7s+U4wHyJ6oQODeX+E8/15H9n7+efsbQBjUKZm lyTQf3PfBWcVApZqr1fyGsypfGIl1nJPsCgL32NmzdFbHRr/nez0
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

In order to support IDT 801034 QUAD PCM CODEC, implement
trailing clock for the amount of requested bits.

On fsl SPI, the minimum we can implement is a 4 bits shot.
If the requested number is greated than 8, use 16.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/spi/spi-fsl-spi.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
index bdf94cc7be1a..aefaea439672 100644
--- a/drivers/spi/spi-fsl-spi.c
+++ b/drivers/spi/spi-fsl-spi.c
@@ -424,13 +424,30 @@ static int fsl_spi_do_one_msg(struct spi_master *master,
 		}
 	}
 
-	m->status = status;
-
 	if (status || !cs_change) {
 		ndelay(nsecs);
 		fsl_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 	}
 
+	if (!status && spi->trailing_bits) {
+		struct spi_transfer t = {
+			.len = 1,
+			.tx_buf = empty_zero_page,
+		};
+
+		if (spi->trailing_bits < 4)
+			t.bits_per_word = 4;
+		else if (spi->trailing_bits > 8)
+			t.bits_per_word = 16;
+		else
+			t.bits_per_word = spi->trailing_bits;
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

