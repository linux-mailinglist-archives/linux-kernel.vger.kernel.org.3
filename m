Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD1FA462232
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbhK2U34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhK2UZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:25:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DF0C0254FA;
        Mon, 29 Nov 2021 09:01:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC0FF615BE;
        Mon, 29 Nov 2021 17:01:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C64EC53FAD;
        Mon, 29 Nov 2021 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638205265;
        bh=oenFJL2Wv8wyYsQIWdj3rYdoS7C7utIfHZRqntFJyRk=;
        h=From:To:Cc:Subject:Date:From;
        b=rlpKoXTDAH9Gy4Zk5JlUtoo1Zq69GM90tjzqYhc/4U17AyHUaCzWFUmRKXqbSTOXS
         Tk6PjHCimiL5Z1lacm0xB+7h98MTmEzo8CBClGW0h58i4ntF1M0RuSqyH6anNsuBHt
         yq+hzrdF1kNPkFWqE6GxgCq0DVC+7jAOOErvlaOTSQHj0eG+RQXbeqvTWDalxkzMCo
         1g2UaoYGspxzO5RLedqI/P+mh+vGi57BeE+QL/3xXYh3EyveH0fxR5uLaIk1KDEJXY
         Wsf8nJpHnc3lqHX+TT0EiMNOP/JvVzGYcM8UXqVQe7WpgOJxmWLaOyhV0bsJygoWJ0
         GHPdPToGtfN0g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Tom Stellard <tstellar@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>, cki-project@redhat.com,
        kernelci@groups.io, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH RFC 0/6] Bump minimum supported version of LLVM to 11.0.0
Date:   Mon, 29 Nov 2021 09:57:57 -0700
Message-Id: <20211129165803.470795-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series raises the minimum supported version of LLVM to
11.0.0.

Patch #1 outlines the issue, goes over the potential impact of the
change, and does the actual bump. Subsequent patches clean up the
various checks that are always true after the bump.

I have marked this revision as RFC to give various parties the option to
comment on this bump before it is done, namely KernelCI and Linaro's
LKFT, who are still testing clang-10. I have added some other folks to
CC that I know are testing with clang to see if this impacts them in any
way (as I would like to impact as few people as possible) but as far as
I am aware, most other CIs and developers are testing closer to tip of
tree. If that is not true, scream so that we can see what can be done
about that. If I missed anyone who is actively testing with clang,
please key them in and I will make sure to include them in future
revisions (if any are needed).

It probably makes sense for this series to live in -mm.

Nathan Chancellor (6):
  Documentation: Raise the minimum supported version of LLVM to 11.0.0
  mm, slab: Remove compiler check in __kmalloc_index
  arch/Kconfig: Remove CLANG_VERSION check in HAS_LTO_CLANG
  Revert "ARM: 9070/1: Make UNWINDER_ARM depend on ld.bfd or ld.lld
    11.0.0+"
  gcov: Remove compiler version check
  init/Kconfig: Drop linker version check for LD_ORPHAN_WARN

 Documentation/process/changes.rst | 2 +-
 arch/Kconfig                      | 3 +--
 arch/arm/Kconfig.debug            | 2 --
 include/linux/slab.h              | 3 +--
 init/Kconfig                      | 1 -
 kernel/gcov/Kconfig               | 1 -
 scripts/min-tool-version.sh       | 2 +-
 7 files changed, 4 insertions(+), 10 deletions(-)


base-commit: d58071a8a76d779eedab38033ae4c821c30295a5
-- 
2.34.1

