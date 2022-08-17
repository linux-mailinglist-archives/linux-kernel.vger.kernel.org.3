Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55336596F72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiHQNL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239969AbiHQNLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:11:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B74232
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741872; x=1692277872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WeXg1qGK5oHjX2LzaydOvVCoa4HLF6ZfQTJlOzwHso0=;
  b=LLgmfgzXTcBcJx4bj3cRui32O2UX0kwAjpnnMFf/2fo0ew8TlUSCmAyR
   FTi8249vty0MakIVhnShGJXW3/6cDWOBmfKRw9oOjU2gil/vKs+aBgMbY
   hXdG8GjHAjkxJgG0XpxA2HCydMT3xhN7qGFeS14uiz5kqppfXqXtfKRG+
   aazM7cVG0SoVWBx1HgglN1lkTXyrTsgTTL0uLb433GAbkr4xOBiDnN4Y0
   ekO9PioC3z7bXVwBrkzC+6HYF8ajd7BiKD5Gz3x1EKV/4yBMOf7IhSHFu
   HII0adW7LiP9tuqK55icJuHr0uWvMkpnBMMlBzxS1fxrRZf5cGbaPuQ9H
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378779139"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378779139"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667609957"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 06:11:11 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 2/4] ALSA: hda: Rework snd_hdac_stream_reset() to use macros
Date:   Wed, 17 Aug 2022 15:11:35 +0200
Message-Id: <20220817131137.3978523-3-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
References: <20220817131137.3978523-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can use existing macros to poll and update register values instead of
open coding the functionality.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/hda/hdac_stream.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/sound/hda/hdac_stream.c b/sound/hda/hdac_stream.c
index f3582012d22f..ce6a2f270445 100644
--- a/sound/hda/hdac_stream.c
+++ b/sound/hda/hdac_stream.c
@@ -10,6 +10,7 @@
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/hdaudio.h>
+#include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
 #include "trace.h"
 
@@ -165,7 +166,6 @@ EXPORT_SYMBOL_GPL(snd_hdac_stop_streams_and_chip);
 void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
 {
 	unsigned char val;
-	int timeout;
 	int dma_run_state;
 
 	snd_hdac_stream_clear(azx_dev);
@@ -173,30 +173,17 @@ void snd_hdac_stream_reset(struct hdac_stream *azx_dev)
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

