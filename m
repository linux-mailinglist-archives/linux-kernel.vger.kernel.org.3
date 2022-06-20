Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB67C550E26
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237974AbiFTAnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237786AbiFTAnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:09 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3850B4A2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:56 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id i17so7357747qvo.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4yiyjFbZ5Juzr+Gz/H2w54X4y4pvmCy/Lt7Z6lfmMw=;
        b=fXdKF00OwYkVBQf5hc3gb32tV7KgsiOs4n11yQWXVgL+6mj6VmTxCqqddq1hNVmhhU
         KnOhYxLu3QkN7RTkyQTS1gssSo1Bs8yCPVd83VicRXKVetgS5XGkH4BVuQwGgNEMsyzt
         f+5N9qn32cEEPz+/h0lsztWQc+7wEmOd/oF4eBS3qD+OMHV5abMffRwqYiZEzYdQSV0f
         VNb70uSvAss1oYJz7Lyvz5M5d+FXM4ct3UUdozsqRSgbcm7tXrrifgDWO1e5AnZYs8RN
         I3NpuImwcCt1EKiid56vxO5FhQQhJrihSRM+lKNsbjKK1UPRLtQ8Xa62KQ6MyLdF+vyR
         BOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4yiyjFbZ5Juzr+Gz/H2w54X4y4pvmCy/Lt7Z6lfmMw=;
        b=eLOj7NU10r0Ss/5J1uuEN4VGwU/UcIx1Rxieg0Her6/akilDxStu+hFqYO+vqIh59g
         ukfo29y1YoR9GkcWNdiva8VDDcobnwv1wmb/m911jIsyicFi4xH8znFSrauONqeKyY/O
         ec01N/Xd8dIISyQi1BIQJgh+7yGrv5O9pkeS5w9VGlVQU+/VNRtpWTMJ26am2OyD4ubx
         SXf2gwy86FV9pEtVD0+1io+zSPdyMKwm6+gPHGGv1DfKM7Qc9iWMEEcwKOIsQ/noEZT4
         TlFHkKtTpVc8US1sxIWXtXYamKaiUvWgwt7XkvE1EvB1TcOGdMeUQxgsdACoRAUt/bFe
         GcXQ==
X-Gm-Message-State: AJIora+P60lnOYLau5UwA0WdfYe5Hz7CKLNRo2udBiHn5f/nA4QHe6Mm
        DlInCB0gi0Depef6siuCrxCASEAelmFmHFo=
X-Google-Smtp-Source: AGRyM1tYNk5fbWQsttURTreDFM+BkJM6BzdKKxG44Rqes86jH7ptzH4Kis++RT67FHxHEe1SWABRfg==
X-Received: by 2002:ac8:57c3:0:b0:305:2dbd:92b3 with SMTP id w3-20020ac857c3000000b003052dbd92b3mr17904388qta.173.1655685774989;
        Sun, 19 Jun 2022 17:42:54 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id q4-20020ac87344000000b00304e5839734sm9303936qtp.55.2022.06.19.17.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:42:54 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 10/34] lib/pretty-printers: prt_string_option(), prt_bitflags()
Date:   Sun, 19 Jun 2022 20:42:09 -0400
Message-Id: <20220620004233.3805-11-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220620004233.3805-1-kent.overstreet@gmail.com>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/pretty-printers.h | 10 ++++++
 lib/Makefile                    |  2 +-
 lib/pretty-printers.c           | 60 +++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pretty-printers.h
 create mode 100644 lib/pretty-printers.c

diff --git a/include/linux/pretty-printers.h b/include/linux/pretty-printers.h
new file mode 100644
index 0000000000..f39d8edfba
--- /dev/null
+++ b/include/linux/pretty-printers.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRETTY_PRINTERS_H
+#define _LINUX_PRETTY_PRINTERS_H
+
+void prt_string_option(struct printbuf *, const char * const[], size_t);
+void prt_bitflags(struct printbuf *, const char * const[], u64);
+
+#endif /* _LINUX_PRETTY_PRINTERS_H */
diff --git a/lib/Makefile b/lib/Makefile
index b4609a4258..b520024852 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -34,7 +34,7 @@ lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
 	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \
 	 nmi_backtrace.o nodemask.o win_minmax.o memcat_p.o \
-	 buildid.o printbuf.o
+	 buildid.o printbuf.o pretty-printers.o
 
 lib-$(CONFIG_PRINTK) += dump_stack.o
 lib-$(CONFIG_SMP) += cpumask.o
diff --git a/lib/pretty-printers.c b/lib/pretty-printers.c
new file mode 100644
index 0000000000..addbac95e0
--- /dev/null
+++ b/lib/pretty-printers.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/* Copyright (C) 2022 Kent Overstreet */
+
+#include <linux/bitops.h>
+#include <linux/kernel.h>
+#include <linux/printbuf.h>
+#include <linux/pretty-printers.h>
+
+/**
+ * prt_string_option - Given a list of strings, print out the list and indicate
+ * which option is selected, with square brackets (sysfs style)
+ *
+ * @out: The printbuf to output to
+ * @list: List of strings to choose from
+ * @selected: The option to highlight, with square brackets
+ */
+void prt_string_option(struct printbuf *out,
+		       const char * const list[],
+		       size_t selected)
+{
+	size_t i;
+
+	for (i = 0; list[i]; i++) {
+		if (i)
+			prt_char(out, ' ');
+		if (i == selected)
+			prt_char(out, '[');
+		prt_str(out, list[i]);
+		if (i == selected)
+			prt_char(out, ']');
+	}
+}
+EXPORT_SYMBOL(prt_string_option);
+
+/**
+ * prt_bitflags: Given a bitmap and a list of names for each bit, print out which
+ * bits are on, comma separated
+ *
+ * @out: The printbuf to output to
+ * @list: List of names for each bit
+ * @flags: Bits to print
+ */
+void prt_bitflags(struct printbuf *out,
+		  const char * const list[], u64 flags)
+{
+	unsigned bit, nr = 0;
+	bool first = true;
+
+	while (list[nr])
+		nr++;
+
+	while (flags && (bit = __ffs(flags)) < nr) {
+		if (!first)
+			prt_char(out, ',');
+		first = false;
+		prt_str(out, list[bit]);
+		flags ^= 1 << bit;
+	}
+}
+EXPORT_SYMBOL(prt_bitflags);
-- 
2.36.1

