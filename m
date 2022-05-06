Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3265951DD02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443489AbiEFQLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443447AbiEFQKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:48 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF87D6D974
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:07:03 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS614zDzMr2ZM;
        Fri,  6 May 2022 18:07:02 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS56LXXzlhSLv;
        Fri,  6 May 2022 18:07:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853222;
        bh=dfWnbGeiA92nwD0xKSnL0FFW806dIXnZ0eXS42gWyfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YpQTjwImym8FVPNGcOTV8mnqLDBdkgEDQ5FYmCrqhU490BRMLeKr1sieqafXMJraG
         +NAkI1BH93Ugx/ZSymSFlnAS2RJBEOqWQp2PJgWU8fuijl8akO4jYEXssIqAFwY9eY
         EOrfWUqAVDUGIffd0iGHWqFp34ZlHN78s9KWpzAQ=
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
Subject: [PATCH v2 07/10] selftests/landlock: Add tests for O_PATH
Date:   Fri,  6 May 2022 18:08:17 +0200
Message-Id: <20220506160820.524344-8-mic@digikod.net>
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

The O_PATH flag is currently not handled by Landlock.  Let's make sure
this behavior will remain consistent with the same ruleset over time.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20220506160820.524344-8-mic@digikod.net
---

Changes since v1:
* New patch.
---
 tools/testing/selftests/landlock/fs_test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 9165f6adf7b9..a8f54c4462eb 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -654,17 +654,23 @@ TEST_F_FORK(layout1, effective_access)
 	enforce_ruleset(_metadata, ruleset_fd);
 	ASSERT_EQ(0, close(ruleset_fd));
 
-	/* Tests on a directory. */
+	/* Tests on a directory (with or without O_PATH). */
 	ASSERT_EQ(EACCES, test_open("/", O_RDONLY));
+	ASSERT_EQ(0, test_open("/", O_RDONLY | O_PATH));
 	ASSERT_EQ(EACCES, test_open(dir_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s1d1, O_RDONLY | O_PATH));
 	ASSERT_EQ(EACCES, test_open(file1_s1d1, O_RDONLY));
+	ASSERT_EQ(0, test_open(file1_s1d1, O_RDONLY | O_PATH));
+
 	ASSERT_EQ(0, test_open(dir_s1d2, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d2, O_RDONLY));
 	ASSERT_EQ(0, test_open(dir_s1d3, O_RDONLY));
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 
-	/* Tests on a file. */
+	/* Tests on a file (with or without O_PATH). */
 	ASSERT_EQ(EACCES, test_open(dir_s2d2, O_RDONLY));
+	ASSERT_EQ(0, test_open(dir_s2d2, O_RDONLY | O_PATH));
+
 	ASSERT_EQ(0, test_open(file1_s2d2, O_RDONLY));
 
 	/* Checks effective read and write actions. */
-- 
2.35.1

