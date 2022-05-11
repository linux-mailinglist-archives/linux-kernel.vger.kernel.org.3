Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4CB522D4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbiEKH14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbiEKH1w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:27:52 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911473AA7E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:50 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 31so1050255pgp.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TdTLtLMgpiAme8Im7kZEk/uGXhOybjozcq+A7lmpHwg=;
        b=pvxV6K/xSiTVa9ouO64Cucp0uIhtHSTkom5BcnoiAqnJbB6ZJM9EK6bsCZya40wO9u
         yIyF6ffIgXHGT8WhsRTBuHt1Q+wl6TRs+G84OsLjn+NYynhjPwYTShUNp4caTwUPfEX2
         J2VnIsA/OIpu4Xx9ncex06m0trvedxBr3Eh3xjpHqmyDsVFFaAJoZxBiq5N6w4ttoEpB
         Z5KVmG1nQnJ4L/XmIMnHTQSywz9rVsCbio+A9JF98Je/VWiknZZCnYbt1FKExyikMmhZ
         5en1vydKM8h4FAXvfU2qO7luR05jrQ/JModUp4yPOwXTDQXDnkO16XkgqFkdyQGKCdrq
         XoQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TdTLtLMgpiAme8Im7kZEk/uGXhOybjozcq+A7lmpHwg=;
        b=M4L7wc/VbReRj4+EZXq+JSanhM9GCW2xdq45wFWpmay115ZOUItbISU701d2D+1xSV
         +5nHT6V2YhAlhv1i8d2yocgLjeQNzqiLSVT2UnVQsuukplu6lr1NktUL0iwOVbg21z6X
         sjJR88EjEHJ/NaQljUTlUQWZf1X4m2CaAvb8Ju5HGuNBkx12Do8bnTkJfvgH+DBFdhPM
         MitiN2h9WpiVncZW0TS4M8x1vnmzPDR+Mb1gt0w7YN7+wqNxQha0kdKYLM5ZRfsc/LdZ
         cjQ2MFMA78ONLqWrFgNycEEcKTkTmoIdTBcKNe7qlsnvdqP6bV77+Qd1zKpHm9N2XNR/
         5ZJA==
X-Gm-Message-State: AOAM531IV37LdZFC+DX+Cy8cx7YBiPvQvNpfZkldErn/2eUgo98P7+CD
        EcAJ1MoyqBYvJiAGJe9AG0Juf4RlCtg=
X-Google-Smtp-Source: ABdhPJxhuWB4xSn8IVNoHnxsY9u1CPBfaXXhRAQrRzX+MginwFsfHYkQKLdClr1S8jOscXPq0b9Qzw==
X-Received: by 2002:a65:6e47:0:b0:3c6:7d47:ddc8 with SMTP id be7-20020a656e47000000b003c67d47ddc8mr15078467pgb.157.1652254069888;
        Wed, 11 May 2022 00:27:49 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id h17-20020a635311000000b003c14af505f8sm982033pgb.16.2022.05.11.00.27.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:49 -0700 (PDT)
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
Subject: [PATCH 4/7] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Wed, 11 May 2022 15:27:44 +0800
Message-Id: <20220511072747.3960-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220511072747.3960-1-jiangshanlai@gmail.com>
References: <20220511072747.3960-1-jiangshanlai@gmail.com>
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
in __noinstr_section.  But stack-protector can not be disabled function-
granularly by some compliers.  So stack-protector is disabled for the
whole file in Makefile.

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

