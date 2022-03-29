Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902A14EB636
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiC2Wz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238290AbiC2WzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:55:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2607C3BBD6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:53:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a12-20020a25938c000000b0063467614126so14401263ybm.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SzAb5E3ABDSvH+2ozGaLa0QM9bLWPv1NLfKOiNeNHW0=;
        b=hLuWt3Wh6c1WKbkWz2FXUQtO9uWwj1vJSmaOgqaqeZhJstAmkHfUjufdCCD4s/ZcsN
         a2u40ugbMbDuuh9+A8tFgwhdzgRquqAJgVsS4q8q9rcxJH5GTwRC3vni5+RfSL2VJBRO
         etrPRLrucKoEgdUayyiPfNA98+1CmHws5IZlqSotuJfeheZOKxbvAyasutiuXCs/IBOU
         nuAB2hzUKnUATdSEAIGQYGHSQMrNAA9Mct1u0B9yX39e+a/P0iS4r1nApHnl2rUORuWj
         3/Mdluwzl0yamL5er0zOG94AdQDZqtych0dkQ9+esBGPIDNIvpA1pC+Ep397wEmyP1V2
         cP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SzAb5E3ABDSvH+2ozGaLa0QM9bLWPv1NLfKOiNeNHW0=;
        b=Qd+ZNbop+QCBAj1RXGyrUQejUY0mvhxl5y7hsJk1ppPqCjCTv4K0lUDRsYI4r0LZ3P
         PA5iv7RXvgq2TCIo0E8E/wJldREkO2Iyxrs1elOX9Da50Bpzmgz73EP4ccXcnQZydCjQ
         +nQMExeui/lXidRIK7n7WEAHX+HSHWAZuMs8ZOSRhEvKI2itYnZyou9txJTdWDgndKwm
         uQK4Tq+2BGZBdwyixkaXPzcCfsU4mhomCKdT9dPcNDrYek2dAe/lPqJQmgHv1DyRhFth
         gAeDRLyL3hLEQ/N8D3Z1SybhTFyImB5jQHKLz0yY7IKJnxPf6of+NjmUSpvAKtk8alJ+
         6Lig==
X-Gm-Message-State: AOAM530YcQbDL7XyfzyOyQfWOfeM9QBO27koonOn0eEtmR1tiIeL2buz
        IYGe9TiqILOcJuYpP+SavJn+p8Hxsfbp
X-Google-Smtp-Source: ABdhPJwi/lpJr0Q8f1NyiiOQaOVbt13viRmpl1VWnPjkgS0XIaJgmVzLfNxzE9JQhfqZ2o36j+Y/PlMHT2MI
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:4a29:1258:961f:3676])
 (user=jmeurin job=sendgmr) by 2002:a25:3796:0:b0:633:7633:941f with SMTP id
 e144-20020a253796000000b006337633941fmr30268972yba.518.1648594419425; Tue, 29
 Mar 2022 15:53:39 -0700 (PDT)
Date:   Tue, 29 Mar 2022 15:53:28 -0700
Message-Id: <20220329225328.396209-1-jmeurin@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] Create a proper header for the saved mtdoops.
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

Avoid a panic if the header size changes.
Add a timestamp to the oops header.

Tested:
Triggered panic saved correctly:
xxd -l 0x20 -s 0x0000 /dev/mtdblock1
00000000: 0100 0000 005e 005d 935d 4117 c5bf df16  .....^.].]A.....
00000010: 3c36 3e5b 2020 3133 392e 3938 3039 3533  <6>[  139.980953

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 57 +++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 227df24387df..6a51baa172ae 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -16,15 +16,13 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/timekeeping.h>
 #include <linux/mtd/mtd.h>
 #include <linux/kmsg_dump.h>
 
 /* Maximum MTD partition size */
 #define MTDOOPS_MAX_MTD_SIZE (8 * 1024 * 1024)
 
-#define MTDOOPS_KERNMSG_MAGIC 0x5d005d00
-#define MTDOOPS_HEADER_SIZE   8
-
 static unsigned long record_size = 4096;
 module_param(record_size, ulong, 0400);
 MODULE_PARM_DESC(record_size,
@@ -40,6 +38,14 @@ module_param(dump_oops, int, 0600);
 MODULE_PARM_DESC(dump_oops,
 		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
 
+#define MTDOOPS_KERNMSG_MAGIC 0x5d005e00
+
+struct mtdoops_hdr {
+	u32 seq;
+	u32 magic;
+	ktime_t timestamp;
+} __packed;
+
 static struct mtdoops_context {
 	struct kmsg_dumper dump;
 
@@ -178,16 +184,18 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 {
 	struct mtd_info *mtd = cxt->mtd;
 	size_t retlen;
-	u32 *hdr;
+	struct mtdoops_hdr *hdr;
 	int ret;
+	ktime_t ktime = ktime_get_real();
 
 	if (test_and_set_bit(0, &cxt->oops_buf_busy))
 		return;
 
 	/* Add mtdoops header to the buffer */
-	hdr = cxt->oops_buf;
-	hdr[0] = cxt->nextcount;
-	hdr[1] = MTDOOPS_KERNMSG_MAGIC;
+	hdr = (struct mtdoops_hdr *)cxt->oops_buf;
+	hdr->seq = cxt->nextcount;
+	hdr->magic = MTDOOPS_KERNMSG_MAGIC;
+	hdr->timestamp = ktime_get_real();
 
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
@@ -222,8 +230,9 @@ static void mtdoops_workfunc_write(struct work_struct *work)
 static void find_next_position(struct mtdoops_context *cxt)
 {
 	struct mtd_info *mtd = cxt->mtd;
+	struct mtdoops_hdr hdr;
 	int ret, page, maxpos = 0;
-	u32 count[2], maxcount = 0xffffffff;
+	u32 maxcount = 0xffffffff;
 	size_t retlen;
 
 	for (page = 0; page < cxt->oops_pages; page++) {
@@ -231,32 +240,31 @@ static void find_next_position(struct mtdoops_context *cxt)
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
@@ -287,8 +295,9 @@ static void mtdoops_do_dump(struct kmsg_dumper *dumper,
 
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
2.35.1.1021.g381101b075-goog

