Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBEE536D9C
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 17:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiE1PtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243709AbiE1PtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 11:49:13 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C11810F7;
        Sat, 28 May 2022 08:49:10 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 24SFlthL010610;
        Sun, 29 May 2022 00:47:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24SFlthL010610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653752876;
        bh=sY+0OvghuGoZfnBgpSdsHHR8GT+qhyXyhPgsj+2Iu+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pACWBNyp8WivPFoW2V7X2NO8O0fAYlVmGo3BqoPyEvX66GOA0Y9c0TOmSGrGTxgGG
         TKC98U99Et1DsqISudw2uGsTGWJbkBXxshihc+R0/p3Cnvw7gKiNzFbXc/CffTNK1z
         JBLqeE9sZPK6zKz3raykU8PCOHwO8rwfLuWPL6GNyvGIy5HL+jOnlW/IwvqWa82Wsb
         tGNVjo72q1siyURgBThmlHbggUQzwzdKC/ejIuSJc6km4+fNMC87VoJ0zox1SGDz06
         /7x4TijxGHaMLkoLQF1O3qPDohmCKHLWKEap4fLAi+ELRIynUP4XXNCk70u3g9sbLx
         0oJ1rL9EyoD1A==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 2/4] kbuild: clean .tmp_* pattern by make clean
Date:   Sun, 29 May 2022 00:47:02 +0900
Message-Id: <20220528154704.2576290-2-masahiroy@kernel.org>
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

Change the "make clean" rule to remove all the .tmp_* files.

.tmp_objdiff is the only exception, which should be removed by
"make mrproper".

Rename the record directory of objdiff, .tmp_objdiff to .objdiff to
avoid the removal by "make clean".

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                | 4 ++--
 scripts/link-vmlinux.sh | 3 ---
 scripts/objdiff         | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/Makefile b/Makefile
index edc3f44cd96c..7011d43dff35 100644
--- a/Makefile
+++ b/Makefile
@@ -1490,7 +1490,7 @@ CLEAN_FILES += include/ksym vmlinux.symvers modules-only.symvers \
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES += include/config include/generated          \
-		  arch/$(SRCARCH)/include/generated .tmp_objdiff \
+		  arch/$(SRCARCH)/include/generated .objdiff \
 		  debian snap tar-install \
 		  .config .config.old .version \
 		  Module.symvers \
@@ -1857,7 +1857,7 @@ clean: $(clean-dirs)
 		-o -name '*.lex.c' -o -name '*.tab.[ch]' \
 		-o -name '*.asn1.[ch]' \
 		-o -name '*.symtypes' -o -name 'modules.order' \
-		-o -name '.tmp_*.o.*' \
+		-o -name '.tmp_*' \
 		-o -name '*.c.[012]*.*' \
 		-o -name '*.ll' \
 		-o -name '*.gcno' \
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 844fc0125d72..b593cb1a8137 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -303,9 +303,6 @@ sorttable()
 cleanup()
 {
 	rm -f .btf.*
-	rm -f .tmp_System.map
-	rm -f .tmp_initcalls.lds
-	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
 	rm -f vmlinux.map
diff --git a/scripts/objdiff b/scripts/objdiff
index 72b0b63c3fe1..68b8d74e5c6f 100755
--- a/scripts/objdiff
+++ b/scripts/objdiff
@@ -32,7 +32,7 @@ if [ -z "$SRCTREE" ]; then
 	exit 1
 fi
 
-TMPD=$SRCTREE/.tmp_objdiff
+TMPD=$SRCTREE/.objdiff
 
 usage() {
 	echo >&2 "Usage: $0 <command> <args>"
-- 
2.32.0

