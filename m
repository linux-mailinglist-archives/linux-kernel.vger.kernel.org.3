Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6CE5ABBC6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 02:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiICAYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 20:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbiICAXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 20:23:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF73107C4D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 17:23:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k126-20020a253d84000000b0068bb342010dso2791035yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=hPKVqX/qKnbg4wtZZoqH1v9WwL48+nuyy8M1K1yFn+Q=;
        b=NCUtkesuJSiUM6spxe/b4OJyxwM4vl24hU8ZXa6374IknbrY5QqWmqKMebFz1qDW96
         2n9Gepnfn4gmaDx383mdo1EsfgdC22ScVDQZJEvcGVyvbBDYhc0s1Z3YOVR+gjhh1Loo
         +sX/Ggp2y3ceBJIVtzuZYvEiRtvPLXUOgirVn4+/IFDCHZ6UlLd0QXF3AWoCUnXY8qNx
         2vQXT+gyc/3XYYo14X9e8v+QEPdZRqM3ED89N68rdRs2gySaYeiS0/Tq05DkE5b4jBve
         VdGk5JR8FwmLqV18faUMvvbC/JIAhIyub67JqnML0SqMIA2F7cx8plclbpFUgcAhOhCh
         22kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=hPKVqX/qKnbg4wtZZoqH1v9WwL48+nuyy8M1K1yFn+Q=;
        b=zBTnHaEGhkiHTzsrqSpQQw0MvJN3dF7HkC7sDO/JiXkxfNrIaIqWduR7SiJF7ysRBQ
         MWPW4U1n3WDlXvLcY1mhjEGuliQeUx8MECQPrrrhxQYL6bYwjEfOdwVgCCfbnO3B8su3
         OyrKbIta8sELZbnc5fgz4bVeWpPqnME/SFL6Rmckb6GpqoEtfllxkAq0zK3Sjy80Uwh+
         9KYm3xGq97UIY9hQ9oNVcYmyjkj3LvwoF5YDOTrAPzd4PVuMn3kQt92rX8hY/zMR7toK
         1TJiGUpxDqGjvQCncV7W1dP3P9+RC6sS4d4Hdh7V1X0Wf3iLjdcMqVJ2YChx7Bn5rw5H
         D0PA==
X-Gm-Message-State: ACgBeo2p31gm0jo4ornY3QLLje2qcK1kdkRRPD0xkNDh8PeSlaBH3iiH
        gPG6+xpD5dNIQqmhABNq4K2VrEE9rT8=
X-Google-Smtp-Source: AA6agR4AaMlxF/lgiWVv9UUSOZdreD17ciJY/4ExZuNkD+3dtrVHtCNRS9VPhDGPrWRp8mglAoCyQWRhppU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:8502:0:b0:340:a7fc:ddb2 with SMTP id
 v2-20020a818502000000b00340a7fcddb2mr31888545ywf.378.1662164608243; Fri, 02
 Sep 2022 17:23:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat,  3 Sep 2022 00:22:48 +0000
In-Reply-To: <20220903002254.2411750-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220903002254.2411750-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220903002254.2411750-18-seanjc@google.com>
Subject: [PATCH v2 17/23] KVM: SVM: Inhibit AVIC if vCPUs are aliased in
 logical mode
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inhibit SVM's AVIC if multiple vCPUs are aliased to the same logical ID.
Architecturally, all CPUs whose logical ID matches the MDA are supposed
to receive the interrupt; overwriting existing entries in AVIC's
logical=>physical map can result in missed IPIs.

Fixes: 18f40c53e10f ("svm: Add VMEXIT handlers for AVIC")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h | 6 ++++++
 arch/x86/kvm/lapic.c            | 5 +++++
 arch/x86/kvm/svm/avic.c         | 3 ++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 13dadc96d9ac..042dcdf987d2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1144,6 +1144,12 @@ enum kvm_apicv_inhibit {
 	 * inhibits, this is sticky for simplicity.
 	 */
 	APICV_INHIBIT_REASON_X2APIC,
+
+	/*
+	 * AVIC is disabled because not all vCPUs with a valid LDR have a 1:1
+	 * mapping between logical ID and vCPU.
+	 */
+	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
 };
 
 struct kvm_arch {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 407e933eb073..4cebbdd3431b 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -364,6 +364,11 @@ void kvm_recalculate_apic_map(struct kvm *kvm)
 		cluster[ldr] = apic;
 	}
 out:
+	if (!new || new->logical_mode == KVM_APIC_MODE_MAP_DISABLED)
+		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
+	else
+		kvm_clear_apicv_inhibit(kvm, APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
+
 	old = rcu_dereference_protected(kvm->arch.apic_map,
 			lockdep_is_held(&kvm->arch.apic_map_lock));
 	rcu_assign_pointer(kvm->arch.apic_map, new);
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 3400046ad0b4..efb0632d7457 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -994,7 +994,8 @@ bool avic_check_apicv_inhibit_reasons(enum kvm_apicv_inhibit reason)
 			  BIT(APICV_INHIBIT_REASON_SEV)      |
 			  BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |
 			  BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |
-			  BIT(APICV_INHIBIT_REASON_X2APIC);
+			  BIT(APICV_INHIBIT_REASON_X2APIC) |
+			  BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED);
 
 	return supported & BIT(reason);
 }
-- 
2.37.2.789.g6183377224-goog

