Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B714BE692
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379430AbiBUPoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:44:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379410AbiBUPns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:43:48 -0500
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch [IPv6:2001:1600:3:17::42ad])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76EA22B0D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:43:24 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2RQt32hnzMqC3X;
        Mon, 21 Feb 2022 16:43:18 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2RQt0P1xzlhMBj;
        Mon, 21 Feb 2022 16:43:18 +0100 (CET)
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
Subject: [PATCH v1 1/7] landlock: Fix landlock_add_rule(2) documentation
Date:   Mon, 21 Feb 2022 16:53:05 +0100
Message-Id: <20220221155311.166278-2-mic@digikod.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221155311.166278-1-mic@digikod.net>
References: <20220221155311.166278-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mickaël Salaün <mic@linux.microsoft.com>

It is not mandatory to pass a file descriptor obtained with the O_PATH
flag.  Also, replace rule's accesses with ruleset's accesses.

Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221155311.166278-2-mic@digikod.net
---
 include/uapi/linux/landlock.h | 5 +++--
 security/landlock/syscalls.c  | 7 +++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index b3d952067f59..c0390e318a65 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -60,8 +60,9 @@ struct landlock_path_beneath_attr {
 	 */
 	__u64 allowed_access;
 	/**
-	 * @parent_fd: File descriptor, open with ``O_PATH``, which identifies
-	 * the parent directory of a file hierarchy, or just a file.
+	 * @parent_fd: File descriptor, preferably opened with ``O_PATH``,
+	 * which identifies the parent directory of a file hierarchy, or just a
+	 * file.
 	 */
 	__s32 parent_fd;
 	/*
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 32396962f04d..fd4b24022a06 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -290,14 +290,13 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  *
  * - EOPNOTSUPP: Landlock is supported by the kernel but disabled at boot time;
  * - EINVAL: @flags is not 0, or inconsistent access in the rule (i.e.
- *   &landlock_path_beneath_attr.allowed_access is not a subset of the rule's
- *   accesses);
+ *   &landlock_path_beneath_attr.allowed_access is not a subset of the
+ *   ruleset handled accesses);
  * - ENOMSG: Empty accesses (e.g. &landlock_path_beneath_attr.allowed_access);
  * - EBADF: @ruleset_fd is not a file descriptor for the current thread, or a
  *   member of @rule_attr is not a file descriptor as expected;
  * - EBADFD: @ruleset_fd is not a ruleset file descriptor, or a member of
- *   @rule_attr is not the expected file descriptor type (e.g. file open
- *   without O_PATH);
+ *   @rule_attr is not the expected file descriptor type;
  * - EPERM: @ruleset_fd has no write access to the underlying ruleset;
  * - EFAULT: @rule_attr inconsistency.
  */
-- 
2.35.1

