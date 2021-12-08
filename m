Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F1DD46CAA6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243950AbhLHB7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243661AbhLHB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:59:07 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4A0C0698CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:55:31 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id m129-20020a632687000000b00324df4ad6c7so420980pgm.19
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=VCkxR8iIoNYN3L1RJkz/btGuEUMw40noTB+y7+zqLJ0=;
        b=LHBsLMi3udo6BrUeQlkY0pT4Oc4Ew+wh9tNDgI5U1zVhU/K0iQ3l6PitAe/In7no9G
         OXT3y7uz44mqs4JDXqIHQ7BK0RaSWSDltzRyPHd0OyFaaR3vrpx63cneXeF3DTx93b9g
         F2/KpKN4IMYf61J/Il7a3FpMeSlYTvqPqK3MgdLFbpzQb7rQbMFPHsRQvt8Ph6dTV4nC
         MW/pjtPm8rI9cn9uQZFXTuJxhW36O6IqgaBHmFE+cCoTQkTPNd5oVzxa6qMc527PBa6Q
         kGs0fFfa+c8qKWopEJ+pQD8z9ov9+LAS3ZGWNB92YYF6/oohgLIDMWPUTgJwXVZpYg95
         K0Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=VCkxR8iIoNYN3L1RJkz/btGuEUMw40noTB+y7+zqLJ0=;
        b=ROIELGzu7YITrLtjYvl4dgkCD8R75+NK2byLyhQPfkseU4mJlT/cXXlAAj+dohCZY9
         DoUVsPDqytC77mXDMPKr5r+rk2qvTndxTae3Zpj2Gux9u+RpUJVL5z7199VlhZEMCap9
         6C0kQ9+NwNMGEh9DMDQNrAAoFBMnRtT4DVnEUUUkilqmm1entonZOqTxSKXTULRP63B6
         Xt+E9iMXXZ9S9SwV4mvUQkqjhKu1gA8sbphKK6VDMhwEQuJYODI7hYdEHB8H6jIlSM4M
         B3gQK1CFk8BmYuE8EyIthv0NicqpTQ6Ck5gEXCv2xzgpEAWaZpu2rzZxiaxl4vaJoWgT
         XrRQ==
X-Gm-Message-State: AOAM532mbmVzGh2LF6wSDLX+1ZSD8XVAHb4aEtaX/dt8yJd3PMejxKrs
        rHwLIsVSNcCQ5NHYHQ5+BBTCM9upRIo=
X-Google-Smtp-Source: ABdhPJyQ9IDS5uYE2qNrBofLqK0XEq3FDd5eSHH0h+fuqLKFddQUMDjOnZnO89YNMResi94warafDO7Gz7o=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:903:124e:b0:143:a388:a5de with SMTP id
 u14-20020a170903124e00b00143a388a5demr55869342plh.73.1638928530566; Tue, 07
 Dec 2021 17:55:30 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:36 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-27-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 26/26] KVM: x86: Unexport __kvm_request_apicv_update()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        kvm@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unexport __kvm_request_apicv_update(), it's not used by vendor code and
should never be used by vendor code.  The only reason it's exposed at all
is because Hyper-V's SynIC needs to track how many auto-EOIs are in use,
and it's convenient to use apicv_update_lock to guard that tracking.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fc52b97d6aa1..0774cf4ccd88 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9597,7 +9597,6 @@ void __kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 	} else
 		kvm->arch.apicv_inhibit_reasons = new;
 }
-EXPORT_SYMBOL_GPL(__kvm_request_apicv_update);
 
 void kvm_request_apicv_update(struct kvm *kvm, bool activate, ulong bit)
 {
-- 
2.34.1.400.ga245620fadb-goog

