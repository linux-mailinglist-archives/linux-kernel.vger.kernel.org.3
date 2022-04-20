Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C7A508FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 20:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381606AbiDTSvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 14:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381589AbiDTSvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 14:51:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EA542EEC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x191so2442764pgd.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 11:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=UGpQa9Z2U55MjYUDsvGvuFzYMVtZARYuOzPYtbUizPg=;
        b=6rfdm/phCRlmO8Ct/g6arSMLvjyQ+UArCdCgU2d60t/F49+e8zW9hVbe0Hw+/6auz8
         0smG66pG/9D7UcRw9gX9si6y6NvYkgsIezoJskMu1TuSK+aiSONGS9esu5svctCYwycs
         zy/DbrDagPCD6MWiRgjfG/1SHvaO15wkNDoUpyA8uxDBpOIZNjhiiQIbshZmfbNLbAZ6
         K0wOBieQ++3HSV2zjACVh9DwCHCYxumykHQ+9uX1l+MYsJ/d3koVe32FE4ThTDttjd4t
         +cG0lApXd9/8MkrFy5CCYjjb/EMIcrfBtlvGGtw4/ZxtWBEMpGYveainQmNzAiPJLESC
         ZT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=UGpQa9Z2U55MjYUDsvGvuFzYMVtZARYuOzPYtbUizPg=;
        b=ZgzDWpeo+5+BhcltL4bkwNxmYsEeKGt3HRoC995dUgd99h499LPu84yYr4NYJp2J2u
         Kwc9Yv+6MHK88Hgmyx9khb2bHxBWdChqOBzAk1klPwnc+XLcJ/R/ovBjQNTp6Kk7zUz7
         gomttVdiFNSHIiWEk5RVkwuM1zoV5VHSB0ti9ir+VTBvH4/tQRBJqNI6Tn5gpIip7JAF
         uN/1SXHP+QDbmed1QR8sf8liCC/HftkBYg82LALPRgyOrd1O4dMKOqBevlHzFsL0Ur1E
         o9v6dJtwb0xrwRuIfAvZBWX9WILHF2SjfzZNL85+5kzL2YMpn1CodYSU4TTOlXXvqb59
         XWpQ==
X-Gm-Message-State: AOAM530TnOuG9RU4ykTpwt4KizQT5FazXqpLg/0eF5yG/5MbBNLhJUD4
        SQ9xYobowoY2B+OMtDN054q8Zg==
X-Google-Smtp-Source: ABdhPJyQtvhwqEgVVnVRRdlklc0eCKG6jyhiAA/OuM6Vae1V/BWG9miXV/9kwjPjjDrjfrYbblnoIw==
X-Received: by 2002:a63:e452:0:b0:3a9:fd43:fd10 with SMTP id i18-20020a63e452000000b003a9fd43fd10mr14420896pgk.541.1650480494575;
        Wed, 20 Apr 2022 11:48:14 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id n20-20020a634d54000000b0039d18bf7864sm20229604pgl.20.2022.04.20.11.48.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 11:48:14 -0700 (PDT)
Subject: [PATCH v2 3/4] RISC-V: Split out the XIP fixups into their own file
Date:   Wed, 20 Apr 2022 11:40:55 -0700
Message-Id: <20220420184056.7886-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220420184056.7886-1-palmer@rivosinc.com>
References: <20220420184056.7886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, vincent.chen@sifive.com, guoren@kernel.org,
        Atish Patra <atishp@rivosinc.com>,
        alexandre.ghiti@canonical.com, jszhang@kernel.org,
        vitaly.wool@konsulko.com, gatecat@ds0.me,
        wangkefeng.wang@huawei.com, mick@ics.forth.gr,
        panqinglin2020@iscas.ac.cn, rppt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org, rdunlap@infradead.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This was broken by the original refactoring (as the XIP definitions
depend on <asm/pgtable.h>) and then more broken by the merge (as I
accidentally took the old version).  This fixes both breakages, while
also pulling this out of <asm/asm.h> to avoid polluting most assembly
files with the XIP fixups.

Fixes: bee7fbc38579 ("RISC-V CPU Idle Support")
Fixes: 63b13e64a829 ("RISC-V: Add arch functions for non-retentive suspend entry/exit")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/asm.h       | 26 ------------------------
 arch/riscv/include/asm/xip_fixup.h | 32 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/head.S           |  1 +
 arch/riscv/kernel/suspend_entry.S  |  1 +
 4 files changed, 34 insertions(+), 26 deletions(-)
 create mode 100644 arch/riscv/include/asm/xip_fixup.h

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index 8c2549b16ac0..618d7c5af1a2 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -67,30 +67,4 @@
 #error "Unexpected __SIZEOF_SHORT__"
 #endif
 
-#ifdef __ASSEMBLY__
-
-/* Common assembly source macros */
-
-#ifdef CONFIG_XIP_KERNEL
-.macro XIP_FIXUP_OFFSET reg
-	REG_L t0, _xip_fixup
-	add \reg, \reg, t0
-.endm
-.macro XIP_FIXUP_FLASH_OFFSET reg
-	la t1, __data_loc
-	REG_L t1, _xip_phys_offset
-	sub \reg, \reg, t1
-	add \reg, \reg, t0
-.endm
-_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
-_xip_phys_offset: .dword CONFIG_XIP_PHYS_ADDR + XIP_OFFSET
-#else
-.macro XIP_FIXUP_OFFSET reg
-.endm
-.macro XIP_FIXUP_FLASH_OFFSET reg
-.endm
-#endif /* CONFIG_XIP_KERNEL */
-
-#endif /* __ASSEMBLY__ */
-
 #endif /* _ASM_RISCV_ASM_H */
diff --git a/arch/riscv/include/asm/xip_fixup.h b/arch/riscv/include/asm/xip_fixup.h
new file mode 100644
index 000000000000..0d0754305324
--- /dev/null
+++ b/arch/riscv/include/asm/xip_fixup.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * XIP fixup macros, only useful in assembly.
+ */
+#ifndef _ASM_RISCV_XIP_FIXUP_H
+#define _ASM_RISCV_XIP_FIXUP_H
+
+#include <linux/pgtable.h>
+
+#ifdef CONFIG_XIP_KERNEL
+.macro XIP_FIXUP_OFFSET reg
+        REG_L t0, _xip_fixup
+        add \reg, \reg, t0
+.endm
+.macro XIP_FIXUP_FLASH_OFFSET reg
+        la t1, __data_loc
+        li t0, XIP_OFFSET_MASK
+        and t1, t1, t0
+        li t1, XIP_OFFSET
+        sub t0, t0, t1
+        sub \reg, \reg, t0
+.endm
+
+_xip_fixup: .dword CONFIG_PHYS_RAM_BASE - CONFIG_XIP_PHYS_ADDR - XIP_OFFSET
+#else
+.macro XIP_FIXUP_OFFSET reg
+.endm
+.macro XIP_FIXUP_FLASH_OFFSET reg
+.endm
+#endif /* CONFIG_XIP_KERNEL */
+
+#endif
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 893b8bb69391..822c33aa7f45 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -14,6 +14,7 @@
 #include <asm/hwcap.h>
 #include <asm/image.h>
+#include <asm/xip_fixup.h>
 #include "efi-header.S"
 
 __HEAD
diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
index 4b07b809a2b8..aafcca58c19d 100644
--- a/arch/riscv/kernel/suspend_entry.S
+++ b/arch/riscv/kernel/suspend_entry.S
@@ -8,6 +8,7 @@
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
 #include <asm/csr.h>
+#include <asm/xip_fixup.h>
 
 	.text
 	.altmacro
-- 
2.34.1

