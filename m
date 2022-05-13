Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E84526141
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380079AbiEMLnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345668AbiEMLnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:43:17 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B3DF68BC;
        Fri, 13 May 2022 04:42:42 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24DBeEwi008349;
        Fri, 13 May 2022 20:40:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24DBeEwi008349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652442024;
        bh=tWubGKl01wW+DNljh3UjfGXWoQ6mtZdfdLtoxs2fSmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KbXwfWVjakJu02uXsXnx36SE59nU4vsPwBw/CfSyj5v6M6t4/Avd9B2x0smijLCSx
         84p7T8j5EDL1A32qvR5whd8+tM+uwi51xgKXoiNknaj1cBr4UTe20kKDqcvKNKtfME
         MLvJL+kquJpKTvaZ5n9XEZ7EIcebLJtol8doAnt4gWg90Q8a3Pwua4/AXSFzv4B2eC
         O/okFmfD/nPHQdfI/bYqR/TAMoMwkAPeM6XWPZp1oznKpH3JJ0X2KufoD4QRDR2eve
         1ugmGWoj29n2dhL8UFsDvfj0SXRfxhTU7XedZtQR92eVpNm4agtvLFTE45qetVL/XX
         1iCu2QxxAwhZg==
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
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v6 09/10] kbuild: add cmd_and_savecmd macro
Date:   Fri, 13 May 2022 20:39:29 +0900
Message-Id: <20220513113930.10488-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513113930.10488-1-masahiroy@kernel.org>
References: <20220513113930.10488-1-masahiroy@kernel.org>
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
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v4)

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

