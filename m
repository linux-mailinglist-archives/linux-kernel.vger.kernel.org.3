Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B7576875
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiGOUo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbiGOUn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:43:28 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC6489EB6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:09 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id c18-20020a17090a8d1200b001ef85196fb4so5767319pjo.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=P6tI16SXPNvPnV6UTEfjFyYjUMKHNQVz4CHraJNxjTY=;
        b=brWIxis/fDIRLiHo0SCGIpS9ztRXocYOEOWzI0CVob5de6flptcy2Lw5Um5YDnrA8w
         2jShIbJN3FAd7L+tBR0mTMo3QPbPhzwDa0/jvb5OW3gblag/y4KdUU3vhrCC2wUq6B7e
         eODX1sufLGTS5PAuvW3j6tCx1+u3r2dc512QCDfNBQfEz7LW2fsh7TF0B7i1oqTc2mtP
         xkGqqO24LE3Gv0/Vm2x7zzYZT2JiQhMtujlSANer1gl7wbUm8nhHiTmWrt9bC77Rk2QC
         Xvfwv+aOhAn+nn5roMOsGifqWV7z3ZZiJ4Y8bryJGtWSsHqWAlBXLs4xmHcPLEm2mXcd
         i64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=P6tI16SXPNvPnV6UTEfjFyYjUMKHNQVz4CHraJNxjTY=;
        b=sMZaaEED50o5/k/PYlv+ERIBp7wHGtzgt8fJOxdPN39/2TXccVoVgzeR6CNDrsI4Qy
         +KDbDcLNMy6Km4pcq6bD+J4oo6ku8ewkqvE6/UlYTiii6qZj7wuLr+rzqziAOzXS8k0q
         bFUSKpINw6tttpqiO8B48rlXWeh/gaeEkXOCRJjlRg6WEH2c884Lxpptm7OmipW4N7a4
         vjaXVkelEabMmcKBqEJQ2SIIoHc8wNcghUsKB/G24Gzzz69Spapy3WHzLDu4Y+HO8pGt
         nydiNmQ1WSvJTFKHjdukUKoPvgIE3/d5bQP/XrRmJkjSt2t3fbSRZ1fgEeyJAhKqpl4C
         qaNw==
X-Gm-Message-State: AJIora8pHbdI9J4bbMpzBMtNR7kE2/HWmlL9fnhWP4PfuFZEOnplLIP7
        rjw68LbkAeDrjRqZowNWknmfrT5e7Io=
X-Google-Smtp-Source: AGRyM1spVEmzN9nWfnBden39YaiLALqJ1SqoWhmO7jc9w7g9/dcHjKjbMEIb2Mkz/gPxAnYEnFj1atXTAy8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:ccc4:b0:156:5d37:b42f with SMTP id
 z4-20020a170902ccc400b001565d37b42fmr15286959ple.157.1657917777879; Fri, 15
 Jul 2022 13:42:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 15 Jul 2022 20:42:16 +0000
In-Reply-To: <20220715204226.3655170-1-seanjc@google.com>
Message-Id: <20220715204226.3655170-15-seanjc@google.com>
Mime-Version: 1.0
References: <20220715204226.3655170-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2 14/24] KVM: x86: Use kvm_queue_exception_e() to queue #DF
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
index c4f758edf353..5aaa1d8de0b3 100644
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
2.37.0.170.g444d1eabd0-goog

