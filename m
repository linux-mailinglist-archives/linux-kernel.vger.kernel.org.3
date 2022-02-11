Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FA04B2ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353618AbiBKUvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:51:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353502AbiBKUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:51:27 -0500
Received: from mxout03.lancloud.ru (mxout03.lancloud.ru [45.84.86.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D266D81;
        Fri, 11 Feb 2022 12:51:25 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru 8E9F120A91FA
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] sh: avoid using IRQ0 on SH3/4
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>
Organization: Open Mobile Platform
Message-ID: <9382f3ca-b49a-e900-7f21-3f10b267ee4a@omp.ru>
Date:   Fri, 11 Feb 2022 23:51:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
and the code supporting SH3/4 SoCs maps the IRQ #s starting at 0 -- modify
that code to start the IRQ #s from 16 instead.

[1] https://lore.kernel.org/all/5e001ec1-d3f1-bcb8-7f30-a6301fd9930c@omp.ru/

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
The patch is against Linus Torvalds' 'linux.git' repo.

Changes in version 2:
- changed cmp/ge to cmp/hs in the assembly code.

 arch/sh/kernel/cpu/sh3/entry.S |    4 ++--
 include/linux/sh_intc.h        |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

Index: linux/arch/sh/kernel/cpu/sh3/entry.S
===================================================================
--- linux.orig/arch/sh/kernel/cpu/sh3/entry.S
+++ linux/arch/sh/kernel/cpu/sh3/entry.S
@@ -470,9 +470,9 @@ ENTRY(handle_interrupt)
 	mov	r4, r0		! save vector->jmp table offset for later
 
 	shlr2	r4		! vector to IRQ# conversion
-	add	#-0x10, r4
 
-	cmp/pz	r4		! is it a valid IRQ?
+	mov	#0x10, r5
+	cmp/hs	r5, r4		! is it a valid IRQ?
 	bt	10f
 
 	/*
Index: linux/include/linux/sh_intc.h
===================================================================
--- linux.orig/include/linux/sh_intc.h
+++ linux/include/linux/sh_intc.h
@@ -13,9 +13,9 @@
 /*
  * Convert back and forth between INTEVT and IRQ values.
  */
-#ifdef CONFIG_CPU_HAS_INTEVT
-#define evt2irq(evt)		(((evt) >> 5) - 16)
-#define irq2evt(irq)		(((irq) + 16) << 5)
+#ifdef CONFIG_CPU_HAS_INTEVT	/* Avoid IRQ0 (invalid for platform devices) */
+#define evt2irq(evt)		((evt) >> 5)
+#define irq2evt(irq)		((irq) << 5)
 #else
 #define evt2irq(evt)		(evt)
 #define irq2evt(irq)		(irq)
