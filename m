Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2661D47E960
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350562AbhLWWY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350543AbhLWWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:24:01 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D972CC06175C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:00 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r4-20020a654984000000b0033ae6493472so3899011pgs.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=tXPFxhfZ38aogkCCFXR452Gm2Zs80lNiXFSNHzjj/7o=;
        b=p7+PPvAqhGGhQ5aEVa1JNV8vAw5XpTM3/Wrv87i5kJeKFT+kaipf8ekswCgoZUrLbI
         MKVRtcz4gr4Zvo3LqAnyL3cJ3xL5UU9626f0vTktOe4OuXhzBNfo0UfAx0LS7wuR2Mkb
         evpm+bunpn6FMxR8usQd7RrYCnyymmX6HLX7hyRuV4rppD5LGI0q3KrnB7lp4ZYbCN9u
         DnW5BigL08AoHCEnr4bRyG3fPuHzCzEUdX/zj80SrzDoBmGLi3v2F9MjIDFOn4KLRi+k
         ZfYElpUe4qJt8s8Y/wc6NhsSjCv0kP5rtFPkauhbNtJrB6jfwoWYJDtyo0mBs5ivyomB
         6qJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=tXPFxhfZ38aogkCCFXR452Gm2Zs80lNiXFSNHzjj/7o=;
        b=XBt9THy2MyNEaRKno8Hq5AEuasY1UKjBfTWxsQIGMX4eF1czBCummiEkJicbCUL/vo
         7Z2HW8zDsASziqlOgeZvw+k5ivaDkUhP1Eu/eHdscn70PW68WhXLHfCPOv3g8dG4tjUL
         zShn5KYxrGZEmjwIW/f64O4l5Qtg4Bc2n9uELRa4IkWonUA4YsG2ZF7tREl5fjw314K3
         ieN7IHlAGBfmqD3AA+eq0ZmzUTbBMUPM05N0cbl3Rhf1+WKKYoooKT19lrmXSsv6wZ00
         3M8mP16HrS0Ez5FpizTWli4U46mXYfwaMOERrieSIG26kk/aw4HLjT8ScbVTNKKc0lA8
         zXKg==
X-Gm-Message-State: AOAM530vSZ3Zi2h+TdhD9peYd3hOMl71CTKq3hL2FGB3SFVlTfQPsWMJ
        Bb9kROMyvVLXaId4uCZ7f7nciRP/UGA=
X-Google-Smtp-Source: ABdhPJxlR40Lrq8sq395rYUNf+4uJtceakhLDojMiy+LdkXIUmsw0PNh1W6lOHb3Ww3/W19kz2FPjVsshCI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:1f52:: with SMTP id q18mr3702466pgm.386.1640298240415;
 Thu, 23 Dec 2021 14:24:00 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:23:00 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-13-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 12/30] KVM: x86/mmu: Batch TLB flushes from TDP MMU for MMU
 notifier change_spte
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

Batch TLB flushes (with other MMUs) when handling ->change_spte()
notifications in the TDP MMU.  The MMU notifier path in question doesn't
allow yielding and correcty flushes before dropping mmu_lock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 05f35541ff2f..6c51548d89b1 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1174,13 +1174,12 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
  */
 bool kvm_tdp_mmu_set_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
 {
-	bool flush = kvm_tdp_mmu_handle_gfn(kvm, range, set_spte_gfn);
-
-	/* FIXME: return 'flush' instead of flushing here. */
-	if (flush)
-		kvm_flush_remote_tlbs_with_address(kvm, range->start, 1);
-
-	return false;
+	/*
+	 * No need to handle the remote TLB flush under RCU protection, the
+	 * target SPTE _must_ be a leaf SPTE, i.e. cannot result in freeing a
+	 * shadow page.  See the WARN on pfn_changed in __handle_changed_spte().
+	 */
+	return kvm_tdp_mmu_handle_gfn(kvm, range, set_spte_gfn);
 }
 
 /*
-- 
2.34.1.448.ga2b2bfdf31-goog

