Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6F551DCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443517AbiEFQLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443440AbiEFQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:48 -0400
Received: from smtp-42a9.mail.infomaniak.ch (smtp-42a9.mail.infomaniak.ch [IPv6:2001:1600:3:17::42a9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE4AC2A
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:00 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS274v7zMqwTF;
        Fri,  6 May 2022 18:06:58 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS25C3nzlhSM0;
        Fri,  6 May 2022 18:06:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853218;
        bh=AduYp70JJClX3H7fyrnMjxM4mEDJGdCPkPgFeSVZSNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HRd2e9dcc/zmgOBEtzRIDeZBAr5LsAg51vKVCdAxvFxawfnEEI/4+c+ZvIgVIPiWO
         3vD53c/qHsyb8ic9wA7Jk+fAHcKxN8UNjIJ8ChmeFR5FrXtELeUD3kZXw5nZMYAijr
         0VTnvXkGjcXaYaOziNVosPxzxfzQb8Qo8A0iaLsI=
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
Subject: [PATCH v2 02/10] selftests/landlock: Make tests build with old libc
Date:   Fri,  6 May 2022 18:08:12 +0200
Message-Id: <20220506160820.524344-3-mic@digikod.net>
In-Reply-To: <20220506160820.524344-1-mic@digikod.net>
References: <20220506160820.524344-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall>
notation, provided by UAPI, is useful to build tests on systems without
the SYS_<syscall> definitions.

Replace SYS_pivot_root with __NR_pivot_root, and SYS_move_mount with
__NR_move_mount.

Define renameat2() and RENAME_EXCHANGE if they are unknown to old build
systems.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-3-mic@digikod.net
---

Changes since v1:
* Format with clang-format and rebase.
---
 tools/testing/selftests/landlock/fs_test.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 28b01cb30c78..cc7fa7b17578 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -22,6 +22,19 @@
 
 #include "common.h"
 
+#ifndef renameat2
+int renameat2(int olddirfd, const char *oldpath, int newdirfd,
+	      const char *newpath, unsigned int flags)
+{
+	return syscall(__NR_renameat2, olddirfd, oldpath, newdirfd, newpath,
+		       flags);
+}
+#endif
+
+#ifndef RENAME_EXCHANGE
+#define RENAME_EXCHANGE (1 << 1)
+#endif
+
 #define TMP_DIR "tmp"
 #define BINARY_PATH "./true"
 
@@ -1279,7 +1292,7 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 	int ruleset_fd;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3))
+	ASSERT_EQ(0, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3))
 	{
 		TH_LOG("Failed to pivot root: %s", strerror(errno));
 	};
@@ -1313,7 +1326,7 @@ TEST_F_FORK(layout1, mount_and_pivot)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
 	ASSERT_EQ(EPERM, errno);
-	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
 	ASSERT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -1332,13 +1345,13 @@ TEST_F_FORK(layout1, move_mount)
 	ASSERT_LE(0, ruleset_fd);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			     dir_s1d2, 0))
 	{
 		TH_LOG("Failed to move mount: %s", strerror(errno));
 	}
 
-	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
+	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
 			     dir_s3d2, 0));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1346,7 +1359,7 @@ TEST_F_FORK(layout1, move_mount)
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(-1, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 			      dir_s1d2, 0));
 	ASSERT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
-- 
2.35.1

