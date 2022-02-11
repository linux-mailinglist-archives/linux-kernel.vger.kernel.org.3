Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6099B4B28E2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351289AbiBKPOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:14:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240001AbiBKPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:14:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7EC781A3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 07:14:52 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CD08106F;
        Fri, 11 Feb 2022 07:14:52 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3F4453F718;
        Fri, 11 Feb 2022 07:14:50 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     acme@redhat.com, ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        mingo@redhat.com, ndesaulniers@google.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org
Subject: [PATCH v3 0/5] linkage: better symbol aliasing
Date:   Fri, 11 Feb 2022 15:14:40 +0000
Message-Id: <20220211151445.2027553-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

I've build-tested the following with both GCC 10.3.0 and LLVM 13.0.0
without issues (ignoring any existing warnings):

* arm omap1_defconfig (v2 broke with LLVM here)
* arm multi_v7_defconfig
* arm64 defconfig
* i386 defconfig
* x86_64 defconfig

I've boot-tested the arm64 Images.

I've pushed the series to my `linkage/alias-rework` branch on git.kernel.org,
atop v5.17-rc2:

  git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git linkage/alias-rework
  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=linkage/alias-rework

Since RFCv1 [1]:
* Drop arm64 dma alias removal (taken via arm64 for v5.17-rc1)
* Rename SYM_FUNC_LOCAL_ALIAS() -> SYM_FUNC_ALIAS_LOCAL()
* Update the tools/ copies of x86 routines
* Add preparatory fix for 32-bit arm
* Rebase to v5.17-rc1

Since v2 [2]:
* Rework to be LLVM-compatible
  - Drop SYM_ENTRY_AT() / SYM_END_AT()
  - Drop unnecessary local symbols
  - Calculate size in SYM_END()
  - Use common SYM_ALIAS()
* Drop newly redundant arch/arm changes
* Clarify commit message wording
* Fix typos

[1] https://lore.kernel.org/r/20211206124715.4101571-1-mark.rutland@arm.com/
[2] https://lore.kernel.org/r/20220125113200.3829108-1-mark.rutland@arm.com/

Thanks,
Mark.

Mark Rutland (5):
  linkage: add SYM_FUNC_ALIAS{,_LOCAL,_WEAK}()
  arm64: clean up symbol aliasing
  x86: clean up symbol aliasing
  linkage: remove SYM_FUNC_{START,END}_ALIAS()
  tools: update x86 string routines

 Documentation/asm-annotations.rst       | 11 ++--
 arch/arm64/include/asm/linkage.h        | 24 ---------
 arch/arm64/kvm/hyp/nvhe/cache.S         |  5 +-
 arch/arm64/lib/clear_page.S             |  5 +-
 arch/arm64/lib/copy_page.S              |  5 +-
 arch/arm64/lib/memchr.S                 |  5 +-
 arch/arm64/lib/memcmp.S                 |  6 +--
 arch/arm64/lib/memcpy.S                 | 21 ++++----
 arch/arm64/lib/memset.S                 | 12 +++--
 arch/arm64/lib/strchr.S                 |  6 ++-
 arch/arm64/lib/strcmp.S                 |  6 +--
 arch/arm64/lib/strlen.S                 |  6 +--
 arch/arm64/lib/strncmp.S                |  6 +--
 arch/arm64/lib/strnlen.S                |  6 ++-
 arch/arm64/lib/strrchr.S                |  5 +-
 arch/arm64/mm/cache.S                   | 35 +++++++------
 arch/x86/boot/compressed/head_32.S      |  3 +-
 arch/x86/boot/compressed/head_64.S      |  3 +-
 arch/x86/crypto/aesni-intel_asm.S       |  4 +-
 arch/x86/lib/memcpy_64.S                | 10 ++--
 arch/x86/lib/memmove_64.S               |  4 +-
 arch/x86/lib/memset_64.S                |  6 +--
 include/linux/linkage.h                 | 67 +++++++++++++------------
 tools/arch/x86/lib/memcpy_64.S          | 10 ++--
 tools/arch/x86/lib/memset_64.S          |  6 +--
 tools/perf/util/include/linux/linkage.h | 46 ++++++++++++-----
 26 files changed, 169 insertions(+), 154 deletions(-)

-- 
2.30.2

