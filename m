Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416185719EA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 14:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233085AbiGLMZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 08:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiGLMZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 08:25:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A420B6DBA;
        Tue, 12 Jul 2022 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657628716; x=1689164716;
  h=from:to:cc:subject:date:message-id;
  bh=NrR8m557LkmdRR5G5crqjbGQfjqfSgnTa5G/VBrQrx4=;
  b=LItuT9Aoc0R4chST4wWLOPs2yC3TXnPExBCf/v56Ux3NA4mMjl2OuqxG
   5qJTdT7ApBm5tuAtIEznrosForKpUA6hNkuaHpP2lxEn6OYc0yd/7ZNv4
   2eMxhpWtZiFRpDXrpXlWZ0nXeqUvNlPa2CLKJveYE3Y8OsTJI+3uuP0G0
   Cyz0pbpQhwQ1BOn2GBlAr+yPEPOlwm4EfojgqJQ+DkxJiwOuMTMjev8yi
   iRBgnuct7xRi2HzRZIaPwaQI+b6qhkoC9TIyRdEIuEXHPCTZK5GyXMxIu
   l1zyokjs+TENO1QDZdDjfr1IcBbojg6VK/DF39yCo0l4AKsu0kqmkm1PT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348895023"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="348895023"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 05:25:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="570172287"
Received: from benkao-pc.itwn.intel.com ([10.5.232.139])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 05:25:14 -0700
From:   Ben Kao <ben.kao@intel.com>
To:     mathias.nyman@intel.com
Cc:     mathias.nyman@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Kao <ben.kao@intel.com>
Subject: [PATCH] xhci-pci: Enable runtime PM on Alder Lake-N PCH xHCI controller
Date:   Tue, 12 Jul 2022 20:24:42 +0800
Message-Id: <20220712122442.22504-1-ben.kao@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two Alder Lake-N xHCI host controllers with PCI IDs
0x464e and 0x54ed, now we add the quirk to default enable runtime
PM for 0x54ed.

Signed-off-by: Ben Kao <ben.kao@intel.com>
---
 drivers/usb/host/xhci-pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d34..44486156bd5d 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -61,6 +61,7 @@
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI		0x461e
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI		0x464e
 #define PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI	0x51ed
+#define PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI	0x54ed
 #define PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI		0xa71e
 #define PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI		0x7ec0
 
@@ -272,6 +273,7 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_PCH_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_INTEL_ALDER_LAKE_N_PCH_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_RAPTOR_LAKE_XHCI ||
 	     pdev->device == PCI_DEVICE_ID_INTEL_METEOR_LAKE_XHCI))
 		xhci->quirks |= XHCI_DEFAULT_PM_RUNTIME_ALLOW;
-- 
2.17.1

