Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD12C4D1E27
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbiCHRJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiCHRJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:09:48 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C2636305;
        Tue,  8 Mar 2022 09:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646759332; x=1678295332;
  h=from:to:cc:subject:date:message-id;
  bh=R0CDGnvApoSO1gfn9j+YZMCQMFxsSEmVfmtBoWiu+Qw=;
  b=S5ceqGltaeFtsuLCkCWcq1CU6lm58G8qp3DcNfKNZe2xngHbgFXK+Vzb
   YOxt3IJwein2lAKXqMsOe1a/yCqcf87Ud6CWKxlgLSL51XXxNnYXeItDk
   Im4kbNNa25FkUyu0QgHTblfapkjQY8M6p2MMthC84g7QR1UIX1uFXUGvD
   Rq8BMLaUfuGh80VcRWyyD6lTr46hhVONpGmiO3yZ8zEZmigZsllJX9+M2
   egta+QvEcoje0c6k2fjnvkYZhd26zvq6ZAWTWAmSVeoaZ6/YwRR5sqXuJ
   lY0M2QOrhudGFu7JGGKmMljaWm0qKw+HiWJ5TJm/UuIc7U/ft4EPnGyFU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235352219"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="235352219"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 09:08:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="641822768"
Received: from gio-01395267462.iind.intel.com ([10.49.4.124])
  by fmsmga002.fm.intel.com with ESMTP; 08 Mar 2022 09:08:49 -0800
From:   shruthi.sanil@intel.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, srikanth.thokala@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH] usb: dwc3: pci: Add support for Intel Alder Lake
Date:   Tue,  8 Mar 2022 22:38:48 +0530
Message-Id: <20220308170848.30722-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

Add the PCI device ID and update the dwc3_pci_id_table
for Intel Alder Lake SoC.

The DWC3 controllor in the CPU block handles the USB3 traffic
and the device ID is common across the Alder Lake platforms.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Shruthi Sanil <shruthi.sanil@intel.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 06d0e88ec8af..d8b9798fc7d4 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -40,6 +40,7 @@
 #define PCI_DEVICE_ID_INTEL_TGPLP		0xa0ee
 #define PCI_DEVICE_ID_INTEL_TGPH		0x43ee
 #define PCI_DEVICE_ID_INTEL_JSP			0x4dee
+#define PCI_DEVICE_ID_INTEL_ADL			0x465e
 #define PCI_DEVICE_ID_INTEL_ADLP		0x51ee
 #define PCI_DEVICE_ID_INTEL_ADLM		0x54ee
 #define PCI_DEVICE_ID_INTEL_ADLS		0x7ae1
@@ -412,6 +413,9 @@ static const struct pci_device_id dwc3_pci_id_table[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_JSP),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 
+	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADL),
+	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
+
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_ADLP),
 	  (kernel_ulong_t) &dwc3_pci_intel_swnode, },
 

base-commit: ea4424be16887a37735d6550cfd0611528dbe5d9
-- 
2.17.1

