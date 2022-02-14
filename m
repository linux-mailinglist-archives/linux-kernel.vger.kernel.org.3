Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17A4B5CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbiBNVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:35:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiBNVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:35:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85D5159EBA;
        Mon, 14 Feb 2022 13:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874387; x=1676410387;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IvBaQoac9SdSxMy/aBRplJsi4/+x3xY3JY7OPph3BGY=;
  b=frBDgvVGv0wgpQ+W2J96s6F00fmebIRT3AEGIrvA/01l2FAp99+I8s9H
   Pj3oMEoU5X0Txy6MWVO8JhYLNNCqnapugDws4gEO5NfqbYq45d2N5lXc+
   6j+V8FPFhRK9Sw79wQ6fIc3pmuJCvjfr6lB2gDYUdTjOMHxrYjZKn4Yz3
   /9h3JnHhs7JhMeyJQs1fn6RWa5bdkHneeAVhoBKQUIl4oBHONIpl6N3Qu
   yalQxiVQl+tyb0nr7MJfYoCoGmUozcDv0iQI/O+yZdWe5MaVaLwIwNZxE
   X7n6YnmcN+GTjWD+zx1Ct6tfk3UvkQVG1yRojXGSG2YHz97BIsTE4PdeN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="230827935"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="230827935"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 13:33:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="485726861"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 14 Feb 2022 13:33:07 -0800
Received: from debox1-desk4.intel.com (unknown [10.255.228.161])
        by linux.intel.com (Postfix) with ESMTP id E4B47580D3A;
        Mon, 14 Feb 2022 13:33:06 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     hdegoede@redhat.com, david.e.box@linux.intel.com,
        mgross@linux.intel.com, rjw@rjwysocki.net,
        srinivas.pandruvada@intel.com
Cc:     linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] platform/x86/intel: vsec: Add DG2 support
Date:   Mon, 14 Feb 2022 13:32:58 -0800
Message-Id: <20220214213258.1929462-4-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220214213258.1929462-1-david.e.box@linux.intel.com>
References: <20220214213258.1929462-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Platform Monitoring Technology support for DG2 platforms.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/pmt/class.c | 2 ++
 drivers/platform/x86/intel/vsec.c      | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/platform/x86/intel/pmt/class.c b/drivers/platform/x86/intel/pmt/class.c
index a3ec09fe2f38..d25fffb2103d 100644
--- a/drivers/platform/x86/intel/pmt/class.c
+++ b/drivers/platform/x86/intel/pmt/class.c
@@ -31,6 +31,8 @@
 static const struct pci_device_id pmt_telem_early_client_pci_ids[] = {
 	{ PCI_VDEVICE(INTEL, 0x467d) }, /* ADL */
 	{ PCI_VDEVICE(INTEL, 0x490e) }, /* DG1 */
+	{ PCI_VDEVICE(INTEL, 0x4f93) }, /* DG2_G10 */
+	{ PCI_VDEVICE(INTEL, 0x4f95) }, /* DG2_G11 */
 	{ PCI_VDEVICE(INTEL, 0x9a0d) }, /* TGL */
 	{ }
 };
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index d182122c261d..f256c7ca5452 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -396,17 +396,26 @@ static const struct intel_vsec_platform_info dg1_info = {
 	.quirks = VSEC_QUIRK_NO_DVSEC,
 };
 
+/* DG2 info */
+static const struct intel_vsec_platform_info dg2_info = {
+	.quirks = VSEC_QUIRK_TABLE_SHIFT
+};
+
 #ifdef CONFIG_PM_SLEEP
 static const struct dev_pm_ops intel_vsec_pm_ops = {};
 #endif
 
 #define PCI_DEVICE_ID_INTEL_VSEC_ADL		0x467d
 #define PCI_DEVICE_ID_INTEL_VSEC_DG1		0x490e
+#define PCI_DEVICE_ID_INTEL_VSEC_DG2_G10	0x4f93
+#define PCI_DEVICE_ID_INTEL_VSEC_DG2_G11	0x4f95
 #define PCI_DEVICE_ID_INTEL_VSEC_OOBMSM		0x09a7
 #define PCI_DEVICE_ID_INTEL_VSEC_TGL		0x9a0d
 static const struct pci_device_id intel_vsec_pci_ids[] = {
 	{ PCI_DEVICE_DATA(INTEL, VSEC_ADL, &tgl_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_DG1, &dg1_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_DG2_G10, &dg2_info) },
+	{ PCI_DEVICE_DATA(INTEL, VSEC_DG2_G11, &dg2_info) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_OOBMSM, NULL) },
 	{ PCI_DEVICE_DATA(INTEL, VSEC_TGL, &tgl_info) },
 	{ }
-- 
2.25.1

