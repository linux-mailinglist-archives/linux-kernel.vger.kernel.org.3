Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BA576A0C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 00:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiGOWnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 18:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiGOWmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 18:42:36 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A17558E3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:35 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u64-20020a638543000000b00412b09eae15so3360799pgd.15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 15:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=eh6gEobhpZaKYXrjfikJhjM6emGdwYRyv0yMcaabdXk=;
        b=VVl6sBHcJOK0bxT4HPjPt9Fzvlg3wie0LNiV4G0kvkIPZOTaIETRDVeyAe2IPDX0Vd
         BnahEnI6fMgarfoLuCFCSoCX/iFnmJUIXNf+AbpUmfwscwSlxjeLwqGPslVZS4ynCAsq
         Yq8LiqHE9vM56bv3w6uDUpjwkp6gnAu9P391AEBQlBFKUG/FfQaNyQUCf7eOYklFM8XR
         QFW/It/Uz8OIAo1qo73Q9TZDBxhoYGFIYWJRc8tUAAbOMCcSK2n2sOeCx86AvB0U1Oc4
         cpd+o58XOS1NctN04kjcVrJa9Vm2TL14TBLK4/4Ywj60nHfDieJeZxW3Ij21Ri/Z3zaT
         xknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=eh6gEobhpZaKYXrjfikJhjM6emGdwYRyv0yMcaabdXk=;
        b=aB7V6EzGZ78VqJzx0Jrzle3ckHbJVCiwpg02psmiH4aubKIjodn1eo1GmMGqOAFpsl
         pL8oDhKIjZeWb8oIwbLfGMNq9R7dACzpWXQgrBqMt3P9zHA1eHfI1+JhoMSksNBec5GX
         8Qu8nnZbhU7cW0FB4qpS7u0LH67Ju1HmOkzn05MrwX64dOLSqN25TJhVsua/PRpC4YUG
         C8ymOvQWiF5Vwz4rejeLYVBuHcP74cVqQAfubRnx/IICg/Cr5A1ZFVWVEEJVXrLS7qhG
         L54Mdra72C7ie1UzyZVpArlnNa3QIUKr3GUA60Y3V9WVSvHpyzyjNR5qCpUOyn0A85Ur
         0tfw==
X-Gm-Message-State: AJIora8IPsbfsTCIayPta/X5Vf1ls0kvPBdVbpfPUN09R42KS/arXkdN
        4RpL2R+/3ZCu5rht05nAVJShgpsNzX4=
X-Google-Smtp-Source: AGRyM1vPilzsnOrSR/Ai7hTylYkvyZsOTRfZHuyNqUSHCZBND2m33KaqZyWmiKiB/PkhSYotZnjls9A1szk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1385:b0:52b:bb4:e012 with SMTP id
 t5-20020a056a00138500b0052b0bb4e012mr15751881pfg.8.1657924955143; Fri, 15 Jul
 2022 15:42:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 22:42:21 +0000
In-Reply-To: <20220715224226.3749507-1-seanjc@google.com>
Message-Id: <20220715224226.3749507-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220715224226.3749507-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 2/7] KVM: x86/mmu: Directly "destroy" PTE list when
 recycling rmaps
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Use pte_list_destroy() directly when recycling rmaps instead of bouncing
through kvm_unmap_rmapp() and kvm_zap_rmapp().  Calling kvm_unmap_rmapp()
is unnecessary and odd as it requires passing dummy parameters; passing
NULL for @slot when __rmap_add() already has a valid slot is especially
weird and confusing.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index b2379ede2ed6..92fcffec0227 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1596,7 +1596,7 @@ static void __rmap_add(struct kvm *kvm,
 	rmap_count = pte_list_add(cache, spte, rmap_head);
 
 	if (rmap_count > RMAP_RECYCLE_THRESHOLD) {
-		kvm_unmap_rmapp(kvm, rmap_head, NULL, gfn, sp->role.level, __pte(0));
+		pte_list_destroy(kvm, rmap_head);
 		kvm_flush_remote_tlbs_with_address(
 				kvm, sp->gfn, KVM_PAGES_PER_HPAGE(sp->role.level));
 	}
-- 
2.37.0.170.g444d1eabd0-goog

