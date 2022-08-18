Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BFD598582
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241881AbiHROOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245757AbiHROOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:14:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A81AE20F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660832087; x=1692368087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VI8XKvt0Ie6fJjujDnEOi8fu3pB8Ak2zVjbkujdfSnY=;
  b=PrdK6oCbLSJX0Wth/gd+/71EY1PESUlG4MEJrvYrOm50ZNptYWe+Y/fT
   C99yONsR74MQl3EKKTPwBitSxmAtol53g3HNy5VY22U6syl1p+oHCqaU3
   lqvp/dAVFb+eEYuv7+DcQSeFzyAsyoLCnRIahpBBITR3HDaULrclr8Rpi
   x26pQJ5yqS8hA9MU41Qh1npjTahyLXaH7u0N2kuB08cC/VatRjXQbnxIu
   TwUMP2FANuLi0yEQCqgt43qiKeIlC1l4biep6UWmcTtC30M6E4le4o92s
   T7Dbqmt8kK5N5KtQ9IyvMOSmPQQW417qUJy66gRmlSePBgqzRbrxg40LT
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272533265"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272533265"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 07:14:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584222242"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 07:14:45 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use macros
Date:   Thu, 18 Aug 2022 16:15:15 +0200
Message-Id: <20220818141517.109280-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
References: <20220818141517.109280-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use existing macros to poll and update register values instead of
open coding the functionality.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/hdac_stream.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f3582012d22f..bdf6d4db6769 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -165,7 +165,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_stop_streams_and_chip);
 void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
 {
 	unsigned char val;
-	int timeout;
 	int dma_run_state;
 
 	snd_hdac_stream_clear(azx_dev);
@@ -173,30 +172,17 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
 	dma_run_state = snd_hdac_stream_readb(azx_dev, SD_CTL) & SD_CTL_DMA_START;
 
 	snd_hdac_stream_updateb(azx_dev, SD_CTL, 0, SD_CTL_STREAM_RESET);
-	udelay(3);
-	timeout = 300;
-	do {
-		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
-			SD_CTL_STREAM_RESET;
-		if (val)
-			break;
-	} while (--timeout);
+
+	/* wait for hardware to report that the stream entered reset */
+	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, (val & SD_CTL_STREAM_RESET), 3, 300);
 
 	if (azx_dev->bus->dma_stop_delay && dma_run_state)
 		udelay(azx_dev->bus->dma_stop_delay);
 
-	val &= ~SD_CTL_STREAM_RESET;
-	snd_hdac_stream_writeb(azx_dev, SD_CTL, val);
-	udelay(3);
+	snd_hdac_stream_updateb(azx_dev, SD_CTL, SD_CTL_STREAM_RESET, 0);
 
-	timeout = 300;
-	/* waiting for hardware to report that the stream is out of reset */
-	do {
-		val = snd_hdac_stream_readb(azx_dev, SD_CTL) &
-			SD_CTL_STREAM_RESET;
-		if (!val)
-			break;
-	} while (--timeout);
+	/* wait for hardware to report that the stream is out of reset */
+	snd_hdac_stream_readb_poll(azx_dev, SD_CTL, val, !(val & SD_CTL_STREAM_RESET), 3, 300);
 
 	/* reset first position - may not be synced with hw at this time */
 	if (azx_dev->posbuf)
-- 
2.25.1

