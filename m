Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608AF534599
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbiEYVFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345306AbiEYVE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:04:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADDBA987
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:04:54 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id s2-20020a17090302c200b00158ea215fa2so12025278plk.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=MhaLoQZ1Fyr7auQaaGwZIF1CIB1ncwG+XDZ6YBvLp+8=;
        b=pOU+xT+m1FY14bCe7Wn4C4cI9rQ2r/blGdne2/f1klpaNUKUs7LnB6EVqakiS2Gy3F
         akMTb7DrECv/A/2MLwJu6D1rkU9WpYBzEWTX5wrR0SI7oPiiLK+yrgDH7XbN2Xh0FQhv
         1m4+/7pYJU8YBip/CF6SWftM0QNjn5QTBLSYfFr3n6rclTrMcoFMIja25VrVWNLIYf8t
         UcB5Vl+2Ejo46pltBVjijJZp4D70OpiIkKjfDJYoKil4HzXqZZo2x3bwAKzeRdOT1QiN
         eoo1IEbsT1rMlH9cp5aesyQTkEupmjefEHCQOpi3aXVIQLujcuKTiJtOil5vE+zYFQvs
         8GrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=MhaLoQZ1Fyr7auQaaGwZIF1CIB1ncwG+XDZ6YBvLp+8=;
        b=gCfavBCvEzzi6vZ/LvOJNY6Ht5yD1QVkt2T8alWy1cIq7jyahMGgxTZJBWO+MMjI5N
         AnlofseZ7aLynA1D4cRNgycHbWPV4S0i4oaLLiwuxXeqVid7zVFvogYtWiezzuQgx/A5
         g8RyY8kHpf+ogA5oqZMed9TJ+NhbP92s0eKSTQt4GM88oFVC1wy57rq+nx50McR0YZ3K
         jLf9Uhy8AbVyT30u7SPmsuTJRy4TY07mdfC3jRNuFtB4Xv265H9FjMKM+i2nou/ijPc4
         mDV6pldgX6NY3A2bD1W76JUeV5fN9UbvktH362rKeg/x8oNJh5FExrYoo0OVG+N88RH7
         s5Ag==
X-Gm-Message-State: AOAM532l/zfDBseRtpMYDVmSiyUrz+UsOfGvU/YLgtFb23ZVsrhb7lFM
        1fkb4ZKbSKAxisEvXxrfNglWAVU6ZEc=
X-Google-Smtp-Source: ABdhPJy8yjwRd0sOfqXZIqlFPLl4fjOVh9U/pVVwxzIHTqp/Fmtviv7/AnGVk6DF1xCKPLg+D8Yz+A/vrZc=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a63:4:0:b0:3c6:cce2:8457 with SMTP id
 4-20020a630004000000b003c6cce28457mr29605276pga.612.1653512694310; Wed, 25
 May 2022 14:04:54 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed, 25 May 2022 21:04:47 +0000
In-Reply-To: <20220525210447.2758436-1-seanjc@google.com>
Message-Id: <20220525210447.2758436-3-seanjc@google.com>
Mime-Version: 1.0
References: <20220525210447.2758436-1-seanjc@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 2/2] KVM: VMX: Add knob to allow rejecting kvm_intel on
 inconsistent VMCS config
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Lei Wang <lei4.wang@intel.com>
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

Add an off-by-default module param, reject_inconsistent_vmcs_config, to
allow rejecting the load of kvm_intel if an inconsistent VMCS config is
detected.  Continuing on with an inconsistent, degraded config is
undesirable when the CPU is expected to support a given set of features,
e.g. can result in a misconfigured VM if userspace doesn't cross-check
KVM_GET_SUPPORTED_CPUID, and/or can result in poor performance due to
lack of fast MSR switching.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2ea256de9aba..11413a8cc57f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -119,6 +119,9 @@ module_param(nested, bool, S_IRUGO);
 bool __read_mostly enable_pml = 1;
 module_param_named(pml, enable_pml, bool, S_IRUGO);
 
+static bool __read_mostly reject_inconsistent_vmcs_config;
+module_param(reject_inconsistent_vmcs_config, bool, 0444);
+
 static bool __read_mostly dump_invalid_vmcs = 0;
 module_param(dump_invalid_vmcs, bool, 0644);
 
@@ -2577,15 +2580,23 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 					     CPU_BASED_CR3_STORE_EXITING |
 					     CPU_BASED_INVLPG_EXITING);
 	} else if (vmx_cap->ept) {
-		vmx_cap->ept = 0;
 		pr_warn_once("EPT CAP should not exist if not support "
 				"1-setting enable EPT VM-execution control\n");
+
+		if (reject_inconsistent_vmcs_config)
+			return -EIO;
+
+		vmx_cap->ept = 0;
 	}
 	if (!(_cpu_based_2nd_exec_control & SECONDARY_EXEC_ENABLE_VPID) &&
-		vmx_cap->vpid) {
-		vmx_cap->vpid = 0;
+	    vmx_cap->vpid) {
 		pr_warn_once("VPID CAP should not exist if not support "
 				"1-setting enable VPID VM-execution control\n");
+
+		if (reject_inconsistent_vmcs_config)
+			return -EIO;
+
+		vmx_cap->vpid = 0;
 	}
 
 	if (_cpu_based_exec_control & CPU_BASED_ACTIVATE_TERTIARY_CONTROLS) {
@@ -2645,6 +2656,9 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf,
 		pr_warn_once("Inconsistent VM-Entry/VM-Exit pair, entry = %x, exit = %x\n",
 			     _vmentry_control & n_ctrl, _vmexit_control & x_ctrl);
 
+		if (reject_inconsistent_vmcs_config)
+			return -EIO;
+
 		_vmentry_control &= ~n_ctrl;
 		_vmexit_control &= ~x_ctrl;
 	}
-- 
2.36.1.124.g0e6072fb45-goog

