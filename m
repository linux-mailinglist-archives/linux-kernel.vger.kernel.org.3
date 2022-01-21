Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E9049646A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381891AbiAURr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:47:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:56027 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381849AbiAURrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:47:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642787272; x=1674323272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nWX0k/Ycng9nd3KVMoKJdljWJ4mHhaMHhIgKvclEDPw=;
  b=kQ/PJj7Z/D/AcIgH4i1kuPjw1Z6oqyZaKPUVgBWMZJV8P9cVM6u+KMK7
   CxQ5qOXpgjefgDwy8+krF6RHEUjrmEVQ/xkWLcDNcHeVXQxKY7lAMgYTw
   sBYMhouqzVc1J1jh1Nlj9IO/agKi/VIzAvclyJbH5vY/68kGYZlgPokDL
   D9eNj0iVHZAL6wHzH+mds7FzU0rIHugjrUlmDHOPiKprBbKXr49tHultT
   hzuo8IUMqGL8a/t0ExzjhVIecC5Ku1VM+WzYveGBHWoBOV2Dy9tXcfI65
   mKfQcBywiFVjY3KqRvxc6QUAGgNAeGZTMeZ2gsZhqMcfBPVM01szWQaUy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="243302304"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="243302304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="623394795"
Received: from agluck-desk2.sc.intel.com ([10.3.52.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 09:47:51 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2 3/6] x86/cpu: X86_FEATURE_INTEL_PPIN finally has a CPUID bit
Date:   Fri, 21 Jan 2022 09:47:40 -0800
Message-Id: <20220121174743.1875294-4-tony.luck@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220121174743.1875294-1-tony.luck@intel.com>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220121174743.1875294-1-tony.luck@intel.com>
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
index b7700a47eadd..8a039d1ea57f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -106,6 +106,7 @@ static struct ppin_info {
 
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

