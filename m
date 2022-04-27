Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 087E45121DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiD0TAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiD0TAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:00:38 -0400
Received: from mxout04.lancloud.ru (mxout04.lancloud.ru [45.84.86.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F122D081C;
        Wed, 27 Apr 2022 11:46:13 -0700 (PDT)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout04.lancloud.ru C5C71209A0EB
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3] sh: avoid using IRQ0 on SH3/4
To:     Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Organization: Open Mobile Platform
Message-ID: <2584ba18-9653-9310-efc1-8b3b3e221eea@omp.ru>
Date:   Wed, 27 Apr 2022 21:46:09 +0300
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
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using IRQ0 by the platform devices is going to be disallowed soon (see [1])
and even now, when IRQ0 is about to be returned by platfrom_get_irq(), you
see a big warning.  The code supporting SH3/4 SoCs maps the IRQ #s starting
at 0 -- modify that code to start the IRQ #s from 16 instead.

The patch should mostly affect the AP-SH4A-3A/AP-SH4AD-0A boards as they
indeed use IRQ0 for the SMSC911x compatible Ethernet chip...

[1] https://lore.kernel.org/all/025679e1-1f0a-ae4b-4369-01164f691511@omp.ru/

Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

---
The patch is against Linus Torvalds' 'linux.git' repo.

Changes in version 3:
- added an appropriate Fixes: tag and added a passage about it to the patch
  description;
- added actual cases of the boards using IRQ0 to the patch description;
- added Geert Uytterhoeven's and John Paul Adrian Glaubitz's tags;
- updated the link to point to the version 2 of the patch.

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
