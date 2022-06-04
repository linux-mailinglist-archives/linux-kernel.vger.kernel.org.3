Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401F853D864
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiFDTdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbiFDTcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:32:13 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87854FC4B
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id x65so8383015qke.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ifovngagXEclMNUOGWmhploQA6POSVt6ng3YeKVo7U=;
        b=PRjSJrgW3U/L87AYtaENt1TjxKHHUSfXQuEFlqHACigby6EqGnHAmSr2cqz2vdcD0s
         elc1r0BadJJj96s8r5YoNLdtKDs/W/C5p0crvIj++uEUPSJ+BLfNG0NDg5cfTNOkAq5X
         xA+iOOGuj+EX6MPqBifK56VWk9GOD2G4Jwl3mqIsg8xA8BbhHvdvTlvqciBDrqajSqMq
         iboHZoya/EDGPEXXrHOYduFRKyBklICt5cKY3RwEMiaodgi7LDuwwUawswjcQ+oG7fpD
         lfv+JmQbbwnQie+T/CucuRu22JqRzTo9zJjG9bG++/JB662llwNat+0YHZyHh1blPPGG
         0oAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ifovngagXEclMNUOGWmhploQA6POSVt6ng3YeKVo7U=;
        b=5PBGIri/Ew+fCIkOoAiA+A5p4P5e4bMF66t8lw9hiSUUoXvjIgOkajisKf31tAPMEC
         zAN90MeSzDBlSy9ELd18OerC587NcSbXAp5U2oQGWJzrLbO6wn6iUU1oqfOWMxJ5ptKJ
         cSwKlTNZyTsg4EM18jhdIojHz+fcgteaQMsI+5X5puO8oU5TXRpTrl1qj08xjbwxY96c
         dvRzrB/YdumSvdFJfOIINl0J1wiIRJTUrvFuuHJEkZHdjk1U1D6grSCsbJ/mdwyLG5pz
         Uha8OUBi9UKhXil0M1yJformXxLchISK4sR05qGsTXS0kLREhHt+cX8lzPpOXZYZgvaf
         FHfw==
X-Gm-Message-State: AOAM532ApEFDZ9gTswoJRcKDXjd4tZhVYNxVYzmG4W37PhTVbc6NgGMR
        MlRCmJBx2lZ5Fy6eLiCQBYMXFOzDpemE
X-Google-Smtp-Source: ABdhPJwM2iDqN9G3t6ZQgs7+9spOd6m3aHpCPX0WrWpeQ6Smg+iy7nqX6/Y5/Mrw6WR5mTMXGI+Ecw==
X-Received: by 2002:a05:620a:9:b0:6a6:b064:882e with SMTP id j9-20020a05620a000900b006a6b064882emr1726068qki.445.1654371097463;
        Sat, 04 Jun 2022 12:31:37 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:36 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org
Subject: [PATCH v3 31/33] d_path: prt_path()
Date:   Sat,  4 Jun 2022 15:30:40 -0400
Message-Id: <20220604193042.1674951-32-kent.overstreet@gmail.com>
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

This implements a new printbuf version of d_path()/mangle_path(), which
will replace the seq_buf version.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 fs/d_path.c            | 34 ++++++++++++++++++++++++++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 35 insertions(+)

diff --git a/fs/d_path.c b/fs/d_path.c
index e4e0ebad1f..2aa8dfc1a7 100644
--- a/fs/d_path.c
+++ b/fs/d_path.c
@@ -294,6 +294,40 @@ char *d_path(const struct path *path, char *buf, int buflen)
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
+		printbuf_make_room(out, max(64, size * 2));
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
2.36.0

