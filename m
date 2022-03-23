Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253C4E50B1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiCWKxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiCWKxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:53:48 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A0978062
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:52:16 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KNlYC3M12z9sT8;
        Wed, 23 Mar 2022 11:52:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xER-xrdBWTjF; Wed, 23 Mar 2022 11:52:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KNlYC29z4z9sSy;
        Wed, 23 Mar 2022 11:52:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3067E8B778;
        Wed, 23 Mar 2022 11:52:15 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id HaJEOvKQQll7; Wed, 23 Mar 2022 11:52:15 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.48])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA0E38B763;
        Wed, 23 Mar 2022 11:52:14 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22NAq4IH1676666
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 11:52:04 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22NAq4bf1676665;
        Wed, 23 Mar 2022 11:52:04 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] eeprom: at25: Use DMA safe buffers
Date:   Wed, 23 Mar 2022 11:51:55 +0100
Message-Id: <230a9486fc68ea0182df46255e42a51099403642.1648032613.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648032713; l=5526; s=20211009; h=from:subject:message-id; bh=MpJsPgmdCRLnd0AzCRSbFm+kd2Qi96r+ilJ3rZU3mJI=; b=ofooqpzGkbv29ONj3870f3fcvEUEvRdsqb7Yh6zDm2oNnh9hCbVNKXE1pLPqnWP+ljlYXJTerM5j HhQ1vdeaBrkgdGC7EFUoEZzVc6ieaT8mX0P80tlV2D5YGoEQs+MN
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

Reading EEPROM fails with following warning:

[   16.357496] ------------[ cut here ]------------
[   16.357529] fsl_spi b01004c0.spi: rejecting DMA map of vmalloc memory
[   16.357698] WARNING: CPU: 0 PID: 371 at include/linux/dma-mapping.h:326 fsl_spi_cpm_bufs+0x2a0/0x2d8
[   16.357775] CPU: 0 PID: 371 Comm: od Not tainted 5.16.11-s3k-dev-01743-g19beecbfe9d6-dirty #109
[   16.357806] NIP:  c03fbc9c LR: c03fbc9c CTR: 00000000
[   16.357825] REGS: e68d9b20 TRAP: 0700   Not tainted  (5.16.11-s3k-dev-01743-g19beecbfe9d6-dirty)
[   16.357849] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 24002282  XER: 00000000
[   16.357931]
[   16.357931] GPR00: c03fbc9c e68d9be0 c26d06a0 00000039 00000001 c0d36364 c0e96428 00000027
[   16.357931] GPR08: 00000001 00000000 00000023 3fffc000 24002282 100d3dd6 100a2ffc 00000000
[   16.357931] GPR16: 100cd280 100b0000 00000000 aff54f7e 100d0000 100d0000 00000001 100cf328
[   16.357931] GPR24: 100cf328 00000000 00000003 e68d9e30 c156b410 e67ab4c0 e68d9d38 c24ab278
[   16.358253] NIP [c03fbc9c] fsl_spi_cpm_bufs+0x2a0/0x2d8
[   16.358292] LR [c03fbc9c] fsl_spi_cpm_bufs+0x2a0/0x2d8
[   16.358325] Call Trace:
[   16.358336] [e68d9be0] [c03fbc9c] fsl_spi_cpm_bufs+0x2a0/0x2d8 (unreliable)
[   16.358388] [e68d9c00] [c03fcb44] fsl_spi_bufs.isra.0+0x94/0x1a0
[   16.358436] [e68d9c20] [c03fd970] fsl_spi_do_one_msg+0x254/0x3dc
[   16.358483] [e68d9cb0] [c03f7e50] __spi_pump_messages+0x274/0x8a4
[   16.358529] [e68d9ce0] [c03f9d30] __spi_sync+0x344/0x378
[   16.358573] [e68d9d20] [c03fb52c] spi_sync+0x34/0x60
[   16.358616] [e68d9d30] [c03b4dec] at25_ee_read+0x138/0x1a8
[   16.358667] [e68d9e50] [c04a8fb8] bin_attr_nvmem_read+0x98/0x110
[   16.358725] [e68d9e60] [c0204b14] kernfs_fop_read_iter+0xc0/0x1fc
[   16.358774] [e68d9e80] [c0168660] vfs_read+0x284/0x410
[   16.358821] [e68d9f00] [c016925c] ksys_read+0x6c/0x11c
[   16.358863] [e68d9f30] [c00160e0] ret_from_syscall+0x0/0x28
...
[   16.359608] ---[ end trace a4ce3e34afef0cb5 ]---
[   16.359638] fsl_spi b01004c0.spi: unable to map tx dma

This is due to the AT25 driver using buffers on stack, which is not
possible with CONFIG_VMAP_STACK.

As mentionned in kernel Documentation (Documentation/spi/spi-summary.rst):

  - Follow standard kernel rules, and provide DMA-safe buffers in
    your messages.  That way controller drivers using DMA aren't forced
    to make extra copies unless the hardware requires it (e.g. working
    around hardware errata that force the use of bounce buffering).

Modify the driver to use a buffer located in the at25 device structure
which is allocated via kmalloc during probe.

Protect writes in this new buffer with the driver's mutex.

Fixes: b587b13a4f67 ("[PATCH] SPI eeprom driver")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 drivers/misc/eeprom/at25.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
index bee727ed98db..d22044edcc9f 100644
--- a/drivers/misc/eeprom/at25.c
+++ b/drivers/misc/eeprom/at25.c
@@ -31,6 +31,8 @@
  */
 
 #define	FM25_SN_LEN	8		/* serial number length */
+#define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
+
 struct at25_data {
 	struct spi_eeprom	chip;
 	struct spi_device	*spi;
@@ -39,6 +41,7 @@ struct at25_data {
 	struct nvmem_config	nvmem_config;
 	struct nvmem_device	*nvmem;
 	u8 sernum[FM25_SN_LEN];
+	u8 command[EE_MAXADDRLEN + 1];
 };
 
 #define	AT25_WREN	0x06		/* latch the write enable */
@@ -61,8 +64,6 @@ struct at25_data {
 
 #define	FM25_ID_LEN	9		/* ID length */
 
-#define EE_MAXADDRLEN	3		/* 24 bit addresses, up to 2 MBytes */
-
 /*
  * Specs often allow 5ms for a page write, sometimes 20ms;
  * it's important to recover from write timeouts.
@@ -78,7 +79,6 @@ static int at25_ee_read(void *priv, unsigned int offset,
 {
 	struct at25_data *at25 = priv;
 	char *buf = val;
-	u8			command[EE_MAXADDRLEN + 1];
 	u8			*cp;
 	ssize_t			status;
 	struct spi_transfer	t[2];
@@ -92,12 +92,15 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	if (unlikely(!count))
 		return -EINVAL;
 
-	cp = command;
+	cp = at25->command;
 
 	instr = AT25_READ;
 	if (at25->chip.flags & EE_INSTR_BIT3_IS_ADDR)
 		if (offset >= BIT(at25->addrlen * 8))
 			instr |= AT25_INSTR_BIT3;
+
+	mutex_lock(&at25->lock);
+
 	*cp++ = instr;
 
 	/* 8/16/24-bit address is written MSB first */
@@ -116,7 +119,7 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	spi_message_init(&m);
 	memset(t, 0, sizeof(t));
 
-	t[0].tx_buf = command;
+	t[0].tx_buf = at25->command;
 	t[0].len = at25->addrlen + 1;
 	spi_message_add_tail(&t[0], &m);
 
@@ -124,8 +127,6 @@ static int at25_ee_read(void *priv, unsigned int offset,
 	t[1].len = count;
 	spi_message_add_tail(&t[1], &m);
 
-	mutex_lock(&at25->lock);
-
 	/*
 	 * Read it all at once.
 	 *
@@ -152,7 +153,7 @@ static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
 	spi_message_init(&m);
 	memset(t, 0, sizeof(t));
 
-	t[0].tx_buf = &command;
+	t[0].tx_buf = at25->command;
 	t[0].len = 1;
 	spi_message_add_tail(&t[0], &m);
 
@@ -162,6 +163,8 @@ static int fm25_aux_read(struct at25_data *at25, u8 *buf, uint8_t command,
 
 	mutex_lock(&at25->lock);
 
+	at25->command[0] = command;
+
 	status = spi_sync(at25->spi, &m);
 	dev_dbg(&at25->spi->dev, "read %d aux bytes --> %d\n", len, status);
 
-- 
2.35.1

