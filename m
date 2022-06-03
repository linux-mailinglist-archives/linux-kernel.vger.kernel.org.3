Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C953C1B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiFCBAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 21:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241178AbiFCAu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 20:50:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B5D2FE42
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 17:47:39 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oa9-20020a17090b1bc900b001e67bbd7f83so2634426pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 17:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=vzEIkOxF6j+8TaKOQctGK3QAAYgR9NaCVUttrNl7Imc=;
        b=EmhsuTBMkRSesVSbQRd5b2Br+gEpVvbkc2b/WJMyySFV9xt3jCkETEmd2CCx3cY0ZR
         nvN0ZHMZR+zCNJB89/Tl1Hz9kZfTPIOmXLM7TMLXsGpI8+/pmYThDR3ZkJrg2URRZEBK
         QcU8Uy/Fsds7oWJoGpmfkPLSh8Yqxhxi8uugZnodAQKPtoXQ21WDiKZjv4HIusgOt2qa
         kw6Fv29hc0EUCZTg+v8qFgTH3HhFE3eo1SsAD9uGCItq1jxd5HBSs132xQP+89slOotj
         MbNkQyrmK0amq++BZg35PDirnbxo09wCzf9JZjQMJWb/v/Nsk6uWNYNNEp5Axz/tZNGM
         UM9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=vzEIkOxF6j+8TaKOQctGK3QAAYgR9NaCVUttrNl7Imc=;
        b=nX9ITojWCSzy9YoazfHh5M/eRyX3/phsdbc90qXzC3Kb9vbJUO7HpxPtYjKUI4K+F9
         tCcfgTK58NJdbxuRkzYSxQdVALZy7z0Baox9mnwCG9XVi7H4VDvNx/OJVa+e66g1YyHx
         9jXIRQGcFfZmx4Jcj0vNRCzS+EX4va6a04W0sdadoWQQWPrGFe6tYREaEWoaB9yKnqcl
         GtKx2Kj1NU0Y3HqBGWFaUE9DQRJ/AwUa0Wg3sWnXxEZi8Bfggn1bcoVeGq7C8bDR2COf
         GyQs3Ir0dIjPkyVs+fKUN4guvHn1IliwWB+ttKGxhDWqRaGGi4Lcp0TTwbkrsH5+cqOd
         pynw==
X-Gm-Message-State: AOAM530HEUeoyUJ4QvvrFyBm0JuSuVUSIghMkcZBi3O0MeeRQTnjeZGS
        GKwKp4qC4+9J1K4KJFXdKAIZO/sBUeU=
X-Google-Smtp-Source: ABdhPJydDVJfmiHF6DKJW47aGfDPWoWTmf7NtAN202prI2IgBM0ak4NkgIUfaMJqSiuU0Zxk7LyUt+UWHwg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id
 n12-20020a170902f60c00b0015682c9e44bmr7669686plg.106.1654217258908; Thu, 02
 Jun 2022 17:47:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  3 Jun 2022 00:43:21 +0000
In-Reply-To: <20220603004331.1523888-1-seanjc@google.com>
Message-Id: <20220603004331.1523888-135-seanjc@google.com>
Mime-Version: 1.0
References: <20220603004331.1523888-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v2 134/144] KVM: selftests: Remove vcpu_state() helper
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

Drop vcpu_state() now that all tests reference vcpu->run directly.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  1 -
 tools/testing/selftests/kvm/lib/kvm_util.c    | 19 +------------------
 2 files changed, 1 insertion(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 2da9db060378..5741a999aca1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -298,7 +298,6 @@ void *addr_gva2hva(struct kvm_vm *vm, vm_vaddr_t gva);
 vm_paddr_t addr_hva2gpa(struct kvm_vm *vm, void *hva);
 void *addr_gpa2alias(struct kvm_vm *vm, vm_paddr_t gpa);
 
-struct kvm_run *vcpu_state(struct kvm_vcpu *vcpu);
 void vcpu_run(struct kvm_vcpu *vcpu);
 int _vcpu_run(struct kvm_vcpu *vcpu);
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8775d7ab39c8..2d69ac86d3fb 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1001,19 +1001,7 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot)
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
@@ -1394,11 +1382,6 @@ void vm_create_irqchip(struct kvm_vm *vm)
 
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
2.36.1.255.ge46751e96f-goog

