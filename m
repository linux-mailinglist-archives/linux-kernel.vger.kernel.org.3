Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA48651DD01
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443521AbiEFQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443451AbiEFQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:48 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B7E6D966
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:02 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS53fnKzMqwT0;
        Fri,  6 May 2022 18:07:01 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS522HJzlhSLv;
        Fri,  6 May 2022 18:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853221;
        bh=vvi6q1Rd/gDcGS5JNMP6tyQE4jRuIgqkCRlVkN+I8tU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MDJBE3OAkxTtgM4XDYMHwNHpuNz+3ubYzZt7MltMMi0q72Eicei8lrhAZJsy3i776
         Jtk2sRTk9s+PD5iqVzsuUptTe1GEUbLp+LTdSwky5Mzdd1Rsgna8izrUm9nwi8ifRf
         oGGG9LBZu8TPiEc5gBhVa8fn0yM7p8PEpQKVwDx4=
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
Subject: [PATCH v2 06/10] selftests/landlock: Fully test file rename with "remove" access
Date:   Fri,  6 May 2022 18:08:16 +0200
Message-Id: <20220506160820.524344-7-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These tests were missing to check the check_access_path() call with all
combinations of maybe_remove(old_dentry) and maybe_remove(new_dentry).

Extend layout1.link with a new complementary test and check that
REMOVE_FILE is not required to link a file.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-7-mic@digikod.net
---

Changes since v1:
* Extend layout1.link with a second rule layer to check that REMOVE_FILE
  is not required to link a file.
* Format with clang-format and rebase.
---
 tools/testing/selftests/landlock/fs_test.c | 41 +++++++++++++++++++---
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 75f9358512df..9165f6adf7b9 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1659,15 +1659,21 @@ TEST_F_FORK(layout1, execute)
 
 TEST_F_FORK(layout1, link)
 {
-	const struct rule rules[] = {
+	const struct rule layer1[] = {
 		{
 			.path = dir_s1d2,
 			.access = LANDLOCK_ACCESS_FS_MAKE_REG,
 		},
 		{},
 	};
-	const int ruleset_fd =
-		create_ruleset(_metadata, rules[0].access, rules);
+	const struct rule layer2[] = {
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_REMOVE_FILE,
+		},
+		{},
+	};
+	int ruleset_fd = create_ruleset(_metadata, layer1[0].access, layer1);
 
 	ASSERT_LE(0, ruleset_fd);
 
@@ -1680,14 +1686,30 @@ TEST_F_FORK(layout1, link)
 
 	ASSERT_EQ(-1, link(file2_s1d1, file1_s1d1));
 	ASSERT_EQ(EACCES, errno);
+
 	/* Denies linking because of reparenting. */
 	ASSERT_EQ(-1, link(file1_s2d1, file1_s1d2));
 	ASSERT_EQ(EXDEV, errno);
 	ASSERT_EQ(-1, link(file2_s1d2, file1_s1d3));
 	ASSERT_EQ(EXDEV, errno);
+	ASSERT_EQ(-1, link(file2_s1d3, file1_s1d2));
+	ASSERT_EQ(EXDEV, errno);
 
 	ASSERT_EQ(0, link(file2_s1d2, file1_s1d2));
 	ASSERT_EQ(0, link(file2_s1d3, file1_s1d3));
+
+	/* Prepares for next unlinks. */
+	ASSERT_EQ(0, unlink(file2_s1d2));
+	ASSERT_EQ(0, unlink(file2_s1d3));
+
+	ruleset_fd = create_ruleset(_metadata, layer2[0].access, layer2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks that linkind doesn't require the ability to delete a file. */
+	ASSERT_EQ(0, link(file1_s1d2, file2_s1d2));
+	ASSERT_EQ(0, link(file1_s1d3, file2_s1d3));
 }
 
 TEST_F_FORK(layout1, rename_file)
@@ -1708,7 +1730,6 @@ TEST_F_FORK(layout1, rename_file)
 
 	ASSERT_LE(0, ruleset_fd);
 
-	ASSERT_EQ(0, unlink(file1_s1d1));
 	ASSERT_EQ(0, unlink(file1_s1d2));
 
 	enforce_ruleset(_metadata, ruleset_fd);
@@ -1744,9 +1765,15 @@ TEST_F_FORK(layout1, rename_file)
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s2d2, AT_FDCWD, file1_s2d1,
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
+	/* Checks that file1_s2d1 cannot be removed (instead of ENOTDIR). */
+	ASSERT_EQ(-1, rename(dir_s2d2, file1_s2d1));
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s2d1, AT_FDCWD, dir_s2d2,
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
+	/* Checks that file1_s1d1 cannot be removed (instead of EISDIR). */
+	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
 
 	/* Renames files with different parents. */
 	ASSERT_EQ(-1, rename(file1_s2d2, file1_s1d2));
@@ -1809,9 +1836,15 @@ TEST_F_FORK(layout1, rename_dir)
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, dir_s1d1, AT_FDCWD, dir_s2d1,
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
+	/* Checks that dir_s1d2 cannot be removed (instead of ENOTDIR). */
+	ASSERT_EQ(-1, rename(dir_s1d2, file1_s1d1));
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, renameat2(AT_FDCWD, file1_s1d1, AT_FDCWD, dir_s1d2,
 				RENAME_EXCHANGE));
 	ASSERT_EQ(EACCES, errno);
+	/* Checks that dir_s1d2 cannot be removed (instead of EISDIR). */
+	ASSERT_EQ(-1, rename(file1_s1d1, dir_s1d2));
+	ASSERT_EQ(EACCES, errno);
 
 	/*
 	 * Exchanges and renames directory to the same parent, which allows
-- 
2.35.1

