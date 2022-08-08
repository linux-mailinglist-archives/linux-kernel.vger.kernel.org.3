Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD73D58CF82
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 23:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244152AbiHHVMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 17:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiHHVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 17:12:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9099917AB0;
        Mon,  8 Aug 2022 14:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659993124; x=1691529124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZtSgYuDbaBj2/G6ilDZHPwxBLmBXYG5l1URDjs2uSy8=;
  b=kFMPbR5TriyGjb3UWxUu5t/nDq33BTLkr0BKWbU34uFCFUqz6pEBGtuz
   r0MtPcLD1mtY7HW3EzqEzrQXlJTefRPK4gm1sf7g6QaU1G1yA6SiDy+6+
   k+VHGKQgWuPXXQovByTOKsyGF2eCf6CEARealBfIxWa+v0JZF3ZR1FbdO
   aTOXwEnyhW+sw7UCHziDJd4dpgapkxLefd+bU8/RUc5zHPclf4dwk2D61
   xYEdLqIQwWswRZW+MvKOR4bM0t+3nqbR20oTGdf9w8SG+jb60mSidB64C
   5OQBskGD7+kji/UFLEjn460dr9P3uinxaknap6T8OV11fkpzM40QExQ+v
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352420977"
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="352420977"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:11:51 -0700
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="601225610"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 14:11:50 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id F16BD202EA;
        Tue,  9 Aug 2022 00:11:47 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.94.2)
        (envelope-from <sakari.ailus@linux.intel.com>)
        id 1oLA2n-004QVL-Ac; Tue, 09 Aug 2022 00:12:13 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-acpi@vger.kernel.org, lkp@lists.01.org, lkp@intel.com,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH 1/1] ACPI: property: Fix error handling in acpi_init_properties()
Date:   Tue,  9 Aug 2022 00:12:13 +0300
Message-Id: <20220808211213.1055148-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buf.pointer, memory for storing _DSD data and nodes, was released if either
parsing properties or, as recently added, attaching data node tags failed.
Alas, properties were still left pointing to this memory if parsing
properties were successful but attaching data node tags failed.

Fix this by separating error handling for the two, and leaving properties
intact if data nodes cannot be tagged for a reason or another.

Reported-by: kernel test robot <oliver.sang@intel.com>
Fixes: 1d52f10917a7 ("ACPI: property: Tie data nodes to acpi handles")
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
Hi Rafael,

This should fix the immediate problem. It needs to be figured out why data
node tagging doesn't work sometimes but that can wait.

 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 9711482014a6..201a5a9b2671 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -566,13 +566,13 @@ void acpi_init_properties(struct acpi_device *adev)
 					&adev->data, acpi_fwnode_handle(adev)))
 		adev->data.pointer = buf.pointer;
 
-	if (!adev->data.pointer ||
-	    !acpi_tie_nondev_subnodes(&adev->data)) {
-		acpi_untie_nondev_subnodes(&adev->data);
+	if (!adev->data.pointer) {
 		acpi_handle_debug(adev->handle, "Invalid _DSD data, skipping\n");
 		ACPI_FREE(buf.pointer);
+	} else {
+		if (!acpi_tie_nondev_subnodes(&adev->data))
+			acpi_untie_nondev_subnodes(&adev->data);
 	}
-
  out:
 	if (acpi_of && !adev->flags.of_compatible_ok)
 		acpi_handle_info(adev->handle,
-- 
2.30.2

