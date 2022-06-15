Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6CD54D4D5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350876AbiFOWwj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350786AbiFOWwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:52:17 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E335642B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f65so12693405pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbQgSf1OVIiwYx0Sn2rxiHGy/GEMZk1makKhYfLcgyY=;
        b=atnEyFN3QfrBooqRfgo4iT32q8OxlL/fSIuJyquYCjy1Umx0nzVkiDIEIxSz2ENHAF
         XmEEhfEx5WHhEt7zEXIhxT8YDoTcLP5xnmjzxJ9VHP6LNjUkk9OfIPYf9Ne1rgwxyNji
         nlfNYMTub/Dw0Z/+EfCdXN4/j62btlN2tHONM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TbQgSf1OVIiwYx0Sn2rxiHGy/GEMZk1makKhYfLcgyY=;
        b=WBWfPCcRadeDtq7OHCXrIgqVumVf2MWgUAhOs+NRFgm01FSiTLhADuGwWnV8Yuey5K
         fXcigAmcysxNySxTqfLXVI9WjuOVoOTIIgBDNpJtEtSDF2YhnO504ct43vRfJ3bQVSRo
         eg6PaCfa76fTQ7vAfhGwGwDK+vojdKJAI2ZdJMb12Hsn7/hllM3dHrDs5Zl8tCURt/tX
         TTtpJrOOPpCa/n3ZgXFXqyNneaTQuWCNY11CH+dAPvyCo0eChd2ukBukCDROr+s7fLy+
         yAKf7pE/qmcmvsujo1IUXHDX1xq9xM2gLVJh6R6c5UkPPoKeNKFEbjqln+wU4polqXyV
         Yhhw==
X-Gm-Message-State: AJIora+H3DVkBTiXogbp8JVontCkm7CkpsmQfDa13GeARg06zztcYAH7
        qbKxhmPFKW9ro+kH95QGUtihGw==
X-Google-Smtp-Source: AGRyM1uisy5NigZ4m/urj0nd+xkA5dGeXQPVz66hbTR3qEHNQ7QBrYrQagMKhifuQTg9hhy9sQuslg==
X-Received: by 2002:a62:b802:0:b0:51b:f4d2:65be with SMTP id p2-20020a62b802000000b0051bf4d265bemr1708795pfe.79.1655333516970;
        Wed, 15 Jun 2022 15:51:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:200:6db4:3c00:379:4cf6])
        by smtp.gmail.com with UTF8SMTPSA id w22-20020a1709026f1600b0015e8d4eb2c0sm125045plk.266.2022.06.15.15.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 15:51:56 -0700 (PDT)
From:   Micah Morton <mortonm@chromium.org>
To:     linux-security-module@vger.kernel.org
Cc:     keescook@chromium.org, jmorris@namei.org, serge@hallyn.com,
        linux-kernel@vger.kernel.org, Micah Morton <mortonm@chromium.org>
Subject: [PATCH 3/3] LSM: SafeSetID: add GID testing to selftest
Date:   Wed, 15 Jun 2022 15:51:52 -0700
Message-Id: <20220615225152.707016-1-mortonm@chromium.org>
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

GID security policies were added back in v5.10, update the selftest to
reflect this.

Signed-off-by: Micah Morton <mortonm@chromium.org>
---
 .../selftests/safesetid/safesetid-test.c      | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index c16977e4b913..a653c47a4ab5 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -3,6 +3,7 @@
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
+#include <grp.h>
 #include <string.h>
 #include <syscall.h>
 #include <sys/capability.h>
@@ -120,6 +121,7 @@ static void ensure_user_exists(uid_t uid)
 		snprintf(name_str, 10, "user %d", uid);
 		p.pw_name=name_str;
 		p.pw_uid=uid;
+		p.pw_gid=uid;
 		p.pw_gecos="Test account";
 		p.pw_dir="/dev/null";
 		p.pw_shell="/bin/false";
@@ -131,6 +133,33 @@ static void ensure_user_exists(uid_t uid)
 	}
 }
 
+static void ensure_group_exists(gid_t gid)
+{
+	struct group g;
+
+	FILE *fd;
+	char name_str[10];
+
+	if (getgrgid(gid) == NULL) {
+		memset(&g,0x00,sizeof(g));
+		fd=fopen("/etc/group","a");
+		if (fd == NULL)
+			die("couldn't open group file\n");
+		if (fseek(fd, 0, SEEK_END))
+			die("couldn't fseek group file\n");
+		snprintf(name_str, 10, "group %d", gid);
+		g.gr_name=name_str;
+		g.gr_gid=gid;
+		g.gr_passwd=NULL;
+		g.gr_mem=NULL;
+		int value = putgrent(&g,fd);
+		if (value != 0)
+			die("putgrent failed\n");
+		if (fclose(fd))
+			die("fclose failed\n");
+	}
+}
+
 static void ensure_securityfs_mounted(void)
 {
 	int fd = open(add_uid_whitelist_policy_file, O_WRONLY);
@@ -175,6 +204,31 @@ static void write_uid_policies()
 	}
 }
 
+static void write_gid_policies()
+{
+	static char *policy_str = UGID_POLICY_STRING;
+	ssize_t written;
+	int fd;
+
+	fd = open(add_gid_whitelist_policy_file, O_WRONLY);
+	if (fd < 0)
+		die("can't open add_gid_whitelist_policy file\n");
+	written = write(fd, policy_str, strlen(policy_str));
+	if (written != strlen(policy_str)) {
+		if (written >= 0) {
+			die("short write to %s\n", add_gid_whitelist_policy_file);
+		} else {
+			die("write to %s failed: %s\n",
+				add_gid_whitelist_policy_file, strerror(errno));
+		}
+	}
+	if (close(fd) != 0) {
+		die("close of %s failed: %s\n",
+			add_gid_whitelist_policy_file, strerror(errno));
+	}
+}
+
+
 static bool test_userns(bool expect_success)
 {
 	uid_t uid;
@@ -265,6 +319,63 @@ static void test_setuid(uid_t child_uid, bool expect_success)
 	die("should not reach here\n");
 }
 
+static void test_setgid(gid_t child_gid, bool expect_success)
+{
+	pid_t cpid, w;
+	int wstatus;
+
+	cpid = fork();
+	if (cpid == -1) {
+		die("fork\n");
+	}
+
+	if (cpid == 0) {	    /* Code executed by child */
+		if (setgid(child_gid) < 0)
+			exit(EXIT_FAILURE);
+		if (getgid() == child_gid)
+			exit(EXIT_SUCCESS);
+		else
+			exit(EXIT_FAILURE);
+	} else {		 /* Code executed by parent */
+		do {
+			w = waitpid(cpid, &wstatus, WUNTRACED | WCONTINUED);
+			if (w == -1) {
+				die("waitpid\n");
+			}
+
+			if (WIFEXITED(wstatus)) {
+				if (WEXITSTATUS(wstatus) == EXIT_SUCCESS) {
+					if (expect_success) {
+						return;
+					} else {
+						die("unexpected success\n");
+					}
+				} else {
+					if (expect_success) {
+						die("unexpected failure\n");
+					} else {
+						return;
+					}
+				}
+			} else if (WIFSIGNALED(wstatus)) {
+				if (WTERMSIG(wstatus) == 9) {
+					if (expect_success)
+						die("killed unexpectedly\n");
+					else
+						return;
+				} else {
+					die("unexpected signal: %d\n", wstatus);
+				}
+			} else {
+				die("unexpected status: %d\n", wstatus);
+			}
+		} while (!WIFEXITED(wstatus) && !WIFSIGNALED(wstatus));
+	}
+
+	die("should not reach here\n");
+}
+
+
 static void ensure_users_exist(void)
 {
 	ensure_user_exists(ROOT_UGID);
@@ -274,6 +385,15 @@ static void ensure_users_exist(void)
 	ensure_user_exists(NO_POLICY_UGID);
 }
 
+static void ensure_groups_exist(void)
+{
+	ensure_group_exists(ROOT_UGID);
+	ensure_group_exists(RESTRICTED_PARENT_UGID);
+	ensure_group_exists(ALLOWED_CHILD1_UGID);
+	ensure_group_exists(ALLOWED_CHILD2_UGID);
+	ensure_group_exists(NO_POLICY_UGID);
+}
+
 static void drop_caps(bool setid_retained)
 {
 	cap_value_t cap_values[] = {CAP_SETUID, CAP_SETGID};
@@ -290,9 +410,11 @@ static void drop_caps(bool setid_retained)
 
 int main(int argc, char **argv)
 {
+	ensure_groups_exist();
 	ensure_users_exist();
 	ensure_securityfs_mounted();
 	write_uid_policies();
+	write_gid_policies();
 
 	if (prctl(PR_SET_KEEPCAPS, 1L))
 		die("Error with set keepcaps\n");
@@ -325,6 +447,12 @@ int main(int argc, char **argv)
 	test_setuid(ALLOWED_CHILD2_UGID, true);
 	test_setuid(NO_POLICY_UGID, false);
 
+	test_setgid(ROOT_UGID, false);
+	test_setgid(ALLOWED_CHILD1_UGID, true);
+	test_setgid(ALLOWED_CHILD2_UGID, true);
+	test_setgid(NO_POLICY_UGID, false);
+
+
 	if (!test_userns(false)) {
 		die("test_userns worked when it should fail\n");
 	}
@@ -334,6 +462,9 @@ int main(int argc, char **argv)
 	test_setuid(2, false);
 	test_setuid(3, false);
 	test_setuid(4, false);
+	test_setgid(2, false);
+	test_setgid(3, false);
+	test_setgid(4, false);
 
 	// NOTE: this test doesn't clean up users that were created in
 	// /etc/passwd or flush policies that were added to the LSM.
-- 
2.36.1.476.g0c4daa206d-goog

