Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B864F5E84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiDFMw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiDFMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:51:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942F5C365
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:32 -0700 (PDT)
Received: from kwepemi100009.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KYJGM5tRfzdZZq;
        Wed,  6 Apr 2022 16:54:03 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100009.china.huawei.com (7.221.188.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:30 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:29 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 4/7] arm64: add copy_from_user to machine check safe
Date:   Wed, 6 Apr 2022 09:13:08 +0000
Message-ID: <20220406091311.3354723-5-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add scenarios copy_from_user to machine check safe.

The data copied is user data and is machine check safe, so just kill
the user process and isolate the error page, not necessary panic.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/asm-uaccess.h | 16 ++++++++++++++++
 arch/arm64/lib/copy_from_user.S      | 11 ++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/asm-uaccess.h b/arch/arm64/include/asm/asm-uaccess.h
index 0557af834e03..f31c8978e1af 100644
--- a/arch/arm64/include/asm/asm-uaccess.h
+++ b/arch/arm64/include/asm/asm-uaccess.h
@@ -92,4 +92,20 @@ alternative_else_nop_endif
 
 		_asm_extable	8888b,\l;
 	.endm
+
+	.macro user_ldp_mc l, reg1, reg2, addr, post_inc
+8888:		ldtr	\reg1, [\addr];
+8889:		ldtr	\reg2, [\addr, #8];
+		add	\addr, \addr, \post_inc;
+
+		_asm_extable_mc	8888b, \l;
+		_asm_extable_mc	8889b, \l;
+	.endm
+
+	.macro user_ldst_mc l, inst, reg, addr, post_inc
+8888:		\inst		\reg, [\addr];
+		add		\addr, \addr, \post_inc;
+
+		_asm_extable_mc	8888b, \l;
+	.endm
 #endif
diff --git a/arch/arm64/lib/copy_from_user.S b/arch/arm64/lib/copy_from_user.S
index 34e317907524..d9d7c5291871 100644
--- a/arch/arm64/lib/copy_from_user.S
+++ b/arch/arm64/lib/copy_from_user.S
@@ -21,7 +21,7 @@
  */
 
 	.macro ldrb1 reg, ptr, val
-	user_ldst 9998f, ldtrb, \reg, \ptr, \val
+	user_ldst_mc 9998f, ldtrb, \reg, \ptr, \val
 	.endm
 
 	.macro strb1 reg, ptr, val
@@ -29,7 +29,7 @@
 	.endm
 
 	.macro ldrh1 reg, ptr, val
-	user_ldst 9997f, ldtrh, \reg, \ptr, \val
+	user_ldst_mc 9997f, ldtrh, \reg, \ptr, \val
 	.endm
 
 	.macro strh1 reg, ptr, val
@@ -37,7 +37,7 @@
 	.endm
 
 	.macro ldr1 reg, ptr, val
-	user_ldst 9997f, ldtr, \reg, \ptr, \val
+	user_ldst_mc 9997f, ldtr, \reg, \ptr, \val
 	.endm
 
 	.macro str1 reg, ptr, val
@@ -45,7 +45,7 @@
 	.endm
 
 	.macro ldp1 reg1, reg2, ptr, val
-	user_ldp 9997f, \reg1, \reg2, \ptr, \val
+	user_ldp_mc 9997f, \reg1, \reg2, \ptr, \val
 	.endm
 
 	.macro stp1 reg1, reg2, ptr, val
@@ -62,7 +62,8 @@ SYM_FUNC_START(__arch_copy_from_user)
 	ret
 
 	// Exception fixups
-9997:	cmp	dst, dstin
+9997:	cbz	x0, 9998f			// Check machine check exception
+	cmp	dst, dstin
 	b.ne	9998f
 	// Before being absolutely sure we couldn't copy anything, try harder
 USER(9998f, ldtrb tmp1w, [srcin])
-- 
2.18.0.huawei.25

