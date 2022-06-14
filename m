Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F6254BC28
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 22:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357191AbiFNUsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 16:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237102AbiFNUrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 16:47:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB6B1F2F0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:47:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p2-20020a170902e74200b00164081f682cso5370172plf.16
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 13:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fEMqLuFAtgH8w8vKOovMX6x1myh1UNWmWv8ofboTXMI=;
        b=WXTfP/SKtgWZirrs3CPPTeFvNldLG4Xzf4GtcVhc5x+dSoCGpXo5jMDtoogLIQbG8N
         JfyEq/EkPaSHDUlc7qMDG6r4Fqdj9y1UjpVJvGVkENVACe2G9P83cudNF+u4rfg/ofWf
         q0/uh+sAPMRAnJDN98IW8ODT8fQZsP7+5rtzLmCkIAiGOMWdBJmQoYhwG+6FD9b//tM8
         F0Dh2sfmmA5i1DTzzBQbP4LJ58KeRAKJU42a8K5S+JUN4nN9k55Fis4igMclxLdp/GtH
         kEGwTxI9nZFP+6ZXC0LPZNflAaPQmKfVtRzqxOhU9PO5jrSDejRUS1scwA/9b2+LwEH8
         3OVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fEMqLuFAtgH8w8vKOovMX6x1myh1UNWmWv8ofboTXMI=;
        b=wLb0riLsgyo0X9C50S9HrszVM345aftzXGJCAlDtOGd9SQW0QzdCtqkQ5tDp6ZuC6b
         BRlLbtillsWF3MAHIUlCWGMlnU7WN3OsMVXxcoSdj7/BPXq3IiOzVCqWe/zB4gkWZnTg
         EkLYylTePn8S5sfGxFYDvwhNmWtnMN+hWDPBAM8Vm3H9ifU7DwXLwIK5a+sQS2Atlols
         HAQBBtNFiQln5xQ5YTs2ZtSdqC72e8aFDc74FhXsOMWo/yy4GE3m0LRATu0AVhiCBFCy
         +xB9hrxt5aSG7N4gUkbXzez5oJzIHm+TUWRd1lik8F6wTQ+P4J1cEaouGpYqSHH4KVJf
         2UoA==
X-Gm-Message-State: AOAM533mGjygFoLNeKhFly/CnjjpkM52sfo3HBaIKliw1L/YKuh++QuZ
        84qLKx9bkvFVC9UeqsIVMawyvxkoChc=
X-Google-Smtp-Source: ABdhPJzGOmR6ilus/G3tluMOKVeV6aCrX+WqWy47QWXnKNVICbB+f93eIh24+Wx28XBPtNWmm1PUEObrR+Q=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1946:b0:4fe:309f:d612 with SMTP id
 s6-20020a056a00194600b004fe309fd612mr6481855pfk.10.1655239664827; Tue, 14 Jun
 2022 13:47:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 20:47:14 +0000
In-Reply-To: <20220614204730.3359543-1-seanjc@google.com>
Message-Id: <20220614204730.3359543-6-seanjc@google.com>
Mime-Version: 1.0
References: <20220614204730.3359543-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v2 05/21] KVM: nVMX: Prioritize TSS T-flag #DBs over Monitor
 Trap Flag
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
---
 arch/x86/kvm/vmx/nested.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 61bc80fc4cfa..e794791a6bdd 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3943,15 +3943,17 @@ static int vmx_check_nested_events(struct kvm_vcpu *vcpu)
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
2.36.1.476.g0c4daa206d-goog

