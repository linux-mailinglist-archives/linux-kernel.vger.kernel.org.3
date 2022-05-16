Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEDA528525
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbiEPNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEPNRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:18 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97E24F09
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:16 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q7so2992763plx.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4unt6PUqjlwmajoQtsGt030sfPAmI7QPMB4lAchbRI4=;
        b=AtmXzsFGqnR9c5Cs0M9H4ANTDWzVo0obhDx0Byxa/U6YpWizVKa64Iyqt2EGiClRA+
         VLHNoXr2zYdMbeG+dU1n75jWCTjmDEby6oF15oiNKVSyOQsQBIOv9179Sd57GBD/6gx+
         WOwix/VT5awLCufz/3lzPSWxGDK2/V4UGQm2BWdHtl2oIgQcWkQqZV6l0/E0pLwD9YqN
         6zaQpTIobz5M4XsfAjAmZpHRmISGMjvdtx3pp3y0DoujWLw+9RTkuVDr3bHhIFguxwoe
         Y9LSykPz410ggoe8WN3imLkqwY0tzyfm35UqPNRzMYj1m50tEo1e42pgRM/A4mFKBG/c
         tdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4unt6PUqjlwmajoQtsGt030sfPAmI7QPMB4lAchbRI4=;
        b=7zzBQjJEeqruWRetr2F8FiJWRFMDweEcdkisvkWrQ/t+DN3KEWSsMfMPoej7kMT77h
         6u5zpwO+FmaSM+l5kX3f1RqRoZpG0TUoVDHLA4ijUm4kULuYPFj0rf3ooPtgyaSqPnGl
         dlumtgKWem4zbBp2b6e7NTq6c/8iGYCRFWZ9CMh6puumICdFqVw+RBl0wl+R/DGxR7GQ
         vUeGfgUvskzsVvg3JRZxEC56KxNvkxYZjmgbT7rLUmVUa/dmnoIfQlCJtt5fsuwlHyvc
         T/KcaqEi1+AU7FQS6iJvhEia+3tsTurVH5FFBGl/vfYCQ7GtqDXHFL79XRwst0T3PB6B
         5bfA==
X-Gm-Message-State: AOAM530mDLdKTduazN1hI6ChCvtduk3RKe8zkOCESozPgEFICv9pDSRn
        jXCgKTItrEpTbclUBC+ZP+GOZHrQ9oY=
X-Google-Smtp-Source: ABdhPJzXUfHg9ffsepRbRBo3K6rwEtxQYoA51K6uUH6LeR9NHvspfUO4WDKkZ4vtn71tgPToZp3Lug==
X-Received: by 2002:a17:902:e80d:b0:15e:b27b:931c with SMTP id u13-20020a170902e80d00b0015eb27b931cmr17637053plg.5.1652707036218;
        Mon, 16 May 2022 06:17:16 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id a12-20020a170902900c00b0015e8d4eb1ddsm6990682plp.39.2022.05.16.06.17.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:16 -0700 (PDT)
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
Subject: [PATCH V2 4/7] x86/entry: Add arch/x86/entry/entry64.c for C entry code
Date:   Mon, 16 May 2022 21:17:35 +0800
Message-Id: <20220516131739.521817-5-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220516131739.521817-1-jiangshanlai@gmail.com>
References: <20220516131739.521817-1-jiangshanlai@gmail.com>
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

