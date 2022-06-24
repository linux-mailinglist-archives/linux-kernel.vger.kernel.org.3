Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBA055A4CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 01:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiFXX1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 19:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiFXX1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 19:27:40 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1B687D67
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:27:39 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q8-20020a632a08000000b00402de053ef9so1671952pgq.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 16:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=dW110CmxpLoR6tsrnKbsCrhyNhhwKQFoJl0xmU5g8Fk=;
        b=UHP5ZMCM/EZ/FmpbJd0QggOzn8rv1/lvRx9SOfLYDabU7GVNqBKxtn6hzIJN9cRApV
         cb6BzcTsVYekgVaGvNSMyFN7QybeNoWWYsaW7gS0OK+VCsA5Hbjyzt6W4+cdhNPJQp0d
         ucYW/nOGZLXc1iKAlmsYknIpPhN4cvVIkB91x2n1XSv7nNOAUQe2AEwNQpjIpoAdmOic
         uf+tBGTYnhBKagHHfEaqCylqi/aNpiR+lAKrXvbDZmFx1x2j3xHQarZ8v61qDf5BUOV5
         Bx5KAtRXeGE53+19I4MH451gIF5Y0cjbQ2D3QjlFUfDIv6AxLv3n5E4BZ9DQlvFEk6B1
         7MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=dW110CmxpLoR6tsrnKbsCrhyNhhwKQFoJl0xmU5g8Fk=;
        b=yeh5x71zmMdn3pk12LdHQ+A3/ZYi4xzfhimRgCR7mv8nk1UZyQHUHsNrpwgcfhh0y7
         2xAbZ96kkdNfnRAjcDr3ZmTD1mBzMolHFcOWCsCwxfXNyqdRoJGgSh56pHhOjrLuYXPO
         dNo2254H//ZmDOYwE5flt/1Qmsg//b5Qaz/1CXlWiH8PEGDHfgZimmWRA4frkJe45tWx
         9PH1loclRAMca/lArePsx0mxO0TZkidnSQHvKGMFbS7DcACJb3Km48EGdflojhUkw5wS
         Cz7DCNhUF49A4m+2ZIQjLuSb56I9g7+3cbv9FRwFM6MooiEZiK6ZYJYmEPsP0sh1uHbu
         ZRqw==
X-Gm-Message-State: AJIora/swUeXYASAcwdPrGsD26RL754F8ReaUoKv8cwpah3sP0OmZcc+
        us8lBVUpf70TcxPCSZ2mUWmT8Am6TBE=
X-Google-Smtp-Source: AGRyM1tP19W8w4K9fKAqNrHARpt4eRFK66Pa1ohrx9TCRQyj3rN1Dy60outvHCpcH2Ddj/WHL+c3qhczfPw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e541:b0:16a:4b61:5d69 with SMTP id
 n1-20020a170902e54100b0016a4b615d69mr1460177plf.151.1656113259269; Fri, 24
 Jun 2022 16:27:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 24 Jun 2022 23:27:32 +0000
In-Reply-To: <20220624232735.3090056-1-seanjc@google.com>
Message-Id: <20220624232735.3090056-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220624232735.3090056-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH 1/4] KVM: x86/mmu: Track the number entries in a pte_list_desc
 with a ulong
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>
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

Use an "unsigned long" instead of a "u64" to track the number of entries
in a pte_list_desc's sptes array.  Both sizes are overkill as the number
of entries would easily fit into a u8, the goal is purely to get sptes[]
aligned and to size the struct as a whole to be a multiple of a cache
line (64 bytes).

Using a u64 on 32-bit kernels fails on both accounts as "more" is only
4 bytes.  Dropping "spte_count" to 4 bytes on 32-bit kernels fixes the
alignment issue and the overall size.

Add a compile-time assert to ensure the size of pte_list_desc stays a
multiple of the cache line size on modern CPUs (hardcoded because
L1_CACHE_BYTES is configurable via CONFIG_X86_L1_CACHE_SHIFT).

Fixes: 13236e25ebab ("KVM: X86: Optimize pte_list_desc with per-array counter")
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index bd74a287b54a..17ac30b9e22c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -117,15 +117,17 @@ module_param(dbg, bool, 0644);
 /*
  * Slight optimization of cacheline layout, by putting `more' and `spte_count'
  * at the start; then accessing it will only use one single cacheline for
- * either full (entries==PTE_LIST_EXT) case or entries<=6.
+ * either full (entries==PTE_LIST_EXT) case or entries<=6.  On 32-bit kernels,
+ * the entire struct fits in a single cacheline.
  */
 struct pte_list_desc {
 	struct pte_list_desc *more;
 	/*
-	 * Stores number of entries stored in the pte_list_desc.  No need to be
-	 * u64 but just for easier alignment.  When PTE_LIST_EXT, means full.
+	 * The number of valid entries in sptes[].  Use an unsigned long to
+	 * naturally align sptes[] (a u8 for the count would suffice).  When
+	 * equal to PTE_LIST_EXT, this particular list is full.
 	 */
-	u64 spte_count;
+	unsigned long spte_count;
 	u64 *sptes[PTE_LIST_EXT];
 };
 
@@ -5640,6 +5642,9 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_forced_root_level,
 	tdp_root_level = tdp_forced_root_level;
 	max_tdp_level = tdp_max_root_level;
 
+	BUILD_BUG_ON_MSG((sizeof(struct pte_list_desc) % 64),
+			 "pte_list_desc is not a multiple of cache line size (on modern CPUs)");
+
 	/*
 	 * max_huge_page_level reflects KVM's MMU capabilities irrespective
 	 * of kernel support, e.g. KVM may be capable of using 1GB pages when
-- 
2.37.0.rc0.161.g10f37bed90-goog

