Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F95C571F75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbiGLPfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbiGLPfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:35:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887723BE0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640118; x=1689176118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xg7I+m/llbJv+k3YKHZXCqCpZNq0T9G7xCJVVXuRPr8=;
  b=YVvyjWob8gm90/Mo8DJaPnenvNepon450Fl76RX+g9hDRx1Bx7Ulf/j1
   fOI1k6gexvROYKxyTCGBQSTimvmW8oh27Rt/q3iUUPhhkD2I0phF/JSJo
   yHobM3G7WmMxBMNa5YFEbmUYex4QdUWBvdrfGszDkxdsRop/LhWhEALSK
   bIalWKMB22kZnKXRXwwbFpQYq9ZUS3A5Bea7eMzvCvYcQCEBDJ8mWTFWf
   lU5lnrl51Ek6OBzTbS9pXjyulB082myDLN2CSym+QSh9qZa9mft846D6I
   /fambthfiOJOv7+cp70eHS5VrrWlItiF5G2dEJVZhI2nNLYsx5QTCZLNQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="371278786"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="371278786"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:35:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="698061904"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jul 2022 08:35:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 2662BD9; Tue, 12 Jul 2022 18:35:20 +0300 (EEST)
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
Subject: [PATCH v2 2/4] ALSA: hda: cs35l41: Allow compilation test on non-ACPI configurations
Date:   Tue, 12 Jul 2022 18:35:17 +0300
Message-Id: <20220712153519.35692-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
References: <20220712153519.35692-1-andriy.shevchenko@linux.intel.com>
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

ACPI is needed only for functioning of this codec on some platforms,
there is no compilation dependency, so make it optional

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 sound/pci/hda/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index 79ade4787d95..e86cf80bdf96 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -97,7 +97,7 @@ config SND_HDA_SCODEC_CS35L41
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
 	depends on I2C
-	depends on ACPI
+	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
@@ -113,7 +113,7 @@ comment "Set to Y if you want auto-loading the side codec driver"
 config SND_HDA_SCODEC_CS35L41_SPI
 	tristate "Build CS35L41 HD-audio codec support for SPI Bus"
 	depends on SPI_MASTER
-	depends on ACPI
+	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
 	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
-- 
2.35.1

