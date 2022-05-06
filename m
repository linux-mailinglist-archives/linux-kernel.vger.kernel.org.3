Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7FB151DCED
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443454AbiEFQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443434AbiEFQKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:10:47 -0400
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch [IPv6:2001:1600:3:17::42af])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7197C3B026
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:06:59 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwS14sS9zMqpmv;
        Fri,  6 May 2022 18:06:57 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwS05F2nzlhMBg;
        Fri,  6 May 2022 18:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853217;
        bh=+g6nltvqYNf1CZKZic5eqqeCIzlw7XGV0BEiW9ZEQ80=;
        h=From:To:Cc:Subject:Date:From;
        b=Z2fF1yW2U0IXfjgHxAffPLaWEtBpl7E9tuO99BpdDQsBtPy3tYzbF7JvW1ckSMkwT
         S158RLiD1+HeLu/ewGy2lH2+VoVjfCK4Kc9B3HUT3LIq4fbLKT+PrS8cLL+IhNZssy
         3D+ddN+4+RpU+hMlGtCKQFrdvfh0069sREXUGhKg=
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
Subject: [PATCH v2 00/10] Minor Landlock fixes and new tests
Date:   Fri,  6 May 2022 18:08:10 +0200
Message-Id: <20220506160820.524344-1-mic@digikod.net>
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

Hi,

This series contains some minor code and documentation fixes.  There is
also some miscellaneous new tests to improve coverage and that may help
for future access types (e.g. networking).

The important new patches are the last three ones.  They change the
landlock_add_rule(2) and landlock_restrict_self(2) check orderings to
make them more consistent according to future Landlock rule types (e.g.
networking).

As suggested by Alejandro Colomar [1], I removed the
landlock_add_rule(2) signature fix.  I added a new patch to test O_PATH
behavior.

Test coverage for security/landlock was 94.4% of 500 lines, and it is
now 94.4% of 504 lines according to gcc/gcov-11.

I also fixed some typos and formatted the code with clang-format.  This
series can be applied on top of
https://lore.kernel.org/r/20220506160513.523257-1-mic@digikod.net

[1] https://lore.kernel.org/r/ae52c028-05c7-c22e-fc47-d97ee4a2f6c7@gmail.com

Previous version:
https://lore.kernel.org/r/20220221155311.166278-1-mic@digikod.net

Regards,

Mickaël Salaün (10):
  landlock: Fix landlock_add_rule(2) documentation
  selftests/landlock: Make tests build with old libc
  selftests/landlock: Extend tests for minimal valid attribute size
  selftests/landlock: Add tests for unknown access rights
  selftests/landlock: Extend access right tests to directories
  selftests/landlock: Fully test file rename with "remove" access
  selftests/landlock: Add tests for O_PATH
  landlock: Change landlock_add_rule(2) argument check ordering
  landlock: Change landlock_restrict_self(2) check ordering
  selftests/landlock: Test landlock_create_ruleset(2) argument check
    ordering

 include/uapi/linux/landlock.h                |   5 +-
 security/landlock/syscalls.c                 |  37 +++---
 tools/testing/selftests/landlock/base_test.c | 107 +++++++++++++++--
 tools/testing/selftests/landlock/fs_test.c   | 120 ++++++++++++++++---
 4 files changed, 218 insertions(+), 51 deletions(-)


base-commit: 763c5dc0e990fbd803c3c2b1ae832366ab7d207f
-- 
2.35.1

