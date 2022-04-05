Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6D14F4EA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835941AbiDFAeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444179AbiDEPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:58 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28738B8D;
        Tue,  5 Apr 2022 07:03:30 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 235E2k8J021295;
        Tue, 5 Apr 2022 23:02:47 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 235E2k8J021295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649167367;
        bh=3DqNNvADXzvHcLCX0JSWQu0LGeQKS0pcjU6by571POs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LfieR2VmMKTxTNyd2rEQ8kIzgpwQ0gGElm/+R4Gv+yUizsZAMUx7OlekL+Cq87W/w
         oaeFGyDYwcDQqttYW2cDoatDLf+PgAPBsMGOgvbhcLfAnFi0XWqAPcD+JRfi0JXyyf
         BjZimdPTSqSBoscR0piS+f9exDxwYD25UdNtjyImjudR175ZrZRHaFhv9IGjfp3OWE
         kkpnQtRrh69J5UNewWEJ95BZ5LvGCym/qqCpJTFn5rd3SDRbhcKSoFitacvlRV+R5l
         aOqfb4EVoT8vdO2BhH1u9woz+RhCizmkuLuIFpRYz8ox5IFg71M0uMm9/z7vJmZ/+L
         qmQID8zdlEKWQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 01/10] kbuild: factor out genksyms command from cmd_gensymtypes_{c,S}
Date:   Tue,  5 Apr 2022 23:02:20 +0900
Message-Id: <20220405140229.2895394-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405140229.2895394-1-masahiroy@kernel.org>
References: <20220405140229.2895394-1-masahiroy@kernel.org>
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

The genksyms command part in cmd_gensymtypes_{c,S} is duplicated.
Factor it out into the 'genksyms' macro.

For the readability, I slightly refactor the arguments to genksyms.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix the location of the closing parenthesis

 scripts/Makefile.build | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9717e6f6fb31..31e0e33dfe5d 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -125,13 +125,14 @@ cmd_cpp_i_c       = $(CPP) $(c_flags) -o $@ $<
 $(obj)/%.i: $(src)/%.c FORCE
 	$(call if_changed_dep,cpp_i_c)
 
+genksyms = scripts/genksyms/genksyms		\
+	$(if $(1), -T $(2))			\
+	$(if $(CONFIG_MODULE_REL_CRCS), -R)	\
+	$(if $(KBUILD_PRESERVE), -p)		\
+	-r $(or $(wildcard $(2:.symtypes=.symref)), /dev/null)
+
 # These mirror gensymtypes_S and co below, keep them in synch.
-cmd_gensymtypes_c =                                                         \
-    $(CPP) -D__GENKSYMS__ $(c_flags) $< |                                   \
-    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
-     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_c =                                                         \
@@ -344,11 +345,7 @@ cmd_gensymtypes_S =                                                         \
     $(CPP) $(a_flags) $< |                                                  \
      grep "\<___EXPORT_SYMBOL\>" |                                          \
      sed 's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/' ; } | \
-    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
-    scripts/genksyms/genksyms $(if $(1), -T $(2))                           \
-     $(patsubst y,-R,$(CONFIG_MODULE_REL_CRCS))                             \
-     $(if $(KBUILD_PRESERVE),-p)                                            \
-     -r $(firstword $(wildcard $(2:.symtypes=.symref) /dev/null))
+    $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
 cmd_cc_symtypes_S =                                                         \
-- 
2.32.0

