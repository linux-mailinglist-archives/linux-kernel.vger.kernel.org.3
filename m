Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C7D495609
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 22:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377966AbiATVkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 16:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:40:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62671C061574;
        Thu, 20 Jan 2022 13:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06CA618E8;
        Thu, 20 Jan 2022 21:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7702C340E0;
        Thu, 20 Jan 2022 21:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642714810;
        bh=WTK4x+RMVHC2SkV4JqF2eL7XTJAYgGKA4+L/GkpSgXY=;
        h=From:To:Cc:Subject:Date:From;
        b=GHAeDLJs2E4fu8rPPggQzPa+Pn/iV8Ls/n8sB94ky75RJjFwCV4/FLO/lr9DhHr1Y
         qlZM0aSMicOKW6cr/tbZYlqaTlsQOg58eWIzyJA1AAcbST24Im4028OytA1aUrhMfP
         X+mae4bdnct/pGLL/H99GNKTB+N25mLJCGNEO07yT2wnkSpCu16YnrppSdI6RjZzs0
         NgUcgO5of0CJDYVkF/d5hKaSl3xiKPKH0lm+Yw7vG5tzC+ETFZQOIWigbz2VfV+JGj
         mrQjabmnU6j2R2l6Oyd/ibK2XdNuAJ2oG6GmnXPDW8RqegPE46MwAp6n4FxWxVheED
         4fRyewtN9By2Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] MIPS: Loongson64: Clean up use of cc-ifversion
Date:   Thu, 20 Jan 2022 14:40:00 -0700
Message-Id: <20220120214001.1879469-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Makefile checks that GCC is 4.9 or newer, which is redundant after
commit 76ae847497bc ("Documentation: raise minimum supported version of
GCC to 5.1"), so cc-option can be removed.

Clang does not support -march=loongson3a so it needs to continue to use
-march=mips64r2, along with binutils less than 2.25, so check that both
GCC and binutils 2.25 or newer are being used before using
-march=loongson3a. These flags do not need to be checked with cc-option
anymore because all GCC versions support -march=loongson3a and
-march=mips64r2 and all clang versions support -march=mips64r2.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/mips/loongson64/Platform | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/mips/loongson64/Platform b/arch/mips/loongson64/Platform
index 3e660d6d3c2b..981d3abc150e 100644
--- a/arch/mips/loongson64/Platform
+++ b/arch/mips/loongson64/Platform
@@ -12,17 +12,10 @@ cflags-$(CONFIG_CPU_LOONGSON64)	+= -Wa,--trap
 # by GAS.  The cc-option can't probe for this behaviour so -march=loongson3a
 # can't easily be used safely within the kbuild framework.
 #
-ifeq ($(call cc-ifversion, -ge, 0409, y), y)
-  ifeq ($(call ld-ifversion, -ge, 22500, y), y)
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
-  endif
+ifeq ($(CONFIG_CC_IS_GCC)$(call ld-ifversion, -ge, 22500, y), yy)
+  cflags-$(CONFIG_CPU_LOONGSON64) += -march=loongson3a -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64
 else
-    cflags-$(CONFIG_CPU_LOONGSON64)  += \
-      $(call cc-option,-march=mips64r2,-mips64r2 -U_MIPS_ISA -D_MIPS_ISA=_MIPS_ISA_MIPS64)
+  cflags-$(CONFIG_CPU_LOONGSON64) += -march=mips64r2
 endif
 
 # Some -march= flags enable MMI instructions, and GCC complains about that

base-commit: 2c271fe77d52a0555161926c232cd5bc07178b39
-- 
2.34.1

