Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1D4ECC4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 20:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350507AbiC3ScG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 14:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350465AbiC3Sb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 14:31:57 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ACF4830F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2e6d04210b3so146313987b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KfcUkaTckWUYUZ9aQp31D6YQqt9tokDiP9MkQHNDrEc=;
        b=VSSiIRlHk2quuVAOW2Z7xaW09hmCV7pBg92ysUgXNZLEpHs6ywnJe6abK25mO88cKI
         uGMeD+NghlCFc2FQ2UyirjrfptH5lqUqkfttIjjo/XEk5HdoRjAVn9mGT+vtJU64foFA
         AagKpYgaYlnQsEPPae2J+Qj9FYKaiwtXUwQxjOASYZPXEpFrvpNWZlVqea6yRtDvOWBK
         gU8K8hSAFTa5oQe1ktSSt4SDxa/bR0yJPED+Msz4++moo2HSBwbK3agZjzjq2ItMOBBo
         2LwQI3d/+SY+I15NSNX3M0fbtVT25xP1JmhNuOI0JY0XnxLZ7HVqlbNutYS3k1Csj0QZ
         4aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KfcUkaTckWUYUZ9aQp31D6YQqt9tokDiP9MkQHNDrEc=;
        b=u9pgKiBv//AWFwu250w9xt2ZnftYvvbuPNRDLYjFx38aV1axgesJ5l1he4TA3Rhp+q
         iHiD+AS3XqfbXUiD0GXoC+MgYbDrnXiQ0aH/hlcaXhgsBwoW2GlPnrEBaVGsmI2uYi2X
         I0xMnM2acYfqXSRi14BGzNbeReRYPLzAEKxQopLbX1Mx1Hz1HRUePDdhJJDKr3EywOw5
         3CkO/6OWc/4QJS8YGNcXtSqT9tslbCXF/KMOzdU4aYfj8MuuOJc40kPn7Ze/o7GKGenk
         vzgE/FZYgRfs6bfOFxIAMXGNYAih/djndwTcorU1W32UaTXXxypXwA2sCuQ13x3V+s8x
         chlA==
X-Gm-Message-State: AOAM533eSOqvnksjoSC0GoMKp6Eiqkm8FmurA8pBIdM7IblvMYUlwPXd
        YBj4ewhqqT9C9NxAU3IajfDvneX/m5w/
X-Google-Smtp-Source: ABdhPJyVW2ytMhj6Q4XtA6yzFixRhf4Yh+fFRBPhl1KuBAdL+CRox9+LHBCljq0H/ihZ7kDSEcGZrww7dP8Q
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:1db:3f32:3ad1:f38])
 (user=jmeurin job=sendgmr) by 2002:a25:dd87:0:b0:628:e822:bd with SMTP id
 u129-20020a25dd87000000b00628e82200bdmr888447ybg.505.1648664916670; Wed, 30
 Mar 2022 11:28:36 -0700 (PDT)
Date:   Wed, 30 Mar 2022 11:28:16 -0700
In-Reply-To: <20220330182816.1177341-1-jmeurin@google.com>
Message-Id: <20220330182816.1177341-4-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220330182816.1177341-1-jmeurin@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
Subject: [PATCH v2 2/2] mtd: mtdoops: Create a header structure for the saved mtdoops.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a dump header to enable the addition of fields without having
to modify the rest of the code.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 53 +++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 09a26747f490..9ca82c2dbf60 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -22,9 +22,6 @@
 /* Maximum MTD partition size */
 #define MTDOOPS_MAX_MTD_SIZE (8 * 1024 * 1024)
 
-#define MTDOOPS_KERNMSG_MAGIC 0x5d005d00
-#define MTDOOPS_HEADER_SIZE   8
-
 static unsigned long record_size = 4096;
 module_param(record_size, ulong, 0400);
 MODULE_PARM_DESC(record_size,
@@ -40,6 +37,13 @@ module_param(dump_oops, int, 0600);
 MODULE_PARM_DESC(dump_oops,
 		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
 
+#define MTDOOPS_KERNMSG_MAGIC 0x5d005d00
+
+struct mtdoops_hdr {
+	u32 seq;
+	u32 magic;
+} __packed;
+
 static struct mtdoops_context {
 	struct kmsg_dumper dump;
 
@@ -178,16 +182,16 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	size_t retlen;
-	u32 *hdr;
+	struct mtdoops_hdr *hdr;
 	int ret;
 
 	if (test_and_set_bit(0, &cxt->oops_buf_busy))
 		return;
 
 	/* Add mtdoops header to the buffer */
-	hdr = cxt->oops_buf;
-	hdr[0] = cxt->nextcount;
-	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
+	hdr = (struct mtdoops_hdr *)cxt->oops_buf;
+	hdr->seq = cxt->nextcount;
+	hdr->magic = MTDOOPS_KERNMSG_MAGIC;
 
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
@@ -222,8 +226,9 @@ static void mtdoops_workfunc_write(struct work_struct *work)
 static void find_next_position(struct mtdoops_context *cxt)
 {
 	struct mtd_info *mtd = cxt->mtd;
+	struct mtdoops_hdr hdr;
 	int ret, page, maxpos = 0;
-	u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount = 0xffffffff;
+	u32 maxcount = 0xffffffff;
 	size_t retlen;
 
 	for (page = 0; page < cxt->oops_pages; page++) {
@@ -231,32 +236,31 @@ static void find_next_position(struct mtdoops_context *cxt)
 			continue;
 		/* Assume the page is used */
 		mark_page_used(cxt, page);
-		ret = mtd_read(mtd, page * record_size, MTDOOPS_HEADER_SIZE,
-			       &retlen, (u_char *)&count[0]);
-		if (retlen != MTDOOPS_HEADER_SIZE ||
+		ret = mtd_read(mtd, page * record_size, sizeof(hdr),
+			       &retlen, (u_char *)&hdr);
+		if (retlen != sizeof(hdr) ||
 				(ret < 0 && !mtd_is_bitflip(ret))) {
 			printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
-			       page * record_size, retlen,
-			       MTDOOPS_HEADER_SIZE, ret);
+			       page * record_size, retlen, sizeof(hdr), ret);
 			continue;
 		}
 
-		if (count[0] == 0xffffffff && count[1] == 0xffffffff)
+		if (hdr.seq == 0xffffffff && hdr.magic == 0xffffffff)
 			mark_page_unused(cxt, page);
-		if (count[0] == 0xffffffff || count[1] != MTDOOPS_KERNMSG_MAGIC)
+		if (hdr.seq == 0xffffffff || hdr.magic != MTDOOPS_KERNMSG_MAGIC)
 			continue;
 		if (maxcount == 0xffffffff) {
-			maxcount = count[0];
+			maxcount = hdr.seq;
 			maxpos = page;
-		} else if (count[0] < 0x40000000 && maxcount > 0xc0000000) {
-			maxcount = count[0];
+		} else if (hdr.seq < 0x40000000 && maxcount > 0xc0000000) {
+			maxcount = hdr.seq;
 			maxpos = page;
-		} else if (count[0] > maxcount && count[0] < 0xc0000000) {
-			maxcount = count[0];
+		} else if (hdr.seq > maxcount && hdr.seq < 0xc0000000) {
+			maxcount = hdr.seq;
 			maxpos = page;
-		} else if (count[0] > maxcount && count[0] > 0xc0000000
+		} else if (hdr.seq > maxcount && hdr.seq > 0xc0000000
 					&& maxcount > 0x80000000) {
-			maxcount = count[0];
+			maxcount = hdr.seq;
 			maxpos = page;
 		}
 	}
@@ -287,8 +291,9 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 
 	if (test_and_set_bit(0, &cxt->oops_buf_busy))
 		return;
-	kmsg_dump_get_buffer(&iter, true, cxt->oops_buf + MTDOOPS_HEADER_SIZE,
-			     record_size - MTDOOPS_HEADER_SIZE, NULL);
+	kmsg_dump_get_buffer(&iter, true,
+			     cxt->oops_buf + sizeof(struct mtdoops_hdr),
+			     record_size - sizeof(struct mtdoops_hdr), NULL);
 	clear_bit(0, &cxt->oops_buf_busy);
 
 	if (reason != KMSG_DUMP_OOPS) {
-- 
2.35.1.1094.g7c7d902a7c-goog

