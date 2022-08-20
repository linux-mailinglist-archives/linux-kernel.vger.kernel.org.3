Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DB559ACCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbiHTJQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245610AbiHTJQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:16:49 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF25B4430;
        Sat, 20 Aug 2022 02:16:48 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 27K9FiMU016772;
        Sat, 20 Aug 2022 18:15:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 27K9FiMU016772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660986946;
        bh=bY6+EI9V1BMBb57Vn4oX7gK4xNrUCHyq24HIGSTCGek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CfKRT02jM1vvZF0H7fL3OK90qa8+tmBKGbEnIwt9g5XoJt4zxoW87gXNAKrQaTRY+
         wzCV3LZhV++TyfOtu8ibR/Y7bPbIc4Ly0AMBGGO5SEgpax6oYXI/a5/EyMNU+QSG+H
         Nq52xJMbyyLeEv8XA55BfIDVVqJcOlKwm29qsUbbjWmMi2mx/dxc5dzL/uljXbVHSg
         Uil4qRGNpceXcirabcCSnwwTMrdqfYYru8Wm8mywpYt3dXG0kwLWeZkdwEyxsUliVy
         VQhREVF+ZtCaAXGg6qdDEPqcieggiKAYlvyIaedvmq5Va7G5EdcEI1Waqu2M5fzmDo
         UkAXadP1HHTlA==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: do not deduplicate modules.order
Date:   Sat, 20 Aug 2022 18:15:30 +0900
Message-Id: <20220820091531.682096-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820091531.682096-1-masahiroy@kernel.org>
References: <20220820091531.682096-1-masahiroy@kernel.org>
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

The AWK code was added to deduplicate modules.order in case $(obj-m)
contains the same module multiple times, but it is actually unneeded
since commit b2c885549122 ("kbuild: update modules.order only when
contained modules are updated").

The list is already deduplicated before being processed by AWK because
$^ is the deduplicated list of prerequisites.
(Please note the real-prereqs macro uses $^)

Yet, modules.order will contain duplication if two different Makefiles
build the same module:

  foo/Makefile:

      obj-m += bar/baz.o

  foo/bar/Makefile:

      obj-m += baz.o

However, the parallel builds cannot properly handle this case in the
first place. So, it is better to let it fail (as already done by
scripts/modules-check.sh).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 5 +----
 scripts/Makefile.build | 2 +-
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/Makefile b/Makefile
index d8ca0738b9e1..8add796953ad 100644
--- a/Makefile
+++ b/Makefile
@@ -1435,14 +1435,11 @@ endif
 
 # Build modules
 #
-# A module can be listed more than once in obj-m resulting in
-# duplicate lines in modules.order files.  Those are removed
-# using awk while concatenating to the final file.
 
 PHONY += modules
 modules: $(if $(KBUILD_BUILTIN),vmlinux) modules_check modules_prepare
 
-cmd_modules_order = $(AWK) '!x[$$0]++' $(real-prereqs) > $@
+cmd_modules_order = cat $(real-prereqs) > $@
 
 modules.order: $(subdir-modorder) FORCE
 	$(call if_changed,modules_order)
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 784f46d41959..0df488d0bbb0 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -374,7 +374,7 @@ $(obj)/built-in.a: $(real-obj-y) FORCE
 
 cmd_modules_order = { $(foreach m, $(real-prereqs), \
 	$(if $(filter %/modules.order, $m), cat $m, echo $(patsubst %.o,%.ko,$m));) :; } \
-	| $(AWK) '!x[$$0]++' - > $@
+	> $@
 
 $(obj)/modules.order: $(obj-m) FORCE
 	$(call if_changed,modules_order)
-- 
2.34.1

