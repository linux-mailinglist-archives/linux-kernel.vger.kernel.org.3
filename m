Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392D1593401
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiHOR0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiHOR02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:28 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6249DFFE
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/lKX9ZUHXzC0bBF9SIiQeiiomTeFjfSeB/rTpQxZUs=;
        b=Pfp6qi9ztVQJ4exOVEkmktvoB/yykemr4v2qos611DnZRe+HnL9nvO95Kd/A5pFqyKsnDZ
        B5zdqhvR1flEd0zso4JjQLgfTEUQW9Nx9dPPRQwWdlgzfAyjRpph4huOzqVgc8LpWDzOij
        XiwRGRVWnfhqXyd7BEELuPKZ1rU0mIU=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>, x86@kernel.org
Subject: [PATCH 05/11] x86/resctrl: Convert to printbuf
Date:   Mon, 15 Aug 2022 13:26:07 -0400
Message-Id: <20220815172613.621627-6-kent.overstreet@linux.dev>
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

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode so it's a trivial direct conversion.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index f276aff521..50c12711a2 100644
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

