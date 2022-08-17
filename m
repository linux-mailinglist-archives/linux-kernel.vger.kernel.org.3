Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B49596F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236899AbiHQNLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239957AbiHQNLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:11:12 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EE8E5D
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660741871; x=1692277871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PQrMNQ/yvxjBTfA2wtMDXqk4o7bSOW6yITOwfe9v8m4=;
  b=WTtzD+Ayu5aXg03f86ZkjwEN/neVCIrmvUUO68IrsvJyE9WzrummZ8GX
   Ai7y6dr/kIbqM6DFk7vu0M6sxV0CG9G94pJDGAMgdIRDcRIyr/18CyBjS
   8jXT5meB1u596ywVLhD6XQPZMJz+uBExNdw+X0g0Dn/xfNCdhUykILrbA
   vQklxpBhKY6SsEJ/Cq0frrvGkE1Webbj37QD0rt54EZaZyxR8c8WsNjK1
   yxvHmS5HGE84TmUut+UL1KyvzpsvdAGUCDWlUz4Ee/xi54E5GNTaO199x
   wOUJQPaZHTnnSqDJh5eVRy+BWyZdacKVxYyJdXfQLXr21Vns3YeDtNMGY
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10442"; a="378779131"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="378779131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 06:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="667609948"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2022 06:11:09 -0700
From:   =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 1/4] ALSA: hda: Move stream-register polling macros
Date:   Wed, 17 Aug 2022 15:11:34 +0200
Message-Id: <20220817131137.3978523-2-amadeuszx.slawinski@linux.intel.com>
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

Polling stream registers doesn't really have anything to do with
extended HDA registers, so move it to basic HDA header. This will allow
for use in HDA framework.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hdaudio.h     | 6 ++++++
 include/sound/hdaudio_ext.h | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 797bf67a164d..a46708b2d8ea 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -589,6 +589,12 @@ int snd_hdac_get_stream_stripe_ctl(struct hdac_bus *bus,
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

