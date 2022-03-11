Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D64D5AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 06:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346784AbiCKF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 00:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346687AbiCKFxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:53:13 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04646ECB28
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:11 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id u10-20020a63df0a000000b0037886b8707bso4195233pgg.23
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dx2akcBLzpkqjsYc61+Ndp3tB6jxXz9uwF83mP2tgxA=;
        b=kfamdwzf3WiNt+nrNqK3rqOO2EWCK2oNLFypd42ds2uu9OHf3C+x70VZYH/bjJWKsT
         TJRL2noKkIzxNWbfVFEBwvJweu81w1NZd7GDuBVML7zhysixiw0czd3+1JLHYjliKrRd
         uRDh5l5XrdNbab2bniYwzpf6hp5jjaYAKQrYtLgMfO4zU3SEl3Lb8wkmJAqHIXz+MWEP
         gzE54G5wnR43X4TqgkyRds6PRIM53pgyAhkOvx/pfg+xcJUYO5KNtWVphJTi9a3uc6xj
         iUajsdkLxd50Cf18I+dNSmQa+lvuMhuXTO+F8z9obfHG+OYCrGmta9mZjAqLB6m+VFMD
         6x1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dx2akcBLzpkqjsYc61+Ndp3tB6jxXz9uwF83mP2tgxA=;
        b=6MHd9NtII6FKyLlZOfWi8iTCrA378XGfvkSU9LFhOlvTjP3oHJ9kWtHuwYUWnijJKb
         0vR8FRNI8vFjH9iUnDRrY7g2SNTcGvivm4p6NkO3fq5ZKLVBjss6NMbmNHE6sM6wRykt
         dgeK2hHkuUVwwdwlBuUqFfqayZZauYpSmlZj0XOEK0IPg6mdOujKfMrkG80U0Ac9IApi
         9x6PMN4Ag4uLjluv3kKq/HPtIE61aC+X9ZBf6s5YRVi5XZuy1qybbi5hjGAkxw0UAFOF
         EAcxGjHNJs6g1pvtecoP5QzlLHeXvSwi3rULOwWoNEFX+VDfwM4dxGLUvVRwIIrkllO7
         U71g==
X-Gm-Message-State: AOAM532GIvMSsftdWyO9UugHKE6TddhkDa8izIXTsX60UffIyKNJGT1f
        0RSHBs3gxJS/owqtCA8EaHh+oZ7j6sey+9RPyPMnufOQXDW5FbWnCKYs4ncbgPoi+1hNjOeBukp
        1jya9PQUZYQeQVUHasQ53RVB4B6QJ+gMgaLld/03vi2GUfK59OiKmrzVjnVbigL7+W5ttPw==
X-Google-Smtp-Source: ABdhPJxTvL5R45R5JDKDLNTWlk8U5NMiMwnmxrMy0/kurQwFOB5Bzwa1itKsjG0kil1C0mDa2M55X6s7MAo=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a65:6d09:0:b0:378:5646:24c2 with SMTP id
 bf9-20020a656d09000000b00378564624c2mr7025263pgb.522.1646977930391; Thu, 10
 Mar 2022 21:52:10 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:49:49 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-39-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 038/105] KVM: selftests: Convert mmu_role_test away from VCPU_ID
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/mmu_role_test.c      | 20 ++++++++-----------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
index da2325fcad87..809aa0153cee 100644
--- a/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
+++ b/tools/testing/selftests/kvm/x86_64/mmu_role_test.c
@@ -3,8 +3,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID			1
-
 #define MMIO_GPA	0x100000000ull
 
 static void guest_code(void)
@@ -25,22 +23,21 @@ static void guest_pf_handler(struct ex_regs *regs)
 static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 {
 	u32 good_cpuid_val = *cpuid_reg;
+	struct kvm_vcpu *vcpu;
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	uint64_t cmd;
-	int r;
 
 	/* Create VM */
-	vm = vm_create_default(VCPU_ID, 0, guest_code);
-	run = vcpu_state(vm, VCPU_ID);
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	run = vcpu->run;
 
 	/* Map 1gb page without a backing memlot. */
 	__virt_pg_map(vm, MMIO_GPA, MMIO_GPA, X86_PAGE_SIZE_1G);
 
-	r = _vcpu_run(vm, VCPU_ID);
+	vcpu_run(vm, vcpu->id);
 
 	/* Guest access to the 1gb page should trigger MMIO. */
-	TEST_ASSERT(r == 0, "vcpu_run failed: %d\n", r);
 	TEST_ASSERT(run->exit_reason == KVM_EXIT_MMIO,
 		    "Unexpected exit reason: %u (%s), expected MMIO exit (1gb page w/o memslot)\n",
 		    run->exit_reason, exit_reason_str(run->exit_reason));
@@ -57,7 +54,7 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 	 * returns the struct that contains the entry being modified.  Eww.
 	 */
 	*cpuid_reg = evil_cpuid_val;
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vm, vcpu->id, kvm_get_supported_cpuid());
 
 	/*
 	 * Add a dummy memslot to coerce KVM into bumping the MMIO generation.
@@ -70,13 +67,12 @@ static void mmu_role_test(u32 *cpuid_reg, u32 evil_cpuid_val)
 
 	/* Set up a #PF handler to eat the RSVD #PF and signal all done! */
 	vm_init_descriptor_tables(vm);
-	vcpu_init_descriptor_tables(vm, VCPU_ID);
+	vcpu_init_descriptor_tables(vm, vcpu->id);
 	vm_install_exception_handler(vm, PF_VECTOR, guest_pf_handler);
 
-	r = _vcpu_run(vm, VCPU_ID);
-	TEST_ASSERT(r == 0, "vcpu_run failed: %d\n", r);
+	vcpu_run(vm, vcpu->id);
 
-	cmd = get_ucall(vm, VCPU_ID, NULL);
+	cmd = get_ucall(vm, vcpu->id, NULL);
 	TEST_ASSERT(cmd == UCALL_DONE,
 		    "Unexpected guest exit, exit_reason=%s, ucall.cmd = %lu\n",
 		    exit_reason_str(run->exit_reason), cmd);
-- 
2.35.1.723.g4982287a31-goog

