Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE65AF47D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiIFTf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiIFTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:35:52 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C82889CE7;
        Tue,  6 Sep 2022 12:35:50 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 286JYjqX018889;
        Wed, 7 Sep 2022 04:34:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 286JYjqX018889
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662492886;
        bh=buj24yq3s8ReDMkxdHKGvu3Cnge/yLfAR/qMi/tJe6c=;
        h=From:To:Cc:Subject:Date:From;
        b=s7zaK5N+ehEANgy1X+xjmV3aDseitIuEh7EmzeRvVRHMf1xV4RGdUdGHjWJpOoFuT
         9K9K3qNnd8XOFHqtaodT5NKWc01pkDu/jViDERsJvjRFLwbFONucrPpWwcN1qZ1fWX
         vD/T+GFxqTEU0sfAHgDIvXpZhYvdHPg+zyK/9vMaCevwyuUI1p70oHjh1NuiyKCLhW
         Y3CZyiDaPDxNiws6PFD39eQZ0rp7QrCHjiNoUxl/QyLEwL1UImROW02mqwMSk9CePG
         WWbAogDNangs3ENTzyFl1lW195/MuN0Uqmn5Wi/S3ZJfK2MKENVW52bTwi6lPQSzlV
         k4IEjknoprwGw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] kbuild: use modpost-args-y to clean up modpost arguments
Date:   Wed,  7 Sep 2022 04:34:35 +0900
Message-Id: <20220906193436.2135744-1-masahiroy@kernel.org>
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

Separate the modpost executable (scripts/mod/modpost) and the command
parameters for the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                 |  2 +-
 scripts/Makefile.modpost | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Makefile b/Makefile
index aee4f0769d9d..e07236209606 100644
--- a/Makefile
+++ b/Makefile
@@ -1908,7 +1908,7 @@ tags TAGS cscope gtags: FORCE
 # ---------------------------------------------------------------------------
 
 PHONY += nsdeps
-nsdeps: export KBUILD_NSDEPS=1
+nsdeps: export KBUILD_NSDEPS=y
 nsdeps: modules
 	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/nsdeps
 
diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index ceb1d78140e7..87821a5fe16b 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -38,17 +38,17 @@ __modpost:
 include include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
 
-MODPOST = scripts/mod/modpost								\
-	$(if $(CONFIG_MODVERSIONS),-m)							\
-	$(if $(CONFIG_MODULE_SRCVERSION_ALL),-a)					\
-	$(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)					\
-	$(if $(KBUILD_NSDEPS),-d $(MODULES_NSDEPS))					\
-	$(if $(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)$(KBUILD_NSDEPS),-N)	\
-	-o $@
+MODPOST = scripts/mod/modpost
+
+modpost-args-$(CONFIG_MODVERSIONS)				+= -m
+modpost-args-$(CONFIG_MODULE_SRCVERSION_ALL)			+= -a
+modpost-args-$(CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS)	+= -N
+modpost-args-$(KBUILD_NSDEPS)					+= -N -d $(MODULES_NSDEPS)
+modpost-args-y += $(if $(CONFIG_SECTION_MISMATCH_WARN_ONLY),,-E)
 
 # 'make -i -k' ignores compile errors, and builds as many modules as possible.
 ifneq ($(findstring i,$(filter-out --%,$(MAKEFLAGS))),)
-MODPOST += -n
+modpost-args-y += -n
 endif
 
 ifeq ($(KBUILD_EXTMOD),)
@@ -99,12 +99,12 @@ module.symvers-if-present := $(wildcard Module.symvers)
 output-symdump := $(KBUILD_EXTMOD)/Module.symvers
 missing-input := $(filter-out $(module.symvers-if-present), Module.symvers)
 
-MODPOST += -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EXTRA_SYMBOLS))
+modpost-args-y += -e $(addprefix -i ,$(module.symvers-if-present) $(KBUILD_EXTRA_SYMBOLS))
 
 endif # ($(KBUILD_EXTMOD),)
 
 ifneq ($(KBUILD_MODPOST_WARN)$(missing-input),)
-MODPOST += -w
+modpost-args-y += -w
 endif
 
 modorder-if-needed := $(if $(KBUILD_MODULES), $(MODORDER))
@@ -117,7 +117,7 @@ quiet_cmd_modpost = MODPOST $@
 		echo >&2 "WARNING: $(missing-input) is missing."; \
 		echo >&2 "         Modules may not have dependencies or modversions."; \
 		echo >&2 "         You may get many unresolved symbol warnings.";) \
-	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(vmlinux.o-if-present) -T -
+	sed 's/ko$$/o/' $(or $(modorder-if-needed), /dev/null) | $(MODPOST) $(modpost-args-y) $(vmlinux.o-if-present) -T - -o $@
 
 targets += $(output-symdump)
 $(output-symdump): $(modorder-if-needed) $(vmlinux.o-if-present) $(moudle.symvers-if-present) FORCE
-- 
2.34.1

