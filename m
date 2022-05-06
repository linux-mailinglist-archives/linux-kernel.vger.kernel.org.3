Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913EE51DD0A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443510AbiEFQLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443463AbiEFQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:52 -0400
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [IPv6:2001:1600:3:17::1909])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33677DF6E
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:05 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS73nFSzMr2Zd;
        Fri,  6 May 2022 18:07:03 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS71F6PzlhMBg;
        Fri,  6 May 2022 18:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853223;
        bh=8r9fKQQr9e9xPmuZNKivpJH5l0oI/VFqJDOLmqdf8pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ykEJrNNDfpAns8GXWSiIcIwOJK5cJ/U2iYpnvLRClUaZYuenzngvEh3/62oUzrFlU
         +FxTfAW5f262AF2Yu1IBGmsfmccIRgp1AhAt+cd47+Rdu69g9a6teRtsopzv2Wm6DQ
         MLnHuBk8nHv6QjHXvLME13lOfkViXknBZyDTOSt4=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v2 09/10] landlock: Change landlock_restrict_self(2) check ordering
Date:   Fri,  6 May 2022 18:08:19 +0200
Message-Id: <20220506160820.524344-10-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Landlock goal to be a security feature available to
unprivileges processes, it makes more sense to first check for
no_new_privs before checking anything else (i.e. syscall arguments).

Merge inval_fd_enforce and unpriv_enforce_without_no_new_privs tests
into the new restrict_self_checks_ordering.  This is similar to the
previous commit checking other syscalls.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-10-mic@digikod.net
---

Changes since v1:
* New patch.
---
 security/landlock/syscalls.c                 |  8 ++--
 tools/testing/selftests/landlock/base_test.c | 47 +++++++++++++++-----
 2 files changed, 41 insertions(+), 14 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index a7396220c9d4..507d43827afe 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -405,10 +405,6 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	if (!landlock_initialized)
 		return -EOPNOTSUPP;
 
-	/* No flag for now. */
-	if (flags)
-		return -EINVAL;
-
 	/*
 	 * Similar checks as for seccomp(2), except that an -EPERM may be
 	 * returned.
@@ -417,6 +413,10 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 	    !ns_capable_noaudit(current_user_ns(), CAP_SYS_ADMIN))
 		return -EPERM;
 
+	/* No flag for now. */
+	if (flags)
+		return -EINVAL;
+
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_READ);
 	if (IS_ERR(ruleset))
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 18b779471dcb..21fb33581419 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -168,22 +168,49 @@ TEST(add_rule_checks_ordering)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
-TEST(inval_fd_enforce)
+/* Tests ordering of syscall argument and permission checks. */
+TEST(restrict_self_checks_ordering)
 {
+	const struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.parent_fd = -1,
+	};
+	const int ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+
+	ASSERT_LE(0, ruleset_fd);
+	path_beneath_attr.parent_fd =
+		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_attr.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath_attr, 0));
+	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
+
+	/* Checks unprivileged enforcement without no_new_privs. */
+	drop_caps(_metadata);
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, landlock_restrict_self(ruleset_fd, 0));
+	ASSERT_EQ(EPERM, errno);
+
 	ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0));
 
+	/* Checks invalid flags. */
+	ASSERT_EQ(-1, landlock_restrict_self(-1, -1));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Checks invalid ruleset FD. */
 	ASSERT_EQ(-1, landlock_restrict_self(-1, 0));
 	ASSERT_EQ(EBADF, errno);
-}
-
-TEST(unpriv_enforce_without_no_new_privs)
-{
-	int err;
 
-	drop_caps(_metadata);
-	err = landlock_restrict_self(-1, 0);
-	ASSERT_EQ(EPERM, errno);
-	ASSERT_EQ(err, -1);
+	/* Checks valid call. */
+	ASSERT_EQ(0, landlock_restrict_self(ruleset_fd, 0));
+	ASSERT_EQ(0, close(ruleset_fd));
 }
 
 TEST(ruleset_fd_io)
-- 
2.35.1

