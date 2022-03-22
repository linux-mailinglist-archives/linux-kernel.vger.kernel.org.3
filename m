Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007CC4E4543
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 18:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239761AbiCVRkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 13:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiCVRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 13:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19555B3ED
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 10:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D39861559
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED99C340EC;
        Tue, 22 Mar 2022 17:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647970745;
        bh=DjiS32vPPzgMI5rZD9Y+sAxvdb/r9L8MYhIr+oCkLbY=;
        h=From:To:Cc:Subject:Date:From;
        b=PuOe6xXlR8M/pSW0JOJW/vpBNEMzZJsv5u93nq9rsn92kFQrafwTgu2K07GlyhCpL
         LNbGvT+LYU6IRHu+ucWvAKQQQ99o6ZzA+Bo6rl/Lva65oRy+CRCwODtr2+MgcszJqZ
         sL/U+4tFbFSyTsy1YsANuLE5x0aEBCev5kExZ5X+QxTqo38IpSmlZxyTkRqSN1Qxh/
         c56s6IU8/V9bpHHkSxcqqfToRB8Q+GoPnKISIBhJJAetw5MbNyQFY8M6RjTiJvk/yN
         cHuoPhVUPhESTckSAJt+K30DnNTmKOu6g/L4IkA02KRjzR5bPr+T78FWZRu+7Xb+ui
         bHEqWBuZmsz7Q==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        David Gow <davidgow@google.com>, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] um: Fix filtering '-mno-global-merge'
Date:   Tue, 22 Mar 2022 10:35:47 -0700
Message-Id: <20220322173547.677760-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting a clang compiled UML kernel, the kernel panics when trying
to run init:

  wait_stub_done : failed to wait for SIGTRAP, pid = 651294, n = 651294, errno = 0, status = 0xb7f
  Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

After the commit in Fixes, many flags from KBUILD_CFLAGS do not appear
in USER_CFLAGS, likely due to USER_CFLAGS initially being a recursive
variable ("VAR =") then being switched to a simple ("VAR :=") variable.
For example, diffing arch/x86/um/.ptrace_user.o.cmd shows flags such as
'-Os' and '-fno-delete-null-pointer-checks' getting dropped, which both
impact code generation.

Rework the filtering to use filter-out instead of patsubst, which allows
all the patterns that USER_CFLAGS cares about to be excluded in one
command and ensures all flags from KBUILD_CFLAGS are transferred over to
USER_CFLAGS properly, which resolves the boot issue noted above.

Fixes: 6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/um/Makefile | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 320b09cd513c..d202f501e9e1 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -70,15 +70,11 @@ KBUILD_CFLAGS += $(CFLAGS) $(CFLAGS-y) -D__arch_um__ \
 
 KBUILD_AFLAGS += $(ARCH_INCLUDE)
 
-USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
+USER_CFLAGS = $(filter-out $(KERNEL_DEFINES) -I% -mno-global-merge,$(KBUILD_CFLAGS)) \
 		$(ARCH_INCLUDE) $(MODE_INCLUDE) $(filter -I%,$(CFLAGS)) \
 		-D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
 		-idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
 
-ifdef CONFIG_CC_IS_CLANG
-USER_CFLAGS := $(patsubst -mno-global-merge,,$(USER_CFLAGS))
-endif
-
 #This will adjust *FLAGS accordingly to the platform.
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 

base-commit: 82017457957a550d7d00dde419435dd74a890887
-- 
2.35.1

