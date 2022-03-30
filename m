Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D55B4EBE01
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbiC3JtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiC3Js7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:48:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1172675B7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:47:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 490731F38C;
        Wed, 30 Mar 2022 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648633629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r3Sjn37oF7DqPiLc6iHgx5Yr2yGAhC+cwpP1k5ApyE0=;
        b=dD9z5OmXmE5y5F9WjsuJnHls2nDFA7BR+D5GLh5A7mjxKaG8a6MWfjiRtHLydS3DeEMIrs
        rcYkRNRzIYnq0FKRYjf05iyv6G4p/AAjnoHSLArjSy1xLalmLOqcHofBOP5EuqCgOGdbtY
        Px2u9fXMKFASSfBtGo03VPCzO4ReEls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648633629;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=r3Sjn37oF7DqPiLc6iHgx5Yr2yGAhC+cwpP1k5ApyE0=;
        b=cw+c/VKcBvex/u40GFnSYWfafh9XWXoovgXseKpSPa2iKUAj4uHLvS7a0tDPA+TAv2v/9b
        ycMBgaLf2Y3M8TCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8CB813A60;
        Wed, 30 Mar 2022 09:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ejfgNhwnRGJjZQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 30 Mar 2022 09:47:08 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] ns: Rename MAX_PID_NS_LEVEL to MAX_NS_LEVEL, move
Date:   Wed, 30 Mar 2022 11:47:03 +0200
Message-Id: <20220330094703.26075-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename MAX_PID_NS_LEVEL to MAX_NS_LEVEL, move it ns_common.h and reuse
it in check in user_namespace.c.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
changes v1->v2:
instead of reusing MAX_PID_NS_LEVEL for user_namespace.c create general
constant MAX_NS_LEVEL used in both (Christian)
That leaded to changes on more places.

As value 32 is likely to be used for any namespace it makes sense to
have this general variable instead of keeping MAX_PID_NS_LEVEL and
creating MAX_USER_NS_LEVEL.

Kind regards,
Petr

 include/linux/ns_common.h                     |  3 ++
 include/linux/pid_namespace.h                 |  3 --
 kernel/fork.c                                 |  4 +--
 kernel/pid_namespace.c                        |  4 +--
 kernel/user_namespace.c                       |  2 +-
 .../clone3/clone3_cap_checkpoint_restore.c    |  4 +--
 .../testing/selftests/clone3/clone3_set_tid.c | 30 +++++++++----------
 7 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/linux/ns_common.h b/include/linux/ns_common.h
index 0f1d024bd958..a84bc9d947a2 100644
--- a/include/linux/ns_common.h
+++ b/include/linux/ns_common.h
@@ -4,6 +4,9 @@
 
 #include <linux/refcount.h>
 
+/* MAX_NS_LEVEL is needed for limiting size of 'struct pid' */
+#define MAX_NS_LEVEL 32
+
 struct proc_ns_operations;
 
 struct ns_common {
diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 07481bb87d4e..f814068012d0 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -11,9 +11,6 @@
 #include <linux/ns_common.h>
 #include <linux/idr.h>
 
-/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
-#define MAX_PID_NS_LEVEL 32
-
 struct fs_pin;
 
 struct pid_namespace {
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..4965bc7f512e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2784,7 +2784,7 @@ noinline static int copy_clone_args_from_user(struct kernel_clone_args *kargs,
 	if (err)
 		return err;
 
-	if (unlikely(args.set_tid_size > MAX_PID_NS_LEVEL))
+	if (unlikely(args.set_tid_size > MAX_NS_LEVEL))
 		return -EINVAL;
 
 	if (unlikely(!args.set_tid && args.set_tid_size > 0))
@@ -2900,7 +2900,7 @@ SYSCALL_DEFINE2(clone3, struct clone_args __user *, uargs, size_t, size)
 	int err;
 
 	struct kernel_clone_args kargs;
-	pid_t set_tid[MAX_PID_NS_LEVEL];
+	pid_t set_tid[MAX_NS_LEVEL];
 
 	kargs.set_tid = set_tid;
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index a46a3723bc66..bf2856cc80df 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -27,7 +27,7 @@
 static DEFINE_MUTEX(pid_caches_mutex);
 static struct kmem_cache *pid_ns_cachep;
 /* Write once array, filled from the beginning. */
-static struct kmem_cache *pid_cache[MAX_PID_NS_LEVEL];
+static struct kmem_cache *pid_cache[MAX_NS_LEVEL];
 
 /*
  * creates the kmem cache to allocate pids from.
@@ -81,7 +81,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 		goto out;
 
 	err = -ENOSPC;
-	if (level > MAX_PID_NS_LEVEL)
+	if (level > MAX_NS_LEVEL)
 		goto out;
 	ucounts = inc_pid_namespaces(user_ns);
 	if (!ucounts)
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 5481ba44a8d6..a50d7ee2cc1b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -87,7 +87,7 @@ int create_user_ns(struct cred *new)
 	int ret, i;
 
 	ret = -ENOSPC;
-	if (parent_ns->level > 32)
+	if (parent_ns->level > MAX_NS_LEVEL)
 		goto fail;
 
 	ucounts = inc_user_namespaces(parent_ns, owner);
diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 52d3f0364bda..05c75a61752b 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -27,8 +27,8 @@
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
 
-#ifndef MAX_PID_NS_LEVEL
-#define MAX_PID_NS_LEVEL 32
+#ifndef MAX_NS_LEVEL
+#define MAX_NS_LEVEL 32
 #endif
 
 static void child_exit(int ret)
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 0229e9ebb995..39e0f9ddf8cb 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -23,8 +23,8 @@
 #include "../kselftest.h"
 #include "clone3_selftests.h"
 
-#ifndef MAX_PID_NS_LEVEL
-#define MAX_PID_NS_LEVEL 32
+#ifndef MAX_NS_LEVEL
+#define MAX_NS_LEVEL 32
 #endif
 
 static int pipe_1[2];
@@ -154,7 +154,7 @@ int main(int argc, char *argv[])
 	uid_t uid = getuid();
 	char proc_path[100] = {0};
 	pid_t pid, ns1, ns2, ns3, ns_pid;
-	pid_t set_tid[MAX_PID_NS_LEVEL * 2];
+	pid_t set_tid[MAX_NS_LEVEL * 2];
 
 	ksft_print_header();
 	ksft_set_plan(29);
@@ -174,36 +174,36 @@ int main(int argc, char *argv[])
 
 	/* Try invalid settings */
 	memset(&set_tid, 0, sizeof(set_tid));
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 2 + 1, 0,
 			-EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
 
 	/*
-	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
+	 * This can actually work if this test running in a MAX_NS_LEVEL - 1
 	 * nested PID namespace.
 	 */
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
 
 	memset(&set_tid, 0xff, sizeof(set_tid));
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL + 1, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 2, 0, -EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 2 + 1, 0,
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 2 + 1, 0,
 			-EINVAL, 0, 0);
 
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL * 42, 0, -EINVAL, 0, 0);
 
 	/*
-	 * This can actually work if this test running in a MAX_PID_NS_LEVEL - 1
+	 * This can actually work if this test running in a MAX_NS_LEVEL - 1
 	 * nested PID namespace.
 	 */
-	test_clone3_set_tid(set_tid, MAX_PID_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
+	test_clone3_set_tid(set_tid, MAX_NS_LEVEL - 1, 0, -EINVAL, 0, 0);
 
 	memset(&set_tid, 0, sizeof(set_tid));
 	/* Try with an invalid PID */
-- 
2.35.1

