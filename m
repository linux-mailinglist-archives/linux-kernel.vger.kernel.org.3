Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10CDB587236
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbiHAUQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbiHAUPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:15:55 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62314E4D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 13:15:12 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id mk9so6484065qvb.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 13:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YzbZWPC/awXZhFf2xsAbUtlwN59iYpbiuewriSD+EsE=;
        b=3+GZNArbYFpKf5Fywb/ATh5UrloxFjVRTkkdYUWQvEJsXJ+adhKxb/tGhlOyIyHOsH
         Zcd71UbGZR3g7+p2PVC8CmlZJNGhJegmPoAGVb2B1uH9mtRma5NvKV3qnnr9mKP8rHMG
         3Yn8p/tUgs/6NYHR1cP0fKJQeiSWuljH3681EnVzrcSIPgwdgUry9e4qyzlLsSjEbWgl
         g4mXB7Tc8ccDhJuEdi4JMhRYSyVOYdkkwQGLnqJy0mvRMcRo0THxaS1XlBpSiAmsi3PM
         LUnPl3hStWKj/VJCMWwhD3y7M3xrS1qN640z0JYbn2dCXZOmgYFSRKA76DXHbhEsnlIu
         kNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YzbZWPC/awXZhFf2xsAbUtlwN59iYpbiuewriSD+EsE=;
        b=4cuOCnZsc16vlS8xAeWg2XFZLJpllmIEtkUHsRb77XA235Caxfwkm9ZXcKbktnF9f9
         XZeHDOB8h7jfwappX52wHTnPsL6Zy7lxZ2yxoTMZHet2UVDf2cz7bviEHH9wnVfNNyJa
         VdNWPWYQI24gwIYaa1+9DHUY612Nlm6YwbDqrcAPPuxhlj9ReFO4apfz4nSDD37MQP3y
         bp//gEaURtcaUhC2FyK/UqYvFv0P1+t5p9eY7LoPnIbW8IA+vgFDQ9sUqvGLHHwXzOPO
         RCc8A1LseYhLXIRKfsUP6LOkxi2MjeGswhtNTcKsDh5fERhBN98pLFYL/rOT3RMUZZbl
         c3Vg==
X-Gm-Message-State: ACgBeo19o6ZZCKCnzgr/JCGVpRXJQZZ/ucizx9c8ceuLj1bRu30GWKFD
        AgCNvc8NWKG+mxxYmqUNG6AouQ==
X-Google-Smtp-Source: AA6agR7hDeg6lfiUq3q/202VwtcKoJvdC+JD6ptmlxHXn+2QC5RguPk64Lh2T0Inl/nSyYlVtYGvBw==
X-Received: by 2002:a05:6214:2b0b:b0:476:cc01:93af with SMTP id jx11-20020a0562142b0b00b00476cc0193afmr2334899qvb.56.1659384911484;
        Mon, 01 Aug 2022 13:15:11 -0700 (PDT)
Received: from hefring.. ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id r20-20020a05620a299400b006b59ddb4bc5sm9288317qkp.84.2022.08.01.13.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:15:11 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
X-Google-Original-From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Cc:     Ben Wolsieffer <Ben.Wolsieffer@hefring.com>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: v7m: support undefined instruction hooks
Date:   Mon,  1 Aug 2022 16:13:39 -0400
Message-Id: <20220801201347.1255392-3-Ben.Wolsieffer@hefring.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220801201347.1255392-1-Ben.Wolsieffer@hefring.com>
References: <20220801201347.1255392-1-Ben.Wolsieffer@hefring.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call the common ARM undefined instruction handler, which handles running
hooks to enable ptrace breakpoints and other features.

Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
---
 arch/arm/include/asm/traps.h | 2 ++
 arch/arm/kernel/traps-v7m.c  | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/traps.h b/arch/arm/include/asm/traps.h
index 987fefb0a4db..e4253f4a86e1 100644
--- a/arch/arm/include/asm/traps.h
+++ b/arch/arm/include/asm/traps.h
@@ -19,6 +19,8 @@ struct undef_hook {
 void register_undef_hook(struct undef_hook *hook);
 void unregister_undef_hook(struct undef_hook *hook);
 
+void do_undefinstr(struct pt_regs *regs);
+
 static inline int __in_irqentry_text(unsigned long ptr)
 {
 	extern char __irqentry_text_start[];
diff --git a/arch/arm/kernel/traps-v7m.c b/arch/arm/kernel/traps-v7m.c
index 5fd9943448e9..b324499e1010 100644
--- a/arch/arm/kernel/traps-v7m.c
+++ b/arch/arm/kernel/traps-v7m.c
@@ -20,6 +20,7 @@
 #include <asm/linkage.h>
 #include <asm/ptrace.h>
 #include <asm/system_misc.h>
+#include <asm/traps.h>
 #include <asm/v7m.h>
 
 enum fault {
@@ -49,7 +50,6 @@ static const struct exception exceptions[] = {
 	{"no coprocessor",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_NOCP,		SIGILL,		ILL_COPROC,	UDBG_UNDEFINED},
 	{"return to invalid PC",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVPC,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
 	{"invalid ISA state",			FAULT_USAGEFAULT,	V7M_SCB_CFSR_INVSTATE,		SIGSEGV,	SEGV_MAPERR,	UDBG_SEGV},
-	{"undefined instruction",		FAULT_USAGEFAULT,	V7M_SCB_CFSR_UNDEFINSTR,	SIGILL,		ILL_ILLOPC,	UDBG_UNDEFINED},
 	{"floating point state error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_LSPERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
 	{"exception stack push error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_STKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
 	{"exception stack pop error",		FAULT_BUSFAULT,		V7M_SCB_CFSR_UNSTKERR,		SIGBUS,		BUS_ADRERR,	UDBG_BUS},
@@ -95,6 +95,12 @@ static void traps_v7m_common(struct pt_regs *regs, int fault)
 	writel(hstatus, BASEADDR_V7M_SCB + V7M_SCB_HFSR);
 	writel(cstatus, BASEADDR_V7M_SCB + V7M_SCB_CFSR);
 
+	if (fault == FAULT_USAGEFAULT && cstatus & V7M_SCB_CFSR_UNDEFINSTR) {
+		/* Handle undefined instruction hooks */
+		do_undefinstr(regs);
+		return;
+	}
+
 	for (i = 0; exceptions[i].name != NULL; ++i) {
 		if (fault != exceptions[i].fault)
 			continue;
-- 
2.37.0

