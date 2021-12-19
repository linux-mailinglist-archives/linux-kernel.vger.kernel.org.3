Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CE647A003
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 10:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbhLSJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 04:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhLSJO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 04:14:59 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D88AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 01:14:59 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so25752848eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 01:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+C6dwtToIrOSak5JfH1i4L+0VoWRsAGDGNse8RUgMk=;
        b=RHj3/IdieBfWoClWNOGSykRNMDES1YpE6a3OyFGD+iBJXwook47XOjwIP1dZDbhg0+
         MRw4FcsC7IFhQZtZd+CixMeci4U3hDNarqTaoCt2CTFAtm4zv2qeZUbTJY6JaSM5yQF3
         nSLRpOyMb/bV1ImSLud7Yn2vely+i7rBJw5RRktEM7Pm+Aj+5rECbKXK9bOtozFcmGgB
         2Br1XAqxJSvJfCBHp5ezrc22MjTYpsaSaBkCyMOs1BXw0dLz2VfnoXEybxQ+uSX+rdB7
         +s2lq3C3ilzcIpWyjOKQTcLe8ozpoyL57ImmuPKF6mx/xtlX/zhZKZgiD2AVJAzJh3+0
         c38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d+C6dwtToIrOSak5JfH1i4L+0VoWRsAGDGNse8RUgMk=;
        b=qP/CJxd+qIPe3bqguv1oSAaY13+5VQLfylOZMJ0BXAxRQgZF8JLS1x+YfZ9mVGm7cC
         Znb7Ky3TCEsLQD0IhuBofRBtGXN3WFO8O9eFv9qc83d9aQmPfneNgoprHw3Np4WUo50r
         4OTHpdM4yVmPB2qXdAfRqr/fEycSdflgHNiomS5McxRqf5ruaPJdL9kp6UAtkVivTFPa
         t8gHvxO6vFydFF20ig38g4m4OV+v0AEvqZi7xEL/di1RwgplGBPfmduYgVYxYtwRXs9u
         32n0GHnzT1TilEPTeqmJB9iImjZwcNFvmP2Kd9PD/VyXFNdXEJFsGQj4KC0LWil0h1rz
         mt6g==
X-Gm-Message-State: AOAM5336CxmcINTzpsQRs1EsZf5dVlRGInDiq074Vwvif/pEXqnKiHt3
        pZP4QMJarV0RqAh86+sYtrI=
X-Google-Smtp-Source: ABdhPJwbqWNigwRApC6MPktannl5U6KVMH0Dgiw7s0MqdVc3HTfbwEekt7f5u7TWWxWARu+F8o9iAQ==
X-Received: by 2002:a17:906:1599:: with SMTP id k25mr9523567ejd.298.1639905297737;
        Sun, 19 Dec 2021 01:14:57 -0800 (PST)
Received: from ubuntu.localdomain ([185.37.253.175])
        by smtp.gmail.com with ESMTPSA id y13sm1563478edq.77.2021.12.19.01.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 01:14:57 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     pbonzini@redhat.com, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH] KVM/X86: Make kvm_vcpu_reload_apic_access_page() static
Date:   Sun, 19 Dec 2021 17:14:46 +0800
Message-Id: <20211219091446.174584-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make kvm_vcpu_reload_apic_access_page() static
as it is no longer invoked directly by vmx
and it is also no longer exported.

No functional change intended.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
---
 arch/x86/include/asm/kvm_host.h | 1 -
 arch/x86/kvm/x86.c              | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 2164b9f4c7b0..f1c4ba208ed6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1855,7 +1855,6 @@ int kvm_cpu_has_extint(struct kvm_vcpu *v);
 int kvm_arch_interrupt_allowed(struct kvm_vcpu *vcpu);
 int kvm_cpu_get_interrupt(struct kvm_vcpu *v);
 void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event);
-void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu);
 
 int kvm_pv_send_ipi(struct kvm *kvm, unsigned long ipi_bitmap_low,
 		    unsigned long ipi_bitmap_high, u32 min,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0cf1082455df..6569a62ea38b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9621,7 +9621,7 @@ void kvm_arch_mmu_notifier_invalidate_range(struct kvm *kvm,
 		kvm_make_all_cpus_request(kvm, KVM_REQ_APIC_PAGE_RELOAD);
 }
 
-void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
+static void kvm_vcpu_reload_apic_access_page(struct kvm_vcpu *vcpu)
 {
 	if (!lapic_in_kernel(vcpu))
 		return;
-- 
2.25.1

