Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E1659ACD2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiHTJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:16:47 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CFAB4430;
        Sat, 20 Aug 2022 02:16:46 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 27K9FiMS016772;
        Sat, 20 Aug 2022 18:15:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 27K9FiMS016772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660986945;
        bh=MDlM2ezt7enZ+5N0kMoHRQz+q0tdiPxN4ldECtwKlWs=;
        h=From:To:Cc:Subject:Date:From;
        b=rruKtIhpW+mjCAIi5rPbs53ivNGHP9ehWm/Agyg928NYsdSwce5WjYsMLqay2g6KT
         m2SsKzSS5bvGdI5PhvAVofeduLwQC2wckFIRnjdR6JSDy3nzX47AGdS2zX+C/dPFnf
         anknFsMmH8M8gwXQsG7Rcuz3X+LYX6fcZBLqNfJyUGe4aIf5T3YKYFsiDp+n0fuE8a
         5b6qqqf5zBZdk8pJsSaf4P/BgWHC/VoBtppcFQI+Xgrc9DKulTI5Pn1hLBlkBtbxmL
         3Ti9qtL0pOa3wBSx1C5gOw+8gL6/CMFAcgkLO0xGZMIoxqti3QY+r5jydnKH2nnajF
         1YIKdKd4YUkGg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] kbuild: add phony targets to ./Kbuild
Date:   Sat, 20 Aug 2022 18:15:28 +0900
Message-Id: <20220820091531.682096-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

missing-syscalls and old-atomics are meant to be phony targets.
Adding them to always-y is odd. (always-y should generate something).

Add a new phony target 'prepare', which depends on all the other.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Kbuild   | 26 +++++++++++++-------------
 Makefile |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/Kbuild b/Kbuild
index fa441b98c9f6..e122d93cee32 100644
--- a/Kbuild
+++ b/Kbuild
@@ -2,18 +2,18 @@
 #
 # Kbuild for top-level directory of the kernel
 
-#####
+# Prepare global headers and check sanity before descending into sub-directories
+# ---------------------------------------------------------------------------
+
 # Generate bounds.h
 
 bounds-file := include/generated/bounds.h
 
-always-y := $(bounds-file)
 targets := kernel/bounds.s
 
 $(bounds-file): kernel/bounds.s FORCE
 	$(call filechk,offsets,__LINUX_BOUNDS_H__)
 
-#####
 # Generate timeconst.h
 
 timeconst-file := include/generated/timeconst.h
@@ -23,12 +23,10 @@ filechk_gentimeconst = echo $(CONFIG_HZ) | bc -q $<
 $(timeconst-file): kernel/time/timeconst.bc FORCE
 	$(call filechk,gentimeconst)
 
-#####
 # Generate asm-offsets.h
 
 offsets-file := include/generated/asm-offsets.h
 
-always-y += $(offsets-file)
 targets += arch/$(SRCARCH)/kernel/asm-offsets.s
 
 arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
@@ -36,24 +34,26 @@ arch/$(SRCARCH)/kernel/asm-offsets.s: $(timeconst-file) $(bounds-file)
 $(offsets-file): arch/$(SRCARCH)/kernel/asm-offsets.s FORCE
 	$(call filechk,offsets,__ASM_OFFSETS_H__)
 
-#####
 # Check for missing system calls
 
-always-y += missing-syscalls
-
 quiet_cmd_syscalls = CALL    $<
       cmd_syscalls = $(CONFIG_SHELL) $< $(CC) $(c_flags) $(missing_syscalls_flags)
 
-missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
+PHONY += missing-syscalls
+missing-syscalls: scripts/checksyscalls.sh $(offsets-file)
 	$(call cmd,syscalls)
 
-#####
 # Check atomic headers are up-to-date
 
-always-y += old-atomics
-
 quiet_cmd_atomics = CALL    $<
       cmd_atomics = $(CONFIG_SHELL) $<
 
-old-atomics: scripts/atomic/check-atomics.sh FORCE
+PHONY += old-atomics
+old-atomics: scripts/atomic/check-atomics.sh
 	$(call cmd,atomics)
+
+# A phony target that depends on all the preparation targets
+
+PHONY += prepare
+prepare: $(offsets-file) missing-syscalls old-atomics
+	@:
diff --git a/Makefile b/Makefile
index 697ab397fe31..4fcced0d3907 100644
--- a/Makefile
+++ b/Makefile
@@ -1202,7 +1202,7 @@ archprepare: outputmakefile archheaders archscripts scripts include/config/kerne
 
 prepare0: archprepare
 	$(Q)$(MAKE) $(build)=scripts/mod
-	$(Q)$(MAKE) $(build)=.
+	$(Q)$(MAKE) $(build)=. prepare
 
 # All the preparing..
 prepare: prepare0
-- 
2.34.1

