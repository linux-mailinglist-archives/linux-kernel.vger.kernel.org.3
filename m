Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A84D5908
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344028AbiCKDay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346168AbiCKD3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:29:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314FBF4602
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:30 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x6-20020a17090aa38600b001c227fbfbc5so1268717pjp.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/3hTzlaDbI+285CROy2A1iE61ckSvYZ31v9FVpbRb8s=;
        b=UX1w/P7jg1a798gyvWXu1wypx7wjM/pHwylJXYUX138rvUTE46OHEe6KKLLOy83Bi1
         IM0oPux+Lp3TbcuqMvJEZ3/pb77EFhen/M3xXOxjgRmTgJ9QcKNl3RNoWufP/tH9tAvG
         Dwl99UB0XD8Oo7KlvGMsmYJ8xNf3UGsO0bhsXzQkJ7w6IFAbLbvJ3ZmaQZ+DaT3qbn+C
         qt3Mhzh88XlbQL2fdRPv96/xDlcNc3XkUb8oBgzfREcXxcRry8GL0uinjqpchEMG0fva
         eOr6a1JabfQu05p6PpLiVxdYsAvpshzxeDB5AsPtFFVo5629JXMgCLTbQ7rXIHLQ62rx
         RUkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/3hTzlaDbI+285CROy2A1iE61ckSvYZ31v9FVpbRb8s=;
        b=XYvPJIXOU534MTFinHot7wSf9PiwpNpHCJRvyPCheoikn/VYVwBmghxpSMzsAt/uoz
         2zLvH/cB+MVkPMasfAG2aaC42Rrv37lgXXkBtXg2Ta+LKR8OGN4fswvWZTJBIhmjcK+D
         +jLVzT2LmJWA2W3S1lHd22/5JEhqACh8khhY4H/HwClbWPtKbpXsgpoN3xBPGsBXFCn/
         v4li6Xfs2R7S5Fek97LgsI42b04QTOFmfQTruQn90yIy/h/MLwdfXc5lo2n7neIIgdYm
         Pa8SBEb4LTrnMXa2gJjGKSM807Evs1btbc1DrLE0dayJ+KhABdyz1xYVajaPjU/XvVDt
         RK8A==
X-Gm-Message-State: AOAM532gcZSHJhB4HnPs7GhYk0q2qGyrjhxUBTDduI1vtaPtwwmLRCvU
        VPZi5bVx7/P3LZLpVhzFKuFqujnK/0g=
X-Google-Smtp-Source: ABdhPJxJslK22N6B7y/w6enIzRagBV9xKv6A0m5KOVOgB6/0UtNBTn43PhLt3jDYbUTJdLT8qSfQGDF41zw=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e84b:b0:151:ca71:7d3d with SMTP id
 t11-20020a170902e84b00b00151ca717d3dmr8295289plg.26.1646969309525; Thu, 10
 Mar 2022 19:28:29 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:55 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-16-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 15/21] KVM: x86: Use kvm_queue_exception_e() to queue #DF
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
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

Queue #DF by recursing on kvm_multiple_exception() by way of
kvm_queue_exception_e() instead of open coding the behavior.  This will
allow KVM to Just Work when a future commit moves exception interception
checks (for L2 => L1) into kvm_multiple_exception().

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 74843767383c..d6fbff896263 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -669,25 +669,22 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
 	}
 	class1 = exception_class(prev_nr);
 	class2 = exception_class(nr);
-	if ((class1 == EXCPT_CONTRIBUTORY && class2 == EXCPT_CONTRIBUTORY)
-		|| (class1 == EXCPT_PF && class2 != EXCPT_BENIGN)) {
+	if ((class1 == EXCPT_CONTRIBUTORY && class2 == EXCPT_CONTRIBUTORY) ||
+	    (class1 == EXCPT_PF && class2 != EXCPT_BENIGN)) {
 		/*
-		 * Generate double fault per SDM Table 5-5.  Set
-		 * exception.pending = true so that the double fault
-		 * can trigger a nested vmexit.
+		 * Synthesize #DF.  Clear the previously injected or pending
+		 * exception so as not to incorrectly trigger shutdown.
 		 */
-		vcpu->arch.exception.pending = true;
 		vcpu->arch.exception.injected = false;
-		vcpu->arch.exception.has_error_code = true;
-		vcpu->arch.exception.vector = DF_VECTOR;
-		vcpu->arch.exception.error_code = 0;
-		vcpu->arch.exception.has_payload = false;
-		vcpu->arch.exception.payload = 0;
-	} else
+		vcpu->arch.exception.pending = false;
+
+		kvm_queue_exception_e(vcpu, DF_VECTOR, 0);
+	} else {
 		/* replace previous exception with a new one in a hope
 		   that instruction re-execution will regenerate lost
 		   exception */
 		goto queue;
+	}
 }
 
 void kvm_queue_exception(struct kvm_vcpu *vcpu, unsigned nr)
-- 
2.35.1.723.g4982287a31-goog

