Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7794F4D590F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346133AbiCKDar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346137AbiCKDaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:30:03 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF84F65C4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:37 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id p8-20020a17090a74c800b001bf257861efso7072786pjl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 19:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/e3NuCK6DEBMSiOBllCLklyOmWNes/4L3RuR/tOp3B8=;
        b=XOLboWLfFXbX2EXQeMjKwLV6hLREdiguZxYDnuFwBuG0g6/gIna0YR6QYqHT4p1+Ai
         iuUn2KTOej2omvllKM73JZYbjdxE9EH2tCjvi9lMJi4tpV79z7foRGjphhTiEluZfi32
         v7zz4eqgOYJ6sYADUd7RxRMgZDcQveHCFUYvcM667PaA6vbJDeify+PRBuO2MYkw3A9/
         EXxs4MwG7h/dawghwislfrsuM2lVM/v/qYmsDiB2dm2BMQ/HkDN7Qk/E+fpqYzqWI2er
         cbNwr9ZB7LEzUgD3U1/FlnhvlNTrPWhgmTv2u3Fqr82M/xVRU6OPPp8OsAXk7bNyYnAp
         osIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/e3NuCK6DEBMSiOBllCLklyOmWNes/4L3RuR/tOp3B8=;
        b=p/o3Wq8/gDZkzpuYCKMowSvOP6xsUqeN4RzIXMBoKvMv+nQooTFP7PqTBSHb286oag
         HBSvN/fur9pvuIScPWuF0MyLjOJ0tLS1E0/tHkinGN6D4Tb8YPqlgUE8b4Aea7vYqvM1
         S+AiweqP6s0Nlor2Q5neSaEE5TrHQJJenJPVp+Qh5LmirBuHtwDZFoNuAUrBtS8DWjWj
         hAq1blKQ5bYVC+rot/VuqHgotHQ7IRhpp0D1gZsJunNrwKnXBiaFuQOvqxW8V5QC5K76
         LL9DpKvNXvxZ2ugQnQ4N+OayGoNf0hCbRNnrwxxqhY+el7CrFERIUv+CvG6ESDYySW7m
         iZxg==
X-Gm-Message-State: AOAM531KUPVLbLivjHru3r8r1tWEtemMQEfxNRVH9lFl5JDykl9THyAj
        RR1P9yPO99kEr+T8HAjfwR+2lB9fJfo=
X-Google-Smtp-Source: ABdhPJzFYOk3S8UZ5kwOhBOm3APg84bUmiikFn1or8h3TTrOWPVhXJfsCuqcMNAwQ5xgMZoKJf9vC65jKlg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4d81:b0:1bf:8ce4:4f51 with SMTP id
 oj1-20020a17090b4d8100b001bf8ce44f51mr404271pjb.0.1646969316456; Thu, 10 Mar
 2022 19:28:36 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 11 Mar 2022 03:27:59 +0000
In-Reply-To: <20220311032801.3467418-1-seanjc@google.com>
Message-Id: <20220311032801.3467418-20-seanjc@google.com>
Mime-Version: 1.0
References: <20220311032801.3467418-1-seanjc@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 19/21] KVM: VMX: Update MTF and ICEBP comments to document
 KVM's subtle behavior
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
        autolearn=ham autolearn_force=no version=3.4.6
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
---
 arch/x86/kvm/vmx/vmx.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 0420bc6d418a..ae88d42289ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1570,9 +1570,13 @@ static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
 
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
@@ -4924,8 +4928,10 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
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
2.35.1.723.g4982287a31-goog

