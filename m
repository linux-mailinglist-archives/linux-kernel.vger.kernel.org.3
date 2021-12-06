Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC704695EF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbhLFMuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:50:51 -0500
Received: from foss.arm.com ([217.140.110.172]:56254 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233165AbhLFMuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:50:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F74F6D;
        Mon,  6 Dec 2021 04:47:21 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603183F73D;
        Mon,  6 Dec 2021 04:47:19 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Jiri Slaby <jslaby@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     ardb@kernel.org, broonie@kernel.org, catalin.marinas@arm.com,
        dave.hansen@linux.intel.com, linux-arm-kernel@lists.infradead.org,
        mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 0/6] linkage: better symbol aliasing
Date:   Mon,  6 Dec 2021 12:47:09 +0000
Message-Id: <20211206124715.4101571-1-mark.rutland@arm.com>
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

I'm sending this as an RFC since I want to check:

a) People are happy with the idea in principle.

b) People are happy with the implementation within <linux/linkage.h>.

... and I haven't yet converted the headers under tools/, which is
largely a copy+paste job.

I've build+boot tested arm64 and x86 defconfig without issues, and I've
pushed the series to my `linkage/alias-rework` branch on git.kernel.org,
atop v5.16-rc3:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=linkage/alias-rework

Thanks,
Mark.

Mark Rutland (6):
  linkage: add SYM_{ENTRY,START,END}_AT()
  linkage: add SYM_FUNC_{LOCAL_,}ALIAS()
  arm64: remove __dma_*_area() aliases
  arm64: clean up symbol aliasing
  x86: clean up symbol aliasing
  linkage: remove START/END ALIAS macros

 Documentation/asm-annotations.rst  | 11 ++--
 arch/arm64/include/asm/linkage.h   | 24 ---------
 arch/arm64/kvm/hyp/nvhe/cache.S    |  5 +-
 arch/arm64/lib/clear_page.S        |  5 +-
 arch/arm64/lib/copy_page.S         |  5 +-
 arch/arm64/lib/memchr.S            |  5 +-
 arch/arm64/lib/memcmp.S            |  6 +--
 arch/arm64/lib/memcpy.S            | 21 ++++----
 arch/arm64/lib/memset.S            | 12 +++--
 arch/arm64/lib/strchr.S            |  6 ++-
 arch/arm64/lib/strcmp.S            |  6 +--
 arch/arm64/lib/strlen.S            |  6 +--
 arch/arm64/lib/strncmp.S           |  8 +--
 arch/arm64/lib/strnlen.S           |  6 ++-
 arch/arm64/lib/strrchr.S           |  5 +-
 arch/arm64/mm/cache.S              | 59 +++++++++-----------
 arch/x86/boot/compressed/head_32.S |  3 +-
 arch/x86/boot/compressed/head_64.S |  3 +-
 arch/x86/lib/memcpy_64.S           | 10 ++--
 arch/x86/lib/memmove_64.S          |  4 +-
 arch/x86/lib/memset_64.S           |  6 +--
 include/linux/linkage.h            | 86 ++++++++++++++++++------------
 22 files changed, 146 insertions(+), 156 deletions(-)

-- 
2.30.2

