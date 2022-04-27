Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C48A510E10
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 03:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356916AbiD0Bnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 21:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356860AbiD0Bn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 21:43:27 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277EDF56
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:40:16 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m6-20020a17090a730600b001d9041534e4so138377pjk.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 18:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=rawRdx79XoHw8u43omV3BLmCVZwqFd6EN+RncnsvFlQ=;
        b=Wy77UfIaH1Mz9LQ3+COp24Uf6HTFpZN3jikhvs5fDCb3iOPjgt5BDq5JW28/5uZEgW
         EfhDviZS9N2Rj9bFTfA2iNGMgNU0M9nHiAUnW16ps6fAaocJBj1JFneqZOYBNnH0/D2o
         v0RwN8ACclFIH5cHcM4vRBa3fTFlm1cgcGo6O+BP0xyTbp0LHTVecQhWa/mX7GfSj9s9
         WL8GrinfpesY+cgz5KFFUpm76wbH4242+dMvlTM5l9y/Flz4ffOG+o7khGfNHZDpAKFH
         Y8F4dIVBmZOPCGCR1dxkxSNv93kBBXZZSnt1urN6U1Mk0+7lpfW1wI0RETVqjnc5Ut8i
         M2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=rawRdx79XoHw8u43omV3BLmCVZwqFd6EN+RncnsvFlQ=;
        b=iPFuvoOjejKZlp3JYF46RJSchyGfGTTDEMcbxAK22o8U5zPGp8VfiVE6OAqJavMRh0
         xjtfKHdty0t3D9HOAoQ1xd8c5a45O2iS4aG8LuX5Dk+xPu0Q1y9d73qXhiwUuYyYOOfd
         8GASWmCHXOFzV7j+7ro0Yi9Vp01Hmzv1Hzekrk4+bUfy86ie3/Bur/ne6I3t4OSVQ1TQ
         tHRKka3QJUPIF7imBVJJkX0p+6I1fz6qfSVL3MTBjlDqF71Q7FR9TsZJ7LUk0qJRO2FB
         oJUwovdLi2aCBEYKbCvkc60bIe/+OhZhrLYWBElQgdVM74Hj/rEbc4Z1xcZ9Z2sCwk/R
         3qAg==
X-Gm-Message-State: AOAM5305SniRd29rEnR1Z/JScFd6E/WMTqESP5dPEwlQD5+qECfGMsrT
        YDqN0z9xByn8PnE0L6tQ3RJbL73Ic7s=
X-Google-Smtp-Source: ABdhPJxHu98OqKrbCDEoXrAFUU0bOj8alASiiDJ2JP3PBWJVsUZI7J3kcLtf88ASn3gUX5Vp4RckwrphTes=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:cf:b0:1d9:44ad:2607 with SMTP id
 v15-20020a17090a00cf00b001d944ad2607mr20399981pjd.25.1651023616264; Tue, 26
 Apr 2022 18:40:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 27 Apr 2022 01:40:00 +0000
In-Reply-To: <20220427014004.1992589-1-seanjc@google.com>
Message-Id: <20220427014004.1992589-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220427014004.1992589-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 4/8] KVM: Put the extra pfn reference when reusing a pfn in
 the gpc cache
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
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

Put the struct page reference to pfn acquired by hva_to_pfn() when the
old and new pfns for a gfn=>pfn cache match.  The cache already has a
reference via the old/current pfn, and will only put one reference when
the cache is done with the pfn.

Fixes: 982ed0de4753 ("KVM: Reinstate gfn_to_pfn_cache with invalidation support")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index e05a6a1b8eff..40cbe90d52e0 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -206,6 +206,14 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 
 		if (gpc->usage & KVM_HOST_USES_PFN) {
 			if (new_pfn == old_pfn) {
+				/*
+				 * Reuse the existing pfn and khva, but put the
+				 * reference acquired hva_to_pfn_retry(); the
+				 * cache still holds a reference to the pfn
+				 * from the previous refresh.
+				 */
+				gpc_release_pfn_and_khva(kvm, new_pfn, NULL);
+
 				new_khva = old_khva;
 				old_pfn = KVM_PFN_ERR_FAULT;
 				old_khva = NULL;
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

