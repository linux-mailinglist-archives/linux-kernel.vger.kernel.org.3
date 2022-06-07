Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167035422F9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388312AbiFHB1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578992AbiFGXjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:39:09 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDEE22E6A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:36:37 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d11-20020a170902cecb00b00163fe890197so10005215plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=NQ0NXcc6zaLq7ONEOxmfQD1Om9k/BwyLb/mU8W7ZfBE=;
        b=psYIhDQIbOYoDfMgxj9hZcW2N+nnDfFJ5muVwPxGWwXfML0dLWXF9sGEkHhJQoDmFP
         5ExBSyxrvpuj1yTHNxeYkv2QEs4voLF7o/tmPLCLxcKmQaXuzaPyFwQU4oJkpOsm2Zx2
         AP5IY8rEIYsZoLE7swfYED4wr9c1vD3MRfCrztDMxwFuUfnYkzPgMueQNGK1V6hXRONP
         4yvkXyQ6DFG21NGtPby+nm1UIQRl06vjw7Anv5TDAebli3SXZapowg2PuEzEveDd1L2d
         3U6N9oiHio93I0lk1n83VWY3SdKqQE60ZccbRD2cFT19l0E8NdLc3J9aZGLehAbMGHdK
         mY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=NQ0NXcc6zaLq7ONEOxmfQD1Om9k/BwyLb/mU8W7ZfBE=;
        b=Te7woG4+2NQFfUYllMR1nBUo1/K5jSrwIFse9zp8zGUS/pK4IJ2VZocek9QzkLvaCZ
         1pqD7SBF8+EoLaqXcPaYzipIeskzqT+74tBnETlI2S2T4gJPXK6wClV88celQCuqZAjq
         TZgZxSLi+MUP58aJHIR8R/br2mpc3L9JdilZv7TzFkvi1kw09pc/1auHrIRQLhdIzJwl
         M/+im6XVOnl9zqwPULrbP07yK3Cn0QaCtcn+J6vp4MU+Pa0fw8OlZFsZwsMV0fSIBkBe
         HlKpR59aUj/u/fdIOB2aCzCLzMS/vve76ISDsO5QiwgTtz3SgmEgxVlOPTB1B0peNhGX
         27Wg==
X-Gm-Message-State: AOAM533YKnibyoIaiuOZpfAkW0+TFL8JM1Yio/VmY2d+8jM6EFWklaK9
        l9UtMKw4yR1sq5ilPFSgRAP2EpX+VyA=
X-Google-Smtp-Source: ABdhPJwB35ykedAAuBKX8Jf0+rndwi9hRqmJsr0aoHx0x/f2vEZfKa4n3yLn1zl4KS3zxkYRBIpKAiXEMcg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a62:38d7:0:b0:51c:4c30:3aef with SMTP id
 f206-20020a6238d7000000b0051c4c303aefmr2369470pfa.5.1654637796967; Tue, 07
 Jun 2022 14:36:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue,  7 Jun 2022 21:36:00 +0000
In-Reply-To: <20220607213604.3346000-1-seanjc@google.com>
Message-Id: <20220607213604.3346000-12-seanjc@google.com>
Mime-Version: 1.0
References: <20220607213604.3346000-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v5 11/15] KVM: nVMX: Set UMIP bit CR4_FIXED1 MSR when
 emulating UMIP
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Li <ercli@ucdavis.edu>,
        David Matlack <dmatlack@google.com>,
        Oliver Upton <oupton@google.com>
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

Make UMIP an "allowed-1" bit CR4_FIXED1 MSR when KVM is emulating UMIP.
KVM emulates UMIP for both L1 and L2, and so should enumerate that L2 is
allowed to have CR4.UMIP=1.  Not setting the bit doesn't immediately
break nVMX, as KVM does set/clear the bit in CR4_FIXED1 in response to a
guest CPUID update, i.e. KVM will correctly (dis)allow nested VM-Entry
based on whether or not UMIP is exposed to L1.

That said, KVM should enumerate the bit as being allowed from time zero,
e.g. userspace will see the wrong value if the MSR is read before CPUID
is written.  And a future patch will quirk KVM's behavior of stuffing
CR4_FIXED1 in response to guest CPUID changes, as CR4_FIXED1 is not
strictly required to match the CPUID model exposed to L1.

Fixes: 0367f205a3b7 ("KVM: vmx: add support for emulating UMIP")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index dc2f9b06b99a..5533c2474128 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -6781,6 +6781,9 @@ void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, u32 ept_caps)
 	rdmsrl(MSR_IA32_VMX_CR0_FIXED1, msrs->cr0_fixed1);
 	rdmsrl(MSR_IA32_VMX_CR4_FIXED1, msrs->cr4_fixed1);
 
+	if (vmx_umip_emulated())
+		msrs->cr4_fixed1 |= X86_CR4_UMIP;
+
 	msrs->vmcs_enum = nested_vmx_calc_vmcs_enum_msr();
 }
 
-- 
2.36.1.255.ge46751e96f-goog

