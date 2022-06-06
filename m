Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94B053ED9C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 20:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbiFFSJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiFFSJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 14:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DDE57629C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 11:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654538940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bA+N7Acl8NE8LWref9tanrAr4GkJgUhDrnzQeHMj1/E=;
        b=eXxks8J/I5bQD61qhSx6S0N/e1A9wECoPaKQIL7ioMsZF5gnkUnm4niGM0e6EySBxT8gX5
        ievldU//epvrcsBn6JEHmWRdUb2klI9z9vLq+NFyRq63VA4vBPJ30TtBbtJhB5NOeBfyzl
        eDdoxVs4YCZCDQIl/tCWT8n8cZQrVHI=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-dnIakPNVOlm3MpOjZ9kYLA-1; Mon, 06 Jun 2022 14:08:55 -0400
X-MC-Unique: dnIakPNVOlm3MpOjZ9kYLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B24B929ABA3B;
        Mon,  6 Jun 2022 18:08:53 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B0551121315;
        Mon,  6 Jun 2022 18:08:50 +0000 (UTC)
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5/7] KVM: x86: disable preemption while updating apicv inhibition
Date:   Mon,  6 Jun 2022 21:08:27 +0300
Message-Id: <20220606180829.102503-6-mlevitsk@redhat.com>
In-Reply-To: <20220606180829.102503-1-mlevitsk@redhat.com>
References: <20220606180829.102503-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently nothing prevents preemption in kvm_vcpu_update_apicv.

On SVM, If the preemption happens after we update the
vcpu->arch.apicv_active, the preemption itself will
'update' the inhibition since the AVIC will be first disabled
on vCPU unload and then enabled, when the current task
is loaded again.

Then we will try to update it again, which will lead to a warning
in __avic_vcpu_load, that the AVIC is already enabled.

Fix this by disabling preemption in this code.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2db6f0373fa3f..9bbe6144d82ae 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9893,6 +9893,7 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 		return;
 
 	down_read(&vcpu->kvm->arch.apicv_update_lock);
+	preempt_disable();
 
 	activate = kvm_vcpu_apicv_activated(vcpu);
 
@@ -9913,6 +9914,7 @@ void kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 out:
+	preempt_enable();
 	up_read(&vcpu->kvm->arch.apicv_update_lock);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_update_apicv);
-- 
2.26.3

