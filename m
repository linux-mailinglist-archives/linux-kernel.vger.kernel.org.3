Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76E857EAC2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 02:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbiGWAwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 20:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236451AbiGWAv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 20:51:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C63388757
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so4810824ybp.19
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 17:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=f8GyotJFmeLYyYzTha23JlR3kgjrkc9nFL5Ec/loSRI=;
        b=Yd9z2Jplm3eV1w/a/hrPMLm3C3a+cD40y+2Sqp92HUKFQ5tDi7wcfJ0oEG3kNjTee2
         dISrKizEMjEfO7imToA4mU64rfvbrl2Bd41hOdt1gbvB57hrIh+na7+ygq50w0i4RcTi
         ZhE9NZPn9fmZTkC2Gu0x0W3PIJIkYYKkkLTyYxMTRYPfT3abSSkQub1IZSfUNS4aVsXI
         csuU8+LP9AsfHYf0Rmb5fv4ddSidsfQXThB1rlciZgVtBh85gNLzDb2hgCKDftDPrDVV
         ia7GLx7WTs7lqYA9sLgwASYr5razZj/uyUqNwneMhjqVpTCz8KsWGSufx2gGXwvD8bNb
         U4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=f8GyotJFmeLYyYzTha23JlR3kgjrkc9nFL5Ec/loSRI=;
        b=O1RBb8Jqd5yph86zwMctUgWQVsKBpZfZSBT2BugFCo4mJfyqBwn/Rrd2QRcZOD5NKd
         kEMu2en9CCXn6j+QevJfAFoeIm+T17ZvwZhg8h/mUMcKNzEJ5w0O+wyIgxV8n7/9/Tv7
         YBlpVqLtjGuk/oK1A+xUOkPBIQCxzFL1TJiHUiRsXcYWpAmjDBItQjg+bn6n48IHUE8g
         zb8V5+Mq08XcaRy1noHYrwUMIUZsfSOemX4S1dtHAb4uyEg7GajhXtz2fcDwUA/QKuKm
         Xm/vFPkGkxPFdimwZXuqAjg8PbDJ/FpScZI0qOJqV5BoLd8iJVJR3LfwGPK/l5B9WoDY
         DJQw==
X-Gm-Message-State: AJIora9GScjNAQTjtwlHUwst0/afnTwqDMwrPT12KKiOfajUCn1YbT37
        y7H1GNmog7HS8OoYC9Y779o6qlJc0+Y=
X-Google-Smtp-Source: AGRyM1sgyhp9a5lQ6bjYiJsvHVkWKbsxLvnsPELm9w4w/UWzf+gSjkaZxI09MiazwcxB/ufnKJsqbLKLAAk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:a194:0:b0:31e:62c4:e710 with SMTP id
 y142-20020a81a194000000b0031e62c4e710mr2095659ywg.312.1658537510167; Fri, 22
 Jul 2022 17:51:50 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Sat, 23 Jul 2022 00:51:18 +0000
In-Reply-To: <20220723005137.1649592-1-seanjc@google.com>
Message-Id: <20220723005137.1649592-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220723005137.1649592-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4 05/24] KVM: nVMX: Prioritize TSS T-flag #DBs over Monitor
 Trap Flag
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

Service TSS T-flag #DBs prior to pending MTFs, as such #DBs are higher
priority than MTF.  KVM itself doesn't emulate TSS #DBs, and any such
exceptions injected from L1 will be handled by hardware (or morphed to
a fault-like exception if injection fails), but theoretically userspace
could pend a TSS T-flag #DB in conjunction with a pending MTF.

Note, there's no known use case this fixes, it's purely to be technically
correct with respect to Intel's SDM.

Cc: Oliver Upton <oupton@google.com>
Cc: Peter Shier <pshier@google.com>
Fixes: 5ef8acbdd687 ("KVM: nVMX: Emulate MTF when performing instruction emulation")
Signed-off-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/vmx/nested.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 456449778598..6b4368d96d9e 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3939,15 +3939,17 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
 	}
 
 	/*
-	 * Process any exceptions that are not debug traps before MTF.
+	 * Process exceptions that are higher priority than Monitor Trap Flag:
+	 * fault-like exceptions, TSS T flag #DB (not emulated by KVM, but
+	 * could theoretically come in from userspace), and ICEBP (INT1).
 	 *
 	 * Note that only a pending nested run can block a pending exception.
 	 * Otherwise an injected NMI/interrupt should either be
 	 * lost or delivered to the nested hypervisor in the IDT_VECTORING_INFO,
 	 * while delivering the pending exception.
 	 */
-
-	if (vcpu->arch.exception.pending && !vmx_get_pending_dbg_trap(vcpu)) {
+	if (vcpu->arch.exception.pending &&
+	    !(vmx_get_pending_dbg_trap(vcpu) & ~DR6_BT)) {
 		if (vmx->nested.nested_run_pending)
 			return -EBUSY;
 		if (!nested_vmx_check_exception(vcpu, &exit_qual))
-- 
2.37.1.359.gd136c6c3e2-goog

