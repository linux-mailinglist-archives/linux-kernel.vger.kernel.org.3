Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C008536D9D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350026AbiE1PtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344394AbiE1PtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:49:14 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2766268;
        Sat, 28 May 2022 08:49:11 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 24SFlthM010610;
        Sun, 29 May 2022 00:47:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24SFlthM010610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653752877;
        bh=r13GrFRYMDrikoVJbL6k/JBbfLtkbPflsQEkRN/RT58=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZKNhujl9v0SS6NCq/L67fCkLmiUYCJTty0C/O6EN+GwAxqQjcLhmHdspH9gDo1G2
         t4y4/e0iMa6yNkCZYjADyQmsAw9Ej9DA5FS55qPHXLjX0/zdexpqKtcXvr9LgSXkC8
         T3a4QQr+xWytTol/fPxGFA7NDZuEd2e3YKlre65nEzeSlQL5XtY9q4wBy6vRBp5T8c
         2aKBsqAQFq+HLqBT9g+F7shx4f2AUibVNXfI6fXu9o0wTCEI7hcP0zWMzv+LgvKpoR
         gRiJiOalBbJK9OOV3rSVxG2zA4cCnsOhMshsU4GyNtA58/Tp88YrNyChOVYsznr08g
         XOk8mGe53aAdQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev
Subject: [PATCH 3/4] kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o
Date:   Sun, 29 May 2022 00:47:03 +0900
Message-Id: <20220528154704.2576290-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220528154704.2576290-1-masahiroy@kernel.org>
References: <20220528154704.2576290-1-masahiroy@kernel.org>
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

This is a preparation for the objtool move in the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.vmlinux_o | 61 ++++++++++++++++++++++++++++++++++++++
 scripts/link-vmlinux.sh    | 41 +------------------------
 2 files changed, 62 insertions(+), 40 deletions(-)
 create mode 100644 scripts/Makefile.vmlinux_o

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
new file mode 100644
index 000000000000..a9b375ca86d5
--- /dev/null
+++ b/scripts/Makefile.vmlinux_o
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+PHONY := __default
+__default: vmlinux.o
+
+include include/config/auto.conf
+include $(srctree)/scripts/Kbuild.include
+
+# Generate a linker script to ensure correct ordering of initcalls for Clang LTO
+# ---------------------------------------------------------------------------
+
+quiet_cmd_gen_initcalls_lds = GEN     $@
+      cmd_gen_initcalls_lds = \
+	$(PYTHON3) $(srctree)/scripts/jobserver-exec \
+	$(PERL) $(real-prereqs) > $@
+
+.tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
+		$(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+	$(call if_changed,gen_initcalls_lds)
+
+targets := .tmp_initcalls.lds
+
+ifdef CONFIG_LTO_CLANG
+initcalls-lds := .tmp_initcalls.lds
+endif
+
+# Link of vmlinux.o used for section mismatch analysis
+# ---------------------------------------------------------------------------
+
+quiet_cmd_ld_vmlinux.o = LD      $@
+      cmd_ld_vmlinux.o = \
+	$(LD) ${KBUILD_LDFLAGS} -r -o $@ \
+	$(addprefix -T , $(initcalls-lds)) \
+	--whole-archive $(KBUILD_VMLINUX_OBJS) --no-whole-archive \
+	--start-group $(KBUILD_VMLINUX_LIBS) --end-group \
+
+define rule_ld_vmlinux.o
+	$(call cmd_and_savecmd,ld_vmlinux.o)
+endef
+
+vmlinux.o: $(initcalls-lds) $(KBUILD_VMLINUX_OBJS) $(KBUILD_VMLINUX_LIBS) FORCE
+	$(call if_changed_rule,ld_vmlinux.o)
+
+targets += vmlinux.o
+
+# Add FORCE to the prequisites of a target to force it to be always rebuilt.
+# ---------------------------------------------------------------------------
+
+PHONY += FORCE
+FORCE:
+
+# Read all saved command lines and dependencies for the $(targets) we
+# may be building above, using $(if_changed{,_dep}). As an
+# optimization, we don't need to read them if the target does not
+# exist, we will rebuild anyway in that case.
+
+existing-targets := $(wildcard $(sort $(targets)))
+
+-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
+
+.PHONY: $(PHONY)
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index b593cb1a8137..90680b6bd710 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -45,45 +45,6 @@ info()
 	printf "  %-7s %s\n" "${1}" "${2}"
 }
 
-# Generate a linker script to ensure correct ordering of initcalls.
-gen_initcalls()
-{
-	info GEN .tmp_initcalls.lds
-
-	${PYTHON3} ${srctree}/scripts/jobserver-exec		\
-	${PERL} ${srctree}/scripts/generate_initcall_order.pl	\
-		${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}	\
-		> .tmp_initcalls.lds
-}
-
-# Link of vmlinux.o used for section mismatch analysis
-# ${1} output file
-modpost_link()
-{
-	local objects
-	local lds=""
-
-	objects="--whole-archive				\
-		${KBUILD_VMLINUX_OBJS}				\
-		--no-whole-archive				\
-		--start-group					\
-		${KBUILD_VMLINUX_LIBS}				\
-		--end-group"
-
-	if is_enabled CONFIG_LTO_CLANG; then
-		gen_initcalls
-		lds="-T .tmp_initcalls.lds"
-
-		# This might take a while, so indicate that we're doing
-		# an LTO link
-		info LTO ${1}
-	else
-		info LD ${1}
-	fi
-
-	${LD} ${KBUILD_LDFLAGS} -r -o ${1} ${lds} ${objects}
-}
-
 objtool_link()
 {
 	local objtoolcmd;
@@ -336,7 +297,7 @@ fi;
 ${MAKE} -f "${srctree}/scripts/Makefile.build" obj=init need-builtin=1
 
 #link vmlinux.o
-modpost_link vmlinux.o
+${MAKE} -f "${srctree}/scripts/Makefile.vmlinux_o"
 objtool_link vmlinux.o
 
 # Generate the list of objects in vmlinux
-- 
2.32.0

