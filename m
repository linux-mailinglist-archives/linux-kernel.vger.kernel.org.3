Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F58B501F7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347957AbiDOAQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347921AbiDOAQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:16:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9200A75C05
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f14-20020a5b0c0e000000b00641d371d9c8so5188870ybq.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=j+3tJjiCf78FCu6r+r65AdoN2KDRFod1PmLEraQ3coY=;
        b=Caezxcdf/vNIhgSMCI6hmDKw41eI/IzIh12p3HqrzYy5BdmkRG+GsLLOhcXFMGq52d
         3KFCwvz/AoUPz+l3+sm8mXAf5PozArFFzJ4m+Zc4phpLh7pM4DEkdrY2z4N2lzvh/I91
         oqthovmJ955Vr9DosTQHL4tWD3y1s/m95U8l5w8+091pwxD0ZzbZKXcdAP6fXbDxewqc
         5EGzuIT/q6kTl0dYwGeln0DNf7bQwGvt4r2mSNmCfYam7HwhcRMmxc/a+nt50UvKFHZ5
         ydwwD0u3cRCLONs7Ry1zb1hgIqQ1HJ/4AbfBZ59BgN0aWbxiebdJ3XQCMUYtmKhs64ZX
         oKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=j+3tJjiCf78FCu6r+r65AdoN2KDRFod1PmLEraQ3coY=;
        b=1kNWTCc5srICC7eO1yP97MZoePRA5GbrOWQ1UcrdZ7b7NnWwbhAIThuAXvBTvp7JB5
         OKwxW1inKTnOzFMSsu53bHs1FZGsRIusfAMD2PWKs0yiVgcyGNQ5ppBS1YHT0JM1OSEI
         yEyMguq6hldTQa+LnHEEdIAtko/1qvlKlm+3JtvHnd3+BhU/fqV1PdXOih77XI29yTpl
         Yuec2DMz+5RoyzdzcgJmTZjMlu3+xi8+xtyRD2M6OT2vXz7RchiWwWvQJFW16hfc6z5H
         ZB/v7dhnu5wIrKFLjUmUVx4DoxsswOjGwkfGhHANEsj0MrrwrIpe8IflBUbVK2/62/+h
         9kGw==
X-Gm-Message-State: AOAM532RKy2aqMK+IqnfkrY2RClw5m2uKHJZSfb+jjSXa9qYF73m546U
        p8qD90ST969iq8tgHzNiKcnWO6dtCy57
X-Google-Smtp-Source: ABdhPJyvaWs/ucoEhalwvhW30u3+I0YIcXElUI1onpLQMvainyojc+8EwtVbGmuj+WqtK6/BNgz7CR/ycm13
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:7d77:8cae:9dfe:95c])
 (user=jmeurin job=sendgmr) by 2002:a05:6902:72a:b0:641:283b:3946 with SMTP id
 l10-20020a056902072a00b00641283b3946mr3679439ybt.469.1649981649814; Thu, 14
 Apr 2022 17:14:09 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:13:20 -0700
In-Reply-To: <20220415001321.252848-1-jmeurin@google.com>
Message-Id: <20220415001321.252848-3-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220415001321.252848-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v3 2/3] mtd: mtdoops: Create a header structure for the saved mtdoops.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>,
        kernel test robot <lkp@intel.com>
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

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 55 +++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 09a26747f490..f80468ef31c6 100644
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
-			printk(KERN_ERR "mtdoops: read failure at %ld (%td of %d read), err %d\n",
-			       page * record_size, retlen,
-			       MTDOOPS_HEADER_SIZE, ret);
+			printk(KERN_ERR "mtdoops: read failure at %ld (%td of %ld read), err %d\n",
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
2.36.0.rc0.470.gd361397f0d-goog

