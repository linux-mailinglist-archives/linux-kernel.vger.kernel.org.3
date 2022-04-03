Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97CF14F0ADC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 17:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359327AbiDCPnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 11:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359358AbiDCPnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 11:43:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39FCF2DD5C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 08:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649000476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UtGCQ6T1u11qhK091mocG/kgchg6wglV6l9vGFS41E=;
        b=dzzw7Nk9Ns0rZr8Kv+RnLV2iE0LaJK061a+ndwzcMndFmE6rvwE8Gyrda13oC+jZQNPHAd
        +KBKtX/MELjy25KKHqhjbzInFNXKHFfiadeHHi18q/Nm2HfurhvSwxUs0Lfhd6WmUZ8d9f
        VvMHGO2v6agbnHhT1t48aZis6Owl4vk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-416-HCKXWHClNaywshvC35LKUA-1; Sun, 03 Apr 2022 11:41:15 -0400
X-MC-Unique: HCKXWHClNaywshvC35LKUA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C810101A52C;
        Sun,  3 Apr 2022 15:41:14 +0000 (UTC)
Received: from gshan.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E61A403172;
        Sun,  3 Apr 2022 15:41:08 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, eauger@redhat.com, oupton@google.com,
        Jonathan.Cameron@huawei.com, vkuznets@redhat.com, will@kernel.org,
        shannon.zhaosl@gmail.com, james.morse@arm.com,
        mark.rutland@arm.com, maz@kernel.org, pbonzini@redhat.com,
        shan.gavin@gmail.com
Subject: [PATCH v6 15/18] KVM: arm64: Support SDEI_FEATURES hypercall
Date:   Sun,  3 Apr 2022 23:39:08 +0800
Message-Id: <20220403153911.12332-16-gshan@redhat.com>
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

This supports SDEI_FEATURES hypercall. It's used by guest to
retrieve the supported features, which are number of slots for
the interrupt binding events and relative mode for the event
handler. Currently, none of them is supported.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kvm/sdei.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
index e1f6ab9800ee..ab0b7b5e3191 100644
--- a/arch/arm64/kvm/sdei.c
+++ b/arch/arm64/kvm/sdei.c
@@ -527,6 +527,23 @@ static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
 	return ret;
 }
 
+static unsigned long hypercall_features(struct kvm_vcpu *vcpu)
+{
+	unsigned long feature = smccc_get_arg(vcpu, 1);
+	unsigned long ret;
+
+	switch (feature) {
+	case 0: /* BIND_SLOTS */
+	case 1: /* RELATIVE_MODE */
+		ret = 0;
+		break;
+	default:
+		ret = SDEI_INVALID_PARAMETERS;
+	}
+
+	return ret;
+}
+
 int kvm_sdei_call(struct kvm_vcpu *vcpu)
 {
 	struct kvm_sdei_vcpu *vsdei = vcpu->arch.sdei;
@@ -590,6 +607,9 @@ int kvm_sdei_call(struct kvm_vcpu *vcpu)
 	case SDEI_1_0_FN_SDEI_SHARED_RESET:
 		ret = hypercall_reset(vcpu, false);
 		break;
+	case SDEI_1_1_FN_SDEI_FEATURES:
+		ret = hypercall_features(vcpu);
+		break;
 	default:
 		ret = SDEI_NOT_SUPPORTED;
 	}
-- 
2.23.0

