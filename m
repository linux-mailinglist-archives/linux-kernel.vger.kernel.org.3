Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BE85A0F65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiHYLhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbiHYLgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:36:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D652656D
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DA16lJ58mNa+twkEn0gWxOy22apPk7IFnJTgPysn9Js=; b=pgXKSvlrk/sJKzyHhdZGk6mt0w
        HNtg9e5CNi6YOaomH7xfkwvuT0/U/hBa7tFb01R4gwtfuAjTHaWGe/giRIfYYHNzhV9jVQFdpsw+g
        cNclrL7av961qbp52xYqYwrNFQ+slL6SKor4SZWP37UabZwuZS3pAJAUZNE95uiyaeeYPtldFbagl
        +meaT7pSEWFCHZCr/NxcwXGFGWB41FJzkOmxV+c5ZWDmDC3eut/l4FbkMTcaz2v9Pa6agHztm44+S
        APVOcUpyxrWzblALXklKSEItJJujOhevEiebH121mq/Wi1CRpv1B3W/3vzFfhM5CDBZlvvD9qsRts
        zqz1sguA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRBAA-00HDKe-Bl; Thu, 25 Aug 2022 11:36:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 505AE98014D; Thu, 25 Aug 2022 13:36:40 +0200 (CEST)
Date:   Thu, 25 Aug 2022 13:36:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        gregkh@linuxfoundation.org
Subject: [PATCH] earlyprintk: Clean up pciserial
Message-ID: <YwdeyCEtW+wa+QhH@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


While working on a GRUB patch to support PCI-serial, a number of
cleanups were suggested that apply to the code I took inspiration from.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/early_printk.c | 14 +++++++-------
 include/linux/pci_ids.h        |  3 +++
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/early_printk.c b/arch/x86/kernel/early_printk.c
index 68b38925a74f..44f937015e1e 100644
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
index 6feade66efdb..1d2c7df8cd41 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -75,6 +75,9 @@
 #define PCI_CLASS_COMMUNICATION_MODEM	0x0703
 #define PCI_CLASS_COMMUNICATION_OTHER	0x0780
 
+/* I/F for SERIAL/MODEM */
+#define PCI_SERIAL_16550_COMPATIBLE	0x02
+
 #define PCI_BASE_CLASS_SYSTEM		0x08
 #define PCI_CLASS_SYSTEM_PIC		0x0800
 #define PCI_CLASS_SYSTEM_PIC_IOAPIC	0x080010
