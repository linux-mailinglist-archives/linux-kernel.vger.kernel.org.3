Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE915825F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiG0LzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiG0LzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:55:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D833D7B;
        Wed, 27 Jul 2022 04:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658922909; x=1690458909;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TJMpj2evcKUJONVAmJwm8pa+9tXHQ3BmofeStSV5/5Y=;
  b=h4XbqFYQaJs7FjanwsAMlXUgoGsXroAxoGiO/j311LBqBgsY645o8fSK
   9uCuKKIWfPi56pxeArZHRrnIHCC7wh6f4m9seOKSlaRFRjLRo5a0mj3Es
   kmHVFN39q/QMuzKSVNaSVPxYAYMSmPoq0a8Qx9oY8+MUf3ujsTB6uyMhC
   AGQcNMDD5+fZf+bsjzYxIGV9TCYrd79DO1duOcXGXfVoKWykq4t4yx3kO
   2clKJNY310l8VlHSTVxUEB7hx5iZbHhQHV3/95BqHfKKEyNJSj88k1qyf
   JU8PaLmPM2GzGpC2mrQNb97HROn0SL21xMx/eMztXdEwrUFIEbax6Dy/x
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289407428"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="289407428"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 04:55:09 -0700
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="846243376"
Received: from jlseahol-mobl3.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.1.35])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 04:55:07 -0700
From:   Kai Huang <kai.huang@intel.com>
To:     dave.hansen@linux.intel.com, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, jarkko@kernel.org,
        haitao.huang@linux.intel.com
Subject: [PATCH] x86/sgx: Allow exposing EDECCSSA user leaf function to KVM guest
Date:   Wed, 27 Jul 2022 23:54:42 +1200
Message-Id: <20220727115442.464380-1-kai.huang@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coupled with the new SGX attribute to allow one enclave to receive the
AEX notification, SGX also adds a new EDECCSSA user leaf function to
facilitate the AEX notification handling.  The new EDECCSSA is
enumerated via CPUID(EAX=0x12,ECX=0x0):EAX[11].

Besides Allowing reporting the new AEX-notify attribute to KVM guests,
also allow reporting the new EDECCSSA user leaf function to KVM guests
so the guest can fully utilize the AEX-notify mechanism.

Introduce a new X86 CPU feature flag for the new EDECCSSA, and report it
in KVM's supported CPUIDs so the userspace hypervisor (i.e. Qemu) can
enable it for the guest.

Note there's no additional enabling work required to allow guest to use
the new EDECCSSA.  KVM is not able to trap ENCLU anyway.

More background about how do AEX-notify and EDECCSSA work:

The new Asynchronous Exit (AEX) notification mechanism (AEX-notify)
allows one enclave to receive a notification in the ERESUME after the
enclave exit due to an AEX.  EDECCSSA is a new SGX user leaf function
(ENCLU[EDECCSSA]) to facilitate the AEX notification handling.

SGX maintains a Current State Save Area Frame (CSSA) for each enclave
thread.  When AEX happens, the enclave thread context is saved to the
CSSA and the CSSA is increased by 1.  For a normal ERESUME which doesn't
deliver AEX notification, it restores the saved thread context from the
previously saved SSA and decreases the CSSA.  If AEX-notify is enabled
for one enclave, the ERESUME acts differently.  Instead of restoring the
saved thread context and decreasing the CSSA, it acts like EENTER which
doesn't decrease the CSSA but establishes a clean slate thread context
at the CSSA for the enclave to handle the notification.  After some
handling, the enclave must discard the "new-established" SSA and switch
back to the previous saved SSA (upon AEX).  Otherwise, the enclave will
run out of SSA space upon further AEXs and eventually fail to run.

To solve this problem, the new EDECCSSA essentially decreases the CSSA.
It can be used by the enclave notification handler to switch back to the
previous saved SSA when needed, i.e. after it handles the notification.

Signed-off-by: Kai Huang <kai.huang@intel.com>
---
Hi Dave,

This is the patch you requested.  Feel free to merge.

This patch isn't tested and needs KVM maintainers' review.

---
 arch/x86/include/asm/cpufeatures.h | 1 +
 arch/x86/kvm/cpuid.c               | 2 +-
 arch/x86/kvm/reverse_cpuid.h       | 3 +++
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6466a58b9cff..d2ebb38b31e7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -296,6 +296,7 @@
 #define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
 #define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
 #define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
+#define X86_FEATURE_SGX_EDECCSSA	(11*32+10) /* "" SGX EDECCSSA user leaf function */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 75dcf7a72605..c21b4a5dc8fa 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -644,7 +644,7 @@ void kvm_set_cpu_caps(void)
 	);
 
 	kvm_cpu_cap_init_scattered(CPUID_12_EAX,
-		SF(SGX1) | SF(SGX2)
+		SF(SGX1) | SF(SGX2) | SF(SGX_EDECCSSA)
 	);
 
 	kvm_cpu_cap_mask(CPUID_8000_0001_ECX,
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a19d473d0184..4e5b8444f161 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -23,6 +23,7 @@ enum kvm_only_cpuid_leafs {
 /* Intel-defined SGX sub-features, CPUID level 0x12 (EAX). */
 #define KVM_X86_FEATURE_SGX1		KVM_X86_FEATURE(CPUID_12_EAX, 0)
 #define KVM_X86_FEATURE_SGX2		KVM_X86_FEATURE(CPUID_12_EAX, 1)
+#define KVM_X86_FEATURE_SGX_EDECCSSA	KVM_X86_FEATURE(CPUID_12_EAX, 11)
 
 struct cpuid_reg {
 	u32 function;
@@ -78,6 +79,8 @@ static __always_inline u32 __feature_translate(int x86_feature)
 		return KVM_X86_FEATURE_SGX1;
 	else if (x86_feature == X86_FEATURE_SGX2)
 		return KVM_X86_FEATURE_SGX2;
+	else if (x86_feature == X86_FEATURE_SGX_EDECCSSA)
+		return KVM_X86_FEATURE_SGX_EDECCSSA;
 
 	return x86_feature;
 }
-- 
2.36.1

