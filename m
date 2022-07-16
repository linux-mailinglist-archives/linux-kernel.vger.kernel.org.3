Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BE057726A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiGPXRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiGPXRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86518205E2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:20 -0700 (PDT)
Message-ID: <20220716230952.961938321@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p8GTJK4uVYYWM5yuu2sRowR6EatmieQ3CSBXbtGpA7Y=;
        b=aKGmpOd9sTKxdTKiJrrxBYpom9/s95YW6pVGZJ0lCejgk5Bd4nXs3he7YeTNvexFk1IOQT
        qnyUYiguuaJ2bLMiNR+EYcOu5FcLLb6fREYyNHcpHnmjcC0aWYRNV9nXI744dL+fvztI+q
        xjTBdxF6PmLfh8WgWciXYC0jNvYwjkgBYSwdLo9CcC7I3RU7oTCinB8OTVSEBWRgp6wUww
        xE9eW5MDU0wUKBZquB/gWn6KZExqyOK5DmJDYD1neDjSZbOLigt18aXKKymGz9hD9iJrkE
        CQePDho/UnoqHuub+a/ISYHQN4n7xr7UoMelJX52XKMBzAdKDRxSkwXWJiH3pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=p8GTJK4uVYYWM5yuu2sRowR6EatmieQ3CSBXbtGpA7Y=;
        b=CJ/Bj37JqHXtrkPxCzWul5ExTkkfB0MEIecJTARcSh8rCbrzSiVBCJifeln5nfCED6l8mS
        UAiwzCIQLmfo49DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 05/38] btree: Initialize early when builtin
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An upcoming user of btree needs it early on. Initialize it in
start_kernel().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/btree.h |    6 ++++++
 init/main.c           |    2 ++
 lib/btree.c           |    8 +++++++-
 3 files changed, 15 insertions(+), 1 deletion(-)

--- a/include/linux/btree.h
+++ b/include/linux/btree.h
@@ -5,6 +5,12 @@
 #include <linux/kernel.h>
 #include <linux/mempool.h>
 
+#if IS_BUILTIN(CONFIG_BTREE)
+extern void btree_cache_init(void);
+#else
+static inline void btree_cache_init(void) {}
+#endif
+
 /**
  * DOC: B+Tree basics
  *
--- a/init/main.c
+++ b/init/main.c
@@ -75,6 +75,7 @@
 #include <linux/signal.h>
 #include <linux/idr.h>
 #include <linux/kgdb.h>
+#include <linux/btree.h>
 #include <linux/ftrace.h>
 #include <linux/async.h>
 #include <linux/shmem_fs.h>
@@ -1125,6 +1126,7 @@ asmlinkage __visible void __init __no_sa
 	cgroup_init();
 	taskstats_init_early();
 	delayacct_init();
+	btree_cache_init();
 
 	poking_init();
 	check_bugs();
--- a/lib/btree.c
+++ b/lib/btree.c
@@ -787,15 +787,21 @@ static int __init btree_module_init(void
 	return 0;
 }
 
+#if IS_MODULE(CONFIG_BTREE)
 static void __exit btree_module_exit(void)
 {
 	kmem_cache_destroy(btree_cachep);
 }
 
-/* If core code starts using btree, initialization should happen even earlier */
 module_init(btree_module_init);
 module_exit(btree_module_exit);
 
 MODULE_AUTHOR("Joern Engel <joern@logfs.org>");
 MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
 MODULE_LICENSE("GPL");
+#else
+void __init btree_cache_init(void)
+{
+	BUG_ON(btree_module_init());
+}
+#endif

