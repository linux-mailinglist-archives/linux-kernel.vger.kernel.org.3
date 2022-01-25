Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A1E49B2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 12:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351946AbiAYLea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 06:34:30 -0500
Received: from foss.arm.com ([217.140.110.172]:36768 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241188AbiAYLcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 06:32:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75C41FB;
        Tue, 25 Jan 2022 03:32:08 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E5D8E3F7D8;
        Tue, 25 Jan 2022 03:32:06 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v2 0/7] linkage: better symbol aliasing
Date:   Tue, 25 Jan 2022 11:31:53 +0000
Message-Id: <20220125113200.3829108-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series aims to make symbol aliasing simpler and more consistent.
The basic idea is to replace SYM_FUNC_START_ALIAS(alias) and
SYM_FUNC_END_ALIAS(alias) with a new SYM_FUNC_ALIAS(alias, name), so
that e.g.

    SYM_FUNC_START(func)
    SYM_FUNC_START_ALIAS(alias1)
    SYM_FUNC_START_ALIAS(alias2)
        ... asm insns ...
    SYM_FUNC_END(func)
    SYM_FUNC_END_ALIAS(alias1)
    SYM_FUNC_END_ALIAS(alias2)
    EXPORT_SYMBOL(alias1)
    EXPORT_SYMBOL(alias2)

... can become:

    SYM_FUNC_START(name)
        ... asm insns ...
    SYM_FUNC_END(name)

    SYM_FUNC_ALIAS(alias1, func)
    EXPORT_SYMBOL(alias1)

    SYM_FUNC_ALIAS(alias2, func)
    EXPORT_SYMBOL(alias2)

This avoids repetition and hopefully make it easier to ensure
consistency (e.g. so each function has a single canonical name and
associated metadata).

I've build+boot tested arm64 defconfig without issues, and also build
tested arm/i386/x86_64 defconfig without issues. I've pushed the series
to my `linkage/alias-rework` branch on git.kernel.org, atop v5.17-rc1:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=linkage/alias-rework

Since RFCv1 [1]:
* Drop arm64 dma alias removal (taken via arm64 for v5.17)
* Rename SYM_FUNC_LOCAL_ALIAS() -> SYM_FUNC_ALIAS_LOCAL()
* Update the tools/ copies of x86 routines
* Add preparatory fix for 32-bit arm
* Rebase to v5.17-rc1

[1] https://lore.kernel.org/r/20211206124715.4101571-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (7):
  arm: lib: remove leading whitespace in bitop macro
  linkage: add SYM_{ENTRY,START,END}_AT()
  linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
  arm64: clean up symbol aliasing
  x86: clean up symbol aliasing
  linkage: remove SYM_FUNC_{START,END}_ALIAS()
  tools: update x86 string routines

 Documentation/asm-annotations.rst       | 11 ++--
 arch/arm/lib/bitops.h                   |  8 +--
 arch/arm64/include/asm/linkage.h        | 24 -------
 arch/arm64/kvm/hyp/nvhe/cache.S         |  5 +-
 arch/arm64/lib/clear_page.S             |  5 +-
 arch/arm64/lib/copy_page.S              |  5 +-
 arch/arm64/lib/memchr.S                 |  5 +-
 arch/arm64/lib/memcmp.S                 |  6 +-
 arch/arm64/lib/memcpy.S                 | 21 +++---
 arch/arm64/lib/memset.S                 | 12 ++--
 arch/arm64/lib/strchr.S                 |  6 +-
 arch/arm64/lib/strcmp.S                 |  6 +-
 arch/arm64/lib/strlen.S                 |  6 +-
 arch/arm64/lib/strncmp.S                |  6 +-
 arch/arm64/lib/strnlen.S                |  6 +-
 arch/arm64/lib/strrchr.S                |  5 +-
 arch/arm64/mm/cache.S                   | 35 ++++++----
 arch/x86/boot/compressed/head_32.S      |  3 +-
 arch/x86/boot/compressed/head_64.S      |  3 +-
 arch/x86/crypto/aesni-intel_asm.S       |  4 +-
 arch/x86/lib/memcpy_64.S                | 10 +--
 arch/x86/lib/memmove_64.S               |  4 +-
 arch/x86/lib/memset_64.S                |  6 +-
 include/linux/linkage.h                 | 87 +++++++++++++++----------
 tools/arch/x86/lib/memcpy_64.S          | 10 +--
 tools/arch/x86/lib/memset_64.S          |  6 +-
 tools/perf/util/include/linux/linkage.h | 80 +++++++++++++++--------
 27 files changed, 209 insertions(+), 176 deletions(-)

-- 
2.30.2

