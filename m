Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E1B5003B6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 03:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiDNBmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 21:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiDNBmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 21:42:46 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189E20F70
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:40:23 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id t4so3458460pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=RdayCDxEwJD59KqBdusCEOpxaJASjBt83sSueeG1AHo=;
        b=ycMC/7bYjbOcLcEX2Tt8VKIilnYKeWYE2bx96R/lFO0m6rchL4vLEVtbx4DIHM3ORk
         UBDoEhJBvmkZ1TigC5xaY+u+GfFf+KjYS1ZNKjjfcj2SGDdkH3LMRQjQpTd2QexjnxFN
         tiicpxYwhRWaqtFUTgMbq7IG+Gtk4bo5ggk+L2LbhgUNmU4gFkofLgn07fI7ltWhQZm2
         CHPxSxMUyO+Z6yE8Nyhyq5/jerzahPX/ibsw4W/GWHCi8BeZg/ET8xiatEvsvv8GYWb/
         xDTA5AkCl+Rba/02rycJF0AWURAb834y4CuWXOSXPZLrej6FrILXK5HxFb6eMIm4CcF0
         WcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=RdayCDxEwJD59KqBdusCEOpxaJASjBt83sSueeG1AHo=;
        b=Yv/N7geduT5nXPIe0G7TUQZcsNdta+FiFggX8OvEJDrSnXOoJS4ewAxM/zrGvwoCVT
         xG+TzFbKFSFO8IyRaXzds6XU8yXO/3Oe2zgtHi6USDJSDTkJlUySFObh2qD5nCR+VOhs
         gPQCb5ZU55YAr4Kl5C4IzX7gZnantyam5oRB4CLCUAmUbOXhvAfOiNmZKl5onRX1+kiH
         2aeZX1xTsHOjW6zWEIXyggD5aP6Yru1SBpRR3dqi2Bhc542EIWd7ACLxwk9yXJFKVbxY
         9hJGhgYam6+g0032tZUkH9zli7jrxQ6ObuwwFb109t5qZTGX9zNls2z4buVMqvPt19u5
         kvWQ==
X-Gm-Message-State: AOAM5308dkI11PQN/wQPXpZ0Kq4xThYgP+41eyjxuNiTcy0jS4Ai5mWm
        cohCJ//Ef+SG4AhGaN7fHS0QkQ==
X-Google-Smtp-Source: ABdhPJwSA5lCtRjpiMXmwO58f+FjMqudVsOkIGa/B9oWV7MmYVdot6tpFhxuZ3a6QrC+ya7+j4hS+g==
X-Received: by 2002:a63:e442:0:b0:398:c06b:169c with SMTP id i2-20020a63e442000000b00398c06b169cmr380503pgk.170.1649900423449;
        Wed, 13 Apr 2022 18:40:23 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id w14-20020a17090a4f4e00b001cb510021ecsm4203901pjl.49.2022.04.13.18.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 18:40:23 -0700 (PDT)
Subject: [PATCH v2] RISC-V: Add CONFIG_{NON,}PORTABLE
Date:   Wed, 13 Apr 2022 18:40:10 -0700
Message-Id: <20220414014010.28110-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

The RISC-V port has collected a handful of options that are
fundamentally non-portable.  To prevent users from shooting themselves
in the foot, hide them all behind a config entry that explicitly calls
out that non-portable binaries may be produced.

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

---

Changes since v1:

* Fix a bunch of spelling mistakes.
* Move NONPORTABLE under the "Platform type" sub-heading.
* Fix the rv32i dependency.
---
 arch/riscv/Kconfig | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5adcbd9b5e88..3d8eb44eb889 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -213,6 +213,21 @@ source "arch/riscv/Kconfig.erratas"
 
 menu "Platform type"
 
+config NONPORTABLE
+	bool "Allow configurations that result in non-portable kernels"
+	help
+	  RISC-V kernel binaries are compatible between all known systems
+	  whenever possible, but there are some use cases that can only be
+	  satisfied by configurations that result in kernel binaries that are
+	  not portable between systems.
+
+	  Selecting N does not guarantee kernels will be portable to all knows
+	  systems.  Selecting any of the options guarded by NONPORTABLE will
+	  result in kernel binaries that are unlikely to be portable between
+	  systems.
+
+	  If unsure, say N.
+
 choice
 	prompt "Base ISA"
 	default ARCH_RV64I
@@ -222,6 +237,7 @@ choice
 
 config ARCH_RV32I
 	bool "RV32I"
+	depends on NONPORTABLE
 	select 32BIT
 	select GENERIC_LIB_ASHLDI3
 	select GENERIC_LIB_ASHRDI3
@@ -485,6 +501,7 @@ config STACKPROTECTOR_PER_TASK
 
 config PHYS_RAM_BASE_FIXED
 	bool "Explicitly specified physical RAM address"
+	depends on NONPORTABLE
 	default n
 
 config PHYS_RAM_BASE
@@ -498,7 +515,7 @@ config PHYS_RAM_BASE
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on MMU && SPARSEMEM
+	depends on MMU && SPARSEMEM && NONPORTABLE
 	# This prevents XIP from being enabled by all{yes,mod}config, which
 	# fail to build since XIP doesn't support large kernels.
 	depends on !COMPILE_TEST
@@ -538,9 +555,16 @@ endmenu
 
 config BUILTIN_DTB
 	bool
-	depends on OF
+	depends on OF && NONPORTABLE
 	default y if XIP_KERNEL
 
+config PORTABLE
+	bool
+	default !NONPORTABLE
+	select EFI
+	select OF
+	select MMU
+
 menu "Power management options"
 
 source "kernel/power/Kconfig"
-- 
2.34.1

