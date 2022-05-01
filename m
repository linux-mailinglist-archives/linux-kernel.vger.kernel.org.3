Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30CA51631D
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343569AbiEAIsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343587AbiEAIpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:54 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC794CD59;
        Sun,  1 May 2022 01:42:26 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2SB008518;
        Sun, 1 May 2022 17:41:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2SB008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394478;
        bh=MLLAKdOtjjfRPFMO1T3BrNLDbeU3kj6UXqQmksZq2zA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hIJAmqJQVYBkdsTKchRWt6W9+m4EhVcJr2r7KwvdFmhivdNWhndcp14Ye4eqwRPx8
         /UMHhWj24pK1Yz76GxtvGIZrs7SrKlFUeEW1wNLnUpkA8rxGNiiuKn72/ZkUKhxHRC
         Lp9wR+wg8FNN+KKqDwHjZ4WGrEIXlZpK1uXOLrZUNf0E01IWSQ8al/n11xk//deo7u
         VW7K2UNn/XLx8PFT3UJlC+RodArQRX8aZDxkKFiHZ6Ad29kDf2DhFU9X3H+hAtbYoA
         I+SdTw8uclTxVNrrOUjo5OFbm32xdjs+bG0buB5hCvS/jtwDkGAifB73P86uahecDz
         WbUqRyP53hSYw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 24/26] kbuild: make *.mod rule robust against too long argument error
Date:   Sun,  1 May 2022 17:40:30 +0900
Message-Id: <20220501084032.1025918-25-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
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
---

Changes in v2:
  - New patch

 scripts/Makefile.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a9236add4864..b0718076f50b 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -266,8 +266,8 @@ $(obj)/%.o: $(src)/%.c $(recordmcount_source) FORCE
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

