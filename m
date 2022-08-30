Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14C55A719B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 01:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbiH3XSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 19:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiH3XRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 19:17:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA75FA0303
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902c40300b001743aafd6c6so8876141plk.20
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 16:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc;
        bh=Txu66imdTeO5r2h9d6P2aTekZZMC58Eb6KLriOaZUxo=;
        b=So6isXaeOVaF/OiT6A6g9HK+ruRAG/fmv/Ma9SAaVxSpg5r19JOL6yYvxiqhnF/2YC
         dAM7UVP+fVsPBChKNW/D/nd79xhFH0jayQZqecIQt9uFIulGV6BE54ICSgt5K51zU4Ef
         C4O8vQqTsWxCSM9XgfeqAwwtwvJfvfowFw8SDhmUizoVzZgy+DfWYl6bAxZ4SoZToGW2
         2WujM0f1aeC7geDAUVPyAmw/MZ3MQW+zpc/m+P1N3dmVRvQyntIa3+CiuQMZudFFL5uo
         QbYaoESg1ILQ1JJ75HD9+0xqRruEO642dZ/TK36yAYRVSWLKimkeb5rNCglypDOZdpCf
         qodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc;
        bh=Txu66imdTeO5r2h9d6P2aTekZZMC58Eb6KLriOaZUxo=;
        b=tdmqbT+A7TdvAmXTmHrb1c0m457yQUManSqGCL7kJt48dj4B7V84AfNOFwEoiQ5a8t
         VF0sJMsVmkhYSzzQiHOOAa4IPOMve/FnWFuzC0NcY6oxS1wQlLHhg7qIc2dmpyjt3c7+
         yLxpGAgJXh4aTy6rfixvwxqf40G9ENUchCUe4nKvzB01XDMfHaANYCZLOSsznfiTOYJS
         KXlWR7vtvL4wJ7+vDYVQMkwPcRC8XXc/LnxeEQQJznN5pW326oAzeaDPm8TptwNFFfH8
         cZ1/LDQlN8RQ2U1gUs3onMKUafesX9hKuwnr+eLJNUcLfxu9O1YgtAdXkFTvQ6uN9TWS
         gebg==
X-Gm-Message-State: ACgBeo1ajUZhgG811aQtvmRTsjUH0IUFWAr+lyR0+qRJs4n1No5YzyEl
        cdO0HsFEeTvf06ytXAqSts3LjdSxmZ0=
X-Google-Smtp-Source: AA6agR5xvUBS1Q2b8dkQcFIBXz3RZErpC9Pu2f5kPJAkwnjGez0h4Y9iYJwCmu6jY8jm3JnxAYtgQBCSub0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:c945:b0:16e:d24d:1b27 with SMTP id
 i5-20020a170902c94500b0016ed24d1b27mr23845113pla.51.1661901388338; Tue, 30
 Aug 2022 16:16:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 30 Aug 2022 23:15:54 +0000
In-Reply-To: <20220830231614.3580124-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220830231614.3580124-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220830231614.3580124-8-seanjc@google.com>
Subject: [PATCH v5 07/27] KVM: nVMX: Prioritize TSS T-flag #DBs over Monitor
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index b540c7bf4753..5298457b3a1f 100644
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
2.37.2.672.g94769d06f0-goog

