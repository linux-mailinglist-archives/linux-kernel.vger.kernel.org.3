Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16445B0636
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 16:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIGOOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 10:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiIGOON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 10:14:13 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAA365644;
        Wed,  7 Sep 2022 07:14:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MN44f2t8Pz9sk7;
        Wed,  7 Sep 2022 16:14:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QizXyr0QWWIB; Wed,  7 Sep 2022 16:14:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MN44f1kt3z9sk5;
        Wed,  7 Sep 2022 16:14:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CC5D8B78B;
        Wed,  7 Sep 2022 16:14:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pAVmOfMFge_0; Wed,  7 Sep 2022 16:14:10 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0EC38B763;
        Wed,  7 Sep 2022 16:14:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 287EDuVA3203820
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 7 Sep 2022 16:13:56 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 287EDtKE3203817;
        Wed, 7 Sep 2022 16:13:55 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3 REBASED] spi: Add capability to perform some transfer with chipselect off
Date:   Wed,  7 Sep 2022 16:13:44 +0200
Message-Id: <434165c46f06d802690208a11e7ea2500e8da4c7.1662558898.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662560022; l=3320; s=20211009; h=from:subject:message-id; bh=nhEy38PTRF9ranS0NmdK0DMBPj0AbmzHk2k5M/5fx/Y=; b=c4eyahKivpthECdpPNVAd307Quru5kBXew3d5nU0poRbIqQeC3YMw6g4ziyJX2HuT47CGyosUPjm hZTtBw+4Bk2dRDguVQvk/sJHTI0TgyMr+HdL4bYvFdSuZzEyXbQ1
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
terminate the SPI transfer.

In order to use that kind of component, add a cs_off flag to
spi_transfer struct. When this flag is set, the transfer is performed
with chipselect off. This allows consummer to add a dummy transfer
at the end of the transfer list which is performed with chipselect
OFF, providing the required additional clock cycles.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
Rebased on today's linus' master

 drivers/spi/spi.c       | 12 +++++++++---
 include/linux/spi/spi.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 83da8862b8f2..cc5cb948978e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1435,7 +1435,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_statistics __percpu *statm = ctlr->pcpu_statistics;
 	struct spi_statistics __percpu *stats = msg->spi->pcpu_statistics;
 
-	spi_set_cs(msg->spi, true, false);
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	spi_set_cs(msg->spi, !xfer->cs_off, false);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
@@ -1503,10 +1504,15 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 					 &msg->transfers)) {
 				keep_cs = true;
 			} else {
-				spi_set_cs(msg->spi, false, false);
+				if (!xfer->cs_off)
+					spi_set_cs(msg->spi, false, false);
 				_spi_transfer_cs_change_delay(msg, xfer);
-				spi_set_cs(msg->spi, true, false);
+				if (!list_next_entry(xfer, transfer_list)->cs_off)
+					spi_set_cs(msg->spi, true, false);
 			}
+		} else if (!list_is_last(&xfer->transfer_list, &msg->transfers) &&
+			   xfer->cs_off != list_next_entry(xfer, transfer_list)->cs_off) {
+			spi_set_cs(msg->spi, xfer->cs_off, false);
 		}
 
 		msg->actual_length += xfer->len;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index e6c73d5ff1a8..6e6c62c59957 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -847,6 +847,7 @@ struct spi_res {
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @dummy_data: indicates transfer is dummy bytes transfer.
  * @cs_change: affects chipselect after this transfer completes
+ * @cs_off: performs the transfer with chipselect off.
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
  * @delay: delay to be introduced after this transfer before
@@ -959,6 +960,7 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
+	unsigned	cs_off:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-- 
2.37.1

