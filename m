Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A434C5284
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 01:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbiBZARR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 19:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240463AbiBZAQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 19:16:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB972255BF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:15 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id g31-20020a63521f000000b003783582a261so1439648pgb.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=G398P7RcaSAEnVDGuXyKG1MtPaHrsCLmNhGjwb/vYpg=;
        b=R8L3GXb2iyMDkg0JQmqrX2X7ARQEO+Z7DOJsS5/5XHBLGcLkRCgSn+ANc7wRoFYg99
         ziYt2seRoQuDB2HvG+EaZ9MHLF2GdsHB4o6qqxE6aBd5DNyFAXDZVzz1EYDnRcxhC2r4
         S2geRnlh62kLBJUVLBy6yVJwLY3RQyPv7AMJNmGocuZKnW1uRQsNZwh94q4Q4XbXlmKL
         foeaFq/xbag68suV0gOwJO0JXHPCBFEy+Mo35Qyr75jDB+S25pbbpHqdxicOZ+5rd6Op
         QPt3fLxyXF2hsSO7/EYM6J+XV840P5D+ooewjyfq+2Hyw3hak7qvX8oJmmD6hR5m0xAC
         2U/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=G398P7RcaSAEnVDGuXyKG1MtPaHrsCLmNhGjwb/vYpg=;
        b=0RcgO3YIiVSG0Me6rBvnTFfZp2LnWR3kMcd87rMrZ9YGNu1LAIq/tvN0MUujwM4lSL
         gWZxGyLuEwYeCSCpzhU7Ngq1s0Hgxb6cy65ZmEM+DtPWH/ATNI6ux//VHsov4EIJPGKf
         jZzv80c/74GVXqQNr4zfQ6tKOR3i67RO/PEie6hJuNoH9m76v6UQ1Etu8gHkXCUtLWTI
         KkuiJ+IJ0qzK/bHHBNeqSEGIEGctkGmGwtT9uRXeiK90Qih2qcp06SY8K/P33mKaavHb
         hmm7KfKApXw7lT9GQBeFiYnTocf3B4V/khCEUqhAOB84ph8SRQHrkQwmDCZtIgt9Bwht
         Ew3A==
X-Gm-Message-State: AOAM530XHMQDH8+XSKNRTQddJOAcnfitRr3tuJgs0zSYktQoyAYlX1Zj
        mejX3de7+egyDOxCJrKW2p56Kr7JNNE=
X-Google-Smtp-Source: ABdhPJy7lHJWDyxwAWHN4q2rpPYcO/QcoMfFh0Asba4foDlLtm+DAdHJ17610fWaI/B/snIanvtPDxy+PBc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP id
 mi18-20020a17090b4b5200b001bcb208dc5cmr761907pjb.1.1645834574884; Fri, 25 Feb
 2022 16:16:14 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 26 Feb 2022 00:15:26 +0000
In-Reply-To: <20220226001546.360188-1-seanjc@google.com>
Message-Id: <20220226001546.360188-9-seanjc@google.com>
Mime-Version: 1.0
References: <20220226001546.360188-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 08/28] KVM: x86/mmu: Batch TLB flushes from TDP MMU for MMU
 notifier change_spte
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

Batch TLB flushes (with other MMUs) when handling ->change_spte()
notifications in the TDP MMU.  The MMU notifier path in question doesn't
allow yielding and correcty flushes before dropping mmu_lock.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 arch/x86/kvm/mmu/tdp_mmu.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 848448b65703..634a2838e117 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1203,13 +1203,12 @@ static bool set_spte_gfn(struct kvm *kvm, struct tdp_iter *iter,
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
2.35.1.574.g5d30c73bfb-goog

