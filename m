Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36043593408
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiHOR1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbiHOR0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:31 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54E6FD17
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:30 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yhQDfoOmh4Mp5y5JtpsPUZ1S+MWlSFeCxKSY2ihEucw=;
        b=lJtMCkHkTXwe3RkzBIyJ9CaGCVSO/mAn8DUqAw3DU9HRaiPnAz+Mu0cNeCr6UvviNShvGx
        LYx7PBnF419zswuRMkGQhlZOb66DVBeVBIhBs5WZwhp1u4y5mUSBCCSHEYP1eoaxghxTsS
        ZeDOEWv57LxP+9Ejd5XZoPhiMGte82s=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 08/11] d_path: prt_path()
Date:   Mon, 15 Aug 2022 13:26:10 -0400
Message-Id: <20220815172613.621627-9-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
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

This implements a new printbuf version of d_path()/mangle_path(), which
will replace the seq_buf version.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
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
index c73e5e327e..bdd5940aa7 100644
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

