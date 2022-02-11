Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507C74B2E49
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbiBKUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:15:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBKUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:15:55 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E69CF9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:15:50 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 1C5E020A00B0
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] sh: avoid using IRQ0 on SH3/4
Organization: Open Mobile Platform
Message-ID: <2f419ed2-66b8-4098-7cd3-0fe698d341c9@omp.ru>
Date:   Fri, 11 Feb 2022 23:15:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
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
+	cmp/ge	r5, r4		! is it a valid IRQ?
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
