Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA9F5884A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiHBXH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbiHBXHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:07:25 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC51233E23
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 16:07:23 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id o21-20020a17090a9f9500b001f0574225faso103011pjp.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 16:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:from:to:cc;
        bh=wxekZ3ryQMo0zEK6TK2UEFmX6M8kBLcXtxqwenvhf90=;
        b=LsjTQbUVPs5ep6EeANhLZaoS+w+TGBfHkB0X3+hbHXpwwof50NPm5/gADNmNUPVGry
         jetfkpeTWJtAJf17ryFm6ijrEGTkAGEyuGbDWLM+Yw4GCOZlsF+enhh3kFIpZ3eG5YrO
         N8WRxuFAOjYf4gkrw+4AippD/Dr+fWGQFmX4g5vnfSn2RUXciqCq/17CWr1VFMtBLQtF
         5vZZ7mXUsOowuCfyC41hylKc9PwdoeV2gUCnKbrPwKSiVEHSgmjSCxRkJoNvTxQiLi1p
         jrCbI7knR/gafVKVNkQWnXpSzbQS6mWSjK3qN9hM4G14oGIuzS1QbC6wGPhZIHl4aqMC
         zIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=wxekZ3ryQMo0zEK6TK2UEFmX6M8kBLcXtxqwenvhf90=;
        b=Z3Ms3O5sFZW4NO18MPmKy7v+OgSHxdDjVRpH/wRkKidzpdanPEZeGUsyzek11uOjRD
         yiKxl74kSkbcN8uqAkFyWRk/1wVFzuOK7V8NNy4aBJ9SlJKPKq0RdOCqvnmc2MwOJrFR
         SfOQRDdF7vvlrIKQSU+9BMuMMQX7I+tP2Uy3T4bhPBuaVpbjumxI5yg+nLJyBJka3cKm
         TmhoIdfW/uhKT0HyWcVgRP/Psl0NrYvakUitqUj1wsdNmXqJuH3B+MGJMlZdrdFqrasE
         HkRzi2jBqRGE+OEhj/PlU94dOk2NJjy1MAJF1u9VqQkU2CIFjiV0IyZdokvkxkFliO2O
         5CMQ==
X-Gm-Message-State: ACgBeo1pL3CHm4ggkiGctg3Fy1aqnp7Q7o8cbP4LEUbHiavHbmsHjBH3
        aacmNU/5MaCOW8EH9JH0LA3PaSaZunCa
X-Google-Smtp-Source: AA6agR65A5j6bivlk0aePat9wLJNwHNc3cREL7Nm0VWN8wKalvs4bXoMwB3bdunep7rlIGdTrx9S1eAWFa9v
X-Received: from mizhang-super.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1071])
 (user=mizhang job=sendgmr) by 2002:a17:90b:1bc6:b0:1f5:313a:de4b with SMTP id
 oa6-20020a17090b1bc600b001f5313ade4bmr1871127pjb.4.1659481643558; Tue, 02 Aug
 2022 16:07:23 -0700 (PDT)
Reply-To: Mingwei Zhang <mizhang@google.com>
Date:   Tue,  2 Aug 2022 23:07:14 +0000
In-Reply-To: <20220802230718.1891356-1-mizhang@google.com>
Message-Id: <20220802230718.1891356-2-mizhang@google.com>
Mime-Version: 1.0
References: <20220802230718.1891356-1-mizhang@google.com>
X-Mailer: git-send-email 2.37.1.455.g008518b4e5-goog
Subject: [PATCH 1/5] KVM: x86: Get vmcs12 pages before checking pending interrupts
From:   Mingwei Zhang <mizhang@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Mingwei Zhang <mizhang@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver Upton <oupton@google.com>

vmx_guest_apic_has_interrupts implicitly depends on the virtual APIC
page being present + mapped into the kernel address space. However, with
demand paging we break this dependency, as the KVM_REQ_GET_VMCS12_PAGES
event isn't assessed before entering vcpu_block.

Fix this by getting vmcs12 pages before inspecting the guest's APIC
page. Note that upstream does not have this issue, as they will directly
get the vmcs12 pages on vmlaunch/vmresume instead of relying on the
event request mechanism. However, the upstream approach is problematic,
as the vmcs12 pages will not be present if a live migration occurred
before checking the virtual APIC page.

Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
---
 arch/x86/kvm/x86.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 5366f884e9a7..1d3d8127aaea 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10599,6 +10599,23 @@ static inline int vcpu_block(struct kvm_vcpu *vcpu)
 {
 	bool hv_timer;
 
+	/*
+	 * We must first get the vmcs12 pages before checking for interrupts
+	 * that might unblock the guest if L1 is using virtual-interrupt
+	 * delivery.
+	 */
+	if (kvm_check_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu)) {
+		/*
+		 * If we have to ask user-space to post-copy a page,
+		 * then we have to keep trying to get all of the
+		 * VMCS12 pages until we succeed.
+		 */
+		if (unlikely(!kvm_x86_ops.nested_ops->get_nested_state_pages(vcpu))) {
+			kvm_make_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
+			return 0;
+		}
+	}
+
 	if (!kvm_arch_vcpu_runnable(vcpu)) {
 		/*
 		 * Switch to the software timer before halt-polling/blocking as
-- 
2.37.1.455.g008518b4e5-goog

