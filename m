Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33DD4CC651
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 20:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiCCTl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 14:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236257AbiCCTkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 14:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E220D1A58EB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 11:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646336360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Boa1TP8IeTEunzIctxrLWdjetXvuWlhCamHEs3TLOHI=;
        b=A+VHOA94OOWO0VucJnY9UAnCh3rRIl+0AskL3K+C1tqLYxakAhUyI8vBJe0qg9tPVOH0+R
        PjbL15se7NCqHo+oER6tSWjdVHnwC02NPLUgn0WICTjF36nTu1ZPgAzPcNMyK+LFHEfP0w
        foO7fAqIEgmK+PNfngEo9W5HQoNYHSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-RwmVYF3PMYKXB9cNMD8tug-1; Thu, 03 Mar 2022 14:39:17 -0500
X-MC-Unique: RwmVYF3PMYKXB9cNMD8tug-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF54801AFE;
        Thu,  3 Mar 2022 19:39:16 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79BB65C64D;
        Thu,  3 Mar 2022 19:39:15 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Hildenbrand <david@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: [PATCH v4 25/30] KVM: x86/mmu: Check for a REMOVED leaf SPTE before making the SPTE
Date:   Thu,  3 Mar 2022 14:38:37 -0500
Message-Id: <20220303193842.370645-26-pbonzini@redhat.com>
In-Reply-To: <20220303193842.370645-1-pbonzini@redhat.com>
References: <20220303193842.370645-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <seanjc@google.com>

Explicitly check for a REMOVED leaf SPTE prior to attempting to map
the final SPTE when handling a TDP MMU fault.  Functionally, this is a
nop as tdp_mmu_set_spte_atomic() will eventually detect the frozen SPTE.
Pre-checking for a REMOVED SPTE is a minor optmization, but the real goal
is to allow tdp_mmu_set_spte_atomic() to have an invariant that the "old"
SPTE is never a REMOVED SPTE.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Message-Id: <20220226001546.360188-24-seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 2456f880508d..89e6eb6640fe 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1202,7 +1202,11 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 		}
 	}
 
-	if (iter.level != fault->goal_level) {
+	/*
+	 * Force the guest to retry the access if the upper level SPTEs aren't
+	 * in place, or if the target leaf SPTE is frozen by another CPU.
+	 */
+	if (iter.level != fault->goal_level || is_removed_spte(iter.old_spte)) {
 		rcu_read_unlock();
 		return RET_PF_RETRY;
 	}
-- 
2.31.1


