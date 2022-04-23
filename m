Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9219950C71B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 06:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbiDWDvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiDWDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:51:15 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEE61C3E48
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:48:19 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id ij17-20020a170902ab5100b00158f6f83068so5804341plb.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 20:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1xXlNuitmBIDnvcFCjqiRv5q853x221AI5N7xfAKCvw=;
        b=Ieha1ltUZLArH56kihEmLOyaNSxIK2twG7xkdpiCELNo5UCcfb1vggkZz9RL3fnwfX
         0PrKYmdnN319T2R6MCRyHOi/2cE2OfEmEIYTitnPdLe2o4Jca2F215W/GNgyRjtwd426
         d9nAiQtpboT76sQ/h5AHKqMAqBJao/zS+ZOlO/rSyuCh6X90Sjw28e/ce/KYoEGm0x0p
         y63JdEvo60hj73YVRQ1eTAapaPh9O+eCPkMUh5qo6bqmoxPd6o9KfUKCBlVu/PiKITli
         JMwbL98H13gphrSULEzFoSbv75jKpC2eCtQ/SnT0NgzN9Du2rLIOoz0kY5zHajyPk0pr
         yJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1xXlNuitmBIDnvcFCjqiRv5q853x221AI5N7xfAKCvw=;
        b=WvfP/hRIQV4ZznAlEWY2PtUD+JTUHAe2O6ewJFw2Tx6AyM4H/CZQLmA7azLGqezlwR
         QuJa8k43q3PbA0E9D2+c9xyvufSqKwOUnby3GNXM+SaVTsiz+r8Y6A7WkosksGnCd1LG
         ZLqdBE/FiU3E0siV6rsiJQLGF9AYGdaHVA5qmugDeMD0bxYoOeDIK4sTrL6U1Q3WxvIE
         ohLk3KNiftjbzZ7TNYdqrXrRtS9/qA3qOvvWy1NXBOHTYYhWq5VbNdOL6e3vmbXmtMEh
         Ngpzaom8hcUuNPTdoaZoMhQJz1+zBlLL4ru48raZX2z6xMRE98hLD49C5YF09dTeAlXW
         7vUA==
X-Gm-Message-State: AOAM530Njq0xXxZwdkNoMN43Bo/BEa+oueu8YXXJ+BC94on1CwCoFSCV
        sTjFirg5tA/lXOelK8eRqTc9AqbUCls=
X-Google-Smtp-Source: ABdhPJyfPN5aVhvQWAJBOV4tNgKYBnOtE/XxNWNn9A1avm3uZilEE7X+6lalb5vG8Nfj4dmjhglENd/AbM0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:2006:0:b0:39d:8460:48a4 with SMTP id
 g6-20020a632006000000b0039d846048a4mr6604430pgg.623.1650685699488; Fri, 22
 Apr 2022 20:48:19 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Apr 2022 03:47:45 +0000
In-Reply-To: <20220423034752.1161007-1-seanjc@google.com>
Message-Id: <20220423034752.1161007-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220423034752.1161007-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH 05/12] KVM: x86/mmu: Drop exec/NX check from "page fault can
 be fast"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Venkatesh Srinivas <venkateshs@google.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tweak the "page fault can be fast" logic to explicitly check for !PRESENT
faults in the access tracking case, and drop the exec/NX check that
becomes redundant as a result.  No sane hardware will generate an access
that is both an instruct fetch and a write, i.e. it's a waste of cycles.
If hardware goes off the rails, or KVM runs under a misguided hypervisor,
spuriously running throught fast path is benign (KVM has been uknowingly
being doing exactly that for years).

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index dfd1cfa9c08c..f1618d8289ce 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3001,16 +3001,14 @@ static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, struct kvm_page_fault *fa
 static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
 {
 	/*
-	 * Do not fix the mmio spte with invalid generation number which
-	 * need to be updated by slow page fault path.
+	 * Page faults with reserved bits set, i.e. faults on MMIO SPTEs, only
+	 * reach the common page fault handler if the SPTE has an invalid MMIO
+	 * generation number.  Refreshing the MMIO generation needs to go down
+	 * the slow path.  Note, EPT Misconfigs do NOT set the PRESENT flag!
 	 */
 	if (fault->rsvd)
 		return false;
 
-	/* See if the page fault is due to an NX violation */
-	if (unlikely(fault->exec && fault->present))
-		return false;
-
 	/*
 	 * #PF can be fast if:
 	 *
@@ -3026,7 +3024,14 @@ static bool page_fault_can_be_fast(struct kvm_page_fault *fault)
 	 *    SPTE is MMU-writable (determined later), the fault can be fixed
 	 *    by setting the Writable bit, which can be done out of mmu_lock.
 	 */
-	return !kvm_ad_enabled() || (fault->write && fault->present);
+	if (!fault->present)
+		return !kvm_ad_enabled();
+
+	/*
+	 * Note, instruction fetches and writes are mutually exclusive, ignore
+	 * the "exec" flag.
+	 */
+	return fault->write;
 }
 
 /*
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

