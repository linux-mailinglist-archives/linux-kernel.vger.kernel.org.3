Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3E535AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344493AbiE0IFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349272AbiE0IFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C510FD359
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0BNXaqWA1otDLXqlPZtOcrW0E3FZ4yYhwe+GYceYi8I=;
        b=bG71kPMmuBxipT/6fQIisVtCDxwpToSEuzKEkF7t0pEO7p4y1u4sUMc4KHXzPuIaZLHzl8
        xY7G3jyTHyyo5HGO2vNai2ntfJIZmKvIkeuXAL/Nvw1zrANCzIxsH3ZhEHYvjqmKZhAGjE
        rsyUraHmeKzfgUqQdPP+PRsVO8pEEmM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-NQFO-vD3OKS2WgVUIQ3FNg-1; Fri, 27 May 2022 04:05:04 -0400
X-MC-Unique: NQFO-vD3OKS2WgVUIQ3FNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 211233804506;
        Fri, 27 May 2022 08:05:04 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 391E42026D64;
        Fri, 27 May 2022 08:04:56 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 10/22] KVM: arm64: Support PE_{MASK, UNMASK} hypercall
Date:   Fri, 27 May 2022 16:02:41 +0800
Message-Id: <20220527080253.1562538-11-gshan@redhat.com>
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

This supports PE_{MASK, UNMASK} hypercall. When PE_UNMASK is called,
KVM_REQ_SDEI request becomes pending if there are any events need
to be delivered.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index cea523418c75..6afa49b4f3c7 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -169,6 +169,21 @@ static unsigned long event_info(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static unsigned long pe_mask(struct kvm_vcpu *vcpu, bool mask)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+
+	if (mask) {
+		vcpu->arch.flags |= KVM_ARM64_SDEI_MASKED;
+	} else {
+		vcpu->arch.flags &= ~KVM_ARM64_SDEI_MASKED;
+		if (vsdei->pending)
+			kvm_make_request(KVM_REQ_SDEI, vcpu);
+	}
+
+	return SDEI_SUCCESS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -208,6 +223,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_EVENT_GET_INFO:
 		ret = event_info(vcpu);
 		break;
+	case SDEI_1_0_FN_SDEI_PE_MASK:
+		ret = pe_mask(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_PE_UNMASK:
+		ret = pe_mask(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

