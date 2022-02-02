Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75BF54A695F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbiBBAwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiBBAwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:52:00 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22112C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 16:52:00 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mn21-20020a17090b189500b001b4fa60efcbso3182748pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 16:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:message-id:mime-version:subject:from:to:cc;
        bh=XJiUK6wfn6NOdKYJSFA7srKKLdI0qEfi+D/R/DtQ6eI=;
        b=D68j6enSyTFRtQtx2+qwSWCnzD5Y2PrF5PNC3GKUDQY8rniPfV0SCT/kzA58EzSCUs
         1+YKSOmM4nMoM1QuKdcZL630A9MRIgVP4KiWHhk6Evo6e6hdAVE+CuOV/ero0hxCp4JR
         F7vBhMFweZ6ScF+qJbOWrslFmKLR4WW+IlWzVQwHh3/c6pqUn7BX34BtV3YthHZQxnm1
         CUMjVT04WRcsynABK+E4EiMYpfskMNG+FWBMOw861njVT1+PdzU+lqxoblXLA5pdWV3J
         e9j2C7u7d3U5yVCtyu7367L5qyjFxkAjud0RrD273xBo9KVMD4N1px374kwauuGglk6l
         pvxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:message-id:mime-version:subject
         :from:to:cc;
        bh=XJiUK6wfn6NOdKYJSFA7srKKLdI0qEfi+D/R/DtQ6eI=;
        b=LjEibePaOcGgG4+YGVjlF/jYSJniVH34Kazd4YwuLUXntD3tP8Y3xCz/5p8KlkO41d
         olLiX4162u3FhgGHeTH1/Y+Eql3YTPmEsZSiYu3tuP7v9q3Zyn34KQlp9tCN7157q/vC
         8rAEPSGotBTpyL5viVTGv0bT2O4MDUcetNZUPBWNNBmFA62AOYHDn02GtJ+VcHtWwNs5
         7nXD5PEJVEDWW7psZevYTx39LfAQIwza5T6Y9bed5boyE+oj6xKQ7N8H0TjLIhcynMWG
         hwHOYMgo2usxKV5udrTlPeVkH985wzJ1ZgEhuB/t3qqQ9LnK8Qz5K4etLCrFcePsKlHZ
         uSZw==
X-Gm-Message-State: AOAM5321nj5721xHUTmFD75XKGFNs9FFvqneEqz8jyZuQsI4xa/JwHo8
        XNans1ekb+mKCV1zNZOtQFk/S8zMIWo=
X-Google-Smtp-Source: ABdhPJzbQDNAqMtl0mv4aOa9DHl5tMHo3NDo2n3ijhMR6OSjtjQc4hSxxq0AHvKiUESLTohewXp7s0mUyk8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1345:: with SMTP id
 k5mr27607355pfu.37.1643763119620; Tue, 01 Feb 2022 16:51:59 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  2 Feb 2022 00:51:57 +0000
Message-Id: <20220202005157.2545816-1-seanjc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] KVM: x86: Use ERR_PTR_USR() to return -EFAULT as a __user pointer
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use ERR_PTR_USR() when returning -EFAULT from kvm_get_attr_addr(), sparse
complains about implicitly casting the kernel pointer from ERR_PTR() into
a __user pointer.

>> arch/x86/kvm/x86.c:4342:31: sparse: sparse: incorrect type in return expression
   (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   arch/x86/kvm/x86.c:4342:31: sparse:     expected void [noderef] __user *
   arch/x86/kvm/x86.c:4342:31: sparse:     got void *
>> arch/x86/kvm/x86.c:4342:31: sparse: sparse: incorrect type in return expression
   (different address spaces) @@     expected void [noderef] __user * @@     got void * @@
   arch/x86/kvm/x86.c:4342:31: sparse:     expected void [noderef] __user *
   arch/x86/kvm/x86.c:4342:31: sparse:     got void *

No functional change intended.

Fixes: 56f289a8d23a ("KVM: x86: Add a helper to retrieve userspace address from kvm_device_attr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index fec3dd4f0718..b533aab98172 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -90,6 +90,8 @@
 u64 __read_mostly kvm_mce_cap_supported = MCG_CTL_P | MCG_SER_P;
 EXPORT_SYMBOL_GPL(kvm_mce_cap_supported);
 
+#define  ERR_PTR_USR(e)  ((void __user *)ERR_PTR(e))
+
 #define emul_to_vcpu(ctxt) \
 	((struct kvm_vcpu *)(ctxt)->vcpu)
 
@@ -4340,7 +4342,7 @@ static inline void __user *kvm_get_attr_addr(struct kvm_device_attr *attr)
 	void __user *uaddr = (void __user*)(unsigned long)attr->addr;
 
 	if ((u64)(unsigned long)uaddr != attr->addr)
-		return ERR_PTR(-EFAULT);
+		return ERR_PTR_USR(-EFAULT);
 	return uaddr;
 }
 
@@ -11684,8 +11686,6 @@ void kvm_arch_sync_events(struct kvm *kvm)
 	kvm_free_pit(kvm);
 }
 
-#define  ERR_PTR_USR(e)  ((void __user *)ERR_PTR(e))
-
 /**
  * __x86_set_memory_region: Setup KVM internal memory slot
  *

base-commit: b2d2af7e5df37ee3a9ba6b405bdbb7691a5c2dfc
-- 
2.35.0.rc2.247.g8bbb082509-goog

