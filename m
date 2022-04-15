Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB371501F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 02:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347935AbiDOAQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347943AbiDOAQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 20:16:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF035931B0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dc7bdd666fso55167797b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 17:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ahv1rMnoXCJYqGoBMv8RBADWJdwEiPpEYtFvG6t6lwk=;
        b=VJ6FESzpi+kwKXbN4PjaEo5RYLhxcdrKaGb60eloOT8EztGcgCnZKP0rXMfhj3mZHw
         SCdNpZH64G5qdy3boXLj6xlC6VcyNv+lklrRgBJPeYOdLtWSl67eIfdB6AdanP/aUWTZ
         KgG7R3ZUhf6pliehqp5RIvSoZD2SQq1yaZCEaW1mZp4wNhEkAUUufjQhOe1Yu6Ua+FDU
         IU3qGidlqmUZFRnx0YjUnQImk2MrYdddWmeHDZYhn6iNNejUkEfYgXF0oQ/kqjXjXKqC
         +JH9jP8S+xbHyMwmuohtLSNf+/BFaZVtJC0YrAMgUqFL5j5qVjZ5vGcHVsvBGQBHMyRK
         HrJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ahv1rMnoXCJYqGoBMv8RBADWJdwEiPpEYtFvG6t6lwk=;
        b=stQK9xYRgNZ+zVOXFfSLsJTGI86Ad/x9ho8n05PYyNr3k8JRybu0s+ju2dQwtLiH7U
         WYiobHiPv9kRYHtltsspIGpfWocKz4k0/Lh6SwygzWyrlOE6sMvCeCUFciQOjXbZqOU2
         +qCOyTqQn+TFY8dQI3sEb674mI7Y7qFOxMGbn0I4Ih/uKdT7diJiLZCKmFjX6S8DtNQ1
         Sb2/P1+FAGSboVHn4v1ocHHSqdu3nRlXKBJJUR8UkUEkfOLwieUuRiZfOrJ7y4Kcm5Jh
         hXGc8lI2iTk8Kl8nkmyPuQ+j4+1eI0lnz0PcD4cy+xkEvp1B2lKwQN8052676E3k6pmB
         oeHw==
X-Gm-Message-State: AOAM532FyMR1XdYO4bf4pCdAoFJMMKaH3KGWFRq83Mis3Kc+ZSWCfsPu
        hT3hxgdxj5HntstA0mBtu7WHJbfR2Yy0
X-Google-Smtp-Source: ABdhPJz0sRlJgwqEIUkD/l0xohBHj1hXJzIsDsQUZHoplQroWQ4UFZYNm68G+NEkRyeSyR95NY1r0n3mAmrh
X-Received: from pigloo.svl.corp.google.com ([2620:15c:2c5:13:7d77:8cae:9dfe:95c])
 (user=jmeurin job=sendgmr) by 2002:a05:6902:1109:b0:63d:caf3:73b5 with SMTP
 id o9-20020a056902110900b0063dcaf373b5mr3737845ybu.413.1649981654033; Thu, 14
 Apr 2022 17:14:14 -0700 (PDT)
Date:   Thu, 14 Apr 2022 17:13:21 -0700
In-Reply-To: <20220415001321.252848-1-jmeurin@google.com>
Message-Id: <20220415001321.252848-4-jmeurin@google.com>
Mime-Version: 1.0
References: <20220207163409.19c3bc4c@xps13> <20220415001321.252848-1-jmeurin@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v3 3/3] mtd: mtdoops: Add a timestamp to the mtdoops header.
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

On some systems, the oops only has relative time from boot.

Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
---
 drivers/mtd/mtdoops.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index f80468ef31c6..4e5ade91da36 100644
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
2.36.0.rc0.470.gd361397f0d-goog

