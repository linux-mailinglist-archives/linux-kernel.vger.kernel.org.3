Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9220535B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbiE0IEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348519AbiE0IEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC573FF5B2
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P4jpm8XSirJ1238sxZZHFV9+DDVhOPJcfnDADqydjXI=;
        b=NpxKsnCvkGm1GG+2dOkHIGJ5qexVpAk5pFDWQHNKMy1nO7Qbs0m6H6iSpkS/xumr9fIqnG
        hgHTuPxoCI/y5A3Ak2bk6DU9fQj+ctgS02GoVVyqhGd5iyzmPe9KYyWuT3YDqOH5QgCAFt
        2ykSTvLgcMXkmJQyiVwigN67TNgEh24=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-M6zTRbdCOiKQyGV6iliAuA-1; Fri, 27 May 2022 04:04:14 -0400
X-MC-Unique: M6zTRbdCOiKQyGV6iliAuA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04D042949BAE;
        Fri, 27 May 2022 08:04:14 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A90A42026D64;
        Fri, 27 May 2022 08:04:07 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 04/22] KVM: arm64: Support EVENT_REGISTER hypercall
Date:   Fri, 27 May 2022 16:02:35 +0800
Message-Id: <20220527080253.1562538-5-gshan@redhat.com>
In-Reply-To: <20220527080253.1562538-1-gshan@redhat.com>
References: <20220527080253.1562538-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports EVENT_REGISTER hypercall, which is used by guest
to register event. The event won't be raised until it's registered
and enabled. There are several cases where the request is injected:

  * The event isn't supported by KVM

  * The event has been registered or pending for unregistration

  * The reserved bits or relative mode are set in @flags argument

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 0c4415fcad16..40c2d585470d 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -13,6 +13,34 @@
 #include <kvm/arm_hypercalls.h>
 #include <asm/kvm_sdei.h>
 
+static unsigned long event_register(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long flags = smccc_get_arg(vcpu, 4);
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return SDEI_INVALID_PARAMETERS;
+
+	/* Reject if the reserved bits or relative mode are set */
+	if (flags & ~0x1UL)
+		return SDEI_INVALID_PARAMETERS;
+
+	/*
+	 * Reject if the event has been registered or pending for
+	 * unregistration.
+	 */
+	if (test_bit(num, &vsdei->registered) ||
+	    test_bit(num, &vsdei->running))
+		return SDEI_DENIED;
+
+	vsdei->handlers[num].ep_addr = smccc_get_arg(vcpu, 2);
+	vsdei->handlers[num].ep_arg = smccc_get_arg(vcpu, 3);
+	set_bit(num, &vsdei->registered);
+
+	return SDEI_SUCCESS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -31,6 +59,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	}
 
 	switch (func) {
+	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
+		ret = event_register(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

