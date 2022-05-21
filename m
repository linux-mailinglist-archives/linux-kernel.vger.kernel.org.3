Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD00652FCA1
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 15:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354857AbiEUNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 09:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354590AbiEUNN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:13:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3816644E8
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id bo5so9874425pfb.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6s5Kt+Fz8ODBsnaEn4hTWh6elxNZ/IIbeZw2XTvUCZg=;
        b=E5YlB7DR9wKAmnr1kNUjXgHvPlt7rIutr9zqF9ZwzMKuBVLBZNo8YeGkUR+kZ6iUpT
         KXy1yNWEezsUEcvM/kytC7dl6xbf/h5R2W5aco6unOeXhw5FCjMUu8Ir/UcCYwuxjeHt
         5V35G3DFAmB+epUNfvoRlTcgBEP9wiYKkK9+V9uC+rAa37CoCvZwXgmi+UxsW0qfhlMG
         gLOyWJCe/DExV7JxeyWKiVjLb9ARtw99SOcLrgtFciOWA9lT5tHaC3M7lACe4erFXLAw
         n8CK8EPVaP+SRyD7OWhi4uNEBdQsoOFEkn/kRPdENTDXNrMvmWJb8wwh7icH4hwSW0go
         bvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6s5Kt+Fz8ODBsnaEn4hTWh6elxNZ/IIbeZw2XTvUCZg=;
        b=ww27mn1PMD4F5PN0/uEmFsnTA16dtgBEgiT1RCKQt0qBiVGpIqqJKddxdCLdLwK+0I
         cI5j5j9SXfNRFYiHiPBEys91mZxUrPQ8SxZ88L4eP76hH/V8ILI/B/snuWIrf1fbq5Ct
         PUqHP20zT9WLPiZb8JpK2cJmQMlRHCJufYkPUGpG8eWe8RNIF+3X4gPiKFUluZz6m/pA
         FGXtlBZYVtEVvUiyBENWzs4YfDYGB61RkvWGYJx7QsPC68xaFyuM4ZlQYgmhJM/WtLdI
         8k5ik0YxP8UsTW/kFFTjshhVdEsFSVy1n8dpy9+0iBCkp/umSwEclXqRENERCui7I4hs
         tpcw==
X-Gm-Message-State: AOAM532ZpXRjtXLxmna8hwfyjONXACWuDCr4dOALbr+aVK4CtcQEzr8X
        76yoXIp3iw8Zq0hCtjjHM06xNIQ5vGjjaA==
X-Google-Smtp-Source: ABdhPJw9okdrDgb1vUahM8hyulgKTKxGm09be9n5L9BA2zsBs0mxsDX31gMptWextpj9RiwT8YDlaQ==
X-Received: by 2002:a63:4401:0:b0:3fa:df3:4201 with SMTP id r1-20020a634401000000b003fa0df34201mr805064pga.65.1653138833789;
        Sat, 21 May 2022 06:13:53 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id jh5-20020a170903328500b00161527e1d9fsm1545279plb.294.2022.05.21.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 06:13:53 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 05/13] openrisc: Pretty print show_registers memory dumps
Date:   Sat, 21 May 2022 22:13:15 +0900
Message-Id: <20220521131323.631209-6-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220521131323.631209-1-shorne@gmail.com>
References: <20220521131323.631209-1-shorne@gmail.com>
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

Currently show registers, print memory dumps character by character and
there is no address information, so its a bit difficult to use.  For
example before a stack dump looks as follows.

    [   13.650000] Stack:
    [   13.650000] Call trace
    [   13.690000] [<(ptrval)>] ? put_timespec64+0x44/0x60
    [   13.690000] [<(ptrval)>] ? _data_page_fault_handler+0x104/0x10c
    [   13.700000]
    [   13.700000] Code:
    [   13.700000] 13
    [   13.700000] ff
    [   13.700000] ff
    [   13.700000] f9
    [   13.710000] 84
    [   13.710000] 82
    [   13.710000] ff
    [   13.710000] bc
    [   13.710000] 07
    [   13.710000] fd
    [   13.720000] 4e
    [   13.720000] 67
    [   13.720000] 84
    [   13.720000] 62
    [   13.720000] ff
    ...

This change updates this to print the address and data a word at time.

    [    0.830000] Stack:
    [    0.830000] Call trace:
    [    0.830000] [<(ptrval)>] load_elf_binary+0x744/0xf5c
    [    0.830000] [<(ptrval)>] ? __kernel_read+0x144/0x184
    [    0.830000] [<(ptrval)>] bprm_execve+0x27c/0x3e4
    [    0.830000] [<(ptrval)>] kernel_execve+0x16c/0x1a0
    [    0.830000] [<(ptrval)>] run_init_process+0xa0/0xec
    [    0.830000] [<(ptrval)>] ? kernel_init+0x0/0x14c
    [    0.830000] [<(ptrval)>] kernel_init+0x7c/0x14c
    [    0.830000] [<(ptrval)>] ? calculate_sigpending+0x30/0x40
    [    0.830000] [<(ptrval)>] ret_from_fork+0x1c/0x84
    [    0.830000]
    [    0.830000]  c1033dbc:       c1033dec
    [    0.830000]  c1033dc0:       c015258c
    [    0.830000]  c1033dc4:       c129da00
    [    0.830000]  c1033dc8:       00000002
    [    0.830000]  c1033dcc:       00000000
    [    0.830000]  c1033dd0:       c129da00
    [    0.830000]  c1033dd4:       00000000
    [    0.830000]  c1033dd8:       00000000
    [    0.830000] (c1033ddc:)      00001e04
    [    0.830000]  c1033de0:       001501fc
    [    0.830000]  c1033de4:       c1033e68
    [    0.830000]  c1033de8:       c0152e60
    [    0.830000]  c1033dec:       c129da5c
    [    0.830000]  c1033df0:       c0674a20
    [    0.830000]  c1033df4:       c1033e50
    [    0.830000]  c1033df8:       c00e3d6c
    [    0.830000]  c1033dfc:       c129da5c
    [    0.830000]  c1033e00:       00000003
    [    0.830000]  c1033e04:       00150000
    [    0.830000]  c1033e08:       00002034
    [    0.830000]  c1033e0c:       001501fc
    [    0.830000]  c1033e10:       00000000
    [    0.830000]  c1033e14:       00150000
    [    0.830000]  c1033e18:       0014ebbc
    [    0.830000]  c1033e1c:       00002000
    [    0.830000]  c1033e20:       00000003
    [    0.830000]  c1033e24:       c12a07e0
    [    0.830000]  c1033e28:       00000000
    [    0.830000]  c1033e2c:       00000000
    [    0.830000]  c1033e30:       00000000
    [    0.830000]  c1033e34:       40040000
    [    0.830000]  c1033e38:       00000000
    [    0.830000]
    [    0.830000] Code:
    [    0.830000]  c00047a4:       9c21fff8
    [    0.830000]  c00047a8:       d4012000
    [    0.830000]  c00047ac:       d4011804
    [    0.830000]  c00047b0:       e4040000
    [    0.830000]  c00047b4:       10000005
    [    0.830000]  c00047b8:       9c84ffff
    [    0.830000] (c00047bc:)      d8030000
    [    0.830000]  c00047c0:       03fffffc
    [    0.830000]  c00047c4:       9c630001
    [    0.830000]  c00047c8:       9d640001
    [    0.830000]  c00047cc:       84810000
    [    0.830000]  c00047d0:       84610004

Now we are also printing a bit of the stack as well as the code.  The
stack is output to help with debugging.  There may be concern about
exposing sensitive information on the stack, but we are already dumping
all register content which would have similar sensitive information.  So
I am going ahead as this proves useful in investigation.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 46 ++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 0446a3c34372..f2478bba77b9 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -46,6 +46,14 @@ void print_trace(void *data, unsigned long addr, int reliable)
 	       (void *) addr);
 }
 
+static void print_data(unsigned long base_addr, unsigned long word, int i)
+{
+	if (i == 0)
+		printk("(%08lx:)\t%08lx", base_addr + (i * 4), word);
+	else
+		printk(" %08lx:\t%08lx", base_addr + (i * 4), word);
+}
+
 /* displays a short stack trace */
 void show_stack(struct task_struct *task, unsigned long *esp, const char *loglvl)
 {
@@ -99,22 +107,36 @@ void show_registers(struct pt_regs *regs)
 		printk("\nStack: ");
 		show_stack(NULL, (unsigned long *)esp, KERN_EMERG);
 
+		if (esp < PAGE_OFFSET)
+			goto bad_stack;
+
+		printk("\n");
+		for (i = -8; i < 24; i += 1) {
+			unsigned long word;
+
+			if (__get_user(word, &((unsigned long *)esp)[i])) {
+bad_stack:
+				printk(" Bad Stack value.");
+				break;
+			}
+
+			print_data(esp, word, i);
+		}
+
 		printk("\nCode: ");
 		if (regs->pc < PAGE_OFFSET)
 			goto bad;
 
-		for (i = -24; i < 24; i++) {
-			unsigned char c;
-			if (__get_user(c, &((unsigned char *)regs->pc)[i])) {
+		for (i = -6; i < 6; i += 1) {
+			unsigned long word;
+
+			if (__get_user(word, &((unsigned long *)regs->pc)[i])) {
 bad:
 				printk(" Bad PC value.");
 				break;
 			}
 
-			if (i == 0)
-				printk("(%02x) ", c);
-			else
-				printk("%02x ", c);
+			print_data(regs->pc, word, i);
 		}
 	}
 	printk("\n");
@@ -185,13 +207,11 @@ void nommu_dump_state(struct pt_regs *regs,
 	printk("\nCode: ");
 
 	for (i = -24; i < 24; i++) {
-		unsigned char c;
-		c = ((unsigned char *)(__pa(regs->pc)))[i];
+		unsigned long word;
+
+		word = ((unsigned long *)(__pa(regs->pc)))[i];
 
-		if (i == 0)
-			printk("(%02x) ", c);
-		else
-			printk("%02x ", c);
+		print_data(regs->pc, word, i);
 	}
 	printk("\n");
 }
-- 
2.31.1

