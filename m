Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D074A9EB6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377408AbiBDSMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:12:02 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:55678 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiBDSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:12:01 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3410C1F37D;
        Fri,  4 Feb 2022 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643998320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TnOodoC+dk7hN8J0G80ViKMJ6kkGjwsgHMNI6oJy58Y=;
        b=iZn1BOxYj0KI3tDt9FfvwkM9pRfaxNPLqiJejWltTFqlrZNZRGVxTk9msawFU1gYGmY5xc
        wyLHK3aqvpeRGlSy9Iu179CSMcL2uyuJAJKGtKKFuvk+1yWFBuOh5Y1fzPRGBJq7/0RcXG
        d6Q1OgQhLvw/dc/nkmz8WYGTF4ZuOz0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EE9E13AD8;
        Fri,  4 Feb 2022 18:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KnPnBnBs/WHwbwAAMHmgww
        (envelope-from <mkoutny@suse.com>); Fri, 04 Feb 2022 18:12:00 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] ucounts: Do not allow RLIMIT_NPROC+1 tasks
Date:   Fri,  4 Feb 2022 19:11:44 +0100
Message-Id: <20220204181144.24462-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was reported that v5.14 behaves differently when enforcing
RLIMIT_NPROC limit, namely, it allows one more task than previously.
This is consequence of the commit 21d1c5e386bc ("Reimplement
RLIMIT_NPROC on top of ucounts") that missed the sharpness of equality
in the forking path.

In order to accommodate other existing checks of the RLIMIT_NPROC, the
fix comprises of extending the result domain of ucount vs limit
comparison. Forks or setting uid of a saturated user are denied.

(Other RLIMIT_ per-user limits have correct comparison sharpness.)

Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Reported-by: TBD
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 fs/exec.c                      |  2 +-
 include/linux/user_namespace.h |  2 +-
 kernel/fork.c                  |  2 +-
 kernel/sys.c                   |  2 +-
 kernel/ucount.c                | 11 +++++++----
 5 files changed, 11 insertions(+), 8 deletions(-)

This change breaks tools/testing/selftests/rlimits/rlimits-per-userns.c between
v5.14..v5.15-rc1~172^2.
The commit 2863643fb8b9 ("set_user: add capability check when
rlimit(RLIMIT_NPROC) exceeds") is an inadvertent "fix".

diff --git a/fs/exec.c b/fs/exec.c
index 79f2c9483302..fc598c2652b2 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1881,7 +1881,7 @@ static int do_execveat_common(int fd, struct filename *filename,
 	 * whether NPROC limit is still exceeded.
 	 */
 	if ((current->flags & PF_NPROC_EXCEEDED) &&
-	    is_ucounts_overlimit(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	    ucounts_limit_cmp(current_ucounts(), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) > 0) {
 		retval = -EAGAIN;
 		goto out_ret;
 	}
diff --git a/include/linux/user_namespace.h b/include/linux/user_namespace.h
index 33a4240e6a6f..9ccc336196f7 100644
--- a/include/linux/user_namespace.h
+++ b/include/linux/user_namespace.h
@@ -129,7 +129,7 @@ long inc_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
 bool dec_rlimit_ucounts(struct ucounts *ucounts, enum ucount_type type, long v);
 long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type);
 void dec_rlimit_put_ucounts(struct ucounts *ucounts, enum ucount_type type);
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
+long ucounts_limit_cmp(struct ucounts *ucounts, enum ucount_type type, unsigned long max);
 
 static inline void set_rlimit_ucount_max(struct user_namespace *ns,
 		enum ucount_type type, unsigned long max)
diff --git a/kernel/fork.c b/kernel/fork.c
index d75a528f7b21..7cb21a70737d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2022,7 +2022,7 @@ static __latent_entropy struct task_struct *copy_process(
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
 #endif
 	retval = -EAGAIN;
-	if (is_ucounts_overlimit(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC))) {
+	if (ucounts_limit_cmp(task_ucounts(p), UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0) {
 		if (p->real_cred->user != INIT_USER &&
 		    !capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 			goto bad_fork_free;
diff --git a/kernel/sys.c b/kernel/sys.c
index ecc4cf019242..8ea20912103a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -479,7 +479,7 @@ static int set_user(struct cred *new)
 	 * for programs doing set*uid()+execve() by harmlessly deferring the
 	 * failure to the execve() stage.
 	 */
-	if (is_ucounts_overlimit(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) &&
+	if (ucounts_limit_cmp(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0 &&
 			new_user != INIT_USER &&
 			!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN))
 		current->flags |= PF_NPROC_EXCEEDED;
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 65b597431c86..53ccd96387dd 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -343,18 +343,21 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum ucount_type type)
 	return 0;
 }
 
-bool is_ucounts_overlimit(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
+long ucounts_limit_cmp(struct ucounts *ucounts, enum ucount_type type, unsigned long rlimit)
 {
 	struct ucounts *iter;
 	long max = rlimit;
+	long excess = LONG_MIN;
 	if (rlimit > LONG_MAX)
 		max = LONG_MAX;
 	for (iter = ucounts; iter; iter = iter->ns->ucounts) {
-		if (get_ucounts_value(iter, type) > max)
-			return true;
+		/* we already WARN_ON negative ucounts, the subtraction result fits */
+		excess = max_t(long, excess, get_ucounts_value(iter, type) - max);
+		if (excess > 0)
+			return excess;
 		max = READ_ONCE(iter->ns->ucount_max[type]);
 	}
-	return false;
+	return excess;
 }
 
 static __init int user_namespace_sysctl_init(void)
-- 
2.34.1

