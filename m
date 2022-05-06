Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31B851DD03
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443525AbiEFQLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443446AbiEFQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:49 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3984DF71
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:05 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS81Q89zMqpn1;
        Fri,  6 May 2022 18:07:04 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS76b8czlhSM9;
        Fri,  6 May 2022 18:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853224;
        bh=02n97EaILIuqTsXFx/oybn/WrgtfMPsX5MAhsYFLVdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mB7DYV/SYQehyM22hGE2FaNyE+qytirrVLYuOtA5/fmNG0tvMKL0uif/XtLt46KL+
         qHRWNjpk5l4uTjLOaCMbVlf3BrBO22WfN+zWuHa0tCo+ZjfUUVEMqP+/UVF4dMfEm8
         u7gBJc2rs1hhrslip4BwNssnXAtdCN+Q8g0+Ur3U=
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
Subject: [PATCH v2 10/10] selftests/landlock: Test landlock_create_ruleset(2) argument check ordering
Date:   Fri,  6 May 2022 18:08:20 +0200
Message-Id: <20220506160820.524344-11-mic@digikod.net>
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

Add inval_create_ruleset_arguments, extension of
inval_create_ruleset_flags, to also check error ordering for
landlock_create_ruleset(2).

This is similar to the previous commit checking landlock_add_rule(2).

Test coverage for security/landlock is 94.4% of 504 lines accorging to
gcc/gcov-11.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-11-mic@digikod.net
---

Changes since v1:
* New patch.
---
 tools/testing/selftests/landlock/base_test.c | 21 +++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 21fb33581419..35f64832b869 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -97,14 +97,17 @@ TEST(abi_version)
 	ASSERT_EQ(EINVAL, errno);
 }
 
-TEST(inval_create_ruleset_flags)
+/* Tests ordering of syscall argument checks. */
+TEST(create_ruleset_checks_ordering)
 {
 	const int last_flag = LANDLOCK_CREATE_RULESET_VERSION;
 	const int invalid_flag = last_flag << 1;
+	int ruleset_fd;
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
 
+	/* Checks priority for invalid flags. */
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
 
@@ -119,6 +122,22 @@ TEST(inval_create_ruleset_flags)
 		  landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr),
 					  invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
+
+	/* Checks too big ruleset_attr size. */
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, -1, 0));
+	ASSERT_EQ(E2BIG, errno);
+
+	/* Checks too small ruleset_attr size. */
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0, 0));
+	ASSERT_EQ(EINVAL, errno);
+	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 1, 0));
+	ASSERT_EQ(EINVAL, errno);
+
+	/* Checks valid call. */
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
 }
 
 /* Tests ordering of syscall argument checks. */
-- 
2.35.1

