Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748CC4B1E30
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 07:08:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbiBKGIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 01:08:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiBKGIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 01:08:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A056F318
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644559697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wWsa088H+m61GloikKboHI/NqK+TRVd8yPN6et7DuH4=;
        b=T/GZq+Owq9E0VrXWelYIsdM9GQiKCja0GgiXfXfBFsKq+KFDlGNuNAST7dW5j/Lb3mseuh
        AG+f+8yMQoCUrfGDfUya20j9tWO74cp48O0FhZ7pFKimgBDHqWV/tiZPlivONzzfwJ+J3y
        OjuXmxqZ9DWbURBRQUkkBfzS+SOay20=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-NmBeqbJvPFOv-ygy7uN60A-1; Fri, 11 Feb 2022 01:08:16 -0500
X-MC-Unique: NmBeqbJvPFOv-ygy7uN60A-1
Received: by mail-oi1-f197.google.com with SMTP id bp18-20020a056808239200b002ced7afbfd2so2145157oib.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 22:08:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wWsa088H+m61GloikKboHI/NqK+TRVd8yPN6et7DuH4=;
        b=epaPvoK5LIgLpd16sQ8xxAKIM9PFWDkU5rYu8obcov60NCy1JjbwK0Lr2pYJcCmC15
         n4/zX5df9mXqj8CydQVodF/MVDFNQQj3R2mOFRxr8kME55m2DhsPTf9dekIhKof10Cef
         Xfs+xMKpQNE5J6Xq2/iMI721cGgHGxJ7K0qRSt2UghIDjoeFSXJrDl08J84s79o65quE
         NECzGSAINIB+PxC2HWn7LA82iffYX2D5Vo/qlPbCKFn6rlrhO3R14GEteirrutYC7Ffv
         8lzaoxaBExgJPkdGRpaEwOJYACsFDBmXHrrVMb1ROcLcLQWPOeobqPcje0QG/tKK1apL
         DYOg==
X-Gm-Message-State: AOAM530c5ZNX/vAGdxQ9S0qjG0fnrZXP3HjJf9SrLTJW166q7sBNeN/O
        8utawYCSVHnEZVBHKlVtTHKUDw7GLEJQ4OBqz9loawiZJ4Qp5m78+tpTB46rND6+6kqXSJJH4/u
        LV5nz9quE5+wyvKnLS6g1liZ0
X-Received: by 2002:a05:6808:56d:: with SMTP id j13mr56851oig.153.1644559695515;
        Thu, 10 Feb 2022 22:08:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw5gU4wIGXlLW1Jvzjpc0mf5KT7f4nC8R9j24uARLqBgu6E+RgZKwF7wvmbioDaby82kslm/g==
X-Received: by 2002:a05:6808:56d:: with SMTP id j13mr56833oig.153.1644559695255;
        Thu, 10 Feb 2022 22:08:15 -0800 (PST)
Received: from LeoBras.redhat.com ([2804:431:c7f0:b1af:f10e:1643:81f3:16df])
        by smtp.gmail.com with ESMTPSA id n9sm8577282otf.9.2022.02.10.22.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 22:08:14 -0800 (PST)
From:   Leonardo Bras <leobras@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Yang Zhong <yang.zhong@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Leonardo Bras <leobras@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: [PATCH v3 1/1] x86/kvm/fpu: Mask guest fpstate->xfeatures with guest_supported_xcr0
Date:   Fri, 11 Feb 2022 03:07:43 -0300
Message-Id: <20220211060742.34083-1-leobras@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

This can be solved by making the guest's fpstate->user_xfeatures only hold
values compatible to guest_supported_xcr0. This way, on 7 the only flags
copied to userspace will be the ones compatible to guest requirements,
and thus there will be no issue during migration.

As a bonus, will also fail if userspace tries to set fpu features
that are not compatible to the guest configuration. (KVM_SET_XSAVE ioctl)

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/x86/kernel/fpu/core.c | 1 +
 arch/x86/kvm/cpuid.c       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01ffc5c1..e83d8b1fbc83 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -34,6 +34,7 @@ DEFINE_PER_CPU(u64, xfd_state);
 /* The FPU state configuration data for kernel and user space */
 struct fpu_state_config	fpu_kernel_cfg __ro_after_init;
 struct fpu_state_config fpu_user_cfg __ro_after_init;
+EXPORT_SYMBOL(fpu_user_cfg);
 
 /*
  * Represents the initial FPU state. It's mostly (but not completely) zeroes,
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 494d4d351859..aecebd6bc490 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -296,6 +296,10 @@ static void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vcpu->arch.guest_supported_xcr0 =
 		cpuid_get_supported_xcr0(vcpu->arch.cpuid_entries, vcpu->arch.cpuid_nent);
 
+	/* Mask out features unsupported by guest */
+	vcpu->arch.guest_fpu.fpstate->user_xfeatures =
+		fpu_user_cfg.default_features & vcpu->arch.guest_supported_xcr0;
+
 	kvm_update_pv_runtime(vcpu);
 
 	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
-- 
2.35.1

