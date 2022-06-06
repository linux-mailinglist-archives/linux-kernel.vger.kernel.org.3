Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59FA53E765
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239993AbiFFOot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiFFOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:45 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E646750455
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:43 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a10so12983162pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4unt6PUqjlwmajoQtsGt030sfPAmI7QPMB4lAchbRI4=;
        b=NTfisVuYf6vYip3A6oX/MtlyiOevTjc09L/PPyG1XEp9uKlhU2KdJP3HX7Z9A7j2kU
         Axic04KC7h61W3hKt9ubEiMliDseLMGQX9su3bO3oO12PbhU8u9n/KQxY5TMDEMJfPPV
         pZskzj9G1d75GXBTlQx/2LKlBRUs9ycTX3pDERNcrz3zs3kFwWM3vKqEb0eRfnPKcjZb
         CxcVrKkRXdZ9OSesmTiJtMM41eA6wZ7wRRUnpqqR55FCd9K8IOhBjG+yM8dOQTgTj6rn
         7DN/bPNAmSc2oanW8TKkOKur5wQXG2M+CgUZJCSI8wdZcRyETB3GWLlqSDINvwfitYu2
         NK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4unt6PUqjlwmajoQtsGt030sfPAmI7QPMB4lAchbRI4=;
        b=T0sWWtNIpb7k+QerVSYrV6FpZGAQxz4ONNISKYUKWQ2d5VTQQPtDf7Bj0+PW4TspPi
         ocMqSmOadf1gRHChDXIoEmFxN/YEvGpxfCVHhnNIfnOjsYPHrIFIdhkokfdzdDudQPa4
         I+kMkgwwv/BbrUkjlaSwazw0eJuVaSyLQcyhoUphwelnH23aq3yKR9hB0vTXsgoTw7KO
         JxVp1RuoJxbf7DrHTCkbTwpA6bC8WMTWvLRxF7UWSPcglHr63p4Yd5Lj0OIBkJNdGici
         kwbMXN0tDt97MRJqpiXUUsC5zeJmHiZTdJfIXdw3Ny2+pxEuruIE4XQ2D8HmjSOH4nYS
         1OAw==
X-Gm-Message-State: AOAM533putVJAb+3im4EO7O5LlSynTFVxDMwYfgO+Xqe1NMQAZda5YDz
        5sUjhuaVVs8x0Tn9Oei7wG+HTgHupMI=
X-Google-Smtp-Source: ABdhPJxA1hqQGmk44f5+1g/UktQNwXxazNTajiocBnQlcpf7qSvFY3fXZhU05jEne4jYVkuUdbUC/Q==
X-Received: by 2002:a17:90a:6747:b0:1e6:6a5b:f040 with SMTP id c7-20020a17090a674700b001e66a5bf040mr29353109pjm.134.1654526683263;
        Mon, 06 Jun 2022 07:44:43 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id g196-20020a6252cd000000b0051b9e224623sm11394200pfb.141.2022.06.06.07.44.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:42 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH V3 4/7] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Mon,  6 Jun 2022 22:45:06 +0800
Message-Id: <20220606144509.617611-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220606144509.617611-1-jiangshanlai@gmail.com>
References: <20220606144509.617611-1-jiangshanlai@gmail.com>
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

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Add a C file "entry64.c" to deposit C entry code for traps and faults
which will be as the same logic as the existing ASM code in entry_64.S.

The file is as low level as entry_64.S and its code can be running in
the environments that the GS base is a user controlled value, or
the CR3 is the KPTI user CR3 or both.

All the code in this file should not be instrumentable.  Many instrument
facilities can be disabled by per-function attributes which are included
in the macro __noinstr_section.  But stack-protector can not be disabled
function-granularly by some compliers.  So stack-protector is disabled
for the whole file in Makefile.

Suggested-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/Makefile  |  3 ++-
 arch/x86/entry/entry64.c | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/entry64.c

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index 7fec5dcf6438..792f7009ff32 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -10,13 +10,14 @@ KCOV_INSTRUMENT := n
 CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_entry64.o		+= -fno-stack-protector
 
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
+obj-$(CONFIG_X86_64)		+= entry64.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
-
diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
new file mode 100644
index 000000000000..ace73861c2a0
--- /dev/null
+++ b/arch/x86/entry/entry64.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ *  Copyright (C) 1991, 1992  Linus Torvalds
+ *  Copyright (C) 2000, 2001, 2002  Andi Kleen SuSE Labs
+ *  Copyright (C) 2000  Pavel Machek <pavel@suse.cz>
+ *  Copyright (C) 2022 Lai Jiangshan, Ant Group
+ *
+ * Handle entries and exits for hardware traps and faults.
+ *
+ * It is as low level as entry_64.S and its code can be running in the
+ * environments that the GS base is a user controlled value, or the CR3
+ * is the PTI user CR3 or both.
+ */
+#include <asm/traps.h>
-- 
2.19.1.6.gb485710b

