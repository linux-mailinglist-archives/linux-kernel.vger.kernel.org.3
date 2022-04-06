Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6A4F6776
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239210AbiDFRaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiDFR3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:29:12 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E0D39BDA4;
        Wed,  6 Apr 2022 08:31:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 236FUcaV017647;
        Thu, 7 Apr 2022 00:30:43 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 236FUcaV017647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649259043;
        bh=MSswAqHKy8lumNzIx8NJz222QuH49EevUg0//UJ/VHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2WiwkMWqu8zQm5jY/anENgoCn2uKrKOwBEQxbI2qActQkkO6n8qv0Rf35ACThYE/7
         yqJJrUkO7Cq8uYtm7Bd8QRR1BVyfa62yX6P2jXBrrhpWaVIgsqYwsp82y41cfxcGGX
         Nry7828J+weffsZX0HJk8vccKnbWSnjFQp3TfjKN187yDN2Ol0wqU1sui+MHZpyyLb
         AsUUbOS/thK45e0zdp4Tu04wZxQwJg5JgzEpZowJ1Kz6qM5l2uXuwQ0+0h7QLZNSna
         g0CGBpLQJ/wWgfsk0HRe/ta3rrTz5MM9MFQcj4mWTbOUpDobe+F4NbyuZkW89bav5o
         +YfKXy7qchqvA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 6/7] kbuild: make *.mod not depend on *.o
Date:   Thu,  7 Apr 2022 00:30:22 +0900
Message-Id: <20220406153023.500847-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220406153023.500847-1-masahiroy@kernel.org>
References: <20220406153023.500847-1-masahiroy@kernel.org>
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

The dependency

    $(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o

... exists because *.mod files previously contained undefined symbols,
which are computed from *.o files when CONFIG_TRIM_UNUSED_KSYMS=y.

Now that the undefined symbols are put into separate *.usyms files,
there is no reason to make *.mod depend on *.o files.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 3 ++-
 scripts/Makefile.build | 5 ++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 82ee893909e9..e915aacd02b0 100644
--- a/Makefile
+++ b/Makefile
@@ -1792,7 +1792,8 @@ ifdef single-build
 
 # .ko is special because modpost is needed
 single-ko := $(sort $(filter %.ko, $(MAKECMDGOALS)))
-single-no-ko := $(sort $(patsubst %.ko,%.mod, $(MAKECMDGOALS)))
+single-no-ko := $(filter-out $(single-ko), $(MAKECMDGOALS)) \
+		$(foreach x, o mod, $(patsubst %.ko, %.$x, $(single-ko)))
 
 $(single-ko): single_modpost
 	@:
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f7a30f378e20..3da731cf6978 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -85,7 +85,7 @@ ifdef need-builtin
 targets-for-builtin += $(obj)/built-in.a
 endif
 
-targets-for-modules := $(foreach x, mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
+targets-for-modules := $(foreach x, o mod $(if $(CONFIG_TRIM_UNUSED_KSYMS), usyms), \
 				$(patsubst %.o, %.$x, $(filter %.o, $(obj-m))))
 
 ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
@@ -306,7 +306,7 @@ endif
 cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
 	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
 
-$(obj)/%.mod: $(obj)/%$(mod-prelink-ext).o FORCE
+$(obj)/%.mod: FORCE
 	$(call if_changed,mod)
 
 # List module undefined symbols
@@ -469,7 +469,6 @@ $(multi-obj-m): FORCE
 	$(call if_changed,link_multi-m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
-targets += $(multi-obj-m)
 targets := $(filter-out $(PHONY), $(targets))
 
 # Add intermediate targets:
-- 
2.32.0

