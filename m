Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9522F584915
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 02:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbiG2Aao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 20:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbiG2Aal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 20:30:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0851C11B;
        Thu, 28 Jul 2022 17:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659054640; x=1690590640;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PfTOiQjYAYYY4a2Y4a9PXwcVN7vb2TT94AIxKQoyK7c=;
  b=RSlgpR+MFUkqBjTP/YKrFBqMF10MJz05fg6MuGTCzglFMG1KrfbM2OmK
   uMgKjehd7aBmyVdLJh47MQoaxkpAc3Qx8kxJF+U0S7qfSqXmoWK9tnWNa
   VH4t43MjUmn+Lwwm/IlnGLtXvEutwqRAbMqgwxb6+Vzr3WOFxf9hzQYdg
   hmouM3eMfoMB0IZeelZhRLM1hFDQBAsPzRX6oJxCroDKYEf8gzFK0ys70
   9WneKscstfcDmJ5H01PhyO7S5Z47cL2kNNCy1e2748+mmBJtbJduMJ3Px
   fFH9DB8fj3YlBVCBZVODzc7yT5qxQyPGcALhqluCHeLP/9mZ4xIwlEPPf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="374960161"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="374960161"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 17:30:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="777370718"
Received: from uhpatel-desk4.jf.intel.com ([10.23.15.62])
  by orsmga005.jf.intel.com with ESMTP; 28 Jul 2022 17:30:40 -0700
From:   Utkarsh Patel <utkarsh.h.patel@intel.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, rajmohan.mani@intel.com,
        utkarsh.h.patel@intel.com
Subject: [PATCH] usb: typec: intel_pmc_mux: Add new ACPI ID for Meteor Lake IOM device
Date:   Thu, 28 Jul 2022 17:30:33 -0700
Message-Id: <20220729003033.771761-1-utkarsh.h.patel@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel Meteor Lake IOM uses 64bit IOM BASE address than previous Intel
Generations which use 32bit.

Added code to support 64bit IOM BASE address change with necessary ACPI
resource extraction support.

Signed-off-by: Utkarsh Patel <utkarsh.h.patel@intel.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/mux/intel_pmc_mux.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/mux/intel_pmc_mux.c b/drivers/usb/typec/mux/intel_pmc_mux.c
index 47b733f78fb0..a8e273fe204a 100644
--- a/drivers/usb/typec/mux/intel_pmc_mux.c
+++ b/drivers/usb/typec/mux/intel_pmc_mux.c
@@ -571,9 +571,11 @@ static int pmc_usb_register_port(struct pmc_usb *pmc, int index,
 
 static int is_memory(struct acpi_resource *res, void *data)
 {
-	struct resource r;
+	struct resource_win win = {};
+	struct resource *r = &win.res;
 
-	return !acpi_dev_resource_memory(res, &r);
+	return !(acpi_dev_resource_memory(res, r) ||
+		 acpi_dev_resource_address_space(res, &win));
 }
 
 /* IOM ACPI IDs and IOM_PORT_STATUS_OFFSET */
@@ -583,6 +585,9 @@ static const struct acpi_device_id iom_acpi_ids[] = {
 
 	/* AlderLake */
 	{ "INTC1079", 0x160, },
+
+	/* Meteor Lake */
+	{ "INTC107A", 0x160, },
 	{}
 };
 
-- 
2.25.1

