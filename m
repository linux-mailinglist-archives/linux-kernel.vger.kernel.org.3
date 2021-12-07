Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEB46C730
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhLGWNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242134AbhLGWNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:13:14 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A94C061A72
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:09:43 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id x133-20020a62868b000000b004af20852f9eso372628pfd.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=ApQQ4FImCNgNKftdWoSXlDKhYCulVO32cTDl5cVzGMA=;
        b=MPRHAcH3Al1Ez9uI761ACxB74NEDwSPFCQ1BG8SzyYlDMFclclTtEa+s0eZmWahnBN
         aIHVa2kkDtUY7gAEE92ud1O01ZodfoEzuZW47N8hGMiuGYj8U0uZkD4N6x7+yLsw/23o
         BOm3U/3CdoX0+lGqEH0TxbMMXczI36PsFgJ5AZuwc8nv5BGgQcXpihHhzK50qRLMRHR9
         E4itmTFtFzTghdGpCFZi6xgCLTn2XqzB1bd6bB0Dc8pV7GuYpJCWSU3e2a7lruiklvnw
         8U/fnL+DIbmRs/x0L9o6/vtEmHgSOiEdUpNoeze85YAGhQKn6S3juKQzhKEKRjCPihbK
         pTbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=ApQQ4FImCNgNKftdWoSXlDKhYCulVO32cTDl5cVzGMA=;
        b=Pa5DUWcODOisQkJ9SXTyi+46XuzeyEZvb9W0M/WtuC/SkMMFROg5PtagGKDrwGQCuP
         nQiXgynuERUTItLN5t6Wu6Ilq922IqjUcTPtQ3W6+nMF2pLnjCQcwzaoGZdC76HExshA
         d/O6wwPI7CjmKpmIVcCkOizLahQs8BO+FqxGRq8qkV+p93M2BdHyQpkaulH0sFQcjRu9
         IuCM1CtKRSfJkr7ZYtrsk2mr7DJEihlssnVO/iM+XGFtGXi0YIEZmRMP0+ofHNB8CniQ
         GjN3sLyCFQ9QLUf8h08LakqM39CLPH71P/TWhSwvENPZbVA2nRrSPCm2d3r0KPfnU5VL
         2b+A==
X-Gm-Message-State: AOAM532OoNZ0sDeRc9Z268pFfGRnw5zDOHfax4arvSUPswqr6Kvt40xX
        FFj036NTRB3N9pxwArz+e3Gy2JkLt5w=
X-Google-Smtp-Source: ABdhPJxTlpZ6Ouugf0KWJ32F3yADamWeF5gWzHgju2KZnp/kRnQtxhnlg5Viye6fk6pPdNzaUiTAW2EH18I=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4c44:: with SMTP id
 np4mr2342404pjb.195.1638914983425; Tue, 07 Dec 2021 14:09:43 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Dec 2021 22:09:22 +0000
In-Reply-To: <20211207220926.718794-1-seanjc@google.com>
Message-Id: <20211207220926.718794-5-seanjc@google.com>
Mime-Version: 1.0
References: <20211207220926.718794-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 4/8] KVM: x86: Add a helper to get the sparse VP_SET for
 IPIs and TLB flushes
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ajay Garg <ajaygargnsit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper, kvm_get_sparse_vp_set(), to handle sanity checks related to
the VARHEAD field and reading the sparse banks of a VP_SET.  A future
commit to reduce the memory footprint of sparse_banks will introduce more
common code to the sparse bank retrieval.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 9bc856370a2d..680ba3d5d2ad 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1751,10 +1751,19 @@ struct kvm_hv_hcall {
 	sse128_t xmm[HV_HYPERCALL_MAX_XMM_REGISTERS];
 };
 
+static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
+				 u64 *sparse_banks, gpa_t offset)
+{
+	if (hc->var_cnt > 64)
+		return -EINVAL;
+
+	return kvm_read_guest(kvm, hc->ingpa + offset, sparse_banks,
+			      hc->var_cnt * sizeof(*sparse_banks));
+}
+
 static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool ex)
 {
 	int i;
-	gpa_t gpa;
 	struct kvm *kvm = vcpu->kvm;
 	struct hv_tlb_flush_ex flush_ex;
 	struct hv_tlb_flush flush;
@@ -1831,13 +1840,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 			goto do_flush;
 		}
 
-		if (hc->var_cnt > 64)
-			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-
-		gpa = hc->ingpa + offsetof(struct hv_tlb_flush_ex,
-					   hv_vp_set.bank_contents);
-		if (unlikely(kvm_read_guest(kvm, gpa, sparse_banks,
-					    hc->var_cnt * sizeof(sparse_banks[0]))))
+		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
+					  offsetof(struct hv_tlb_flush_ex,
+						   hv_vp_set.bank_contents)))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
@@ -1934,14 +1939,9 @@ static u64 kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc, bool
 		if (!hc->var_cnt)
 			goto ret_success;
 
-		if (hc->var_cnt > 64)
-			return HV_STATUS_INVALID_HYPERCALL_INPUT;
-
-		if (kvm_read_guest(kvm,
-				   hc->ingpa + offsetof(struct hv_send_ipi_ex,
-							vp_set.bank_contents),
-				   sparse_banks,
-				   hc->var_cnt * sizeof(sparse_banks[0])))
+		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks,
+					  offsetof(struct hv_send_ipi_ex,
+						   vp_set.bank_contents)))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
-- 
2.34.1.400.ga245620fadb-goog

