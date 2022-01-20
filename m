Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13DD6494896
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiATHlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:41:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34432 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbiATHkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:40:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F96BB81C98;
        Thu, 20 Jan 2022 07:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E038C340E5;
        Thu, 20 Jan 2022 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642664438;
        bh=JvV8ftLviV/FzucVodc6NceqG1Q54GKFTkZVB+ZZOng=;
        h=From:To:Cc:Subject:Date:From;
        b=oZkrDgoHiSlrda3Oh5+Yn5//iKhASuY7MlM0BATDdI56OQiAzKsLpR9Ppa3Nrd3/K
         h6+XoX4NpJyZNSZJFbcHjmbJ3VJBK75Tuz10YixY2SOFS2Zveo7ek5neLIN8ct7jP4
         ISX7cLKdz8jQgz2S7mwY5mwvPBup46IAaadSF/d62YXsr4lTqqHlvD53lc4UJuTZ0L
         60/z84Uz9JZ3cs27mKtHg75yrCWwkU/Jzeplhodd0J/eT4e1ozl2ktvYqn+6OMdoui
         SGKDBgQTkXBxeydBDJpB8PdKDKBycok3BETz6QmqfhPO+cgG67JhuM/hGx/cZ6RMBP
         ASQ9V82k3AGVA==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 09/17] riscv: compat: syscall: Add entry.S implementation
Date:   Thu, 20 Jan 2022 15:39:02 +0800
Message-Id: <20220120073911.99857-10-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement the entry of compat_sys_call_table[] in asm. Ref to
riscv-privileged spec 4.1.1 Supervisor Status Register (sstatus):

 BIT[32:33] = UXL[1:0]:
 - 1:32
 - 2:64
 - 3:128

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/csr.h |  7 +++++++
 arch/riscv/kernel/entry.S    | 18 ++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 5046f431645c..7dac12366833 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -36,6 +36,13 @@
 #define SR_SD		_AC(0x8000000000000000, UL) /* FS/XS dirty */
 #endif
 
+#ifdef CONFIG_COMPAT
+#define SR_UXL		_AC(0x300000000, UL) /* XLEN mask for U-mode */
+#define SR_UXL_32	_AC(0x100000000, UL) /* XLEN = 32 for U-mode */
+#define SR_UXL_64	_AC(0x200000000, UL) /* XLEN = 64 for U-mode */
+#define SR_UXL_SHIFT	32
+#endif
+
 /* SATP flags */
 #ifndef CONFIG_64BIT
 #define SATP_PPN	_AC(0x003FFFFF, UL)
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ed29e9c8f660..1951743f09b3 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -207,13 +207,27 @@ check_syscall_nr:
 	 * Syscall number held in a7.
 	 * If syscall number is above allowed value, redirect to ni_syscall.
 	 */
-	bgeu a7, t0, 1f
+	bgeu a7, t0, 3f
+#ifdef CONFIG_COMPAT
+	REG_L s0, PT_STATUS(sp)
+	srli s0, s0, SR_UXL_SHIFT
+	andi s0, s0, (SR_UXL >> SR_UXL_SHIFT)
+	li t0, (SR_UXL_32 >> SR_UXL_SHIFT)
+	sub t0, s0, t0
+	bnez t0, 1f
+
+	/* Call compat_syscall */
+	la s0, compat_sys_call_table
+	j 2f
+1:
+#endif
 	/* Call syscall */
 	la s0, sys_call_table
+2:
 	slli t0, a7, RISCV_LGPTR
 	add s0, s0, t0
 	REG_L s0, 0(s0)
-1:
+3:
 	jalr s0
 
 ret_from_syscall:
-- 
2.25.1

