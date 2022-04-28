Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9795513223
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 13:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiD1LOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 07:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345450AbiD1LOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 07:14:15 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC66822285;
        Thu, 28 Apr 2022 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651144260; x=1682680260;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=StGSaSQuy2V6GyOeOth2NP+ywOMsMkMTCUwknyBndeU=;
  b=icsMHYL16hRmrqz6a/jryn4S2dUmgc/6oDqLf12yO3HvJCR97/dmj18F
   KzW3fTiwgVsu2FzqBf19CHT11bluz0SnfRHyX7yruxuY1hxs9KhcYOF/+
   JqPjFQ499kZ85ERooEOPNItaO4Za4zdFt3F6lzV16s+g4nZ3LBXHpLCdz
   KLs60HGHI8aUtpTlogQpfgAWi1VlmIaszr7/Vux/RDVQdVjyhNepCkSK7
   Kdrus3m3cewtFvvBZ43ErBUBSGEiKM2rD2sQEBTZjzVCeV81pJPLFaYyg
   LpnD8hpp8pUB6JuoYUErF8eH9deSuTb3hqByzl3k6BvTj/MPZSD092KT4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="291414542"
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="291414542"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 04:11:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,295,1643702400"; 
   d="scan'208";a="706011959"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 28 Apr 2022 04:10:58 -0700
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usb: core: acpi: Use the sysdev pointer instead of controller device
Date:   Thu, 28 Apr 2022 14:10:55 +0300
Message-Id: <20220428111056.3558-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428111056.3558-1-heikki.krogerus@linux.intel.com>
References: <20220428111056.3558-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controller device (hcd) does not always have the ACPI
companion assigned to it at all. We can not rely on it when
finding the ACPI companion for the root hub. Instead we need
to use the sysdev pointer.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/core/usb-acpi.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-acpi.c
index bb1da35eb891e..d4dcaefd0ea40 100644
--- a/drivers/usb/core/usb-acpi.c
+++ b/drivers/usb/core/usb-acpi.c
@@ -205,8 +205,11 @@ usb_acpi_find_companion_for_device(struct usb_device *udev)
 	struct usb_hub *hub;
 
 	if (!udev->parent) {
-		/* root hub is only child (_ADR=0) under its parent, the HC */
-		adev = ACPI_COMPANION(udev->dev.parent);
+		/*
+		 * root hub is only child (_ADR=0) under its parent, the HC.
+		 * sysdev pointer is the HC as seen from firmware.
+		 */
+		adev = ACPI_COMPANION(udev->bus->sysdev);
 		return acpi_find_child_device(adev, 0, false);
 	}
 
-- 
2.35.1

