Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0F5F47E95F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350746AbhLWWY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350512AbhLWWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:23:59 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE5EC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id d3-20020a17090a2a4300b001b22191073dso2924949pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/ZFHgDnOl20L+13r6dn56W2Dom/tt9hnv2FmIwxRFwM=;
        b=c7aAabUUEF7Z0aGr0vLvyy8IDuhevj0wCx5ERJGhthQ2s6qPdaPwqBwnFLd2+hCpU1
         ajO/w2PpD2ZTOFjStPEcYbebnJqx3MrwhY342jfEWaFCHweuJHErV77v9/x0bHrNitbI
         4EYWtrsNTOyCbefcd9QpqyApzGr+VQcV+rFNM4VtRHaTewni+4jMqz9B2BiSHJpZ6Ur0
         fliWu8+4/bS0dJlA3tA7Uf1ADlNcXuuWy3PbWUmzxXcfKHhsLBcqHi6edjz7yM9alCx0
         88AycimElIkDw7Aa2zdt0E5F47ngPmKgIKVxEEcOBwzooU48hif2xF7sa89GTrTyo1D+
         TXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/ZFHgDnOl20L+13r6dn56W2Dom/tt9hnv2FmIwxRFwM=;
        b=U92wvRcpyVjomlYck5826XI5wbWafiL21299OQrJoFQhDpH282LnT+CV9OLaDp0fJV
         J3eBQ3ZeUgPGmRpZSgUvy2d22yejyBI85pzi/FWhnW5/I1rqEZ1EhlFGgQDkr463Q8l8
         oNidHUsoEBok9yqEFzHLfa4eVCsoV2TTt6+XMHgvrCS2ANiioyELODFP9ETqUT+G70Uk
         lekeKOo0gZeV/aBk1iYNLkQq9FuR3jpOA8Dd18Q4euMytkvsc+1FSOPnQJgwG1vwevQO
         63KtOVpxbHVXQ4jO+r4nYXtaJK+T0HjNCsDq41QCAXyap9PwruP8OK3Hdb8evKWmr1VO
         iwiA==
X-Gm-Message-State: AOAM531oxEZ+8Qp9KmASQPmn8pncmCaBTPcduXWoPpv+E2vfHmV0wVkE
        1hbR1DYV6vUpVbsrhoLtQIjETky9HqE=
X-Google-Smtp-Source: ABdhPJye2bSrwx441l0MON1QuD1KSBcBGpRHORrrKCjLQRY2tJ5LQ2b+BT+QRa723WlukEfY87wnLs+P5HM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2391:b0:4a2:cb64:2e01 with SMTP id
 f17-20020a056a00239100b004a2cb642e01mr4191029pfc.45.1640298238813; Thu, 23
 Dec 2021 14:23:58 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:22:59 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-12-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 11/30] KVM: x86/mmu: Check for !leaf=>leaf, not PFN change,
 in TDP MMU SP removal
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Look for a !leaf=>leaf conversion instead of a PFN change when checking
if a SPTE change removed a TDP MMU shadow page.  Convert the PFN check
into a WARN, as KVM should never change the PFN of a shadow page (except
when its being zapped or replaced).

From a purely theoretical perspective, it's not illegal to replace a SP
with a hugepage pointing at the same PFN.  In practice, it's impossible
as that would require mapping guest memory overtop a kernel-allocated SP.
Either way, the check is odd.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 3b13249bbbe1..05f35541ff2f 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -518,9 +518,12 @@ static void __handle_changed_spte(struct kvm *kvm, int as_id, gfn_t gfn,
 
 	/*
 	 * Recursively handle child PTs if the change removed a subtree from
-	 * the paging structure.
+	 * the paging structure.  Note the WARN on the PFN changing without the
+	 * SPTE being converted to a hugepage (leaf) or being zapped.  Shadow
+	 * pages are kernel allocations and should never be migrated.
 	 */
-	if (was_present && !was_leaf && (pfn_changed || !is_present))
+	if (was_present && !was_leaf &&
+	    (is_leaf || !is_present || WARN_ON_ONCE(pfn_changed)))
 		handle_removed_tdp_mmu_page(kvm,
 				spte_to_child_pt(old_spte, level), shared);
 }
-- 
2.34.1.448.ga2b2bfdf31-goog

