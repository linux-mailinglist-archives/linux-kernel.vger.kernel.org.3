Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9044BDBFE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379416AbiBUPnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 10:43:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379403AbiBUPnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 10:43:47 -0500
Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [IPv6:2001:1600:3:17::8fa9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD03322511
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 07:43:20 -0800 (PST)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4K2RQv034TzMptrY;
        Mon, 21 Feb 2022 16:43:19 +0100 (CET)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4K2RQt5MDgzlhMBw;
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
        Alejandro Colomar <alx.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v1 2/7] landlock: Fix landlock_add_rule(2) signature
Date:   Mon, 21 Feb 2022 16:53:06 +0100
Message-Id: <20220221155311.166278-3-mic@digikod.net>
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

Replace the enum landlock_rule_type with an int in the syscall signature
of landlock_add_rule to avoid an implementation-defined size.  In
practice an enum type is like an int (at least with GCC and clang), but
compilers may accept options (e.g. -fshort-enums) that would have an
impact on that [1].  This change is mostly a cosmetic fix according to
the current kernel compilers and used options.

Link: https://lore.kernel.org/r/8a22a3c2-468c-e96c-6516-22a0f029aa34@gmail.com/ [1]
Reported-by: Alejandro Colomar <alx.manpages@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Mickaël Salaün <mic@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220221155311.166278-3-mic@digikod.net
---
 include/linux/syscalls.h     | 3 +--
 security/landlock/syscalls.c | 7 ++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 819c0cb00b6d..a5956f91caf2 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -71,7 +71,6 @@ struct clone_args;
 struct open_how;
 struct mount_attr;
 struct landlock_ruleset_attr;
-enum landlock_rule_type;
 
 #include <linux/types.h>
 #include <linux/aio_abi.h>
@@ -1053,7 +1052,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
 asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
 asmlinkage long sys_landlock_create_ruleset(const struct landlock_ruleset_attr __user *attr,
 		size_t size, __u32 flags);
-asmlinkage long sys_landlock_add_rule(int ruleset_fd, enum landlock_rule_type rule_type,
+asmlinkage long sys_landlock_add_rule(int ruleset_fd, int rule_type,
 		const void __user *rule_attr, __u32 flags);
 asmlinkage long sys_landlock_restrict_self(int ruleset_fd, __u32 flags);
 asmlinkage long sys_memfd_secret(unsigned int flags);
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index fd4b24022a06..3b40fc5d0216 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -277,8 +277,9 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  *
  * @ruleset_fd: File descriptor tied to the ruleset that should be extended
  *		with the new rule.
- * @rule_type: Identify the structure type pointed to by @rule_attr (only
- *             LANDLOCK_RULE_PATH_BENEATH for now).
+ * @rule_type: Identify the structure type pointed to by @rule_attr as defined
+ *             by enum landlock_rule_type (only LANDLOCK_RULE_PATH_BENEATH for
+ *             now).
  * @rule_attr: Pointer to a rule (only of type &struct
  *             landlock_path_beneath_attr for now).
  * @flags: Must be 0.
@@ -301,7 +302,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
  * - EFAULT: @rule_attr inconsistency.
  */
 SYSCALL_DEFINE4(landlock_add_rule,
-		const int, ruleset_fd, const enum landlock_rule_type, rule_type,
+		const int, ruleset_fd, const int, rule_type,
 		const void __user *const, rule_attr, const __u32, flags)
 {
 	struct landlock_path_beneath_attr path_beneath_attr;
-- 
2.35.1

