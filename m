Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F1649BE60
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 23:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiAYWT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 17:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiAYWTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 17:19:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2E9C06173B;
        Tue, 25 Jan 2022 14:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A815B81062;
        Tue, 25 Jan 2022 22:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C45C340E6;
        Tue, 25 Jan 2022 22:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643149186;
        bh=w68DEAUNHKhXspFgbyIygYSBDiRFMAt8ZTY71GPUW64=;
        h=From:To:Cc:Subject:Date:From;
        b=i2k5WHPuCnb/+W2eJT5mSdz9jfaw7bGg8R9bMvi46PioHZzHElsnND6ZLbgW++2w+
         kOLFA0mHtuE1h4NpnDtGG9yNXaYQnjEu/tJ9EHOUWRntSIo+L4PCeCcMdb0Rx8l38/
         5b/wdPmvGnWpYnVrivtYtAb9kWgNZf4IXVOO1Bwjs6ItwEjqL1uztO6cnwZPwkjEl9
         gJFrdEOmD/RGXBE6CP1DM1JOQBCsBSaoggpVcFx9fmt40NM3W1G5f/nUfXKolNXrNY
         KWhuF99bvR322V3BcrcG5kRq+KQ1VyWywbaSK+BVjzxJ68gw7VfU6ZfJRV34SuG1s5
         EhuZ08AGqkoJg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH v2 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Date:   Tue, 25 Jan 2022 15:19:24 -0700
Message-Id: <20220125221925.3547683-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Makefile checks that GCC is 4.9 or newer, which is redundant after
commit 76ae847497bc ("Documentation: raise minimum supported version of
GCC to 5.1"), so cc-option can be removed.

Clang does not support -march=loongson3a so it needs to continue to use
-march=mips64r2, which no longer needs cc-option because all supported
clang versions recognize this flag.

-march=loonson3a can be used unconditionally with GCC because the
minimum supported GCC version has been bumped past 4.9.0, which won't
have the bug mentioned in the comment. The _MIPS_ISA macro redefinition
can be removed at the same time for the same reason.

Suggested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

v1 -> v2: https://lore.kernel.org/r/20220120214001.1879469-1-nathan@kernel.org/

* Eliminate ld-option call (Jiaxun).
* Eliminate _MIPS_ISA macro redefinitions (Nick).

 arch/mips/loongson64/Platform | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 3e660d6d3c2b..f2a08a185ee2 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -5,24 +5,9 @@
 
 cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
 
-#
-# binutils from v2.25 on and gcc starting from v4.9.0 treat -march=loongson3a
-# as MIPS64 R2; older versions as just R1.  This leaves the possibility open
-# that GCC might generate R2 code for -march=loongson3a which then is rejected
-# by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
-# can't easily be used safely within the kbuild framework.
-#
-ifeq ($(call cc-ifversion, -ge, 0409, y), y)
-  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  endif
-else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+ifdef CONFIG_CPU_LOONGSON64
+cflags-$(CONFIG_CC_IS_GCC) += -march=loongson3a
+cflags-$(CONFIG_CC_IS_CLANG) += -march=mips64r2
 endif
 
 # Some -march= flags enable MMI instructions, and GCC complains about that

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
-- 
2.35.0

