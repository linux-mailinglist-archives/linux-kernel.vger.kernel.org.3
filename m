Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA74451F0B8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiEHTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiEHTTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:19:03 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7AC13D35;
        Sun,  8 May 2022 12:11:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSa030019;
        Mon, 9 May 2022 04:09:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSa030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036947;
        bh=DmsBv1fv38LgYT/uFaEQzmELMmHgADfzOYYANxRYdz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d+jmdaodPAH6CmaNeK0RdEg6nzZHEGEzI19JHUF480ZBoKCzpRQ2pOLBlBTlGArTh
         fOVXn36FQYvOErvSSxVeIh2A051mxr0Q22rNZdJ7VKr5Jbsl/QPCJ8aD1xuCvR3B1q
         8q7xdFc11cDI7Gu8EiOTTWVMcC+gyyqUc/5oc/Cw3/Fp4NVXHIjnh2jBunfrCUH5PV
         mx+yQM8GqYz1qWV1vjItQ+FqBwKoeYQ6yNA3AFIDlBoC82gmSPOC4VQijn1YubUDjO
         uyJgBaN+A6GxBNFsqo2tdF+GM+5LyZA9xga4fDTIMvZma9LUozQ0mSDnFXKbfnppXN
         EskpKTwwlS30Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 13/14] kbuild: add cmd_and_savecmd macro
Date:   Mon,  9 May 2022 04:06:30 +0900
Message-Id: <20220508190631.2386038-14-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508190631.2386038-1-masahiroy@kernel.org>
References: <20220508190631.2386038-1-masahiroy@kernel.org>
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

Separate out the command execution part of if_changed, as we did
for if_changed_dep.

This allows us to reuse it in if_changed_rule.

  define rule_foo
          $(call cmd_and_savecmd,foo)
          $(call cmd,bar)
  endef

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
---

Changes in v4:
  - New.
    Resent of my previous submission.
    https://lore.kernel.org/all/20210831074004.3195284-10-masahiroy@kernel.org/

 scripts/Kbuild.include | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/Kbuild.include b/scripts/Kbuild.include
index 455a0a6ce12d..ece44b735061 100644
--- a/scripts/Kbuild.include
+++ b/scripts/Kbuild.include
@@ -142,9 +142,11 @@ check-FORCE = $(if $(filter FORCE, $^),,$(warning FORCE prerequisite is missing)
 if-changed-cond = $(newer-prereqs)$(cmd-check)$(check-FORCE)
 
 # Execute command if command has changed or prerequisite(s) are updated.
-if_changed = $(if $(if-changed-cond),                                        \
+if_changed = $(if $(if-changed-cond),$(cmd_and_savecmd),@:)
+
+cmd_and_savecmd =                                                            \
 	$(cmd);                                                              \
-	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd, @:)
+	printf '%s\n' 'cmd_$@ := $(make-cmd)' > $(dot-target).cmd
 
 # Execute the command and also postprocess generated .d dependencies file.
 if_changed_dep = $(if $(if-changed-cond),$(cmd_and_fixdep),@:)
-- 
2.32.0

