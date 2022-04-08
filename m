Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A9414F9119
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiDHIsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiDHIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:48:29 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1F31C0A0;
        Fri,  8 Apr 2022 01:46:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e35:39f2:1220:bf15:70c6:368e:e3ba])
        by smtp1-g21.free.fr (Postfix) with ESMTPS id E9B6FB004B6;
        Fri,  8 Apr 2022 10:46:17 +0200 (CEST)
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yann Droneaud <ydroneaud@opteya.com>
Subject: [PATCHv1] kbuild: support W=e to make build abort in case of warning
Date:   Fri,  8 Apr 2022 10:46:07 +0200
Message-Id: <20220408084607.106468-1-ydroneaud@opteya.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
References: <1422803720-14723-1-git-send-email-ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When developing new code/feature, CONFIG_WERROR is most
often turned off, especially for people using make W=12 to
get more warnings.

In such case, turning on -Werror temporarily would require
switching on CONFIG_WERROR in the configuration, building,
then switching off CONFIG_WERROR.

For this use case, this patch introduces a new 'e' modifier
to W= as a short hand for KCFLAGS+=-Werror" so that -Werror
got added to the kernel (built-in) and modules' CFLAGS.

Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 Makefile                   |  1 +
 scripts/Makefile.extrawarn | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

Changes since v0[0]:

 - rebase on top of commit 64a91907c896 ("kbuild: refactor scripts/Makefile.extrawarn")
 - document use case after commit 3fe617ccafd6 ("Enable '-Werror' by default for all kernel builds")

[0] https://lore.kernel.org/all/1422803720-14723-1-git-send-email-ydroneaud@opteya.com/

diff --git a/Makefile b/Makefile
index 8c7de9a72ea2..6dc621af18d1 100644
--- a/Makefile
+++ b/Makefile
@@ -1649,6 +1649,7 @@ help:
 	@echo  '		1: warnings which may be relevant and do not occur too often'
 	@echo  '		2: warnings which occur quite often but may still be relevant'
 	@echo  '		3: more obscure warnings, can most likely be ignored'
+	@echo  '		e: warnings are being treated as errors'
 	@echo  '		Multiple levels can be combined with W=12 or W=123'
 	@echo  ''
 	@echo  'Execute "make" or "make all" to build all targets marked with [*] '
diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 650d0b8ceec3..f5f0d6f09053 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -2,8 +2,8 @@
 # ==========================================================================
 # make W=... settings
 #
-# There are three warning groups enabled by W=1, W=2, W=3.
-# They are independent, and can be combined like W=12 or W=123.
+# There are four warning groups enabled by W=1, W=2, W=3, and W=e
+# They are independent, and can be combined like W=12 or W=123e.
 # ==========================================================================
 
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
@@ -94,3 +94,12 @@ KBUILD_CFLAGS += $(call cc-option, -Wpacked-bitfield-compat)
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN3
 
 endif
+
+#
+# W=e - error out on warnings
+#
+ifneq ($(findstring e, $(KBUILD_EXTRA_WARN)),)
+
+KBUILD_CFLAGS += -Werror
+
+endif
-- 
2.32.0

