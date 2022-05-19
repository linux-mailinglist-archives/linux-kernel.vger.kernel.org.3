Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5082352DB1D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242546AbiESRYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbiESRYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:24:35 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91A3A30B8;
        Thu, 19 May 2022 10:24:32 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id nk9-20020a17090b194900b001df2fcdc165so9406007pjb.0;
        Thu, 19 May 2022 10:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AOewAjqDP3lAAYJgfWcVj1UOu5lLUzToNZ6Wvc+KtSg=;
        b=o7PvoY82ItPKwYBbxMn3eeGtB+88hpIirgruNU/rWUoKpUEAqSN8AOJmIKDsce5JFi
         UTYPp4rb4zmYUdXjv4RmmVYJVy3S+kuvgWvFsmqZDGGQmzxL2LeuQDl3ahDP4FRdZA8j
         900dw1oX1FkKmt20m515iWbKsmS8VgKJL2hZYp5lKEvchzH0Eewp5UZJBqtqPqVic5EH
         RF20B4iGdR38wQe+qn6Kbh+VMTzLJvHrydMTvN5QZY567vkCoDhNPdPix0kYs/jXAINc
         5tV2zX4xFQC9V9Rum8IT42fvmOhz3r6B3xqzH6NifaMli1XqIQwj81SHZJLbzm4LIZsZ
         1Xug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AOewAjqDP3lAAYJgfWcVj1UOu5lLUzToNZ6Wvc+KtSg=;
        b=zRYyoCVR6aFnlshEQu2JH0lkVe157NRIjvhRI+frGFzi1npR0ucTRHpvn8kzbXqzby
         tD/a/VYc+4wtF5s/ZReQfJGMwOrE39a4dQ+foYEQ8Cpzv89JNkDURUu46D2BAij8giMP
         tXYfOXJrgNQ/UoH1cRuRGOyY35UC5irvpluXSpNSKMnZFsZCk/P9ODGDGvcPv5qqebkR
         NCCydMRed/qlNiu5XHy1KlseUrCHCwC0VKUTpaclAnR6czq8n4f1x47AB3m5oabO2aOv
         L8hHhXEtDY971jyyr2BMQk2fexbdZ9rf9Vt+8FLPBVlF/ABK4GzDWgWqZnwUVwO9M8PM
         Qw3Q==
X-Gm-Message-State: AOAM5314CAbS2OgOB3mYMCB0GyhMPPHCn2oV37IBw9BK4AjTnyhdwl+G
        94VHaWkUDJkJFcJBM6ND1U7Ej7Qt0oLu
X-Google-Smtp-Source: ABdhPJwzE8ZdLVW+yuKBJt7vmP5Ln6NcdLktqI4MYHA6QA9b9e/mWT6r/+ml164G4C5gZpReHJkGcQ==
X-Received: by 2002:a17:903:22cd:b0:161:be20:577 with SMTP id y13-20020a17090322cd00b00161be200577mr5941328plg.54.1652981071739;
        Thu, 19 May 2022 10:24:31 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:24:31 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org
Subject: [PATCH v2 01/28] lib/printbuf: New data structure for printing strings
Date:   Thu, 19 May 2022 13:23:54 -0400
Message-Id: <20220519172421.162394-2-kent.overstreet@gmail.com>
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

This adds printbufs: a printbuf points to a char * buffer and knows the
size of the output buffer as well as the current output position.

Future patches will be adding more features to printbuf, but initially
printbufs are targeted at refactoring and improving our existing code in
lib/vsprintf.c - so this initial printbuf patch has the features
required for that.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 include/linux/printbuf.h | 94 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)
 create mode 100644 include/linux/printbuf.h

diff --git a/include/linux/printbuf.h b/include/linux/printbuf.h
new file mode 100644
index 0000000000..40dc07040d
--- /dev/null
+++ b/include/linux/printbuf.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022 Kent Overstreet */
+
+#ifndef _LINUX_PRINTBUF_H
+#define _LINUX_PRINTBUF_H
+
+#include <linux/string.h>
+
+/*
+ * Printbufs: String buffer for outputting (printing) to, for vsnprintf
+ */
+
+struct printbuf {
+	char			*buf;
+	unsigned		size;
+	unsigned		pos;
+};
+
+static inline unsigned printbuf_remaining(struct printbuf *out)
+{
+	return out->pos < out->size ? out->size - out->pos : 0;
+}
+
+static inline unsigned printbuf_written(struct printbuf *out)
+{
+	return min(out->pos, out->size);
+}
+
+static inline void printbuf_nul_terminate(struct printbuf *out)
+{
+	if (out->pos < out->size)
+		out->buf[out->pos] = 0;
+	else if (out->size)
+		out->buf[out->size - 1] = 0;
+}
+
+static inline void pr_chars(struct printbuf *out, char c, unsigned n)
+{
+	memset(out->buf + out->pos,
+	       c,
+	       min(n, printbuf_remaining(out)));
+	out->pos += n;
+	printbuf_nul_terminate(out);
+}
+
+static inline void __pr_char(struct printbuf *out, char c)
+{
+	if (printbuf_remaining(out))
+		out->buf[out->pos] = c;
+	out->pos++;
+}
+
+static inline void pr_char(struct printbuf *out, char c)
+{
+	__pr_char(out, c);
+	printbuf_nul_terminate(out);
+}
+
+static inline void pr_bytes(struct printbuf *out, const void *b, unsigned n)
+{
+	memcpy(out->buf + out->pos,
+	       b,
+	       min(n, printbuf_remaining(out)));
+	out->pos += n;
+	printbuf_nul_terminate(out);
+}
+
+static inline void pr_str(struct printbuf *out, const char *str)
+{
+	pr_bytes(out, str, strlen(str));
+}
+
+static inline void pr_hex_byte(struct printbuf *out, u8 byte)
+{
+	__pr_char(out, hex_asc_hi(byte));
+	__pr_char(out, hex_asc_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+static inline void pr_hex_byte_upper(struct printbuf *out, u8 byte)
+{
+	__pr_char(out, hex_asc_upper_hi(byte));
+	__pr_char(out, hex_asc_upper_lo(byte));
+	printbuf_nul_terminate(out);
+}
+
+#define PRINTBUF ((struct printbuf) { .si_units = PRINTBUF_UNITS_10 })
+#define PRINTBUF_EXTERN(_buf, _size)			\
+((struct printbuf) {					\
+	.buf	= _buf,					\
+	.size	= _size,				\
+})
+
+#endif /* _LINUX_PRINTBUF_H */
-- 
2.36.0

