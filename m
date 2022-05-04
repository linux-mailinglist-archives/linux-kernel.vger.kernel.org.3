Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD9B051B367
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379597AbiEDW4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379495AbiEDWyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:54:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25461B7BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:50:37 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i6-20020a17090a718600b001dc87aca289so1080614pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ics5fKQO8hYOFNHtV6D8SXzwom3B/0Woppu9zPFokPE=;
        b=n6riCm3IAmq/UZOcFxQGvdC1OcCB6v0Ts/YtqCboYuFN+Fgci6lFBpkgwFHgYF38A4
         SVcyWgFf/F4LGtlz14qoVNsAthZzzQxuJIlFYkSf+VWULBFfSU4ocUOnsMLTs3vBwxMa
         trUhLImFFbO/LIExgLu/adnqKp5YrCisYAqmMMdEJ1GkrmfBe5yv38c9VIx7c4cwOJJ3
         /sl3Cp6Z79bC/G4O2UCG8+NTYqoIGeEEWME8jvPCHb/W+ndri+IWPZ5lBX16Dbknnx1z
         AkTqNlTQcSuZ+7y6aN0Ds0S6l9iUi2gUSLu0pUhslvSY/VxGo2sxYC7lVog4rY1UkR8S
         wprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ics5fKQO8hYOFNHtV6D8SXzwom3B/0Woppu9zPFokPE=;
        b=CP/6fW9+gQ+D9ws5pprniXpZ56WtfEiL3WyBDLHbchKA6xjqpo+SC0ekZBM6dn1/vy
         xnnMm8JGzQuB5IPG3yB0y9AvnNZKYcDPWTVf8t+C8UbVe72gBgz+BXJPMcez4Q16lr04
         JlE4vFc3hnEt9vHLm2N5dPrVYVMJRvuDA/g1fBtG/tEX6aE7pUSPX1ac0L+XOgTO56vQ
         6CEJvlekmvc8OwjEkpsUWKVUzDD4lNVLuncKk7Yb9J5h49lSolmhXHgHFARQ6PHa8V10
         TgGMv4c5cDE0I9bkEQVjldsIh9UGsILV8ClZVQelLB2JxzvO5wKjkQ3O7B5kylFzBvtQ
         EFpw==
X-Gm-Message-State: AOAM532jT/A09XvvD4Jqe/1a5rLnj0A2fP3f18auPDHJM8ypHvktCnI8
        /eXBUsz7FEoHqqNLtgyYMA+/XqZgRLo=
X-Google-Smtp-Source: ABdhPJyq9dcELUdCxvX0YR9FeHkBJppQMhPVNoV10ItN/sA0vbwtuzl0rtZBr+SBbfd3syl2+f5a0udgONE=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:d48d:b0:15e:c236:4fd3 with SMTP id
 c13-20020a170902d48d00b0015ec2364fd3mr6868487plg.113.1651704637188; Wed, 04
 May 2022 15:50:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:47:44 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-39-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 038/128] KVM: selftests: Rename xAPIC state test's vcpu struct
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
2.36.0.464.gb9c8b46e94-goog

