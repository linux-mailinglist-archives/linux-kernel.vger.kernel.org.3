Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F75A51AE46
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377682AbiEDTsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377735AbiEDTsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:48:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25284EDD9
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651693465; x=1683229465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LOftJdy/rhu02/2gQDmB7tV4F8Asgc5Ejq17mLWudDI=;
  b=P745FTELpbJDE/NtPNHEm7vDHagnn8Pm3PN2ghKIgcTUmUUxbqGcHHIA
   vlFbjfsd+PyAxhuYCm8u0z0XE3B8DuNNb2yY7Ic0yRM2ZpUYAhZJYJqtC
   2q2vpaRuFKvxCAZgyIRsVSWkwZhG/C6qMMuJYb7rllUz5TK8p62/Ou+h1
   8mN2cHSRN4CqR34EqeBLc3IHgAOI7uZYKlDjnGoV1grTIW7T7VVik16og
   fuCsWgAW4+LvutkwL9374OG0qaBTUnLmLVnW01Ai+j2LB7xWTCMZJxk0D
   thpS2DQ868p9kdqMGR7K23qIvuh1z0y9OB6Xbhj4gGcLafVVdbrFNHd51
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248416192"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248416192"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="549003467"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 12:44:22 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/5] perf/x86/uncore: Add new Alder Lake and Raptor Lake support
Date:   Wed,  4 May 2022 12:44:13 -0700
Message-Id: <20220504194413.1003071-5-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504194413.1003071-1-kan.liang@linux.intel.com>
References: <20220504194413.1003071-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

From the perspective of the uncore PMU, there is nothing changed for the
new Alder Lake N and Raptor Lake P.

Add new PCIIDs of IMC.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore.c     |  2 ++
 arch/x86/events/intel/uncore_snb.c | 52 ++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 7695dcae280e..db6c31bca809 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1828,7 +1828,9 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ROCKETLAKE,		&rkl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_N,		&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE,		&adl_uncore_init),
+	X86_MATCH_INTEL_FAM6_MODEL(RAPTORLAKE_P,	&adl_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&spr_uncore_init),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_TREMONT_D,	&snr_uncore_init),
 	{},
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index b30890b91137..ce440011cc4e 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -79,10 +79,36 @@
 #define PCI_DEVICE_ID_INTEL_ADL_14_IMC		0x4650
 #define PCI_DEVICE_ID_INTEL_ADL_15_IMC		0x4668
 #define PCI_DEVICE_ID_INTEL_ADL_16_IMC		0x4670
+#define PCI_DEVICE_ID_INTEL_ADL_17_IMC		0x4614
+#define PCI_DEVICE_ID_INTEL_ADL_18_IMC		0x4617
+#define PCI_DEVICE_ID_INTEL_ADL_19_IMC		0x4618
+#define PCI_DEVICE_ID_INTEL_ADL_20_IMC		0x461B
+#define PCI_DEVICE_ID_INTEL_ADL_21_IMC		0x461C
 #define PCI_DEVICE_ID_INTEL_RPL_1_IMC		0xA700
 #define PCI_DEVICE_ID_INTEL_RPL_2_IMC		0xA702
 #define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA706
 #define PCI_DEVICE_ID_INTEL_RPL_4_IMC		0xA709
+#define PCI_DEVICE_ID_INTEL_RPL_5_IMC		0xA701
+#define PCI_DEVICE_ID_INTEL_RPL_6_IMC		0xA703
+#define PCI_DEVICE_ID_INTEL_RPL_7_IMC		0xA704
+#define PCI_DEVICE_ID_INTEL_RPL_8_IMC		0xA705
+#define PCI_DEVICE_ID_INTEL_RPL_9_IMC		0xA706
+#define PCI_DEVICE_ID_INTEL_RPL_10_IMC		0xA707
+#define PCI_DEVICE_ID_INTEL_RPL_11_IMC		0xA708
+#define PCI_DEVICE_ID_INTEL_RPL_12_IMC		0xA709
+#define PCI_DEVICE_ID_INTEL_RPL_13_IMC		0xA70a
+#define PCI_DEVICE_ID_INTEL_RPL_14_IMC		0xA70b
+#define PCI_DEVICE_ID_INTEL_RPL_15_IMC		0xA715
+#define PCI_DEVICE_ID_INTEL_RPL_16_IMC		0xA716
+#define PCI_DEVICE_ID_INTEL_RPL_17_IMC		0xA717
+#define PCI_DEVICE_ID_INTEL_RPL_18_IMC		0xA718
+#define PCI_DEVICE_ID_INTEL_RPL_19_IMC		0xA719
+#define PCI_DEVICE_ID_INTEL_RPL_20_IMC		0xA71A
+#define PCI_DEVICE_ID_INTEL_RPL_21_IMC		0xA71B
+#define PCI_DEVICE_ID_INTEL_RPL_22_IMC		0xA71C
+#define PCI_DEVICE_ID_INTEL_RPL_23_IMC		0xA728
+#define PCI_DEVICE_ID_INTEL_RPL_24_IMC		0xA729
+#define PCI_DEVICE_ID_INTEL_RPL_25_IMC		0xA72A
 
 
 #define IMC_UNCORE_DEV(a)						\
@@ -1192,10 +1218,36 @@ static const struct pci_device_id tgl_uncore_pci_ids[] = {
 	IMC_UNCORE_DEV(ADL_14),
 	IMC_UNCORE_DEV(ADL_15),
 	IMC_UNCORE_DEV(ADL_16),
+	IMC_UNCORE_DEV(ADL_17),
+	IMC_UNCORE_DEV(ADL_18),
+	IMC_UNCORE_DEV(ADL_19),
+	IMC_UNCORE_DEV(ADL_20),
+	IMC_UNCORE_DEV(ADL_21),
 	IMC_UNCORE_DEV(RPL_1),
 	IMC_UNCORE_DEV(RPL_2),
 	IMC_UNCORE_DEV(RPL_3),
 	IMC_UNCORE_DEV(RPL_4),
+	IMC_UNCORE_DEV(RPL_5),
+	IMC_UNCORE_DEV(RPL_6),
+	IMC_UNCORE_DEV(RPL_7),
+	IMC_UNCORE_DEV(RPL_8),
+	IMC_UNCORE_DEV(RPL_9),
+	IMC_UNCORE_DEV(RPL_10),
+	IMC_UNCORE_DEV(RPL_11),
+	IMC_UNCORE_DEV(RPL_12),
+	IMC_UNCORE_DEV(RPL_13),
+	IMC_UNCORE_DEV(RPL_14),
+	IMC_UNCORE_DEV(RPL_15),
+	IMC_UNCORE_DEV(RPL_16),
+	IMC_UNCORE_DEV(RPL_17),
+	IMC_UNCORE_DEV(RPL_18),
+	IMC_UNCORE_DEV(RPL_19),
+	IMC_UNCORE_DEV(RPL_20),
+	IMC_UNCORE_DEV(RPL_21),
+	IMC_UNCORE_DEV(RPL_22),
+	IMC_UNCORE_DEV(RPL_23),
+	IMC_UNCORE_DEV(RPL_24),
+	IMC_UNCORE_DEV(RPL_25),
 	{ /* end: all zeroes */ }
 };
 
-- 
2.35.1

