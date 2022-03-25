Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE3A4E7419
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354034AbiCYNXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353945AbiCYNXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E435D110E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 06:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648214507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F/zMX3vMpimh1Q2Dt4VlHRposb+rNApFkADJ1V2LHvc=;
        b=ar0n9IyyeipX04SANk041sAC8us6qdUld9pJNzEH/3Pi2sH5A5fbbvQxrVxuzt6TgpqhOz
        7NwY0UkHeM4HO8qMH4xNH+m7sMyjb3tJUznEw6xkin/DrEIxdS87wSrHeZ+cRSVS1MNFno
        bjT3pJUiPjh+ArCP4iwJeG8wGxk3+hw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-Qts0xWIXPZib_4VTGFShrQ-1; Fri, 25 Mar 2022 09:21:46 -0400
X-MC-Unique: Qts0xWIXPZib_4VTGFShrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CC5D73C14CCF;
        Fri, 25 Mar 2022 13:21:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.194.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF3CC2166B16;
        Fri, 25 Mar 2022 13:21:43 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] KVM: x86: Check lapic_in_kernel() before attempting to set a SynIC irq
Date:   Fri, 25 Mar 2022 14:21:38 +0100
Message-Id: <20220325132140.25650-2-vkuznets@redhat.com>
In-Reply-To: <20220325132140.25650-1-vkuznets@redhat.com>
References: <20220325132140.25650-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When KVM_CAP_HYPERV_SYNIC{,2} is activated, KVM already checks for
irqchip_in_kernel() so normally SynIC irqs should never be set. It is,
however,  possible for a misbehaving VMM to write to SYNIC/STIMER MSRs
causing erroneous behavior.

The immediate issue being fixed is that kvm_irq_delivery_to_apic()
(kvm_irq_delivery_to_apic_fast()) crashes when called with
'irq.shorthand = APIC_DEST_SELF' and 'src == NULL'.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/hyperv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 7480e3562d30..a79a094c1266 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -453,6 +453,9 @@ static int synic_set_irq(struct kvm_vcpu_hv_synic *synic, u32 sint)
 	struct kvm_lapic_irq irq;
 	int ret, vector;
 
+	if (KVM_BUG_ON(!lapic_in_kernel(vcpu), vcpu->kvm))
+		return -EINVAL;
+
 	if (sint >= ARRAY_SIZE(synic->sint))
 		return -EINVAL;
 
-- 
2.35.1

