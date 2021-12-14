Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640AE4739E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244585AbhLNA7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:59:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:21411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhLNA7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443578; x=1670979578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Z3pTsdcyEg0Cysyg0rQo7WWdsgj62MRS390COBMyxXg=;
  b=i9CjC1bySUSxj+PGfYsWFoxHiXSfk4mqMC0UCyN7o33hF5CuU4QXNgMS
   AwQii8uAXgPo2+MEu/xApD+FsHa75udlSFhE1WXNU7J97fw9F/WaLybs2
   rHK3W24Hgo180niRur6HPkG+DGJy2Zcbx/4WOaB35QF3HdqT3VU5jBoKY
   OSnOw4DmdCXC9ZGqHKFrEHPlJ9WJOkOokPSDa6LxQomIRBFvHHZiIV2dZ
   IkbuovBwh2vpERnVjlBLbzMxUuGHaNq3b4NP08qs8Ne/+FUf8EjF9CSCU
   0PbM9e9Rmsr4YKtYNVWoBw6TQWxGuARuZ12GnkmRXidKK/cHFhZz2GkT/
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139615"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139615"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148570"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:37 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 02/13] x86/cpufeature: Enumerate Key Locker feature
Date:   Mon, 13 Dec 2021 16:52:01 -0800
Message-Id: <20211214005212.20588-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211214005212.20588-1-chang.seok.bae@intel.com>
References: <20211214005212.20588-1-chang.seok.bae@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Key Locker is a CPU feature to minimize exposure of clear-text key
material. An encoded form, called 'key handle', is referenced for data
encryption or decryption instead of accessing the clear text key.

A wrapping key loaded in the CPU's software-inaccessible state is used to
transform a user key into a key handle.

It supports Advanced Encryption Standard (AES) cipher algorithm with new
SIMD instruction set like its predecessor (AES-NI). So a new AES
implementation will follow in the kernel's crypto library.

Here add it to enumerate the hardware capability, but it will not be
shown in /proc/cpuinfo as userspace usage is not supported.

Make the feature depend on XMM2 as it comes with AES SIMD instructions.

Add X86_FEATURE_KEYLOCKER to the disabled features mask. It will be
enabled under a new config option.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Do not publish the feature flag to userspace.
* Update the changelog.

Changes from RFC v1:
* Updated the changelog.
---
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/disabled-features.h    | 8 +++++++-
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 arch/x86/kernel/cpu/cpuid-deps.c            | 1 +
 4 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index d5b5f2ab87a0..e1964446bbe5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -361,6 +361,7 @@
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
 #define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
 #define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
+#define X86_FEATURE_KEYLOCKER		(16*32+23) /* "" Key Locker */
 #define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 8f28fafa98b3..75e1e87640d4 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,6 +44,12 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
+#ifdef CONFIG_X86_KEYLOCKER
+# define DISABLE_KEYLOCKER	0
+#else
+# define DISABLE_KEYLOCKER	(1<<(X86_FEATURE_KEYLOCKER & 31))
+#endif /* CONFIG_X86_KEYLOCKER */
+
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
 #else
@@ -85,7 +91,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_KEYLOCKER)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..b958a95a0908 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -124,6 +124,8 @@
 #define X86_CR4_PCIDE		_BITUL(X86_CR4_PCIDE_BIT)
 #define X86_CR4_OSXSAVE_BIT	18 /* enable xsave and xrestore */
 #define X86_CR4_OSXSAVE		_BITUL(X86_CR4_OSXSAVE_BIT)
+#define X86_CR4_KEYLOCKER_BIT	19 /* enable Key Locker */
+#define X86_CR4_KEYLOCKER	_BITUL(X86_CR4_KEYLOCKER_BIT)
 #define X86_CR4_SMEP_BIT	20 /* enable SMEP support */
 #define X86_CR4_SMEP		_BITUL(X86_CR4_SMEP_BIT)
 #define X86_CR4_SMAP_BIT	21 /* enable SMAP support */
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index c881bcafba7d..abe7e04b27d9 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -78,6 +78,7 @@ static const struct cpuid_dep cpuid_deps[] = {
 	{ X86_FEATURE_XFD,			X86_FEATURE_XSAVES    },
 	{ X86_FEATURE_XFD,			X86_FEATURE_XGETBV1   },
 	{ X86_FEATURE_AMX_TILE,			X86_FEATURE_XFD       },
+	{ X86_FEATURE_KEYLOCKER,		X86_FEATURE_XMM2      },
 	{}
 };
 
-- 
2.17.1

