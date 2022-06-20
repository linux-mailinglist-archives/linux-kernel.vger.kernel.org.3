Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367D550E24
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237855AbiFTApC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238407AbiFTAnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:43:50 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2101B48B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:39 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id cs6so9536748qvb.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Vdy/3q0z+zupAiyg6Yh4GOKkpWfVuARDkMzaW4uflk=;
        b=lBJ/nMwGEn+uWKxFE6E0xhdfP4zJLmfjV2Nrc5Ovw3Fi6FKL38hoxWIThEo3s2IhA9
         FJeOSspstzISx+42nRSaO8wVE9bJg4lXJNahcHxa2GW4NFD8Nprgv81TdWCyNqgydSSV
         w8KSIKhlYbrHt1XFl5TwkpjD3sUFMh2VRYTtXn/H8IpMePgGHHVxwT14A08+bS7szPKo
         ybAZX1rthru7tk0HirpC5pKjoJMH5L2UKtPDX0+Q8otXr+EHMp8mcm5nuss2+P2AEVjA
         tK34nsw1diiQ5kkI2D0CvD85QpKnLH3mqDx2x7Z6cL01Dsy3vnz5FBqybvFZ1+zAeGzk
         F6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Vdy/3q0z+zupAiyg6Yh4GOKkpWfVuARDkMzaW4uflk=;
        b=GmD14aoVTXwuuP9ijii/vSVQnNyZfQEntgE8SixQojsccMU9Webhr1AHKmZvtbAVlq
         PkdUcpXUpHpIZVeZa+bQMAZvnh+zOSDyWAeS3DY8pEt+RBEBzT8lFAEAI80aI8YSKzl0
         xHTKs0H64M2JdLIvtVA365ch1AtwrLDyaq1lstG+cXQpmj9sjp7L4az75FJb+LGAUciT
         9XKf6NSQmNqquqDjBdqBrB+gHcY9r4xyALGasMAfqk+7zopUewy6RQD7R+QLxJugtOjj
         zrihq8JwV6ueZZwl7hy3bPYenQys54h+PeEY7AwCy/tmOPAq7HC4/AGo35GHfsTeycJ/
         mdMg==
X-Gm-Message-State: AJIora9+akSXHpWDKhCf39ooChYTocYh3GUpk43Gr5abq2QjPZOjud+e
        DoRJkvIddOUt+BPZk2IuTPc8rskYmIhGApQ=
X-Google-Smtp-Source: AGRyM1tS4spvl8xZaQS5aL6s94wW+yGTeZDkgIKbZLzYbzrC5075+0KCox5+j5QeYPUegh322eL+9g==
X-Received: by 2002:a05:6214:21e5:b0:46d:82b5:b1a2 with SMTP id p5-20020a05621421e500b0046d82b5b1a2mr17234499qvj.116.1655685818521;
        Sun, 19 Jun 2022 17:43:38 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id z9-20020ac84549000000b0030515374a6asm9759352qtn.51.2022.06.19.17.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 17:43:37 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com
Cc:     Kent Overstreet <kent.overstreet@gmail.com>, rostedt@goodmis.org,
        enozhatsky@chromium.org, linux@rasmusvillemoes.dk,
        willy@infradead.org, x86@kernel.org
Subject: [PATCH v4 28/34] x86/resctrl: Convert to printbuf
Date:   Sun, 19 Jun 2022 20:42:27 -0400
Message-Id: <20220620004233.3805-29-kent.overstreet@gmail.com>
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
2.36.1

