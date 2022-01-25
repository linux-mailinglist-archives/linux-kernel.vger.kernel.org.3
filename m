Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E29CE49BE61
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbiAYWT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:19:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47346 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbiAYWTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:19:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C86ACB81B76;
        Tue, 25 Jan 2022 22:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD26FC340E7;
        Tue, 25 Jan 2022 22:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643149189;
        bh=3ZivQ+FV86iNurkooJ7KOtL0OLNq/84ROVUSZKlyUQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1bwuR0A6QqrCq/SDFCiXZKLqitK5ygFouhvtwcGnCqmRrB+sA4+WwQX8sTzzvQUN
         i302fTiAqLA6FD6R8XIGsfnzRLUkfhtF5tWAFnW/PnJLX5JLWRCRaImDxJMOcnEd1f
         ncOdBckbw2V4fsZ4DTDsciUNrEGo3frRNuwM6skqlVfqLBG3LIWRnXw+nSil75TWl8
         Aqy95geVO1I9rDUz18e3ql8vQ44KSCSWChZmkAoFKicY3++slU4WnY8NXCkA1Ew542
         0dmeQb2TbPY5TJIAuS20mMBShWABctXvFngYF2KNe5i4Y+Jz2fU+8ViuXDRapHz8ck
         4dhQzjVt1Yhfw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 2/2] MIPS: Loongson{2ef,64}: Wrap -mno-branch-likely with cc-option
Date:   Tue, 25 Jan 2022 15:19:25 -0700
Message-Id: <20220125221925.3547683-2-nathan@kernel.org>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220125221925.3547683-1-nathan@kernel.org>
References: <20220125221925.3547683-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag is not supported by clang, which results in a warning:

  clang-14: warning: argument unused during compilation: '-mno-branch-likely' [-Wunused-command-line-argument]

This breaks cc-option, which adds -Werror to make this warning fatal and
catch flags that are not supported.

Wrap this flag in cc-option so that it does not cause cc-option to fail,
which can cause randconfigs to be really noisy, due to warnings not
getting disabled that should be.

Additionally, move the cc-option check to Kconfig so that the check is
done at configuration time, rather than build time, as builds with no
configuration change will be quicker because the cc-option call will not
need to happen in those instances.

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20220120214001.1879469-2-nathan@kernel.org/

* Move cc-option call to Kconfig (Nick).
* Also apply to loongson2ef, even though this will not currently build
  with clang.

 arch/mips/Kconfig              | 4 ++++
 arch/mips/loongson2ef/Platform | 3 ++-
 arch/mips/loongson64/Platform  | 3 ++-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 058446f01487..da6b3e0501a7 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3202,6 +3202,10 @@ config MIPS32_N32
 
 	  If unsure, say N.
 
+config CC_HAS_MNO_BRANCH_LIKELY
+	def_bool y
+	depends on $(cc-option,-mno-branch-likely)
+
 menu "Power management options"
 
 config ARCH_HIBERNATION_POSSIBLE
diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index 50e659aca543..eebabf9df6ac 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -41,6 +41,7 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
 # Loongson Machines' Support
 #
 
-cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef -mno-branch-likely
+cflags-$(CONFIG_MACH_LOONGSON2EF) += -I$(srctree)/arch/mips/include/asm/mach-loongson2ef
+cflags-$(CONFIG_CC_HAS_MNO_BRANCH_LIKELY) += -mno-branch-likely
 load-$(CONFIG_LEMOTE_FULOONG2E) += 0xffffffff80100000
 load-$(CONFIG_LEMOTE_MACH2F) += 0xffffffff80200000
diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index f2a08a185ee2..473404cae1c4 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -18,5 +18,6 @@ cflags-y += $(call cc-option,-mno-loongson-mmi)
 # Loongson Machines' Support
 #
 
-cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64 -mno-branch-likely
+cflags-$(CONFIG_MACH_LOONGSON64) += -I$(srctree)/arch/mips/include/asm/mach-loongson64
+cflags-$(CONFIG_CC_HAS_MNO_BRANCH_LIKELY) += -mno-branch-likely
 load-$(CONFIG_CPU_LOONGSON64) += 0xffffffff80200000
-- 
2.35.0

