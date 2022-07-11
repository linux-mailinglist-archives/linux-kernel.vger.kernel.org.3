Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF0656FF61
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiGKKqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiGKKpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:45:44 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BFAEDB77
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657533150; x=1689069150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IFixV8KBTV+chD2hbw0USw+m4VI10depIHGAYgCIDEc=;
  b=MQIx2QYWVY+DDDcq6p13nLJdChN0C289KHXsvVac+LyXEHdEp9sn4TGK
   9bJob0YXGBXNVyPz7AI0xGizwdFSsamk96/GNwYWO75BtMn1HmMA06IOf
   RyhWHEWZ9Q72gtlxrxv48Bm9cpWM+WrZNakpvXGXlJ4nehNkyzNKeLRzG
   yeIXjeHRa0DCvhwgOvSmJYplxtO6EseJ13pHDJuoc+vsct8a451GQK3jJ
   NCn36SRtlaX+UGmFQzPTMpFwgIIA3fAx3hNDzFN7NOLeU//2kf1gk1t2H
   TZTDm6chkw/5FK/X72oLJgW5S7Tp4wSAmeADPlD7e5wu/uggDwIUKwxUh
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="310223440"
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="310223440"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 02:52:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="840953939"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jul 2022 02:52:18 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 73BD5AD; Mon, 11 Jul 2022 12:52:26 +0300 (EEST)
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
Subject: [PATCH v1 2/4] ALSA: hda: cs35l41: Allow compilation test on non-ACPI configurations
Date:   Mon, 11 Jul 2022 12:52:17 +0300
Message-Id: <20220711095219.36915-2-andriy.shevchenko@linux.intel.com>
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

ACPI is needed only for functioning of this codec on some platforms,
there is no compilation dependency, so make it optional

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
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

