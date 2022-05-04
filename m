Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 128C151AE45
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233226AbiEDTsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377739AbiEDTsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:48:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B0F4EDD8
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 12:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651693465; x=1683229465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=h90700iV5WKX8ySGE6qVkrdDbiAxN82xsO/cHuc90Kk=;
  b=Wk+3PdeetEz6dhBgQd9lMrgndTIk2/8pxL/FS9VReWAhOx+ePLjTZSOt
   S55aR0cMFezLU287HDLeYG08SrflYCfPhXviBvG4sKq0laHF70ZrWgkd5
   v6cPseznL4Tek0gpjq2FWxSBbUuQPJ95jmYPnl27Oxb6n5vyn7eA2qIAx
   ud5V0MO5Yc5IsJIf0cCznQNqqmiIhVNuU1cUbVyplJj7+cSfegrAjjtZh
   vYtxsXlNN9sOaZQ+AHAn3VgBBwR5NY8AW+uIOxa+qHFYFUqmULh+cb7Ml
   CY9yhwVTJuoNnKZ7s3pO6xppWS0Y/gq5JHZFMyhW7G0N1gNtIgHGTjOPO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="248416191"
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="248416191"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 12:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,199,1647327600"; 
   d="scan'208";a="549003466"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga002.jf.intel.com with ESMTP; 04 May 2022 12:44:21 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 4/5] perf/x86/uncore: Clean up uncore_pci_ids[]
Date:   Wed,  4 May 2022 12:44:12 -0700
Message-Id: <20220504194413.1003071-4-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220504194413.1003071-1-kan.liang@linux.intel.com>
References: <20220504194413.1003071-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UPPERCASE_75_100 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The initialization code to assign PCI IDs for different platforms is
similar. Add the new macros to reduce the redundant code.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snb.c | 402 ++++++-----------------------
 1 file changed, 86 insertions(+), 316 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 4262351f52b6..b30890b91137 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -84,6 +84,13 @@
 #define PCI_DEVICE_ID_INTEL_RPL_3_IMC		0xA706
 #define PCI_DEVICE_ID_INTEL_RPL_4_IMC		0xA709
 
+
+#define IMC_UNCORE_DEV(a)						\
+{									\
+	PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_##a##_IMC),	\
+	.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),	\
+}
+
 /* SNB event control */
 #define SNB_UNC_CTL_EV_SEL_MASK			0x000000ff
 #define SNB_UNC_CTL_UMASK_MASK			0x0000ff00
@@ -849,242 +856,80 @@ static struct intel_uncore_type *snb_pci_uncores[] = {
 };
 
 static const struct pci_device_id snb_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SNB_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(SNB),
 	{ /* end: all zeroes */ },
 };
 
 static const struct pci_device_id ivb_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_E3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(IVB),
+	IMC_UNCORE_DEV(IVB_E3),
 	{ /* end: all zeroes */ },
 };
 
 static const struct pci_device_id hsw_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_HSW_U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(HSW),
+	IMC_UNCORE_DEV(HSW_U),
 	{ /* end: all zeroes */ },
 };
 
 static const struct pci_device_id bdw_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_BDW_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(BDW),
 	{ /* end: all zeroes */ },
 };
 
 static const struct pci_device_id skl_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_Y_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_HD_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_HQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SD_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_SQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_SKL_E3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_Y_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_UQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SD_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_SQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_HQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_KBL_WQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4H_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6H_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_2S_D_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_D_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_D_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_D_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_W_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_W_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_W_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_4S_S_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_6S_S_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CFL_8S_S_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AML_YD_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_AML_YQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_4_UQ_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_WHL_UD_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_H3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_U3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S4_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_CML_S5_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(SKL_Y),
+	IMC_UNCORE_DEV(SKL_U),
+	IMC_UNCORE_DEV(SKL_HD),
+	IMC_UNCORE_DEV(SKL_HQ),
+	IMC_UNCORE_DEV(SKL_SD),
+	IMC_UNCORE_DEV(SKL_SQ),
+	IMC_UNCORE_DEV(SKL_E3),
+	IMC_UNCORE_DEV(KBL_Y),
+	IMC_UNCORE_DEV(KBL_U),
+	IMC_UNCORE_DEV(KBL_UQ),
+	IMC_UNCORE_DEV(KBL_SD),
+	IMC_UNCORE_DEV(KBL_SQ),
+	IMC_UNCORE_DEV(KBL_HQ),
+	IMC_UNCORE_DEV(KBL_WQ),
+	IMC_UNCORE_DEV(CFL_2U),
+	IMC_UNCORE_DEV(CFL_4U),
+	IMC_UNCORE_DEV(CFL_4H),
+	IMC_UNCORE_DEV(CFL_6H),
+	IMC_UNCORE_DEV(CFL_2S_D),
+	IMC_UNCORE_DEV(CFL_4S_D),
+	IMC_UNCORE_DEV(CFL_6S_D),
+	IMC_UNCORE_DEV(CFL_8S_D),
+	IMC_UNCORE_DEV(CFL_4S_W),
+	IMC_UNCORE_DEV(CFL_6S_W),
+	IMC_UNCORE_DEV(CFL_8S_W),
+	IMC_UNCORE_DEV(CFL_4S_S),
+	IMC_UNCORE_DEV(CFL_6S_S),
+	IMC_UNCORE_DEV(CFL_8S_S),
+	IMC_UNCORE_DEV(AML_YD),
+	IMC_UNCORE_DEV(AML_YQ),
+	IMC_UNCORE_DEV(WHL_UQ),
+	IMC_UNCORE_DEV(WHL_4_UQ),
+	IMC_UNCORE_DEV(WHL_UD),
+	IMC_UNCORE_DEV(CML_H1),
+	IMC_UNCORE_DEV(CML_H2),
+	IMC_UNCORE_DEV(CML_H3),
+	IMC_UNCORE_DEV(CML_U1),
+	IMC_UNCORE_DEV(CML_U2),
+	IMC_UNCORE_DEV(CML_U3),
+	IMC_UNCORE_DEV(CML_S1),
+	IMC_UNCORE_DEV(CML_S2),
+	IMC_UNCORE_DEV(CML_S3),
+	IMC_UNCORE_DEV(CML_S4),
+	IMC_UNCORE_DEV(CML_S5),
 	{ /* end: all zeroes */ },
 };
 
 static const struct pci_device_id icl_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICL_U2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RKL_2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(ICL_U),
+	IMC_UNCORE_DEV(ICL_U2),
+	IMC_UNCORE_DEV(RKL_1),
+	IMC_UNCORE_DEV(RKL_2),
 	{ /* end: all zeroes */ },
 };
 
@@ -1326,106 +1171,31 @@ void nhm_uncore_cpu_init(void)
 /* Tiger Lake MMIO uncore support */
 
 static const struct pci_device_id tgl_uncore_pci_ids[] = {
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_U4_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_TGL_H_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_4_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_5_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_6_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_7_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_8_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_9_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_10_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_11_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_12_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_13_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_14_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_15_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ADL_16_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_1_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_2_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_3_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
-	{ /* IMC */
-		PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_RPL_4_IMC),
-		.driver_data = UNCORE_PCI_DEV_DATA(SNB_PCI_UNCORE_IMC, 0),
-	},
+	IMC_UNCORE_DEV(TGL_U1),
+	IMC_UNCORE_DEV(TGL_U2),
+	IMC_UNCORE_DEV(TGL_U3),
+	IMC_UNCORE_DEV(TGL_U4),
+	IMC_UNCORE_DEV(TGL_H),
+	IMC_UNCORE_DEV(ADL_1),
+	IMC_UNCORE_DEV(ADL_2),
+	IMC_UNCORE_DEV(ADL_3),
+	IMC_UNCORE_DEV(ADL_4),
+	IMC_UNCORE_DEV(ADL_5),
+	IMC_UNCORE_DEV(ADL_6),
+	IMC_UNCORE_DEV(ADL_7),
+	IMC_UNCORE_DEV(ADL_8),
+	IMC_UNCORE_DEV(ADL_9),
+	IMC_UNCORE_DEV(ADL_10),
+	IMC_UNCORE_DEV(ADL_11),
+	IMC_UNCORE_DEV(ADL_12),
+	IMC_UNCORE_DEV(ADL_13),
+	IMC_UNCORE_DEV(ADL_14),
+	IMC_UNCORE_DEV(ADL_15),
+	IMC_UNCORE_DEV(ADL_16),
+	IMC_UNCORE_DEV(RPL_1),
+	IMC_UNCORE_DEV(RPL_2),
+	IMC_UNCORE_DEV(RPL_3),
+	IMC_UNCORE_DEV(RPL_4),
 	{ /* end: all zeroes */ }
 };
 
-- 
2.35.1

