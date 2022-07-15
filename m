Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352F057684E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiGOUmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiGOUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:42:37 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B437FE65
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:42:36 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r13-20020a17090a454d00b001f04dfc6195so3489118pjm.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=wPnZg/weEXDMrhZ6n4kyBPhV/0y1/e3H5B3IYu4XWF8=;
        b=kL+/QFKDFfHHa2pgMd2n57g67SH56QIHlNyzEEpgivSulybkQnQEJVhZms0TIltHzX
         YanVPCAW9kq18DZ033z657a3P1S/+yTRqtyWbMUWNHBSrqC8bOaZudpmpMIAiU5eeKxN
         EK73geAcL9a8nvZbF+DvOhzOZpnZIZCge+IlpMpwETikBih5dS15EjEFJRAouIC0kpXr
         Hrn0oOTVuh50pyxn+VfCGUtyKrZAD/LFojoheRITBQLjZBtvqnWoyer8mEDjoEFibQp2
         tje+D3oyJOPTgJ+FIrbV5VVA4ldayawW9NxUR9/y1S0fmSnbOMGcA4lgaI24qQTqSvUZ
         fgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=wPnZg/weEXDMrhZ6n4kyBPhV/0y1/e3H5B3IYu4XWF8=;
        b=ErbqWLfFjakxojEfw/TbQbJOvxmsZL6yLl6eUA8jUnnIBLtlLw5T5AxPTU3fNMgP/D
         22iOGvlyE9RoPvT20HCi9YnO4vDck97j74Eqt8YWaSFtJzSheBCmBf8r9Ngq2FgsMK3R
         vl9KFmGioYHevCLWu+qbnpHiOhXA2exWPgXoPwFtdkew5EuThpJAZrotM6OWOvxrf+MU
         A1Gk9w7t0TCRAL+FYJS7+HxcMpwfuYEK1+lKdiw/Wvcl3DZmqcucSO3TOpiLbZmfah0Y
         1IhiYgg91qiNez0anHxDF7hqdSQ0ncuZvw4N2O+QKZBPvVQiG/yKwmgX5+tqmlaKjLUo
         JdFQ==
X-Gm-Message-State: AJIora9KFHSVrMEB7PsuKA+Aq/WjagGr1W8AKaHpMBRZp/ju5pf8e/My
        fCAbmRi7Sty/gGGjZfuVS5Q5e/ck+/k=
X-Google-Smtp-Source: AGRyM1tOruFNn3/TWHRtsDXTOSPK6qWy/lHTC7NRHc9MhPhSrIFA8RJpO4OPdt5NP7OIhlA25Esj07e+g7Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:eb8c:b0:16b:f104:71bc with SMTP id
 q12-20020a170902eb8c00b0016bf10471bcmr15317039plg.30.1657917755968; Fri, 15
 Jul 2022 13:42:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 20:42:03 +0000
In-Reply-To: <20220715204226.3655170-1-seanjc@google.com>
Message-Id: <20220715204226.3655170-2-seanjc@google.com>
Mime-Version: 1.0
References: <20220715204226.3655170-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 01/24] KVM: nVMX: Unconditionally purge queued/injected
 events on nested "exit"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop pending exceptions and events queued for re-injection when leaving
nested guest mode, even if the "exit" is due to VM-Fail, SMI, or forced
by host userspace.  Failure to purge events could result in an event
belonging to L2 being injected into L1.

This _should_ never happen for VM-Fail as all events should be blocked by
nested_run_pending, but it's possible if KVM, not the L1 hypervisor, is
the source of VM-Fail when running vmcs02.

SMI is a nop (barring unknown bugs) as recognition of SMI and thus entry
to SMM is blocked by pending exceptions and re-injected events.

Forced exit is definitely buggy, but has likely gone unnoticed because
userspace probably follows the forced exit with KVM_SET_VCPU_EVENTS (or
some other ioctl() that purges the queue).

Fixes: 4f350c6dbcb9 ("kvm: nVMX: Handle deferred early VMLAUNCH/VMRESUME failure properly")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bfa366938c49..8c2c81406248 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4250,14 +4250,6 @@ static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 			nested_vmx_abort(vcpu,
 					 VMX_ABORT_SAVE_GUEST_MSR_FAIL);
 	}
-
-	/*
-	 * Drop what we picked up for L2 via vmx_complete_interrupts. It is
-	 * preserved above and would only end up incorrectly in L1.
-	 */
-	vcpu->arch.nmi_injected = false;
-	kvm_clear_exception_queue(vcpu);
-	kvm_clear_interrupt_queue(vcpu);
 }
 
 /*
@@ -4596,6 +4588,17 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		WARN_ON_ONCE(nested_early_check);
 	}
 
+	/*
+	 * Drop events/exceptions that were queued for re-injection to L2
+	 * (picked up via vmx_complete_interrupts()), as well as exceptions
+	 * that were pending for L2.  Note, this must NOT be hoisted above
+	 * prepare_vmcs12(), events/exceptions queued for re-injection need to
+	 * be captured in vmcs12 (see vmcs12_save_pending_event()).
+	 */
+	vcpu->arch.nmi_injected = false;
+	kvm_clear_exception_queue(vcpu);
+	kvm_clear_interrupt_queue(vcpu);
+
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
 	/* Update any VMCS fields that might have changed while L2 ran */
-- 
2.37.0.170.g444d1eabd0-goog

