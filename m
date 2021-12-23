Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8FC47E964
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 23:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350798AbhLWWYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 17:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350553AbhLWWYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 17:24:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DA2C06175D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:02 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id t29-20020a62d15d000000b004baa073f34fso3994189pfl.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 14:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=BNCCSYnc3JAlm7sEigQj1irsmiDBhrB62HCDCGqzwM4=;
        b=hsx3AHY9e9KGs5P9Y/6uTZVutXLJXF3CgK88i4NdUo3gvWGHAaH/hzMV99ToAe8QNh
         yh8fX6SyxC12fB88YAwO7kI032Jxfa3v6wrr/20tiI0G5ZTkBxI5gW15jV1Zhe58uCKU
         5RZ6gBAO1oksMgd5g0+eF/Eu3NQ5gNj/BE9/GGs9fAct3ToiAprcvH90xNW7o0nNzTuz
         vPi+xQVbNURRJL/SM40i++TwCmFGkFyUeEcHJngaIdf9XWBJWs3LlgKLmCZdcpRBLzuC
         VZyL1E1m/JZ3MTBSITppI5+IHIb/04xt62Xx3BwYUs/MLhjQ/ozRh8weHP29er8X78xs
         7oWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=BNCCSYnc3JAlm7sEigQj1irsmiDBhrB62HCDCGqzwM4=;
        b=bKf8s8aphVEOfFz7AEWcB/IHv5NGsqh1XieNvDO+9nOcI4HSHXmqOCjfbjODsqF/lB
         SWhJWap2+lsycJR6nx7OuFP53zwghyw/WVgkWTnqR49dM5A/vbiwRDbuGnsaBPEByEmc
         nJrStBLNPL+/q+jLCRQEQDvdwinYkh7gBUuZqhjPh2vOcVKh0yBrYeVHJ+9Fq5obj1os
         5y89DOsB+xjIpqxS23kfX/plMWTHuJvakgMaV12tl00Bc6Y3JIEHGSsFvp8DWl4Nw+xa
         CFtO1kcChhA/OezTW0CeZFTB3FL9i3lxQTO+Rjakv//DfOhghnjY5pTQlDYBtkL9OVyL
         I8nw==
X-Gm-Message-State: AOAM530QKaZwSDZ7XJNI8OpoTLR5Th6y/tg0mRYNx6i1dCS4n/UcbaC4
        0+9gU89EtXCUWp/0K/zSKqnUznHt7Ms=
X-Google-Smtp-Source: ABdhPJyrIjNroCeHcGoLme72TYYoLeEFX8HuM7VJuuvDeTFICp/qElBwDUte+nFyADv0mybL0LB72crz4rk=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:e91:: with SMTP id
 fv17mr4976856pjb.217.1640298241971; Thu, 23 Dec 2021 14:24:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 23 Dec 2021 22:23:01 +0000
In-Reply-To: <20211223222318.1039223-1-seanjc@google.com>
Message-Id: <20211223222318.1039223-14-seanjc@google.com>
Mime-Version: 1.0
References: <20211223222318.1039223-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v2 13/30] KVM: x86/mmu: Drop RCU after processing each root in
 MMU notifier hooks
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

Drop RCU protection after processing each root when handling MMU notifier
hooks that aren't the "unmap" path, i.e. aren't zapping.  Temporarily
drop RCU to let RCU do its thing between roots, and to make it clear that
there's no special behavior that relies on holding RCU across all roots.

Currently, the RCU protection is completely superficial, it's necessary
only to make rcu_dereference() of SPTE pointers happy.  A future patch
will rely on holding RCU as a proxy for vCPUs in the guest, e.g. to
ensure shadow pages aren't freed before all vCPUs do a TLB flush (or
rather, acknowledge the need for a flush), but in that case RCU needs to
be held until the flush is complete if and only if the flush is needed
because a shadow page may have been removed.  And except for the "unmap"
path, MMU notifier events cannot remove SPs (don't toggle PRESENT bit,
and can't change the PFN for a SP).

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 6c51548d89b1..47424e22a681 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1071,18 +1071,19 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
 	struct tdp_iter iter;
 	bool ret = false;
 
-	rcu_read_lock();
-
 	/*
 	 * Don't support rescheduling, none of the MMU notifiers that funnel
 	 * into this helper allow blocking; it'd be dead, wasteful code.
 	 */
 	for_each_tdp_mmu_root(kvm, root, range->slot->as_id) {
+		rcu_read_lock();
+
 		tdp_root_for_each_leaf_pte(iter, root, range->start, range->end)
 			ret |= handler(kvm, &iter, range);
+
+		rcu_read_unlock();
 	}
 
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.34.1.448.ga2b2bfdf31-goog

