Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086D946E242
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhLIGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbhLIGJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:09:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB26C0617A1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 22:06:01 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id b8-20020a17090a10c800b001a61dff6c9dso3035970pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 22:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=PUYcIIJKsxBIAAizj0Y9Eh5D3GRB3JGARLuO03M6nuk=;
        b=lJtw45QEza3KMEyzVaRdR8j9tBIr2Fmk1JFaJKCN0HHUj+MaCw/aS8rUhnS/+uInJx
         covrIZyP3ITtMtl9YU0/Nqno2QP4OCaO+4rJ6IKCdz47EvW64j3blNt/qeficIY9iED9
         eduzYL2rCvLF//D7ktTMwRgoJmxURatdPraNKnYXCJzw3bh3jrVJ2klj7qD4u6yw5i7S
         gVRc9g+YV0eViIIGIMFBat6dG8+jOinBDrd65BAWV2A8SnYXntrKoYf21b3u/VqA6Wlb
         w3kWDsDmf61P1YxbhH5fj4CFMF8vmXD6G7IwgPEyvCJTLlC/KOksmwvCBaxD8Iib5jBO
         C4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=PUYcIIJKsxBIAAizj0Y9Eh5D3GRB3JGARLuO03M6nuk=;
        b=QdiQNkFjQJ0jBu1bDHqxiCxNrqJiHKsQZmSvPz4BRlstrJ70+0wGxx68xrAfOEbAx9
         BaNhh0FLDF9uXhwjLXc1yJWNhjNF5KZLpcaU33CKRy2je7BrbyBUYdQsMN4WdWZpnFVw
         YDevP85fNF0bJHMEaw0qLOdBJi6Bs1TTjhLGcjo7qAVNvIQmmVvMwX2FkUg2BP43Tyzb
         zktlS+JXfTcp/FKiN4T6D/ip/6E0fW4huqHlN1c4SChlDmqeMlzw2gvTo+opg1FT1THJ
         vGwaRc/J8OiUQ3g/9GCcOhSoDEzn65+euRne6ljkN+mvxSLRKMbwGmkkBqRU13iv0p+x
         5eMA==
X-Gm-Message-State: AOAM532MeiHyltlMGvg/1inh3dAGl8ny9BhFT8+KFey+Z4EaR4OmOq6B
        SoFM2L9w5iMKCvOZs5Q741v5+ivUPxk=
X-Google-Smtp-Source: ABdhPJyv6Njx687Wa+aodBEX3C/mF2v7CuZORX5Al6AG4vlZ6nFlmJ2Gt0e9cDjHkK7cE4j1JskeZZNTiMI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1057:: with SMTP id
 gq23mr12968391pjb.203.1639029961379; Wed, 08 Dec 2021 22:06:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  9 Dec 2021 06:05:47 +0000
In-Reply-To: <20211209060552.2956723-1-seanjc@google.com>
Message-Id: <20211209060552.2956723-3-seanjc@google.com>
Mime-Version: 1.0
References: <20211209060552.2956723-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 2/7] KVM: x86: Invoke kvm_mmu_unload() directly on CR4.PCIDE change
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace a KVM_REQ_MMU_RELOAD request with a direct kvm_mmu_unload() call
when the guest's CR4.PCIDE changes.  This will allow tweaking the logic
of KVM_REQ_MMU_RELOAD to free only obsolete/invalid roots, which is the
historical intent of KVM_REQ_MMU_RELOAD.  The recent PCIDE behavior is
the only user of KVM_REQ_MMU_RELOAD that doesn't mark affected roots as
obsolete, needs to unconditionally unload the entire MMU, _and_ affects
only the current vCPU.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1aaf37e1bd0f..ca1f0350a868 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1045,19 +1045,18 @@ void kvm_post_set_cr4(struct kvm_vcpu *vcpu, unsigned long old_cr4, unsigned lon
 	 * If CR4.PCIDE is changed 0 -> 1, there is no need to flush the TLB
 	 * according to the SDM; however, stale prev_roots could be reused
 	 * incorrectly in the future after a MOV to CR3 with NOFLUSH=1, so we
-	 * free them all.  KVM_REQ_MMU_RELOAD is fit for the both cases; it
-	 * is slow, but changing CR4.PCIDE is a rare case.
+	 * free them all.  kvm_mmu_unload() is fit for the both cases; it is
+	 * slow, but changing CR4.PCIDE is a rare case.
 	 *
 	 * If CR4.PGE is changed, the guest TLB must be flushed.
 	 *
-	 * Note: resetting MMU is a superset of KVM_REQ_MMU_RELOAD and
-	 * KVM_REQ_MMU_RELOAD is a superset of KVM_REQ_TLB_FLUSH_GUEST, hence
-	 * the usage of "else if".
+	 * Note: resetting MMU is a superset of unloading an MMU, and unloading
+	 * an MMU is a superset of KVM_REQ_TLB_FLUSH_GUEST, hence the "else if".
 	 */
 	if ((cr4 ^ old_cr4) & KVM_MMU_CR4_ROLE_BITS)
 		kvm_mmu_reset_context(vcpu);
 	else if ((cr4 ^ old_cr4) & X86_CR4_PCIDE)
-		kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
+		kvm_mmu_unload(vcpu);
 	else if ((cr4 ^ old_cr4) & X86_CR4_PGE)
 		kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
 }
-- 
2.34.1.400.ga245620fadb-goog

