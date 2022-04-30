Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4184C515C65
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 13:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239495AbiD3LLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiD3LLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 07:11:16 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AFB2183C;
        Sat, 30 Apr 2022 04:07:52 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 23UB4siD001142;
        Sat, 30 Apr 2022 20:04:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 23UB4siD001142
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651316695;
        bh=qFq62hBbENoaVAD7QD5BdAfmy70jfETPcpl34tqTGjQ=;
        h=From:To:Cc:Subject:Date:From;
        b=I7Qf2fOElOZRV86gYmAf4dApBSqjae3RPU5dBtFAMNakp0UAMWsj53+BtUffL/s7K
         fv2rpSJ+kL+TuEfGB90vgdJG7L5vL4+qZs53EDuGOr6QrX8GSCdMgaVPYqn/8/DW9s
         53f3eFcA24PZXc5Obrlluia7RO7W3lO9oYsvdtwx2dALx+DtJBu4XhIbAiVzobW7Wc
         kthogHWmHUd87WiJmnJnMHTka7loeCuauLagwZ3dhNjtIJIkqMLj33mfIBEbw/nP2N
         SZidkAb3XkSTizPaWU3FqEFilx/vQ7FTLTQTq8bwm1M6Q/g7vRVjuFrMK6+Ju4WvyU
         BnOgzQ2eQ4LlA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] kbuild: drop $(objtree)/ prefix support for clean-files
Date:   Sat, 30 Apr 2022 20:04:09 +0900
Message-Id: <20220430110409.256858-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think this hack is a bad idea. arch/powerpc/boot/Makefile is the
only user. Let's stop doing this.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/powerpc/boot/Makefile | 4 ++--
 scripts/Makefile.clean     | 8 +-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 4b4827c475c6..008bf0bff186 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -453,8 +453,8 @@ clean-files += $(image-) $(initrd-) cuImage.* dtbImage.* treeImage.* \
 clean-kernel-base := vmlinux.strip vmlinux.bin
 clean-kernel := $(addsuffix .gz,$(clean-kernel-base))
 clean-kernel += $(addsuffix .xz,$(clean-kernel-base))
-# If not absolute clean-files are relative to $(obj).
-clean-files += $(addprefix $(objtree)/, $(clean-kernel))
+# clean-files are relative to $(obj).
+clean-files += $(addprefix ../../../, $(clean-kernel))
 
 WRAPPER_OBJDIR := /usr/lib/kernel-wrapper
 WRAPPER_DTSDIR := /usr/lib/kernel-wrapper/dts
diff --git a/scripts/Makefile.clean b/scripts/Makefile.clean
index 74cb1c5c3658..878cec648959 100644
--- a/scripts/Makefile.clean
+++ b/scripts/Makefile.clean
@@ -36,13 +36,7 @@ __clean-files	:= \
 
 __clean-files   := $(filter-out $(no-clean-files), $(__clean-files))
 
-# clean-files is given relative to the current directory, unless it
-# starts with $(objtree)/ (which means "./", so do not add "./" unless
-# you want to delete a file from the toplevel object directory).
-
-__clean-files   := $(wildcard                                               \
-		   $(addprefix $(obj)/, $(filter-out $(objtree)/%, $(__clean-files))) \
-		   $(filter $(objtree)/%, $(__clean-files)))
+__clean-files   := $(wildcard $(addprefix $(obj)/, $(__clean-files)))
 
 # ==========================================================================
 
-- 
2.32.0

