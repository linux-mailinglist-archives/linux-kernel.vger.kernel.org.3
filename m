Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66FC54BD32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 00:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358438AbiFNV7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358019AbiFNV6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 17:58:42 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234A1D322
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:41 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id b6-20020a252e46000000b0065d5168f3f0so8597770ybn.21
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=hM7xMbhXzzpQsznI3mGO8g+Dd+xj8PMNtipqtZvGG6k=;
        b=GuwmpLX88ftCnnpvqBc0WWzPL0wSNukaXGYAF8kRU3fV4GL4+B9Elr4s4+wWKQ3/Rz
         xg+LLlOREPuRcRxHZKOFIBVH6tpVgBcu+qg1SyPbYUuTj2LeHp4CzOFvYXE9NL+dQt1o
         +Vw0KhKxEtxeoXYu9Sj5Zl0XeKb8VflPBYqi0tGcGGuDmaOIEC/hxaGQZMlFoiLPgt48
         m0Gk4uwi/E2c2iCDlKMiCd0GOlJfPgP6eKlWtS1GaMP4EVNyXrivSMOwwTyNIvKB+PBU
         uf651/XmhZiMVcMv1l9rlJ/4l5c6D+8s/y89roi6/XOnE9ZysvYaodORfCg8EVWtW3J0
         zs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=hM7xMbhXzzpQsznI3mGO8g+Dd+xj8PMNtipqtZvGG6k=;
        b=k/0phgAMahsIQWJC/tjdHHu+JsSsxQ0SxvfBUemORZnTLyxcjKpQtU1WV+QuojzboU
         okx+93OYPwkOpWPknU8QP7NAhg2yRVZhzP1rejxwhxjZz8kH3Ac4hxyi+Ur0fVR4AaGB
         CA24ND8w48fTFEY6f1zMW1a907AfVXAZPWyX3CbNAoSHPhKtlk9auPgTZyllRCZ9l06n
         iWW0lk528vgRhBydH0hoaLLpeHTQZayltBkq+/4YwEEmZYc38fLroTmHT1J1PQ1XAJVS
         tMskrA/Gat1iyaUg8JPQTMcglkngNacQbtj7znPS0wGDoMTznppK6TPdE0CN0Xkwy30U
         iNUQ==
X-Gm-Message-State: AJIora86JFEPfPYJTd0jPdg+h7oZuguH7AcTfkXjRACLw6Xaf5OADS9L
        r1601RPPwh3P9tsiTN37qsktHgnkkZ8=
X-Google-Smtp-Source: AGRyM1tLv+/JKHGTDIKQSxOo/noztvW59rm5koNkZaEIoKlUtzDtwmNubj8LmcaWwHqarnkYTx9vUqSqWNs=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a25:c544:0:b0:663:896f:2236 with SMTP id
 v65-20020a25c544000000b00663896f2236mr6636975ybe.234.1655243921135; Tue, 14
 Jun 2022 14:58:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 14 Jun 2022 21:58:30 +0000
In-Reply-To: <20220614215831.3762138-1-seanjc@google.com>
Message-Id: <20220614215831.3762138-5-seanjc@google.com>
Mime-Version: 1.0
References: <20220614215831.3762138-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH 4/5] KVM: nVMX: Save BNDCFGS to vmcs12 iff relevant controls
 are exposed to L1
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lei Wang <lei4.wang@intel.com>
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

Save BNDCFGS to vmcs12 (from vmcs02) if and only if at least of one of
the load-on-entry or clear-on-exit fields for BNDCFGS is enumerated as an
allowed-1 bit in vmcs12.  Skipping the field avoids an unnecessary VMREAD
when MPX is supported but not exposed to L1.

Per Intel's SDM:

  If the processor supports either the 1-setting of the "load IA32_BNDCFGS"
  VM-entry control or that of the "clear IA32_BNDCFGS" VM-exit control, the
  contents of the IA32_BNDCFGS MSR are saved into the corresponding field.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 38015f4ecc54..496981b86f94 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -4104,7 +4104,8 @@ static void sync_vmcs02_to_vmcs12_rare(struct kvm_vcpu *vcpu,
 	vmcs12->guest_idtr_base = vmcs_readl(GUEST_IDTR_BASE);
 	vmcs12->guest_pending_dbg_exceptions =
 		vmcs_readl(GUEST_PENDING_DBG_EXCEPTIONS);
-	if (kvm_mpx_supported())
+	if ((vmx->nested.msrs.entry_ctls_high & VM_ENTRY_LOAD_BNDCFGS) ||
+	    (vmx->nested.msrs.exit_ctls_high & VM_EXIT_CLEAR_BNDCFGS))
 		vmcs12->guest_bndcfgs = vmcs_read64(GUEST_BNDCFGS);
 
 	vmx->nested.need_sync_vmcs02_to_vmcs12_rare = false;
-- 
2.36.1.476.g0c4daa206d-goog

