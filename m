Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749E350E537
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243187AbiDYQND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiDYQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:12:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767193D4A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:09:36 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u9-20020a25b7c9000000b0064636cb9078so6209128ybj.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q8a8wJvEklAmCtCpSgW2FIcat+OGKagtU2H8hFgsok4=;
        b=La2lXw+CyTzmORqrvTtza6E1VmcDhBtZSejdp92C/j6nD1VzVby+OOi9gtDlyazQiq
         o+q7tinZHsfN+YfYPjeA0tfcepEpmXSDauc46eZyT+nZTh+kTgzyShblLGYKPNv8jofB
         KkG9nyuHtIbEyLZwe13V8j63/eXJE1wqviEBwxau4ZtGI1b+P0ci9a1cyZTJZXeJ9Cz6
         XRolYviQLodpgkF6SJrjzpPTHkT//T6cq4RFBWdCzSHj94feeI8BGETpYBgMh8P/T3M8
         rhp5X7/tV4cWACImM/yc90HCjkAzGPoVt2tAp/F11BETzg5AhDhkm5mj5JFXme/FqWHz
         60tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q8a8wJvEklAmCtCpSgW2FIcat+OGKagtU2H8hFgsok4=;
        b=arXo9Vd0OJszbFq50oGY/hCOcZGs1BqBy0JF5kh9+RXAX5UwrqoGDtQ3AZAS/CLRoh
         r5JCk7A1pm0XarAgH7IBeot8wCHVDsbQAK27x2Awjz/8QfV6w9eBA3V33FH5p9LSJ81Y
         s0iRn71piouiIXMtJRLHeeb3oFViJ6lM2SVavxx2teudgLtN4inO+r/Nxcd8H+ejHZ6J
         joORDGxRCueIbVZsuh3A3Q7alwXHzmrF9x7UD5TSZ3G0s058SqFfbvaqzrgEHybGWz7L
         CPRblcnRQ1dxHO3tv0sJy+2GSIJ3Op7qw092gjatCJO0irj5nCWWoWqayRfegCtZbRYg
         keRw==
X-Gm-Message-State: AOAM5334oD2e6elr0XAjPpVSLbk7US4b80NnEwegNb588uvgPZ5q2iCw
        Zl0qgrSa1ewN9AK1i0muZaOD6yoiWd2Y
X-Google-Smtp-Source: ABdhPJxLXU6NMM3kSh38aJIH/4lbhagzTjIvjo3KT34820k38yHRBMsFEiCubfGOgQGjyBUjvHo61vYWmKGW
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:cacf:5ee9:4234:3c47])
 (user=jmeurin job=sendgmr) by 2002:a25:3445:0:b0:648:3dd2:f210 with SMTP id
 b66-20020a253445000000b006483dd2f210mr8899114yba.3.1650902975700; Mon, 25 Apr
 2022 09:09:35 -0700 (PDT)
Date:   Mon, 25 Apr 2022 09:09:27 -0700
In-Reply-To: <20220415001321.252848-1-jmeurin@google.com>
Message-Id: <20220425160927.3823016-1-jmeurin@google.com>
Mime-Version: 1.0
References: <20220415001321.252848-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v4 3/3] mtd: mtdoops: Add a timestamp to the mtdoops header.
From:   Jean-Marc Eurin <jmeurin@google.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jean-Marc Eurin <jmeurin@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some systems, the oops only has relative time from boot.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 186eeb01bee1..3d4a2ffb5b01 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/timekeeping.h>
 #include <linux/mtd/mtd.h>
 #include <linux/kmsg_dump.h>
 
@@ -37,11 +38,13 @@ module_param(dump_oops, int, 0600);
 MODULE_PARM_DESC(dump_oops,
 		"set to 1 to dump oopses, 0 to only dump panics (default 1)");
 
-#define MTDOOPS_KERNMSG_MAGIC 0x5d005d00
+#define MTDOOPS_KERNMSG_MAGIC_v1 0x5d005d00  /* Original */
+#define MTDOOPS_KERNMSG_MAGIC_v2 0x5d005e00  /* Adds the timestamp */
 
 struct mtdoops_hdr {
 	u32 seq;
 	u32 magic;
+	ktime_t timestamp;
 } __packed;
 
 static struct mtdoops_context {
@@ -191,7 +194,8 @@ static void mtdoops_write(struct mtdoops_context *cxt, int panic)
 	/* Add mtdoops header to the buffer */
 	hdr = (struct mtdoops_hdr *)cxt->oops_buf;
 	hdr->seq = cxt->nextcount;
-	hdr->magic = MTDOOPS_KERNMSG_MAGIC;
+	hdr->magic = MTDOOPS_KERNMSG_MAGIC_v2;
+	hdr->timestamp = ktime_get_real();
 
 	if (panic) {
 		ret = mtd_panic_write(mtd, cxt->nextpage * record_size,
@@ -247,7 +251,9 @@ static void find_next_position(struct mtdoops_context *cxt)
 
 		if (hdr.seq == 0xffffffff && hdr.magic == 0xffffffff)
 			mark_page_unused(cxt, page);
-		if (hdr.seq == 0xffffffff || hdr.magic != MTDOOPS_KERNMSG_MAGIC)
+		if (hdr.seq == 0xffffffff ||
+		    (hdr.magic != MTDOOPS_KERNMSG_MAGIC_v1 &&
+		     hdr.magic != MTDOOPS_KERNMSG_MAGIC_v2))
 			continue;
 		if (maxcount == 0xffffffff) {
 			maxcount = hdr.seq;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

