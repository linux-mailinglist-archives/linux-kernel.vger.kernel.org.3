Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1D34799CF
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 09:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhLRI5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 03:57:48 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28328 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbhLRI5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 03:57:46 -0500
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JGKVX3K2JzbjGm;
        Sat, 18 Dec 2021 16:57:24 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Sat, 18 Dec 2021 16:57:44 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <linux@armlinux.org.uk>, <krzysztof.kozlowski@canonical.com>,
        <andrew@lunn.ch>, <gregory.clement@bootlin.com>,
        <sebastian.hesselbarth@gmail.com>, <vireshk@kernel.org>,
        <shiraz.linux.kernel@gmail.com>, <soc@kernel.org>,
        <linus.walleij@linaro.org>, <ardb@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <gongruiqi1@huawei.com>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next 2/3] arm-soc: mvebu: replace open coded VA->PA conversion
Date:   Sat, 18 Dec 2021 16:58:42 +0800
Message-ID: <20211218085843.212497-3-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20211218085843.212497-1-cuigaosheng1@huawei.com>
References: <20211218085843.212497-1-cuigaosheng1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

This replaces an open coded calculation to obtain the physical
address of a far symbol with a call to the new ldr_l etc macro.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a3a64bf97250..9ae65b1e9745 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -37,9 +37,7 @@ ENTRY(ll_get_coherency_base)
 	 * MMU is disabled, use the physical address of the coherency
 	 * base address, (or 0x0 if the coherency fabric is not mapped)
 	 */
-	adr	r1, 3f
-	ldr	r3, [r1]
-	ldr	r1, [r1, r3]
+	ldr_l	r1, coherency_phys_base
 	b	2f
 1:
 	/*
@@ -155,7 +153,3 @@ ENTRY(ll_disable_coherency)
 	dsb
 	ret	lr
 ENDPROC(ll_disable_coherency)
-
-	.align 2
-3:
-	.long	coherency_phys_base - .
-- 
2.30.0

