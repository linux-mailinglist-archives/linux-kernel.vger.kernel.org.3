Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5009751B335
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384410AbiEDXHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 19:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379677AbiEDXAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 19:00:16 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F50B58E5A
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:53:34 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v10-20020a17090a0c8a00b001c7a548e4f7so3577283pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Cs3lrlk//K4240Pgi+YoisL+MewmkZIIzZJnWpx8Epc=;
        b=Ez6iCchAKdIAAjAmpHp4etoCIMg+Bnn/G4Mheykuxmmv3dfo6s/myDED7m3XWOCD5u
         JbG3fUMs8ffxJN0RSjiFHFN75y772Kjr0rDdbIW7xCCNtrsgW9P52Yz9Fw7AZJg8MFgZ
         z1gfwzzgKAsK/5uw2GGpGMZWp2Bb5axfVGTLROgogGcWUwHSww3YEHnMDinXcqkIEAMo
         ZeYtfWaOh4VabHzYWAI9/k/oYGm4K0V5rKzJXBWDvUeWa3ghL6Wb7R6VSoeGKPl+uQ/v
         xsV8qrGDkKr0xz+fUfA+W/Qpj+JUiPkz45Vr9bgekZrC7ijaGF4Y9rfrnMDADrMf7m/n
         wC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Cs3lrlk//K4240Pgi+YoisL+MewmkZIIzZJnWpx8Epc=;
        b=3d2C6e/eodZIyHJnKBU0TDDC/86JnlEBP8k90mu2rvOG5UqqBGs6H2zzWX1s7dvVwh
         kiAxswOPNS83mMvr8gXxentAs+A12MjQ9SbmWEneCmvKugqedshxp0l8mvdUFTfwOZq/
         /E6eCvPR4lEksk6bc0mX1MpXXvSb+/mR46Bc5BFYKXhx3psiR17QpR6WS65pTOjVx6iU
         gJRj3w52JNej6nAX5TFQcE/zteXnuAfi7++P2O3a+rpgB1hyBUY2K6ksQtjU8KKrNmxN
         UvgkoPCRF90gUnrGsh+qu0YvnpT4AbgKaqz49fU0cN1aKcYboY27R13KiD1GTIFzcys0
         tl6w==
X-Gm-Message-State: AOAM530Mhmz8fQRIMjEvI9kLH4pp25JwMZ7bKEBw4wz27FU86v6jVr4b
        Cyhe/sAfJh/7JGzpPpxfZ21x2uGbdmE=
X-Google-Smtp-Source: ABdhPJwOTKxPcmf9BY/3xz/aG2xI6EbTE3LGKyI2GIzyxNuOmgTlKZmr7lBMQtZAGbje4/LPKg6JzKCYDpM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:b41:b0:50d:35fa:476d with SMTP id
 p1-20020a056a000b4100b0050d35fa476dmr22962184pfo.33.1651704781583; Wed, 04
 May 2022 15:53:01 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  4 May 2022 22:49:08 +0000
In-Reply-To: <20220504224914.1654036-1-seanjc@google.com>
Message-Id: <20220504224914.1654036-123-seanjc@google.com>
Mime-Version: 1.0
References: <20220504224914.1654036-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 122/128] KVM: selftests: Remove vcpu_state() helper
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

Drop vcpu_state() now that all tests reference vcpu->run directly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  1 -
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 5ab9b5380310..97376446c093 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -290,7 +290,6 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
-struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu);
 void vcpu_run(struct kvm_vcpu *vcpu);
 int _vcpu_run(struct kvm_vcpu *vcpu);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c5156e0caa98..8ee116048864 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1005,19 +1005,7 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
 	__vm_mem_region_delete(vm, memslot2region(vm, slot), true);
 }
 
-/*
- * VCPU mmap Size
- *
- * Input Args: None
- *
- * Output Args: None
- *
- * Return:
- *   Size of VCPU state
- *
- * Returns the size of the structure pointed to by the return value
- * of vcpu_state().
- */
+/* Returns the size of a vCPU's kvm_run structure. */
 static int vcpu_mmap_sz(void)
 {
 	int dev_fd, ret;
@@ -1398,11 +1386,6 @@ void vm_create_irqchip(struct kvm_vm *vm)
 
 	vm->has_irqchip = true;
 }
-struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu)
-{
-	return vcpu->run;
-}
-
 
 int _vcpu_run(struct kvm_vcpu *vcpu)
 {
-- 
2.36.0.464.gb9c8b46e94-goog

