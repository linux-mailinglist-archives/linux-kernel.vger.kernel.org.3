Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9237C5835AD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 01:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbiG0Xel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 19:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiG0Xeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 19:34:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DA9564E4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:35 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id b8-20020a17090a010800b001f1f4fc8178so46892pjb.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 16:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=9adtlHGn9FKeVF+3PI8cEyItaITWCpmMoTEZzIf1mcM=;
        b=MxgkAjshFD75JkjIup9q/SXMa6S6NoCx9gVLA1H+AQFV5thN3RjNINV2iRYwUHD6EX
         gJZJ5O1ynmeduCLJQt0/UkNObPn8A7bprprHXX1O8RU88TJH4Nj/EawxCIlt+UveuKZY
         imPdS/udjs99VBxkQ3Wdy2BojQjLlbsNxP60/mEjJoIbbiL+5sHSiUK2xQkx/Vryn9ZL
         7TXOoUPd2hJDRQRohZ2BTJzDf6S1hUtfXrZa3Qfz5kfBPqM9aKib6JvBKenSc6PSP4RG
         iY4Lm/Sg1Fhy9o1iM78AMxbcBxl8WkMyk0W7p1NSNYYAh3KV6UFdXjB9X2rLfOuGm86e
         KyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=9adtlHGn9FKeVF+3PI8cEyItaITWCpmMoTEZzIf1mcM=;
        b=c2sorTPfkl5/QrZNFESPuFV5SZ1gvc52at+25YLAzRcptyz5QOBRRwcCtAmvzOfoQp
         7YObShnnKSxvHN87j6BiTfiiRzOdLZI4I3LAmilxMkqqEDbmLIlXh4sbT/os+BcCmDCt
         UDs+PfDFdwJqjE8+1SeO3aaE2b5eWqLuli1LmaUzkZJTO8PgTHYfEeTDk6DKY2wC7+F9
         Ucd8T9WNYbWN4ZzdOY4RqDuVrHpo3Vw+E3FgC2+S+Bksa5ueBUiPGgm2fa3wigpxOYGa
         AisdOIYmZm1uEoE1ML7znTA5h6yGAMHhYl827wP57JKrBu4/3La5akuF6jmZwSCOtU0r
         HeBA==
X-Gm-Message-State: AJIora/AcV9wNkQKGejwAKf8X0cAFhxED5pY3MwfQfW/TbFk5+X7A/uU
        uILLMz5tdLn9Ak6AbrMH43Pwgx1SihU=
X-Google-Smtp-Source: AGRyM1t4yxhEgp8+BSQkOzsakccZRL77cL08/ZNyF5q5C7BitXgV7iYO7x2oypitk2O1HFgkgsi3N9utlD8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d507:b0:16d:7d89:15dc with SMTP id
 b7-20020a170902d50700b0016d7d8915dcmr14924262plg.31.1658964875032; Wed, 27
 Jul 2022 16:34:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Jul 2022 23:34:23 +0000
In-Reply-To: <20220727233424.2968356-1-seanjc@google.com>
Message-Id: <20220727233424.2968356-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220727233424.2968356-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH 2/3] KVM: VMX: Use proper type-safe functions for vCPU => LBRs helpers
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turn vcpu_to_lbr_desc() and vcpu_to_lbr_records() into functions in order
to provide type safety, to document exactly what they return, and to
allow consuming the helpers in vmx.h.  Move the definitions as necessary
(the macros "reference" to_vmx() before its definition).

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.h | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 286c88e285ea..690421b7d26c 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -6,6 +6,7 @@
 
 #include <asm/kvm.h>
 #include <asm/intel_pt.h>
+#include <asm/perf_event.h>
 
 #include "capabilities.h"
 #include "kvm_cache_regs.h"
@@ -91,15 +92,6 @@ union vmx_exit_reason {
 	u32 full;
 };
 
-#define vcpu_to_lbr_desc(vcpu) (&to_vmx(vcpu)->lbr_desc)
-#define vcpu_to_lbr_records(vcpu) (&to_vmx(vcpu)->lbr_desc.records)
-
-void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
-bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
-
-int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
-void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
-
 struct lbr_desc {
 	/* Basic info about guest LBR records. */
 	struct x86_pmu_lbr records;
@@ -524,6 +516,22 @@ static inline struct vcpu_vmx *to_vmx(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct vcpu_vmx, vcpu);
 }
 
+static inline struct lbr_desc *vcpu_to_lbr_desc(struct kvm_vcpu *vcpu)
+{
+	return &to_vmx(vcpu)->lbr_desc;
+}
+
+static inline struct x86_pmu_lbr *vcpu_to_lbr_records(struct kvm_vcpu *vcpu)
+{
+	return &vcpu_to_lbr_desc(vcpu)->records;
+}
+
+void intel_pmu_cross_mapped_check(struct kvm_pmu *pmu);
+bool intel_pmu_lbr_is_enabled(struct kvm_vcpu *vcpu);
+
+int intel_pmu_create_guest_lbr_event(struct kvm_vcpu *vcpu);
+void vmx_passthrough_lbr_msrs(struct kvm_vcpu *vcpu);
+
 static inline unsigned long vmx_get_exit_qual(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
-- 
2.37.1.359.gd136c6c3e2-goog

