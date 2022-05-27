Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C4535DCB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350769AbiE0KEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350767AbiE0KEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:04:35 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C981116D2;
        Fri, 27 May 2022 03:04:32 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24RA2hPR029808;
        Fri, 27 May 2022 19:02:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24RA2hPR029808
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653645765;
        bh=qwd23UnZbO+5y7U7znABEi6dbpFFNIV0E++LnxqEYTU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mBTnB1DbKOnCmX5Ya77nr4wiY61xCAd2gDVGZleMKQiezhhRhnn5kcWqlcmPRVA68
         UfK15SyTlR56+ygHUSR1HFmo5wuekHdC+np4qWSLtNaCqiwqeu+6qNM1GMGSII4a1y
         NI6ntzouNqgU8FYUcdnaZVDpeWLoUuIx5StuCA/S65ebk2424eIKQhY+iphgwiR/rG
         LDJyNveUt1Yg2z2YSQ+Ud66mKIjX+UpnItrhq9abbiz+3jY2dYxqeqBaInsuUv1Clq
         WM7nRpQAXN+6s5hbIQxRd1+8l26aYDPi3LTrXIqJFttc0dKni0YR/6G2WKOyCb/JHA
         F1CMKUgoAlaTA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, llvm@lists.linux.dev,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v7 1/8] kbuild: replace $(linked-object) with CONFIG options
Date:   Fri, 27 May 2022 19:01:48 +0900
Message-Id: <20220527100155.1996314-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220527100155.1996314-1-masahiroy@kernel.org>
References: <20220527100155.1996314-1-masahiroy@kernel.org>
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

*.prelink.o is created when CONFIG_LTO_CLANG or CONFIG_X86_KERNEL_IBT
is enabled.

Replace $(linked-object) with $(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)
so you will get better idea when the --link option is passed.

No functional change is intended.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v7:
  - New patch

 scripts/Makefile.build | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 06400504150b..f80196eef03a 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -219,7 +219,7 @@ objtool_args =								\
 	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
 	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
 	--uaccess							\
-	$(if $(linked-object), --link)					\
+	$(if $($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT)), --link)	\
 	$(if $(part-of-module), --module)				\
 	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
 
@@ -284,7 +284,6 @@ quiet_cmd_cc_prelink_modules = LD [M]  $@
 # modules into native code
 $(obj)/%.prelink.o: objtool-enabled = y
 $(obj)/%.prelink.o: part-of-module := y
-$(obj)/%.prelink.o: linked-object := y
 
 $(obj)/%.prelink.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_prelink_modules)
-- 
2.32.0

