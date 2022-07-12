Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F81571F71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiGLPfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiGLPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:35:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13F86459
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640115; x=1689176115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S2GftDn+xorE6UM3YzlFwuDAbmRpEb7074YgFP8dxNY=;
  b=eHDCPA9PIH2T+gCNf7q5W6kdFunWVoRsrVfkn0opvQHlmK5Em20LOqsW
   ZtRSvHHPCn8T0PDHFkw+eFdmpya5GocIVWNBJDpq6sVjUAmr8SWXNALtX
   3Tv5oQNVy/prMr2kCnBfevse446UwwSXmwbK2ZkowyUk9VUGLZbTNTB4L
   a2wt4rl1PwsAHs0a4OZO35Yaif0gr3oV1tkGkVbFxt5kaofVB6ti+RdXq
   SViMJbwD2m6EyUIuY7qglG1Gzl+7Huhr0Kd6AqPP38OrgYRdGrU0NaQJf
   wyKv38jf6XhNPCkM3nj4XjdvowdTNk8GvYiU8op8h4WjWYW7lYlbv1myG
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="268005805"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="268005805"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="771922134"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2022 08:35:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3234E18E; Tue, 12 Jul 2022 18:35:20 +0300 (EEST)
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
Subject: [PATCH v2 3/4] ALSA: hda: cs35l41: Drop wrong use of ACPI_PTR()
Date:   Tue, 12 Jul 2022 18:35:18 +0300
Message-Id: <20220712153519.35692-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
References: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
v2: no changes
 sound/pci/hda/cs35l41_hda_i2c.c | 8 +++-----
 sound/pci/hda/cs35l41_hda_spi.c | 8 +++-----
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda_i2c.c b/sound/pci/hda/cs35l41_hda_i2c.c
index ec626e0fbedc..df39fc76e6be 100644
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
 
@@ -43,19 +43,17 @@ static const struct i2c_device_id cs35l41_hda_i2c_id[] = {
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
index 3a1472e1bc24..2f5afad3719e 100644
--- a/sound/pci/hda/cs35l41_hda_spi.c
+++ b/sound/pci/hda/cs35l41_hda_spi.c
@@ -6,7 +6,7 @@
 //
 // Author: Lucas Tanure <tanureal@opensource.cirrus.com>
 
-#include <linux/acpi.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/spi/spi.h>
 
@@ -39,18 +39,16 @@ static const struct spi_device_id cs35l41_hda_spi_id[] = {
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

