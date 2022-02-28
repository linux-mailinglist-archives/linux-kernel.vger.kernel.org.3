Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AC4C7070
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbiB1PRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234688AbiB1PQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:16:53 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF77811A2;
        Mon, 28 Feb 2022 07:16:15 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K6kVD4Dksz9sSC;
        Mon, 28 Feb 2022 16:16:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0AcxrXPsdYDS; Mon, 28 Feb 2022 16:16:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K6kVB5rHqz9sSK;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA4818B770;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 63hMoXfIVCKP; Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.66])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E8228B76E;
        Mon, 28 Feb 2022 16:16:02 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21SFFt2i354884
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 28 Feb 2022 16:15:55 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21SFFtoP354883;
        Mon, 28 Feb 2022 16:15:55 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] spi: Add optional number of additional clock cycles to be generated
Date:   Mon, 28 Feb 2022 16:15:45 +0100
Message-Id: <6b6bad3844828c22de3acfb9e7fbac877a48d5a4.1646060734.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646060734.git.christophe.leroy@csgroup.eu>
References: <cover.1646060734.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646061343; l=3225; s=20211009; h=from:subject:message-id; bh=obQ6U01CPn6rN30ENVOTw64zmFRTclLzFL8f6RdDfTo=; b=kg/PJTUvFLbWYhJ4xH82zwkGtgldZMuJfIc/I4rtJ+/MI4mav0il39OLUaG+WVdb9EPMU9gQhgNG cS/61TXTCLnapWWDPU2WZY4mgKU1Vc+yLPlfjsNKADmufAZCS/Rk
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
SPI slaves in order to implement trailing clock of a given number of
bits with ChipSelect off at the end of the transfer.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../devicetree/bindings/spi/spi-peripheral-props.yaml      | 5 +++++
 drivers/spi/spi.c                                          | 7 +++++--
 include/linux/spi/spi.h                                    | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 5dd209206e88..2fd5a5084dbe 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -82,6 +82,11 @@ properties:
     description:
       Delay, in microseconds, after a write transfer.
 
+  spi-trailing-bits:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of clock cycles with chipselect OFF after transfers.
+
 # The controller specific properties go here.
 allOf:
   - $ref: cdns,qspi-nor-peripheral-props.yaml#
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 4599b121d744..2b204fd20337 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2159,6 +2159,9 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
 		}
 	}
 
+	if (!of_property_read_u32(nc, "spi-trailing-bits", &value))
+		spi->trailing_bits = value;
+
 	if (spi_controller_is_slave(ctlr)) {
 		if (!of_node_name_eq(nc, "slave")) {
 			dev_err(&ctlr->dev, "%pOF is not called 'slave'\n",
@@ -3538,14 +3541,14 @@ int spi_setup(struct spi_device *spi)
 
 	trace_spi_setup(spi, status);
 
-	dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
+	dev_dbg(&spi->dev, "setup mode %lu, %s%s%s%s%u bits/w, %u Hz max, %d trailing bits --> %d\n",
 			spi->mode & SPI_MODE_X_MASK,
 			(spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
 			(spi->mode & SPI_LSB_FIRST) ? "lsb, " : "",
 			(spi->mode & SPI_3WIRE) ? "3wire, " : "",
 			(spi->mode & SPI_LOOP) ? "loopback, " : "",
 			spi->bits_per_word, spi->max_speed_hz,
-			status);
+			spi->trailing_bits, status);
 
 	return status;
 }
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 7ab3fed7b804..3f1e3d788f08 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -166,6 +166,7 @@ struct spi_device {
 	u32			max_speed_hz;
 	u8			chip_select;
 	u8			bits_per_word;
+	u8			trailing_bits;
 	bool			rt;
 #define SPI_NO_TX	BIT(31)		/* no transmit wire */
 #define SPI_NO_RX	BIT(30)		/* no receive wire */
-- 
2.34.1

