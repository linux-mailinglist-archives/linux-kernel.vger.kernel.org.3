Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC3A587FD8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiHBQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237598AbiHBQJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 12:09:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01F424B0E1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659456519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osVaW9+zyJiKzuJgrt2w7CnJ6sfC0FpxH+0hgpS9EIo=;
        b=hjN2/gitdkk7Wui97r270RzeFGMK8SsM/g5LTV0YSO1NMtg+kxYU+QZKkcb0wK3jolrtxh
        6dU9r3uo4wO92w+IOY6+dBuqij4ayDIH/Cwl+4ybjNywuE3dnWEF17RRxrLrnU0V+Oxj2C
        /EP0r86oNpXBqQqDgCsGNS1aVcB0m4g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61-qK0ZYoIXPQWhE0aFj2rYxA-1; Tue, 02 Aug 2022 12:08:38 -0400
X-MC-Unique: qK0ZYoIXPQWhE0aFj2rYxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FEC23C0D856;
        Tue,  2 Aug 2022 16:08:37 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2145C2166B26;
        Tue,  2 Aug 2022 16:08:34 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/26] KVM: VMX: Check CPU_BASED_{INTR,NMI}_WINDOW_EXITING in setup_vmcs_config()
Date:   Tue,  2 Aug 2022 18:07:43 +0200
Message-Id: <20220802160756.339464-14-vkuznets@redhat.com>
In-Reply-To: <20220802160756.339464-1-vkuznets@redhat.com>
References: <20220802160756.339464-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_BASED_{INTR,NMI}_WINDOW_EXITING controls are toggled dynamically by
vmx_enable_{irq,nmi}_window, handle_interrupt_window(), handle_nmi_window()
but setup_vmcs_config() doesn't check their existence. Add the check and
filter the controls out in vmx_exec_control().

Note: KVM explicitly supports CPUs without VIRTUAL_NMIS and all these CPUs
are supposedly lacking NMI_WINDOW_EXITING too. Adjust cpu_has_virtual_nmis()
accordingly.

No functional change intended.

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/capabilities.h | 3 ++-
 arch/x86/kvm/vmx/vmx.c          | 8 +++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index c5e5dfef69c7..faee1db8b0e0 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -82,7 +82,8 @@ static inline bool cpu_has_vmx_basic_inout(void)
 
 static inline bool cpu_has_virtual_nmis(void)
 {
-	return vmcs_config.pin_based_exec_ctrl & PIN_BASED_VIRTUAL_NMIS;
+	return vmcs_config.pin_based_exec_ctrl & PIN_BASED_VIRTUAL_NMIS &&
+	       vmcs_config.cpu_based_exec_ctrl & CPU_BASED_NMI_WINDOW_EXITING;
 }
 
 static inline bool cpu_has_vmx_preemption_timer(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 5429101eea87..554326651372 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2566,10 +2566,12 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 	      CPU_BASED_MWAIT_EXITING |
 	      CPU_BASED_MONITOR_EXITING |
 	      CPU_BASED_INVLPG_EXITING |
-	      CPU_BASED_RDPMC_EXITING;
+	      CPU_BASED_RDPMC_EXITING |
+	      CPU_BASED_INTR_WINDOW_EXITING;
 
 	opt = CPU_BASED_TPR_SHADOW |
 	      CPU_BASED_USE_MSR_BITMAPS |
+	      CPU_BASED_NMI_WINDOW_EXITING |
 	      CPU_BASED_ACTIVATE_SECONDARY_CONTROLS |
 	      CPU_BASED_ACTIVATE_TERTIARY_CONTROLS;
 	if (adjust_vmx_controls(min, opt, MSR_IA32_VMX_PROCBASED_CTLS,
@@ -4380,6 +4382,10 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 {
 	u32 exec_control = vmcs_config.cpu_based_exec_ctrl;
 
+	/* INTR_WINDOW_EXITING and NMI_WINDOW_EXITING are toggled dynamically */
+	exec_control &= ~(CPU_BASED_INTR_WINDOW_EXITING |
+			  CPU_BASED_NMI_WINDOW_EXITING);
+
 	if (vmx->vcpu.arch.switch_db_regs & KVM_DEBUGREG_WONT_EXIT)
 		exec_control &= ~CPU_BASED_MOV_DR_EXITING;
 
-- 
2.35.3

