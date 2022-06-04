Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1719A53D46B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348452AbiFDBYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350143AbiFDBXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:23:10 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA682E9CC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:22:14 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g129-20020a636b87000000b003fd1deac6ebso1652919pgc.23
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=D4pd0B8lUuq0zciMBRqcW64B09BKAynerT7v02hMJtY=;
        b=YRimQa6jGuJsBY2uXFkR87Hx13Z2P1/N41Jjl148F5J9r0rulXps8xOfSPm9wu/ahz
         a/Ae8qAu+867Thxcrt3iATtARm4do4MQ7puevwwNbOPRTRYPnAsRCjee/1Q12Wb/MRbS
         de2eEIkdvv1Jzv60T1mS+SU/93qaGAjwi3EvbbHOjIbLoZOaIQxFwCnMp69h+Qyjl5h4
         Fk42oqb73L52B9c8XRggTZZwd0AmLXbO28xThwO2UgX+v2u0BeJ9NItbtSS2+9fUSfAH
         NjalDGSlPZSlUN30ZZbhz3LHUWoc8qQ//rXZa2RcZipOxkqKjgBksyPSYXrCvPFPmSk5
         iUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=D4pd0B8lUuq0zciMBRqcW64B09BKAynerT7v02hMJtY=;
        b=rXN5lbdAaPo2Pjz+SjJH/8USAqqWBxz8622FcwNPwQmejGTmpCcSXYhkq/w3XGDeox
         wh1cxIw3yqU7g6yKlNj3bMyRyJqnFs1zxAPyyVcAspglOV83unSk8+V0P7CEe5otmBMn
         ovWUDbw0NNmLLeMna9WGIlSXM0LqIrWIRkBb1aVt67FQxLDQnFMiIOl9SiVwjORtWR2Y
         RD2YSUF1TUa+Hjqd5d69gygfAmI02rvW8KGgAXGto+nL7RsKiEKE5eU8QjU4TrBBFXoH
         3hkpKzfDFajie8HFzQmYA7QJLY93+FGT9ZEoO3LoLcXPO0y4Xl/Au4lED/RrC2QwetFz
         lJTA==
X-Gm-Message-State: AOAM531H2XIKP5qUu2sB4Q+XofSQ3Rmpp1dQze6gDaGqGPy+20My0Vx2
        UmdS7DriN4a1qTZgBD/S3aQSwA5tbWo=
X-Google-Smtp-Source: ABdhPJz0UhqZv7zIUir0euaZw0GP9YWAeknDoZdsiE2M9GcM304y4Czt1+UOVp1Lv8jLr8ouX2q8ORK8QtY=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1744:b0:51b:d4d5:f34 with SMTP id
 j4-20020a056a00174400b0051bd4d50f34mr8619159pfc.0.1654305725916; Fri, 03 Jun
 2022 18:22:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:53 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-38-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 37/42] KVM: selftests: Inline "get max CPUID leaf" helpers
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

Make the "get max CPUID leaf" helpers static inline, there's no reason to
bury the one liners in processor.c.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/include/x86_64/processor.h  | 11 +++++++++--
 tools/testing/selftests/kvm/lib/x86_64/processor.c    | 10 ----------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index b47291347a5d..473501e5776e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -719,9 +719,16 @@ static inline void vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index,
 	TEST_ASSERT(r == 1, KVM_IOCTL_ERROR(KVM_SET_MSRS, r));
 }
 
+static inline uint32_t kvm_get_cpuid_max_basic(void)
+{
+	return kvm_get_supported_cpuid_entry(0)->eax;
+}
+
+static inline uint32_t kvm_get_cpuid_max_extended(void)
+{
+	return kvm_get_supported_cpuid_entry(0x80000000)->eax;
+}
 
-uint32_t kvm_get_cpuid_max_basic(void);
-uint32_t kvm_get_cpuid_max_extended(void);
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits);
 bool vm_is_unrestricted_guest(struct kvm_vm *vm);
 
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 1d92a1d9a03f..0f36f8ac7e9d 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1057,16 +1057,6 @@ bool is_amd_cpu(void)
 	return cpu_vendor_string_is("AuthenticAMD");
 }
 
-uint32_t kvm_get_cpuid_max_basic(void)
-{
-	return kvm_get_supported_cpuid_entry(0)->eax;
-}
-
-uint32_t kvm_get_cpuid_max_extended(void)
-{
-	return kvm_get_supported_cpuid_entry(0x80000000)->eax;
-}
-
 void kvm_get_cpu_address_width(unsigned int *pa_bits, unsigned int *va_bits)
 {
 	const struct kvm_cpuid_entry2 *entry;
-- 
2.36.1.255.ge46751e96f-goog

