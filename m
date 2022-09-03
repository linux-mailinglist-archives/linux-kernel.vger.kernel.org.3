Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00F35ABBA0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbiICAYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbiICAXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:23:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF87E10F94D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:23:34 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f3-20020a056902038300b00696588a0e87so2790235ybs.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=mbHk1vkw63VQJwpK5v7OYSHF5DuBwhkzqDp695B1D9E=;
        b=Am/ejqk+FXEoTdqA6s2ljphu1EM0595EUQYpOwC6lvm+KgrWBOIESYOdvlI13rVCPZ
         Vyi+6UUz2mfrA2rVOJSNVOKI3qA+J8gMPcEaeBitIxso8rJXNGznyswNq1LAm/wsV10n
         MSKiH3Q0nAksWQ2VqG2wE58WzWg88snpUMaDHItO4Egu8fVBUhx5nNuxWMUliI6+jOiI
         MBPOk1DctspVhiTN9Nbz9xYS/nO7y+mw9NG6cE/zu2LF4j0nWjFPuKm29jlhEKJqdkqo
         qAORYwnGOGgK7alkjsAgIaJ28v1W1M0g1xa6oVtijvyRmMWxTm3jxfdwsyPJZHw7eyP9
         BIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=mbHk1vkw63VQJwpK5v7OYSHF5DuBwhkzqDp695B1D9E=;
        b=aRoX/PZY97FTHmGsP1PWLBeUUo23N7N7gYVkZ9RE8VBIaorHXexJ41cea07NybS9Wj
         ZgMVrB44rAgr9VLeLdNnAWfjcFTCTDIyE+MtZY7E1h+/Zy40b4CL6boRAcbIwD75geRD
         q5GX6tc/RoJri0TMSwixn+35JmkHYiBA7RaSWI5GYuPqBRJbLqFPRz2XgYnEmAa067bF
         shuyyYIoQ6jZrn07cODbxsk1qvoGQNspvMqJQKQLWhQL3E5cym+5mOg49K1IKREePJn5
         grqpYue0kbm2T//b+VqPHSSJkdtkjyMil90wGSWkLeZitaWdH0VSAZvCss4iW+EHxO4l
         jcCQ==
X-Gm-Message-State: ACgBeo18m/1ssYU804y9CBlwI28zPOozfa8g8G0uBTbZum+Dy8m2i6JE
        eloQTX+9h5MYRPQjzaLnOt8mcuqbhtw=
X-Google-Smtp-Source: AA6agR78lhCJtcYdGkURpNKpNyVQm/bS5YisWK7p8gjPFbOehg4PIXtAlB4cJGGV/ylcAYQsbRZCRdb2N2E=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a5b:7c6:0:b0:6a7:509e:f13e with SMTP id
 t6-20020a5b07c6000000b006a7509ef13emr1382020ybq.302.1662164613075; Fri, 02
 Sep 2022 17:23:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Sep 2022 00:22:51 +0000
In-Reply-To: <20220903002254.2411750-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220903002254.2411750-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903002254.2411750-21-seanjc@google.com>
Subject: [PATCH v2 20/23] KVM: SVM: Require logical ID to be power-of-2 for
 AVIC entry
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Li RongQing <lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not modify AVIC's logical ID table if the logical ID portion of the
LDR is not a power-of-2, i.e. if the LDR has multiple bits set.  Taking
only the first bit means that KVM will fail to match MDAs that intersect
with "higher" bits in the "ID"

The "ID" acts as a bitmap, but is referred to as an ID because theres an
implicit, unenforced "requirement" that software only set one bit.  This
edge case is arguably out-of-spec behavior, but KVM cleanly handles it
in all other cases, e.g. the optimized logical map (and AVIC!) is also
disabled in this scenario.

Refactor the code to consolidate the checks, and so that the code looks
more like avic_kick_target_vcpus_fast().

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 894d0afd761b..e34b9baa9ee0 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -540,26 +540,26 @@ unsigned long avic_vcpu_get_apicv_inhibit_reasons(struct kvm_vcpu *vcpu)
 static u32 *avic_get_logical_id_entry(struct kvm_vcpu *vcpu, u32 ldr, bool flat)
 {
 	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
-	int index;
 	u32 *logical_apic_id_table;
-	int dlid = GET_APIC_LOGICAL_ID(ldr);
+	u32 cluster, index;
 
-	if (!dlid)
-		return NULL;
+	ldr = GET_APIC_LOGICAL_ID(ldr);
 
-	if (flat) { /* flat */
-		index = ffs(dlid) - 1;
-		if (index > 7)
+	if (flat) {
+		cluster = 0;
+	} else {
+		cluster = (ldr >> 4) << 2;
+		if (cluster >= 0xf)
 			return NULL;
-	} else { /* cluster */
-		int cluster = (dlid & 0xf0) >> 4;
-		int apic = ffs(dlid & 0x0f) - 1;
-
-		if ((apic < 0) || (apic > 7) ||
-		    (cluster >= 0xf))
-			return NULL;
-		index = (cluster << 2) + apic;
+		ldr &= 0xf;
 	}
+	if (!ldr || !is_power_of_2(ldr))
+		return NULL;
+
+	index = __ffs(ldr);
+	if (WARN_ON_ONCE(index > 7))
+		return NULL;
+	index += (cluster << 2);
 
 	logical_apic_id_table = (u32 *) page_address(kvm_svm->avic_logical_id_table_page);
 
-- 
2.37.2.789.g6183377224-goog

