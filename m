Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5630F49455A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358089AbiATBHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358059AbiATBH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:07:29 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75933C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:29 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id z3-20020a17090a468300b001b4df1f5a6eso2925655pjf.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7/mr3VAZ+GGwhFCFeDChGtplD3crV8sSPlyeJQ/WW78=;
        b=h/W8byg/FWcCNjEgb8CsHlM5dZ+jci1WvPkSRhZu+0zijU22D1Ea30LhYvfuHFqhf2
         XPJYrAjjfiNdXe4hxqzf07LF0Gsp+2SGewdv2xfH9/WY5gpNeaEGrznxKQgdvMaETJUF
         vTG9FTPG4ill1PYBj1T3xmwg0sI1HGrWhcSAy3Dg4/gDrlZzDQ7ev4hMEx4+xiFBzfJ0
         GQWtqnz+VVaF5rbEVyFoj+Sg9aTTwahg3TAb3GQcb9iN+XGdDL0/YEIhjkkqpUO9wn0r
         JGncI/1jztmotAHVBnnfGo3GpunEJ14Mi92O2IBP6n8H6h/dBPSU3DCaWfzfL9q889q1
         AdhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7/mr3VAZ+GGwhFCFeDChGtplD3crV8sSPlyeJQ/WW78=;
        b=wzhoi0bx6rXTbJh86wg+TPxTwukgKXJSlVNo8jn4BwU8HSXYrtuP4F7diUZjCKziax
         TqpQv7KJYjvk+ImoisTHj0Ikv1JRJNJeY5ujK5R8biWHxZuFqmBNG6U/lpFVEzy8iP6D
         mn3wdGh/rk6tQ5jseXLao9pWi2j+Cv/OzCFvI7orD/9bG6RYQb1kaRVMT+4aJR+NK/BG
         Hg7gppoIKRPRzX7A+6rAs6cA4VPMW4mlRJ3J3HiWAJrU5ZMDLFp6GByO+IojBMtOffcC
         i4Q8Hk2frmXvihA3ZUUrh6PEebU9U6zYvTQYJbysqdrEVfLI4Q++Xz8tCk6NnjEajOD9
         DE3A==
X-Gm-Message-State: AOAM530CrgiFtIuPcDb3XcKbmz7LMhZxZsCh0rk0fAPT99Ifxp3RTCF4
        45nyETFBkLRQRR5w7URPUqqzfavajCk=
X-Google-Smtp-Source: ABdhPJxpIFaRY6m9RVeY2dlkSROIH2RV6i5rE15nHnu+I39Q/AeGO617waVxL2cl4tvEFjn1+pqmufrUJA0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:13aa:b0:4c1:e99b:2084 with SMTP id
 t42-20020a056a0013aa00b004c1e99b2084mr31574313pfg.19.1642640848679; Wed, 19
 Jan 2022 17:07:28 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 20 Jan 2022 01:07:13 +0000
In-Reply-To: <20220120010719.711476-1-seanjc@google.com>
Message-Id: <20220120010719.711476-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220120010719.711476-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 3/9] KVM: SVM: Don't intercept #GP for SEV guests
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Never intercept #GP for SEV guests as reading SEV guest private memory
will return cyphertext, i.e. emulating on #GP can't work as intended.

Cc: stable@vger.kernel.org
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 85703145eb0a..edea52be6c01 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -312,7 +312,11 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
 				return ret;
 			}
 
-			if (svm_gp_erratum_intercept)
+			/*
+			 * Never intercept #GP for SEV guests, KVM can't
+			 * decrypt guest memory to workaround the erratum.
+			 */
+			if (svm_gp_erratum_intercept && !sev_guest(vcpu->kvm))
 				set_exception_intercept(svm, GP_VECTOR);
 		}
 	}
@@ -1010,9 +1014,10 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 	 * Guest access to VMware backdoor ports could legitimately
 	 * trigger #GP because of TSS I/O permission bitmap.
 	 * We intercept those #GP and allow access to them anyway
-	 * as VMware does.
+	 * as VMware does.  Don't intercept #GP for SEV guests as KVM can't
+	 * decrypt guest memory to decode the faulting instruction.
 	 */
-	if (enable_vmware_backdoor)
+	if (enable_vmware_backdoor && !sev_guest(vcpu->kvm))
 		set_exception_intercept(svm, GP_VECTOR);
 
 	svm_set_intercept(svm, INTERCEPT_INTR);
-- 
2.34.1.703.g22d0c6ccf7-goog

