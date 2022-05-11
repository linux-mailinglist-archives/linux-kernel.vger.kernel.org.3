Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFED4523AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345212AbiEKQvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345101AbiEKQuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:50:37 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB56980B0;
        Wed, 11 May 2022 09:50:04 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24BGlWc7031975;
        Thu, 12 May 2022 01:47:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24BGlWc7031975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652287665;
        bh=lwhcZwty1WSqzMwcqIa4FpY71JgLgetW2nQZRkklH+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vbl4SEiYvvF37f1IoBEjasxAsVDVSQV8iEM8Mi1h0FEwr6nbrD3P3UYOZTcXB+dwW
         P4z9VJ4VCWJvC1cJ1pmve8jsN9WLx+eVX79Xl6TrT24LXAougV9Awt53/UrOSkZd43
         X5EErlnVqv3GL29CA/j+CRK/e3buKnMpnmqT6knIllg7DKJ7KcmM/wga5P7pkHiye6
         7Ntd8KWojBuvIyoY6awGSQNZfD7l35B6l5NF8xgdOhRDKMrTfKY1D5UlWG6fqVCJ0C
         yVqCAChqiTv/BoII/V6PNLSr8f0DT6kA6jxx/hAq260ykEre9DLp5hGZYDAkUG3GK/
         a6HnJhQ6XrVqA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v5 12/12] kbuild: rebuild multi-object modules when objtool is updated
Date:   Thu, 12 May 2022 01:45:14 +0900
Message-Id: <20220511164514.2741934-13-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511164514.2741934-1-masahiroy@kernel.org>
References: <20220511164514.2741934-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT is enabled, objtool for
multi-object modules is postponed until the objects are linked together.

Make sure to re-run objtool and re-link multi-object modules when
objtool is updated.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---

(no changes since v4)

Changes in v4:
  - New
    Resent of my previous submission
    https://lore.kernel.org/linux-kbuild/20210831074004.3195284-11-masahiroy@kernel.org/

 scripts/Makefile.build | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index f546b5f1f33f..4e6902e099e8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -404,13 +404,18 @@ $(obj)/modules.order: $(obj-m) FORCE
 $(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)
 
-quiet_cmd_link_multi-m = LD [M]  $@
-      cmd_link_multi-m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
+quiet_cmd_ld_multi_m = LD [M]  $@
+      cmd_ld_multi_m = $(LD) $(ld_flags) -r -o $@ @$(patsubst %.o,%.mod,$@) $(cmd_objtool)
+
+define rule_ld_multi_m
+	$(call cmd_and_savecmd,ld_multi_m)
+	$(call cmd,gen_objtooldep)
+endef
 
 $(multi-obj-m): objtool-enabled := $(delay-objtool)
 $(multi-obj-m): part-of-module := y
 $(multi-obj-m): %.o: %.mod FORCE
-	$(call if_changed,link_multi-m)
+	$(call if_changed_rule,ld_multi_m)
 $(call multi_depend, $(multi-obj-m), .o, -objs -y -m)
 
 targets := $(filter-out $(PHONY), $(targets))
-- 
2.32.0

