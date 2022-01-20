Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BC7494565
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358288AbiATBI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358160AbiATBHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:07:45 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D9C061755
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:38 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x11-20020aa7918b000000b004bd70cde509so2637278pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=1MqJcaQdNhP8SCL+NFeqeJWTrEaCvBpqs2dZuCdHK2Y=;
        b=TJ2FWW5fCZHdNotJ03suK35FRY2TDUvVarJkAb30a3e7GfYJF3iobX7j9DJFQG53Z1
         wgPWmvuR7JMQvfC1HUgUxnySnvI8sjgfuIVo5whsXbAoVZWpCZGbcuz7lNCXs65mElDw
         HmtE71ykIxTNGP/rpz/VYH/dxgTy4KNJcVNglaLAj7sx/wzdbZTfrhsagKyLHEovu6BO
         +ZT651eiEOAcNUPKG3XIEQx2guE8OsYQTfnAsCWPww8AVHvTD4kuNMFNg/DJoq/syDdd
         wDJoUhAwQKejmydJGZ6wQJgVZZBrM3mIi7WEOJxyk1skav8lgp0o5i6SAiW391uQXlM5
         kyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=1MqJcaQdNhP8SCL+NFeqeJWTrEaCvBpqs2dZuCdHK2Y=;
        b=YsLJtJgvwioP2ELNH5/lTZbNuoHTgPjLz4za2rA4vlZhTSuevX64Gi1+NgccvlWluM
         +CTpESPmZLynqJ9NQ5LvZaDW5v+ADcrKtZWUr5K+wJmSfUl+fzY+Zy9EiYu5wZ3jzQI0
         giko+G3JepEaYd2kJu8/4j9ZsdkuEMN+c5FAzX/6Qn8Y6wy9hu2dEuYd8uoViTrb9bx1
         srD8vMLviIVakQvvZRL4D+VL7Y/MiAelTA/LPxH1Fvwpx1MnGFndP1d2YgPX9ETklx7A
         JmS7/y99uIx6/tST6IXzRmir5GxZXvMalXsja8zWulbEIElv9ROflw3ONBHvnY1YNX8r
         aB9g==
X-Gm-Message-State: AOAM530qM8lfOyhhDcF+0WwAFTsNVxpLCACur5DDmxJpp3RwHQlRXmKI
        XA/ohsc3OhtLTICuMi7OUACjqU1sEXQ=
X-Google-Smtp-Source: ABdhPJxUXXXgJMFRI9avsCMLkEs0eKS2r5rCEsC4DcQm9gjKQZO2bQl/XiEdt6JpSu4zT5a4hJg577BHrD0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1c8f:: with SMTP id
 oo15mr7460001pjb.125.1642640858187; Wed, 19 Jan 2022 17:07:38 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 20 Jan 2022 01:07:19 +0000
In-Reply-To: <20220120010719.711476-1-seanjc@google.com>
Message-Id: <20220120010719.711476-10-seanjc@google.com>
Mime-Version: 1.0
References: <20220120010719.711476-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 9/9] KVM: SVM: Don't kill SEV guest if SMAP erratum triggers
 in usermode
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Liam Merwick <liam.merwick@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inject a #GP instead of synthesizing triple fault to try to avoid killing
the guest if emulation of an SEV guest fails due to encountering the SMAP
erratum.  The injected #GP may still be fatal to the guest, e.g. if the
userspace process is providing critical functionality, but KVM should
make every attempt to keep the guest alive.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a4b02a6217fd..88f5bbb0e6a1 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4357,7 +4357,21 @@ static bool svm_can_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	is_user = svm_get_cpl(vcpu) == 3;
 	if (smap && (!smep || is_user)) {
 		pr_err_ratelimited("KVM: SEV Guest triggered AMD Erratum 1096\n");
-		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+
+		/*
+		 * If the fault occurred in userspace, arbitrarily inject #GP
+		 * to avoid killing the guest and to hopefully avoid confusing
+		 * the guest kernel too much, e.g. injecting #PF would not be
+		 * coherent with respect to the guest's page tables.  Request
+		 * triple fault if the fault occurred in the kernel as there's
+		 * no fault that KVM can inject without confusing the guest.
+		 * In practice, the triple fault is moot as no sane SEV kernel
+		 * will execute from user memory while also running with SMAP=1.
+		 */
+		if (is_user)
+			kvm_inject_gp(vcpu, 0);
+		else
+			kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	}
 
 resume_guest:
-- 
2.34.1.703.g22d0c6ccf7-goog

