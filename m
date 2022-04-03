Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BE34F0AD2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359257AbiDCPnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359270AbiDCPmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 234B02ED41
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zEZ1sFHt59w1V42A6eQJBGsn1VTrcUf9aWKsQZVBwmQ=;
        b=A4XiVAG4ZhoGRGAr4eBig3h6hILC6+fYFnbHX9l2MLP+uNyuDOq4KQ092Y2MW/XJItTNFs
        JP6mGJucD9I/LH5JORCF/SQqwIioYjjjb3uAU47E0A20OwooYa19+WlCSlFZp6gE/as24Q
        3PbJeSoyJSbYZCQ++EAR2TPPRHEroQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-332-R-anuXI8MaKX2f0el4fqWQ-1; Sun, 03 Apr 2022 11:40:41 -0400
X-MC-Unique: R-anuXI8MaKX2f0el4fqWQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 87BE082A6C2;
        Sun,  3 Apr 2022 15:40:40 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7ABB2403172;
        Sun,  3 Apr 2022 15:40:34 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 10/18] KVM: arm64: Support SDEI_PE_{MASK, UNMASK} hypercall
Date:   Sun,  3 Apr 2022 23:39:03 +0800
Message-Id: <20220403153911.12332-11-gshan@redhat.com>
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

This supports SDEI_PE_{MASK, UNMASK} hypercall. They are used by
guest to stop or start receiving event on the specified vcpu.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 9e642d01e303..3aca36e7e27b 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -340,6 +340,18 @@ static unsigned long hypercall_info(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_mask(struct kvm_vcpu *vcpu, bool mask)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned long ret = SDEI_SUCCESS;
+
+	spin_lock(&vsdei->lock);
+	vsdei->masked = mask ? 1 : 0;
+	spin_unlock(&vsdei->lock);
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -382,6 +394,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
 		ret = hypercall_info(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+		ret = hypercall_mask(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+		ret = hypercall_mask(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

