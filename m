Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21003528526
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243914AbiEPNRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243837AbiEPNRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:17:32 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD6B25C4E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id a23-20020a17090acb9700b001df4e9f4870so2809620pju.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=of3+wHvtm7eRVXWa+Ssr07ZyY84NwEb7ZN+SI2YphvMQkh5Q6DMlZeg/uxDg47EY83
         x428ZDTLZKQ/JOyZzXK2F/0z/CEJaLRKEXu1z4Kp0R3ibMrbEqSu4K7/xvGc4qw9dmHg
         3vJWXTpA5NVtaDb68jsFDUbzEDZOR0MbLGTJNH/7IrnJ9j0e8BmVs1gnoQfH69KHY7cV
         r0voCpvUFYk565pzY6cjTN6cHjci+46jXO//xZiKCdr3lxCIfSSbAACDbgUqfkWhlh3L
         C4QqZDRPllBJp0JiDiS9HAx3zSplCO5csXcIPlw+XufRp0B20aMsYcYcuL8LCe7eGGFn
         7Ozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=TfplgPhccZ8SjMbC6+Hsjyv/+b5s138UnpuJiW6t63BcxGlUvfbL+VacxKmu0t6/ep
         KwvVd+0N52M2QkxBlOgthtwABJG3S80ALQVbyD2jUztnJd25w5Kh6WvYg3ln+8Eg4MW1
         ETRyApiPzAnrbiUrxUqE0EtVBNP5UlK2t+42pB021yPU+B3fKn4KmDld3bNslhhWJTxd
         95n9elEtTlJHA5coMcmn114wAidvKTFVxbItmx21WwmT4sAK1M2ltBKqzXpH1HdlR7gf
         TuiMgJOp/xxaQVoVWiiayiCD98PZh1fmEP3FV4ZcmyV64o6pL3T29bTbvzUvGmCILOXO
         T6Qg==
X-Gm-Message-State: AOAM531YklkF9KhymQrcFE2ljCv6s2coTbo0ou3mOw3GT+TFiDuDpwgy
        IcP64bhF+J/IvUqOH+ea1dcfrfBnGoY=
X-Google-Smtp-Source: ABdhPJzIwhoAisiSVova9GP69StXH0dNk+cuV4VhXpQPNnlVcWeJoIRuRDpe9n+thmw2voMmSV5w0g==
X-Received: by 2002:a17:90b:1752:b0:1df:2f90:87ee with SMTP id jf18-20020a17090b175200b001df2f9087eemr9664856pjb.94.1652707043596;
        Mon, 16 May 2022 06:17:23 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id y124-20020a62ce82000000b0050dc762812bsm6859188pfg.5.2022.05.16.06.17.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2022 06:17:23 -0700 (PDT)
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
Subject: [PATCH V2 6/7] x86/traps: Add fence_swapgs_{user,kernel}_entry() and user_entry_swapgs_and_fence()
Date:   Mon, 16 May 2022 21:17:37 +0800
Message-Id: <20220516131739.521817-7-jiangshanlai@gmail.com>
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

