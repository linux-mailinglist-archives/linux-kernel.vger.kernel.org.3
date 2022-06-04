Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63CF53D45E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349980AbiFDBWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350097AbiFDBVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:21:41 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229A859B87
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:22 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d13-20020a170902728d00b001635c985770so5055088pll.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6XC7JtZ5cEAXk5roBNccLsZKMYfOaGpCtF/bFJA0Fvo=;
        b=C8VjAHSs/NC3zH1Ez2SVvAJLV75TFs4IgqG/Uqd2yVHN/PiTpbOsT0TwqgF3ovuEJZ
         i/X43LnEjMzlMZ4UCbl8WFzaovu48WCXOcTfgw0lvGDfPUFb/Z2MsKBQWl0ZWe2CtxuI
         Gy64CJS+I2uVzQM1u+P7Kv6uQY1/3uxKo5n72lsIdb9BUngXinakqUdkT2G2hW8F1Ubk
         8qst0I2Jj//MyaFNEpO1jFEM9eRL4NxZAbvbEFCEZJqndX45Tl7L1rNN81VIL7DhHJgC
         GhnM5r6t8qZRXPEUK8Jgt5sWVoHGDxBw/I7ON5XJnXrLRRqGGNuq39epsyjkSBrzy21Y
         W6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6XC7JtZ5cEAXk5roBNccLsZKMYfOaGpCtF/bFJA0Fvo=;
        b=iVBKEIb08XJaPVCbk3CCH+EjxBmk4DKPpWWmf4JvIKStewT3IzleZC97XOTnHCIQi6
         t38LeuuL5Qd3gcTfOs8FgLUgcodCdvNOxCtqse9DWROHfzuJ25xYN1TbBjEVzILd/lsu
         tikDxodBiDyFxZyfu6QGX7vj7Q9TOEtVWQZb0/Pkt1FEZjNiNEfceLazwU/p1hhW6JHZ
         rs4pt0AkbG0/1KSfsTR0ELB6vqjmbgno4TL4TTejVtZ8t5EN/EtatU6Cz3XKqogZWLTh
         kVWlCHQV0emwPTV3Mu/hpKg391CYQjAADw+dxDt86TvW6LnTrc4X0BX7m4qr6EgG7+Sg
         R0Vw==
X-Gm-Message-State: AOAM53029dxy6dsORZSMSf7021Q7VrfaDJaKb9v9ooUDEFZltGCq3gMl
        ToovKuIVVuxZO9S492jX6fbEGMgGDo4=
X-Google-Smtp-Source: ABdhPJyO/2uj1pfmTeJyJWMIF8PZP2K9Ng5q4hQn0vYEwPUxsXeARv+oplb9rNxrEkjwBbDvbxk4dxoSMi0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:2287:b0:164:83cf:bb15 with SMTP id
 b7-20020a170903228700b0016483cfbb15mr12544224plh.49.1654305681851; Fri, 03
 Jun 2022 18:21:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:28 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-13-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 12/42] KVM: selftests: Use kvm_cpu_has() for XSAVE in cr4_cpuid_sync_test
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

Use kvm_cpu_has() in the CR4/CPUID sync test instead of open coding
equivalent functionality using kvm_get_supported_cpuid_entry().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
index 8b0bb36205d9..092fedbe6f52 100644
--- a/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
+++ b/tools/testing/selftests/kvm/x86_64/cr4_cpuid_sync_test.c
@@ -63,11 +63,9 @@ int main(int argc, char *argv[])
 	struct kvm_run *run;
 	struct kvm_vm *vm;
 	struct kvm_sregs sregs;
-	struct kvm_cpuid_entry2 *entry;
 	struct ucall uc;
 
-	entry = kvm_get_supported_cpuid_entry(1);
-	TEST_REQUIRE(entry->ecx & CPUID_XSAVE);
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_XSAVE));
 
 	/* Tell stdout not to buffer its content */
 	setbuf(stdout, NULL);
-- 
2.36.1.255.ge46751e96f-goog

