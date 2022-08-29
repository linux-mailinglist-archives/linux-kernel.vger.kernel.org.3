Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73C5A4796
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiH2KwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiH2KwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:52:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A35D0DC;
        Mon, 29 Aug 2022 03:52:10 -0700 (PDT)
Date:   Mon, 29 Aug 2022 10:52:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1661770328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbSjhvnS6cdpNMmBd981hbgoH/RUgplJxz8S/6mrE3Y=;
        b=gfUT0OJp0aiUV9Gki/9cRBXX8bSxSrHQFrDc5jHJcs5qiWx3zUu964KODzXblTK8uBREip
        O9zZKeDdzFp/HBA1CY8efs0dEO5SXfppOi/AMZzljYkTh7ObBM9RUagZei46rwORREyOsm
        ZVGl+XtT6LFDvLDnoR3uJ3xXYQ+1pr/AUcb6G9kiCP4Bub944EmlgEIvV63PNdOtlmN8MC
        5cy+uBoDBRFzvAeH45ifz+uGVLhX83+SEHhfYY0f+FIRdfDGMwtKx43pZzRZBX8TuxMQeZ
        UhlmBDWC3fQzR0gZeHc7b087FzlmB7I6gfO1hp8SQ4bwteVaxIOqflGguHOlGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1661770328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tbSjhvnS6cdpNMmBd981hbgoH/RUgplJxz8S/6mrE3Y=;
        b=iI+564d2UlqeXAaItQybD2zw0pPWk+cceNI8wJdOFczpTXFPjjeXUQuIbxybwzjqZOy8iL
        fYxAjyu9L9r5U3DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/earlyprintk: Clean up pciserial
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
References: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166177032651.401.449750645705530019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     bc12b70f7d216b36bd87701349374a13e486f8eb
Gitweb:        https://git.kernel.org/tip/bc12b70f7d216b36bd87701349374a13e486f8eb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Aug 2022 13:36:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Aug 2022 12:19:25 +02:00

x86/earlyprintk: Clean up pciserial

While working on a GRUB patch to support PCI-serial, a number of
cleanups were suggested that apply to the code I took inspiration from.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>   # pci_ids.h
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://lkml.kernel.org/r/YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net
---
 arch/x86/kernel/early_printk.c | 14 +++++++-------
 include/linux/pci_ids.h        |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 68b3892..44f9370 100644
--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -264,11 +264,11 @@ static __init void early_pci_serial_init(char *s)
 	bar0 = read_pci_config(bus, slot, func, PCI_BASE_ADDRESS_0);
 
 	/*
-	 * Verify it is a UART type device
+	 * Verify it is a 16550-UART type device
 	 */
 	if (((classcode >> 16 != PCI_CLASS_COMMUNICATION_MODEM) &&
 	     (classcode >> 16 != PCI_CLASS_COMMUNICATION_SERIAL)) ||
-	   (((classcode >> 8) & 0xff) != 0x02)) /* 16550 I/F at BAR0 */ {
+	    (((classcode >> 8) & 0xff) != PCI_SERIAL_16550_COMPATIBLE)) {
 		if (!force)
 			return;
 	}
@@ -276,22 +276,22 @@ static __init void early_pci_serial_init(char *s)
 	/*
 	 * Determine if it is IO or memory mapped
 	 */
-	if (bar0 & 0x01) {
+	if ((bar0 & PCI_BASE_ADDRESS_SPACE) == PCI_BASE_ADDRESS_SPACE_IO) {
 		/* it is IO mapped */
 		serial_in = io_serial_in;
 		serial_out = io_serial_out;
-		early_serial_base = bar0&0xfffffffc;
+		early_serial_base = bar0 & PCI_BASE_ADDRESS_IO_MASK;
 		write_pci_config(bus, slot, func, PCI_COMMAND,
-						cmdreg|PCI_COMMAND_IO);
+				 cmdreg|PCI_COMMAND_IO);
 	} else {
 		/* It is memory mapped - assume 32-bit alignment */
 		serial_in = mem32_serial_in;
 		serial_out = mem32_serial_out;
 		/* WARNING! assuming the address is always in the first 4G */
 		early_serial_base =
-			(unsigned long)early_ioremap(bar0 & 0xfffffff0, 0x10);
+			(unsigned long)early_ioremap(bar0 & PCI_BASE_ADDRESS_MEM_MASK, 0x10);
 		write_pci_config(bus, slot, func, PCI_COMMAND,
-						cmdreg|PCI_COMMAND_MEMORY);
+				 cmdreg|PCI_COMMAND_MEMORY);
 	}
 
 	/*
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 6feade6..41b3fff 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -75,6 +75,9 @@
 #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
 #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
 
+/* Interface for SERIAL/MODEM */
+#define PCI_SERIAL_16550_COMPATIBLE	0x02
+
 #define PCI_BASE_CLASS_SYSTEM		0x08
 #define PCI_CLASS_SYSTEM_PIC		0x0800
 #define PCI_CLASS_SYSTEM_PIC_IOAPIC	0x080010
