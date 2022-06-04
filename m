Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89CD53D48A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347810AbiFDBVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349980AbiFDBVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:21:20 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A24A56771
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:17 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 15-20020a63020f000000b003fca9ebc5cbso4351969pgc.22
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2CIyo9+62gy+JEf6/FTcvhLOqsH6XI1aGgGR7RbhZy8=;
        b=e/CoQ6N1BLk/odGMKewDlRxYI9eMw5DUZwQ0JyS1vL18okZj3CyJgGnGtyTa2MGbpw
         /VBTEUVkRpuD3RR08dlwZJKxo5jSx8Dfu99Mm3BuLrUFYhBONNkNQMYHbekj0lbFLIGf
         0LYhWpkFcjJZtEx+x2uLF/aPiev/CqY6CENPXAUCoolt+k3jRjcD0s3AQ6jgPOzWbOAp
         xIBrdWIWguF3/dR+ph5HhbQjExv4LNXd3d/Ezrday3GwFjdZ5JwahHQzyHLIZvQfBkUd
         42np6xTe3W40uvhVw/bBPakuMvqndav7GibHDa9oQqF/50egSBsiGwRTfmI9OnYOYRhJ
         pqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2CIyo9+62gy+JEf6/FTcvhLOqsH6XI1aGgGR7RbhZy8=;
        b=mP6GcK8xmbkU+5HKO8/AyHywhMEn8t2OP7U8q+HxpjI96fw/qMNi5O9fFlWq4+0KJs
         Olwr6bwcmQBcB5X/DAFRrV1BR6e2Dp5yxE8k5C9zRqLBY0s1k69RS80ZMo6jB9LwoKoF
         CSP4xKP7cOfrh7ZEp+4YC/O779DtkLySRBgK8A6IH51+ygNrLFsZhub9+x8Ly/Fg02hw
         ktlh3nhJXvN63HmFhk2DwWUykmw5QOQYexQRQ61IFnZFi1z6+LGmH5cWGGPrs/FK4ZlK
         mNsIOtJQogiw+sQyb0PAvHHxPb/BxLhxkKYiTx4XxH/GgTJbsQ6z+l2Z8+bNUfQDDOaS
         TiPg==
X-Gm-Message-State: AOAM533Wx0JBqcQ2/ln6DJUubpxjpuFZ3evjwhqH/oqXqzWQ244sUkNE
        RpG7BlNfLHNXmwT9wzTXGs3Rfj80TFc=
X-Google-Smtp-Source: ABdhPJyEpE1eRHJzScLoumLROn6x7qNvOlhYu2NSqd5gJxBk6thivXmfFul7gtdrANkMicJfmvZmO2zR11g=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f34c:b0:163:fa4f:2ff5 with SMTP id
 q12-20020a170902f34c00b00163fa4f2ff5mr12474825ple.174.1654305676584; Fri, 03
 Jun 2022 18:21:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:25 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 09/42] KVM: selftests: Use kvm_cpu_has() for XSAVES in XSS MSR test
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

Use kvm_cpu_has() in the XSS MSR test instead of open coding equivalent
functionality using kvm_get_supported_cpuid_index().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86_64/processor.h | 1 +
 tools/testing/selftests/kvm/x86_64/xss_msr_test.c      | 8 +-------
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index ff8b92c435f5..7992c665be1f 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -110,6 +110,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_SPEC_CTRL		KVM_X86_CPU_FEATURE(0x7, 0, EDX, 26)
 #define	X86_FEATURE_ARCH_CAPABILITIES	KVM_X86_CPU_FEATURE(0x7, 0, EDX, 29)
 #define	X86_FEATURE_PKS			KVM_X86_CPU_FEATURE(0x7, 0, ECX, 31)
+#define	X86_FEATURE_XSAVES		KVM_X86_CPU_FEATURE(0xD, 1, EAX, 3)
 
 /*
  * Extended Leafs, a.k.a. AMD defined
diff --git a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
index 4e2e08059b95..e0ddf47362e7 100644
--- a/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xss_msr_test.c
@@ -14,11 +14,8 @@
 
 #define MSR_BITS      64
 
-#define X86_FEATURE_XSAVES	(1<<3)
-
 int main(int argc, char *argv[])
 {
-	struct kvm_cpuid_entry2 *entry;
 	bool xss_in_msr_list;
 	struct kvm_vm *vm;
 	struct kvm_vcpu *vcpu;
@@ -28,10 +25,7 @@ int main(int argc, char *argv[])
 	/* Create VM */
 	vm = vm_create_with_one_vcpu(&vcpu, NULL);
 
-	TEST_REQUIRE(kvm_get_cpuid_max_basic() >= 0xd);
-
-	entry = kvm_get_supported_cpuid_index(0xd, 1);
-	TEST_REQUIRE(entry->eax & X86_FEATURE_XSAVES);
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVES));
 
 	xss_val = vcpu_get_msr(vcpu, MSR_IA32_XSS);
 	TEST_ASSERT(xss_val == 0,
-- 
2.36.1.255.ge46751e96f-goog

