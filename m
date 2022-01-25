Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7549BD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 22:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiAYVAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 16:00:15 -0500
Received: from mga11.intel.com ([192.55.52.93]:39742 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbiAYVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 16:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643144410; x=1674680410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=r/+FNMKs/Z0Sqj+xFuC/uDZxiuzeVZQdHx5A2DosufA=;
  b=c5gQedNomADgzf40GH6d220HMDXjRewItpL6MvHMddgPaUPdd5nGvV+q
   X60x6qA87cTUvsVRYdbPS1xKfx94qfF83rr0zvjR8EIKu7HJM5cHYBgD0
   ADoKcFv8nN6cxqz5gd0LHtI+s+efq5r0LloPHj8IyaynbCAv9RkeJWQ+s
   z54Wuf8jqGuJUzqfXy0UJmgBau9M7Jy1Bnws7SRAJCSENXKDpluk/BmGl
   TLn2UQiRdvVcOb220SwQuOMlcr5cDVZbQ9WT9hnUfF79TfWVeqFhap8y4
   XHhGW5KbLtxcejfEexjzojIUveL74arg5gsyyush95Lv2RhUKpEdZQGCQ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244013729"
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="244013729"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 13:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,315,1635231600"; 
   d="scan'208";a="520545831"
Received: from otc-lr-04.jf.intel.com ([10.54.39.41])
  by orsmga007.jf.intel.com with ESMTP; 25 Jan 2022 13:00:10 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/4] perf/x86/uncore: Add Raptor Lake uncore support
Date:   Tue, 25 Jan 2022 15:57:51 -0800
Message-Id: <1643155071-98900-4-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
References: <1643155071-98900-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The uncore PMU of the Raptor Lake is the same as Alder Lake.
Add new PCIIDs of IMC for Raptor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  1 +
 arch/x86/events/intel/uncore_snb.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index e497da9..7695dca 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1828,6 +1828,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index f698a55..cae22be 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -79,6 +79,9 @@
 #define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
 #define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
 #define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
+#define PCI_DEVICE_ID_INTEL_RPL_1_IMC		0xA700
+#define PCI_DEVICE_ID_INTEL_RPL_2_IMC		0xA706
+#define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA709
 
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
@@ -1406,6 +1409,18 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_16_IMC),
 		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
 	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_1_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_2_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
+	{ /* IMC */
+		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_3_IMC),
+		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
+	},
 	{ /* end: all zeroes */ }
 };
 
-- 
2.7.4

