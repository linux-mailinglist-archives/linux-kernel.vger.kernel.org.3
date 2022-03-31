Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C152A4ED635
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbiCaIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiCaIvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:43 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9503BA43
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:53 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 22V8lTVu003697;
        Thu, 31 Mar 2022 17:47:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 22V8lTVu003697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648716450;
        bh=gGJuNtZNlK31EyvN6aKIUPmZ7sjtipQdD25VkZOOOCc=;
        h=From:To:Cc:Subject:Date:From;
        b=rhYAFo8ei45If/CuJ5HR8u2dnVvZ08GiqGLaoczoXz7rFPV3QkIvV97Gh2YSQ7pmw
         uZLlDBkluCfe97IeemZkfBwq0hTp1C+HmS+5XL0dyRbn9C42Cj0h72ZKVdK0P7tbeW
         MWFBqothqXfeFMtBFejY4M+zO5a/Nr/vkFQ/LQSSCJnFl2qcrGeIOrAryV4DDAVQzE
         H78GFsvKTs/pOPFwREjJNQtE77QIeVngD1ZSDH/jRTfyAT1xgJgOuxm969trEA46oG
         TaE3oDFJrNGlQbQsl3i7eCjXPNp3/1QPPfJtkPaZNsx5DyG9FXvs0VxwTgJBeR2cUt
         Gf9rfexlO2VoA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     patches@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        David Heidelberg <david@ixit.cz>,
        Nicolas Schier <n.schier@avm.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ARM: decompressor: fix unneeded rebuilds of library objects
Date:   Thu, 31 Mar 2022 17:47:09 +0900
Message-Id: <20220331084709.1079362-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

Since commit 251cc826be7d ("ARM: 9154/1: decompressor: do not copy source
files while building"), the following three are rebuilt every time.

  AS      arch/arm/boot/compressed/lib1funcs.o
  AS      arch/arm/boot/compressed/ashldi3.o
  AS      arch/arm/boot/compressed/bswapsdi2.o

Move the "OBJS += ..." line up so these objects are added to 'targets'.

Fixes: 251cc826be7d ("ARM: 9154/1: decompressor: do not copy source files while building")
Reported-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

KernelVersion: v5.17

 arch/arm/boot/compressed/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 954eee8a785a..e65c7ad5dd4c 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -97,6 +97,8 @@ endif
 $(foreach o, $(libfdt_objs) atags_to_fdt.o fdt_check_mem_start.o, \
 	$(eval CFLAGS_$(o) := -I $(srctree)/scripts/dtc/libfdt -fno-stack-protector))
 
+OBJS	+= lib1funcs.o ashldi3.o bswapsdi2.o
+
 targets       := vmlinux vmlinux.lds piggy_data piggy.o \
 		 head.o $(OBJS)
 
@@ -130,8 +132,6 @@ endif
 # Next argument is a linker script
 LDFLAGS_vmlinux += -T
 
-OBJS	+= lib1funcs.o ashldi3.o bswapsdi2.o
-
 # We need to prevent any GOTOFF relocs being used with references
 # to symbols in the .bss section since we cannot relocate them
 # independently from the rest at run time.  This can be achieved by
-- 
2.32.0

