Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE90560C22
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiF2WNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiF2WNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:13:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0F1402F;
        Wed, 29 Jun 2022 15:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656540792; x=1688076792;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/gzM3u42GDS52D3i2KuC32l8KKdq5FKoFoCLfNXt1Q4=;
  b=HxpbbkNzSEJ/E+Oafs8wwXXkWoC85yslqXG8zuSqng4uIGCMH3vbS4Xj
   2FMi0BrNF+OOBNj0GgCVc7mkpSPW78m/dwHPO1a1l28k8ph12ArC9sv9a
   rf+s/i9/1an9cuZgOf2abxSHCF3BfkNWEj81RsEW8tNT4m+UZDcDx5UHe
   Smw+tAi6FKbgcmbJC3/WioxtpUJ3jRBYQwphq35AKfm+bpUPrdrlMjPF7
   jXAVbI5qNbY1vOdqx8aEzBeQKbSPmVfuI1qGsrHgiQeHou34yGJqPs+5v
   I7G0KNeIMnEfnjq8c2aiyccPylFMkwDLzyDeNE9S16c7kLUJnH3rxv431
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="262579026"
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="262579026"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 15:13:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,232,1650956400"; 
   d="scan'208";a="658734765"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2022 15:13:11 -0700
Received: from MeteorLakePO1.jf.intel.com (MeteorLakePO1.jf.intel.com [10.234.180.58])
        by linux.intel.com (Postfix) with ESMTP id BA794580B55;
        Wed, 29 Jun 2022 15:13:11 -0700 (PDT)
From:   Gayatri Kammela <gayatri.kammela@linux.intel.com>
To:     hdegoede@redhat.com
Cc:     markgross@kernel.org, david.e.box@linux.intel.com,
        srinivas.pandruvada@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@linux.intel.com>
Subject: [PATCH v1 2/4] platform/x86/intel/vsec: Add support for Raptor Lake
Date:   Wed, 29 Jun 2022 15:13:32 -0700
Message-Id: <20220629221334.434307-3-gayatri.kammela@linux.intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
References: <20220629221334.434307-1-gayatri.kammela@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "David E. Box" <david.e.box@linux.intel.com>

Add Raptor Lake support to Intel's PMT driver.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Signed-off-by: Gayatri Kammela <gayatri.kammela@linux.intel.com>
---
 drivers/platform/x86/intel/vsec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index d48df46e2e27..9368a3d587ab 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -394,11 +394,13 @@ static const struct intel_vsec_platform_info dg1_info = {
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
 #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
+#define PCI_DEVICE_ID_INTEL_VSEC_RPL		0xa77d
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, &(struct intel_vsec_platform_info) {}) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_RPL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ }
 };
-- 
2.32.0

