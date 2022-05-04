Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969D751B28D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381486AbiEDXEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379739AbiEDW5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:57:41 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BD75469F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:51:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id gb16-20020a17090b061000b001d78792caebso1318578pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=m1fbDgBOpXedaeQkbwTaO9NDDO/UaHp/JOaIY7+2IJA=;
        b=U6XkNnZfbRwmcwTVcILZn7/yn0z52QMJQNdxy2zzm3nA0Zgur3S3Wv2R8u92oG8O21
         6LNCNn4cE6Ca4M3WDyEK+4XR0dzvyIsSF/vjiAfgfmzY+d8h5FL2FEDRqjZIFNa1DJPt
         6DxmHYTCUbW1rSPx32SgGnFfozRM78QOUcPLdm2cgGBWCnXcHZJ2i/4PFAFl30v+lcN5
         1vY98QOLZv9cHIbIlgf3ZyqCSeIH1C9a5idCLTZRbloHy1YeJ4lzk5hRmDrGp5UAUUEl
         HZpa2/NYglxGxnMGNe+YO3EclTKMphGKBml3lN3dRhat2mC5tpi3tE9c7Axg4gDeVxPK
         myag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=m1fbDgBOpXedaeQkbwTaO9NDDO/UaHp/JOaIY7+2IJA=;
        b=JUGK06y7qwOumWZm7X/HpKQaf1PFemu+rqLrjVgeQ4vcpNdm95T//SrSqFfWJ3UpGZ
         GB8yQs+oH2v1K0wNCnCHlUStVnVx0JYImXg/IFUZ+RNX8fVDpBGLb3+7afd1+nEM1pYp
         jr6cABwYLIhPobq9jZpGqJ40leZFlOdS/jewKrPh5OSxu95ABVCLqFE+oLhKQeTdpjAH
         N/TV7efVKpgkoTzs0bwOvvjFMiKJTU17mbVwGvHh6YQPCYVdlZNCBRLe6DWe2bdPGl5l
         5+FdqEDYR4g5R2k9qI/uDe9f+QSgoXPR1KhzQquAcam5+R/N8X8ztLw0usPdosEJy9gd
         S7AQ==
X-Gm-Message-State: AOAM530zfgIpY/tHkCsL8AwhUrQ+AR+7OwCssu1wRk8Ql1PqJsYlD+EY
        nb/6jKYzjBLBocb5VmU5qX0+o6Ebzn4=
X-Google-Smtp-Source: ABdhPJyLp2dISrNEcAcdcZKefkXikf28GNflF+SqJ9pbzuxjBWeSR4DDtG13+iu0PM89GzjXLxBV3oy5TCQ=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:38c7:b0:1dc:77aa:e3d5 with SMTP id
 nn7-20020a17090b38c700b001dc77aae3d5mr2195419pjb.51.1651704717584; Wed, 04
 May 2022 15:51:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:48:31 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-86-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 085/128] KVM: selftests: Track kvm_vcpu object in tsc_scaling_sync
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>,
        Sean Christopherson <seanjc@google.com>
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

Track the added 'struct kvm_vcpu' object in tsc_scaling_sync instead of
relying purely on the VM + vcpu_id combination.  Ideally, the test
wouldn't need to manually manage vCPUs, but the need to invoke a per-VM
ioctl before creating vCPUs is not handled by the selftests framework,
at least not yet...

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/x86_64/tsc_scaling_sync.c     | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
index f0083d8cfe98..b7cd5c47fc53 100644
--- a/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
+++ b/tools/testing/selftests/kvm/x86_64/tsc_scaling_sync.c
@@ -46,38 +46,41 @@ static void guest_code(void)
 
 static void *run_vcpu(void *_cpu_nr)
 {
-	unsigned long cpu = (unsigned long)_cpu_nr;
+	unsigned long vcpu_id = (unsigned long)_cpu_nr;
 	unsigned long failures = 0;
 	static bool first_cpu_done;
+	struct kvm_vcpu *vcpu;
 
 	/* The kernel is fine, but vm_vcpu_add_default() needs locking */
 	pthread_spin_lock(&create_lock);
 
-	vm_vcpu_add_default(vm, cpu, guest_code);
+	vm_vcpu_add_default(vm, vcpu_id, guest_code);
+	vcpu = vcpu_get(vm, vcpu_id);
 
 	if (!first_cpu_done) {
 		first_cpu_done = true;
-		vcpu_set_msr(vm, cpu, MSR_IA32_TSC, TEST_TSC_OFFSET);
+		vcpu_set_msr(vm, vcpu->id, MSR_IA32_TSC, TEST_TSC_OFFSET);
 	}
 
 	pthread_spin_unlock(&create_lock);
 
 	for (;;) {
-		volatile struct kvm_run *run = vcpu_state(vm, cpu);
+		volatile struct kvm_run *run = vcpu->run;
                 struct ucall uc;
 
-                vcpu_run(vm, cpu);
+		vcpu_run(vm, vcpu->id);
                 TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
                             "Got exit_reason other than KVM_EXIT_IO: %u (%s)\n",
                             run->exit_reason,
                             exit_reason_str(run->exit_reason));
 
-                switch (get_ucall(vm, cpu, &uc)) {
+		switch (get_ucall(vm, vcpu->id, &uc)) {
                 case UCALL_DONE:
 			goto out;
 
                 case UCALL_SYNC:
-			printf("Guest %ld sync %lx %lx %ld\n", cpu, uc.args[2], uc.args[3], uc.args[2] - uc.args[3]);
+			printf("Guest %d sync %lx %lx %ld\n", vcpu->id,
+			       uc.args[2], uc.args[3], uc.args[2] - uc.args[3]);
 			failures++;
 			break;
 
-- 
2.36.0.464.gb9c8b46e94-goog

