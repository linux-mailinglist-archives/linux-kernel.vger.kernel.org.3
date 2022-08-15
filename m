Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017AC59280F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiHODVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiHODU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:20:59 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CFA1B2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:20:57 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4M5fdn68zNzGpKP;
        Mon, 15 Aug 2022 11:19:25 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:55 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:54 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v2 2/2] riscv: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support
Date:   Mon, 15 Aug 2022 03:20:25 +0000
Message-ID: <20220815032025.2685516-3-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815032025.2685516-1-tongtiangen@huawei.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, The extable type EX_TYPE_UACCESS_ERR_ZERO is used by
__get/put_kernel_nofault(), but those helpers are not uaccess type, so we
add a new extable type EX_TYPE_KACCESS_ERR_ZERO which can be used by
__get/put_kernel_no_fault().

Only refactor code without any functional changes.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/include/asm/asm-extable.h |  12 ++
 arch/riscv/include/asm/uaccess.h     | 160 +++++++++++++--------------
 arch/riscv/mm/extable.c              |   1 +
 3 files changed, 93 insertions(+), 80 deletions(-)

diff --git a/arch/riscv/include/asm/asm-extable.h b/arch/riscv/include/asm/asm-extable.h
index 14be0673f5b5..73c70098a9c8 100644
--- a/arch/riscv/include/asm/asm-extable.h
+++ b/arch/riscv/include/asm/asm-extable.h
@@ -6,6 +6,7 @@
 #define EX_TYPE_FIXUP			1
 #define EX_TYPE_BPF			2
 #define EX_TYPE_UACCESS_ERR_ZERO	3
+#define EX_TYPE_KACCESS_ERR_ZERO	4
 
 #ifdef __ASSEMBLY__
 
@@ -57,9 +58,20 @@
 			    EX_DATA_REG(ZERO, zero)			\
 			  ")")
 
+#define _ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, zero)		\
+	__DEFINE_ASM_GPR_NUMS						\
+	__ASM_EXTABLE_RAW(#insn, #fixup,				\
+			  __stringify(EX_TYPE_KACCESS_ERR_ZERO),	\
+			  "("						\
+			    EX_DATA_REG(ERR, err) " | "			\
+			    EX_DATA_REG(ZERO, zero)			\
+			  ")")
+
 #define _ASM_EXTABLE_UACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_UACCESS_ERR_ZERO(insn, fixup, err, zero)
 
+#define _ASM_EXTABLE_KACCESS_ERR(insn, fixup, err)			\
+	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, zero)
 #endif /* __ASSEMBLY__ */
 
 #endif /* __ASM_ASM_EXTABLE_H */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 1370da055b44..a79af147636e 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -50,62 +50,62 @@
  * call.
  */
 
-#define __get_mem_asm(insn, x, ptr, err)			\
-do {								\
-	__typeof__(x) __x;					\
-	__asm__ __volatile__ (					\
-		"1:\n"						\
-		"	" insn " %1, %2\n"			\
-		"2:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 2b, %0, %1)	\
-		: "+r" (err), "=&r" (__x)			\
-		: "m" (*(ptr)));				\
-	(x) = __x;						\
+#define __get_mem_asm(insn, x, ptr, err, type)				\
+do {									\
+	__typeof__(x) __x;						\
+	__asm__ __volatile__ (						\
+		"1:\n"							\
+		"	" insn " %1, %2\n"				\
+		"2:\n"							\
+		_ASM_EXTABLE_##type##ACCESS_ERR_ZERO(1b, 2b, %0, %1)	\
+		: "+r" (err), "=&r" (__x)				\
+		: "m" (*(ptr)));					\
+	(x) = __x;							\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define __get_mem_8(x, ptr, err) \
-	__get_mem_asm("ld", x, ptr, err)
+#define __get_mem_8(x, ptr, err, type) \
+	__get_mem_asm("ld", x, ptr, err, type)
 #else /* !CONFIG_64BIT */
-#define __get_mem_8(x, ptr, err)				\
-do {								\
-	u32 *__ptr = (u32 *)(ptr);				\
-	u32 __lo, __hi;						\
-	__asm__ __volatile__ (					\
-		"1:\n"						\
-		"	lw %1, %3\n"				\
-		"2:\n"						\
-		"	lw %2, %4\n"				\
-		"3:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR_ZERO(1b, 3b, %0, %1)	\
-		_ASM_EXTABLE_UACCESS_ERR_ZERO(2b, 3b, %0, %1)	\
-		: "+r" (err), "=&r" (__lo), "=r" (__hi)		\
-		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]));	\
-	if (err)						\
-		__hi = 0;					\
-	(x) = (__typeof__(x))((__typeof__((x)-(x)))(		\
-		(((u64)__hi << 32) | __lo)));			\
+#define __get_mem_8(x, ptr, err, type)					\
+do {									\
+	u32 *__ptr = (u32 *)(ptr);					\
+	u32 __lo, __hi;							\
+	__asm__ __volatile__ (						\
+		"1:\n"							\
+		"	lw %1, %3\n"					\
+		"2:\n"							\
+		"	lw %2, %4\n"					\
+		"3:\n"							\
+		_ASM_EXTABLE_##type##ACCESS_ERR_ZERO(1b, 3b, %0, %1)	\
+		_ASM_EXTABLE_##type##ACCESS_ERR_ZERO(2b, 3b, %0, %1)	\
+		: "+r" (err), "=&r" (__lo), "=r" (__hi)			\
+		: "m" (__ptr[__LSW]), "m" (__ptr[__MSW]));		\
+	if (err)							\
+		__hi = 0;						\
+	(x) = (__typeof__(x))((__typeof__((x)-(x)))(			\
+		(((u64)__hi << 32) | __lo)));				\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-#define __get_mem_nocheck(x, __gu_ptr, __gu_err)		\
-do {								\
-	switch (sizeof(*__gu_ptr)) {				\
-	case 1:							\
-		__get_mem_asm("lb", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 2:							\
-		__get_mem_asm("lh", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 4:							\
-		__get_mem_asm("lw", (x), __gu_ptr, __gu_err);	\
-		break;						\
-	case 8:							\
-		__get_mem_8((x), __gu_ptr, __gu_err);		\
-		break;						\
-	default:						\
-		BUILD_BUG();					\
-	}							\
+#define __get_mem_nocheck(x, __gu_ptr, __gu_err, type)			\
+do {									\
+	switch (sizeof(*__gu_ptr)) {					\
+	case 1:								\
+		__get_mem_asm("lb", (x), __gu_ptr, __gu_err, type);	\
+		break;							\
+	case 2:								\
+		__get_mem_asm("lh", (x), __gu_ptr, __gu_err, type);	\
+		break;							\
+	case 4:								\
+		__get_mem_asm("lw", (x), __gu_ptr, __gu_err, type);	\
+		break;							\
+	case 8:								\
+		__get_mem_8((x), __gu_ptr, __gu_err, type);		\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
 } while (0)
 
 /**
@@ -136,7 +136,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__get_mem_nocheck(x, __gu_ptr, __gu_err);		\
+	__get_mem_nocheck(x, __gu_ptr, __gu_err, U);		\
 	__disable_user_access();				\
 								\
 	__gu_err;						\
@@ -163,28 +163,28 @@ do {								\
 ({								\
 	const __typeof__(*(ptr)) __user *__p = (ptr);		\
 	might_fault();						\
-	access_ok(__p, sizeof(*__p)) ?		\
+	access_ok(__p, sizeof(*__p)) ?				\
 		__get_user((x), __p) :				\
 		((x) = 0, -EFAULT);				\
 })
 
-#define __put_mem_asm(insn, x, ptr, err)			\
+#define __put_mem_asm(insn, x, ptr, err, type)			\
 do {								\
 	__typeof__(*(ptr)) __x = x;				\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
 		"	" insn " %z2, %1\n"			\
 		"2:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR(1b, 2b, %0)		\
+		_ASM_EXTABLE_##type##ACCESS_ERR(1b, 2b, %0)	\
 		: "+r" (err), "=m" (*(ptr))			\
 		: "rJ" (__x));					\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define __put_mem_8(x, ptr, err) \
-	__put_mem_asm("sd", x, ptr, err)
+#define __put_mem_8(x, ptr, err, type) \
+	__put_mem_asm("sd", x, ptr, err, type)
 #else /* !CONFIG_64BIT */
-#define __put_mem_8(x, ptr, err)				\
+#define __put_mem_8(x, ptr, err, type)				\
 do {								\
 	u32 *__ptr = (u32 *)(ptr);				\
 	u64 __x = (__typeof__((x)-(x)))(x);			\
@@ -194,8 +194,8 @@ do {								\
 		"2:\n"						\
 		"	sw %z4, %2\n"				\
 		"3:\n"						\
-		_ASM_EXTABLE_UACCESS_ERR(1b, 3b, %0)		\
-		_ASM_EXTABLE_UACCESS_ERR(2b, 3b, %0)		\
+		_ASM_EXTABLE_##type##ACCESS_ERR(1b, 3b, %0)	\
+		_ASM_EXTABLE_##type##ACCESS_ERR(2b, 3b, %0)	\
 		: "+r" (err),					\
 			"=m" (__ptr[__LSW]),			\
 			"=m" (__ptr[__MSW])			\
@@ -203,24 +203,24 @@ do {								\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-#define __put_mem_nocheck(x, __gu_ptr, __pu_err)		\
-do {								\
-	switch (sizeof(*__gu_ptr)) {				\
-	case 1:							\
-		__put_mem_asm("sb", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 2:							\
-		__put_mem_asm("sh", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 4:							\
-		__put_mem_asm("sw", (x), __gu_ptr, __pu_err);	\
-		break;						\
-	case 8:							\
-		__put_mem_8((x), __gu_ptr, __pu_err);		\
-		break;						\
-	default:						\
-		BUILD_BUG();					\
-	}							\
+#define __put_mem_nocheck(x, __gu_ptr, __pu_err, type)			\
+do {									\
+	switch (sizeof(*__gu_ptr)) {					\
+	case 1:								\
+		__put_mem_asm("sb", (x), __gu_ptr, __pu_err, type);	\
+		break;							\
+	case 2:								\
+		__put_mem_asm("sh", (x), __gu_ptr, __pu_err, type);	\
+		break;							\
+	case 4:								\
+		__put_mem_asm("sw", (x), __gu_ptr, __pu_err, type);	\
+		break;							\
+	case 8:								\
+		__put_mem_8((x), __gu_ptr, __pu_err, type);		\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
 } while (0)
 
 /**
@@ -253,7 +253,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__put_mem_nocheck(__val, __gu_ptr, __pu_err);		\
+	__put_mem_nocheck(__val, __gu_ptr, __pu_err, U);	\
 	__disable_user_access();				\
 								\
 	__pu_err;						\
@@ -279,7 +279,7 @@ do {								\
 ({								\
 	__typeof__(*(ptr)) __user *__p = (ptr);			\
 	might_fault();						\
-	access_ok(__p, sizeof(*__p)) ?		\
+	access_ok(__p, sizeof(*__p)) ?				\
 		__put_user((x), __p) :				\
 		-EFAULT;					\
 })
@@ -321,7 +321,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 do {									\
 	long __kr_err;							\
 									\
-	__get_mem_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	__get_mem_nocheck(*((type *)(dst)), (type *)(src), __kr_err, K);\
 	if (unlikely(__kr_err))						\
 		goto err_label;						\
 } while (0)
@@ -330,7 +330,7 @@ do {									\
 do {									\
 	long __kr_err;							\
 									\
-	__put_mem_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
+	__put_mem_nocheck(*((type *)(src)), (type *)(dst), __kr_err, K);\
 	if (unlikely(__kr_err))						\
 		goto err_label;						\
 } while (0)
diff --git a/arch/riscv/mm/extable.c b/arch/riscv/mm/extable.c
index 35484d830fd6..a21ad8237189 100644
--- a/arch/riscv/mm/extable.c
+++ b/arch/riscv/mm/extable.c
@@ -64,6 +64,7 @@ bool fixup_exception(struct pt_regs *regs)
 	case EX_TYPE_BPF:
 		return ex_handler_bpf(ex, regs);
 	case EX_TYPE_UACCESS_ERR_ZERO:
+	case EX_TYPE_KACCESS_ERR_ZERO:
 		return ex_handler_uaccess_err_zero(ex, regs);
 	}
 
-- 
2.25.1

