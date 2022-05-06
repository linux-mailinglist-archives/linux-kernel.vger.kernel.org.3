Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00B551DD08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443475AbiEFQLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443426AbiEFQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:48 -0400
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B606D95C
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:02 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS46QNyzMqwSk;
        Fri,  6 May 2022 18:07:00 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS44KfTzlhMBg;
        Fri,  6 May 2022 18:07:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853220;
        bh=pONfXKuTok6YIRXg0U1RNOakHlPIXE+u75ZPbnhzYa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hv2Ir+vmvtKtiuC9n4RKClUnQhQr5W0pO/QvwpWvSuNkUhbbO8wuZ9HJQZ/Vwc3P0
         suzrm9VvRcg12NvvQHM6LfnS491uWLDhaJVcpYXOUqkKN4uB+862aX/w4kUd+N8TG5
         6/9QMWZSk9nYJ4P99NykEfUndW7VkHhXhlKePVCY=
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
Subject: [PATCH v2 05/10] selftests/landlock: Extend access right tests to directories
Date:   Fri,  6 May 2022 18:08:15 +0200
Message-Id: <20220506160820.524344-6-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that all filesystem access rights can be tied to directories.

Rename layout1.file_access_rights to layout1.file_and_dir_access_rights
to reflect this change.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-6-mic@digikod.net
---

Changes since v1:
* Format with clang-format and rebase.
---
 tools/testing/selftests/landlock/fs_test.c | 30 ++++++++++++++++------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f293b7e2a1a7..75f9358512df 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -418,11 +418,12 @@ TEST_F_FORK(layout1, inval)
 
 /* clang-format on */
 
-TEST_F_FORK(layout1, file_access_rights)
+TEST_F_FORK(layout1, file_and_dir_access_rights)
 {
 	__u64 access;
 	int err;
-	struct landlock_path_beneath_attr path_beneath = {};
+	struct landlock_path_beneath_attr path_beneath_file = {},
+					  path_beneath_dir = {};
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = ACCESS_ALL,
 	};
@@ -432,20 +433,33 @@ TEST_F_FORK(layout1, file_access_rights)
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Tests access rights for files. */
-	path_beneath.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
-	ASSERT_LE(0, path_beneath.parent_fd);
+	path_beneath_file.parent_fd = open(file1_s1d2, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_file.parent_fd);
+
+	/* Tests access rights for directories. */
+	path_beneath_dir.parent_fd =
+		open(dir_s1d2, O_PATH | O_DIRECTORY | O_CLOEXEC);
+	ASSERT_LE(0, path_beneath_dir.parent_fd);
+
 	for (access = 1; access <= ACCESS_LAST; access <<= 1) {
-		path_beneath.allowed_access = access;
+		path_beneath_dir.allowed_access = access;
+		ASSERT_EQ(0, landlock_add_rule(ruleset_fd,
+					       LANDLOCK_RULE_PATH_BENEATH,
+					       &path_beneath_dir, 0));
+
+		path_beneath_file.allowed_access = access;
 		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_PATH_BENEATH,
-					&path_beneath, 0);
-		if ((access | ACCESS_FILE) == ACCESS_FILE) {
+					&path_beneath_file, 0);
+		if (access & ACCESS_FILE) {
 			ASSERT_EQ(0, err);
 		} else {
 			ASSERT_EQ(-1, err);
 			ASSERT_EQ(EINVAL, errno);
 		}
 	}
-	ASSERT_EQ(0, close(path_beneath.parent_fd));
+	ASSERT_EQ(0, close(path_beneath_file.parent_fd));
+	ASSERT_EQ(0, close(path_beneath_dir.parent_fd));
+	ASSERT_EQ(0, close(ruleset_fd));
 }
 
 TEST_F_FORK(layout1, unknown_access_rights)
-- 
2.35.1

