Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF174754CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241008AbhLOJBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:01:37 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16814 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbhLOJBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:01:36 -0500
Received: from dggeme764-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDTjt3HFPz91ky;
        Wed, 15 Dec 2021 17:00:50 +0800 (CST)
Received: from huawei.com (10.67.174.119) by dggeme764-chm.china.huawei.com
 (10.3.19.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.20; Wed, 15
 Dec 2021 17:01:34 +0800
From:   Xu Kuohai <xukuohai@huawei.com>
To:     Russell King <linux@armlinux.org.uk>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: Add unwinding annotations to __loop.*delay functions
Date:   Wed, 15 Dec 2021 09:06:07 +0000
Message-ID: <20211215090607.3737830-1-xukuohai@huawei.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.119]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme764-chm.china.huawei.com (10.3.19.110)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unwind directives can't handle nested function entries, so only the
outermost function __loop_udelay is annotated, and the inner nested
entries share the same unwind info with __loop_udelay.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm/lib/delay-loop.S | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/delay-loop.S b/arch/arm/lib/delay-loop.S
index 3ccade0f8130..f0a076f9abc5 100644
--- a/arch/arm/lib/delay-loop.S
+++ b/arch/arm/lib/delay-loop.S
@@ -7,6 +7,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/delay.h>
+#include <asm/unwind.h>
 
 		.text
 
@@ -21,6 +22,7 @@
  */
 
 ENTRY(__loop_udelay)
+UNWIND(.fnstart)
 		ldr	r2, .LC1
 		mul	r0, r2, r0		@ r0 = delay_us * UDELAY_MULT
 ENTRY(__loop_const_udelay)			@ 0 <= r0 <= 0xfffffaf0
@@ -54,6 +56,7 @@ ENTRY(__loop_delay)
 #endif
 		bhi	__loop_delay
 		ret	lr
-ENDPROC(__loop_udelay)
-ENDPROC(__loop_const_udelay)
 ENDPROC(__loop_delay)
+ENDPROC(__loop_const_udelay)
+UNWIND(.fnend)
+ENDPROC(__loop_udelay)
-- 
2.27.0

