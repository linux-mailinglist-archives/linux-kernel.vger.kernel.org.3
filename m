Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AD346CA9A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 02:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243576AbhLHB73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 20:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243323AbhLHB66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 20:58:58 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C5C0698DD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:55:20 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id x23-20020a634a17000000b003252e908ce3so456684pga.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 17:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=lL7Ah91e3ij9X4ILfB+Eg7xuVQkNKOT75fKaL9t5euc=;
        b=YSkEa/Mi2ETQaGznq3e7ke6p7MfXvU6iPcOcmhxmAvTs7sJ7NbWla5aE4B0uEs1nRy
         F0/iwWE6PUu0hOSvBJ/7aNJmQH6vdpWYxfaLudRsjwldpfZsZZ2B9x2Bu1R1EWYphKQs
         XkUtLYvcOQvHKpTedcFRv//lPbXRhXUQwpfhaJKYLDvtw+6kEXx+JCbdpCq0K9uFGpp+
         vZ8ZSRzWiswdm1gyWLiA27FEX/hNeBiWA9s3YTfL84CHkSdJ/aawxd0NN0KRjJ6nXMwR
         RMqf96pxDFadpqFZBuPFtqwAYJiJVdRSE1EYSJtvAkFFEZzDjqpG3SlPu0ZA4T4qoPiM
         pFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=lL7Ah91e3ij9X4ILfB+Eg7xuVQkNKOT75fKaL9t5euc=;
        b=pZov2I0W6vDH6AEq2jHBuKuY6BaQ1bD2iy0b+8dFGeI4J5YhDz0Cw5x+fV2tb2aBb0
         3ttszfDot1bzBFIS9cZKzhdDdz/GHuxQ239I6PD/eXnWlvbQ4+q5yZAYmydnRDuXE+2b
         jTxR0NLsaEl0+CMMM+6gRk4ni21dE5xEfZY5tpVXhPjShNK1ZdVtQbiYBNW7qiZ3Mb17
         DYoQLQrae+Zim9d+4cf1lRNSVBxDBUNIDEinq8zbGm6cu23d1W821SMrzhv5zy70q6pm
         U3Yh27jUp1EAifSHSyjQKXpGpH6MPj1YPkGP5Oxv0uiiREINI0IdaoB4su4kkLOlUEJk
         oJdg==
X-Gm-Message-State: AOAM533Klcnk3fPRMcgPRKA3mvAoFUcDc8mdQzuQQfYc7QF7vnkxmuQD
        qq4Rj3wcy6J7Bike1IVk7rtT3/FOY/w=
X-Google-Smtp-Source: ABdhPJwVoW65XdPki0wHByMFQDgUosdqBIe36fXCy42y0RYnEbdN8YqqHxyWCjIdH47J58cqyCGvdf6eS+I=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:db02:: with SMTP id
 g2mr3692938pjv.76.1638928519864; Tue, 07 Dec 2021 17:55:19 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  8 Dec 2021 01:52:30 +0000
In-Reply-To: <20211208015236.1616697-1-seanjc@google.com>
Message-Id: <20211208015236.1616697-21-seanjc@google.com>
Mime-Version: 1.0
References: <20211208015236.1616697-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH v3 20/26] KVM: VMX: Don't do full kick when handling posted
 interrupt wakeup
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

When waking vCPUs in the posted interrupt wakeup handling, do exactly
that and no more.  There is no need to kick the vCPU as the wakeup
handler just needs to get the vCPU task running, and if it's in the guest
then it's definitely running.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/posted_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
index 023a6b9b0fa4..f4169c009400 100644
--- a/arch/x86/kvm/vmx/posted_intr.c
+++ b/arch/x86/kvm/vmx/posted_intr.c
@@ -209,7 +209,7 @@ void pi_wakeup_handler(void)
 			    pi_wakeup_list) {
 
 		if (pi_test_on(&vmx->pi_desc))
-			kvm_vcpu_kick(&vmx->vcpu);
+			kvm_vcpu_wake_up(&vmx->vcpu);
 	}
 	spin_unlock(&per_cpu(wakeup_vcpus_on_cpu_lock, cpu));
 }
-- 
2.34.1.400.ga245620fadb-goog

