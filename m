Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9045A7654
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiHaGOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHaGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:14:16 -0400
Received: from mail-m11877.qiye.163.com (mail-m11877.qiye.163.com [115.236.118.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C59BCC17
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 23:14:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:36a:1401:7900:28fe:18b4:1216:17dd])
        by mail-m11877.qiye.163.com (Hmail) with ESMTPA id 508564007A5;
        Wed, 31 Aug 2022 14:14:12 +0800 (CST)
From:   Yupeng Li <liyupeng@zbhlos.com>
To:     chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        caizp2008@163.com, Yupeng Li <liyupeng@zbhlos.com>
Subject: [PATCH 1/1] LoongArch: Fixed loongarch kernel csr_xxx implicit declaration.
Date:   Wed, 31 Aug 2022 14:14:06 +0800
Message-Id: <20220831061406.431027-1-liyupeng@zbhlos.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDTB4eVk1IGB8YTx0dHkMZGFUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSE0aQUpPS0pBTEJLS0FJQx0eQUpDGU9BSklKTUFKTB8fWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6STo*Fz0#Tk41OE09GjQ*
        CjUwC0pVSlVKTU1KQklNT05JQ0pOVTMWGhIXVRcSAg4LHhUcOwEZExcUCFUYFBZFWVdZEgtZQVlJ
        T0seQUhNGkFKT0tKQUxCS0tBSUMdHkFKQxlPQUpJSk1BSkwfH1lXWQgBWUFNSklDNwY+
X-HM-Tid: 0a82f2892cf02eb3kusn508564007a5
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Loongarch CSR register operation related interface, use the
interface defined  __builtin_loongarch_xxx instead.
Build kernel error messages like:

  CALL    scripts/atomic/check-atomics.sh
  CC      arch/loongarch/kernel/asm-offsets.s
In file included from ./arch/loongarch/include/asm/cpu-info.h:11,
                 from ./arch/loongarch/include/asm/processor.h:13,
                 from ./arch/loongarch/include/asm/thread_info.h:15,
                 from ./include/linux/thread_info.h:60,
                 from ./include/asm-generic/current.h:5,
                 from ./arch/loongarch/include/generated/asm/current.h:1,
                 from ./include/linux/sched.h:12,
                 from arch/loongarch/kernel/asm-offsets.c:8:
./arch/loongarch/include/asm/loongarch.h: In function 'csr_read32':
./arch/loongarch/include/asm/loongarch.h:232:9: error: implicit declaration of function '__csrrd_w'; did you mean '__iocsrrd_w'? [-Werror=implicit-function-declaration]
  return __csrrd_w(reg);
         ^~~~~~~~~
         __iocsrrd_w
./arch/loongarch/include/asm/loongarch.h: In function 'csr_read64':
./arch/loongarch/include/asm/loongarch.h:237:9: error: implicit declaration of function '__csrrd_d'; did you mean '__iocsrrd_d'? [-Werror=implicit-function-declaration]
  return __csrrd_d(reg);
         ^~~~~~~~~
         __iocsrrd_d
./arch/loongarch/include/asm/loongarch.h: In function 'csr_write32':
./arch/loongarch/include/asm/loongarch.h:242:2: error: implicit declaration of function '__csrwr_w'; did you mean '__iocsrwr_w'? [-Werror=implicit-function-declaration]
  __csrwr_w(val, reg);
  ^~~~~~~~~
  __iocsrwr_w
./arch/loongarch/include/asm/loongarch.h: In function 'csr_write64':
./arch/loongarch/include/asm/loongarch.h:247:2: error: implicit declaration of function '__csrwr_d'; did you mean '__iocsrwr_d'? [-Werror=implicit-function-declaration]
  __csrwr_d(val, reg);
  ^~~~~~~~~
  __iocsrwr_d
./arch/loongarch/include/asm/loongarch.h: In function 'csr_xchg32':
./arch/loongarch/include/asm/loongarch.h:252:9: error: implicit declaration of function '__csrxchg_w'; did you mean '__cmpxchg'? [-Werror=implicit-function-declaration]
  return __csrxchg_w(val, mask, reg);
         ^~~~~~~~~~~
         __cmpxchg
./arch/loongarch/include/asm/loongarch.h: In function 'csr_xchg64':
./arch/loongarch/include/asm/loongarch.h:257:9: error: implicit declaration of function '__csrxchg_d'; did you mean '__cmpxchg'? [-Werror=implicit-function-declaration]
  return __csrxchg_d(val, mask, reg);
         ^~~~~~~~~~~
         __cmpxchg
cc1: all warnings being treated as errors
make[1]: *** [scripts/Makefile.build:117：arch/loongarch/kernel/asm-offsets.s] 错误 1
make: *** [Makefile:1205：prepare0] 错误 2

Signed-off-by: Yupeng Li <liyupeng@zbhlos.com>
Signed-off-by: Caicai <caizp2008@163.com>
---
 arch/loongarch/include/asm/loongarch.h | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 3ba4f7e87cd2..576ec266d9fc 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 
 #ifndef __ASSEMBLY__
-#include <larchintrin.h>
 
 /*
  * parse_r var, r - Helper assembler macro for parsing register names.
@@ -58,7 +57,7 @@ __asm__(".macro	parse_r var r\n\t"
 /* CPUCFG */
 static inline u32 read_cpucfg(u32 reg)
 {
-	return __cpucfg(reg);
+	return __builtin_loongarch_cpucfg(reg);
 }
 
 #endif /* !__ASSEMBLY__ */
@@ -229,53 +228,53 @@ static inline u32 read_cpucfg(u32 reg)
 /* CSR */
 static __always_inline u32 csr_read32(u32 reg)
 {
-	return __csrrd_w(reg);
+	return __builtin_loongarch_csrrd(reg);
 }
 
 static __always_inline u64 csr_read64(u32 reg)
 {
-	return __csrrd_d(reg);
+	return __builtin_loongarch_csrrd(reg);
 }
 
 static __always_inline void csr_write32(u32 val, u32 reg)
 {
-	__csrwr_w(val, reg);
+	__builtin_loongarch_csrwr(val, reg);
 }
 
 static __always_inline void csr_write64(u64 val, u32 reg)
 {
-	__csrwr_d(val, reg);
+	__builtin_loongarch_csrwr(val, reg);
 }
 
 static __always_inline u32 csr_xchg32(u32 val, u32 mask, u32 reg)
 {
-	return __csrxchg_w(val, mask, reg);
+	return __builtin_loongarch_csrxchg(val, mask, reg);
 }
 
 static __always_inline u64 csr_xchg64(u64 val, u64 mask, u32 reg)
 {
-	return __csrxchg_d(val, mask, reg);
+	return __builtin_loongarch_csrxchg(val, mask, reg);
 }
 
 /* IOCSR */
 static __always_inline u32 iocsr_read32(u32 reg)
 {
-	return __iocsrrd_w(reg);
+	return __builtin_loongarch_iocsrrd_w(reg);
 }
 
 static __always_inline u64 iocsr_read64(u32 reg)
 {
-	return __iocsrrd_d(reg);
+	return __builtin_loongarch_iocsrrd_d(reg);
 }
 
 static __always_inline void iocsr_write32(u32 val, u32 reg)
 {
-	__iocsrwr_w(val, reg);
+	__builtin_loongarch_iocsrwr_w(val, reg);
 }
 
 static __always_inline void iocsr_write64(u64 val, u32 reg)
 {
-	__iocsrwr_d(val, reg);
+	__builtin_loongarch_iocsrwr_d(val, reg);
 }
 
 #endif /* !__ASSEMBLY__ */
-- 
2.34.1

