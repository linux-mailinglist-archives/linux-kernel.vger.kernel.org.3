Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D847C3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239866AbhLUQgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239868AbhLUQgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:36:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FEAC061746;
        Tue, 21 Dec 2021 08:36:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E6988B816D8;
        Tue, 21 Dec 2021 16:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBC9C36AE9;
        Tue, 21 Dec 2021 16:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104570;
        bh=pyNDRrLm8h1op2D/CnDPZ+t7MIQaxafy6aTK+h3aaoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BXFzUjg0CKVpXzn/vqjFhfWcIKxxKh5+2lJH05zapwEnp3pKszZuliqDGV5DGu/+k
         o/NWNQZmRh+kLW0qYhoecVjD1QZUch/9ltyKjmkY4mtef6TxnjIkUPsMYv1l/bExfZ
         yO6pA1aDjJov5LHVef6Ab4zk20H8BcpThqysCNzuPMd5LG9gxIyP0we+dNRFE7DcKQ
         fHxBjmiOCmzxUvpDnZBVKPUD9zaX3B4/9mBS9A4ti4k9GEYJ3aiyMdL56p8awVcdMq
         8Q4ayAgOMGHT5cB00WHezk6wHQ1R0ZK8txkLtINMIjmNO0mQOcdfMtdXIYkfHttiRa
         MvlX1pR32ewnQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 06/13] riscv: compat: syscall: Add entry.S implementation
Date:   Wed, 22 Dec 2021 00:35:25 +0800
Message-Id: <20211221163532.2636028-7-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
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

