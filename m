Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCE8507E45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358813AbiDTBke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358787AbiDTBk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:40:26 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCE377C3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:37:41 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z11-20020a62d10b000000b00507258043e7so300742pfg.16
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=YggvXc76kD9hmqmKWmhy8VV9X8fOiVEtam3hP4xSjGM=;
        b=maxPT6Mp0MgvU206GcEL0romWQqaLaog8y/UrpuifwgoME9aLjLO4W/X8VprbMLDY/
         GCSQlblwz0+h33sONAnLzlWMj/r58kxHJad6WpW/6XBcaaatIvts2ncRNxYLCqBJWpUr
         ImtXvtRkpsHVKpb5ik7Sk63AW8Lt5YOldBjgPgWy8Rz/Q6hppA8iI0lOXtEo4Ro4bBSw
         GAmva/jjL32/Z9oBcosfTomF6CKA4cQhGQsyAn+2g0racOBoXBAL9cd7IRXXaUgWzGoY
         tjB4OS9UP7vgxAY43mpIA/Vb4eqHyVhaHglyhi9LD29Ul0kOA+7DG2iA7Dq6ZRAdXaVn
         ZzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=YggvXc76kD9hmqmKWmhy8VV9X8fOiVEtam3hP4xSjGM=;
        b=cSu+ZlhwTssCRmwYX2guZzQHeeAHWnQcyWfHudbgRRs1vyYtfU9e6HUkeyPcDq5CQh
         qmWju3YNckYv7naqRVJYNygDYZ/ywa1RkZlxOZuGrZF3UdlZWsm9gfKmC7b2jGpYGbRS
         4ujdS7ANKpyXRgqlI68L6IXtGJVbO2zx9lODynE0T9vudCSdAigqqA91/cR+bieGtIGy
         Yy5T+LGV5BxxmbRrc3B0rdqhOdRNiy64hmYwSYgqY2+xTIvlZcD8I3mXjfr7Uzxciw3E
         7zax3g5p+BdUfMdG0XznVP/Zm22BG/clTmUas0O5wxEff6yfyaCLKhlSBOJwmopuG3IG
         4SXg==
X-Gm-Message-State: AOAM532ADZxdUwikL1OMlbHyzty9YYvjK+/K5O9iwvbY5uagzL5U/CY8
        2yfJu2RbjrOl3XJN2pWekGPpWfloSeE=
X-Google-Smtp-Source: ABdhPJxmdbTe3X4Jl9yDGni826ymwia/p9HVgg/n6ca6j5LdEaWE5XZFyQ+yI2r9ValnG5yrTGpnbVg5h+U=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:7448:b0:158:f93f:bc0c with SMTP id
 e8-20020a170902744800b00158f93fbc0cmr12947007plt.8.1650418661056; Tue, 19 Apr
 2022 18:37:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 20 Apr 2022 01:37:32 +0000
In-Reply-To: <20220420013732.3308816-1-seanjc@google.com>
Message-Id: <20220420013732.3308816-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220420013732.3308816-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2 4/4] KVM: x86: Skip KVM_GUESTDBG_BLOCKIRQ APICv update if
 APICv is disabled
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Gaoning Pan <pgn@zju.edu.cn>, Yongkang Jia <kangel@zju.edu.cn>
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

Skip the APICv inhibit update for KVM_GUESTDBG_BLOCKIRQ if APICv is
disabled at the module level to avoid having to acquire the mutex and
potentially process all vCPUs. The DISABLE inhibit will (barring bugs)
never be lifted, so piling on more inhibits is unnecessary.

Fixes: cae72dcc3b21 ("KVM: x86: inhibit APICv when KVM_GUESTDBG_BLOCKIRQ active")
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 09a270cc1c8f..16c5fa7d165d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11048,6 +11048,9 @@ static void kvm_arch_vcpu_guestdbg_update_apicv_inhibit(struct kvm *kvm)
 	struct kvm_vcpu *vcpu;
 	unsigned long i;
 
+	if (!enable_apicv)
+		return;
+
 	down_write(&kvm->arch.apicv_update_lock);
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
-- 
2.36.0.rc0.470.gd361397f0d-goog

