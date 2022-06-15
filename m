Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F5554D4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350622AbiFOWvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245662AbiFOWvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:51:33 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718156413
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:32 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k12-20020a17090a404c00b001eaabc1fe5dso149498pjg.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84lnoizEt2TYmOloN/qHuvuToSk2Kenqk/PKracr6Kc=;
        b=kw8/5UnYUzrE2U7mIcL5oKT99IZgDix3V9Dq77rZ1JVuDjBFW/FokgeAjewI272rH4
         cW99B1k5xWLSxipgTZ7D+gKiQBi0KUmHgsJ6A+lBIOkibFSw8y/jJYYazpyVmzU5AO1D
         6CXFIMueIy5k9nuu2y4i3IQNIStXONNdr0orc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84lnoizEt2TYmOloN/qHuvuToSk2Kenqk/PKracr6Kc=;
        b=1AmIhNJXBUrog5JvR8DedwmoUTggbFcGx7zyvLq7i8ZoxUovVUgmF+Qhh438A6+GgT
         9kwnsCar/uZ2nOjjOetNDMNG5nqaqTKLvy2wzI4XKfB2y0eg2i61bSp+f4pqZrLnsXVo
         cg4zFJ3gMMS9xxIh4ydr6FEs/G4IQOcTFaw49uqGsVps3zqmPq6hyVchFDtikx5zg7pU
         gSgFJP+WZDmiqnKcwACicw8Jm94Z1HVjbRcCd7jMKr1nsheCw7CB9+yUqY2hmXOTukFT
         JzsdDgR0QbfZk3ZWSgACtcOHyNKYfYv215eoi4TPIXh5YpM7ZMbR5Wdi+igWvK86hEV+
         GbDg==
X-Gm-Message-State: AJIora9LpJzqzO7RITxKhOoSFMyUspEcgRZQWlI0Wr0oEYEayD32yq/s
        8R60SErGZMGOoEtEh8VA27gFlw==
X-Google-Smtp-Source: AGRyM1tzcs8gjyhURCnRFJ5vtRknwS47pC9METL0RKLMFBs4nF3PHOH4ATz8gwVu7PCfKuW8x5aABg==
X-Received: by 2002:a17:90a:bc98:b0:1e8:6895:645e with SMTP id x24-20020a17090abc9800b001e86895645emr1767907pjr.131.1655333491460;
        Wed, 15 Jun 2022 15:51:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:6db4:3c00:379:4cf6])
        by smtp.gmail.com with UTF8SMTPSA id u2-20020a17090a4bc200b001e2ebcce5d5sm98801pjl.37.2022.06.15.15.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:51:30 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 2/3] LSM: SafeSetID: selftest cleanup and prepare for GIDs
Date:   Wed, 15 Jun 2022 15:51:25 -0700
Message-Id: <20220615225125.706978-1-mortonm@chromium.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some notes on how to run the test, update the policy file paths to
reflect recent upstream changes, prepare test for adding GID testing.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 tools/testing/selftests/safesetid/Makefile    |  2 +-
 .../selftests/safesetid/safesetid-test.c      | 93 ++++++++++---------
 2 files changed, 51 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/safesetid/Makefile b/tools/testing/selftests/safesetid/Makefile
index fa02c4d5ec13..e815bbf2d0f4 100644
--- a/tools/testing/selftests/safesetid/Makefile
+++ b/tools/testing/selftests/safesetid/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# Makefile for mount selftests.
+# Makefile for SafeSetID selftest.
 CFLAGS = -Wall -O2
 LDLIBS = -lcap
 
diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index 111dcbcc0491..c16977e4b913 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -16,17 +16,28 @@
 #include <stdbool.h>
 #include <stdarg.h>
 
+/*
+ * NOTES about this test:
+ * - requries libcap-dev to be installed on test system
+ * - requires securityfs to me mounted at /sys/kernel/security, e.g.:
+ * mount -n -t securityfs -o nodev,noexec,nosuid securityfs /sys/kernel/security
+ * - needs CONFIG_SECURITYFS and CONFIG_SAFESETID to be enabled
+ */
+
 #ifndef CLONE_NEWUSER
 # define CLONE_NEWUSER 0x10000000
 #endif
 
-#define ROOT_USER 0
-#define RESTRICTED_PARENT 1
-#define ALLOWED_CHILD1 2
-#define ALLOWED_CHILD2 3
-#define NO_POLICY_USER 4
+#define ROOT_UGID 0
+#define RESTRICTED_PARENT_UGID 1
+#define ALLOWED_CHILD1_UGID 2
+#define ALLOWED_CHILD2_UGID 3
+#define NO_POLICY_UGID 4
+
+#define UGID_POLICY_STRING "1:2\n1:3\n2:2\n3:3\n"
 
-char* add_whitelist_policy_file = "/sys/kernel/security/safesetid/add_whitelist_policy";
+char* add_uid_whitelist_policy_file = "/sys/kernel/security/safesetid/uid_allowlist_policy";
+char* add_gid_whitelist_policy_file = "/sys/kernel/security/safesetid/gid_allowlist_policy";
 
 static void die(char *fmt, ...)
 {
@@ -106,7 +117,7 @@ static void ensure_user_exists(uid_t uid)
 			die("couldn't open file\n");
 		if (fseek(fd, 0, SEEK_END))
 			die("couldn't fseek\n");
-		snprintf(name_str, 10, "%d", uid);
+		snprintf(name_str, 10, "user %d", uid);
 		p.pw_name=name_str;
 		p.pw_uid=uid;
 		p.pw_gecos="Test account";
@@ -122,7 +133,7 @@ static void ensure_user_exists(uid_t uid)
 
 static void ensure_securityfs_mounted(void)
 {
-	int fd = open(add_whitelist_policy_file, O_WRONLY);
+	int fd = open(add_uid_whitelist_policy_file, O_WRONLY);
 	if (fd < 0) {
 		if (errno == ENOENT) {
 			// Need to mount securityfs
@@ -135,36 +146,32 @@ static void ensure_securityfs_mounted(void)
 	} else {
 		if (close(fd) != 0) {
 			die("close of %s failed: %s\n",
-				add_whitelist_policy_file, strerror(errno));
+				add_uid_whitelist_policy_file, strerror(errno));
 		}
 	}
 }
 
-static void write_policies(void)
+static void write_uid_policies()
 {
-	static char *policy_str =
-		"1:2\n"
-		"1:3\n"
-		"2:2\n"
-		"3:3\n";
+	static char *policy_str = UGID_POLICY_STRING;
 	ssize_t written;
 	int fd;
 
-	fd = open(add_whitelist_policy_file, O_WRONLY);
+	fd = open(add_uid_whitelist_policy_file, O_WRONLY);
 	if (fd < 0)
-		die("can't open add_whitelist_policy file\n");
+		die("can't open add_uid_whitelist_policy file\n");
 	written = write(fd, policy_str, strlen(policy_str));
 	if (written != strlen(policy_str)) {
 		if (written >= 0) {
-			die("short write to %s\n", add_whitelist_policy_file);
+			die("short write to %s\n", add_uid_whitelist_policy_file);
 		} else {
 			die("write to %s failed: %s\n",
-				add_whitelist_policy_file, strerror(errno));
+				add_uid_whitelist_policy_file, strerror(errno));
 		}
 	}
 	if (close(fd) != 0) {
 		die("close of %s failed: %s\n",
-			add_whitelist_policy_file, strerror(errno));
+			add_uid_whitelist_policy_file, strerror(errno));
 	}
 }
 
@@ -260,11 +267,11 @@ static void test_setuid(uid_t child_uid, bool expect_success)
 
 static void ensure_users_exist(void)
 {
-	ensure_user_exists(ROOT_USER);
-	ensure_user_exists(RESTRICTED_PARENT);
-	ensure_user_exists(ALLOWED_CHILD1);
-	ensure_user_exists(ALLOWED_CHILD2);
-	ensure_user_exists(NO_POLICY_USER);
+	ensure_user_exists(ROOT_UGID);
+	ensure_user_exists(RESTRICTED_PARENT_UGID);
+	ensure_user_exists(ALLOWED_CHILD1_UGID);
+	ensure_user_exists(ALLOWED_CHILD2_UGID);
+	ensure_user_exists(NO_POLICY_UGID);
 }
 
 static void drop_caps(bool setid_retained)
@@ -285,39 +292,38 @@ int main(int argc, char **argv)
 {
 	ensure_users_exist();
 	ensure_securityfs_mounted();
-	write_policies();
+	write_uid_policies();
 
 	if (prctl(PR_SET_KEEPCAPS, 1L))
 		die("Error with set keepcaps\n");
 
-	// First test to make sure we can write userns mappings from a user
-	// that doesn't have any restrictions (as long as it has CAP_SETUID);
-	if (setuid(NO_POLICY_USER) < 0)
-		die("Error with set uid(%d)\n", NO_POLICY_USER);
-	if (setgid(NO_POLICY_USER) < 0)
-		die("Error with set gid(%d)\n", NO_POLICY_USER);
-
+	// First test to make sure we can write userns mappings from a non-root
+	// user that doesn't have any restrictions (as long as it has
+	// CAP_SETUID);
+	if (setgid(NO_POLICY_UGID) < 0)
+		die("Error with set gid(%d)\n", NO_POLICY_UGID);
+	if (setuid(NO_POLICY_UGID) < 0)
+		die("Error with set uid(%d)\n", NO_POLICY_UGID);
 	// Take away all but setid caps
 	drop_caps(true);
-
 	// Need PR_SET_DUMPABLE flag set so we can write /proc/[pid]/uid_map
 	// from non-root parent process.
 	if (prctl(PR_SET_DUMPABLE, 1, 0, 0, 0))
 		die("Error with set dumpable\n");
-
 	if (!test_userns(true)) {
 		die("test_userns failed when it should work\n");
 	}
 
-	if (setuid(RESTRICTED_PARENT) < 0)
-		die("Error with set uid(%d)\n", RESTRICTED_PARENT);
-	if (setgid(RESTRICTED_PARENT) < 0)
-		die("Error with set gid(%d)\n", RESTRICTED_PARENT);
+	// Now switch to a user/group with restrictions
+	if (setgid(RESTRICTED_PARENT_UGID) < 0)
+		die("Error with set gid(%d)\n", RESTRICTED_PARENT_UGID);
+	if (setuid(RESTRICTED_PARENT_UGID) < 0)
+		die("Error with set uid(%d)\n", RESTRICTED_PARENT_UGID);
 
-	test_setuid(ROOT_USER, false);
-	test_setuid(ALLOWED_CHILD1, true);
-	test_setuid(ALLOWED_CHILD2, true);
-	test_setuid(NO_POLICY_USER, false);
+	test_setuid(ROOT_UGID, false);
+	test_setuid(ALLOWED_CHILD1_UGID, true);
+	test_setuid(ALLOWED_CHILD2_UGID, true);
+	test_setuid(NO_POLICY_UGID, false);
 
 	if (!test_userns(false)) {
 		die("test_userns worked when it should fail\n");
@@ -331,5 +337,6 @@ int main(int argc, char **argv)
 
 	// NOTE: this test doesn't clean up users that were created in
 	// /etc/passwd or flush policies that were added to the LSM.
+	printf("test successful!\n");
 	return EXIT_SUCCESS;
 }
-- 
2.36.1.476.g0c4daa206d-goog

