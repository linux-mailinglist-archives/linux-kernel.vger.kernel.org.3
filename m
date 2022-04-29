Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0B351564E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381166AbiD2VD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381154AbiD2VDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:03:53 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C813D3AD4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:32 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id p18-20020aa78612000000b0050d1c170018so4679021pfn.15
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=LPVkLBPwEAjA8SToO1l83Vg1lu2tQY9qN9/CiKwVlGU=;
        b=IsuclB30S32MomEEZnx7eKe3YnpywIDDJ3ugO+zUmBmA0U7FjNOrRXhxz8mEqiCI/4
         Tvz5jcIVNNULVi9NPLdtTQzJbS4NAYQnN4+IRtqufEnNf+EfYLGD0lGWhGwFpwedrjxY
         JjfxOH70aDEO18Jn7H4WZt3EV7hHpdrNhK6zCU2927NNekHZu7AgRNdLuivppHKPDzPY
         8OX8/4WD6vHuhbsyGd+PUGXmeh7NZSG9coxaq7+8+lpMMN8EuMZud7fdzW90EgukBLlU
         vU/w7Q0j4A0HYxsvEfW9Cc1qkMpolziiuUAV8PV6pxmcTici3d3wQ7DFOOUzywTX2EkU
         Eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=LPVkLBPwEAjA8SToO1l83Vg1lu2tQY9qN9/CiKwVlGU=;
        b=MpDleNVSqSPhJzvmWmQnL1hFXCu/CfXD8dMz6xuIcix387HsLtHttGOF9RtnJHpQMI
         ccPuqm91S0D2HLZNJKeCB1o59OFnmIg/3OH/R9VOI/qEiwftZje5BYhUhjMBnHW+9/wV
         M/inguRP7JFnzbpQOua2zu3BMf6s1jZhD4dRVNjuUKMjNEklUAgBFwTGLLQd8r9Cs5g2
         fiG+aq02cq/BdIqDR9y5xO1esTcD5+3dx8KKbjyh2VSh3u7wpW7iEwAWzgYZNwa0OFQD
         a34/ytBRalxCRr4fxc6e9EpFzJAKG7kErjt4H4fbbzNmJwe40uhGBJcPbCmQ+PekLqYH
         GODg==
X-Gm-Message-State: AOAM531cnWHOu2Ow8eI2c/YRmxUZvoOkVlcpNWmLLSCGtmKdh4UOus2G
        IRNYD/hiQwJEmvSN2RuzgSklUwEI9ck=
X-Google-Smtp-Source: ABdhPJwF72ZyuLedAAJsbXXnQhkqmpfiH1j4YWQDOOIF9AkF4nAk9MZU1II2RY3xDZCxYwYOWXB0pVgjTr4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:5917:0:b0:39c:c450:3143 with SMTP id
 n23-20020a635917000000b0039cc4503143mr861303pgb.531.1651266031469; Fri, 29
 Apr 2022 14:00:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 29 Apr 2022 21:00:18 +0000
In-Reply-To: <20220429210025.3293691-1-seanjc@google.com>
Message-Id: <20220429210025.3293691-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220429210025.3293691-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v3 1/8] Revert "KVM: Do not speculatively mark pfn cache valid
 to "fix" race"
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Mingwei Zhang <mizhang@google.com>
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

This reverts commit 55111927df1cd140aa7b7ea3f33f524b87776381.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 virt/kvm/pfncache.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 72eee096a7cd..71c84a43024c 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -81,8 +81,6 @@ bool kvm_gfn_to_pfn_cache_check(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 {
 	struct kvm_memslots *slots = kvm_memslots(kvm);
 
-	lockdep_assert_held_read(&gpc->lock);
-
 	if ((gpa & ~PAGE_MASK) + len > PAGE_SIZE)
 		return false;
 
@@ -228,6 +226,11 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 	if (!old_valid || old_uhva != gpc->uhva) {
 		void *new_khva = NULL;
 
+		/* Placeholders for "hva is valid but not yet mapped" */
+		gpc->pfn = KVM_PFN_ERR_FAULT;
+		gpc->khva = NULL;
+		gpc->valid = true;
+
 		new_pfn = hva_to_pfn_retry(kvm, gpc);
 		if (is_error_noslot_pfn(new_pfn)) {
 			ret = -EFAULT;
@@ -256,7 +259,7 @@ int kvm_gfn_to_pfn_cache_refresh(struct kvm *kvm, struct gfn_to_pfn_cache *gpc,
 			gpc->pfn = KVM_PFN_ERR_FAULT;
 			gpc->khva = NULL;
 		} else {
-			gpc->valid = true;
+			/* At this point, gpc->valid may already have been cleared */
 			gpc->pfn = new_pfn;
 			gpc->khva = new_khva;
 		}
-- 
2.36.0.464.gb9c8b46e94-goog

