Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1F59280C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiHODVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiHODU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:20:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F497A1A7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:20:55 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5fd03nfxzmVjX;
        Mon, 15 Aug 2022 11:18:44 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:53 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:52 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v2 1/2] riscv: uaccess: rename __get/put_user_nocheck to __get/put_mem_nocheck
Date:   Mon, 15 Aug 2022 03:20:24 +0000
Message-ID: <20220815032025.2685516-2-tongtiangen@huawei.com>
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

Current, The helpers __get/put_user_nocheck() is used by get/put_user() and
__get/put_kernel_nofault(), which is not always uaccess, so the name with
*user* is not appropriate.

Also rename xxx_user_xxx to xxx_mem_xx  on the call path of
__get/put_user_nocheck()

Only refactor code without any functional changes.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/riscv/include/asm/uaccess.h | 48 ++++++++++++++++----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 855450bed9f5..1370da055b44 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -50,7 +50,7 @@
  * call.
  */
 
-#define __get_user_asm(insn, x, ptr, err)			\
+#define __get_mem_asm(insn, x, ptr, err)			\
 do {								\
 	__typeof__(x) __x;					\
 	__asm__ __volatile__ (					\
@@ -64,12 +64,12 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define __get_user_8(x, ptr, err) \
-	__get_user_asm("ld", x, ptr, err)
+#define __get_mem_8(x, ptr, err) \
+	__get_mem_asm("ld", x, ptr, err)
 #else /* !CONFIG_64BIT */
-#define __get_user_8(x, ptr, err)				\
+#define __get_mem_8(x, ptr, err)				\
 do {								\
-	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u32 *__ptr = (u32 *)(ptr);				\
 	u32 __lo, __hi;						\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
@@ -88,20 +88,20 @@ do {								\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-#define __get_user_nocheck(x, __gu_ptr, __gu_err)		\
+#define __get_mem_nocheck(x, __gu_ptr, __gu_err)		\
 do {								\
 	switch (sizeof(*__gu_ptr)) {				\
 	case 1:							\
-		__get_user_asm("lb", (x), __gu_ptr, __gu_err);	\
+		__get_mem_asm("lb", (x), __gu_ptr, __gu_err);	\
 		break;						\
 	case 2:							\
-		__get_user_asm("lh", (x), __gu_ptr, __gu_err);	\
+		__get_mem_asm("lh", (x), __gu_ptr, __gu_err);	\
 		break;						\
 	case 4:							\
-		__get_user_asm("lw", (x), __gu_ptr, __gu_err);	\
+		__get_mem_asm("lw", (x), __gu_ptr, __gu_err);	\
 		break;						\
 	case 8:							\
-		__get_user_8((x), __gu_ptr, __gu_err);	\
+		__get_mem_8((x), __gu_ptr, __gu_err);		\
 		break;						\
 	default:						\
 		BUILD_BUG();					\
@@ -136,7 +136,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__get_user_nocheck(x, __gu_ptr, __gu_err);		\
+	__get_mem_nocheck(x, __gu_ptr, __gu_err);		\
 	__disable_user_access();				\
 								\
 	__gu_err;						\
@@ -168,7 +168,7 @@ do {								\
 		((x) = 0, -EFAULT);				\
 })
 
-#define __put_user_asm(insn, x, ptr, err)			\
+#define __put_mem_asm(insn, x, ptr, err)			\
 do {								\
 	__typeof__(*(ptr)) __x = x;				\
 	__asm__ __volatile__ (					\
@@ -181,12 +181,12 @@ do {								\
 } while (0)
 
 #ifdef CONFIG_64BIT
-#define __put_user_8(x, ptr, err) \
-	__put_user_asm("sd", x, ptr, err)
+#define __put_mem_8(x, ptr, err) \
+	__put_mem_asm("sd", x, ptr, err)
 #else /* !CONFIG_64BIT */
-#define __put_user_8(x, ptr, err)				\
+#define __put_mem_8(x, ptr, err)				\
 do {								\
-	u32 __user *__ptr = (u32 __user *)(ptr);		\
+	u32 *__ptr = (u32 *)(ptr);				\
 	u64 __x = (__typeof__((x)-(x)))(x);			\
 	__asm__ __volatile__ (					\
 		"1:\n"						\
@@ -203,20 +203,20 @@ do {								\
 } while (0)
 #endif /* CONFIG_64BIT */
 
-#define __put_user_nocheck(x, __gu_ptr, __pu_err)					\
+#define __put_mem_nocheck(x, __gu_ptr, __pu_err)		\
 do {								\
 	switch (sizeof(*__gu_ptr)) {				\
 	case 1:							\
-		__put_user_asm("sb", (x), __gu_ptr, __pu_err);	\
+		__put_mem_asm("sb", (x), __gu_ptr, __pu_err);	\
 		break;						\
 	case 2:							\
-		__put_user_asm("sh", (x), __gu_ptr, __pu_err);	\
+		__put_mem_asm("sh", (x), __gu_ptr, __pu_err);	\
 		break;						\
 	case 4:							\
-		__put_user_asm("sw", (x), __gu_ptr, __pu_err);	\
+		__put_mem_asm("sw", (x), __gu_ptr, __pu_err);	\
 		break;						\
 	case 8:							\
-		__put_user_8((x), __gu_ptr, __pu_err);	\
+		__put_mem_8((x), __gu_ptr, __pu_err);		\
 		break;						\
 	default:						\
 		BUILD_BUG();					\
@@ -253,7 +253,7 @@ do {								\
 	__chk_user_ptr(__gu_ptr);				\
 								\
 	__enable_user_access();					\
-	__put_user_nocheck(__val, __gu_ptr, __pu_err);		\
+	__put_mem_nocheck(__val, __gu_ptr, __pu_err);		\
 	__disable_user_access();				\
 								\
 	__pu_err;						\
@@ -321,7 +321,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 do {									\
 	long __kr_err;							\
 									\
-	__get_user_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
+	__get_mem_nocheck(*((type *)(dst)), (type *)(src), __kr_err);	\
 	if (unlikely(__kr_err))						\
 		goto err_label;						\
 } while (0)
@@ -330,7 +330,7 @@ do {									\
 do {									\
 	long __kr_err;							\
 									\
-	__put_user_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
+	__put_mem_nocheck(*((type *)(src)), (type *)(dst), __kr_err);	\
 	if (unlikely(__kr_err))						\
 		goto err_label;						\
 } while (0)
-- 
2.25.1

