Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA07053C30A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239079AbiFCAtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 20:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiFCApC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:45:02 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB10344DC
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:45:01 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id z16-20020a17090a015000b001dbc8da29a1so3397954pje.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=gIPvcmUhN4Q/tzt8VkoAiW7RJdbdD7hzLHuZ6TYurvI=;
        b=hXGNCWjCV9ArfJclpReO6CN0EfYjGd/HFztxZF0DwWjo64J9VSrZuuUiQaqmfF29TU
         2ULIWtoVVt6l8JI1LO1LjHtiAySbCujkN2oa/eGw9KeATdr8CfRi9DhndJ5I205FFROP
         x1BXIIvwS0tHzgQVcgdvvN0MLQa0/Qpi3ZH6ny/cbLQwqAxqg/4MszsHyp5HPKBtgnyb
         T93d96Z/hklXfq7M2E22uwX1ccRRz7vY8mc6KF6rEdpqkJ37niG0oc4QE7jbUylt9ke1
         FgXrAg+GK0F2kAv/YgHUUZDp6KFN5kpD5sCwIoY9PvrlQ/xJjOW5RAh41d6Y67VX2oQh
         jt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=gIPvcmUhN4Q/tzt8VkoAiW7RJdbdD7hzLHuZ6TYurvI=;
        b=ugX0O4KfiEjoXHcMnuRE8wv7Yqs7bikC217xbdNvc2Y7OYQd14fQHcqC0diFdMVwUF
         WaXRTvvU0mwRkiC38GNCMCLyEAGD/gzn8/FyZgHyJ55QtoKnmzAqtqmHxVKo8yYgBNIH
         gtAhgxNCfAadunCGpf1d4/nsJ5Jhja0kQxPTogDL8qfBmnUvZyfv0qg4aAfIfRv005W0
         bexXN6FdpSqHvFt1WXhyEb99LFIEkEUzkPpE58pVbdAvjnJRamaflrRXmoYnwqMKeri0
         NF2kVGE5tDHOibQftI3g5+uamE+TGAYiJy6MI0Ncb7RTw7RsNB5trO54Z+JuFScWnS29
         CauA==
X-Gm-Message-State: AOAM531O45e0tyKIgp1kdrpGme2TdzRZC5vBfovWgV8U2rQRfHdBeSLH
        bNQDhlee92YKo7gZBVRhB4ntsAiro84=
X-Google-Smtp-Source: ABdhPJzlEcxgEJY0LiZLnfAB+K6R9S2gsAR+967w4GZSOquG1ccyEJ80loHO+3oRWjbJr9Bvz1aRsZSGqb4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1a91:b0:518:7bca:d095 with SMTP id
 e17-20020a056a001a9100b005187bcad095mr64694374pfv.13.1654217101129; Thu, 02
 Jun 2022 17:45:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:41:53 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-47-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 046/144] KVM: selftests: Rename xAPIC state test's vcpu struct
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename xapic_state_test's kvm_vcpu struct to xapic_vcpu to avoid a
collision when the common 'struct vcpu' is renamed to 'struct kvm_vcpu'
in a future patch.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/x86_64/xapic_state_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
index 0792334ba243..9d8393b6ec75 100644
--- a/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
+++ b/tools/testing/selftests/kvm/x86_64/xapic_state_test.c
@@ -11,7 +11,7 @@
 #include "processor.h"
 #include "test_util.h"
 
-struct kvm_vcpu {
+struct xapic_vcpu {
 	uint32_t id;
 	bool is_x2apic;
 };
@@ -47,7 +47,7 @@ static void x2apic_guest_code(void)
 	} while (1);
 }
 
-static void ____test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
+static void ____test_icr(struct kvm_vm *vm, struct xapic_vcpu *vcpu, uint64_t val)
 {
 	struct kvm_lapic_state xapic;
 	struct ucall uc;
@@ -75,13 +75,13 @@ static void ____test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
 	ASSERT_EQ(icr, val & ~APIC_ICR_BUSY);
 }
 
-static void __test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu, uint64_t val)
+static void __test_icr(struct kvm_vm *vm, struct xapic_vcpu *vcpu, uint64_t val)
 {
 	____test_icr(vm, vcpu, val | APIC_ICR_BUSY);
 	____test_icr(vm, vcpu, val & ~(u64)APIC_ICR_BUSY);
 }
 
-static void test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
+static void test_icr(struct kvm_vm *vm, struct xapic_vcpu *vcpu)
 {
 	uint64_t icr, i, j;
 
@@ -116,7 +116,7 @@ static void test_icr(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 
 int main(int argc, char *argv[])
 {
-	struct kvm_vcpu vcpu = {
+	struct xapic_vcpu vcpu = {
 		.id = 0,
 		.is_x2apic = true,
 	};
-- 
2.36.1.255.ge46751e96f-goog

