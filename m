Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E901D56FF60
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiGKKqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiGKKp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:45:56 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8D7EDB59
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533158; x=1689069158;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3N262QoHq7zgv+1D1IpRmJMMCOTGj2506vH+/IAwPgk=;
  b=iA0SfUDEsDLCpQSrOYdDTR3P+N9EjH7koASMW0m2BBnX+uweYEr39GmX
   cbHQ/Eh2ASGM4ShzLDw9autz7hgefdWp8cWHbv2p/UL8pqEgBhT6Zx8H3
   YvVxiYnJbfb+Hh/K5oVbY0NdaWNc4qnkXAlisF3Gp4Hyab1qp6wjhxf7q
   zHQeEUe382ih2Wi+uB6XoxTTb9eTh2Zt9VnQgekE/PNbXu6b844g0XcpB
   c/qwWzUcRdcAyAMYIHG/07d1Vn9xzAJswXP/djI5OV5jNIj0/uJPV3i9M
   gKL9jIOehI+oIFBr4fvEBG6eL/xRi/fFcveqIKgMoNAjHP3wSqamF52F8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310223441"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310223441"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840953940"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 02:52:19 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 85029400; Mon, 11 Jul 2022 12:52:26 +0300 (EEST)
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
Subject: [PATCH v1 4/4] ALSA: hda: cs35l41: Consolidate selections under SND_HDA_SCODEC_CS35L41
Date:   Mon, 11 Jul 2022 12:52:19 +0300
Message-Id: <20220711095219.36915-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com>
References: <20220711095219.36915-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selections can be propagated via selections, while dependencies are not.
Hence, consolidate selections under the SND_HDA_SCODEC_CS35L41 option.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/hda/Kconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
index e86cf80bdf96..8b73a12d356f 100644
--- a/sound/pci/hda/Kconfig
+++ b/sound/pci/hda/Kconfig
@@ -93,16 +93,16 @@ config SND_HDA_PATCH_LOADER
 
 config SND_HDA_SCODEC_CS35L41
 	tristate
+	select SND_HDA_GENERIC
+	select REGMAP_IRQ
 
 config SND_HDA_SCODEC_CS35L41_I2C
 	tristate "Build CS35L41 HD-audio side codec support for I2C Bus"
 	depends on I2C
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
-	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
-	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 I2C HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
@@ -115,10 +115,8 @@ config SND_HDA_SCODEC_CS35L41_SPI
 	depends on SPI_MASTER
 	depends on ACPI || COMPILE_TEST
 	depends on SND_SOC
-	select SND_HDA_GENERIC
 	select SND_SOC_CS35L41_LIB
 	select SND_HDA_SCODEC_CS35L41
-	select REGMAP_IRQ
 	help
 	  Say Y or M here to include CS35L41 SPI HD-audio side codec support
 	  in snd-hda-intel driver, such as ALC287.
-- 
2.35.1

