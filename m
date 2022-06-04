Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586CF53D492
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350069AbiFDBVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349992AbiFDBVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:21:15 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46D56773
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y66-20020a62ce45000000b0051bb4d19f5fso4429744pfg.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=atPH1T2TubvL7PAUqYl19amHcm0CJWgBwICdsU+Bjlo=;
        b=Ofqb0/p28Y+xQw2Geh7UqeeARknTFRH6VFOMGeh3GBpGmEaYOLeRT99sUVTrluzUEu
         viaobvJ8WbVGFkTlT+xSQJNNdtFvN0PGqVgVBdtMAF9uj97ABSFfWWOXHumtxxxgzAgL
         a4XjV13y6LQNvUv2QpoCmScdURHN8aME53QSFfOXxJm5Xt1GgHFK1bHuHfn5MsAqzOQq
         JGb9VfWBZ7Euv0q4fbeuwYH02Uw/5DgGAhVvKsm66No4/B/fCZX8GqNUQm5m/jreQdhS
         ckWjgtdB+ScnTKd6BC0U4hRPgn+zFPZsfP2wCcfLLh/zOfwluUTTwvC2KMOC8fVUaUIJ
         QLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=atPH1T2TubvL7PAUqYl19amHcm0CJWgBwICdsU+Bjlo=;
        b=pwDRDYJVBDiypZVv51YphqFxEQnhpmsjZR19rzMQO4xz1ZryQJkFZ6cK6cKOawN28T
         PhqmLcq+Rral29VHAFYA24w0+FqaHAc2kNvAU9Bk45g2NmIVfLzPT/wMhu+rtLctSkcH
         PvwuZ26ZwJI9bN7X/uv3k77ABnoGbuMu+g2PwxCv0sx+MJ7he9IIkmz5WLx1b5bxH1A/
         RenS5gdqKfZyuXf5TSqF+wpzVJ5PoCZbEBHIlmvqbX5urFCgxewpjyW6lyMu4K92b/12
         6xsuotZ7gx4dHZs1m6KCylkdyIVB4Ed1cy3qaFIo4Gl+FWaKbVjRr/DvnO6sv/M9hpn4
         1zyA==
X-Gm-Message-State: AOAM531azJbc/Rqaza3X4zq/weL81U+MqKJFqT2hel/ofb0glU6nEvSP
        EQeb6gYmv3V8WYqKNGZTHrK4JbN29TQ=
X-Google-Smtp-Source: ABdhPJwlu3BFfGOsEZTkFbArnW/+qTHVi9kD4VrBqV1cmLxB2QxCNybzYbcemWsOSmfFNZ73q9jca3eAio0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:249:b0:1e0:a8a3:3c6c with SMTP id
 t9-20020a17090a024900b001e0a8a33c6cmr4680pje.0.1654305672782; Fri, 03 Jun
 2022 18:21:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:23 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-8-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 07/42] KVM: selftests: Use kvm_cpu_has() to query PDCM in PMU selftest
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Use kvm_cpu_has() in the PMU test to query PDCM support instead of open
coding equivalent functionality using kvm_get_supported_cpuid_index().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c | 7 ++-----
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 24ffa7c238ff..ff8b92c435f5 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -79,6 +79,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_MWAIT		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 3)
 #define	X86_FEATURE_VMX			KVM_X86_CPU_FEATURE(0x1, 0, ECX, 5)
 #define	X86_FEATURE_SMX			KVM_X86_CPU_FEATURE(0x1, 0, ECX, 6)
+#define	X86_FEATURE_PDCM		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 15)
 #define	X86_FEATURE_PCID		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 17)
 #define	X86_FEATURE_MOVBE		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 22)
 #define	X86_FEATURE_TSC_DEADLINE_TIMER	KVM_X86_CPU_FEATURE(0x1, 0, ECX, 24)
diff --git a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
index eb592fae44ef..667d48e8c1e0 100644
--- a/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
+++ b/tools/testing/selftests/kvm/x86_64/vmx_pmu_caps_test.c
@@ -17,7 +17,6 @@
 #include "kvm_util.h"
 #include "vmx.h"
 
-#define X86_FEATURE_PDCM	(1<<15)
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
 
@@ -55,7 +54,6 @@ static void guest_code(void)
 int main(int argc, char *argv[])
 {
 	struct kvm_cpuid2 *cpuid;
-	struct kvm_cpuid_entry2 *entry_1_0;
 	struct kvm_cpuid_entry2 *entry_a_0;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
@@ -70,11 +68,10 @@ int main(int argc, char *argv[])
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	cpuid = kvm_get_supported_cpuid();
 
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_PDCM));
+
 	TEST_REQUIRE(kvm_get_cpuid_max_basic() >= 0xa);
-
-	entry_1_0 = kvm_get_supported_cpuid_index(1, 0);
 	entry_a_0 = kvm_get_supported_cpuid_index(0xa, 0);
-	TEST_REQUIRE(entry_1_0->ecx & X86_FEATURE_PDCM);
 
 	eax.full = entry_a_0->eax;
 	__TEST_REQUIRE(eax.split.version_id, "PMU is not supported by the vCPU");
-- 
2.36.1.255.ge46751e96f-goog

