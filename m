Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A541D52DB29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242670AbiESRZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242600AbiESRY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FA6A5012;
        Thu, 19 May 2022 10:24:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so1947920plj.0;
        Thu, 19 May 2022 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L8iwJ9KMm4n/JzWy8qd0BmKy4V9nQfOKn1lqPdviiLg=;
        b=KG4XwmRf0vMgoko6EfDoSBe0U5MdiIjKw2pDox2XLhBcvj/Wy9pBDz+XVt8+3oMz7m
         ilgB55zWZGMYdiPzzGWq0LWd72nQF1drhAbSAfmCdT8B+reV2pgUmp3psLc7DBnChiFy
         xUK96KUN1BJeHGj1o60k5gR1VyVqSlVHizf8PRSSayo26kX/ZJU9dEDtDdsgisRiUJ/k
         huedI3FiAfEZasJM/s0AttK/75a/F7QO1nJiV9ti9QkeCeDmtOuonUdjwIA10jpvgUY6
         wfOigNeOiz69OTNnfYlC3RrL7xqqMWkjk7G6z9qaHA3+sN8CKFIm46MLwu9xmBhCnjmg
         zLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L8iwJ9KMm4n/JzWy8qd0BmKy4V9nQfOKn1lqPdviiLg=;
        b=WrLXhxh1mD8mrBIFovScZa4LA6Lbr4dmMNw1sDkvF1EpqrXyWlajs9W3cJuW/Dj6y4
         QAA59SsyOPpLnPCCkAMVbKPIHOAf5dUFGHtZBQcYMWZgS2tozrZNQYzo5tTpcPYMqQNJ
         mq+hD4rV20pL9lQB6jS7meidFsMPMsm068so+4Nxx+TUbUSoiwun7E9tgGCHzzWUfM8w
         jTNYF58sqeIFUUQfP9okGesmFtCmlZY5TEKqJuHeVoTVZdhKGF09S9dZttdTGGtlPXEZ
         zOUAtxL2e8S7kLO8osKklKiURctd9dbXwOlszP48K1kau/4fG8Og9z+F/FVyWVjpAgm/
         UrKw==
X-Gm-Message-State: AOAM532mDRO1t9YdxWOrC0mlneGwly30X4OR+/WotyMzxoNLJ/+CXJ+s
        HJV1W9sgmmpgOdXDjjji2Jjqz4wlf5gF
X-Google-Smtp-Source: ABdhPJwNAsXk8WrlQNmMUxOiakWa8HRVa3XKgG63gL+oghxcu3tQJZVMw0yfIaqOJOUvdI8yXemssA==
X-Received: by 2002:a17:902:ea46:b0:15d:dbc:34f2 with SMTP id r6-20020a170902ea4600b0015d0dbc34f2mr5636922plg.60.1652981088676;
        Thu, 19 May 2022 10:24:48 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:47 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 07/28] lib/printbuf: Unit specifiers
Date:   Thu, 19 May 2022 13:24:00 -0400
Message-Id: <20220519172421.162394-8-kent.overstreet@gmail.com>
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
index 798e067457..c7919ae721 100644
--- a/include/linux/printbuf.h
+++ b/include/linux/printbuf.h
@@ -53,10 +53,19 @@
  *
  * Make sure you use pr_newline() instead of \n in the format string for indent
  * level and tabstops to work corretly.
+ *
+ * Output units: printbuf->units exists to tell pretty-printers how to output
+ * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
+ * human readable bytes. pr_units() and pr_sectors() obey it.
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
@@ -83,6 +94,10 @@ void pr_indent_add(struct printbuf *, unsigned);
 void pr_indent_sub(struct printbuf *, unsigned);
 void pr_tab(struct printbuf *);
 void pr_tab_rjust(struct printbuf *);
+void pr_human_readable_u64(struct printbuf *, u64);
+void pr_human_readable_s64(struct printbuf *, s64);
+void pr_units_u64(struct printbuf *, u64);
+void pr_units_s64(struct printbuf *, s64);
 
 /* Initializer for a heap allocated printbuf: */
 #define PRINTBUF ((struct printbuf) { .heap_allocated = true })
diff --git a/lib/printbuf.c b/lib/printbuf.c
index c9f730a215..b99d4b0dff 100644
--- a/lib/printbuf.c
+++ b/lib/printbuf.c
@@ -9,6 +9,7 @@
 #endif
 
 #include <linux/slab.h>
+#include <linux/string_helpers.h>
 #include <linux/printbuf.h>
 
 static inline size_t printbuf_linelen(struct printbuf *buf)
@@ -193,3 +194,59 @@ void pr_tab_rjust(struct printbuf *buf)
 	buf->tabstop++;
 }
 EXPORT_SYMBOL(pr_tab_rjust);
+
+/**
+ * pr_human_readable_u64 - Print out a u64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void pr_human_readable_u64(struct printbuf *buf, u64 v)
+{
+	printbuf_make_room(buf, 10);
+	buf->pos += string_get_size(v, 1, !buf->si_units,
+				    buf->buf + buf->pos,
+				    printbuf_remaining(buf));
+}
+EXPORT_SYMBOL(pr_human_readable_u64);
+
+/**
+ * pr_human_readable_s64 - Print out a s64 in human readable units
+ *
+ * Units of 2^10 (default) or 10^3 are controlled via @buf->si_units
+ */
+void pr_human_readable_s64(struct printbuf *buf, s64 v)
+{
+	if (v < 0)
+		pr_char(buf, '-');
+	pr_human_readable_u64(buf, abs(v));
+}
+EXPORT_SYMBOL(pr_human_readable_s64);
+
+/**
+ * pr_human_readable_u64 - Print out a u64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void pr_units_u64(struct printbuf *out, u64 v)
+{
+	if (out->human_readable_units)
+		pr_human_readable_u64(out, v);
+	else
+		pr_buf(out, "%llu", v);
+}
+EXPORT_SYMBOL(pr_units_u64);
+
+/**
+ * pr_human_readable_s64 - Print out a s64 according to printbuf unit options
+ *
+ * Units are either raw (default), or human reabable units (controlled via
+ * @buf->human_readable_units)
+ */
+void pr_units_s64(struct printbuf *out, s64 v)
+{
+	if (v < 0)
+		pr_char(out, '-');
+	pr_units_u64(out, v);
+}
+EXPORT_SYMBOL(pr_units_s64);
-- 
2.36.0

