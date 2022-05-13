Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CB252613D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380059AbiEMLn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379963AbiEMLnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:43:11 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CDFD8081;
        Fri, 13 May 2022 04:42:32 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24DBeEwh008349;
        Fri, 13 May 2022 20:40:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24DBeEwh008349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652442023;
        bh=OcOEuS6jEbLubdZRYm9mI6nzM08ugGxo0tuefY4hIgE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bp9jvRuF56C6r43GNXjG6BX+TvZHLTbdTLlR34dCXZg/oW32238SNreYsd6ecrnG6
         PWr/NUZR0Fj64xkX3yxzCkcDwm8BUtpOQer8MUJE0kfUxAXrmqhHXhUVBDO1eaFvmZ
         Zd2DgWMNXGj/fTUiZ/fP4rrMZ0P/EShz6FzQ0fejjM7Fk5Mk+4x3zIAjw7LvNr3l8P
         6RqksiC0umDQhSOQrTIO45Q7vzc3cdAd1y7uI/ao5m/kB6w/+AoM6bRZyfIpfL/JKy
         BLmQpIaa0h1Ej7NhYPC3vBgHWU9i3BlD07Dxm/NP3Kvu3JsIm6e+nmrjotY7EuCyv8
         GgKFtSPjQ+KrA==
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
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v6 08/10] kbuild: make *.mod rule robust against too long argument error
Date:   Fri, 13 May 2022 20:39:28 +0900
Message-Id: <20220513113930.10488-9-masahiroy@kernel.org>
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

Like built-in.a, the command length of the *.mod rule scales with
the depth of the directory times the number of objects in the Makefile.

Add $(obj)/ by the shell command (awk) instead of by Make's builtin
function.

In-tree modules still have some room to the limit (ARG_MAX=2097152),
but this is more future-proof for big modules in a deep directory.

For example, you can build i915 as a module (CONFIG_DRM_I915=m) and
compare drivers/gpu/drm/i915/.i915.mod.cmd with/without this commit.

The issue is more critical for external modules because the M= path
can be very long as Jeff Johnson reported before [1].

[1] https://lore.kernel.org/linux-kbuild/4c02050c4e95e4cb8cc04282695f8404@codeaurora.org/

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 8f1a355df7aa..f546b5f1f33f 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -270,8 +270,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
 	$(call if_changed_rule,cc_o_c)
 	$(call cmd,force_checksrc)
 
-cmd_mod = echo $(addprefix $(obj)/, $(call real-search, $*.o, .o, -objs -y -m)) | \
-	$(AWK) -v RS='( |\n)' '!x[$$0]++' > $@
+cmd_mod = echo $(call real-search, $*.o, .o, -objs -y -m) | \
+	$(AWK) -v RS='( |\n)' '!x[$$0]++ { print("$(obj)/"$$0) }' > $@
 
 $(obj)/%.mod: FORCE
 	$(call if_changed,mod)
-- 
2.32.0

