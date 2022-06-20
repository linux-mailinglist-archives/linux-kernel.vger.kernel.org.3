Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344A6550E0F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbiFTApN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238418AbiFTAnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:51 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8949325F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:47 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id c83so6889035qke.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X/vHm1f3WoFXRt6JUj3SilR7opGdtbcYgwZ9r1atlS8=;
        b=merDOSNMLYB6urSNHfDzTPlO9cTnNP2/a+Co95AIL+tp45UY1ESEm0GqSiRzYXGjPq
         lKJyO17f8asxDNlFx3YoHH74RPB12Y1OXa3miHqcxl3nepJtQLBUO9Vv5UHdySoFPh8K
         PGKEHVHhgt9ZYBn4DvdxjpTQB5GqGkaI+LQAnRZWVQ8SX7TbDJNlwW2CW67lMlBrQaqM
         fHJMTDRHSDe1GvdIBQNm34YtHj7FhTmUjvYWB9DPu2p8WHbZTwICJGdaIzqbiHLk2tuN
         ZC81jsJMxRKZ1U5KcvigCc/Eahf5rQRytJ7Y04hPgHNB3cyrUwmXC8gLtHcpNZqCkTdj
         ugFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X/vHm1f3WoFXRt6JUj3SilR7opGdtbcYgwZ9r1atlS8=;
        b=RNpibXciZBe1JI2iQu6GRfQih+FQnTZir4KnBSwwf0XK/EptASStvZ9mWFD6EY35Mv
         6Ld5Wx3S5b6lYCf2lnt8SDUzgCzjVXQBbqMEi7iLlCT8xk5gwF0MCSVpaemnc+za+JQ0
         HhsglhcWB0/zVVSYFfXeeXM09tCVceReNY8maWT2HTzyCci8Efa5b6ycH9k64oBCNA0N
         T7qUIxQNJ9Bs3o5wVf9D6WqpJPGzIQaPVau1Ko47VPzKL/Sfn/vG4L9D+YBi+OyFfCg4
         //37bewFjBRXrmQDvPPpJnMM4hNTKePNLrTMyByOfBa5hYvaQUG8h1ov7J3KuoezzYRK
         wMQQ==
X-Gm-Message-State: AJIora81UwKzHr5tR0n857GjpEXxMw7tHF4Tsh2W1aOSYbvsrZ0m/ZcW
        oWXc4pavf4X5FS9k7GbSQO9U43e6bVkj+Hk=
X-Google-Smtp-Source: AGRyM1shE4oiEAmMw5aoUvXut3DE6PwvQ/fgFRcao0IJAPOeGEA0eOkJ0l5lxSyNWcz00L20yvlfpg==
X-Received: by 2002:a05:620a:2720:b0:6a7:c28:3afa with SMTP id b32-20020a05620a272000b006a70c283afamr14575088qkp.438.1655685825745;
        Sun, 19 Jun 2022 17:43:45 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id bq38-20020a05620a46a600b006a785ba0c25sm10096007qkb.77.2022.06.19.17.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:44 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org
Subject: [PATCH v4 31/34] d_path: prt_path()
Date:   Sun, 19 Jun 2022 20:42:30 -0400
Message-Id: <20220620004233.3805-32-kent.overstreet@gmail.com>
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

This implements a new printbuf version of d_path()/mangle_path(), which
will replace the seq_buf version.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/d_path.c            | 35 +++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f..1bd9e85f2f 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -5,6 +5,7 @@
 #include <linux/fs_struct.h>
 #include <linux/fs.h>
 #include <linux/slab.h>
+#include <linux/printbuf.h>
 #include <linux/prefetch.h>
 #include "mount.h"
 
@@ -294,6 +295,40 @@ char *d_path(const struct path *path, char *buf, int buflen)
 }
 EXPORT_SYMBOL(d_path);
 
+/**
+ * prt_path - format a path for output
+ * @out: printbuf to output to
+ * @path: path to write into the sequence buffer.
+ * @esc: set of characters to escape in the output
+ *
+ * Write a path name into the sequence buffer.
+ *
+ * Returns 0 on success, or error code from d_path
+ */
+int prt_path(struct printbuf *out, const struct path *path, const char *esc)
+{
+	char *p, *buf;
+	size_t size;
+again:
+	buf = out->buf + out->pos;
+	size = printbuf_remaining_size(out);
+
+	p = d_path(path, buf, size);
+	if (IS_ERR(p)) {
+		printbuf_make_room(out, max_t(size_t, 64, size * 2));
+		if (printbuf_remaining_size(out) > size)
+			goto again;
+
+		return PTR_ERR(p);
+	}
+
+	p = mangle_path(buf, p, esc);
+	if (p)
+		out->pos += p - buf;
+	return 0;
+}
+EXPORT_SYMBOL(prt_path);
+
 /*
  * Helper function for dentry_operations.d_dname() members
  */
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index f5bba51480..2181144f9f 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -293,6 +293,7 @@ extern char *d_absolute_path(const struct path *, char *, int);
 extern char *d_path(const struct path *, char *, int);
 extern char *dentry_path_raw(const struct dentry *, char *, int);
 extern char *dentry_path(const struct dentry *, char *, int);
+extern int prt_path(struct printbuf *, const struct path *, const char *);
 
 /* Allocation counts.. */
 
-- 
2.36.1

