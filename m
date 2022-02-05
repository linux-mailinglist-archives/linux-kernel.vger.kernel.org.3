Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851544AA794
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 09:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243177AbiBEIRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 03:17:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238918AbiBEIRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 03:17:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644049055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpyU/hxiwc/MJkJ493/UIfJTOWcNrra/dJYpmK9ChNI=;
        b=B9lxYcVnIUVBsu+Nh1PMqiv+SCdA9RtLMaqHVUPF1ZmJS+HK/kEG3sqnyRlA6Odta4JToK
        qkcqd2GGWRopzn54Pz/SnCQDUys/9nCznlNBrlDQFd9jCLuqPbsYg3M1zX1SlFoPLmITGi
        18FITSkDFIMZlBLFC/dgbmRjeN3qFt8=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-328-JfjTjOKQMO-z3ksIvKw6_w-1; Sat, 05 Feb 2022 03:17:34 -0500
X-MC-Unique: JfjTjOKQMO-z3ksIvKw6_w-1
Received: by mail-oo1-f72.google.com with SMTP id u126-20020a4a5784000000b002e3688852c8so4752448ooa.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 00:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FpyU/hxiwc/MJkJ493/UIfJTOWcNrra/dJYpmK9ChNI=;
        b=hpp2xnjceYxx6SXnWV7EIe40ILqn4dylhAlXvE+uh4M14tsqM49FW+QXfoD59ILdBF
         cr9CvhOi1ErXEYB7fGlavJyPEAL/WHdIdyZiopciIGV/h/R3vPWOGmHPZy3TawLsYAMU
         8R9gwbe7+RdibC+00YnJqvODxalepJiZPYNdFFvA5EnHUSlbCS/BXqdrjmpBlKD5qLTM
         LiZaY0BwL3DIRxMYf/S8izZsB3AQnRLwO5sawD++CUDGZQD5goHT2b2jY2Wvwr1ombUf
         iYYiOUIe1jcrc/rO3aKgdGtxy9K3jv/gMfbaDUZcLWkDo3GWMBl3QB1CtLkek6d8+ens
         Wiig==
X-Gm-Message-State: AOAM532Pws55xNB80Owyn5r9NYin0DSeKQPzJHft7TZDobV0yi7ozz6e
        cnTprsE9TGWqfOU2G58YYZXbgfys/n82+WPRVuYWoUb5uTbiMp19FEM6B8Uqu7qNT68uolaZ8UC
        rxcF7dPttpsHUdlxYusc/3ym1
X-Received: by 2002:a9d:69d1:: with SMTP id v17mr887841oto.220.1644049053552;
        Sat, 05 Feb 2022 00:17:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxHZ8nTlggoeWG+zBTopeYthpriHxLKpwl/g0wOeOS85juAdDUPbrfh3I9zvgK9dj3l9+vEyA==
X-Received: by 2002:a9d:69d1:: with SMTP id v17mr887837oto.220.1644049053352;
        Sat, 05 Feb 2022 00:17:33 -0800 (PST)
Received: from localhost.localdomain ([2804:431:c7f0:b1af:f10e:1643:81f3:16df])
        by smtp.gmail.com with ESMTPSA id bg34sm1708795oob.14.2022.02.05.00.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 00:17:32 -0800 (PST)
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
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Leonardo Bras <leobras@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
Date:   Sat,  5 Feb 2022 05:16:58 -0300
Message-Id: <20220205081658.562208-2-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220205081658.562208-1-leobras@redhat.com>
References: <20220205081658.562208-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On 5, even though the guest does not support PKRU, it does have the flag
set on guest fpstate, which is transferred to userspace via vcpu ioctl
KVM_GET_XSAVE.

This becomes a problem when the user decides on migrating the above guest
to another machine that does not support PKRU:
The new host restores guest's fpu regs to as they were before (xrstor(s)),
but since the new host don't support PKRU, a general-protection exception
ocurs in xrstor(s) and that crashes the guest.

This can be solved by making the guest's fpstate->xfeatures only hold
values compatible to guest_supported_xcr0. This way, on 5 the only flags
saved by xsave(s) will be the ones compatible to guest requirements,
and thus there will be no issue during migration.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/x86/kvm/cpuid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 28be02adc669..8ce481cc0f9b 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -296,6 +296,9 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
+	/* Mask out features unsupported by guest */
+	vcpu->arch.guest_fpu.fpstate->xfeatures &= vcpu->arch.guest_supported_xcr0;
+
 	kvm_update_pv_runtime(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
-- 
2.35.1

