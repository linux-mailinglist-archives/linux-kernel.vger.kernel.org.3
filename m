Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A5853D460
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiFDBXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350198AbiFDBWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:22:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34580B7FC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-310061f47faso37421967b3.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=TSkVw4BUWTj8GnGnzmYwA+VpLXiJcJCvkpVGmnLW8To=;
        b=i3GCfCF9cF6KmfY5ipXnOirz5jXw5qSn7RwKoi8EFHkW+so9Yx2YUsUHg9RYTUvDa/
         CTNUIQx8pHxGVah5Pbj2uP9yUUs1eP2khoRC1IlI6Svl5ZxMT96NT50o9RzOjA6e+QuI
         SAXnYBUhqF+f+2cmZLPNwCYwMbN7eZ2KScHLJfq+l/vj0lAH1aJdo7vbxAWxYHLog5MK
         mHjaGvDwaU7Sh0onpM9tKjlC0Bwlmyz0fBXm6alkyrsNGM/j81ivZ+Vq93IJNZr7WIsx
         KfKbvCJomVIsBS2z5q3pWcV6WHsaeIZNSG3CPGJuhC9gDEYWtJt/EPwjBNEYqXwvt/y6
         xDQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=TSkVw4BUWTj8GnGnzmYwA+VpLXiJcJCvkpVGmnLW8To=;
        b=W8u0kClM9dd3ZQr9wE3dShBdKwywTUjtxsg4irUaeO3Q/Y3jxlHmYQ01HN1Tfz7N/C
         9cHS7fAAMhi981ihuhvAsAJrNc1IGFgt3WtWPYGdTIsM3XyMOYDJq0CFX7rc6Ench1KY
         BYWbocJXDyazt+7DQBFVfYYM+jzrtd2vXLp2H69yeQuIdprER1kM+3SumyZ7mbcQ5Ipy
         TORINT9DAP48QbGsTZzprnirIcNjmbzm4FhVBeTUbpuO+Hj7U5nVNUvr1bfnQZaj1CF+
         K5R9tK06KxtzCLJb1abbgqKvqSV0P9sK2Yn5LFnTWOcAdIDYHZwUuAYHPoEy5OYJjYKn
         lHbg==
X-Gm-Message-State: AOAM5336K9WuPJHbTvTThT5umN/D13aQopKRg0sZlNoo8MbYZaXyP/G2
        b5HQ2i69j1vNN4DWa3rgWOeR2ALHfgk=
X-Google-Smtp-Source: ABdhPJykVyZvNZtFVywiMyWJdipP4t0W0zyr/Vs1qk6OM7OzoVxIog9RBbk5wrx54Jyb83t/EiFqC1ZGwyk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:4c6:0:b0:65c:9e2f:f51 with SMTP id
 189-20020a2504c6000000b0065c9e2f0f51mr13696865ybe.11.1654305704251; Fri, 03
 Jun 2022 18:21:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:41 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-26-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 25/42] KVM: selftests: Use vcpu_get_cpuid_entry() in PV
 features test (sort of)
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Add a new helper, vcpu_clear_cpuid_entry(), to do a RMW operation on the
vCPU's CPUID model to clear a given CPUID entry, and use it to clear
KVM's paravirt feature instead of operating on kvm_get_supported_cpuid()'s
static "cpuid" variable.  This also eliminates a user of
the soon-be-defunct set_cpuid() helper.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h |  1 +
 tools/testing/selftests/kvm/lib/x86_64/processor.c   | 11 +++++++++++
 tools/testing/selftests/kvm/x86_64/kvm_pv_test.c     | 12 +-----------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index d6ffd625513b..22e2eaf42360 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -658,6 +658,7 @@ static inline void vcpu_set_cpuid(struct kvm_vcpu *vcpu)
 
 void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr);
 
+void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function);
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 				     struct kvm_x86_cpu_feature feature,
 				     bool set);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 06ae7542f2c9..69239b3613f7 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -771,6 +771,17 @@ void vcpu_set_cpuid_maxphyaddr(struct kvm_vcpu *vcpu, uint8_t maxphyaddr)
 	vcpu_set_cpuid(vcpu);
 }
 
+void vcpu_clear_cpuid_entry(struct kvm_vcpu *vcpu, uint32_t function)
+{
+	struct kvm_cpuid_entry2 *entry = vcpu_get_cpuid_entry(vcpu, function);
+
+	entry->eax = 0;
+	entry->ebx = 0;
+	entry->ecx = 0;
+	entry->edx = 0;
+	vcpu_set_cpuid(vcpu);
+}
+
 void vcpu_set_or_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 				     struct kvm_x86_cpu_feature feature,
 				     bool set)
diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
index e3bb9b803944..7ab61f3f2a20 100644
--- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
+++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
@@ -142,15 +142,6 @@ static void guest_main(void)
 	GUEST_DONE();
 }
 
-static void clear_kvm_cpuid_features(struct kvm_cpuid2 *cpuid)
-{
-	struct kvm_cpuid_entry2 ent = {0};
-
-	ent.function = KVM_CPUID_FEATURES;
-	TEST_ASSERT(set_cpuid(cpuid, &ent),
-		    "failed to clear KVM_CPUID_FEATURES leaf");
-}
-
 static void pr_msr(struct ucall *uc)
 {
 	struct msr_data *msr = (struct msr_data *)uc->args[0];
@@ -209,8 +200,7 @@ int main(void)
 
 	vcpu_enable_cap(vcpu, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 1);
 
-	clear_kvm_cpuid_features(vcpu->cpuid);
-	vcpu_set_cpuid(vcpu);
+	vcpu_clear_cpuid_entry(vcpu, KVM_CPUID_FEATURES);
 
 	vm_init_descriptor_tables(vm);
 	vcpu_init_descriptor_tables(vcpu);
-- 
2.36.1.255.ge46751e96f-goog

