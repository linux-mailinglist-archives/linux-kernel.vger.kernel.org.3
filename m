Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01814C5A60
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiB0KCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 05:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiB0KBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 05:01:43 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5FE5B8AA;
        Sun, 27 Feb 2022 02:01:06 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K5zY51grbz9sSf;
        Sun, 27 Feb 2022 11:00:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id t_JPdnIHkgKu; Sun, 27 Feb 2022 11:00:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K5zY25c6pz9sSN;
        Sun, 27 Feb 2022 11:00:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E960F8B763;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id W5oqlttZPhHn; Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.62])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9C6348B770;
        Sun, 27 Feb 2022 11:00:53 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21RA0kq1262871
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 27 Feb 2022 11:00:46 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21RA0jEV262870;
        Sun, 27 Feb 2022 11:00:45 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 1/2] spi: Add new mode to generate additional clock cycles
Date:   Sun, 27 Feb 2022 11:00:34 +0100
Message-Id: <2bbe791f1c2b3c809c8863020184cdcfdadd1510.1645950971.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1645950971.git.christophe.leroy@csgroup.eu>
References: <cover.1645950971.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645956034; l=3649; s=20211009; h=from:subject:message-id; bh=UpeHInRYCMHgzsyoIq8kRNojKZE72iMXwQWDi6TVlqk=; b=i7tLSbR8+v/1DDEB7oHUwrjhbyyYwOlVlN7xPMNsiAn38Kos0bN0rLigbxvlYhudGKbSnVcnTJZ/ 88DH2DlGBtaT8bSNK2VYgRFBbbqRak9QIi4/ffocP1++9xXPfk11
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

Some components require a few clock cycles with chipselect off before
or/and after the data transfer done with CS on.

Typically IDT 801034 QUAD PCM CODEC datasheet states "Note *: CCLK
should have one cycle before CS goes low, and two cycles after
CS goes high".

The cycles "before" are implicitely provided by all previous activity
on the SPI bus. But the cycles "after" must be provided in order to
achieve the SPI transfer.

In order to use that kind of component, implement a new option for
SPI slaves in order to implement a trailing clock of a few bits
with ChipSelect off at the end of the transfer.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 4 ++++
 drivers/spi/spi.c                                            | 5 ++++-
 include/uapi/linux/spi/spi.h                                 | 3 ++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..4e4fc357d667 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -82,6 +82,10 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-trailing-clock:
+    description:
+      Add a few clock cycles (minimum 2) with chipselect OFF after transfers.
+
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..1b943e112751 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2109,6 +2109,8 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		spi->mode |= SPI_LSB_FIRST;
 	if (of_property_read_bool(nc, "spi-cs-high"))
 		spi->mode |= SPI_CS_HIGH;
+	if (of_property_read_bool(nc, "spi-trailing-clock"))
+		spi->mode |= SPI_TRAILING;
 
 	/* Device DUAL/QUAD mode */
 	if (!of_property_read_u32(nc, "spi-tx-bus-width", &value)) {
@@ -3538,12 +3540,13 @@ int spi_setup(struct spi_device *spi)
 
 	trace_spi_setup(spi, status);
 
-	dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
+	dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%s%u bits/w, %u Hz max --> %d\n",
 			spi->mode & SPI_MODE_X_MASK,
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
 			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
 			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
 			(spi->mode & SPI_LOOP) ? "loopback, " : "",
+			(spi->mode & SPI_TRAILING) ? "trailing clock, " : "",
 			spi->bits_per_word, spi->max_speed_hz,
 			status);
 
diff --git a/include/uapi/linux/spi/spi.h b/include/uapi/linux/spi/spi.h
index 236a85f08ded..0933a619a154 100644
--- a/include/uapi/linux/spi/spi.h
+++ b/include/uapi/linux/spi/spi.h
@@ -27,6 +27,7 @@
 #define	SPI_TX_OCTAL		_BITUL(13)	/* transmit with 8 wires */
 #define	SPI_RX_OCTAL		_BITUL(14)	/* receive with 8 wires */
 #define	SPI_3WIRE_HIZ		_BITUL(15)	/* high impedance turnaround */
+#define	SPI_TRAILING		_BITUL(16)	/* trailing clock needed */
 
 /*
  * All the bits defined above should be covered by SPI_MODE_USER_MASK.
@@ -36,6 +37,6 @@
  * These bits must not overlap. A static assert check should make sure of that.
  * If adding extra bits, make sure to increase the bit index below as well.
  */
-#define SPI_MODE_USER_MASK	(_BITUL(16) - 1)
+#define SPI_MODE_USER_MASK	(_BITUL(17) - 1)
 
 #endif /* _UAPI_SPI_H */
-- 
2.34.1

