Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60667535AFE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349252AbiE0IFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349538AbiE0IFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA36B43EDE
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 01:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653638719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=990zi+sfu+1KWMZVgqplhrYTyhVc+VOJOjIr/irisRU=;
        b=H3xob5f9duKrdRRSYSSjLDG2P55A9+isW/I/Ch1SG1tUNIlkCXQzGrFsj89wHWIWg1gLlh
        miyNmPmvYutRAdxbi3fEaxAaqdXj2+D1s1XsrXF3Pf3jcy1e6UamUIESsVRvVckALD8xaB
        A0+4A+rKFLtsgjGYm8MgUMaoeOiCDfY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-12-TbYShRdBOM6hGLgfZR7QJg-1; Fri, 27 May 2022 04:05:12 -0400
X-MC-Unique: TbYShRdBOM6hGLgfZR7QJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C116B1C161AE;
        Fri, 27 May 2022 08:05:11 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E4D2A2026D64;
        Fri, 27 May 2022 08:05:04 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     maz@kernel.org, linux-kernel@vger.kernel.org, eauger@redhat.com,
        oupton@google.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org,
        james.morse@arm.com, mark.rutland@arm.com,
        shannon.zhaosl@gmail.com, shijie@amperemail.onmicrosoft.com,
        shan.gavin@gmail.com
Subject: [PATCH v7 11/22] KVM: arm64: Support {PRIVATE, SHARED}_RESET hypercall
Date:   Fri, 27 May 2022 16:02:42 +0800
Message-Id: <20220527080253.1562538-12-gshan@redhat.com>
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

This supports {PRIVATE, SHARED}_RESET hypercall. There is nothing
to do if we're going to reset the shared events, which are not
supported. For the private events, their registered and enabled
state are cleared.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index 6afa49b4f3c7..42ba6f97b168 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -184,6 +184,26 @@ static unsigned long pe_mask(struct kvm_vcpu *vcpu, bool mask)
 	return SDEI_SUCCESS;
 }
 
+static unsigned long event_reset(struct kvm_vcpu *vcpu, bool private)
+{
+	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
+	unsigned int num;
+
+	/*
+	 * Nothing to do if we're going to reset the shared events,
+	 * which are unsupported.
+	 */
+	if (!private)
+		return SDEI_SUCCESS;
+
+	for (num = 0; num < KVM_NR_SDEI_EVENTS; num++) {
+		clear_bit(num, &vsdei->registered);
+		clear_bit(num, &vsdei->enabled);
+	}
+
+	return SDEI_SUCCESS;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -229,6 +249,12 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_PE_UNMASK:
 		ret = pe_mask(vcpu, false);
 		break;
+	case SDEI_1_0_FN_SDEI_PRIVATE_RESET:
+		ret = event_reset(vcpu, true);
+		break;
+	case SDEI_1_0_FN_SDEI_SHARED_RESET:
+		ret = event_reset(vcpu, false);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

