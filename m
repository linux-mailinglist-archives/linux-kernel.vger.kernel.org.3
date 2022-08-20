Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1D59ACCE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 11:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbiHTJQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiHTJQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 05:16:13 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9EDB4424;
        Sat, 20 Aug 2022 02:16:10 -0700 (PDT)
Received: from grover.sesame (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 27K9FiMV016772;
        Sat, 20 Aug 2022 18:15:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 27K9FiMV016772
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1660986947;
        bh=ZaA95r2hIvnjr0IyYniszHW9QBF5d9eg0OdtCM353VU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hwNzU0dZ+MDYxxD+j5qH42HEQBdHXs4vAokfVD/bFAS8n0YzRBhQgh15qZDT4aXXR
         b4l3SimfMqUwoHSrQucKvqamk7A1PnB9Bllc3i2z27Msa4RySWnXPIQJKtzugv8OjY
         8OyglTVbtwmmafyDRZ637Wz0oxd7mtuJVWdJ6DrXcnLaACGQq01MVKHgINC6TmKMc2
         DdKtvKXKENxALGCjF/p/HDI9BBeOR5TWsaD050XJqkZvhIGVpOml5jCf0UJqwgSeEu
         pNQ6d+dfKPXq2h8Doz7otwyvF3KhYihhtwm41CDGdslEN8MYpEUU/xBmYWnT9kCZNN
         S6iM+2ARAvUFg==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] nios2: move core-y in arch/nios2/Makefile to arch/nios2/Kbuild
Date:   Sat, 20 Aug 2022 18:15:31 +0900
Message-Id: <20220820091531.682096-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220820091531.682096-1-masahiroy@kernel.org>
References: <20220820091531.682096-1-masahiroy@kernel.org>
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

Use obj-y to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/nios2/Kbuild   | 2 ++
 arch/nios2/Makefile | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/nios2/Kbuild b/arch/nios2/Kbuild
index 4e39f7abdeb6..fc2952edd2de 100644
--- a/arch/nios2/Kbuild
+++ b/arch/nios2/Kbuild
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+obj-y += kernel/ mm/ platform/ boot/dts/
+
 # for cleaning
 subdir- += boot
diff --git a/arch/nios2/Makefile b/arch/nios2/Makefile
index d6a7499b814c..3f34e6831863 100644
--- a/arch/nios2/Makefile
+++ b/arch/nios2/Makefile
@@ -39,8 +39,6 @@ KBUILD_CFLAGS += -G 0
 
 head-y		:= arch/nios2/kernel/head.o
 libs-y		+= arch/nios2/lib/ $(LIBGCC)
-core-y		+= arch/nios2/kernel/ arch/nios2/mm/
-core-y		+= arch/nios2/platform/
 
 INSTALL_PATH ?= /tftpboot
 nios2-boot := arch/$(ARCH)/boot
@@ -48,8 +46,6 @@ BOOT_TARGETS = vmImage zImage
 PHONY += $(BOOT_TARGETS) install
 KBUILD_IMAGE := $(nios2-boot)/vmImage
 
-core-y	+= $(nios2-boot)/dts/
-
 all: vmImage
 
 $(BOOT_TARGETS): vmlinux
-- 
2.34.1

