Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBD4C7D8F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 23:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiB1Wk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 17:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiB1WkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 17:40:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609C6125C84;
        Mon, 28 Feb 2022 14:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646087969; x=1677623969;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gs5S60D5Gva7TQIgAcoMKq8XEKYr+M9gys943f6RNt8=;
  b=lzBM+l3suF2ilW8kMY/iVGgnaBdlqsDUaq0wpzejCGPlgnTkPScGnDrJ
   C/WfV+JAL0PJ4l11WFly/Zn6aH9yUlPgjDWomZkJso366kFU6WSxIMWn2
   TAD70otaFG1f6u39p1jY0xUjfAvRMp2ocfvK/WvlJos4/gxvmh3zR8qDB
   RcO+5psQJzS3NU/lXvTSejPL1yJBBV7nfGhJDQg+nITLt0kWXlyX1TXDD
   N2dXLoR55guVngRL5qOz2BStoSM4w7WPaLLZtr2o60jut8RvKCgkkl4qB
   jdX488GjD5fLH21ruRpg+RPIAUL9JAvmu232AVtfc7RdIJaEt0pnM82Sh
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="316219519"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="316219519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 14:39:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="639150677"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2022 14:39:27 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D08A24C; Tue,  1 Mar 2022 00:39:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 6/7] ACPI: enumeration: Unify Package () for properties
Date:   Tue,  1 Mar 2022 00:39:35 +0200
Message-Id: <20220228223936.54310-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
References: <20220228223936.54310-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify Package () representation for properties:
 - make them one line where it's possible
 - add spaces between parentheses and curly braces
 - drop the explicit size of package

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 93fdc04de9c3..2e0cffb88d67 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -167,8 +167,7 @@ The table below shows an example of its usage::
         Name (_DSD, Package () {
             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
             Package () {
-                Package () {"interrupt-names",
-                Package (2) {"default", "alert"}},
+                Package () { "interrupt-names", Package () { "default", "alert" } },
             }
         ...
         })
@@ -193,7 +192,7 @@ Here is what the ACPI namespace for a SPI slave might look like::
 	Device (EEP0)
 	{
 		Name (_ADR, 1)
-		Name (_CID, Package() {
+		Name (_CID, Package () {
 			"ATML0025",
 			"AT25",
 		})
@@ -365,8 +364,8 @@ For example::
 			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 			Package ()
 			{
-				Package () {"power-gpios", Package() {^DEV, 0, 0, 0 }},
-				Package () {"irq-gpios", Package() {^DEV, 1, 0, 0 }},
+				Package () { "power-gpios", Package () { ^DEV, 0, 0, 0 } },
+				Package () { "irq-gpios", Package () { ^DEV, 1, 0, 0 } },
 			}
 		})
 		...
@@ -488,10 +487,10 @@ namespace link::
 	Device (TMP0)
 	{
 		Name (_HID, "PRP0001")
-		Name (_DSD, Package() {
+		Name (_DSD, Package () {
 			ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
 			Package () {
-				Package (2) { "compatible", "ti,tmp75" },
+				Package () { "compatible", "ti,tmp75" },
 			}
 		})
 		Method (_CRS, 0, Serialized)
-- 
2.34.1

