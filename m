Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1413A46C23C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbhLGSDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:03:42 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:58426 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240264AbhLGSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:03:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4F09CCE1B1D;
        Tue,  7 Dec 2021 18:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF552C341C3;
        Tue,  7 Dec 2021 18:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638900008;
        bh=aKg6nSmYDNEZA50nS90q2gIS47iA/LbgPSILNYZJWOc=;
        h=From:To:Cc:Subject:Date:From;
        b=K7+UDhhcc0dBOU7MqY4SBN3EJksBg2IH6U9FEexlBdqMfhrUTWOJx4e/fSnE7hxAx
         6/bDkGw1uxCK4vJ2A8333tMo6owkRiBZ9Hpyb5xJHUvCLRoFBDxjkdDvW9GyMu9+9d
         wBrGthjDEgRyimNqrM9giAOchoDuHBh/rs/ErnYG+ygWADuuovrFzNOythJL9uMSqj
         GZPD5Z2E/uYB1+UWrApVfeh3co+Zu9Qs3pOmH9jBeA/BA2C5ptlBMJno+6gtWhmb0N
         QYXnw4rjHmlgdsa8ri4LbIuXKXvAhDsAQul8v1sJprPFrJchMDLdlQi3AHR7HPXUeG
         NWKC2Zr7uF37w==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Subject: [PATCH] MIPS: Loongson2ef: Remove unnecessary {as,cc}-option calls
Date:   Tue,  7 Dec 2021 10:59:51 -0700
Message-Id: <20211207175951.135400-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with LLVM's integrated assembler, the build errors because
it does not implement -mfix-loongson2f-{jump,nop}:

arch/mips/loongson2ef/Platform:36: *** only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop.  Stop.

The error is a little misleading because binutils are not being used in
this case.

To clear this up, remove the as-option calls because binutils 2.23 is
the minimum supported version for building the kernel. At the same time,
remove the cc-option calls for the '-march=' flags, as GCC 5.1.0 is the
minimum supported version.

This change will not fix the LLVM build for CONFIG_CPU_LOONGSON2{E,F},
as it does not implement the loongson2{e,f} march arguments (nor r4600,
so it will error prior to this change) nor the assembler flags mentioned
above but it will make the errors more obvious.

Link: https://github.com/ClangBuiltLinux/linux/issues/1529
Reported-by: Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

This dependency on certain toolchain flags should probably be moved into
Kconfig at some point so that users cannot select configurations that
they do not have support for so that their builds do not error. However,
from a brief survey, there is not a clean way to codify these
dependencies at the moment because the CPU configs are selected by the
individual machines that implement them, meaning that the dependencies
would need to be added to all the machine configs (as 'select ...'
overrides 'depends on ...'), which is outside the scope of this patch.
Furthermore, one could argue that it is better for the user to get a big
error when they are missing support for something, rather than the
configs getting disabled silently, especially if they are critical to
the machine.

 arch/mips/loongson2ef/Platform | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/mips/loongson2ef/Platform b/arch/mips/loongson2ef/Platform
index ae023b9a1c51..50e659aca543 100644
--- a/arch/mips/loongson2ef/Platform
+++ b/arch/mips/loongson2ef/Platform
@@ -2,12 +2,9 @@
 # Loongson Processors' Support
 #
 
-# Only gcc >= 4.4 have Loongson specific support
 cflags-$(CONFIG_CPU_LOONGSON2EF)	+= -Wa,--trap
-cflags-$(CONFIG_CPU_LOONGSON2E) += \
-	$(call cc-option,-march=loongson2e,-march=r4600)
-cflags-$(CONFIG_CPU_LOONGSON2F) += \
-	$(call cc-option,-march=loongson2f,-march=r4600)
+cflags-$(CONFIG_CPU_LOONGSON2E) += -march=loongson2e
+cflags-$(CONFIG_CPU_LOONGSON2F) += -march=loongson2f
 #
 # Some versions of binutils, not currently mainline as of 2019/02/04, support
 # an -mfix-loongson3-llsc flag which emits a sync prior to each ll instruction
@@ -32,16 +29,8 @@ cflags-$(CONFIG_CPU_LOONGSON2EF)	+= $(call as-option,-Wa$(comma)-mno-fix-loongso
 
 # Enable the workarounds for Loongson2f
 ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
-  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)
-    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-nop)
-  else
-    cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-nop
-  endif
-  ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-jump,),)
-    $(error only binutils >= 2.20.2 have needed option -mfix-loongson2f-jump)
-  else
-    cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa$(comma)-mfix-loongson2f-jump
-  endif
+cflags-$(CONFIG_CPU_NOP_WORKAROUNDS) += -Wa,-mfix-loongson2f-nop
+cflags-$(CONFIG_CPU_JUMP_WORKAROUNDS) += -Wa,-mfix-loongson2f-jump
 endif
 
 # Some -march= flags enable MMI instructions, and GCC complains about that

base-commit: 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
-- 
2.34.1

