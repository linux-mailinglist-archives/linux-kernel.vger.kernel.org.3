Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA99953D84E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 21:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240844AbiFDTda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 15:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiFDTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 15:32:06 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54ED4F9E6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 12:31:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id x7so7964192qta.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1KhCKnVaLX/kVfWuiSwPJQ3smEaMf/clD1IjnRzWHRY=;
        b=gMBTMfBQ8/cbt+ZlKXMwQ9hAKNl1Pbu4zN3nJBZqB4T+bsbNZCQpS1AOuL/2nTdvGy
         vW4m91ZR2m7ulMRaQsaT/opV3auOjxmygX0MJzr3eTrK+ZNTXqs4LMFCHGV6JevBBCc+
         d973RH1IDE0vXB9dyCQCaTzT8i/2zX9WKEFVZAOXNKhrwbzyeRbbWDC2qcpoR00N6reG
         bmACbuX6ZNEScb7rMHqnHhykRe5VioXaE+DOIW80UWS8acmFQwju17ryghcThZEkY1m7
         aY7XfpjEIje0B3IXlJwM4CWhrARsjra7au+adJK+6Unem6bJwPDeo6FTgLT5YOQY2Pxw
         Rgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1KhCKnVaLX/kVfWuiSwPJQ3smEaMf/clD1IjnRzWHRY=;
        b=WwNCNRpUb21WwzIja5wQCg5LJBrlZmvOWyPWdRhRsD/HZf2OS8ev0gxw/g82XLe+O6
         2E3grIbI+C/7qa6bwV3itYn3JBM8nVWGr+NvmiqOicon6pNDfYHjmlIjV1lOueI7ab7Z
         LcoKhDyK0xoIwvdH1SIfV5WwnXdkoM0F5PJ4bB3M1wCrOCjb6NdnriyHDQlODQyLq/j2
         gUwnl6Mi8hotezJHHeEIBeAVvYkeGTahbHyfyX09v4UN6REbzhjpcOaJl6VHvSmUtuYO
         iD5qw5qlkzb0RyguQAalxo2BL9ZkQN3uePNj91DvVrk9DtTn2dN+JLaXD9wbnyQYLTai
         VmUg==
X-Gm-Message-State: AOAM533hjnlNt8IRf+IYl7k8w/ulUIlOi+Oe9tOMG49+VY1AnIIRi/SB
        ObrrDcurJL7HL26dpUT+gZX49G4Xyygs
X-Google-Smtp-Source: ABdhPJxZ34TJtN2Hlrhiy+Lza2bHPLROoEr/P4uJ4PkL4qttBONUCc0sNV919ANU3/TyhcUjA7+E+g==
X-Received: by 2002:a05:622a:58f:b0:2f9:16f3:95b0 with SMTP id c15-20020a05622a058f00b002f916f395b0mr12960409qtb.493.1654371092562;
        Sat, 04 Jun 2022 12:31:32 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id o17-20020ac84291000000b00304defdb1b3sm3537426qtl.85.2022.06.04.12.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jun 2022 12:31:31 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, pmladek@suse.com,
        rostedt@goodmis.org, x86@kernel.org
Subject: [PATCH v3 28/33] x86/resctrl: Convert to printbuf
Date:   Sat,  4 Jun 2022 15:30:37 -0400
Message-Id: <20220604193042.1674951-29-kent.overstreet@gmail.com>
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

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 83f901e2c2..5b6720b6a4 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -19,7 +19,7 @@
 #include <linux/fs_parser.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
-#include <linux/seq_buf.h>
+#include <linux/printbuf.h>
 #include <linux/seq_file.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
@@ -51,7 +51,7 @@ static struct kernfs_node *kn_mongrp;
 /* Kernel fs node for "mon_data" directory under root */
 static struct kernfs_node *kn_mondata;
 
-static struct seq_buf last_cmd_status;
+static struct printbuf last_cmd_status;
 static char last_cmd_status_buf[512];
 
 struct dentry *debugfs_resctrl;
@@ -59,13 +59,13 @@ struct dentry *debugfs_resctrl;
 void rdt_last_cmd_clear(void)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_clear(&last_cmd_status);
+	printbuf_reset(&last_cmd_status);
 }
 
 void rdt_last_cmd_puts(const char *s)
 {
 	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_puts(&last_cmd_status, s);
+	prt_str(&last_cmd_status, s);
 }
 
 void rdt_last_cmd_printf(const char *fmt, ...)
@@ -74,7 +74,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 	va_start(ap, fmt);
 	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+	prt_vprintf(&last_cmd_status, fmt, ap);
 	va_end(ap);
 }
 
@@ -833,7 +833,7 @@ static int rdt_last_cmd_status_show(struct kernfs_open_file *of,
 	int len;
 
 	mutex_lock(&rdtgroup_mutex);
-	len = seq_buf_used(&last_cmd_status);
+	len = printbuf_written(&last_cmd_status);
 	if (len)
 		seq_printf(seq, "%.*s", len, last_cmd_status_buf);
 	else
@@ -3248,8 +3248,8 @@ int __init rdtgroup_init(void)
 {
 	int ret = 0;
 
-	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
-		     sizeof(last_cmd_status_buf));
+	last_cmd_status = PRINTBUF_EXTERN(last_cmd_status_buf,
+					  sizeof(last_cmd_status_buf));
 
 	ret = rdtgroup_setup_root();
 	if (ret)
-- 
2.36.0

