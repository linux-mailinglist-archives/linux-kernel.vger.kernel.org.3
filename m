Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8AB56FF5F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiGKKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiGKKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:45:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28CEEDB7A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533150; x=1689069150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mioNk0tvPDP7UvyjGTwFiy0EVcTJtI65Soj89fFF8yE=;
  b=Io9n1Nm1mHWvcF1qN6HBh+EeOjJJIr5YcoLjUblyHrT2Y3jiIRjppDWO
   uCkvn6Bx5HaSAv3rAc+CTCIU4UY405w1TCg5NJtF4BtIJ3oax7j9O9wVt
   NS8KYHxkTv/X1Mqgliw6uV5PDcWfsjkq6esvUeOjX9cKYPmWxA8xn6zjM
   akKvqYs+K+k5nx4WRXKUZnqN0EONcgvuqE3dGlQB1S7LqL7mJW6Ib+9Aa
   6hLX4oBu04O840kEDxGiPAUJnG5fP29CbrvyyYx9dHfKd5S94xfokQ1Ss
   XS0dOMyThovsMb3i9qFw3zEdi1w6yyCIiPw3aOPVa2fPkp0zCvoPIOCaE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="264398006"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="264398006"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="737035121"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jul 2022 02:52:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7C029481; Mon, 11 Jul 2022 12:52:26 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v1 3/4] ALSA: hda: cs35l41: Drop wrong use of ACPI_PTR()
Date:   Mon, 11 Jul 2022 12:52:18 +0300
Message-Id: <20220711095219.36915-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com>
References: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACPI_PTR() is more harmful than helpful. For example, in this case
if CONFIG_ACPI=n, the ID table left unused which is not what we want.

Instead of adding ifdeffery or attribute here and there, drop ACPI_PTR().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/cs35l41_hda_i2c.c | 8 +++-----
 sound/pci/hda/cs35l41_hda_spi.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index e810b278fb91..5cfb5aac37ac 100644
--- a/sound/pci/hda/cs35l41_hda_i2c.c
+++ b/sound/pci/hda/cs35l41_hda_i2c.c
@@ -6,9 +6,9 @@
 //
 // Author: Lucas Tanure <tanureal@opensource.cirrus.com>
 
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/acpi.h>
 
 #include "cs35l41_hda.h"
 
@@ -42,19 +42,17 @@ static const struct i2c_device_id cs35l41_hda_i2c_id[] = {
 	{}
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{"CLSA0100", 0 },
 	{"CSC3551", 0 },
-	{ },
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
-#endif
 
 static struct i2c_driver cs35l41_i2c_driver = {
 	.driver = {
 		.name		= "cs35l41-hda",
-		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
+		.acpi_match_table = cs35l41_acpi_hda_match,
 	},
 	.id_table	= cs35l41_hda_i2c_id,
 	.probe		= cs35l41_hda_i2c_probe,
diff --git a/sound/pci/hda/cs35l41_hda_spi.c b/sound/pci/hda/cs35l41_hda_spi.c
index 22e088f28438..c9a61675c4fd 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -6,7 +6,7 @@
 //
 // Author: Lucas Tanure <tanureal@opensource.cirrus.com>
 
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
@@ -38,18 +38,16 @@ static const struct spi_device_id cs35l41_hda_spi_id[] = {
 	{}
 };
 
-#ifdef CONFIG_ACPI
 static const struct acpi_device_id cs35l41_acpi_hda_match[] = {
 	{ "CSC3551", 0 },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(acpi, cs35l41_acpi_hda_match);
-#endif
 
 static struct spi_driver cs35l41_spi_driver = {
 	.driver = {
 		.name		= "cs35l41-hda",
-		.acpi_match_table = ACPI_PTR(cs35l41_acpi_hda_match),
+		.acpi_match_table = cs35l41_acpi_hda_match,
 	},
 	.id_table	= cs35l41_hda_spi_id,
 	.probe		= cs35l41_hda_spi_probe,
-- 
2.35.1

