Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD394B9850
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbiBQFbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:31:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBQFbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:31:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E379243136
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645075879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+S8NFXssddbsAeetjWyXbDGSuT3B6JkqWWn56zJM37k=;
        b=XMF/vt6ya7t3HVTRyWP3d181G/CGpEX4xHDkZMc/DgDYy5cWDauTTPd7jYQF5FX144NkJA
        KSUoVCX/eJylVYwTSJ79XDwGi/5j+Y/WkaeVLd8etA29TadrnnCTrlDpTqI9/SYNjKDuVH
        Thes7J/k9Xp3gKnPRxJLbJJCxjdBz7o=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-gpb3CtywOw-kumkWe_tq_w-1; Thu, 17 Feb 2022 00:31:17 -0500
X-MC-Unique: gpb3CtywOw-kumkWe_tq_w-1
Received: by mail-ot1-f69.google.com with SMTP id w9-20020a056830410900b005ad1bf1f0b9so17409ott.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 21:31:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+S8NFXssddbsAeetjWyXbDGSuT3B6JkqWWn56zJM37k=;
        b=N3vMdE/BHqT4fCvWceHir64LrRJlaOl6xhV7oRMmN5Sr9BAlLSJKr2ZN86NZTgk6zk
         rzp6RcwyAIeXg7Df7wFMDEiOid6SN48xqX0Lggx3NkJR860+1O442gRh5uAfoE7UC6Tx
         Z8Tq4CsTkc2zV2f0hjcsCjbPHJmW1fUYVvkSYUQaoS7JdRC19KpTm/7Q8UIGnu1ljzm/
         9+7o/cbOCm//tUKtCIZFNQ9iPN7dOzX0Bv6Fwb9BYmx++0gbbhJxUvMc5U1DBVA61bZ5
         7qKOcaJVbIQ3DFZf+vFoAK6A3hRYG1osl4ePT51KINtCMwyvtLxp1z9jhFEgVj5VabMA
         dz8w==
X-Gm-Message-State: AOAM531ZCjCvZWkuijXONdDIxn3lv0OgpnZkFHdbIHgFKTgexXUrfkZ+
        lOTR6B7azaX/TOPG4T16h/W9JVCpcfO3gzSQX2nxh/NWOjiaHhXGPqSyoSEJks2Cxn7aoa6U6+P
        Sw2wcqP5Dle+JDE1eg8b8M65d
X-Received: by 2002:a05:6808:2208:b0:2d3:5181:44a7 with SMTP id bd8-20020a056808220800b002d3518144a7mr2049000oib.201.1645075877045;
        Wed, 16 Feb 2022 21:31:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypATkApCAZFKg7P+NajSA5dJuQsvGJ0jKhojrg7tL8lVsKiiizKsfuEgaVzuav2Mw5l075hg==
X-Received: by 2002:a05:6808:2208:b0:2d3:5181:44a7 with SMTP id bd8-20020a056808220800b002d3518144a7mr2048996oib.201.1645075876797;
        Wed, 16 Feb 2022 21:31:16 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7f1:c12c:38a3:24a6:f679:3afd])
        by smtp.gmail.com with ESMTPSA id cm18sm8571688oab.7.2022.02.16.21.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 21:31:15 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        David Gilbert <dgilbert@redhat.com>,
        Peter Xu <peterx@redhat.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
Date:   Thu, 17 Feb 2022 02:30:29 -0300
Message-Id: <20220217053028.96432-2-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217053028.96432-1-leobras@redhat.com>
References: <20220217053028.96432-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During host/guest switch (like in kvm_arch_vcpu_ioctl_run()), the kernel
swaps the fpu between host/guest contexts, by using fpu_swap_kvm_fpstate().

When xsave feature is available, the fpu swap is done by:
- xsave(s) instruction, with guest's fpstate->xfeatures as mask, is used
  to store the current state of the fpu registers to a buffer.
- xrstor(s) instruction, with (fpu_kernel_cfg.max_features &
  XFEATURE_MASK_FPSTATE) as mask, is used to put the buffer into fpu regs.

For xsave(s) the mask is used to limit what parts of the fpu regs will
be copied to the buffer. Likewise on xrstor(s), the mask is used to
limit what parts of the fpu regs will be changed.

The mask for xsave(s), the guest's fpstate->xfeatures, is defined on
kvm_arch_vcpu_create(), which (in summary) sets it to all features
supported by the cpu which are enabled on kernel config.

This means that xsave(s) will save to guest buffer all the fpu regs
contents the cpu has enabled when the guest is paused, even if they
are not used.

This would not be an issue, if xrstor(s) would also do that.

xrstor(s)'s mask for host/guest swap is basically every valid feature
contained in kernel config, except XFEATURE_MASK_PKRU.
Accordingto kernel src, it is instead switched in switch_to() and
flush_thread().

Then, the following happens with a host supporting PKRU starts a
guest that does not support it:
1 - Host has XFEATURE_MASK_PKRU set. 1st switch to guest,
2 - xsave(s) fpu regs to host fpustate (buffer has XFEATURE_MASK_PKRU)
3 - xrstor(s) guest fpustate to fpu regs (fpu regs have XFEATURE_MASK_PKRU)
4 - guest runs, then switch back to host,
5 - xsave(s) fpu regs to guest fpstate (buffer now have XFEATURE_MASK_PKRU)
6 - xrstor(s) host fpstate to fpu regs.
7 - kvm_vcpu_ioctl_x86_get_xsave() copy guest fpstate to userspace (with
    XFEATURE_MASK_PKRU, which should not be supported by guest vcpu)

On 5, even though the guest does not support PKRU, it does have the flag
set on guest fpstate, which is transferred to userspace via vcpu ioctl
KVM_GET_XSAVE.

This becomes a problem when the user decides on migrating the above guest
to another machine that does not support PKRU:
The new host restores guest's fpu regs to as they were before (xrstor(s)),
but since the new host don't support PKRU, a general-protection exception
ocurs in xrstor(s) and that crashes the guest.

This can be solved by making the guest's fpstate->user_xfeatures hold
a copy of guest_supported_xcr0. This way, on 7 the only flags copied to
userspace will be the ones compatible to guest requirements, and thus
there will be no issue during migration.

As a bonus, it will also fail if userspace tries to set fpu features
that are not compatible to the guest configuration. (KVM_SET_XSAVE ioctl)

Also, since kvm_vcpu_after_set_cpuid() now sets fpstate->user_xfeatures,
there is not need to set it in kvm_check_cpuid(). So, change
fpstate_realloc() so it does not touch fpstate->user_xfeatures if a
non-NULL guest_fpu is passed, which is the case when kvm_check_cpuid()
calls it.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/x86/kernel/fpu/xstate.c | 5 ++++-
 arch/x86/kvm/cpuid.c         | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 02b3ddaf4f75..7c7824ae7862 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -1558,7 +1558,10 @@ static int fpstate_realloc(u64 xfeatures, unsigned int ksize,
 		fpregs_restore_userregs();
 
 	newfps->xfeatures = curfps->xfeatures | xfeatures;
-	newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
+
+	if (!guest_fpu)
+		newfps->user_xfeatures = curfps->user_xfeatures | xfeatures;
+
 	newfps->xfd = curfps->xfd & ~xfeatures;
 
 	/* Do the final updates within the locked region */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 494d4d351859..71125291c578 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -296,6 +296,8 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
+	vcpu->arch.guest_fpu.fpstate->user_xfeatures = vcpu->arch.guest_supported_xcr0;
+
 	kvm_update_pv_runtime(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
-- 
2.35.1

