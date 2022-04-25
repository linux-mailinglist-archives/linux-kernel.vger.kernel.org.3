Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2050DF51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbiDYLu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbiDYLtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:49:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0519403E9;
        Mon, 25 Apr 2022 04:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650887150; x=1682423150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0uWssjamdHsdBJb0mJxNHp980sMj8oaZK4dFrIaGODA=;
  b=O6fvJyLX/LoP7NVXhrlrrRvoULxfnINf9BTfFIO3U+mdX/rggeYr4wRp
   mkUPJ/1Tps6z0Wo2zYnbhFhreGUBbG0PppiRQSFzfMYBpY2sp+s6mJ2Og
   Ex8YEznGNE+1hzdv5DOpfT3hm2YAeXidhPecuNkd1LZ3q+YztKhG+ooMR
   uRzQg1OAuiaHJbWSAFMJz/nNs50vzyeamXfeB7yFNrGF7uKoGZiGDnMto
   LqKC8T5TXLvz9MjkXXwr/HkBDhmtqfRjYYJt598eXPMdc2X4yBccAOXR/
   f8Cb6frdEo3CuswDlZXBGqBVgcWb1NWbMTbfLbXPlIRxuRaGcMAJ95297
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="264075351"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="264075351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 04:45:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704526088"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 04:45:48 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 2/2] acpi: Remove the helper for deactivating memory region
Date:   Mon, 25 Apr 2022 14:45:44 +0300
Message-Id: <20220425114544.37595-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
References: <20220425114544.37595-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no more users for acpi_release_memory().

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/osl.c   | 86 --------------------------------------------
 include/linux/acpi.h |  3 --
 2 files changed, 89 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7a70c4bfc23c6..3269a888fb7a9 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -36,7 +36,6 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "acpica/accommon.h"
-#include "acpica/acnamesp.h"
 #include "internal.h"
 
 /* Definitions for ACPI_DEBUG_PRINT() */
@@ -1496,91 +1495,6 @@ int acpi_check_region(resource_size_t start, resource_size_t n,
 }
 EXPORT_SYMBOL(acpi_check_region);
 
-static acpi_status acpi_deactivate_mem_region(acpi_handle handle, u32 level,
-					      void *_res, void **return_value)
-{
-	struct acpi_mem_space_context **mem_ctx;
-	union acpi_operand_object *handler_obj;
-	union acpi_operand_object *region_obj2;
-	union acpi_operand_object *region_obj;
-	struct resource *res = _res;
-	acpi_status status;
-
-	region_obj = acpi_ns_get_attached_object(handle);
-	if (!region_obj)
-		return AE_OK;
-
-	handler_obj = region_obj->region.handler;
-	if (!handler_obj)
-		return AE_OK;
-
-	if (region_obj->region.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY)
-		return AE_OK;
-
-	if (!(region_obj->region.flags & AOPOBJ_SETUP_COMPLETE))
-		return AE_OK;
-
-	region_obj2 = acpi_ns_get_secondary_object(region_obj);
-	if (!region_obj2)
-		return AE_OK;
-
-	mem_ctx = (void *)&region_obj2->extra.region_context;
-
-	if (!(mem_ctx[0]->address >= res->start &&
-	      mem_ctx[0]->address < res->end))
-		return AE_OK;
-
-	status = handler_obj->address_space.setup(region_obj,
-						  ACPI_REGION_DEACTIVATE,
-						  NULL, (void **)mem_ctx);
-	if (ACPI_SUCCESS(status))
-		region_obj->region.flags &= ~(AOPOBJ_SETUP_COMPLETE);
-
-	return status;
-}
-
-/**
- * acpi_release_memory - Release any mappings done to a memory region
- * @handle: Handle to namespace node
- * @res: Memory resource
- * @level: A level that terminates the search
- *
- * Walks through @handle and unmaps all SystemMemory Operation Regions that
- * overlap with @res and that have already been activated (mapped).
- *
- * This is a helper that allows drivers to place special requirements on memory
- * region that may overlap with operation regions, primarily allowing them to
- * safely map the region as non-cached memory.
- *
- * The unmapped Operation Regions will be automatically remapped next time they
- * are called, so the drivers do not need to do anything else.
- */
-acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
-				u32 level)
-{
-	acpi_status status;
-
-	if (!(res->flags & IORESOURCE_MEM))
-		return AE_TYPE;
-
-	status = acpi_walk_namespace(ACPI_TYPE_REGION, handle, level,
-				     acpi_deactivate_mem_region, NULL,
-				     res, NULL);
-	if (ACPI_FAILURE(status))
-		return status;
-
-	/*
-	 * Wait for all of the mappings queued up for removal by
-	 * acpi_deactivate_mem_region() to actually go away.
-	 */
-	synchronize_rcu();
-	rcu_barrier();
-	flush_scheduled_work();
-
-	return AE_OK;
-}
-EXPORT_SYMBOL_GPL(acpi_release_memory);
-
 /*
  * Let drivers know whether the resource checks are effective
  */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index d7136d13aa442..fadda404bcc9b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -520,9 +520,6 @@ int acpi_check_resource_conflict(const struct resource *res);
 int acpi_check_region(resource_size_t start, resource_size_t n,
 		      const char *name);
 
-acpi_status acpi_release_memory(acpi_handle handle, struct resource *res,
-				u32 level);
-
 int acpi_resources_are_enforced(void);
 
 #ifdef CONFIG_HIBERNATION
-- 
2.35.1

