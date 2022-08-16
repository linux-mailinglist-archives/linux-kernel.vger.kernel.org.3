Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2025959A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbiHPLPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235406AbiHPLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:15:27 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E03974E11;
        Tue, 16 Aug 2022 03:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660644992; x=1692180992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zUPqg/E6WJ3Fq2O6W3oFh9h+ZOs8adLY8vipG0PDk0=;
  b=jyva4G3NI+lIsqimwh2EBMfSVs57p9C/NLr0alaoz39fAxsZuG59BEEI
   76b9qlJcfkysP89FXVWyb3s4HJoSXL72pGff/bmh581gz4mJQa5t0Aik1
   7pQdtExqNen1eyQ5Zvzsk4oSfoE6I/gqyIWeVtUIrGbj+lbDKOpxJs6wf
   hbL3YLyu94kfsxdynkUV+kx2AqN9XkpF6onCg1bYIa4VKk0tzBvdk77o9
   1OEbV3NJIlUINe6c6Gk5E/PEpKxVM/bNH0J2WybdYXNMltI2YJ5XRb+O9
   FwNsD26Wv2g7EHubpQSPpFIQ42FAJJXzkVKaI3/CS+yaVZz8H+f/LDBrF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="279141273"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="279141273"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:16:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="749260771"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 16 Aug 2022 03:16:24 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Utkarsh Patel <utkarsh.h.patel@intel.com>, rajmohan.mani@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 3/6] ACPI: resource: Add helper function acpi_dev_get_memory_resources()
Date:   Tue, 16 Aug 2022 13:16:26 +0300
Message-Id: <20220816101629.69054-4-heikki.krogerus@linux.intel.com>
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

Wrapper function that finds all memory type resources by
using acpi_dev_get_resources(). It removes the need for the
drivers to check the resource data type separately.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/resource.c | 17 +++++++++++++++++
 include/linux/acpi.h    |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index e644e90d18847..8032d50ca9441 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -721,6 +721,23 @@ int acpi_dev_get_dma_resources(struct acpi_device *adev, struct list_head *list)
 }
 EXPORT_SYMBOL_GPL(acpi_dev_get_dma_resources);
 
+/**
+ * acpi_dev_get_memory_resources - Get current memory resources of a device.
+ * @adev: ACPI device node to get the resources for.
+ * @list: Head of the resultant list of resources (must be empty).
+ *
+ * This is a helper function that locates all memory type resources of @adev
+ * with acpi_dev_get_resources().
+ *
+ * The number of resources in the output list is returned on success, an error
+ * code reflecting the error condition is returned otherwise.
+ */
+int acpi_dev_get_memory_resources(struct acpi_device *adev, struct list_head *list)
+{
+	return acpi_dev_get_resources(adev, list, is_memory, NULL);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_get_memory_resources);
+
 /**
  * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
  *				   types
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc547..ed4aa395cc49b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -506,6 +506,7 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
 			   void *preproc_data);
 int acpi_dev_get_dma_resources(struct acpi_device *adev,
 			       struct list_head *list);
+int acpi_dev_get_memory_resources(struct acpi_device *adev, struct list_head *list);
 int acpi_dev_filter_resource_type(struct acpi_resource *ares,
 				  unsigned long types);
 
-- 
2.35.1

