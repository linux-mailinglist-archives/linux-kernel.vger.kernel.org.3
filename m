Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9470054BE54
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 01:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiFNXds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 19:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiFNXdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 19:33:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21B94C7BA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:33:38 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id z9-20020a170903018900b00168b66bbde2so5573701plg.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 16:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=66YOE3D++YjiCQYAOPbfPb7xNbNJtfXwRmXra4+Vga0=;
        b=XkSOxZVNtKRdwlCMG2Rkoe9pWC1o3+MtsPxenAFTOIWjAp8pAzo9ptSTAPINXlQdZI
         PGIBIy5g3ssWdKHmjSlmfKvbTjvhVRvrWE2KGeczKLOj/Sema0dIb9phYdk7m6o4/WQc
         W2/0+ZCuVJQ+L3vAnl3N17NpF37zpaIijGPyKGnBynV6z5+i/vj9m0v2p3MlsuKVYetD
         Mwpftm7Wz5yvnyHCCM7rrTcijxdJ390lTSlNFAsERaq1YZ4IFNAIC6viSYFB7Wldcdga
         rapmU4xoXd6ztMR9ukJ4TqxYXBqhJ+EZk39WcJyNz2vyoJb5i7SunvqXxTa9ejkAEZXD
         n3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=66YOE3D++YjiCQYAOPbfPb7xNbNJtfXwRmXra4+Vga0=;
        b=xpxXf8b2/4oG+p2BhGbMNjZiu4hggNVvuanXoFTzsmSFaJcAhqW1MOIe6ZkvSRYU4f
         5tkSsWIC58I4ikD1uJ8w2hTGDj4kIs86RDd7zizE0u7ewMhJSg1PuRS6QLen38a0mtrA
         nlK8cnkrcm1SqUQDbwPgl92iVeOyynWYBAvo8IerI4k85mddhWSpb/afNZV0FKcowXFW
         OOfE1/EA5e+bEQa6VS6sfORreTNgqb/nm3kBpumhDhBoRPRQdvEnjb5wXtdsAc6nNx11
         +BDD7DI6GAMTo6FeRsnvN9u+dc42x3X3kmWzf4N9w61aNZm6cFf8R/7LIIScw5unw1N1
         qjBg==
X-Gm-Message-State: AOAM530286mM68oItA8HpGeBXRVH+Jmw/Q2ROjzIlJYuu8X/kX6RYHo/
        03IQAjDJNA+L94wQLMMJEFJv4d9LDR8=
X-Google-Smtp-Source: ABdhPJyWMZ015MfiUWvGXN7mMPeXD9z9UC8xpj7UH7wHuSJ60ScAFr35PWhit6iSa+I1bttdCV63Z5TIcu4=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3491:b0:51c:1d3b:b0b0 with SMTP id
 cp17-20020a056a00349100b0051c1d3bb0b0mr6890353pfb.68.1655249618275; Tue, 14
 Jun 2022 16:33:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 23:33:22 +0000
In-Reply-To: <20220614233328.3896033-1-seanjc@google.com>
Message-Id: <20220614233328.3896033-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220614233328.3896033-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 2/8] KVM: VMX: Refactor 32-bit PSE PT creation to avoid
 using MMU macro
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
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

Compute the number of PTEs to be filled for the 32-bit PSE page tables
using the page size and the size of each entry.  While using the MMU's
PT32_ENT_PER_PAGE macro is arguably better in isolation, removing VMX's
usage will allow a future namespacing cleanup to move the guest page
table macros into paging_tmpl.h, out of the reach of code that isn't
directly related to shadow paging.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5e14e4c40007..b774f8c1b952 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3704,7 +3704,7 @@ static int init_rmode_identity_map(struct kvm *kvm)
 	}
 
 	/* Set up identity-mapping pagetable for EPT in real mode */
-	for (i = 0; i < PT32_ENT_PER_PAGE; i++) {
+	for (i = 0; i < (PAGE_SIZE / sizeof(tmp)); i++) {
 		tmp = (i << 22) + (_PAGE_PRESENT | _PAGE_RW | _PAGE_USER |
 			_PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_PSE);
 		if (__copy_to_user(uaddr + i * sizeof(tmp), &tmp, sizeof(tmp))) {
-- 
2.36.1.476.g0c4daa206d-goog

