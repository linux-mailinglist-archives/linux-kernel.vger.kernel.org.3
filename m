Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49214BE7F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379443AbiBUPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:43:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242205AbiBUPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:43:47 -0500
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C998E2253B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:43:21 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2RQv3tJKzMqBYZ;
        Mon, 21 Feb 2022 16:43:19 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2RQv2Bs5zlhMCD;
        Mon, 21 Feb 2022 16:43:19 +0100 (CET)
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
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 3/7] selftest/landlock: Make tests build with old libc
Date:   Mon, 21 Feb 2022 16:53:07 +0100
Message-Id: <20220221155311.166278-4-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221155311.166278-1-mic@digikod.net>
References: <20220221155311.166278-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

Replace SYS_<syscall> with __NR_<syscall>.  Using the __NR_<syscall>
notation, provided by UAPI, is useful to build tests on systems without
the SYS_<syscall> definitions.

Replace SYS_pivot_root with __NR_pivot_root, and SYS_move_mount with
__NR_move_mount.

Define renameat2() and RENAME_EXCHANGE if they are unknown to old build
systems.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221155311.166278-4-mic@digikod.net
---
 tools/testing/selftests/landlock/fs_test.c | 23 +++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 10c9a1e4ebd9..699cda25a12a 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -22,6 +22,19 @@
 
 #include "common.h"
 
+#ifndef renameat2
+int renameat2(int olddirfd, const char *oldpath, int newdirfd,
+		const char *newpath, unsigned int flags)
+{
+	return syscall(__NR_renameat2, olddirfd, oldpath, newdirfd, newpath,
+			flags);
+}
+#endif
+
+#ifndef RENAME_EXCHANGE
+#define RENAME_EXCHANGE		(1 << 1)
+#endif
+
 #define TMP_DIR		"tmp"
 #define BINARY_PATH	"./true"
 
@@ -1249,7 +1262,7 @@ TEST_F_FORK(layout1, rule_inside_mount_ns)
 	int ruleset_fd;
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3)) {
+	ASSERT_EQ(0, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3)) {
 		TH_LOG("Failed to pivot root: %s", strerror(errno));
 	};
 	ASSERT_EQ(0, chdir("/"));
@@ -1282,7 +1295,7 @@ TEST_F_FORK(layout1, mount_and_pivot)
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_RDONLY, NULL));
 	ASSERT_EQ(EPERM, errno);
-	ASSERT_EQ(-1, syscall(SYS_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
 	ASSERT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
@@ -1301,12 +1314,12 @@ TEST_F_FORK(layout1, move_mount)
 	ASSERT_LE(0, ruleset_fd);
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 				dir_s1d2, 0)) {
 		TH_LOG("Failed to move mount: %s", strerror(errno));
 	}
 
-	ASSERT_EQ(0, syscall(SYS_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
+	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
 				dir_s3d2, 0));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
@@ -1314,7 +1327,7 @@ TEST_F_FORK(layout1, move_mount)
 	ASSERT_EQ(0, close(ruleset_fd));
 
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(-1, syscall(SYS_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
 				dir_s1d2, 0));
 	ASSERT_EQ(EPERM, errno);
 	clear_cap(_metadata, CAP_SYS_ADMIN);
-- 
2.35.1

