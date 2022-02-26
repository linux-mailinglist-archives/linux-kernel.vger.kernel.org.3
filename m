Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CF14C529D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiBZARZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240524AbiBZAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:16:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F1A2261D2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:17 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id t7-20020a634447000000b0036579648983so3492393pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=GLAMaXO4BLnbAIX6/AcgYNLqdWbaIIgMTgsuYxMQrpk=;
        b=IPBFBbCu7NaqWZPAwKKolZZ7oYeFq3VbCvxdfwxTJg7sDDIHVVNvQ+JzTDvbEWoaSm
         JPyFzrWUNkecgHpj8QiukTXlwmFWIN6NsPOuVRTdiMBxdLhExWwS54vP8lvV9wxlLzAk
         crDpVn+H2Gu4Jf5TVQTru59EVW2Ikn1TJUE9ESs1Kzrw4HQbGm24VbOGAU0i8ovY7ov7
         dC15CQL3p9ur70HdDnvJZTi8QNCO2/AsxHOqOj49EXETuI33UMOH1MnrAcLf0RKXiwU9
         dxu6skrBMSqR5SD2fAf+nOXqMJkKBu4qPwfBoYRfAxioYxRze7VllMVXgpicU9bJJC+l
         f7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=GLAMaXO4BLnbAIX6/AcgYNLqdWbaIIgMTgsuYxMQrpk=;
        b=PFJgbJBkTUpXC6nou+SN/voTqVZj2pq76f8Vv73M2BtjgM0OMuUaJBh9s1q8vyF8Vk
         z/e7Dm+p6+ChL1aRbfY7sEtZ0xDKPPhI85QCAFZhTb6knoDsj3kj5qed/GT364k2LUfC
         7wIt1dUheTlaeGIpakcmQfHXmSwNmmYGngagl+qmIiBp/Zke9uexSlx2799XoJmr+j3F
         wK255IbJC+UshfxcpREeUyN5QKCEKB6p/e/DVXrjbbR3hHrDJDzGO+6KEwmOSK+mhrX3
         P8edSsN7xYNoMS2Eb3HcahYirEU1kbqoNwYVGsuysETW95ouG2Hmg/R6gQ2W6mbANHSc
         Y7+g==
X-Gm-Message-State: AOAM532d8RbHXndq5fbHoj4YcLRiwqDmGD5eZ3IH+Eftq3syFhmrLGqY
        8MNieAAx7unWqotjr0tJiT0BT7yMkMg=
X-Google-Smtp-Source: ABdhPJx8rYJ83MXizyFpwRKKPP/3gcYAoJ2ByXAk92IyTDKirx3ywRF4qjmtmIJKkIa8SfBeZxMvIoxCRF0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3018:b0:4e1:de9a:a5a3 with SMTP id
 ay24-20020a056a00301800b004e1de9aa5a3mr10262616pfb.80.1645834576574; Fri, 25
 Feb 2022 16:16:16 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:27 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 09/28] KVM: x86/mmu: Drop RCU after processing each root in
 MMU notifier hooks
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
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
 arch/x86/kvm/mmu/tdp_mmu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 634a2838e117..4f460782a848 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1100,18 +1100,18 @@ static __always_inline bool kvm_tdp_mmu_handle_gfn(struct kvm *kvm,
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
-	}
 
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 
 	return ret;
 }
-- 
2.35.1.574.g5d30c73bfb-goog

