Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC681535AFF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349033AbiE0IFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240023AbiE0IE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:04:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5367D10275F
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Two26LWqm11I3Z4UV+vVjj4R+s2XokxqwlwfmiyoUok=;
        b=ALK2nO4gTesCV0WW7g9YkrWjD/qQUICeSDJ0jDJizi8r9+WEo54YXTqntYyXdtOmOZ9G2r
        y+sfi6XuEzbWw73GZtprBEYe9j8l9z4vbiuf8cwyOJzqvpUFWh+hndumpH0y9a33ITm2Ta
        fhqHPwOYYcbRVbxmAJ4Wr7Q4jk1orU0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-3mnuTZQHPOCrMuMea_WNNw-1; Fri, 27 May 2022 04:04:49 -0400
X-MC-Unique: 3mnuTZQHPOCrMuMea_WNNw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 530E780A0B5;
        Fri, 27 May 2022 08:04:48 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A35432026D64;
        Fri, 27 May 2022 08:04:41 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 08/22] KVM: arm64: Support EVENT_STATUS hypercall
Date:   Fri, 27 May 2022 16:02:39 +0800
Message-Id: <20220527080253.1562538-9-gshan@redhat.com>
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

This supports EVENT_STATUS hypercall. It's used to retrieve the
status about the specified event. A bitmap is returned to represent
the event status, which includes state of registration, enablement,
and running.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index b44ab302732d..377341f229da 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -118,6 +118,25 @@ static unsigned long event_unregister(struct kvm_vcpu *vcpu)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long event_status(struct kvm_vcpu *vcpu)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num = smccc_get_arg(vcpu, 1);
+	unsigned long ret = 0;
+
+	if (num >= KVM_NR_SDEI_EVENTS)
+		return SDEI_INVALID_PARAMETERS;
+
+	if (test_bit(num, &vsdei->registered))
+		ret |= (1UL << SDEI_EVENT_STATUS_REGISTERED);
+	if (test_bit(num, &vsdei->enabled))
+		ret |= (1UL << SDEI_EVENT_STATUS_ENABLED);
+	if (test_bit(num, &vsdei->running))
+		ret |= (1UL << SDEI_EVENT_STATUS_RUNNING);
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -151,6 +170,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_UNREGISTER:
 		ret = event_unregister(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_EVENT_STATUS:
+		ret = event_status(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

