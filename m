Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 656D24AF475
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbiBIOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiBIOxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:53:04 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8ADC061355;
        Wed,  9 Feb 2022 06:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644418386; x=1675954386;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JcR2SqzgDfaiREjbB1UD/J9SsNencbetmBgZzpo5Kx4=;
  b=cWIAAH5LlkmwRC1PIhLXnzIZgmvRSCrIr7FUJNJdX9Jec5zkiQRv8qIY
   N99bBl9eVTvO02zjR1+N0bdydhKYSvVnCQCRYmJWgmzbw2p5Kem1JOL23
   F4Hx2iE06fNMvlrRIJIEYX4C9FCD1G1+zajCqGLeH67VfIoYBdczHrUdh
   l1zTlHa4VjrPzJd6uc/vrnLvN1S6fILV2pI7Ichu3zS0s3C42pGJoVlpM
   8YpsSN9dsqE/n1iEEZkCsM6lDttjJmskTzzc97xT2vw2ACc8JvjG05wf5
   ZcascRBbG+losQvOW/5z1U9t6g4gJVBSEDOCwI5XoD+aIvUM1x8Z7YSD7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="249167860"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="249167860"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="629294711"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2022 06:53:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E30B50D; Wed,  9 Feb 2022 16:53:19 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: property: Get rid of redundant 'else'
Date:   Wed,  9 Feb 2022 16:53:18 +0200
Message-Id: <20220209145318.83405-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the snippets like the following

	if (...)
		return / goto / break / continue ...;
	else
		...

the 'else' is redundant. Get rid of it.

While at it, replace conditional '<= 0' for unsigned type by '== 0'
in acpi_data_prop_read(); update comment in the
__acpi_node_get_property_reference() on how we parse the reference.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/property.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 4744c191acee..928aa4f86344 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -541,7 +541,8 @@ acpi_device_data_of_node(const struct fwnode_handle *fwnode)
 	if (is_acpi_device_node(fwnode)) {
 		const struct acpi_device *adev = to_acpi_device_node(fwnode);
 		return &adev->data;
-	} else if (is_acpi_data_node(fwnode)) {
+	}
+	if (is_acpi_data_node(fwnode)) {
 		const struct acpi_data_node *dn = to_acpi_data_node(fwnode);
 		return &dn->data;
 	}
@@ -739,14 +740,19 @@ int __acpi_node_get_property_reference(const struct fwnode_handle *fwnode,
 					return -EINVAL;
 			}
 
-			/* assume following integer elements are all args */
+			/*
+			 * Assume the following integer elements are all args.
+			 * Stop counting on the first reference or end of the
+			 * package arguments. In case of neither reference,
+			 * nor integer, return an error, we can't parse it.
+			 */
 			for (i = 0; element + i < end && i < num_args; i++) {
 				int type = element[i].type;
 
+				if (type == ACPI_TYPE_LOCAL_REFERENCE)
+					break;
 				if (type == ACPI_TYPE_INTEGER)
 					nargs++;
-				else if (type == ACPI_TYPE_LOCAL_REFERENCE)
-					break;
 				else
 					return -EINVAL;
 			}
@@ -938,7 +944,7 @@ static int acpi_data_prop_read(const struct acpi_device_data *data,
 
 	if (proptype != DEV_PROP_STRING && nval > obj->package.count)
 		return -EOVERFLOW;
-	else if (nval <= 0)
+	if (nval == 0)
 		return -EINVAL;
 
 	items = obj->package.elements;
@@ -1000,14 +1006,10 @@ struct fwnode_handle *acpi_get_next_subnode(const struct fwnode_handle *fwnode,
 	const struct list_head *head;
 	struct list_head *next;
 
-	if (!child || is_acpi_device_node(child)) {
+	if ((!child || is_acpi_device_node(child)) && adev) {
 		struct acpi_device *child_adev;
 
-		if (adev)
-			head = &adev->children;
-		else
-			goto nondev;
-
+		head = &adev->children;
 		if (list_empty(head))
 			goto nondev;
 
@@ -1077,7 +1079,8 @@ acpi_node_get_parent(const struct fwnode_handle *fwnode)
 	if (is_acpi_data_node(fwnode)) {
 		/* All data nodes have parent pointer so just return that */
 		return to_acpi_data_node(fwnode)->parent;
-	} else if (is_acpi_device_node(fwnode)) {
+	}
+	if (is_acpi_device_node(fwnode)) {
 		struct device *dev = to_acpi_device_node(fwnode)->dev.parent;
 
 		if (dev)
-- 
2.34.1

