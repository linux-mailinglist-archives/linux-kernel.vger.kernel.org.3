Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BCD57F50A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 14:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiGXM0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 08:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiGXM0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 08:26:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D550B18373;
        Sun, 24 Jul 2022 05:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5B3A8B80D6B;
        Sun, 24 Jul 2022 12:26:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF3DC3411E;
        Sun, 24 Jul 2022 12:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658665572;
        bh=5kIVqhKqws1LvJ274twbut419msCbSFVG3i62G1GMz4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n+GR3DtPlKwtsAoVzA2Q7OjeRqVeLSVehFABpXXHhcVotD2OBTjh6NhwVXdUqrIyU
         M2N4XM0LbMd/4nHTdg5JoPqImNW3BVGMu5k/U2GHxRuJy5wH3cK1PUshpMfZW3d7r4
         oN8meBfVrqOPDRsysggmM6tyVqj1NwsNV7PzrpqVPT5rEPDGL1wmnoW+ZQlb7KkJds
         RZGbF9HPQ4O6Sjfk5qUDukB0a+YJX1QIQiMaTsG3zSXhzhYAtILlaZCHTiBaZjugWP
         sc7zjhwGpaiFOm8TxVZOo+VC5gGyBqiQq84UWQgorWyOKseM4LGiP+1LO1kM0BBmri
         mIWh7r2HIHXXg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, mingo@redhat.com,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        linux-kernel@vger.kernel.org, David.Laight@ACULAB.COM
Cc:     linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V8 07/10] riscv: Add qspinlock support
Date:   Sun, 24 Jul 2022 08:25:14 -0400
Message-Id: <20220724122517.1019187-8-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220724122517.1019187-1-guoren@kernel.org>
References: <20220724122517.1019187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock by the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

 - RISC-V atomic_*_release()/atomic_*_acquire() are implemented with
   own relaxed version plus acquire/release_fence for RCsc
   synchronization.

 - RISC-V LR/SC pairs could provide a strong/weak forward guarantee
   that depends on micro-architecture. And RISC-V ISA spec has given
   out several limitations to let hardware support strict forward
   guarantee (RISC-V User ISA - 8.3 Eventual Success of
   Store-Conditional Instructions). Some riscv cores such as BOOMv3
   & XiangShan could provide strict & strong forward guarantee (The
   cache line would be kept in an exclusive state for Backoff cycles,
   and only this core's interrupt could break the LR/SC pair).

 - RISC-V provides cheap atomic_fetch_or_acquire() with RCsc.

 - RISC-V only provides relaxed xchg16 to support qspinlock.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig               | 16 ++++++++++++++++
 arch/riscv/include/asm/Kbuild    |  2 ++
 arch/riscv/include/asm/cmpxchg.h | 17 +++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index bff04916a6c5..721f098228a8 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -359,6 +359,22 @@ config NODES_SHIFT
 	  Specify the maximum number of NUMA Nodes available on the target
 	  system.  Increases memory reserved to accommodate various tables.
 
+choice
+	prompt "RISC-V spinlock type"
+	default RISCV_TICKET_SPINLOCKS
+
+config RISCV_TICKET_SPINLOCKS
+	bool "Using ticket spinlock"
+
+config RISCV_QUEUED_SPINLOCKS
+	bool "Using queued spinlock"
+	depends on SMP && MMU
+	select ARCH_USE_QUEUED_SPINLOCKS
+	help
+	  Make sure your micro arch LL/SC has a strong forward progress guarantee.
+	  Otherwise, stay at ticket-lock/combo-lock.
+endchoice
+
 config RISCV_ALTERNATIVE
 	bool
 	depends on !XIP_KERNEL
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 504f8b7e72d4..2cce98c7b653 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -2,7 +2,9 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += mcs_spinlock.h
 generic-y += parport.h
+generic-y += qspinlock.h
 generic-y += spinlock.h
 generic-y += spinlock_types.h
 generic-y += qrwlock.h
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 67ab6375b650..6bf2726d4500 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -17,6 +17,23 @@
 	__typeof__(new) __new = (new);					\
 	__typeof__(*(ptr)) __ret;					\
 	switch (size) {							\
+	case 2: { 							\
+		u32 tmp, ret;						\
+		u32 shif = ((ulong)__ptr & 2) ? 16 : 0;			\
+		u32 mask = 0xffff << shif;				\
+		__ptr = (__typeof__(ptr))((ulong)__ptr & ~2);		\
+		__asm__ __volatile__ (					\
+			"0:	lr.w %0, %2\n"				\
+			"	and  %1, %0, %z3\n"			\
+			"	or   %1, %1, %z4\n"			\
+			"	sc.w %1, %1, %2\n"			\
+			"	bnez %1, 0b\n"				\
+			: "=&r" (ret), "=&r" (tmp), "+A" (*__ptr)	\
+			: "rJ" (~mask), "rJ" ((u32)__new << shif)	\
+			: "memory");					\
+		__ret = (__typeof__(*(ptr)))((ret & mask) >> shif);	\
+		break;							\
+	}								\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"	amoswap.w %0, %2, %1\n"			\
-- 
2.36.1

