Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0FE4F0AC7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359246AbiDCPmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359249AbiDCPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B3462C10F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N2/VYgb8BwuXP4gy6xwNWoMfI+WOYmTAaqXhSYXVe7M=;
        b=Q3XnzyJf1fnmfhGOLxF4UYVL5MB+OB+RVkMnZpLqR7iqP/7v24T/EaLT6XNnfw4BlEo7hl
        98Pq5laP7cEdMtRPFB6mYoPYCR7VbrKsXHO13bz5W9YGsRvBdCAkrwPmoytHeaZoDh89u9
        jIsslxZVSB9O3yBcu8ILAvX2WuEKhYw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-KrJb2otjMy6i2P7h8Ij8lw-1; Sun, 03 Apr 2022 11:40:07 -0400
X-MC-Unique: KrJb2otjMy6i2P7h8Ij8lw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 891473C02B6F;
        Sun,  3 Apr 2022 15:40:06 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BB6C403172;
        Sun,  3 Apr 2022 15:40:00 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 05/18] KVM: arm64: Support SDEI_EVENT_{ENABLE, DISABLE}
Date:   Sun,  3 Apr 2022 23:38:58 +0800
Message-Id: <20220403153911.12332-6-gshan@redhat.com>
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

This supports SDEI_EVENT_{ENABLE, DISABLE} hypercall. After the
event is registered, it won't be raised and delivered to guest
until it's enabled. On other hand, the event won't be delivered
to guest if it's disabled.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 89c1b231cb60..941263578b30 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -101,6 +101,45 @@ static unsigned long hypercall_register(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long hypercall_enable(struct kvm_vcpu *vcpu, bool enable)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	struct kvm_sdei_event *event;
+	unsigned long num = smccc_get_arg(vcpu, 1);
+	unsigned long ret = SDEI_SUCCESS;
+
+	if (!kvm_sdei_is_supported(num)) {
+		ret = SDEI_INVALID_PARAMETERS;
+		goto out;
+	}
+
+	spin_lock(&vsdei->lock);
+
+	/* Check if the event exists */
+	event = find_event(vcpu, num);
+	if (!event) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	/* Check the event state */
+	if (!kvm_sdei_is_registered(event) ||
+	    kvm_sdei_is_unregister_pending(event)) {
+		ret = SDEI_DENIED;
+		goto unlock;
+	}
+
+	if (enable)
+		kvm_sdei_set_enabled(event);
+	else
+		kvm_sdei_clear_enabled(event);
+
+unlock:
+	spin_unlock(&vsdei->lock);
+out:
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -125,6 +164,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_REGISTER:
 		ret = hypercall_register(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_ENABLE:
+		ret = hypercall_enable(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_EVENT_DISABLE:
+		ret = hypercall_enable(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

