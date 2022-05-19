Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3F752DB4A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242915AbiESR2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242862AbiESR0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:26:09 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF6ADFF6A;
        Thu, 19 May 2022 10:25:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s14so5374712plk.8;
        Thu, 19 May 2022 10:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Conle3R7/rWLrdvm5pHUbuFYVfzx4ZhW28hlaDoo5UE=;
        b=h6nyI75WW6zrfYSF1n9gm4XCazCn1PGX6/HpgzdprVrmdogWSiHO3kJjCPbEgsqbax
         xx+VfzKLCLRocuARWkTVz1ctSLEeuDN+M5Wr4h6N4FFviA1UdQrZh1GwiwRAQDR0zLHO
         /fVg1CAoMI/APsK5Vbxs02R9nvaMunqQ18aOgFoq+5/cWUA951dj/hlSgVzh+y+rXMh2
         7YAZfgDC5V6BIOE3O+xeys/OtT8Wv/60sS5xaGcmS2SppkVYHPvc3KTssYxFMWCSs9ak
         lAVxSFOwo24iNnk5A6J7e9jjn9OyAa9R9YU83Qku0+/1m8vRk8D9YnUMuZKul7frOXMM
         TUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Conle3R7/rWLrdvm5pHUbuFYVfzx4ZhW28hlaDoo5UE=;
        b=kRBku3ynqv4m8zvu14mWu40umivqboCErFAEUQjyjG4kY25MIG03Y906+/qNNfCnx/
         TvqEYL95YBgH+xomRxN84bjr4Wb4a0HUzkxC1fgZbh8sfsWHcLJtSWV3EY5chaQTYCOf
         fTWDpIl3ghIsc0M3lNnhgXjs2wgD0cGMRCMerALTtjQSO/llT3uVAztVH2xSVLonzaAm
         /X04qTycms2zRP8JYlrX/nibJo8gxGK88uzOixeKfP6HxJwY97vMfRxiQZPMjpq3grT3
         r8iekYwgj8vrassZG3Hk3qW6zHCQXouaRJ22W90HDI7zzrvtk7qHrl5IjSPO0jlR0l/K
         VClQ==
X-Gm-Message-State: AOAM531/jgmcnLdj2b4D0VVttOaJiQiPiJREWqBHDIJQ8hKxS+XUlLhy
        VhGMU89lLj7KDc4Tsrhac8UvkOwjIHh1
X-Google-Smtp-Source: ABdhPJwPhcmLCAs6EVuey2Jc5ggnwZaqeYmHuvaGHSvzD3g45sk0aMZm/vyLoY0KgK+9sbwRmyCGxw==
X-Received: by 2002:a17:90a:e392:b0:1df:b078:8dbe with SMTP id b18-20020a17090ae39200b001dfb0788dbemr6776271pjz.105.1652981139849;
        Thu, 19 May 2022 10:25:39 -0700 (PDT)
Received: from zaphod.evilpiepirate.org (068-119-229-002.res.spectrum.com. [68.119.229.2])
        by smtp.gmail.com with ESMTPSA id y4-20020a655a04000000b003c6ab6ba06csm3859126pgs.79.2022.05.19.10.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 10:25:39 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org,
        pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        andriy.shevchenko@linux.intel.com, willy@infradead.org,
        x86@kernel.org
Subject: [PATCH v2 27/28] x86/resctrl: Convert to printbuf
Date:   Thu, 19 May 2022 13:24:20 -0400
Message-Id: <20220519172421.162394-28-kent.overstreet@gmail.com>
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

This converts from seq_buf to printbuf. We're using printbuf in external
buffer mode, so it's a direct conversion, aside from some trivial
refactoring in cpu_show_meltdown() to make the code more consistent.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index b57b3db9a6..8e4f7773b7 100644
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
+	pr_str(&last_cmd_status, s);
 }
 
 void rdt_last_cmd_printf(const char *fmt, ...)
@@ -74,7 +74,7 @@ void rdt_last_cmd_printf(const char *fmt, ...)
 
 	va_start(ap, fmt);
 	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+	vpr_buf(&last_cmd_status, fmt, ap);
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

