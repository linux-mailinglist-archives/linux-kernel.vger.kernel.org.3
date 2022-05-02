Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8A051773B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387059AbiEBTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387044AbiEBTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:17:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F48E1E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:13:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso143183837b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=NecAjaKo6a145Hd4bQjyaTWZfIjyHs70zkocfLAKQSs=;
        b=QVB6MW5tJEeXEtBnaqj+68WPwqmSC0IDheiS7ttyTWBXJheFxYJ7C/cvodMmjalP5S
         vgZ+25BOK1Vt3B+UC80FJgGZdJxmILirm2qIWWMzqQF9btkic9cKsZ4U90LlRJKgOIQb
         OrTHHTjrX2SGtENn6w3FoHexOsjv2+FfLK1KiMDV/DFHYvlaEcbXAMk9Uha4wZsMlT57
         r3Qm38iqI4B/e8OLYePe0sEmEzTlEV4o1W4+PTuBcWIQ9QCFi9NQMtRyR9gXalxyZAsd
         L8fbI+dfQxvDWPmAQbezRSSCqwvyOACkyZSwVL6lKIEY19fxQPrqDUQjvTJeSh4cKII1
         /WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=NecAjaKo6a145Hd4bQjyaTWZfIjyHs70zkocfLAKQSs=;
        b=PEUOph0hD3lsNS+JZd38RRnVN8qEGZdcnCD2j1OadUJEp3glL/eONqzDvFtlswBxkH
         JavdpfJrq/qAYIVNYwJ2FIgiNn4z8gHdbWElRHtNjOAms2jBrCDXJFEWcu9IRIeue+R0
         nFlxeTTkZdIvhv+7TZ9Zk57TrAoRhKmZADFr0vPsGrPqBp8x3sirpFZdJFDxqwR40mKZ
         BXRrQHzo8d+rcfwOjJr6avsxmYFPKzyasLz2L46mGD7Qdv5ykacNpQwY7ohH0q+XEPQ0
         ErBCMK5/iwcB0v15VxfEmDRXuIWvJXzpOR87jY2EeN0dhxQWboFtHRuSib2iKC0uxOM/
         8VwQ==
X-Gm-Message-State: AOAM530I4wQy+GnGK/6IiqVcgMvWz5SJKvop8Rkb6dVu/ddfH68pXy5q
        kR/Ihr5bb+7hftpiKbj3IYwPzjEYT3xPMDgcmA==
X-Google-Smtp-Source: ABdhPJx8M1O6z1nhK+MdMqqpss40uQyyOjlwfPNkVGWLfomVVPIxF8Rydp8wjn3kM3vkNvKVXWoWNEL5hggFgOkzAg==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:55c:7548:7073:c14f])
 (user=kaleshsingh job=sendgmr) by 2002:a25:7243:0:b0:649:1be0:5061 with SMTP
 id n64-20020a257243000000b006491be05061mr11146766ybc.597.1651518828253; Mon,
 02 May 2022 12:13:48 -0700 (PDT)
Date:   Mon,  2 May 2022 12:12:03 -0700
In-Reply-To: <20220502191222.4192768-1-kaleshsingh@google.com>
Message-Id: <20220502191222.4192768-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220502191222.4192768-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v2 3/5] KVM: arm64: Add hypervisor overflow stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, will@kernel.org,
        maz@kernel.org, qperret@google.com, tabba@google.com,
        surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        Andrew Jones <drjones@redhat.com>,
        Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Keir Fraser <keirf@google.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate and switch to 16-byte aligned secondary stack on overflow. This
provides us stack space to better handle overflows; and is used in
a subsequent patch to dump the hypervisor stacktrace.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/kernel/stacktrace.c | 3 +++
 arch/arm64/kvm/hyp/nvhe/host.S | 9 ++-------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index a84e38d41d38..f346b4c66f1c 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -242,4 +242,7 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 
 	unwind(task, &state, consume_entry, cookie);
 }
+#else /* __KVM_NVHE_HYPERVISOR__ */
+DEFINE_PER_CPU(unsigned long [PAGE_SIZE/sizeof(long)], overflow_stack)
+	__aligned(16);
 #endif /* !__KVM_NVHE_HYPERVISOR__ */
diff --git a/arch/arm64/kvm/hyp/nvhe/host.S b/arch/arm64/kvm/hyp/nvhe/host.S
index 09b5254fb497..1cd2de4f039e 100644
--- a/arch/arm64/kvm/hyp/nvhe/host.S
+++ b/arch/arm64/kvm/hyp/nvhe/host.S
@@ -179,13 +179,8 @@ SYM_FUNC_END(__host_hvc)
 	b	hyp_panic
 
 .L__hyp_sp_overflow\@:
-	/*
-	 * Reset SP to the top of the stack, to allow handling the hyp_panic.
-	 * This corrupts the stack but is ok, since we won't be attempting
-	 * any unwinding here.
-	 */
-	ldr_this_cpu	x0, kvm_init_params + NVHE_INIT_STACK_HYP_VA, x1
-	mov	sp, x0
+	/* Switch to the overflow stack */
+	adr_this_cpu sp, overflow_stack + PAGE_SIZE, x0
 
 	b	hyp_panic_bad_stack
 	ASM_BUG()
-- 
2.36.0.464.gb9c8b46e94-goog

