Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6184051DCCB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443348AbiEFQHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 12:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiEFQHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 12:07:34 -0400
Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6A369CCB
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 09:03:50 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KvwNN4jhtzMqKsD;
        Fri,  6 May 2022 18:03:48 +0200 (CEST)
Received: from localhost (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4KvwNN2ZszzljsTF;
        Fri,  6 May 2022 18:03:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651853028;
        bh=b8DXJhHh0abOxq3vv6dVqiGLZkdpmtAtsCbdnpcP6hs=;
        h=From:To:Cc:Subject:Date:From;
        b=iYHG1HlcrZ5Ja8YnLx0lGGv3m9j+8LE2QQO6osFAB4NUlzesZybjwaZa4tvog+ilo
         OHp4SJo3BXzO2aoZ5zhsMNNM4gRcQZTU+7KWwMnmlvx1IASZI1HgWyi9/Y1eqpRQqO
         j/9Dt9FPBq8qDewcItrM9p2tsbEbQvCpf4v38LIQ=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Kees Cook <keescook@chromium.org>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Shuah Khan <shuah@kernel.org>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [PATCH v1 0/7] Landlock: Clean up coding style with clang-format
Date:   Fri,  6 May 2022 18:05:06 +0200
Message-Id: <20220506160513.523257-1-mic@digikod.net>
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

Hi,

I used a simple coding style for the initial Landlock code.  However,
this may be subject to different interpretations.  To avoid relying
on tacit knowledge or text editors for these kind of rules, let's
automate it as much as possible thanks to clang-format.  This makes the
code formatting simple, consistent and impersonal.

Several versions of clang-format can be use but they may have (small)
different behaviors for undefined/new configuration parts.  After
testing different versions, I picked clang-format-14 which is relatively
new and fixes a bug present in version 11 to 13 (visible in the Landlock
formatted code).

I'll backport these patches and enforce this formatting for all the new
Landlock patches.

This series uses a patched clang-format configuration to make it
compatible with checkpatch.pl:
https://lore.kernel.org/r/20220506160106.522341-1-mic@digikod.net

It can be applied on v5.18-rc5 .

Regards,

Mickaël Salaün (7):
  landlock: Add clang-format exceptions
  landlock: Format with clang-format
  selftests/landlock: Add clang-format exceptions
  selftests/landlock: Normalize array assignment
  selftests/landlock: Format with clang-format
  samples/landlock: Add clang-format exceptions
  samples/landlock: Format with clang-format

 include/uapi/linux/landlock.h                 |   4 +
 samples/landlock/sandboxer.c                  | 104 ++--
 security/landlock/cred.c                      |   4 +-
 security/landlock/cred.h                      |   8 +-
 security/landlock/fs.c                        |  80 +--
 security/landlock/fs.h                        |  11 +-
 security/landlock/limits.h                    |   4 +
 security/landlock/object.c                    |   6 +-
 security/landlock/object.h                    |   6 +-
 security/landlock/ptrace.c                    |  10 +-
 security/landlock/ruleset.c                   |  80 +--
 security/landlock/ruleset.h                   |  15 +-
 security/landlock/syscalls.c                  |  60 +-
 tools/testing/selftests/landlock/base_test.c  |  80 +--
 tools/testing/selftests/landlock/common.h     |  66 ++-
 tools/testing/selftests/landlock/fs_test.c    | 532 ++++++++++--------
 .../testing/selftests/landlock/ptrace_test.c  |  38 +-
 17 files changed, 615 insertions(+), 493 deletions(-)


base-commit: 5c22d35e0cc57032edd92df16f530e3c9a33c027
-- 
2.35.1

