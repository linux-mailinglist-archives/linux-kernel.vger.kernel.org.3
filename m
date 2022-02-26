Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402044C528E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241084AbiBZASX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240494AbiBZARa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:17:30 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1422A294
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:32 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id t7-20020a634447000000b0036579648983so3492693pgk.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=YcD14cPLYHRqCUN9XMqsA1N9iI/pU6jOe1s6Rx79mLg=;
        b=g2WIVIjucKcc3FeIMYEg1JqP8sH7orBfOFiRQ1HLRZYZiypl1HiH1GM7aL3Mn0jfc3
         Zfk2B0RPCqztAdRLIp61/bnAGdzjSAuoGODazTgygTETjUDBQLRTAppOIA6z7Zt/nCyf
         T4JO0+PjzV1XHbQAqzIn/57gBeaUkfrDWwsyxOvG5bvcUcRIfq4oqmHxE/b087WnJgRi
         vAprnAM5+Gwdv4cPPtbCt72aVuIkMLh/p0OneGBIQL6DCwxl5BWu8bLBjQ278loJa+1e
         ORLiFR6OU0prTd2CtEi8zG1iwoxdGN3cs/S5KYMLoE4j3sPu2SihnHhoI+rwZZp20oIH
         VlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=YcD14cPLYHRqCUN9XMqsA1N9iI/pU6jOe1s6Rx79mLg=;
        b=Twx9ZMvQWnoCOyMe501eOg5PBy2eRd9I1sawkdvPC4raVGa0glPAPS6LCShpRjdzY3
         Ea1eRNhIos+4nZ0awrYKD8yiCteUv2eq3VBClrUDV4t2b2xQ8Okw+d4BCwvONeMzu6dp
         6bfzg3hAWx7mPrxNpMkO7Y3ay/VztbvFbb/IP7AUBv7GJTjwsoMBhw74u00DaXuTM3zL
         v3zgx9UxNp5nsOMM6q7TZQd7o8tNC365oC9i0oheKIMpkA6XRfJEHXCroljsxU0bBjbG
         F+0y4S6uGRRmnQ+J+u82qYFleKAoNfx0GNhFogWfS6q+Wb+gY+u3peYPXPdKPnFMQ4ki
         WuEg==
X-Gm-Message-State: AOAM532PtcqvlMYc8obRLqZGEnWpeeNmMuZ/pNbPjbvqqvGi4CIoO0Q4
        UuWha3Bs0UMTrTe/IDzwnUW2YLoBaGE=
X-Google-Smtp-Source: ABdhPJyHiBIYgUmO1kHJu6ywpURyknS4uCXFRG4yfpCyMmM+FKVa0coTEtdb7K6OSSSwzo4ko7n3RPKzjxc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:90d5:0:b0:4e1:307c:d94a with SMTP id
 k21-20020aa790d5000000b004e1307cd94amr10184465pfk.38.1645834591703; Fri, 25
 Feb 2022 16:16:31 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:36 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-19-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 18/28] KVM: x86/mmu: Do remote TLB flush before dropping
 RCU in TDP MMU resched
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When yielding in the TDP MMU iterator, service any pending TLB flush
before dropping RCU protections in anticipation of using the caller's RCU
"lock" as a proxy for vCPUs in the guest.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 42803d5dbbf9..ef594af246f5 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -730,11 +730,11 @@ static inline bool __must_check tdp_mmu_iter_cond_resched(struct kvm *kvm,
 		return false;
 
 	if (need_resched() || rwlock_needbreak(&kvm->mmu_lock)) {
-		rcu_read_unlock();
-
 		if (flush)
 			kvm_flush_remote_tlbs(kvm);
 
+		rcu_read_unlock();
+
 		if (shared)
 			cond_resched_rwlock_read(&kvm->mmu_lock);
 		else
-- 
2.35.1.574.g5d30c73bfb-goog

