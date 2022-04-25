Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D54050DFC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240638AbiDYMRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiDYMQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:16:52 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD452193D4;
        Mon, 25 Apr 2022 05:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650888828; x=1682424828;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RcJmmFSAKdqn8rkcY+jzES/FkuNtJTKacj4WSDA1mlk=;
  b=jCoGipE7TF3n3TcKDqsZRuHsclpMm4YqjI722TktxxQiEfNJwYZh+WyT
   NjbCENSh+I9W1mRpuBKnsWNQkGMwCPzohaXdURI92J1iom7yyL8PTqMcH
   jRSz7mwB5dVQ9mB7cHgIHmVWDKVYqAioB8kxW9TtJM29OgHyY+m5ixlvb
   WYUM2gCVQdMa3dty1wdtQT9Mzxlni07F+RZda+RAISGW866iM2ehopRHc
   trRVYOEFEXd047pnAph5OUJ3rM4Be/ub9YJhMUv7BP99Uoe0uFcuyKhck
   0Lvm+HWDG1bZkhtEgJ5OXb3ZSnTjZRaHLC/ylKbH3VCToJ00ck0sk1QcT
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351676973"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="351676973"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:13:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704535997"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:13:45 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] usb: dwc3: host: Stop setting the ACPI companion
Date:   Mon, 25 Apr 2022 15:13:40 +0300
Message-Id: <20220425121340.1362-3-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425121340.1362-1-heikki.krogerus@linux.intel.com>
References: <20220425121340.1362-1-heikki.krogerus@linux.intel.com>
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

It is no longer needed. The sysdev pointer is now used when
assigning the ACPI companions to the xHCI ports and USB
devices.

Assigning the ACPI companion here resulted in the
fwnode->secondary pointer to be replaced also for the parent
dwc3 device since the primary fwnode (the ACPI companion)
was shared. That was unintentional and it created potential
side effects like resource leaks.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index eda871973d6cc..f56c30cf151e4 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -7,7 +7,6 @@
  * Authors: Felipe Balbi <balbi@ti.com>,
  */
 
-#include <linux/acpi.h>
 #include <linux/irq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -83,7 +82,6 @@ int dwc3_host_init(struct dwc3 *dwc)
 	}
 
 	xhci->dev.parent	= dwc->dev;
-	ACPI_COMPANION_SET(&xhci->dev, ACPI_COMPANION(dwc->dev));
 
 	dwc->xhci = xhci;
 
-- 
2.35.1

