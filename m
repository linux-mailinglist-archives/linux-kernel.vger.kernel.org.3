Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6DF571F72
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 17:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiGLPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiGLPfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 11:35:16 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473C5F5C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657640115; x=1689176115;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0xWXv2hPnaq6dui+hkXkWYBLtudgtqDyCMY+iqKa4I=;
  b=OPe/DscDw7k+xQJFGacJA6C5kgex+gwRKfBBy1G7IlRILa6z+d8nkuRI
   VWnT6WzurXFeAMzHsukczzjqG9zgfiLXQN1plAC0UiJPj4wmGi84LRPC+
   OUlh0HGcCVSe/mPfc8FanBUlF10V3UVLLNYVklNiV3NUB+fYksfMRZLC+
   GklAoB4hEPUH2/iuYlYVz0YBHeqx2jo+eNoevTDxZuBjg21vvU58n9tym
   udqIsV9Oq/4grf91PtftZBbGbq5FgXYcHXnEUUz9HfRtNGyc39/PqhSaY
   9+Z9Nyjj7YDtS2LJuRUOk/GMSD9gqBXc9m6hseiiNmrKYUZLz4rKBX+hp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="265380204"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="265380204"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="662994045"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jul 2022 08:35:12 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3808916D; Tue, 12 Jul 2022 18:35:20 +0300 (EEST)
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
Subject: [PATCH v2 4/4] ALSA: hda: cs35l41: Consolidate selections under SND_HDA_SCODEC_CS35L41
Date:   Tue, 12 Jul 2022 18:35:19 +0300
Message-Id: <20220712153519.35692-4-andriy.shevchenko@linux.intel.com>
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

Selections can be propagated via selections, while dependencies are not.
Hence, consolidate selections under the SND_HDA_SCODEC_CS35L41 option.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
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

