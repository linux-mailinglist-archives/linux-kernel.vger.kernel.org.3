Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE0F53EB36
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbiFFOpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiFFOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:44:55 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2AD26543
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 07:44:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id y187so13090525pgd.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=XJm7qKD2bOT58RQ97zCn/zWbGHjdyy77P5xi96N2i7a9i8tTiEn3+2Panyl6bkL0K2
         xda6xnU78lpVlW2JjeD3Vn/7rouIulCAg4Y9duaPAhKbDdqe3FSwZnjuNZ8T5Fu4aGHG
         0TLfDpYoeKYfB2D9JSICOzPOdue57TP6Dbf0iM8FPbdQ7qGKqhmTPOwBPheewKwpdN8e
         rJgsLR3GpJuL5WOrsi3uJrQ72lkyiyzlXEOyuFawixOKPgiqVRWHm6UFLbTb0RpHYs/7
         bshgQln3hBIa2J2CM3dRE1XjwKOLOxgoZSIsuReh0RjdRmDIxYHs2VxcLR12FcQBXEcT
         KEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=Y+AUCXyktJn8jkcs7sIZF7z+jN1njwKr1jZ53MObRpS65elNDlY8PRyWKKpylC8eAP
         WCmEdSEEP4RozvJfr+Isr1/n/Kgcg8ew1zi25ZfkXo3z/wUws2zOrRxFVYUFbQH9NRta
         +ULBZ4TKMkrobkfnu6vlGC3NuLid87sURTGFFuhrc2TqX1nIxrqN2Znh+9lSDZXZA4b5
         +HoUG2DHdKh4k8cTlv3L41fyqn9xwiCNuE/6OhHGps/b7kZVQNJg1IVu3B8LWNs4Hu7j
         aMOpNxt0HAVMKTlKnGvn4NxfK+5mUmXbWHKFiCf70HQKcBwRBIky4wh6OnMn91ZoFiea
         zCdg==
X-Gm-Message-State: AOAM532iKzZOCahq52cGrcjm2UR4rbl7CWqj2reMCct/hX4W2TlaqxcN
        Ae4oerKekH3YZFNulsp94nNn8PDTcdw=
X-Google-Smtp-Source: ABdhPJwHtzCg5kFnUiWNadbeSw965fhqP0DNjV0hekDkRGPaONCqQVXORVETWVV98temea8+zvNgdw==
X-Received: by 2002:a63:5a58:0:b0:3fb:b455:ed15 with SMTP id k24-20020a635a58000000b003fbb455ed15mr21332437pgm.228.1654526691026;
        Mon, 06 Jun 2022 07:44:51 -0700 (PDT)
Received: from localhost ([198.11.178.15])
        by smtp.gmail.com with ESMTPSA id y125-20020a626483000000b0050dc76281d3sm7606451pfb.173.2022.06.06.07.44.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jun 2022 07:44:50 -0700 (PDT)
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
Subject: [PATCH V3 6/7] x86/traps: Add fence_swapgs_{user,kernel}_entry() and user_entry_swapgs_and_fence()
Date:   Mon,  6 Jun 2022 22:45:08 +0800
Message-Id: <20220606144509.617611-7-jiangshanlai@gmail.com>
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

Add the C version fence_swapgs_{user,kernel}_entry() in entry64.c which
are the same as the ASM macro FENCE_SWAPGS_{USER,KERNEL}_ENTRY.

fence_swapgs_user_entry is used in the user entry swapgs code path,
to prevent a speculative swapgs when coming from kernel space.

fence_swapgs_kernel_entry is used in the kernel entry code path,
to prevent the swapgs from getting speculatively skipped when
coming from user space.

Add the C user_entry_swapgs_and_fence() which implements the ASM code:
        swapgs
        FENCE_SWAPGS_USER_ENTRY

It will be used in the user entry swapgs code path,  doing the swapgs and
lfence to prevent a speculative swapgs when coming from kernel space.

Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 arch/x86/entry/entry64.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/x86/entry/entry64.c b/arch/x86/entry/entry64.c
index bd77cc8373ce..f7f23800cee4 100644
--- a/arch/x86/entry/entry64.c
+++ b/arch/x86/entry/entry64.c
@@ -36,3 +36,33 @@ static __always_inline void switch_to_kernel_cr3(void)
 #else
 static __always_inline void switch_to_kernel_cr3(void) {}
 #endif
+
+/*
+ * Mitigate Spectre v1 for conditional swapgs code paths.
+ *
+ * fence_swapgs_user_entry is used in the user entry swapgs code path, to
+ * prevent a speculative swapgs when coming from kernel space.  It must be
+ * used with switch_to_kernel_cr3() in the same path.
+ *
+ * fence_swapgs_kernel_entry is used in the kernel entry code path without
+ * CR3 write or with conditinal CR3 write only, to prevent the swapgs from
+ * getting speculatively skipped when coming from user space.
+ *
+ * user_entry_swapgs_and_fence is a wrapper of swapgs and fence for user entry
+ * code path.
+ */
+static __always_inline void fence_swapgs_user_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_USER);
+}
+
+static __always_inline void fence_swapgs_kernel_entry(void)
+{
+	alternative("", "lfence", X86_FEATURE_FENCE_SWAPGS_KERNEL);
+}
+
+static __always_inline void user_entry_swapgs_and_fence(void)
+{
+	native_swapgs();
+	fence_swapgs_user_entry();
+}
-- 
2.19.1.6.gb485710b

