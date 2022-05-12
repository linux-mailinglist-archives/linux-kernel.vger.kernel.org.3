Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEDB45257C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 00:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359187AbiELW1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 18:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359165AbiELW1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 18:27:25 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B867369727
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:27:24 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m6-20020a17090a730600b001d9041534e4so3390772pjk.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 15:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=y6gb0U2+lLyl/JLfdo770ZdpJj+aiCLx3/RH8sebC6g=;
        b=kEP9p9p6ty8/Cn8cm6dGGrIzXSWlTeD922G12T3rUIRfkqyIxLiFDIdV6tNBMqYigy
         9ouHWupdaewZjaLRmHYZ/JL4yB/ZAV7O17Z0fwvGj2/iIt+gRZvfAaRfkSUACbXVm29k
         lgjMnz8qoEKLSuKPDHiHfWHk+dnEbQLea8ksKSyZW4K0tocXBIh9PsAk3+4m0AMkKjQE
         tpLyygojrv2nLbMp4P4mahrE/sVfFdu+EaCt+/4VO2Ni3+WkuVrweTmq8GhcAansyS1I
         eByUUhClwyruTFsBBVTnF24SrSjgX8S4AAer3b+8hAZf/xzxFRMqwMnVFpYYGpGfilNz
         82PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=y6gb0U2+lLyl/JLfdo770ZdpJj+aiCLx3/RH8sebC6g=;
        b=Zh6yAWRk2IYiW2mKuKJ/FR6tzbRw5g8vWFXn6uYxd/xCj0knqXl3mdhgmDTr+eCP/D
         /AhY/Y36l7owJzb7jj01qiZIuYVfvngXJ0n4TZU+O/3mcpdLXk+L6uV4g8Az8i8TCZSw
         RwXJ0L6rp8DsabE6MfeK27qc+E3LBw3FP5SwjxSzIWpFEJz4ddWHHDfEhPJ2WqmlsSZM
         l50GHAepO+MmZtRsuTafB+Mn9z48YleeIcHQv8iy0VTEgvKjphUMR3NmASAz8yzWIfaB
         8zjuxTy9pmS2TWPf7J8yGsgLQiPp9ciuVewpBLQbJz8SYAbIX7F3R+L9KTQEkrc70uRo
         6Xzw==
X-Gm-Message-State: AOAM530HrkoTP2WOWDH4cTN8TqwJOCI8ygfYavqCe7DtJnIlvMwmR37Q
        N4/oVhNFxigq2CmkzJZxY+tTLP47SOE=
X-Google-Smtp-Source: ABdhPJw1WLaJt1wz9itOgfj7pPjBlw2xXYrT6jt9xeyZPyALNNRSlFuN+TayMfobCW23vb/d4MMU2OIBnl0=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:76cb:b0:15e:f795:bf5e with SMTP id
 j11-20020a17090276cb00b0015ef795bf5emr1930290plt.39.1652394444060; Thu, 12
 May 2022 15:27:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 12 May 2022 22:27:16 +0000
In-Reply-To: <20220512222716.4112548-1-seanjc@google.com>
Message-Id: <20220512222716.4112548-4-seanjc@google.com>
Mime-Version: 1.0
References: <20220512222716.4112548-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 3/3] KVM: x86: Add helpers to identify CTL and STATUS MCi MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jue Wang <juew@google.com>
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

Add helpers to identify CTL (control) and STATUS MCi MSR types instead of
open coding the checks using the offset.  Using the offset is perfectly
safe, but unintuitive, as understanding what the code does requires
knowing that the offset calcuation will not affect the lower three bits.

Opportunistically comment the STATUS logic to save readers a trip to
Intel's SDM or AMD's APM to understand the "data != 0" check.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7e685ea9882b..b61c5def0bfc 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3188,6 +3188,16 @@ static void kvmclock_sync_fn(struct work_struct *work)
 					KVMCLOCK_SYNC_PERIOD);
 }
 
+/* These helpers are safe iff @msr is known to be an MCx bank MSR. */
+static bool is_mci_control_msr(u32 msr)
+{
+	return (msr & 3) == 0;
+}
+static bool is_mci_status_msr(u32 msr)
+{
+	return (msr & 3) == 1;
+}
+
 /*
  * On AMD, HWCR[McStatusWrEn] controls whether setting MCi_STATUS results in #GP.
  */
@@ -3225,9 +3235,6 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (msr > last_msr)
 			return 1;
 
-		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
-					    last_msr + 1 - MSR_IA32_MC0_CTL);
-
 		/*
 		 * Only 0 or all 1s can be written to IA32_MCi_CTL, all other
 		 * values are architecturally undefined.  But, some Linux
@@ -3235,15 +3242,21 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		 * issue on AMD K8s, allow bit 10 to be clear when setting all
 		 * other bits in order to avoid an uncaught #GP in the guest.
 		 */
-		if ((offset & 0x3) == 0 &&
+		if (is_mci_control_msr(msr) &&
 		    data != 0 && (data | (1 << 10)) != ~(u64)0)
 			return 1;
 
-		/* MCi_STATUS */
-		if (!msr_info->host_initiated && (offset & 0x3) == 1 &&
+		/*
+		 * All CPUs allow writing 0 to MCi_STATUS MSRs to clear the MSR.
+		 * AMD-based CPUs allow non-zero values, but if and only if
+		 * HWCR[McStatusWrEn] is set.
+		 */
+		if (!msr_info->host_initiated && is_mci_status_msr(msr) &&
 		    data != 0 && !can_set_mci_status(vcpu))
 			return 1;
 
+		offset = array_index_nospec(msr - MSR_IA32_MC0_CTL,
+					    last_msr + 1 - MSR_IA32_MC0_CTL);
 		vcpu->arch.mce_banks[offset] = data;
 		break;
 	default:
-- 
2.36.0.550.gb090851708-goog

