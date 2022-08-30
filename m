Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57FF5A71B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbiH3XTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiH3XSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:18:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AD8A2DA1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3328a211611so188935867b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=nT/9uc77S8ExzdP0GdRk6lyVALBCe6fSmVkqSwOQXNM=;
        b=XoKFew2JGd5KCvlvH+4g/133oGG/6QUoMdKIxe00im2NLbBSuVDpGkWJRC+RJcQnUL
         A8nOT7BgGYh1cVo/ldPYIkQGSvyyEgCgZtzf9XtxgH6upHVMQ/EM6yUIn4BGMVjPTEai
         7flsFDcWWsMN3wyE1p94AwN/ACoUmW5toTfj76h/STU4jq1ujDox4OvuZJp3mrmY63RD
         7gIZcn7z0X/HkTaL/3e4OMCywsO+TZIe7djX4uIdTMka54m2ZQ4/QN5V5FaiRiaKhhB2
         Cb9yNaeAFVGOsmfjyx1J4/becTlZ7wA2cRET7+dVoS43jPCLKKedooSY0Y4u0m7+ETMN
         cWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=nT/9uc77S8ExzdP0GdRk6lyVALBCe6fSmVkqSwOQXNM=;
        b=gv5Tys42sOLxlCaADp+DKkIk+W1lKYhgDyI406LqfEgBb9pmQH2Ue5YQfV+nZhQM4T
         gM6uLudaueVKGIwSmqsdFbMYLXlSc5KLITs8Y1UzUEO9oUfwN2cURy+r/j1sK60cVrNC
         x2lXddKr3vxeTtumtQjhuwNoC0kNriEvC5MjeR1sXPFXvB4E9SKGNkWLXPBXCu/EDrW3
         b5kR4s8vgGfkW/cLqcFXfXhTyJD2x087UcsStqQfEZAN+EUqSANUd2cInH1Jfym6IDCk
         Hcgx4R9PuwOfbdYeHC+epSqkMnKRoxGJioNVJDWGh+6oN4D9tr9sy4J/kn/TtsLBNYzY
         op/g==
X-Gm-Message-State: ACgBeo17x6AKcwgqQX/JOOs+P8QR/L4lYqOL/ctTfVUhRYNl8X7YrlzC
        vCG4QTaJpD0sHnNDncZMieWEO2NJnIY=
X-Google-Smtp-Source: AA6agR77gN34mCj9Uhtb58dxv41yVm9aD+Pz4eIF+jNcpoQDR1cK7eBAdLL7t4wrCoYGVKN/aYVpiHd1oLk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e90e:0:b0:695:64cf:5d2 with SMTP id
 n14-20020a25e90e000000b0069564cf05d2mr13184768ybd.541.1661901404187; Tue, 30
 Aug 2022 16:16:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:16:03 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-17-seanjc@google.com>
Subject: [PATCH v5 16/27] KVM: x86: Use kvm_queue_exception_e() to queue #DF
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
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bed42a75b515..c19658b7be23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -667,25 +667,22 @@ static void kvm_multiple_exception(struct kvm_vcpu *vcpu,
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
2.37.2.672.g94769d06f0-goog

