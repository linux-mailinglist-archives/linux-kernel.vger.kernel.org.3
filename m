Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601252963E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237915AbiEQAzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiEQAze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:55:34 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349AB36698
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p12so15590428pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4B9whTuaSBuS6zdttFS+MBLPRM6d/yXNWGITeKtP+Lk=;
        b=O5ESu0QnCpH20R9CRje/OfUaATtqia0qeQN5Ac7g2hRBzMtxoiW6Y50QgXYFFPT1JQ
         2C7Qeuu44qzTTmVIHLScuBH0ktoCt97eq0BmboP2b6CDvbFIquA45YZwFDOkBiGJm1rv
         KJM7R1eqxYjJz70QO2fmz8+q3CDRKOH21iugnxi6G718f1ZdiuWvJUZTC+fM3Dz4Rkmj
         ZNLlDUnm18L1osOGkOkc1Mn+uisrPhO5o5Bld04qB3bx+yFBRZd5Upukarb4VqOtkdtb
         JN+cIeuEGgCoP7k57XYWD/il8wkvkEijeClmYr3E3qeafpVI0B79I/npzTzHHcyuGRFg
         1GRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4B9whTuaSBuS6zdttFS+MBLPRM6d/yXNWGITeKtP+Lk=;
        b=AVTuKy3caITP20c2wWfNnWTLmYQGTazztTnYaxeiy/Tt8pq4rGqAdxyrHvVqi+CZ2P
         2e/BNExEuiPsq75K0BQYB+uORt17NUs1mc6GfNb0jpsFP51F62bu5PJhKhnOlShiRLar
         peMRSNp00EQdOO55mQRXmio6e9N90U4clyeGuHcmWIMAQgF4MRglBSj6aodjeQ5U0t8V
         pANn4MDQmtcACzHI/bgRcBlvVRuQut7areYezxhDRzZ9lMkBYLNAyGcpxM1wlvOts1du
         8d1+cpvzTB/H5QXCuEQaAxrnJFw4jvWx5gRqwa0Se18JVyk0MSK8Dmcl/Hygv5/ETU8Q
         kKaA==
X-Gm-Message-State: AOAM532AKZQblvjyQCObxJA2KAEyE8b6yeoAFgKiPj+Qml1QO22fErto
        wQRzoE+vu+uLwz0MbupZHLEQZ4dLbvA=
X-Google-Smtp-Source: ABdhPJz3B5rOUpekhP9RiiPysC+YiE+tZGPYkHfGaRIR9MRb5dNhKVLPbFQKs1MVje4YehDvDgpBnA==
X-Received: by 2002:a05:6a00:1683:b0:4f7:e497:6a55 with SMTP id k3-20020a056a00168300b004f7e4976a55mr19773111pfc.21.1652748932153;
        Mon, 16 May 2022 17:55:32 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id k3-20020a17090a7f0300b001d77f392280sm293701pjl.30.2022.05.16.17.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:55:31 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 02/13] openrisc: Cleanup emergency print handling
Date:   Tue, 17 May 2022 09:54:59 +0900
Message-Id: <20220517005510.3500105-3-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The emergency print support only works for 8250 compatible serial ports.
Now that OpenRISC platforms may be configured with different serial port
hardware we don't want emergency print to try to print to non-existent
hardware which will cause lockups.

This patch contains several fixes to get emergency print working again:

 - Update symbol loading to not assume the location of symbols
 - Split the putc print operation out to its own function to allow
   for different future implementations.
 - Update _emergency_print_nr and _emergency_print to use the putc
   function.
 - Guard serial 8250 specific sequences by CONFIG_SERIAL_8250
 - Update string line feed from lf,cr to cr,lf.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
Changes since v1:
 - Fix ifdefs pointed out by Samuel

 arch/openrisc/kernel/head.S | 148 +++++++++++++++++++++---------------
 1 file changed, 85 insertions(+), 63 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 15f1b38dfe03..7bfa6e4b60c5 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -297,19 +297,23 @@
 	/* temporary store r3, r9 into r1, r10 */		;\
 	l.addi	r1,r3,0x0					;\
 	l.addi	r10,r9,0x0					;\
-	/* the string referenced by r3 must be low enough */	;\
+	LOAD_SYMBOL_2_GPR(r9,_string_unhandled_exception)	;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_unhandled_exception)		;\
+	 l.nop							;\
 	l.mfspr	r3,r0,SPR_NPC					;\
 	l.jal	_emergency_print_nr				;\
-	l.andi	r3,r3,0x1f00					;\
-	/* the string referenced by r3 must be low enough */	;\
+	 l.andi	r3,r3,0x1f00					;\
+	LOAD_SYMBOL_2_GPR(r9,_string_epc_prefix)		;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_epc_prefix)			;\
+	 l.nop							;\
 	l.jal	_emergency_print_nr				;\
-	l.mfspr	r3,r0,SPR_EPCR_BASE				;\
+	 l.mfspr r3,r0,SPR_EPCR_BASE				;\
+	LOAD_SYMBOL_2_GPR(r9,_string_nl)			;\
+	tophys	(r3,r9)						;\
 	l.jal	_emergency_print				;\
-	l.ori	r3,r0,lo(_string_nl)				;\
+	 l.nop							;\
 	/* end of printing */					;\
 	l.addi	r3,r1,0x0					;\
 	l.addi	r9,r10,0x0					;\
@@ -1530,65 +1534,99 @@ trampoline_out:
 	l.jr	r9
 	l.nop
 
-
 /*
- * DSCR: prints a string referenced by r3.
+ * DESC: Prints ASCII character stored in r7
  *
- * PRMS: r3     	- address of the first character of null
- *			terminated string to be printed
+ * PRMS: r7	- a 32-bit value with an ASCII character in the first byte
+ *		position.
  *
- * PREQ: UART at UART_BASE_ADD has to be initialized
+ * PREQ: The UART at UART_BASE_ADD has to be initialized
  *
- * POST: caller should be aware that r3, r9 are changed
+ * POST: internally used but restores:
+ * 	 r4	- to store UART_BASE_ADD
+ *	 r5	- for loading OFF_TXFULL / THRE,TEMT
+ *	 r6	- for storing bitmask (SERIAL_8250)
  */
-ENTRY(_emergency_print)
+ENTRY(_emergency_putc)
 	EMERGENCY_PRINT_STORE_GPR4
 	EMERGENCY_PRINT_STORE_GPR5
 	EMERGENCY_PRINT_STORE_GPR6
-	EMERGENCY_PRINT_STORE_GPR7
-2:
-	l.lbz	r7,0(r3)
-	l.sfeq	r7,r0
-	l.bf	9f
-	l.nop
 
-// putc:
 	l.movhi r4,hi(UART_BASE_ADD)
+	l.ori	r4,r4,lo(UART_BASE_ADD)
 
+#if defined(CONFIG_SERIAL_8250)
+	/* Check UART LSR THRE (hold) bit */
 	l.addi  r6,r0,0x20
 1:      l.lbz   r5,5(r4)
 	l.andi  r5,r5,0x20
 	l.sfeq  r5,r6
 	l.bnf   1b
-	l.nop
+	 l.nop
 
+	/* Write character */
 	l.sb    0(r4),r7
 
+	/* Check UART LSR THRE|TEMT (hold, empty) bits */
 	l.addi  r6,r0,0x60
 1:      l.lbz   r5,5(r4)
 	l.andi  r5,r5,0x60
 	l.sfeq  r5,r6
 	l.bnf   1b
-	l.nop
+	 l.nop
+#endif
+	EMERGENCY_PRINT_LOAD_GPR6
+	EMERGENCY_PRINT_LOAD_GPR5
+	EMERGENCY_PRINT_LOAD_GPR4
+	l.jr	r9
+	 l.nop
+
+/*
+ * DSCR: prints a string referenced by r3.
+ *
+ * PRMS: r3     	- address of the first character of null
+ *			terminated string to be printed
+ *
+ * PREQ: UART at UART_BASE_ADD has to be initialized
+ *
+ * POST: caller should be aware that r3, r9 are changed
+ */
+ENTRY(_emergency_print)
+	EMERGENCY_PRINT_STORE_GPR7
+	EMERGENCY_PRINT_STORE_GPR9
+
+	/* Load character to r7, check for null terminator */
+2:	l.lbz	r7,0(r3)
+	l.sfeqi	r7,0x0
+	l.bf	9f
+	 l.nop
+
+	l.jal	_emergency_putc
+	 l.nop
 
 	/* next character */
 	l.j	2b
-	l.addi	r3,r3,0x1
+	 l.addi	r3,r3,0x1
 
 9:
+	EMERGENCY_PRINT_LOAD_GPR9
 	EMERGENCY_PRINT_LOAD_GPR7
-	EMERGENCY_PRINT_LOAD_GPR6
-	EMERGENCY_PRINT_LOAD_GPR5
-	EMERGENCY_PRINT_LOAD_GPR4
 	l.jr	r9
-	l.nop
+	 l.nop
 
+/*
+ * DSCR: prints a number in r3 in hex.
+ *
+ * PRMS: r3     	- a 32-bit unsigned integer
+ *
+ * PREQ: UART at UART_BASE_ADD has to be initialized
+ *
+ * POST: caller should be aware that r3, r9 are changed
+ */
 ENTRY(_emergency_print_nr)
-	EMERGENCY_PRINT_STORE_GPR4
-	EMERGENCY_PRINT_STORE_GPR5
-	EMERGENCY_PRINT_STORE_GPR6
 	EMERGENCY_PRINT_STORE_GPR7
 	EMERGENCY_PRINT_STORE_GPR8
+	EMERGENCY_PRINT_STORE_GPR9
 
 	l.addi	r8,r0,32		// shift register
 
@@ -1600,58 +1638,39 @@ ENTRY(_emergency_print_nr)
 	/* don't skip the last zero if number == 0x0 */
 	l.sfeqi	r8,0x4
 	l.bf	2f
-	l.nop
+	 l.nop
 
 	l.sfeq	r7,r0
 	l.bf	1b
-	l.nop
+	 l.nop
 
 2:
 	l.srl	r7,r3,r8
 
 	l.andi	r7,r7,0xf
 	l.sflts	r8,r0
-	l.bf	9f
+	 l.bf	9f
 
+	/* Numbers greater than 9 translate to a-f */
 	l.sfgtui r7,0x9
 	l.bnf	8f
-	l.nop
+	 l.nop
 	l.addi	r7,r7,0x27
 
-8:
-	l.addi	r7,r7,0x30
-// putc:
-	l.movhi r4,hi(UART_BASE_ADD)
-
-	l.addi  r6,r0,0x20
-1:      l.lbz   r5,5(r4)
-	l.andi  r5,r5,0x20
-	l.sfeq  r5,r6
-	l.bnf   1b
-	l.nop
-
-	l.sb    0(r4),r7
-
-	l.addi  r6,r0,0x60
-1:      l.lbz   r5,5(r4)
-	l.andi  r5,r5,0x60
-	l.sfeq  r5,r6
-	l.bnf   1b
-	l.nop
+	/* Convert to ascii and output character */
+8:	l.jal	_emergency_putc
+	 l.addi	r7,r7,0x30
 
 	/* next character */
 	l.j	2b
 	l.addi	r8,r8,-0x4
 
 9:
+	EMERGENCY_PRINT_LOAD_GPR9
 	EMERGENCY_PRINT_LOAD_GPR8
 	EMERGENCY_PRINT_LOAD_GPR7
-	EMERGENCY_PRINT_LOAD_GPR6
-	EMERGENCY_PRINT_LOAD_GPR5
-	EMERGENCY_PRINT_LOAD_GPR4
 	l.jr	r9
-	l.nop
-
+	 l.nop
 
 /*
  * This should be used for debugging only.
@@ -1676,7 +1695,9 @@ ENTRY(_emergency_print_nr)
 
 ENTRY(_early_uart_init)
 	l.movhi	r3,hi(UART_BASE_ADD)
+	l.ori	r3,r3,lo(UART_BASE_ADD)
 
+#if defined(CONFIG_SERIAL_8250)
 	l.addi	r4,r0,0x7
 	l.sb	0x2(r3),r4
 
@@ -1694,9 +1715,10 @@ ENTRY(_early_uart_init)
 	l.addi  r4,r0,((UART_DIVISOR) & 0x000000ff)
 	l.sb	UART_DLL(r3),r4
 	l.sb	0x3(r3),r5
+#endif
 
 	l.jr	r9
-	l.nop
+	 l.nop
 
 	.align	0x1000
 	.global _secondary_evbar
@@ -1711,13 +1733,13 @@ _secondary_evbar:
 
 	.section .rodata
 _string_unhandled_exception:
-	.string "\n\rRunarunaround: Unhandled exception 0x\0"
+	.string "\r\nRunarunaround: Unhandled exception 0x\0"
 
 _string_epc_prefix:
 	.string ": EPC=0x\0"
 
 _string_nl:
-	.string "\n\r\0"
+	.string "\r\n\0"
 
 
 /* ========================================[ page aligned structures ]=== */
-- 
2.31.1

