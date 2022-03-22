Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0624E3A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 09:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiCVIKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 04:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiCVIKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 04:10:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74CA42BFA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 01:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647936526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CA0H5z8Y8jCywSeEwJTZ/p/KNFj1y45LOqR+04gyQvM=;
        b=P4lejcfDAKxMRzaHpAeRSzLSu6hyMzT1etaaXEZuOz37uFb5/hryx/Tz5CqoWausnHFmyT
        MRAhDcLjDHMyhIMfjZp2etuRx1IjL80eW9gLobgHVLhxKNVKNzX2c0agKBZ+IY5ts+ANER
        9XGBqOqMXnJTftO4DgTHS0XXL1CnjvU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-IV6VDCqaMjeWV-YfzD9R6Q-1; Tue, 22 Mar 2022 04:08:43 -0400
X-MC-Unique: IV6VDCqaMjeWV-YfzD9R6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B5B1C05AF2;
        Tue, 22 Mar 2022 08:08:42 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-33.pek2.redhat.com [10.72.12.33])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0ACDB1121324;
        Tue, 22 Mar 2022 08:08:32 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com,
        shannon.zhaosl@gmail.com, maz@kernel.org,
        Jonathan.Cameron@huawei.com, will@kernel.org, pbonzini@redhat.com,
        james.morse@arm.com, mark.rutland@arm.com, drjones@redhat.com,
        vkuznets@redhat.com, shan.gavin@gmail.com
Subject: [PATCH v5 06/22] KVM: arm64: Support SDEI_EVENT_CONTEXT hypercall
Date:   Tue, 22 Mar 2022 16:06:54 +0800
Message-Id: <20220322080710.51727-7-gshan@redhat.com>
In-Reply-To: <20220322080710.51727-1-gshan@redhat.com>
References: <20220322080710.51727-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supports SDEI_EVENT_CONTEXT hypercall. It's used by the guest
to retrieve the registers (R0 - R17) in the preempted context
in the SDEI event handler. The preempted context is saved prior to
servicing or handling the SDEI event and restored after that.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 4ab58f264992..4488d3f044f2 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -297,6 +297,34 @@ static unsigned long hypercall_enable(struct kvm_vcpu *vcpu, bool enable)
 	return ret;
 }
 
+static unsigned long hypercall_context(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_vcpu_regs_state *regs;
+	unsigned long param_id = smccc_get_arg1(vcpu);
+	unsigned long ret = SDEI_SUCCESS;
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if the pending event exists */
+	if (!vsdei->critical_event && !vsdei->normal_event) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Fetch the requested register */
+	regs = vsdei->critical_event ? &vsdei->state.critical_regs :
+				       &vsdei->state.normal_regs;
+	if (param_id < ARRAY_SIZE(regs->regs))
+		ret = regs->regs[param_id];
+	else
+		ret = SDEI_INVALID_PARAMETERS;
+
+unlock:
+	spin_unlock(&vsdei->lock);
+	return ret;
+}
+
 int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = vcpu->kvm;
@@ -333,6 +361,8 @@ int kvm_sdei_hypercall(struct kvm_vcpu *vcpu)
 		ret = hypercall_enable(vcpu, false);
 		break;
 	case SDEI_1_0_FN_SDEI_EVENT_CONTEXT:
+		ret = hypercall_context(vcpu);
+		break;
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE:
 	case SDEI_1_0_FN_SDEI_EVENT_COMPLETE_AND_RESUME:
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
-- 
2.23.0

