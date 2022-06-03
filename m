Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC97753C2A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232570AbiFCA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbiFCArR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:47:17 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748AF37BCD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:46:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id c4-20020a170902c2c400b0015f16fb4a54so3467225pla.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dFTXZyKLCe2rmfpw6djiOtrp0qdJVfykNhEs/JKdN3Y=;
        b=fluQjYwJvqacnX9HyUJcT+kV2bAKhgIxjfZXnsXL2G2O7umYOTa4Xk2f9cnSjB3M/S
         YBvAx7JunIlPwktx1ms+Lr1C/K8b0XvoJRdGADwJmytuXgP8l1WhPwxfhg3bPGAOfAdG
         mi54x1FAKC8CJ6/Gkt2N9tgybWOf7AH0IgcRH7fStk7PuxdrOXEU90d4W44E1Kd1fYJD
         ZuxDzQ4+t4wWakbMxH8aSLsqvc7nKR1q6CDTLZAlcQjSGMW3sIyqETQSBXxPUmQGuETp
         tgRQzhA5mcDUiBIW58kN2z4fYrdBZO6+GJ+0BGhQlU8REFIPsySjfNUIfewfV5cVlJP5
         r2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dFTXZyKLCe2rmfpw6djiOtrp0qdJVfykNhEs/JKdN3Y=;
        b=UidgONNSQC1gfYWkTEAIR9+eOF9767aBwsfHtuHsujv5OMmJUF/Jro5ytTqAoqAtNU
         89JubGujlzKZNkUiy5tXyu+y7C7t98o31gVdIW9gmjf+djXtqhyi0k9/KBg6pAuVTgDT
         9bYjzrecElFwFtswjXKDoANNGo5DcSN6oy/Hv75GskduSR+35ZfTh+G+5Pk5F50U4Ix9
         2hN19e0FDqw2NICRhBZsRiXUabhI/drJdeQFrNwYTwVUdpvkpy2yPb4422owSoyczZqj
         Ka7ch2Mph+gFrK2jIyN3zbdz4Qoh3V9Ie7dIY8RNgjH/A5/73WT0Uie3GxgIxPR36ThK
         uC3w==
X-Gm-Message-State: AOAM531BwsWm/gchyk32YC3pAs+Z7TAHZk//6WGouwT3ZPcfZhA9dcHy
        S0kHQRVmJOl/oHBIXSUoGWjplD5oogE=
X-Google-Smtp-Source: ABdhPJxv5mzLQA4WNtxhe7cYClH7VsUnf7TK1tSZ9vb0b3ZITWviuXePFmF04G/vp96nBrHEAIgX/gPfTV4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:6390:b0:1e0:a47b:a57a with SMTP id
 f16-20020a17090a639000b001e0a47ba57amr42517476pjj.115.1654217185119; Thu, 02
 Jun 2022 17:46:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:42:40 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-94-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 093/144] KVM: selftests: Track kvm_vcpu object in tsc_scaling_sync
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.36.1.255.ge46751e96f-goog

