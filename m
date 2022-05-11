Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B272522D51
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243036AbiEKH2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbiEKH2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:28:07 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAF3D483
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:28:00 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so1052736plg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=hOL2SmGEKUuNpF8//yrIHyFyW9QpHj5EcEyqSlL2j5Ss2Kk637E+sdDr1ipujizSp6
         mBs3ISgZQuqdAdu6OMZ75YBdnojiygEvrhyLm+fc2iZzRtk4RIIOEbmWSMxqSmzEJ6iu
         9mpCShLthHzj8HAPNuuxT5t9pJU5mrD9R70FEwFrqI+jpZbyrbhS/F9XNccIhoi7zerA
         qQwXXC5zyn6Q42wm1x+zxTMSLFzjR4NIBGUmXDMwlT7zDPQcWsWqPmllg0KrINWZE7Hh
         V3iBAJED+kr+y055flPWxxW2ORJHzR62PfxEpXLilu7+dZkR2JTPP+fr0ooi5+Up7Czy
         P7gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gkGEhy3VfxaC6VD1+0Znm8PQRe5Rv1gv7lzNV+9U6sU=;
        b=Eys4qDuBve7Qtgo/wCyWHnNzLu56oqPeegFAisMbeN62YUA8wbiho7astHTK21NiPs
         7UrRmdIc3aVQo5DT8BBDUC08STEpuppiiAoQ4nRHHfWjkrpaXQPSPQUXnSdOAleIKcXD
         5aU084/FuQ1P2fFdoO3t4d1Sp9gLrZ+RRq4sqsaYAcMhx8NO39hugvq8JnvY9/2n6bJ6
         Kw8moap5DFiAb5eyfA/FC/nysdbuMylIeNyFo/o63vcuohpKQeSICoLUShCcYLLApsvA
         BHeZ4ILftsIJ042N9O/DpYBmL4wpKUUgm+YBdyfpvkn9SxprebS2OXcuodI/XlBNLR9F
         VfQg==
X-Gm-Message-State: AOAM530jJBuFsqFtSvrgNgxqE0cGRY6Mu7/CIJwpAr+9Mjxivlo50EE8
        mhz7Dy/YmznRyway2kGxwz0rpGUH/To=
X-Google-Smtp-Source: ABdhPJyiupD//7dRtmU1nOj1/+hIdK289hdKppc2VOXLd8W9IyHJRVmAo9TXo3zE35ecQWZRa1cRVA==
X-Received: by 2002:a17:90a:ec0e:b0:1d9:7f4d:23be with SMTP id l14-20020a17090aec0e00b001d97f4d23bemr3883921pjy.181.1652254080230;
        Wed, 11 May 2022 00:28:00 -0700 (PDT)
Received: from localhost ([47.251.4.198])
        by smtp.gmail.com with ESMTPSA id be12-20020a170902aa0c00b0015e8d4eb1e4sm954269plb.46.2022.05.11.00.27.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 00:27:59 -0700 (PDT)
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
Subject: [PATCH 6/7] x86/traps: Add fence_swapgs_{user,kernel}_entry() and user_entry_swapgs_and_fence()
Date:   Wed, 11 May 2022 15:27:46 +0800
Message-Id: <20220511072747.3960-7-jiangshanlai@gmail.com>
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

