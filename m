Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F1A52DB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242762AbiESRZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbiESRY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:57 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1862EA5A89;
        Thu, 19 May 2022 10:24:52 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r71so5698894pgr.0;
        Thu, 19 May 2022 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Urg/PvF7N1ruHRzs7i4TJND15oOuTHDLyrPznJj/Hxc=;
        b=kTKRvi5qJaK55Z+CM6m2hFF158cWTIrDq1cpr8ksrG84+TEp9Z6KiVTWGUzHVB8YYV
         0p9Ze1zUdqX7m8vsXQGGfHgyellma0Wg7BG7+dEGNN8ad0gJibx1We05zemp/dd1mfrn
         2aiUH4k3DmJeFL1+mYSW+kHGW3WQJJAiOXreAXx+97i2D7JQplVGjC657IA0hHhP4LMM
         ABfE9IfONuyvAwZuGR0dx9Sk1mjozX9iiMxlyWScmAvst9l8iv8EOmpvktKav0qFWb/c
         oq+NSeuRiYVv1R/OrzqiD/z7kSfIuzIE+GnuLcJ2LK68FWtXB6JgYbB3OmXpHZQ2Q2Ki
         FjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Urg/PvF7N1ruHRzs7i4TJND15oOuTHDLyrPznJj/Hxc=;
        b=qYQUSHePWh5NRh1y8/HCWbUvxjutUayEev/amLzH/uo/axSCJzn2m0smWtPW70+Oze
         GRw+Gpn5FTRKSpWrRwG1DpTpTZa34nFEJb5rITsW7MyZ0evLU0vo13Rv/TdDi24qPLPp
         ybdjAeEgQB/53kQFNIessiVHJnUTb491HvCJqx1kI8WRuWDDHRi5swD5Lq/d4fQqlQpy
         JzBwBG+Mg+LZW1aZGUgE2L+AaeXjXs96oajH9nqAJAYq9obNciqhqlfsVi+Ufbm1u3sK
         o8fyoiLFPhwg5oPJhhoGEiAES3476S1FNb9evZYA4Td66A6oCyh0sBIl1FQwB7lHunhv
         iqSQ==
X-Gm-Message-State: AOAM531LNhpvoEfUwZa6hWn+mfHbqbcm9DWGp6YXaFYJ812C0WxnOTiN
        dZ9ogk4+Y7HxhZEjuD/nszhYu2eG8X46
X-Google-Smtp-Source: ABdhPJx4+FufxxmnsEncGa92MP0Kjx8yaN3r2hPBFqNyVm/e1rZxhPueIPCJCjmEAYSmUbuJiesaWw==
X-Received: by 2002:a63:1312:0:b0:3f2:678b:d166 with SMTP id i18-20020a631312000000b003f2678bd166mr4877001pgl.279.1652981091163;
        Thu, 19 May 2022 10:24:51 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 08/28] lib/pretty-printers: pr_string_option(), pr_bitflags()
Date:   Thu, 19 May 2022 13:24:01 -0400
Message-Id: <20220519172421.162394-9-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220519172421.162394-1-kent.overstreet@gmail.com>
References: <20220519172421.162394-1-kent.overstreet@gmail.com>
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
 lib/pretty-printers.c           | 58 +++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/pretty-printers.h
 create mode 100644 lib/pretty-printers.c

diff --git a/include/linux/pretty-printers.h b/include/linux/pretty-printers.h
new file mode 100644
index 0000000000..2e8b6b4426
--- /dev/null
+++ b/include/linux/pretty-printers.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRETTY_PRINTERS_H
+#define _LINUX_PRETTY_PRINTERS_H
+
+void pr_string_option(struct printbuf *, const char * const[], size_t);
+void pr_bitflags(struct printbuf *, const char * const[], u64);
+
+#endif /* _LINUX_PRETTY_PRINTERS_H */
diff --git a/lib/Makefile b/lib/Makefile
index 31a3904eda..98e9aefe62 100644
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
index 0000000000..d794648ef9
--- /dev/null
+++ b/lib/pretty-printers.c
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/* Copyright (C) 2022 Kent Overstreet */
+
+#include <linux/kernel.h>
+#include <linux/printbuf.h>
+
+/**
+ * pr_string_option - Given a list of strings, print out the list and indicate
+ * which option is selected, with square brackets (sysfs style)
+ *
+ * @out: The printbuf to output to
+ * @list: List of strings to choose from
+ * @selected: The option to highlight, with square brackets
+ */
+void pr_string_option(struct printbuf *out,
+		      const char * const list[],
+		      size_t selected)
+{
+	size_t i;
+
+	for (i = 0; list[i]; i++) {
+		if (i)
+			pr_char(out, ' ');
+		if (i == selected)
+			pr_char(out, '[');
+		pr_str(out, list[i]);
+		if (i == selected)
+			pr_char(out, ']');
+	}
+}
+EXPORT_SYMBOL(pr_string_option);
+
+/**
+ * pr_bitflags: Given a bitmap and a list of names for each bit, print out which
+ * bits are on, comma separated
+ *
+ * @out: The printbuf to output to
+ * @list: List of names for each bit
+ * @flags: Bits to print
+ */
+void pr_bitflags(struct printbuf *out,
+		 const char * const list[], u64 flags)
+{
+	unsigned bit, nr = 0;
+	bool first = true;
+
+	while (list[nr])
+		nr++;
+
+	while (flags && (bit = __ffs(flags)) < nr) {
+		if (!first)
+			pr_buf(out, ",");
+		first = false;
+		pr_str(out, list[bit]);
+		flags ^= 1 << bit;
+	}
+}
+EXPORT_SYMBOL(pr_bitflags);
-- 
2.36.0

