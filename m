Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53508598518
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbiHRN6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245485AbiHRN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:58:15 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39D82E3;
        Thu, 18 Aug 2022 06:58:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4M7mgQ0Yqsz9sf4;
        Thu, 18 Aug 2022 15:58:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Mh1iG2BKyRO9; Thu, 18 Aug 2022 15:58:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4M7mgP6sZWz9sdy;
        Thu, 18 Aug 2022 15:58:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DC8B78B767;
        Thu, 18 Aug 2022 15:58:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LlPoFkLgpU30; Thu, 18 Aug 2022 15:58:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.235.236])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D11C8B763;
        Thu, 18 Aug 2022 15:58:09 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27IDw0Vu1993063
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 15:58:00 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27IDw09J1993060;
        Thu, 18 Aug 2022 15:58:00 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: [PATCH v3] spi: Add capability to perform some transfer with chipselect off
Date:   Thu, 18 Aug 2022 15:57:49 +0200
Message-Id: <fabbc87627e5ddc2c913b368ae99386668d8dcfb.1660830866.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660831067; l=3497; s=20211009; h=from:subject:message-id; bh=pBEp2sV1HSEbreVLmDNueVNSIkEvPWM2zi6OQ+L8A3M=; b=ruZBrXja6jNd1n+ZvqAsoBgHCZ9iAZPljuFSoWxEqAaOztZftEi4UMQVPPKMcs+KQxOnaWQ/yslv 5ExyNtw1AaL2/5vYPGW7ZLIbVNRNFIBeTu9RkgKriygiTi0QfmlV
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
This is a change in the approach. Now we offer the driver/consumer a way to perform an additional transfer with chipselect off.

v2 is at https://patchwork.kernel.org/project/spi-devel-general/list/?series=618784&state=*&archive=both

 drivers/spi/spi.c       | 12 +++++++++---
 include/linux/spi/spi.h |  2 ++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 2a472dcf081e..ca71723d44a7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1418,7 +1418,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 	struct spi_statistics *statm = &ctlr->statistics;
 	struct spi_statistics *stats = &msg->spi->statistics;
 
-	spi_set_cs(msg->spi, true, false);
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	spi_set_cs(msg->spi, !xfer->cs_off, false);
 
 	SPI_STATISTICS_INCREMENT_FIELD(statm, messages);
 	SPI_STATISTICS_INCREMENT_FIELD(stats, messages);
@@ -1486,10 +1487,15 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
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
index 7ab3fed7b804..cbb787f6b9ff 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -818,6 +818,7 @@ struct spi_res {
  *      for this transfer. If 0 the default (from @spi_device) is used.
  * @dummy_data: indicates transfer is dummy bytes transfer.
  * @cs_change: affects chipselect after this transfer completes
+ * @cs_off: performs the transfer with chipselect off.
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
  * @delay: delay to be introduced after this transfer before
@@ -930,6 +931,7 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:3;
 	unsigned	rx_nbits:3;
+	unsigned	cs_off:1;
 #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
-- 
2.37.1

