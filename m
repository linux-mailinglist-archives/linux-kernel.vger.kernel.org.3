Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4BC531271
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238425AbiEWQNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238404AbiEWQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:13:31 -0400
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735233151C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 09:13:29 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4L6Mng4qkszMqCsj;
        Mon, 23 May 2022 18:13:27 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4L6Mnf45hLzlhMCc;
        Mon, 23 May 2022 18:13:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1653322407;
        bh=XhUEXOgvMyh0yaNnTTP+A90mHJw1pe7rby6geeIj66w=;
        h=From:To:Cc:Subject:Date:From;
        b=RJx2Mcv6Igs2Fb+Wk9itfGL7Yrg8wli7MAdBjIK9zfDLJoVpuZOMFCDZq+PCrysRO
         dwF6QKAo/9PNNHlyXjIIQcb+hgDo6WLr1eBdhfsYstbxxRFddZRe3CL/jTPpUgDcF7
         yASOe57XCJd9pfCoyY0QyacLLh2DRNl1KPG/wOTo=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        John Johansen <john.johansen@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock changes for v5.19
Date:   Mon, 23 May 2022 18:12:45 +0200
Message-Id: <20220523161245.2451265-1-mic@digikod.net>
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

Hi Linus,

Please pull these Landlock changes for v5.19-rc1 .  These 30 commits
have been successfully tested in the latest linux-next releases for
several weeks, and with syzkaller:
https://github.com/google/syzkaller/pull/3133

Regards,
 Mickaël

--
The following changes since commit 672c0c5173427e6b3e2a9bbb7be51ceeec78093a:

  Linux 5.18-rc5 (2022-05-01 13:57:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-5.19-rc1

for you to fetch changes up to 5e469829baa1b1320e843adf3631edef1d6d2cf2:

  landlock: Explain how to support Landlock (2022-05-23 13:28:03 +0200)

----------------------------------------------------------------
Landlock updates for v5.19-rc1

Important changes:
* improve the path_rename LSM hook implementations for RENAME_EXCHANGE;
* fix a too-restrictive filesystem control for a rare corner case;
* set the nested sandbox limitation to 16 layers;
* add a new LANDLOCK_ACCESS_FS_REFER access right to properly handle
  file reparenting (i.e. full rename and link support);
* add new tests and documentation;
* format code with clang-format to make it easier to maintain and
  contribute.

Related patch series:
* [PATCH v1 0/7] Landlock: Clean up coding style with clang-format
  https://lore.kernel.org/r/20220506160513.523257-1-mic@digikod.net
* [PATCH v2 00/10] Minor Landlock fixes and new tests
  https://lore.kernel.org/r/20220506160820.524344-1-mic@digikod.net
* [PATCH v3 00/12] Landlock: file linking and renaming support
  https://lore.kernel.org/r/20220506161102.525323-1-mic@digikod.net
* [PATCH v2] landlock: Explain how to support Landlock
  https://lore.kernel.org/r/20220513112743.156414-1-mic@digikod.net

----------------------------------------------------------------
Mickaël Salaün (30):
      landlock: Add clang-format exceptions
      landlock: Format with clang-format
      selftests/landlock: Add clang-format exceptions
      selftests/landlock: Normalize array assignment
      selftests/landlock: Format with clang-format
      samples/landlock: Add clang-format exceptions
      samples/landlock: Format with clang-format
      landlock: Fix landlock_add_rule(2) documentation
      selftests/landlock: Make tests build with old libc
      selftests/landlock: Extend tests for minimal valid attribute size
      selftests/landlock: Add tests for unknown access rights
      selftests/landlock: Extend access right tests to directories
      selftests/landlock: Fully test file rename with "remove" access
      selftests/landlock: Add tests for O_PATH
      landlock: Change landlock_add_rule(2) argument check ordering
      landlock: Change landlock_restrict_self(2) check ordering
      selftests/landlock: Test landlock_create_ruleset(2) argument check ordering
      landlock: Define access_mask_t to enforce a consistent access mask size
      landlock: Reduce the maximum number of layers to 16
      landlock: Create find_rule() from unmask_layers()
      landlock: Fix same-layer rule unions
      landlock: Move filesystem helpers and add a new one
      LSM: Remove double path_rename hook calls for RENAME_EXCHANGE
      landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER
      selftests/landlock: Add 11 new test suites dedicated to file reparenting
      samples/landlock: Add support for file reparenting
      landlock: Document LANDLOCK_ACCESS_FS_REFER and ABI versioning
      landlock: Document good practices about filesystem policies
      landlock: Add design choices documentation for filesystem access rights
      landlock: Explain how to support Landlock

 Documentation/security/landlock.rst            |   17 +-
 Documentation/userspace-api/landlock.rst       |  180 ++-
 include/linux/lsm_hook_defs.h                  |    2 +-
 include/linux/lsm_hooks.h                      |    1 +
 include/uapi/linux/landlock.h                  |   36 +-
 samples/landlock/sandboxer.c                   |  132 +-
 security/apparmor/lsm.c                        |   30 +-
 security/landlock/cred.c                       |    4 +-
 security/landlock/cred.h                       |    8 +-
 security/landlock/fs.c                         |  815 +++++++++---
 security/landlock/fs.h                         |   11 +-
 security/landlock/limits.h                     |   10 +-
 security/landlock/object.c                     |    6 +-
 security/landlock/object.h                     |    6 +-
 security/landlock/ptrace.c                     |   10 +-
 security/landlock/ruleset.c                    |   84 +-
 security/landlock/ruleset.h                    |   35 +-
 security/landlock/syscalls.c                   |   95 +-
 security/security.c                            |    9 +-
 security/tomoyo/tomoyo.c                       |   11 +-
 tools/testing/selftests/landlock/base_test.c   |  179 ++-
 tools/testing/selftests/landlock/common.h      |   66 +-
 tools/testing/selftests/landlock/fs_test.c     | 1619 +++++++++++++++++++-----
 tools/testing/selftests/landlock/ptrace_test.c |   40 +-
 24 files changed, 2646 insertions(+), 760 deletions(-)
