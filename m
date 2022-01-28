Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA0BC49F003
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiA1Axn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344855AbiA1AxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:53:25 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10B3C061753
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:22 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id k2-20020a17090a658200b001b399622095so2851337pjj.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=MoHy27U3pXaXkL0u2KKkeb8SzX8P4k1qrRDTcgsWetA=;
        b=EqdpBATfjlVVuZojDLCyulKP1ekFA1dhoWS7qfqhKAGctc9u66Eg5171vUXlLUm4HE
         Var11+u7SKElmw93R/hlCwCDqc5vzefmNzGbr+80RNF2yoQHlPK5XtH1/SdviM1XTGGN
         YM0jpR5nfIzr0XDBbxEeEZmo4uR2eJamLqLu0bvSk1XDwjjUe3I6Oe0C+KfKNOpQ2PxN
         K+iDLhjNYwFuoPqbE3jgVAkupGcCSDIXpiWhxfSBEpu3auyEkAYi1VpGBRIZkNcrRnuY
         FsM/Y8jP1wTIx+DFNYDCKCR2eV4ZDwpk34awoNG/cMJ+J0HBWhwzfYThc7GezvbpOqSq
         zbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=MoHy27U3pXaXkL0u2KKkeb8SzX8P4k1qrRDTcgsWetA=;
        b=2kfmZJVOpVzAp62sj/DS2fcZoBQk9UQP1W2gBs9xk/jNx3ZhdG0lrvPwcv5ibz9ygB
         0bKezUErEhse+q823sslN4DYK1ug36DVbO7TCIxhrAnSZOYx82hbNMDWNdhi/1fgonNj
         EY7vC1Nr4vbOh9tN154P7OfQFnq1VVR/YnxZXcOnFaI19PgS/sPIiccIBZNIC/sBzqJV
         Is1AhA3tx7NXi2m2DYkJI+2LJinMBpiW2GAsgcpCQFcHEktFkzbxRqkTPIsk14mLG+/9
         Y8YN24kxsvZBbs0ns/olWsCDLVkNBkbPbdqMxcgYgWHr/NnzDYjzjlSPn90ozRkkkOWL
         untQ==
X-Gm-Message-State: AOAM5312aUSwmUjtrjc+4veMtoJcnamAEjQf7eGsBLoV1siiitjOxVnM
        iVwTX+FMkp6RsMcdLnilIMbxt1zddzo=
X-Google-Smtp-Source: ABdhPJz5GveShZKKXurJYvOum+YlxCN026eERDfD3Ui6hAISaoh3rOcsEo7zG5HDWxojIvpU/MEppShInwI=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:17c4:: with SMTP id
 q62mr16834393pja.145.1643331202367; Thu, 27 Jan 2022 16:53:22 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jan 2022 00:51:51 +0000
In-Reply-To: <20220128005208.4008533-1-seanjc@google.com>
Message-Id: <20220128005208.4008533-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220128005208.4008533-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 05/22] KVM: x86: Use static_call() for .vcpu_deliver_sipi_vector()
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define and use a static_call() for kvm_x86_ops.vcpu_deliver_sipi_vector(),
mostly so that the op is defined in kvm-x86-ops.h.  This will allow using
KVM_X86_OP in vendor code to wire up the implementation.  Any performance
gains eeked out by using static_call() is a happy bonus and not the
primary motiviation.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h | 1 +
 arch/x86/kvm/lapic.c               | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index a87632641a13..eb93aa439d61 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -117,5 +117,6 @@ KVM_X86_OP(enable_direct_tlbflush)
 KVM_X86_OP(migrate_timers)
 KVM_X86_OP(msr_filter_changed)
 KVM_X86_OP(complete_emulated_msr)
+KVM_X86_OP(vcpu_deliver_sipi_vector)
 
 #undef KVM_X86_OP
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d7e6fde82d25..dc4bc9eea81c 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2928,7 +2928,7 @@ int kvm_apic_accept_events(struct kvm_vcpu *vcpu)
 			/* evaluate pending_events before reading the vector */
 			smp_rmb();
 			sipi_vector = apic->sipi_vector;
-			kvm_x86_ops.vcpu_deliver_sipi_vector(vcpu, sipi_vector);
+			static_call(kvm_x86_vcpu_deliver_sipi_vector)(vcpu, sipi_vector);
 			vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
 		}
 	}
-- 
2.35.0.rc0.227.g00780c9af4-goog

