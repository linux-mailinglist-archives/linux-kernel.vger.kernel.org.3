Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339F34D5B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbiCKGCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346788AbiCKFzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 00:55:12 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB1D10529C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mt1-20020a17090b230100b001beef010919so7272266pjb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 21:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=PHifpinCKbWrFK0UtCfVbKILS2hQoNnJeB9lRg5RHRQ=;
        b=ArbrkDj/nFgmvkL3MQLRyrd58IQJFnbtgXd03N48lGkFYfBcxp6HujrX1j+wFl9h9P
         F/KmGtaN6pohWfhmWC1SQnn+uwf3xh0euTouVjbOkAAkjJoAdSlJFwUxzZN3wVo1FIQa
         mrd+5l8sjXLB5FnzpI8t4JhlZlwy/IITthf8t0kfPlrwPX74t5+NWOoHDzrKu+voPM7j
         TBiFWA0gIlHYKeJFD1tMgqa5i/VQaWUh5t+7OWrI+Yrg8ifuJzPJnUxyrPRa4+bXA0Nk
         7t5KIFpUVJ4lQnvs+Blxagf4gwydJA452CeOl/8efekIrKlfEisClY0/2e4NlYUDSPmO
         61JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=PHifpinCKbWrFK0UtCfVbKILS2hQoNnJeB9lRg5RHRQ=;
        b=Cbj1MUb+w0fEgPjSgh74huTzsUivtUi8I/AIVI2pdHFsd+CzXjw9jWxTwTq4xE1z+A
         z43wyTjNgGKn75nBEXS1MeCB20MXfDrqFvHTrO32q2HoL3pryeX9eM5DKryRWZB1UCph
         ij39Cyno/AYZtwZW+GEkWuWZfJfFp4IlpRaLwk+IsZDEWFmfHsoccHd/9LCP3MN0D3D7
         YVCYCG5QN2HWcvX/vPIiN3ua2AnDxJLQSBaRKeIMyylEIcMuHA5Pczfpe9ZmhZ1nVJo8
         0yZWhN+Us+FGyjMo+x+hsQEE5fovrdbKQdgxnUEal5Cr9rkfBw/zTZqDbAsycY2s23tz
         SZmw==
X-Gm-Message-State: AOAM532+GqGT0t32ZpygZYUzN8hHipfy6f0gqXwIbe/wY0ZRBEPn1dh+
        32rUIecFiiVulXvBLCmYpUIYeZwq5hPhEVGnVIsCtrXte07kKs0iT5TAYsijVkYlWU12lNJXN05
        4WBzHWKHKkpCXg8QAorZiw5TVuQCyRgz2ZzI6pFq75E/FXIJqWnlllN4pkP7zENpcnDd3Bw==
X-Google-Smtp-Source: ABdhPJwH99CncSlMl5QqboY65EPZ1txiNZoQr5PWUVmiu5/hqgtuUTJzrP2+jAGVeHcYv/WkEY4xGa4euwg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:85d8:0:b0:4f6:8ae9:16a8 with SMTP id
 z24-20020aa785d8000000b004f68ae916a8mr8755179pfn.15.1646978035776; Thu, 10
 Mar 2022 21:53:55 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 05:50:52 +0000
In-Reply-To: <20220311055056.57265-1-seanjc@google.com>
Message-Id: <20220311055056.57265-102-seanjc@google.com>
Mime-Version: 1.0
References: <20220311055056.57265-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [RFC PATCH 101/105] KVM: selftests: Require vCPU output array when
 creating VM with vCPUs
From:   Sean Christopherson <seanjc@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>
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

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 861d18ed868d..3a09ed1a02d2 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -311,10 +311,11 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 				      struct kvm_vcpu *vcpus[])
 {
 	uint64_t vcpu_pages, extra_pg_pages, pages;
-	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	int i;
 
+	TEST_ASSERT(!nr_vcpus || vcpus, "Must provide vCPU array");
+
 	/* Force slot0 memory size not small than DEFAULT_GUEST_PHY_PAGES */
 	if (slot0_mem_pages < DEFAULT_GUEST_PHY_PAGES)
 		slot0_mem_pages = DEFAULT_GUEST_PHY_PAGES;
@@ -342,11 +343,8 @@ struct kvm_vm *__vm_create_with_vcpus(enum vm_guest_mode mode, uint32_t nr_vcpus
 	vm_create_irqchip(vm);
 #endif
 
-	for (i = 0; i < nr_vcpus; ++i) {
-		vcpu = vm_vcpu_add(vm, i, guest_code);
-		if (vcpus)
-			vcpus[i] = vcpu;
-	}
+	for (i = 0; i < nr_vcpus; ++i)
+		vcpus[i] = vm_vcpu_add(vm, i, guest_code);
 
 	return vm;
 }
-- 
2.35.1.723.g4982287a31-goog

