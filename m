Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202894E7C25
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiCYXdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 19:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbiCYXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 19:33:12 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766A75BE70
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:31:37 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id k71-20020a636f4a000000b00382a7c27856so4522234pgc.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tufvfSWY9raGchFT5U16B+276W1zCmg9SmAHZU5wbiw=;
        b=N/UpJetG7UvnLv5mjrU30pNxid1gU4YuB1Gc/dgyjrWfdK0yd1BMJz/6dNfGVOesfZ
         1CB+MkpgDFZRHv30a+hEaOoHzmwezOAhvIErUbvqAL2PT3yYt9a+Yk/6wnyFkNPD2lN1
         +cLq7WQWOcRDryxlcJCl+c74a5sV6/ROhZMxC95olnAYgIJgUD3KgHT9FnRExzv86bw/
         CUJAyATvgsAuKfb4Lo+CwHo5jAS34ai2puFi4uhueHAiNZ5UlWeuB4Al3yjhloqvATzE
         n1W+FfXl21UU89mpQN9C+jat86toWKW4CnnPNDCrf94Dl2QfjwgwL2pwEtXHyUW/MoCW
         FRYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tufvfSWY9raGchFT5U16B+276W1zCmg9SmAHZU5wbiw=;
        b=3aHQVvSWt3DBLw0nTn4TPt+GGY11jZB8X0WiYqyfCrUlO4UtchhzTbjizCENbGGOwy
         VQiQ/lYf+gaT1Z54ou57Hr/I/SI65JIt5Nf3ZbNYR2n+Bqs3BQb+bkJtc8sDH4n43qeA
         TTdiNwe17ekEHT220Nk5K0CmJRSOC4XQj6/Lli6wjBT6pji/12s7W6ZUIyKghxuoAikx
         mAC/szppEyE63FzyHjLUCBurJzAgeqRAFLAe6z4HIGPXeMNEP8MBIcV6+zd5QHm/4YEz
         D3KtUxB7kORaFFTBQ+BTa8vaslxt2WR1nNEEb3APcMne9i/pA0qdoZpBbGBxVUv40kF4
         4wgA==
X-Gm-Message-State: AOAM531Q5T5QSu2jTAg5tepPYQ15yRYkggnXgfEmH95HNxSu6O2kfE/o
        c9QfBxoKIJX3zQe02Mg97AbLEQ5JUs0G
X-Google-Smtp-Source: ABdhPJwE4ynaVAE6qX71B3LxHXvN/vp8KeBJUKGFzeitehZG7IowP2jsXS2GcxnMV5DTIgVTQRRwAYi96BoV
X-Received: from vipinsh.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:36b0])
 (user=vipinsh job=sendgmr) by 2002:a05:6a00:1a89:b0:4fa:b21d:2cd with SMTP id
 e9-20020a056a001a8900b004fab21d02cdmr12363942pfv.62.1648251096929; Fri, 25
 Mar 2022 16:31:36 -0700 (PDT)
Date:   Fri, 25 Mar 2022 23:31:25 +0000
Message-Id: <20220325233125.413634-1-vipinsh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] KVM: x86/mmu: Speed up slot_rmap_walk_next for sparsely
 populated rmaps
From:   Vipin Sharma <vipinsh@google.com>
To:     pbonzini@redhat.com
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, dmatlack@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vipin Sharma <vipinsh@google.com>
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

Avoid calling handlers on empty rmap entries and skip to the next non
empty rmap entry.

Empty rmap entries are noop in handlers.

Signed-off-by: Vipin Sharma <vipinsh@google.com>
Suggested-by: Sean Christopherson <seanjc@google.com>
Change-Id: I8abf0f4d82a2aae4c5d58b80bcc17ffc30785ffc
---
 arch/x86/kvm/mmu/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 51671cb34fb6..f296340803ba 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1499,11 +1499,14 @@ static bool slot_rmap_walk_okay(struct slot_rmap_walk_iterator *iterator)
 	return !!iterator->rmap;
 }
 
-static void slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
+static noinline void
+slot_rmap_walk_next(struct slot_rmap_walk_iterator *iterator)
 {
-	if (++iterator->rmap <= iterator->end_rmap) {
+	while (++iterator->rmap <= iterator->end_rmap) {
 		iterator->gfn += (1UL << KVM_HPAGE_GFN_SHIFT(iterator->level));
-		return;
+
+		if (iterator->rmap->val)
+			return;
 	}
 
 	if (++iterator->level > iterator->end_level) {

base-commit: c9b8fecddb5bb4b67e351bbaeaa648a6f7456912
-- 
2.35.1.1021.g381101b075-goog

