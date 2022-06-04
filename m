Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED3053D857
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiFDTbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240162AbiFDTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA234F9EF
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:06 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k6so5324321qkf.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pog5jNfp5Dd2Cu5seYQ54yFgRVpvLlcCiIm5Dkf3KrE=;
        b=RCoLQOLwAttABgmnV+OZmfgfRp+eEI9LMGbFWz6kp/iyeIPrJrcsQdUb4SpRUX7J/g
         i3/BGpjrxunt+M+Xp/WwLcpPMx6GWO8VYWAMvdGsEzL0lbs5IVxfhfLVtPSe7x3lzbzj
         cGf5iWZRIHHyURMHuuQQ6ibZtbZCuhwFYUKMux9UdquFvfXHIMKoXswPrFJCzT7bOK5p
         eEjuAyFohBkwJ3Cp5SM/m09jwvMAnufCQa4B+I9kY4PcjgIcm77cOqx90Zn5BzkTyntN
         4QGkgV/xvYj0ikwopzwMUdBgjnIbpoG5NqI9DtRpyMC/LOcV15ZdiKPI/79jF08i99cT
         NskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pog5jNfp5Dd2Cu5seYQ54yFgRVpvLlcCiIm5Dkf3KrE=;
        b=bfpnr975gNcPs9t3QfB0umUHkt7wMxD8Ro2wJRBURcUb8lS1ifIns8YIJYZQ2nfQ9w
         kDx1FXCXFMcKHpf7TvIfUSHL94fZOBsZvROlmO5KqL+3haXYfisUEjoxoMID6HUfyiQz
         lPhZLE2RGsFcncPvjxZkw8o8tj3ycdaLAsQGMstNjpGbZghVfjgNtrESzTadY9/2lfla
         YUSTxqJNLXII5Dd/uw1VT6pEy7mjl2yc9B3b8ODxx5AbbTV2+nj3SzAyMUWATTQUlwke
         0oavr7T8GkScixe3R1BgbTp/ZXg13ixjh/p6Iha6Oonpxo9GlASe/k2f+aB+2ECzOh2A
         Y4ow==
X-Gm-Message-State: AOAM531z5cXJuadqf7PIZI8Xmb7h/px+Oz6MhqXIyO8XpHgCK9/6ON7J
        14Rw9+rZMPobersV8QQo93kVszfeOQ3z
X-Google-Smtp-Source: ABdhPJwuKU6FVRDhJFPAnStYbOLMeIElK7agJEfmYqpVzfU8QFQNiKlTrNoyNQzBefLEJXjaKmHYjw==
X-Received: by 2002:a37:a5d0:0:b0:6a6:7cbc:dc2a with SMTP id o199-20020a37a5d0000000b006a67cbcdc2amr9236853qke.496.1654371064885;
        Sat, 04 Jun 2022 12:31:04 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:04 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 10/33] lib/pretty-printers: prt_string_option(), prt_bitflags()
Date:   Sat,  4 Jun 2022 15:30:19 -0400
Message-Id: <20220604193042.1674951-11-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220604193042.1674951-1-kent.overstreet@gmail.com>
References: <20220604193042.1674951-1-kent.overstreet@gmail.com>
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
 lib/pretty-printers.c           | 59 +++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 1 deletion(-)
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
index 0000000000..8794eb3824
--- /dev/null
+++ b/lib/pretty-printers.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: LGPL-2.1+
+/* Copyright (C) 2022 Kent Overstreet */
+
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
2.36.0

