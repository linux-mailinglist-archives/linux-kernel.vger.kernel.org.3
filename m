Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B5059858B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 16:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343491AbiHROOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 10:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245638AbiHROOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 10:14:46 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0FFA4B3C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 07:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660832085; x=1692368085;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kzzNDnHHoacYqckwuIDXKHWBTJTer+bxj1MMqeY0Ku8=;
  b=UMzhqTrl35rHZOyPMEzRubeL2D0zRCnlEMglzNkN6MCtEbuJged62/eF
   U39tvqd3nlGDduxijFZt+8wt2ICaemIP6/69LTAQJKnyTGThVMuRPRkyx
   3Plh2upNAx+giTISWztOlq3OoaC+AZpqd+8wI67GLzYcVOFNAJeuII50q
   jVnYk2oeHeqszEJRf9W7pAFvl40mu+gP3MPMhkemNWG5bQVpqxKZOzBxl
   Q1KDmq3Bu2TS9k73TTPkiZFz741fLG25kfXQOKRQL8C5+ap2MisrjxXdE
   1yTmuRG7LjUuQX/fuM3DN0rm+lh+Dkc5VcJYIvdxTUEaDG+VfqDpm2non
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10443"; a="272533259"
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="272533259"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2022 07:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,246,1654585200"; 
   d="scan'208";a="584222226"
Received: from dev2.igk.intel.com ([10.237.148.94])
  by orsmga006.jf.intel.com with ESMTP; 18 Aug 2022 07:14:43 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2 1/4] ALSA: hda: Move stream-register polling macros
Date:   Thu, 18 Aug 2022 16:15:14 +0200
Message-Id: <20220818141517.109280-2-amadeuszx.slawinski@linux.intel.com>
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

Polling stream registers doesn't really have anything to do with
extended HDA registers, so move it to basic HDA header. This will allow
for use in HDA framework.

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hdaudio.h     | 7 +++++++
 include/sound/hdaudio_ext.h | 6 ------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 797bf67a164d..6e74aeafeda4 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -10,6 +10,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/iopoll.h>
 #include <linux/pm_runtime.h>
 #include <linux/timecounter.h>
 #include <sound/core.h>
@@ -589,6 +590,12 @@ int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
 	snd_hdac_reg_readw((dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
 #define snd_hdac_stream_readb(dev, reg) \
 	snd_hdac_reg_readb((dev)->bus, (dev)->sd_addr + AZX_REG_ ## reg)
+#define snd_hdac_stream_readb_poll(dev, reg, val, cond, delay_us, timeout_us) \
+	readb_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
+			   delay_us, timeout_us)
+#define snd_hdac_stream_readl_poll(dev, reg, val, cond, delay_us, timeout_us) \
+	readl_poll_timeout((dev)->sd_addr + AZX_REG_ ## reg, val, cond, \
+			   delay_us, timeout_us)
 
 /* update a register, pass without AZX_REG_ prefix */
 #define snd_hdac_stream_updatel(dev, reg, mask, val) \
diff --git a/include/sound/hdaudio_ext.h b/include/sound/hdaudio_ext.h
index d26234f9ee46..03634ea198d0 100644
--- a/include/sound/hdaudio_ext.h
+++ b/include/sound/hdaudio_ext.h
@@ -188,12 +188,6 @@ void snd_hdac_ext_bus_link_power(struct hdac_device *codec, bool enable);
 #define snd_hdac_adsp_readq_poll(chip, reg, val, cond, delay_us, timeout_us) \
 	readq_poll_timeout((chip)->dsp_ba + (reg), val, cond, \
 			   delay_us, timeout_us)
-#define snd_hdac_stream_readb_poll(strm, reg, val, cond, delay_us, timeout_us) \
-	readb_poll_timeout((strm)->sd_addr + AZX_REG_ ## reg, val, cond, \
-			   delay_us, timeout_us)
-#define snd_hdac_stream_readl_poll(strm, reg, val, cond, delay_us, timeout_us) \
-	readl_poll_timeout((strm)->sd_addr + AZX_REG_ ## reg, val, cond, \
-			   delay_us, timeout_us)
 
 struct hdac_ext_device;
 
-- 
2.25.1

