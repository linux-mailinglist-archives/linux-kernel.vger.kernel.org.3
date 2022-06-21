Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAD5553381
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351420AbiFUNXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351368AbiFUNWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:22:39 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596125FF9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:22:34 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id lpNW2700Q4C55Sk06pNWmX; Tue, 21 Jun 2022 15:22:31 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3dpt-000BW8-Rh; Tue, 21 Jun 2022 15:22:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3dpt-006K0S-Aw; Tue, 21 Jun 2022 15:22:29 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Brad Bishop <bradleyb@fuzziesquirrel.com>,
        Joel Stanley <joel@jms.id.au>,
        Eddie James <eajames@linux.ibm.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] eeprom: at25: Rework buggy read splitting
Date:   Tue, 21 Jun 2022 15:22:26 +0200
Message-Id: <7ae260778d2c08986348ea48ce02ef148100e088.1655817534.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent change to split reads into chunks has several problems:
  1. If an SPI controller has no transfer size limit, max_chunk is
     SIZE_MAX, and num_msgs becomes zero, causing no data to be read
     into the buffer, and exposing the original contents of the buffer
     to userspace,
  2. If the requested read size is not a multiple of the maximum
     transfer size, the last transfer reads too much data, overflowing
     the buffer,
  3. The loop logic differs from the write case.

Fix the above by:
  1. Keeping track of the number of bytes that are still to be
     transferred, instead of precalculating the number of messages and
     keeping track of the number of bytes tranfered,
  2. Calculating the transfer size of each individual message, taking
     into account the number of bytes left,
  3. Switching from a "while"-loop to a "do-while"-loop, and renaming
     "msg_count" to "segment".

While at it, drop the superfluous cast from "unsigned int" to "unsigned
int", also from at25_ee_write(), where it was probably copied from.

Fixes: 0a35780c755ccec0 ("eeprom: at25: Split reads into chunks and cap write size")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on Ebisu-4D with 25LC040 EEPROM.
---
 drivers/misc/eeprom/at25.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index c9c56fd194c1301f..bdffc6543f6f8b7f 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -80,10 +80,9 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	struct at25_data *at25 = priv;
 	char *buf = val;
 	size_t max_chunk = spi_max_transfer_size(at25->spi);
-	size_t num_msgs = DIV_ROUND_UP(count, max_chunk);
-	size_t nr_bytes = 0;
-	unsigned int msg_offset;
-	size_t msg_count;
+	unsigned int msg_offset = offset;
+	size_t bytes_left = count;
+	size_t segment;
 	u8			*cp;
 	ssize_t			status;
 	struct spi_transfer	t[2];
@@ -97,9 +96,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	if (unlikely(!count))
 		return -EINVAL;
 
-	msg_offset = (unsigned int)offset;
-	msg_count = min(count, max_chunk);
-	while (num_msgs) {
+	do {
+		segment = min(bytes_left, max_chunk);
 		cp = at25->command;
 
 		instr = AT25_READ;
@@ -131,8 +129,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
 		t[0].len = at25->addrlen + 1;
 		spi_message_add_tail(&t[0], &m);
 
-		t[1].rx_buf = buf + nr_bytes;
-		t[1].len = msg_count;
+		t[1].rx_buf = buf;
+		t[1].len = segment;
 		spi_message_add_tail(&t[1], &m);
 
 		status = spi_sync(at25->spi, &m);
@@ -142,10 +140,10 @@ static int at25_ee_read(void *priv, unsigned int offset,
 		if (status)
 			return status;
 
-		--num_msgs;
-		msg_offset += msg_count;
-		nr_bytes += msg_count;
-	}
+		msg_offset += segment;
+		buf += segment;
+		bytes_left -= segment;
+	} while (bytes_left > 0);
 
 	dev_dbg(&at25->spi->dev, "read %zu bytes at %d\n",
 		count, offset);
@@ -229,7 +227,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
 	do {
 		unsigned long	timeout, retries;
 		unsigned	segment;
-		unsigned	offset = (unsigned) off;
+		unsigned	offset = off;
 		u8		*cp = bounce;
 		int		sr;
 		u8		instr;
-- 
2.25.1

