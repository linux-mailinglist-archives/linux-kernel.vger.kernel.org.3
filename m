Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19ABD57EAD7
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237040AbiGWAxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236995AbiGWAxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:53:04 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069A6C0B64
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:17 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q40-20020a17090a17ab00b001f2103a43d9so2670717pja.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=mcR+Y5Ms3FD3f/xG9LEGod80N5RagmS+RXoMsriitm0=;
        b=V+nmOzZuqsOlKd6plJHbruPMF+/9kPLRfbD63+P9Cw6xKImIo8kC5WrOvKdk5/CzLU
         800B/sNoDp5+I8UWqao4K5wAG2eBghyU+hBpPFcCL+CP8/+G0nDSVhGn2WgSWQfyWylA
         6NWkB2Cq5syMoNSsXoCDiSYLKnYjU4ljZ9BG0Q/i9IFRwwuoLtWTpmrq/KH1+hkYVRQe
         dSLxkYs1jyTkJkeYbbDqHev7TfAts5Ct+gGJEj8f2UbSuWhcO7H83ieleGjsb1xyapeT
         hD08Gr9paHlO9kJf+x2TdRkqJs+mjBQH+WyiQl2lfgu04ST0gAHPYCCdaMNVbTKL5BXL
         VcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=mcR+Y5Ms3FD3f/xG9LEGod80N5RagmS+RXoMsriitm0=;
        b=C2dsODKt3/5FwMkoLhAKtDzahl63NQ9o2oVXGxjDwq217gwkIgHrgnQUewGJEoKKQ4
         ygzrIjj27ynynCAjJ0zhmIv+4M7YGAacD3nWzxClZatSMU7kp0tL7tqGYDrUF6+PPhq3
         jrAybMR+i6YmSVcdbK5vAyoASpQ6fkFTAKx70X6rA1hcKvh+LzEsYqREHXe7+J36g/qQ
         ai+aVYf5KkIxKeR+SnXPf6p97Z05I+ibbp3/DV+bLOrE+g20eOzjhJJgPaO70xz8SAt2
         4QfZeqkk5kvWQlJDLnDvGTeUNGErs3K0WHt8ZOmGBbs+MtF1j7ciNNzfG2ZCutu4YZzw
         1zgQ==
X-Gm-Message-State: AJIora//S2mDAo4pI9aRcg3/yjN+KX+Q9EqyPyruzwFjEqdBHxSCBja/
        2QG+qTV2ct2Td3y5FXPf863MexxQNa8=
X-Google-Smtp-Source: AGRyM1vXVwTJjicio75jvInkCj/771zF90zgZIjhhu0yPsDC5mAnUe9nUC77Xd6SoVgnt31APPWz5bKHbb4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:ba11:b0:1f2:38ec:3be3 with SMTP id
 s17-20020a17090aba1100b001f238ec3be3mr2302715pjr.177.1658537524319; Fri, 22
 Jul 2022 17:52:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:27 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-15-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 14/24] KVM: x86: Use kvm_queue_exception_e() to queue #DF
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 027fc518ba75..041149c0cf02 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -663,25 +663,22 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
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
2.37.1.359.gd136c6c3e2-goog

