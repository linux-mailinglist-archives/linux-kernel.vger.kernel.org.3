Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0C349F010
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiA1AyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbiA1Axm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:53:42 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2212C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:32 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a12-20020a056a001d0c00b004cc283b2e30so2371515pfx.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 16:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=x674bgr4MZ+skXJdAJ4IMcJE6zqdTys8wAdZyd8Nm7s=;
        b=MPEcECl11PxoOnqqo0qf9ICGM2jqXYqMVBnuE2gK1BlYeWxvV+QXMZKJVQv6bePA4E
         WLIsWupIl59bhG5lkmRT4sOaI47B4Xr13k2qB8PBfYYl3lTm8+JhKI0W4/riv7LUNMm/
         gdnFQHMhnKgZy5eUBeIMUq3UJhrZznIMrhXvbWT1w9ei1x+4E2bX04p+IyzYwlskDNan
         nXZ/MTAW2uPGqnlcHUe8o7D/OeeLkJq11vMS/nBpxLPHcj34aElLU4AvQ22dVwgMQq0z
         wz0/fW2jEpjQSTFJoRtipNgvoX/oKFqZox6NKO58CjIUbuf0qlOUYXEnkfktPamqehCB
         RO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=x674bgr4MZ+skXJdAJ4IMcJE6zqdTys8wAdZyd8Nm7s=;
        b=2xhVvjgWQ683vm9IMREKdEgTgOUsB8o8OS+5dX4aDbuD73aFp5Alx0Vfc+l8/fLbJ3
         pc7dAe+OLw8bQ+AKSfee+ksFEeg04ECwhFFBoUxfHihP+bKpsOzgnZq2Jujf0HlmQZsK
         rKfl03gIgZ2gC0Rk+axqh5/wNQxe99IPKyG72RsLJdiI30IlMBDk014TZQR6YEuP6bCz
         8GhZbZAxmZKzFUaOGnpM6xFPtHyFqo5f+sT3scnZKvv/bGIZdzJ7sPmB8WCEIu+8VbM+
         SUFHxFOO0l1YyJFsA8ykpm9euKrCcnXiRDF2XIpSMLRf2dR3k78WmJYFRs7hZiL1N4d7
         lX0A==
X-Gm-Message-State: AOAM533nSJ3mdMaqt0AhweTOJ6b6HGXRCmHJ8AfQ+BYTbZrnc1v884WI
        Kt+l8RTU9y7u4Rokbojr6Ft0U77el7I=
X-Google-Smtp-Source: ABdhPJxptEsAjn9h/p8f0/AdKS7H6bYnE+p9asF58tkLi5VDCWmzUezpj1P96i2zYP4oN03onEMjY9Kwo3k=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9c5:: with SMTP id
 63mr16817690pjo.144.1643331212060; Thu, 27 Jan 2022 16:53:32 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 28 Jan 2022 00:51:57 +0000
In-Reply-To: <20220128005208.4008533-1-seanjc@google.com>
Message-Id: <20220128005208.4008533-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220128005208.4008533-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 11/22] KVM: x86: Use static_call() for copy/move encryption
 context ioctls()
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

Define and use static_call()s for .vm_{copy,move}_enc_context_from(),
mostly so that the op is defined in kvm-x86-ops.h.  This will allow using
KVM_X86_OP in vendor code to wire up the implementation.  Any performance
gains eeked out by using static_call() is a happy bonus and not the
primary motiviation.

Opportunistically refactor the code to reduce indentation and keep line
lengths reasonable, and to be consistent when wrapping versus running
a bit over the 80 char soft limit.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm-x86-ops.h |  2 ++
 arch/x86/kvm/x86.c                 | 17 ++++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index eb93aa439d61..4ee046e60c34 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -110,6 +110,8 @@ KVM_X86_OP(enable_smi_window)
 KVM_X86_OP(mem_enc_op)
 KVM_X86_OP(mem_enc_reg_region)
 KVM_X86_OP(mem_enc_unreg_region)
+KVM_X86_OP(vm_copy_enc_context_from)
+KVM_X86_OP(vm_move_enc_context_from)
 KVM_X86_OP(get_msr_feature)
 KVM_X86_OP(can_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a8ea1b212267..580a2adaec7c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5958,15 +5958,18 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 #endif
 	case KVM_CAP_VM_COPY_ENC_CONTEXT_FROM:
 		r = -EINVAL;
-		if (kvm_x86_ops.vm_copy_enc_context_from)
-			r = kvm_x86_ops.vm_copy_enc_context_from(kvm, cap->args[0]);
-		return r;
+		if (!kvm_x86_ops.vm_copy_enc_context_from)
+			break;
+
+		r = static_call(kvm_x86_vm_copy_enc_context_from)(kvm, cap->args[0]);
+		break;
 	case KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM:
 		r = -EINVAL;
-		if (kvm_x86_ops.vm_move_enc_context_from)
-			r = kvm_x86_ops.vm_move_enc_context_from(
-				kvm, cap->args[0]);
-		return r;
+		if (!kvm_x86_ops.vm_move_enc_context_from)
+			break;
+
+		r = static_call(kvm_x86_vm_move_enc_context_from)(kvm, cap->args[0]);
+		break;
 	case KVM_CAP_EXIT_HYPERCALL:
 		if (cap->args[0] & ~KVM_EXIT_HYPERCALL_VALID_MASK) {
 			r = -EINVAL;
-- 
2.35.0.rc0.227.g00780c9af4-goog

