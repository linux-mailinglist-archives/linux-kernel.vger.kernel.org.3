Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8C847F2DA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 11:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLYKHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 05:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbhLYKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 05:07:19 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B4FC061401
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:07:19 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id n16so8067278plc.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 02:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O9EkSjwtanl4h/6dqWkpPDfN+8wa52ZJjrk+N+tOFDk=;
        b=LIvultUljIeIEDCwfyUeC9ZxcK4r4ihapXkVzthi+ypU5ptO5QWUDhgHs4FkzJgNKL
         jrv94HN9GLtbi80Nw6s4H3Jl3mxwJy+jYZHo8cdfSRQuLQEQOOaNo2LCQNwtjr2Kz5i6
         3fqUcIOuU16sQg26a0a86+zJoueJg6omADEwJlVnwY1GWTZ5NgGwzXFLLycT84B6UFgc
         SiJP66rT91aj811WE9og4oP/FspsgWyxhK/mTsGCAiisTgwxfELM9Ugxjdg2H/rrz3mE
         psjBoUVLa6yxri16HlR60ACt0DWhDpDKO21fobmJWergUmwhajUDxofium3tes25YZtt
         /S2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O9EkSjwtanl4h/6dqWkpPDfN+8wa52ZJjrk+N+tOFDk=;
        b=RpfYB1m0G/jlZpRCZ+23FG01iLdOWhtqPjfRTy+TC8uduyq0afj+p1CznkKnXjU1lb
         98MVm2atVDCbfAiAt/86VKjq21eQ9t1kGAhlYCNrmmjh2E34/8WQPXpaJjb+TgIw2IQU
         OczDSV7LVwpSUXFNEJ/y9KrsD4iP6nXi91K44JNS4XRIXr2rVaFWIMdZUFGvpoEN2o/l
         pALicbD6KTcuCLFFzgODrZ/V6+SLB3ZD9tDhVebtJ2FmF8Lg5gOqu/uUcMtZIxaWNQwT
         yROOdd9Akd1jCMnAU7+cqXfZI9K2/zYkyI5o5oulW51zas5eojzh7MM/CIO0DGrrBa0v
         NvuQ==
X-Gm-Message-State: AOAM532Md2OaKQjSAGdxU5gBWxiBpAKQZM0GMr8auagK4Y3q0U+PTbGQ
        ZbvnDQPvZgWQo4lEqAiuWxo=
X-Google-Smtp-Source: ABdhPJxPpzuT3Qt/FGxXpjPuJv1e/C8B9y7Ch3+8RuzC8bsRMj2lcMx7n0yQGO40Na/L4KX1+qatxA==
X-Received: by 2002:a17:90a:7001:: with SMTP id f1mr11999286pjk.70.1640426838912;
        Sat, 25 Dec 2021 02:07:18 -0800 (PST)
Received: from localhost.localdomain (1-34-229-86.hinet-ip.hinet.net. [1.34.229.86])
        by smtp.gmail.com with ESMTPSA id b9sm11840982pfm.127.2021.12.25.02.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 02:07:18 -0800 (PST)
From:   s921975628@gmail.com
To:     richard@nod.at, vigneshr@ti.com, miquel.raynal@bootlin.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        RinHizakura <s921975628@gmail.com>
Subject: [PATCH 3/3] mtd: rawnand: nandsim: Add NS_PAGE_BYTE_SHIFT macro to replace the repeat pattern
Date:   Sat, 25 Dec 2021 18:07:13 +0800
Message-Id: <20211225100713.119089-1-s921975628@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: RinHizakura <s921975628@gmail.com>

The (ns->regs.column + ns->regs.off) pattern repeats a lot which
represents the byte shift in next page to access. We can replace it
with a macro to improve the readability.

Signed-off-by: RinHizakura <s921975628@gmail.com>
---
 drivers/mtd/nand/raw/nandsim.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
index 2ef6bddf0..24beade95 100644
--- a/drivers/mtd/nand/raw/nandsim.c
+++ b/drivers/mtd/nand/raw/nandsim.c
@@ -201,6 +201,9 @@ MODULE_PARM_DESC(bch,		 "Enable BCH ecc and set how many bits should "
 /* Calculate the OOB offset in flash RAM image by (row, column) address */
 #define NS_RAW_OFFSET_OOB(ns) (NS_RAW_OFFSET(ns) + ns->geom.pgsz)
 
+/* Calculate the byte shift in the next page to access */
+#define NS_PAGE_BYTE_SHIFT(ns) ((ns)->regs.column + (ns)->regs.off)
+
 /* After a command is input, the simulator goes to one of the following states */
 #define STATE_CMD_READ0        0x00000001 /* read data from the beginning of page */
 #define STATE_CMD_READ1        0x00000002 /* read data from the second half of page */
@@ -1382,7 +1385,7 @@ static inline union ns_mem *NS_GET_PAGE(struct nandsim *ns)
  */
 static inline u_char *NS_PAGE_BYTE_OFF(struct nandsim *ns)
 {
-	return NS_GET_PAGE(ns)->byte + ns->regs.column + ns->regs.off;
+	return NS_GET_PAGE(ns)->byte + NS_PAGE_BYTE_SHIFT(ns);
 }
 
 static int ns_do_read_error(struct nandsim *ns, int num)
@@ -1408,7 +1411,7 @@ static void ns_do_bit_flips(struct nandsim *ns, int num)
 			ns->buf.byte[pos / 8] ^= (1 << (pos % 8));
 			NS_WARN("read_page: flipping bit %d in page %d "
 				"reading from %d ecc: corrected=%u failed=%u\n",
-				pos, ns->regs.row, ns->regs.column + ns->regs.off,
+				pos, ns->regs.row, NS_PAGE_BYTE_SHIFT(ns),
 				nsmtd->ecc_stats.corrected, nsmtd->ecc_stats.failed);
 		}
 	}
@@ -1430,7 +1433,7 @@ static void ns_read_page(struct nandsim *ns, int num)
 			ssize_t tx;
 
 			NS_DBG("read_page: page %d written, reading from %d\n",
-				ns->regs.row, ns->regs.column + ns->regs.off);
+				ns->regs.row, NS_PAGE_BYTE_SHIFT(ns));
 			if (ns_do_read_error(ns, num))
 				return;
 			pos = (loff_t)NS_RAW_OFFSET(ns) + ns->regs.off;
@@ -1451,7 +1454,7 @@ static void ns_read_page(struct nandsim *ns, int num)
 		memset(ns->buf.byte, 0xFF, num);
 	} else {
 		NS_DBG("read_page: page %d allocated, reading from %d\n",
-			ns->regs.row, ns->regs.column + ns->regs.off);
+			ns->regs.row, NS_PAGE_BYTE_SHIFT(ns));
 		if (ns_do_read_error(ns, num))
 			return;
 		memcpy(ns->buf.byte, NS_PAGE_BYTE_OFF(ns), num);
@@ -1502,7 +1505,7 @@ static int ns_prog_page(struct nandsim *ns, int num)
 		int all;
 
 		NS_DBG("prog_page: writing page %d\n", ns->regs.row);
-		pg_off = ns->file_buf + ns->regs.column + ns->regs.off;
+		pg_off = ns->file_buf + NS_PAGE_BYTE_SHIFT(ns);
 		off = (loff_t)NS_RAW_OFFSET(ns) + ns->regs.off;
 		if (!test_bit(ns->regs.row, ns->pages_written)) {
 			all = 1;
@@ -1591,7 +1594,7 @@ static int ns_do_state_action(struct nandsim *ns, uint32_t action)
 			NS_ERR("do_state_action: column number is too large\n");
 			break;
 		}
-		num = ns->geom.pgszoob - ns->regs.off - ns->regs.column;
+		num = ns->geom.pgszoob - NS_PAGE_BYTE_SHIFT(ns);
 		ns_read_page(ns, num);
 
 		NS_DBG("do_state_action: (ACTION_CPY:) copy %d bytes to int buf, raw offset %d\n",
@@ -1659,7 +1662,7 @@ static int ns_do_state_action(struct nandsim *ns, uint32_t action)
 			return -1;
 		}
 
-		num = ns->geom.pgszoob - ns->regs.off - ns->regs.column;
+		num = ns->geom.pgszoob - NS_PAGE_BYTE_SHIFT(ns);
 		if (num != ns->regs.count) {
 			NS_ERR("do_state_action: too few bytes were input (%d instead of %d)\n",
 					ns->regs.count, num);
@@ -1803,7 +1806,7 @@ static void ns_switch_state(struct nandsim *ns)
 		switch (NS_STATE(ns->state)) {
 			case STATE_DATAIN:
 			case STATE_DATAOUT:
-				ns->regs.num = ns->geom.pgszoob - ns->regs.off - ns->regs.column;
+				ns->regs.num = ns->geom.pgszoob - NS_PAGE_BYTE_SHIFT(ns);
 				break;
 
 			case STATE_DATAOUT_ID:
-- 
2.25.1

