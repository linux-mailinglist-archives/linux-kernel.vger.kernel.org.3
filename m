Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A10514006
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 03:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353781AbiD2BHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 21:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353722AbiD2BHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 21:07:46 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4A0BC875
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:26 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id y141-20020a626493000000b0050d8c0745a3so2650604pfb.21
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 18:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=Y7gKLvAp1p3RveznRBbFbm0Lo+y5YcSRX+jDV0xbRUg=;
        b=tWtOMpTlPqSbHAZ8AAAvm3vq0wYzfMiDS/xjibTVhQZwl1kosm21QeZ+m0cvPeadDt
         fKKRPAowcoyMjIM+O/pVXZ1bArrkezATPs9brXibFoXkyq62Zm0wcwh3ZJFQeTZw4NvP
         7s8b61eNJ7GAYqThh3iPajH3arbG2tuEPBYSOHFhoA2/cwoS2lUHQPoJjn0Ayhqyne7y
         Dl5Puug2mvk711k/5Py9zES5RHwyuP71kCAakgimAS5doPEOqAL1c8AEzutoejzI97Q7
         4xgVxMUmOansFxt8LR5869MwXRevwSQdWJwpNQ6n512AndjShI5uE+KGXYevcdH2s2z4
         ii+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=Y7gKLvAp1p3RveznRBbFbm0Lo+y5YcSRX+jDV0xbRUg=;
        b=n8GqOotbA7ADVDZsiJE9hUmuu9o0PXo7F+PzNv/PXdhZGRc3GoFrK8x3hLEchUM5rj
         Dc/g9reAWb1++eR80A8p7zIPm1uFxjUZt7nSMbv6dkqJ0c464drpgzAftxmokSpF/CBp
         hyczHyij/IEtVW2cVTf4OiGy6ULEOtKkqyxDf1/1VjgWSCKigVzpz13/zK6Dvi8M4s9Y
         N8kCRt5/nicnf9YVP4fC948cJ06ivk4y/12P367kIJ0YiLsNqvV0lX6ksv9EU+eyefxT
         ZOilxPEBhDh1XfChMTNqNeB2DqQIEUS8C0DVj83MERCaZG8zVXJcDBdGxPVBPZhyGXjN
         f97w==
X-Gm-Message-State: AOAM532hzKiwHihgUI0PmgOUrHXqovztJOa6t9aK8bepeT70a5iK7lpy
        pf8v4ZNNLhpFwTNRGvnLhwy2FrahwkI=
X-Google-Smtp-Source: ABdhPJwu72FzzFGpQThtNokReT4b9ApF02OAzwe9Fv4hC2B6uwlF5JMCh5iypRnr5EbK1PvBsiUXjY6rPNw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1e4e:b0:1da:3936:dc2e with SMTP id
 pi14-20020a17090b1e4e00b001da3936dc2emr1146759pjb.20.1651194265530; Thu, 28
 Apr 2022 18:04:25 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Apr 2022 01:04:10 +0000
In-Reply-To: <20220429010416.2788472-1-seanjc@google.com>
Message-Id: <20220429010416.2788472-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220429010416.2788472-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 04/10] KVM: Avoid pfn_to_page() and vice versa when releasing pages
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert the order of KVM's page/pfn release helpers so that the "inner"
helper operates on a page instead of a pfn.  As pointed out by Linus[*],
converting between struct page and a pfn isn't necessarily cheap, and
that's not even counting the overhead of is_error_noslot_pfn() and
kvm_is_reserved_pfn().  Even if the checks were dirt cheap, there's no
reason to convert from a page to a pfn and back to a page, just to mark
the page dirty/accessed or to put a reference to the page.

Opportunistically drop a stale declaration of kvm_set_page_accessed()
from kvm_host.h (there was no implementation).

No functional change intended.

[*] https://lore.kernel.org/all/CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/kvm_host.h |  1 -
 virt/kvm/kvm_main.c      | 58 +++++++++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 252ee4a61b58..e32fbde79298 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1116,7 +1116,6 @@ unsigned long gfn_to_hva_memslot_prot(struct kvm_memory_slot *slot, gfn_t gfn,
 				      bool *writable);
 void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
-void kvm_set_page_accessed(struct page *page);
 
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 46d12998732e..ab7549195c68 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2798,18 +2798,40 @@ struct page *kvm_vcpu_gfn_to_page(struct kvm_vcpu *vcpu, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_gfn_to_page);
 
+static bool kvm_is_ad_tracked_page(struct page *page)
+{
+	/*
+	 * Per page-flags.h, pages tagged PG_reserved "should in general not be
+	 * touched (e.g. set dirty) except by its owner".
+	 */
+	return !PageReserved(page);
+}
+
+static void kvm_set_page_dirty(struct page *page)
+{
+	if (kvm_is_ad_tracked_page(page))
+		SetPageDirty(page);
+}
+
+static void kvm_set_page_accessed(struct page *page)
+{
+	if (kvm_is_ad_tracked_page(page))
+		mark_page_accessed(page);
+}
+
 void kvm_release_page_clean(struct page *page)
 {
 	WARN_ON(is_error_page(page));
 
-	kvm_release_pfn_clean(page_to_pfn(page));
+	kvm_set_page_accessed(page);
+	put_page(page);
 }
 EXPORT_SYMBOL_GPL(kvm_release_page_clean);
 
 void kvm_release_pfn_clean(kvm_pfn_t pfn)
 {
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn))
-		put_page(pfn_to_page(pfn));
+		kvm_release_page_clean(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_release_pfn_clean);
 
@@ -2817,40 +2839,34 @@ void kvm_release_page_dirty(struct page *page)
 {
 	WARN_ON(is_error_page(page));
 
-	kvm_release_pfn_dirty(page_to_pfn(page));
+	kvm_set_page_dirty(page);
+	kvm_release_page_clean(page);
 }
 EXPORT_SYMBOL_GPL(kvm_release_page_dirty);
 
 void kvm_release_pfn_dirty(kvm_pfn_t pfn)
 {
-	kvm_set_pfn_dirty(pfn);
-	kvm_release_pfn_clean(pfn);
+	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn))
+		kvm_release_page_dirty(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_release_pfn_dirty);
 
-static bool kvm_is_ad_tracked_pfn(kvm_pfn_t pfn)
-{
-	if (!pfn_valid(pfn))
-		return false;
-
-	/*
-	 * Per page-flags.h, pages tagged PG_reserved "should in general not be
-	 * touched (e.g. set dirty) except by its owner".
-	 */
-	return !PageReserved(pfn_to_page(pfn));
-}
-
+/*
+ * Note, checking for an error/noslot pfn is the caller's responsibility when
+ * directly marking a page dirty/accessed.  Unlike the "release" helpers, the
+ * "set" helpers are not to be unused when the pfn might point at garbage.
+ */
 void kvm_set_pfn_dirty(kvm_pfn_t pfn)
 {
-	if (kvm_is_ad_tracked_pfn(pfn))
-		SetPageDirty(pfn_to_page(pfn));
+	if (pfn_valid(pfn))
+		kvm_set_page_dirty(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_dirty);
 
 void kvm_set_pfn_accessed(kvm_pfn_t pfn)
 {
-	if (kvm_is_ad_tracked_pfn(pfn))
-		mark_page_accessed(pfn_to_page(pfn));
+	if (pfn_valid(pfn))
+		kvm_set_page_accessed(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_set_pfn_accessed);
 
-- 
2.36.0.464.gb9c8b46e94-goog

