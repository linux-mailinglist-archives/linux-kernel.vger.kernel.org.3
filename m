Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92D65958F8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 12:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbiHPKur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbiHPKuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 06:50:19 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62ECC11C37;
        Tue, 16 Aug 2022 03:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644995; x=1692180995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CZpVmaySJKsjTz2SEFDxIwCpiRQ3ZlOuaduB9ahdSIc=;
  b=XjpaOGbUhv+FoCa3Jjs4AVyUEo6Mx88MuwmuI8up35fif3k/FaBxcBPE
   nyLhzyxOusvvS1Zo23TFU3WKX67xjVwHZyok14U2AWnzg7gROOveGZ5VH
   uQP6aPDvWwwmP3wek4Qc5O/ZOP66gn/a8PfBAGqIB3ZmeFiD/bFAuNf+P
   mzJvmvZlAjAtw8EDgqsCKOve/U/BrfcYbzPNlbRqwEdlrED0DueXNPL+E
   ZxRf+K4ok3uAq3NvxWAxNNfPIfBPCB886smpuKm2AM0/AqF/6N92HPIY1
   kE7xL4b2pj+PVZCtXZH+WMo7DelhLY5odAm3xCO/GAadPuQrLQdR+qehp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279141292"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279141292"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:16:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="749260787"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 03:16:29 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>, rajmohan.mani@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 5/6] ACPI: LPSS: Use the helper acpi_dev_get_memory_resources()
Date:   Tue, 16 Aug 2022 13:16:28 +0300
Message-Id: <20220816101629.69054-6-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
References: <20220816101629.69054-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It removes the need to check the resource data type
separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c4d4d21391d7b..4f6cba8fe8def 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -392,13 +392,6 @@ static const struct acpi_device_id acpi_lpss_device_ids[] = {
 
 #ifdef CONFIG_X86_INTEL_LPSS
 
-static int is_memory(struct acpi_resource *res, void *not_used)
-{
-	struct resource r;
-
-	return !acpi_dev_resource_memory(res, &r);
-}
-
 /* LPSS main clock device. */
 static struct platform_device *lpss_clk_dev;
 
@@ -659,7 +652,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&resource_list);
-	ret = acpi_dev_get_resources(adev, &resource_list, is_memory, NULL);
+	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0)
 		goto err_out;
 
-- 
2.35.1

