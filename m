Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5F353D858
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240322AbiFDTbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240093AbiFDTbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:31:08 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D411D3388E
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:04 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x16so4677545qtw.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKb2EhCeklsdRsNI2YgRpJ34oLvZStS1bp2Vbt3uYtI=;
        b=c5Mv+jemCw0Zq3bfauzSeyeEO6D4d5jCRvMdGwhV3PqzD7pmreLQcvL9GujP2zip4/
         PABVDtalGEr20tVUR/7VVLgh7TLH2VQ7a24DfvZV8ftkt2GiQkmdC0O6GI1nxt5YmInH
         a0kWKsGb4gnfzaR68WRErtBIZ4r1PMyeXkR8zTzhkZ3XUmR6/g/23sVrhxzpimqtIbQV
         HHo2FakfY2dCANg/NncP23lRjPjvepLgtQksqIsqWd/NNPM8GCLIzMCjFQEGOf6cZawd
         il8cRaj5y78QXRGLlV6aSA1QclGJMI9xJ2tTtgpL3rG6EdvQBcm2INoLSDTpMl4sEfzP
         RvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKb2EhCeklsdRsNI2YgRpJ34oLvZStS1bp2Vbt3uYtI=;
        b=n46Z6alNP8mDZaon22v4TshwWfYBVQi1ZPhE7th3sDor+O1s2/Gqqpw1GNauIbQcwu
         bxxZYZHWx+UfgeJKf+0kcqt99xGPFliSM5xrDGfx7vHpjhm8c8vwgXzfffovvFcwTXbH
         5PSZl4EyfkBiKe7ndviL4ebyKm1cZkI/SznIFPpJ+kkmsrkZbJl1vFRB1EiS8rJ7A6ZW
         fTCUVBiW9kvCeNkkwEH/1m1L8WGaVX3XyEvhbmdJ2mvvAwFycv6TkKs5gadWkBO9HGu1
         vVG2+CcVRN8cN3iD84nMMdb7fnNdXefsAw9gkJsVo+w37YfNePz2nlssOqlIwXd37ELK
         70SQ==
X-Gm-Message-State: AOAM5337pkNyAcCF65qF/AhJKbhAaWnbXU3K5ZKl6bDe0RRvG4JSNRKl
        5dyZp5CI0+UpeAD82DHsJ9keNr6Xyw4U
X-Google-Smtp-Source: ABdhPJzkXjLJzjLhssNceqtD/ETx33XcAOdJGR14+fjgysVdAF2hLM3bTZFtIExMUB4ErNWvgjEmFQ==
X-Received: by 2002:ac8:7f92:0:b0:304:c4c0:f032 with SMTP id z18-20020ac87f92000000b00304c4c0f032mr12759448qtj.273.1654371063506;
        Sat, 04 Jun 2022 12:31:03 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:02 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 09/33] lib/printbuf: Unit specifiers
Date:   Sat,  4 Jun 2022 15:30:18 -0400
Message-Id: <20220604193042.1674951-10-kent.overstreet@gmail.com>
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

This adds options to printbuf for specifying whether units should be
printed raw (default) or with human readable units, and for controlling
whether human-readable units should be base 2 (default), or base 10.

This also adds new helpers that obey these options:

 - pr_human_readable_u64
 - pr_human_readable_s64
These obey printbuf->si_units

 - pr_units_u64
 - pr_units_s64
These obey both printbuf-human_readable_units and printbuf->si_units

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h | 15 +++++++++++
 lib/printbuf.c           | 57 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
index 8fb074eb67..9d6c951626 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -53,10 +53,19 @@
  *
  * Make sure you use prt_newline() instead of \n in the format string for indent
  * level and tabstops to work corretly.
+ *
+ * Output units: printbuf->units exists to tell pretty-printers how to output
+ * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
+ * human readable bytes. prt_units() obeys it.
  */
 
 #include <linux/string.h>
 
+enum printbuf_si {
+	PRINTBUF_UNITS_2,	/* use binary powers of 2^10 */
+	PRINTBUF_UNITS_10,	/* use powers of 10^3 (standard SI) */
+};
+
 struct printbuf {
 	char			*buf;
 	unsigned		size;
@@ -70,6 +79,8 @@ struct printbuf {
 	u8			atomic;
 	bool			allocation_failure:1;
 	bool			heap_allocated:1;
+	enum printbuf_si	si_units:1;
+	bool			human_readable_units:1;
 	u8			tabstop;
 	u8			tabstops[4];
 };
@@ -83,6 +94,10 @@ void printbuf_indent_add(struct printbuf *, unsigned);
 void printbuf_indent_sub(struct printbuf *, unsigned);
 void prt_tab(struct printbuf *);
 void prt_tab_rjust(struct printbuf *);
+void prt_human_readable_u64(struct printbuf *, u64);
+void prt_human_readable_s64(struct printbuf *, s64);
+void prt_units_u64(struct printbuf *, u64);
+void prt_units_s64(struct printbuf *, s64);
 
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
diff --git a/lib/printbuf.c b/lib/printbuf.c
index e11a504abf..88f1f34fe6 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -9,6 +9,7 @@
 #endif
 
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/printbuf.h>
 
 static inline size_t printbuf_linelen(struct printbuf *buf)
@@ -193,3 +194,59 @@ void prt_tab_rjust(struct printbuf *buf)
 	buf->tabstop++;
 }
 EXPORT_SYMBOL(prt_tab_rjust);
+
+/**
+ * prt_human_readable_u64 - Print out a u64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void prt_human_readable_u64(struct printbuf *buf, u64 v)
+{
+	printbuf_make_room(buf, 10);
+	buf->pos += string_get_size(v, 1, !buf->si_units,
+				    buf->buf + buf->pos,
+				    printbuf_remaining_size(buf));
+}
+EXPORT_SYMBOL(prt_human_readable_u64);
+
+/**
+ * prt_human_readable_s64 - Print out a s64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void prt_human_readable_s64(struct printbuf *buf, s64 v)
+{
+	if (v < 0)
+		prt_char(buf, '-');
+	prt_human_readable_u64(buf, abs(v));
+}
+EXPORT_SYMBOL(prt_human_readable_s64);
+
+/**
+ * prt_units_u64 - Print out a u64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void prt_units_u64(struct printbuf *out, u64 v)
+{
+	if (out->human_readable_units)
+		prt_human_readable_u64(out, v);
+	else
+		prt_printf(out, "%llu", v);
+}
+EXPORT_SYMBOL(prt_units_u64);
+
+/**
+ * prt_units_s64 - Print out a s64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void prt_units_s64(struct printbuf *out, s64 v)
+{
+	if (v < 0)
+		prt_char(out, '-');
+	prt_units_u64(out, abs(v));
+}
+EXPORT_SYMBOL(prt_units_s64);
-- 
2.36.0

