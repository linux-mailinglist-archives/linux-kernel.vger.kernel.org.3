Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAACF58C1B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiHHCmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241862AbiHHClj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDCC25C7
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GVucidUOOwtQ2TJCPsgzEhLdwKKhX1FOI8GcU2GMl0g=; b=ISaWvnuqHzawQhPdc61l2Sxvkd
        WpOlQVvan5xH10oxr1v4QtaDOYTBgKIdnjePj3WSsmntzoVv1cZeDWgjqY9gf1YVBSR0GRg47zQ9C
        zNQOgZ3Pfx7iDHcwOroSP0crMagexUKgC5+fcakQ5ReQ98wNRNybzSv+B/Z8iZVI2y/ej2F0CHyod
        MalFPsk0dE2SI+lJDsOQx8Gta0gcdVWEd9luP4qK2SdlFQIrwn6JVx1Ar2x51Y+J5Rryb9k6iISEm
        YXr4cuPvSUtXF1nJVuZKJX9m081xfv6hWw/B+ty29iMyWhh7ex+QhBHUPjNS3BWkXQLwm6Ex8l4nz
        G/ykCLUg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshy-00DVSf-OB; Mon, 08 Aug 2022 02:41:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     x86@kernel.org
Subject: [PATCH v5 26/32] x86/resctrl: Convert to printbuf
Date:   Mon,  8 Aug 2022 03:41:22 +0100
Message-Id: <20220808024128.3219082-27-willy@infradead.org>
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

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f276aff521e8..50c12711a249 100644
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
2.35.1

