Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933F558C1C0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237367AbiHHCmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241934AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E615B25D5
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PdlpiFKX35KK8r3Bv1PVQ9ch5aGjfo6klq0s7Ja/ZcU=; b=oavNtuqiUYqRRZhJ0sIwHV2ERi
        QtwceMggiiUt4buzv5kNGHnxwn78DqQLJ9+zdX3PyUGRwKMMT3uQ9a14miL94tKa8TDlz5IMHHpnv
        CvymKXqKOcfi9tdYZHtcsaGyJI6dp4ahgWSNVtOq/ZRG9gGAoE2ZRR8FT7RCCGOgebyhM/p4wXPb2
        XmyW8qkOjaWxz7nlCbLBKTuX3JFkcZ4vAxSnUH1pJNZyk7fZ0Z/AN0QDUbHiQuGRn6OdSEPOPQw9y
        ulUb13Y3kdgROubNzvA3OSf21ei2nqJVFl86XRx1ceCMc7VAWy/SD8vBX7aqpwkDSduDQwxzJPT1D
        OBUNPUaw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSp-Vf; Mon, 08 Aug 2022 02:41:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v5 29/32] d_path: prt_path()
Date:   Mon,  8 Aug 2022 03:41:25 +0100
Message-Id: <20220808024128.3219082-30-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

This implements a new printbuf version of d_path()/mangle_path(), which
will replace the seq_buf version.

Part of what we're trying to do with printbufs is standardizing a
calling convention so they don't have to live in lib/vsprintf.c, and can
instead with the code for the types they're printing - so this patch
adds prt_path() to d_path.c, another patch will switch vsprintf.c to use
it.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
---
 fs/d_path.c            | 35 +++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 36 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f15..1bd9e85f2f65 100644
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
index c73e5e327e76..bdd5940aa75a 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -293,6 +293,7 @@ extern char *d_absolute_path(const struct path *, char *, int);
 extern char *d_path(const struct path *, char *, int);
 extern char *dentry_path_raw(const struct dentry *, char *, int);
 extern char *dentry_path(const struct dentry *, char *, int);
+extern int prt_path(struct printbuf *, const struct path *, const char *);
 
 /* Allocation counts.. */
 
-- 
2.35.1

