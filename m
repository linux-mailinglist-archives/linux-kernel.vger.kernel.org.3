Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9A4BFF67
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbiBVQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiBVQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:56:30 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604A116BCF5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:56:05 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d61b4ef6cdso145981507b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=R7NUgyhmz2Vzm1IbfrrDYD1qNpQGYjcjDbFVXUaMLH8=;
        b=KI3O3p6WIXcE6n5c1xlRqNCzstNa7C+hluEFjVsr0MOzveDFLD2VUOGSWGeKG0RHJy
         T/yqV6+ri+p/3rX+b1pYMjSNo3Ovj9yyZbKA1607HqCA3kbya8vyKQ2GDgWlYG9l1znh
         rWdySSjzOH0K6sfRsXIWIRMQFAHMD5jl44ausSef3FnfQgFOmyhWcQwfQoMj6etEc/LI
         hJHRQ66bszx5zigZGXaE9ntUDiXKmNtjFdm5S5h0xTnO2PAF2yNKcyiTDlX9Dq5Ziu1q
         t3RdfNDzIKa7Bq1TCGBRbeYsC4mW70m5JWLL7NBzuv6XS1rF0YDiOJcHIe7I88ZhGfi5
         7YDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=R7NUgyhmz2Vzm1IbfrrDYD1qNpQGYjcjDbFVXUaMLH8=;
        b=5pCIMjBHoSmDnMdhJCa9qPw4/phSfhou2ejPaTQbYvBvjD8oexTgTklZ5EsHOCrrLE
         jboPtOVHi8hHCkUJsmE7kM6oU8imr00nHtQGKigOnolY/eXVH/e5GXUtHC4FM+b5ZFrP
         cv/EhWU7teJrZJW++CKnNBPlbbYORnPejUbR9epRnPZ8onCFuCw9AMkfjLX01eVYosm7
         /r1oyglsnK57OiGYfhrGvqtD6FugIzN0pLKWHvD4FcewLhLcbn19gkYPuCVAOUQHlA5F
         5zYXe4G6AxXPEMsL2bEit+Mje57RUmI0s7uKw/BXyTEDEAoJ/pY/6NQ3sRgxXUeWoZjm
         UYOA==
X-Gm-Message-State: AOAM53186SQ2x/v/TWXkEmnGuJre0+hiBk1jutePYuPU8FFfSYCo1PPW
        LmjBESxkzZgUva0ICIh9O+ikF4NOIHWvjCqAlg==
X-Google-Smtp-Source: ABdhPJzj4uTOWudxzzJokeTZXJ0Xc+OcxmAl9Nm7IKWdiyC4Dj/qqu6z+Dkz3NZLlc5P6ZEzL8Pz6NCeaRU6Ltd2cA==
X-Received: from kaleshsingh.mtv.corp.google.com ([2620:15c:211:200:5db7:1235:b3dd:cfcb])
 (user=kaleshsingh job=sendgmr) by 2002:a05:6902:ca:b0:5ff:5f2d:b533 with SMTP
 id i10-20020a05690200ca00b005ff5f2db533mr23967292ybs.606.1645548964571; Tue,
 22 Feb 2022 08:56:04 -0800 (PST)
Date:   Tue, 22 Feb 2022 08:51:04 -0800
In-Reply-To: <20220222165212.2005066-1-kaleshsingh@google.com>
Message-Id: <20220222165212.2005066-4-kaleshsingh@google.com>
Mime-Version: 1.0
References: <20220222165212.2005066-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH v2 3/9] KVM: arm64: Add guard pages for KVM nVHE hypervisor stack
From:   Kalesh Singh <kaleshsingh@google.com>
Cc:     will@kernel.org, maz@kernel.org, qperret@google.com,
        tabba@google.com, surenb@google.com, kernel-team@android.com,
        Kalesh Singh <kaleshsingh@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Scull <ascull@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
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

Maps the stack pages in the flexible private VA range and allocates
guard pages below the stack as unbacked VA space. The stack is aligned
to twice its size to aid overflow detection (implemented in a subsequent
patch in the series).

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/arm64/include/asm/kvm_asm.h |  1 +
 arch/arm64/kvm/arm.c             | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index d5b0386ef765..2e277f2ed671 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -169,6 +169,7 @@ struct kvm_nvhe_init_params {
 	unsigned long tcr_el2;
 	unsigned long tpidr_el2;
 	unsigned long stack_hyp_va;
+	unsigned long stack_pa;
 	phys_addr_t pgd_pa;
 	unsigned long hcr_el2;
 	unsigned long vttbr;
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index ecc5958e27fe..7e2e680c3ffb 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1541,7 +1541,6 @@ static void cpu_prepare_hyp_mode(int cpu)
 	tcr |= (idmap_t0sz & GENMASK(TCR_TxSZ_WIDTH - 1, 0)) << TCR_T0SZ_OFFSET;
 	params->tcr_el2 = tcr;
 
-	params->stack_hyp_va = kern_hyp_va(per_cpu(kvm_arm_hyp_stack_page, cpu) + PAGE_SIZE);
 	params->pgd_pa = kvm_mmu_get_httbr();
 	if (is_protected_kvm_enabled())
 		params->hcr_el2 = HCR_HOST_NVHE_PROTECTED_FLAGS;
@@ -1990,14 +1989,41 @@ static int init_hyp_mode(void)
 	 * Map the Hyp stack pages
 	 */
 	for_each_possible_cpu(cpu) {
+		struct kvm_nvhe_init_params *params = per_cpu_ptr_nvhe_sym(kvm_init_params, cpu);
 		char *stack_page = (char *)per_cpu(kvm_arm_hyp_stack_page, cpu);
-		err = create_hyp_mappings(stack_page, stack_page + PAGE_SIZE,
-					  PAGE_HYP);
+		unsigned long stack_hyp_va, guard_hyp_va;
 
+		/*
+		 * Private mappings are allocated downwards from io_map_base
+		 * so allocate the stack first then the guard page.
+		 *
+		 * The stack is aligned to twice its size to facilitate overflow
+		 * detection.
+		 */
+		err = __create_hyp_private_mapping(__pa(stack_page), PAGE_SIZE,
+						PAGE_SIZE * 2, &stack_hyp_va, PAGE_HYP);
 		if (err) {
 			kvm_err("Cannot map hyp stack\n");
 			goto out_err;
 		}
+
+		/* Allocate unbacked private VA range for stack guard page */
+		guard_hyp_va = hyp_alloc_private_va_range(PAGE_SIZE, PAGE_SIZE);
+		if (IS_ERR((void *)guard_hyp_va)) {
+			err = PTR_ERR((void *)guard_hyp_va);
+			kvm_err("Cannot allocate hyp stack guard page\n");
+			goto out_err;
+		}
+
+		/*
+		 * Save the stack PA in nvhe_init_params. This will be needed to recreate
+		 * the stack mapping in protected nVHE mode. __hyp_pa() won't do the right
+		 * thing there, since the stack has been mapped in the flexible private
+		 * VA space.
+		 */
+		params->stack_pa = __pa(stack_page) + PAGE_SIZE;
+
+		params->stack_hyp_va = stack_hyp_va + PAGE_SIZE;
 	}
 
 	for_each_possible_cpu(cpu) {
-- 
2.35.1.473.g83b2b277ed-goog

