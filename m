Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D28050DFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiDYMQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiDYMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:16:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CA4193D4;
        Mon, 25 Apr 2022 05:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650888825; x=1682424825;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+/qh612LBKatRiWstzGf4VFJepxi//hEf4y18HWsw28=;
  b=G78c213x5XVYJIlYGlsGvdym8Pfrt0a3uEw1EB3mGg+GEy2J2lGYcYAM
   F3LIr8vzVlTHPu3mlzdreRlw7PPQdhtWXiBIUYhIo8H+mQtMvj15eeoMf
   fhsh/Otu2JZoXI9aAgbjVF9MzJqtN2CFSOSnYpsOcyoDuWG4FIJHVinJl
   a8TO2qiZXCJJfK4Yx8brKCkdz1iKAo0gzmK2/LZ+3XWXGNDJbo3vmYv6T
   CUk2Y0GNbPmryUYRyY6UIc1Q1WPPWKqcL/qBIfR15UYxq7yJX/VjARJCT
   N68N6vfUaS2ErkwBibK08oljgeTaamjXE0yWsaMBvslVmhDHttw8qncR4
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="351676968"
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="351676968"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 05:13:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,288,1643702400"; 
   d="scan'208";a="704535988"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 25 Apr 2022 05:13:43 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] usb: core: acpi: Use the sysdev pointer instead of controller device
Date:   Mon, 25 Apr 2022 15:13:39 +0300
Message-Id: <20220425121340.1362-2-heikki.krogerus@linux.intel.com>
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

The controller device (hcd) does not always have the ACPI
companion assigned to it at all. We can not rely on it when
finding the ACPI companion for the root hub. Instead we need
to use the sysdev pointer here.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb-acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index bb1da35eb891e..fbaf5045507bb 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -206,7 +206,7 @@ usb_acpi_find_companion_for_device(struct usb_device *udev)
 
 	if (!udev->parent) {
 		/* root hub is only child (_ADR=0) under its parent, the HC */
-		adev = ACPI_COMPANION(udev->dev.parent);
+		adev = ACPI_COMPANION(udev->bus->sysdev);
 		return acpi_find_child_device(adev, 0, false);
 	}
 
-- 
2.35.1

