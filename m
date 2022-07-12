Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3D7570FFC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 04:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiGLCHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 22:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiGLCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 22:07:31 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEE963931
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:07:30 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id m5-20020a170902768500b0016a1c410f6cso4801994pll.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=7zGopdQFPQGp9nip4E1VjLTbCwtKn+Wbvtvm7Hq7wik=;
        b=QzHXJQot962Hjsh6aB9dnFMWGQigLj0aos5R4594XSOkJ0/+dzvCZTeJ+xkiYvm9DB
         ym774ehd0zGrPsOXudCxPrqK2rPkAgNXGiifW1c4yw7ypAxp/hFWM/0M6yK/Ojsw0TP5
         qVOqsl1WSO5g/MhP41Ql30SwD6D9zcd4XlSgHWdatfv4JXXRZ45EnQHj8B9NyYdunS9G
         XzbyHrdrvdkniMQrw4jHCmwrSS7k0BRLlH5SqPJJdWphBNK8PFLyH15r9erNNsoPpiXA
         GAiwMgA51OITPv2eS7phoC70areFpMDuf4fA6q4WNd89Ggr7lPWrFMpwDkCkmklQPnnE
         LA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=7zGopdQFPQGp9nip4E1VjLTbCwtKn+Wbvtvm7Hq7wik=;
        b=ahTAz9w7xQLYwB7Kjj2u56XAOeuInwjTfrSz4E+qyWpe4TB0+jWFDyqYaBtoV/XbCq
         7IKkbU2nRkp2bzyvpRlKyQk6c/Q3HIc/2Psr6fReiyEeA1a2Y99zHeN5tFvAltFpoaQ6
         q4mzYaf3ka0DhUJ/9pAEhH0kOmogzeEqsES/WwdM9bWYk/PckQSGC+C2z/Oi6QXw2Py6
         ohJKiuJJJdgOgNZd3PVvTw29JAjfsfaurjP+8IVHx/cR8iK4tnrWtzzzKYPnBGNILgoq
         0kxdnZ+y2j3AS7jDeADTAUmsgHikP5MzQWiEEGGRbZYbX0UsOpN1Wsc09BEe3fG5FQ6z
         wmGg==
X-Gm-Message-State: AJIora+pNZ3nkKICcWEHPEHU6dMQLZ9LfZTz/3n9JAX6/Xg88o7Lp2OL
        V8qVC1U8SWN8QfGcrR2W/wmDp71vbmI=
X-Google-Smtp-Source: AGRyM1vtd9UhT2QUE4GGRjHiDLn3YbyJA3rd375NZtlyQ512IYAH6cdN/WpBQ+ntdpFTAj+U1tTtjWuwXeQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:84b:b0:528:c70c:9508 with SMTP id
 q11-20020a056a00084b00b00528c70c9508mr21342272pfk.31.1657591649685; Mon, 11
 Jul 2022 19:07:29 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 12 Jul 2022 02:07:23 +0000
In-Reply-To: <20220712020724.1262121-1-seanjc@google.com>
Message-Id: <20220712020724.1262121-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220712020724.1262121-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.144.g8ac04bfd2-goog
Subject: [PATCH v3 2/3] KVM: x86/mmu: Expand quadrant comment for PG_LEVEL_4K
 shadow pages
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Matlack <dmatlack@google.com>
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

Tweak the comment above the computation of the quadrant for PG_LEVEL_4K
shadow pages to explicitly call out how and why KVM uses role.quadrant to
consume gPTE bits.

Opportunistically wrap an unnecessarily long line.

No functional change intended.

Link: https://lore.kernel.org/all/YqvWvBv27fYzOFdE@google.com
Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/mmu/mmu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 864a32f96082..7a65e57b9b41 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2168,7 +2168,8 @@ static struct kvm_mmu_page *kvm_mmu_get_shadow_page(struct kvm_vcpu *vcpu,
 	return __kvm_mmu_get_shadow_page(vcpu->kvm, vcpu, &caches, gfn, role);
 }
 
-static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct, unsigned int access)
+static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct,
+						  unsigned int access)
 {
 	struct kvm_mmu_page *parent_sp = sptep_to_sp(sptep);
 	union kvm_mmu_page_role role;
@@ -2195,9 +2196,15 @@ static union kvm_mmu_page_role kvm_mmu_child_role(u64 *sptep, bool direct, unsig
 	 * uses 2 PAE page tables, each mapping a 2MiB region. For these,
 	 * @role.quadrant encodes which half of the region they map.
 	 *
-	 * Note, the 4 PAE page directories are pre-allocated and the quadrant
-	 * assigned in mmu_alloc_root(). So only page tables need to be handled
-	 * here.
+	 * Concretely, a 4-byte PDE consumes bits 31:22, while an 8-byte PDE
+	 * consumes bits 29:21.  To consume bits 31:30, KVM's uses 4 shadow
+	 * PDPTEs; those 4 PAE page directories are pre-allocated and their
+	 * quadrant is assigned in mmu_alloc_root().   A 4-byte PTE consumes
+	 * bits 21:12, while an 8-byte PTE consumes bits 20:12.  To consume
+	 * bit 21 in the PTE (the child here), KVM propagates that bit to the
+	 * quadrant, i.e. sets quadrant to '0' or '1'.  The parent 8-byte PDE
+	 * covers bit 21 (see above), thus the quadrant is calculated from the
+	 * _least_ significant bit of the PDE index.
 	 */
 	if (role.has_4_byte_gpte) {
 		WARN_ON_ONCE(role.level != PG_LEVEL_4K);
-- 
2.37.0.144.g8ac04bfd2-goog

