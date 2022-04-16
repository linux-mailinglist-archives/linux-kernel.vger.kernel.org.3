Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDFED503423
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiDPDpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiDPDp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:45:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF4AA027
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:42:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id l11-20020a170902f68b00b00158a978a3a8so2587301plg.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 20:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=nKPYdcoAR+O0z93CeuVQzqJsKdRmlp95sBm2PZZkh2Q=;
        b=gxfsYYhxAuJu92KlrKTzzOsteey1Iwag9ncOUwIBdu6vepT/7L+HbG0tu2hmkplbv0
         u2Bk7qHGyvgFQMblzFuUAiCL0FEzjvcQq4mTURIjx74rRbAJQkYOLyQDJ6q7Tj/YLoKl
         3r6pOxjxcyLPp7bw1UaJ4kh9930VEZ2lLF5rvh0Ykj6nZ2nLI6UcgXDp3KzSIL75f+58
         XWz6l6uxqHekehFt1w9GhBJBA+51ArcS0dc4yD9L21cXDWJQPJGw4AnhfDke4z8IGwrW
         PkyQMADgWjPiXH8zFbMS14nLY2sJmBzzlrNx1I4uI0A7UHTPv30f8nOSZy3NaxJTr0Ua
         bzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=nKPYdcoAR+O0z93CeuVQzqJsKdRmlp95sBm2PZZkh2Q=;
        b=h5/D0/JvBdYR4Er9OdEqsq+FWHpAaXGl3erfuCCK6UZOBWm13xdX2NSFYpyZwEkaGu
         AqSj5IazXmIknC8otSCPsb9Mj6BcUjqH8l6Cp/cequhcfQxbt3ud22GfuDL0nb1i3oVL
         Exv2fo9AZQtulUK0Mf/Kj19upVr97ctpYyEO5Sn+VJ4tPmVpo2BmNumjHrsx2rUKI2Lu
         ajAngd3iqGGscSUv9zTjU8yONpFlavbsR3Xfk2CeWuoU11dk33HnEY1I0suH0OaOqTy0
         U4IcPrRmHUJKa7RD+mmUaxSCo9+AU1ACooUglv1Vq4fF4QWU+sjwr96vUFTPVo0Nqrrn
         RgMw==
X-Gm-Message-State: AOAM532UtWEfcB9YK3zKproJndVqYfhQ5WHAFGyCVxWyCbr0/GnGG+9e
        EL1v7J3Al6851+6Lrx+oaj+iseJSoLc=
X-Google-Smtp-Source: ABdhPJx6Tmqfrn+hqTO7IpqMzEhjNCsL12jNPtIcg5YqTq3hIvmM7RkIoPH/ztfkLfsd7cfaVb/eiwDeNRc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:858b:b0:1c6:5bc8:781a with SMTP id
 m11-20020a17090a858b00b001c65bc8781amr661086pjn.0.1650080578285; Fri, 15 Apr
 2022 20:42:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 16 Apr 2022 03:42:47 +0000
In-Reply-To: <20220416034249.2609491-1-seanjc@google.com>
Message-Id: <20220416034249.2609491-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220416034249.2609491-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH 2/4] KVM: nVMX: Defer APICv updates while L2 is active until
 L1 is active
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Gaoning Pan <pgn@zju.edu.cn>,
        Yongkang Jia <kangel@zju.edu.cn>,
        Maxim Levitsky <mlevitsk@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defer APICv updates that occur while L2 is active until nested VM-Exit,
i.e. until L1 regains control.  vmx_refresh_apicv_exec_ctrl() assumes L1
is active and (a) stomps all over vmcs02 and (b) neglects to ever updated
vmcs01.  E.g. if vmcs12 doesn't enable the TPR shadow for L2 (and thus no
APICv controls), L1 performs nested VM-Enter APICv inhibited, and APICv
becomes unhibited while L2 is active, KVM will set various APICv controls
in vmcs02 and trigger a failed VM-Entry.  The kicker is that, unless
running with nested_early_check=1, KVM blames L1 and chaos ensues.

The obvious elephant in the room is whether or not KVM needs to disallow
APICv in L2 if it is inhibited in L1.  Luckily, that's largely a moot
point as the only dynamic inhibit conditions that affect VMX are Hyper-V
and IRQ blocking.  IRQ blocking is firmly a debug-only feature, and L1
probably deserves whatever mess it gets by enabling AutoEOI while running
L2 with APICv enabled.

Lack of dynamic toggling is also why this scenario is all but impossible
to encounter in KVM's current form.  But a future patch will pend an
APICv update request _during_ vCPU creation to plug a race where a vCPU
that's being created doesn't get included in the "all vCPUs request"
because it's not yet visible to other vCPUs.  If userspaces restores L2
after VM creation (hello, KVM selftests), the first KVM_RUN will occur
while L2 is active and thus service the APICv update request made during
VM creation.

Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 5 +++++
 arch/x86/kvm/vmx/vmx.c    | 5 +++++
 arch/x86/kvm/vmx/vmx.h    | 1 +
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index a6688663da4d..f5cb18e00e78 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4640,6 +4640,11 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 		kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
 	}
 
+	if (vmx->nested.update_vmcs01_apicv_status) {
+		vmx->nested.update_vmcs01_apicv_status = false;
+		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
+	}
+
 	if ((vm_exit_reason != -1) &&
 	    (enable_shadow_vmcs || evmptr_is_valid(vmx->nested.hv_evmcs_vmptr)))
 		vmx->nested.need_vmcs12_to_shadow_sync = true;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index cf8581978bce..4c407a34b11e 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4174,6 +4174,11 @@ static void vmx_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_vmx *vmx = to_vmx(vcpu);
 
+	if (is_guest_mode(vcpu)) {
+		vmx->nested.update_vmcs01_apicv_status = true;
+		return;
+	}
+
 	pin_controls_set(vmx, vmx_pin_based_exec_ctrl(vmx));
 	if (cpu_has_secondary_exec_ctrls()) {
 		if (kvm_vcpu_apicv_active(vcpu))
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 9c6bfcd84008..b98c7e96697a 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -183,6 +183,7 @@ struct nested_vmx {
 	bool change_vmcs01_virtual_apic_mode;
 	bool reload_vmcs01_apic_access_page;
 	bool update_vmcs01_cpu_dirty_logging;
+	bool update_vmcs01_apicv_status;
 
 	/*
 	 * Enlightened VMCS has been enabled. It does not mean that L1 has to
-- 
2.36.0.rc0.470.gd361397f0d-goog

