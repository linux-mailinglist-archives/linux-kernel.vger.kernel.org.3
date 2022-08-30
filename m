Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2AD5A71BA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbiH3XT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiH3XSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:18:44 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D951FA3D11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:59 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id s8-20020a170902ea0800b00172e456031eso8731743plg.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=tYq9YcAwjLBbsPBl3g4Rt11xEJcHY89Bgh5mNj3EW+c=;
        b=F1HnI1LbZZGh+1iwnFz0bwwP/9HlRp8aSE9s5qTo2KlgDmgpTWstPBqoW7+Ojn0dg1
         xdZRTxVA8HvFy8Uqhzo+8R4I3wtHvZHRAPbOryN1nprBqtdnjiSzeR5Rq6Wp4GpC3XvG
         Y9wHkpv8IftQG6UPjRvd3Gd+XcdgjL81dsTkaLZMD2LS8/9Ju/TQv0B62AwUf8hYRYgA
         D4fcqkjRBiP7JU2zL9coQ1FlF+2fFjlBAHl9gNy3URmlkWOO0lqqtsrQ2qemAbho7xQF
         PFlkhVX+Q/WTvnJavNm0P8W7lwYFk7CcNXK6N2KZU0KzIoWgu8djZ6SHU77Kkz3tAh2R
         1wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=tYq9YcAwjLBbsPBl3g4Rt11xEJcHY89Bgh5mNj3EW+c=;
        b=yn08GeR6jbhQ7lA8XwwYxVClGO+1kG2csx/LdxLiPi5pGUl2b1czMP/cc1CzTGxsdm
         3lmZbzm8jnpInnh/juajK7i/t6IY5V7EOr7SfzRaJxqsrkJC/irCI987F6c58t4HDoFx
         Q9whumivvivDyK2ohQW3mAqsMZxk52Kf8fMJktTsOoXS6itcSU1LAa2mLvrspyPmIhvo
         nCswPbH6vbxdVXhw1SC6A/d3eBWL21MmQnY5CM9Cgem3QNjHJxUI4BceSi6DL9jS/h+9
         m3Fui6m5xum1uyan0c5xq1SiS9Sort5FK2xf7aDn2kECUT8AL+t4AsABPXKcsntlp/Bi
         pI0g==
X-Gm-Message-State: ACgBeo0uFEbKei/LPJy5dr/Pkwoeflt+3zHqi81osCqenWo6lxMbZUPf
        EU7tA+Abz4mKfsND0gtaJRuRV6eKO+E=
X-Google-Smtp-Source: AA6agR6RHeCjSt+01YIz5kfeURH9q9hI3n0T4/icOqjmk3Zb8GUCUC+P264qqPI2xAk/yG/uDuMJXZaXR1M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4b0c:b0:1f4:ffac:699a with SMTP id
 lx12-20020a17090b4b0c00b001f4ffac699amr333294pjb.145.1661901415663; Tue, 30
 Aug 2022 16:16:55 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:16:10 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-24-seanjc@google.com>
Subject: [PATCH v5 23/27] KVM: VMX: Update MTF and ICEBP comments to document
 KVM's subtle behavior
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

Document the oddities of ICEBP interception (trap-like #DB is intercepted
as a fault-like exception), and how using VMX's inner "skip" helper
deliberately bypasses the pending MTF and single-step #DB logic.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c6fc37415fc6..8875d9c448c2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1652,9 +1652,13 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 
 	/*
 	 * Per the SDM, MTF takes priority over debug-trap exceptions besides
-	 * T-bit traps. As instruction emulation is completed (i.e. at the
-	 * instruction boundary), any #DB exception pending delivery must be a
-	 * debug-trap. Record the pending MTF state to be delivered in
+	 * TSS T-bit traps and ICEBP (INT1).  KVM doesn't emulate T-bit traps
+	 * or ICEBP (in the emulator proper), and skipping of ICEBP after an
+	 * intercepted #DB deliberately avoids single-step #DB and MTF updates
+	 * as ICEBP is higher priority than both.  As instruction emulation is
+	 * completed at this point (i.e. KVM is at the instruction boundary),
+	 * any #DB exception pending delivery must be a debug-trap of lower
+	 * priority than MTF.  Record the pending MTF state to be delivered in
 	 * vmx_check_nested_events().
 	 */
 	if (nested_cpu_has_mtf(vmcs12) &&
@@ -5165,8 +5169,10 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			 * instruction.  ICEBP generates a trap-like #DB, but
 			 * despite its interception control being tied to #DB,
 			 * is an instruction intercept, i.e. the VM-Exit occurs
-			 * on the ICEBP itself.  Note, skipping ICEBP also
-			 * clears STI and MOVSS blocking.
+			 * on the ICEBP itself.  Use the inner "skip" helper to
+			 * avoid single-step #DB and MTF updates, as ICEBP is
+			 * higher priority.  Note, skipping ICEBP still clears
+			 * STI and MOVSS blocking.
 			 *
 			 * For all other #DBs, set vmcs.PENDING_DBG_EXCEPTIONS.BS
 			 * if single-step is enabled in RFLAGS and STI or MOVSS
-- 
2.37.2.672.g94769d06f0-goog

