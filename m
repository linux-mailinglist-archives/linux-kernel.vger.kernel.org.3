Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4C53D479
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350173AbiFDBW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiFDBWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:22:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8134930553
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:21:47 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id om5-20020a17090b3a8500b001df42f1cbaaso8053683pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=IuS7bySLaWk96Nr3FGWjEQAo2Xsg0Uk+ZK8PKSv3jks=;
        b=tPq24DSwyTk5KSO20RDyya7f7yw8xQUbzDozzJsWDZxJdkHTLXmnATymku+8QAns/W
         fBwDfz9KAcO+cqN2Wssbg4VFRtfuMCunAJp5TfF3YqdBOjrzSP9et7q+PXF+TMU7LfLn
         X8tNemgrW3H4Q1z7f4pDazmxOgdWAcO0ctu1dcTWIlOIqS1G+WE3wB4YEH2mUzmf/7kR
         yBehsBBnSl5U5dxKH5v31h2gJQIFFZbtWlHJYPaVah7z+9fWXamR3GxfhwOFHzgMat1A
         ZimjzClQOBmacr7zPKTACaVruoD5OEPiZjgi3GNlJsZbhokfspa5ezz0wi2xECEYueDb
         Pyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=IuS7bySLaWk96Nr3FGWjEQAo2Xsg0Uk+ZK8PKSv3jks=;
        b=UDTTh7LlJzDeXjAZvXzH3awWjXeSouVIzrQxr9RcdJFFrd11csJQq2Wd/W07Dfljeo
         pjk9bXDxcKk3BEJvpo+1kl6g0GLsX7W2/3JncunvKambNFkPhQJVUURvJ0DBGmnejmmc
         eivlkZiAs29YjQSfHVKab1DlQzBO7ZPfLJIMwigaHx7jo3lLHXEQ6ONcZn5bh6/eOSKC
         mwdA+2xKa/3HAt9A3ADyeArnVy0nQPKN0BZi0O2UPS2jrZGIDkEIhVTvVOCVVQ61pqMS
         FV58oXAMosg9kRnHFKROhe9HieAyeJaSiS4dbQL6h8UvXAjkWTpwA68JX/2XJ4shJymV
         i6OQ==
X-Gm-Message-State: AOAM5334nUw8mnJaK974Fg8XP8zbMG7BURPC/LHYj6vqSVLdl5zI6fG3
        wGon4cHo/AeZ3wEE6hUepioWH2ntsJs=
X-Google-Smtp-Source: ABdhPJwuClwILqT2Dv4zyXmcPWZI77NL7R+wjQnwq488gAhRaMBLpiUAi+6R3tHak0WA/bKbmW7OOLU/6CM=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:178f:b0:1e3:3ba:c185 with SMTP id
 q15-20020a17090a178f00b001e303bac185mr4623pja.1.1654305693476; Fri, 03 Jun
 2022 18:21:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  4 Jun 2022 01:20:35 +0000
In-Reply-To: <20220604012058.1972195-1-seanjc@google.com>
Message-Id: <20220604012058.1972195-20-seanjc@google.com>
Mime-Version: 1.0
References: <20220604012058.1972195-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 19/42] KVM: selftests: Don't use a static local in vcpu_get_supported_hv_cpuid()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
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

Don't use a static variable for the Hyper-V supported CPUID array, the
helper unconditionally reallocates the array on every invocation (and all
callers free the array immediately after use).  The array is intentionally
recreated and refilled because the set of supported CPUID features is
dependent on vCPU state, e.g. whether or not eVMCS has been enabled.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c252c7463970..ae40ff426ad8 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -1289,9 +1289,7 @@ void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu)
 
 struct kvm_cpuid2 *vcpu_get_supported_hv_cpuid(struct kvm_vcpu *vcpu)
 {
-	static struct kvm_cpuid2 *cpuid;
-
-	cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
+	struct kvm_cpuid2 *cpuid = allocate_kvm_cpuid2(MAX_NR_CPUID_ENTRIES);
 
 	vcpu_ioctl(vcpu, KVM_GET_SUPPORTED_HV_CPUID, cpuid);
 
-- 
2.36.1.255.ge46751e96f-goog

