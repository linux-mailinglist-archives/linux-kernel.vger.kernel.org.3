Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1033759268C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 23:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240560AbiHNVVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbiHNVUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 17:20:53 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC52BC8E
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 14:20:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660512045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVFZnUSv4LU/k4o/AQOMyq1rkKuyBfrcSzAE/+TqtNc=;
        b=cJBmffJ939a2Pkhga1WomL8kabW9at1ZwYHpmpstrDzawB1GKEoR8zFEgxlUp4CnDLHMg1
        UqVzSSPrGG24ANJQDSDPiNLcpV4T2f84OjmbITcpfZy/1Krc2jFZCBBqeXjsBTryakXs6p
        ZoDmpL5LNXt8uDDwN7KdC95BKF7nOhU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 08/32] lib/printbuf: Unit specifiers
Date:   Sun, 14 Aug 2022 17:19:47 -0400
Message-Id: <20220814212011.1727798-9-kent.overstreet@linux.dev>
In-Reply-To: <20220814212011.1727798-1-kent.overstreet@linux.dev>
References: <20220814212011.1727798-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

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
index c1a482b6c0..ebbc4a55fc 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -57,11 +57,20 @@
  *
  * Make sure you use prt_newline() instead of \n in the format string for indent
  * level and tabstops to work corretly.
+ *
+ * Output units: printbuf->units exists to tell pretty-printers how to output
+ * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
+ * human readable bytes. prt_units() obeys it.
  */
 
 #include <linux/kernel.h>
 #include <linux/string.h>
 
+enum printbuf_si {
+	PRINTBUF_UNITS_2,	/* use binary powers of 2^10 */
+	PRINTBUF_UNITS_10,	/* use powers of 10^3 (standard SI) */
+};
+
 struct printbuf {
 	char			*buf;
 	unsigned		size;
@@ -75,6 +84,8 @@ struct printbuf {
 	u8			atomic;
 	bool			allocation_failure:1;
 	bool			heap_allocated:1;
+	enum printbuf_si	si_units:1;
+	bool			human_readable_units:1;
 	u8			tabstop;
 	u8			tabstops[4];
 };
@@ -88,6 +99,10 @@ void printbuf_indent_add(struct printbuf *, unsigned);
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
index 395c681e3a..0474700257 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -10,6 +10,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/printbuf.h>
 
 static inline size_t printbuf_linelen(struct printbuf *buf)
@@ -199,3 +200,59 @@ void prt_tab_rjust(struct printbuf *buf)
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
2.36.1

