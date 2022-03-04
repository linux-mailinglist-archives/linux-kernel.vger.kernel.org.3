Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C634CD798
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240241AbiCDPXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240223AbiCDPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:23:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33DF10A6;
        Fri,  4 Mar 2022 07:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=h4FCNEPQwTG4sN1msaWa8+oYY6eRjb1lItZHTcbmJsA=; b=HvjqSCmDT7NxHR1WfgWeLckGZK
        s73J8y0wubGQnoJWwN6ER55IZfO7cqLKAftOn3ALwvg0oIGaOryZQG26pNdtpwyZx4VY8FMmY3vW5
        KPXPlgxRNhb/qmKCryj91ARhfy5LOz5I0HUv+WDfUh6860r5CcxNCiHYR+qGrJxgkzNPaZB0Xw0Gi
        sKyMVMfxowaDNGZQVRCKeflnSpNeQeJCfyo0icU5nCDBh0pIH9ZusbfP/0qqPXOp+zenbIShSiVW3
        LcxFzOpce8iFuWXXHVrWhadr0XOzFhZR1xTsIRw9AH/76SaaKxGVVXojt4JxrATBJ0exwvfc6Cp+7
        YmJL5LUQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQ9l4-00FEIl-SV; Fri, 04 Mar 2022 15:22:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 86444300454;
        Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6E1D72C546F73; Fri,  4 Mar 2022 16:22:17 +0100 (CET)
Message-ID: <20220304152135.975568860@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 04 Mar 2022 16:19:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, mathias.nyman@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        rdunlap@infradead.org, linux-usb@vger.kernel.org
Subject: [PATCH 2/3] usb: early: xhci-dbc: Remove duplicate keep parsing
References: <20220304151953.830111479@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic earlyprintk= parsing already parses the optional ",keep",
no need to duplicate that in the xdbc driver.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/early_printk.c |    2 +-
 drivers/usb/early/xhci-dbc.c   |    5 ++---
 include/linux/usb/xhci-dbgp.h  |    2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/early_printk.c
+++ b/arch/x86/kernel/early_printk.c
@@ -387,7 +387,7 @@ static int __init setup_early_printk(cha
 #endif
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
 		if (!strncmp(buf, "xdbc", 4))
-			early_xdbc_parse_parameter(buf + 4);
+			early_xdbc_parse_parameter(buf + 4, keep);
 #endif
 
 		buf++;
--- a/drivers/usb/early/xhci-dbc.c
+++ b/drivers/usb/early/xhci-dbc.c
@@ -599,7 +599,7 @@ static int __init xdbc_early_setup(void)
 	return 0;
 }
 
-int __init early_xdbc_parse_parameter(char *s)
+int __init early_xdbc_parse_parameter(char *s, int keep_early)
 {
 	unsigned long dbgp_num = 0;
 	u32 bus, dev, func, offset;
@@ -608,8 +608,7 @@ int __init early_xdbc_parse_parameter(ch
 	if (!early_pci_allowed())
 		return -EPERM;
 
-	if (strstr(s, "keep"))
-		early_console_keep = true;
+	early_console_keep = keep_early;
 
 	if (xdbc.xdbc_reg)
 		return 0;
--- a/include/linux/usb/xhci-dbgp.h
+++ b/include/linux/usb/xhci-dbgp.h
@@ -15,7 +15,7 @@
 #define __LINUX_XHCI_DBGP_H
 
 #ifdef CONFIG_EARLY_PRINTK_USB_XDBC
-int __init early_xdbc_parse_parameter(char *s);
+int __init early_xdbc_parse_parameter(char *s, int keep_early);
 int __init early_xdbc_setup_hardware(void);
 void __init early_xdbc_register_console(void);
 #else


