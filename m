Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298EE4A52C9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 00:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235997AbiAaXBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 18:01:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:53704 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235529AbiAaXBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 18:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643670079; x=1675206079;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D5IxgMQQPsxXkTofIEcbAivuT+zDal3E4DIqU1/Lh7U=;
  b=iCIgDmkTlB8DyrMbKKp47u8joncKrkhUox8ApaIJECV1wswJfjN81DCA
   qQaZGNwEcTDY6W7Yl50rI25b35MNj+fx3MrsAC98YH/WIAj9+kdJXbtmg
   cmPoY5QhI+ScOYY0gC0a3brxRaOKDfp7/oCY+fccTX31WmGeSXTbFfK6t
   Cyljs9vCip+boB23GrSx9nQuMHPeLcjO7tGF0NKk2JyqCNNQjagm62fug
   r4PCmhrrKS6pJMrYzYnGHmXGuKlDlpUzV1dIsgbA/jVQpraGzXDLYsUvD
   WP6ipu+mzeC/JWsU9vv6lWgp/av3PMptrX1Op2WnSiKt7n0h0nltBSETy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="247521225"
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="247521225"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,331,1635231600"; 
   d="scan'208";a="522831341"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 15:01:18 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3 2/5] x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
Date:   Mon, 31 Jan 2022 15:01:08 -0800
Message-Id: <20220131230111.2004669-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220131230111.2004669-1-tony.luck@intel.com>
References: <20220121174743.1875294-1-tony.luck@intel.com>
 <20220131230111.2004669-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After nine generations of adding to model specific list of CPUs that
support PPIN (Protected Processor Inventory Number) Intel allocated
a CPUID bit to enumerate the MSRs.

CPUID(EAX=7, ECX=1).EBX bit 0 enumerates presence of MSR_PPIN_CTL and
MSR_PPIN. Add it to the "scattered" CPUID bits and add an entry to the
ppin_cpuids[] x86_match_cpu() array to catch Intel CPUs that implement
it.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/common.c    | 1 +
 arch/x86/kernel/cpu/scattered.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b0bd8a6b5beb..0681c69a1f09 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -104,6 +104,7 @@ static struct ppin_info {
 
 static const struct x86_cpu_id ppin_cpuids[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_AMD_PPIN, &ppin_info[X86_VENDOR_AMD]),
+	X86_MATCH_FEATURE(X86_FEATURE_INTEL_PPIN, &ppin_info[X86_VENDOR_INTEL]),
 
 	/* Legacy models without CPUID enumeration */
 	X86_MATCH_INTEL_FAM6_MODEL(IVYBRIDGE_X, &ppin_info[X86_VENDOR_INTEL]),
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 21d1f062895a..4143b1e4c5c6 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -26,6 +26,7 @@ struct cpuid_bit {
 static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
 	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
+	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
 	{ X86_FEATURE_CQM_LLC,		CPUID_EDX,  1, 0x0000000f, 0 },
 	{ X86_FEATURE_CQM_OCCUP_LLC,	CPUID_EDX,  0, 0x0000000f, 1 },
 	{ X86_FEATURE_CQM_MBM_TOTAL,	CPUID_EDX,  1, 0x0000000f, 1 },
-- 
2.31.1

