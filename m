Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9508D51DD07
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443442AbiEFQL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443456AbiEFQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:49 -0400
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C61212ACE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:03 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS65N6wzMqwTG;
        Fri,  6 May 2022 18:07:02 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS63lzQzlhMC1;
        Fri,  6 May 2022 18:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853222;
        bh=Hg4YQ+otf1y+p9E8hTp3CeAQR8NMqxwgFOwDNjJcoQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7UlI8BxD2zPKHjUL1ft+VN0+qnGaU9s54EZZlpKSv1kRpOClg28Jr7jGGod4RsxK
         USs9BZQdEO/cWGj8dPb6Nhu4WHfj0gfB/r85IbBtqMQr90Yr6SWE+8OVwo6TCUcVHB
         d5Ah1CmRLgxooy/PgV35ICT9JEIxZoOT/5MgQiCw=
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
Subject: [PATCH v2 08/10] landlock: Change landlock_add_rule(2) argument check ordering
Date:   Fri,  6 May 2022 18:08:18 +0200
Message-Id: <20220506160820.524344-9-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes more sense to first check the ruleset FD and then the rule
attribute.  It will be useful to factor out code for other rule types.

Add inval_add_rule_arguments tests, extension of empty_path_beneath_attr
tests, to also check error ordering for landlock_add_rule(2).

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-9-mic@digikod.net
---

Changes since v1:
* New patch.
---
 security/landlock/syscalls.c                 | 22 +++++++------
 tools/testing/selftests/landlock/base_test.c | 34 ++++++++++++++++++--
 2 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 7edc1d50e2bf..a7396220c9d4 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -318,20 +318,24 @@ SYSCALL_DEFINE4(landlock_add_rule, const int, ruleset_fd,
 	if (flags)
 		return -EINVAL;
 
-	if (rule_type != LANDLOCK_RULE_PATH_BENEATH)
-		return -EINVAL;
-
-	/* Copies raw user space buffer, only one type for now. */
-	res = copy_from_user(&path_beneath_attr, rule_attr,
-			     sizeof(path_beneath_attr));
-	if (res)
-		return -EFAULT;
-
 	/* Gets and checks the ruleset. */
 	ruleset = get_ruleset_from_fd(ruleset_fd, FMODE_CAN_WRITE);
 	if (IS_ERR(ruleset))
 		return PTR_ERR(ruleset);
 
+	if (rule_type != LANDLOCK_RULE_PATH_BENEATH) {
+		err = -EINVAL;
+		goto out_put_ruleset;
+	}
+
+	/* Copies raw user space buffer, only one type for now. */
+	res = copy_from_user(&path_beneath_attr, rule_attr,
+			     sizeof(path_beneath_attr));
+	if (res) {
+		err = -EFAULT;
+		goto out_put_ruleset;
+	}
+
 	/*
 	 * Informs about useless rule: empty allowed_access (i.e. deny rules)
 	 * are ignored in path walks.
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index be9b937256ac..18b779471dcb 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -121,20 +121,50 @@ TEST(inval_create_ruleset_flags)
 	ASSERT_EQ(EINVAL, errno);
 }
 
-TEST(empty_path_beneath_attr)
+/* Tests ordering of syscall argument checks. */
+TEST(add_rule_checks_ordering)
 {
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
 	};
+	struct landlock_path_beneath_attr path_beneath_attr = {
+		.allowed_access = LANDLOCK_ACCESS_FS_EXECUTE,
+		.parent_fd = -1,
+	};
 	const int ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 
 	ASSERT_LE(0, ruleset_fd);
 
-	/* Similar to struct landlock_path_beneath_attr.parent_fd = 0 */
+	/* Checks invalid flags. */
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 1));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Checks invalid ruleset FD. */
+	ASSERT_EQ(-1, landlock_add_rule(-1, 0, NULL, 0));
+	ASSERT_EQ(EBADF, errno);
+
+	/* Checks invalid rule type. */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, 0, NULL, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Checks invalid rule attr. */
 	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
 					NULL, 0));
 	ASSERT_EQ(EFAULT, errno);
+
+	/* Checks invalid path_beneath.parent_fd. */
+	ASSERT_EQ(-1, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+					&path_beneath_attr, 0));
+	ASSERT_EQ(EBADF, errno);
+
+	/* Checks valid call. */
+	path_beneath_attr.parent_fd =
+		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_attr.parent_fd);
+	ASSERT_EQ(0, landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
+				       &path_beneath_attr, 0));
+	ASSERT_EQ(0, close(path_beneath_attr.parent_fd));
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
-- 
2.35.1

