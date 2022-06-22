Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EC855517E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376431AbiFVQo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359504AbiFVQop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D9E5369D4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655916283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pPzUDtn7MUBOJvHbms5ez003D0L9U3ISPpMur3dPFnU=;
        b=Ezdlr1SoVVfsazHtc1kcQ8PF4wEUZ9K8/l70i2LdhheLVAUlN+PiEHI/z55ttiVPR3lJBn
        nbopVxEYMgXhgo921KhMH7/773SwbH6FiAEwLfrjbNISNYTLDHyvMmjwktFiYtjQzuYYOd
        F+kAA8REiBVRzZwz/8sk5o0T337soKc=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-OWK7qWCaNfm25c58Cceq7w-1; Wed, 22 Jun 2022 12:44:42 -0400
X-MC-Unique: OWK7qWCaNfm25c58Cceq7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3A5129DD9A2;
        Wed, 22 Jun 2022 16:44:41 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.195.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94FA640CFD0A;
        Wed, 22 Jun 2022 16:44:39 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RFC v1 03/10] KVM: VMX: Move CPU_BASED_{CR3_LOAD,CR3_STORE,INVLPG}_EXITING filtering out of setup_vmcs_config()
Date:   Wed, 22 Jun 2022 18:44:25 +0200
Message-Id: <20220622164432.194640-4-vkuznets@redhat.com>
In-Reply-To: <20220622164432.194640-1-vkuznets@redhat.com>
References: <20220622164432.194640-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 01294a2fc1c1..4583de7f0324 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4293,6 +4293,16 @@ static u32 vmx_exec_control(struct vcpu_vmx *vmx)
 			  CPU_BASED_MONITOR_TRAP_FLAG |
 			  CPU_BASED_PAUSE_EXITING);
 
+	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_ENABLE_EPT) {
+		/*
+		 * CR3 accesses and invlpg don't need to cause VM Exits when EPT
+		 * enabled.
+		 */
+		exec_control &= ~(CPU_BASED_CR3_LOAD_EXITING |
+				  CPU_BASED_CR3_STORE_EXITING |
+				  CPU_BASED_INVLPG_EXITING);
+	}
+
 #ifdef CONFIG_X86_64
 	if (exec_control & CPU_BASED_TPR_SHADOW)
 		exec_control &= ~CPU_BASED_CR8_LOAD_EXITING &
-- 
2.35.3

