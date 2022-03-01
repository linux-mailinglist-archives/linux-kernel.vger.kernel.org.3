Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A074D4C813D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiCACuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiCACuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:50:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9E4831E;
        Mon, 28 Feb 2022 18:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646102962; x=1677638962;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BKrCzA0DUWytFgTFvZI0tuJIcbREVqqSnKKBEdoNKwU=;
  b=io4vaYUAvhipK1PO3OoHUX+GJ7Q4ZqHvaKTcKMgAhK+bIiQ1fheDUifk
   fC5qb0BpWNNYLIWXaCXxi4Wse1qnMpzbpHbdDO2MOJkXysJQ3OzlI3EbS
   W9NHF4bsl+g9cma62NBNGVGommdnzv+V0onN803DelAdckPjNy5iiU8YD
   rTPH3UUy4IoIFfKAy20G0ZGoP9Qumh0EuwFsXfQsPMkmqTk1W3gRFYqZK
   38/SwP9b+CGVnDXZOBW7wt8HdUgAUPNFfpaPqaspp2CHsFjtyJFBI/TdU
   4lOjzUzieQpYYFwbv/wfauHbbbxKamP9yc9DaIFr1UDK3C4XMs7nBCHUy
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339474599"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339474599"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="778310473"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 18:49:22 -0800
Subject: [PATCH 06/11] cxl/acpi: Add a lock class for the root platform
 device
From:   Dan Williams <dan.j.williams@intel.com>
To:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Mon, 28 Feb 2022 18:49:22 -0800
Message-ID: <164610296214.2682974.9364719321216244746.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164610292916.2682974.12924748003366352335.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the device-core can start validating lockdep usage after the
device has been added, use that capability to validate usage of
device_lock() against the ACPI0017 device relative to other subsystem
locks.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Cc: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c |    1 +
 drivers/cxl/cxl.h  |    3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 37bc8d787999..7fa7bf6088cd 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -313,6 +313,7 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
+	device_set_lock_class(&pdev->dev, CXL_ROOT_LOCK);
 	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
 	if (IS_ERR(root_port))
 		return PTR_ERR(root_port);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f94eff659cce..5179b6bb1b36 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -496,9 +496,9 @@ struct cxl_nvdimm *cxl_find_nvdimm(struct cxl_memdev *cxlmd);
 #define __mock static
 #endif
 
-#ifdef CONFIG_PROVE_CXL_LOCKING
 enum cxl_lock_class {
 	CXL_ANON_LOCK,
+	CXL_ROOT_LOCK,
 	CXL_NVDIMM_LOCK,
 	CXL_NVDIMM_BRIDGE_LOCK,
 	CXL_PORT_LOCK = 2,
@@ -510,6 +510,7 @@ enum cxl_lock_class {
 	 */
 };
 
+#ifdef CONFIG_PROVE_CXL_LOCKING
 static inline int clamp_lock_class(struct device *dev, int lock_class)
 {
 	if (lock_class >= MAX_LOCKDEP_SUBCLASSES) {

