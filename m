Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007FE4F0ACF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359267AbiDCPmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359249AbiDCPmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63C413968C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=845WvNiklQhaA5N8dsHhYvh4+Oz8svlNTDz8uRoZK4Q=;
        b=VkJdlp1ozNGFFSYtYfdw9tCgflkvEIy8b6y9QWv6YdBpdCOpW+2+zY6d2APYpG4kpF4byL
        31OTqlCV4PHZaIWxGNLHIhzE5lGtG0ijvqlh5BB/uKiEoUtJZX6wRXAsl9bbSGI2ce+FHF
        BxHf1oVtsbOwbpGTOa61q69IH0Jw9Dg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-612-ct3-QfrSMt-7IHB_MlW_2w-1; Sun, 03 Apr 2022 11:40:48 -0400
X-MC-Unique: ct3-QfrSMt-7IHB_MlW_2w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 66E6F858EEC;
        Sun,  3 Apr 2022 15:40:47 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3FD7A4538D7;
        Sun,  3 Apr 2022 15:40:40 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 11/18] KVM: arm64: Support SDEI_{PRIVATE, SHARED}_RESET
Date:   Sun,  3 Apr 2022 23:39:04 +0800
Message-Id: <20220403153911.12332-12-gshan@redhat.com>
In-Reply-To: <20220403153911.12332-1-gshan@redhat.com>
References: <20220403153911.12332-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_{PRIVATE, SHARED}_RESET. They are used by the
guest to reset the private events on the calling vCPU or the
shared events on all vCPUs.

The shared event isn't supported yet, we simply returns SDEI_SUCCESS
as the guest doesn't know it. It can't stop the guest from using
SDEI service.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 3aca36e7e27b..6716ed020aa2 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -352,6 +352,36 @@ static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
 	return ret;
 }
 
+static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned int i;
+	unsigned long ret = SDEI_SUCCESS;
+
+	/*
+	 * All events, which have been registered, should be private
+	 * because the shared events aren't supported yet, so we needn't
+	 * do anything to reset the shared events.
+	 */
+	if (!private)
+		return ret;
+
+	spin_lock(&vsdei->lock);
+
+	kvm_sdei_for_each_event(vsdei, event, i) {
+		if (!kvm_sdei_is_registered(event))
+			continue;
+
+		if (reset_event(vcpu, event))
+			ret = SDEI_PENDING;
+	}
+
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -400,6 +430,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 		ret = hypercall_mask(vcpu, false);
 		break;
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		ret = hypercall_reset(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		ret = hypercall_reset(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

