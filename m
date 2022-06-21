Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBFCF553EC8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiFUW5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354570AbiFUW5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:57:06 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D5326C5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655852225; x=1687388225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TY0x4skZSRtNnUTitczz8XAzbhfZ1+UkCJ8XwgnmySQ=;
  b=HySxZaO7FRPlkm8UeFnMNE5EssEogiNQwOQpw8mtxdN+GU9Lml9XVfMp
   GwUZviBo/PKGT0EW45CEbx4FQ/3ZXywKz4Cbpf63gB8jf7A+dCq6K13tF
   eWcaXlAyTvmBtnJUbv9c6NI7mojOGfdc186JOsnhmyfUaTOtNFTKCpVlG
   rPDvhjc2hyS0L8hRObntVBWGRgCd2MollIwl373q4aqeSWGM+aq4iRZ+J
   wJa3CnHYjkmpaoza1Jo89NiuzZcoQGJf0S590QPvYIJPbVIeLuIlVQIuY
   tAY/TSQ6Tr4QkPZ6b3C1/0odHh8S12fQZWh12EIBtjyFBdEHI0yskd7wc
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="344250740"
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="344250740"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:57:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,210,1650956400"; 
   d="scan'208";a="914354252"
Received: from dpasupul-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.209.178.35])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 15:57:03 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org, srinivas.kandagatla@linaro.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] soundwire: intel: use pm_runtime_resume() on component probe
Date:   Tue, 21 Jun 2022 17:56:40 -0500
Message-Id: <20220621225641.221170-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
References: <20220621225641.221170-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

During the card registration, transactions on the SoundWire bus can be
initiated. If the ALSA card is registered after the bus suspends,
timeouts can be seen while reading/writing codec registers. This is
extremely easy to reproduce in driver bind/unbind tests.

In an initial experiment, the ASoC soc-component.c code was modified
to initiate a pm_runtime resume on a component probe. The results
showed this was too invasive. Instead this patch suggests resuming the
SoundWire component only.

Because of the parent-child hierarchy enforced by the pm_runtime
framework, it can be argued that the codec component probe should be
enough to resume all necessary devices, and indeed the same resume
will be applied to SoundWire codecs used on Intel platforms.

Calling pm_runtime_resume() on both the Intel and codec sides has the
benefit of resuming the bus without assuming any order during the card
registration. The first component on a dailink to be probed will
resume the bus. In addition, if a codec driver did not implement this
transition, the Intel component would still resume the bus and avoid
timeouts on card registration.

BugLink: https://github.com/thesofproject/linux/issues/3651
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 2e7c27d303b42..c907bab12ee33 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1051,6 +1051,23 @@ static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct sn
 	return ret;
 }
 
+static int intel_component_probe(struct snd_soc_component *component)
+{
+	int ret;
+
+	/*
+	 * make sure the device is pm_runtime_active before initiating
+	 * bus transactions during the card registration.
+	 * We use pm_runtime_resume() here, without taking a reference
+	 * and releasing it immediately.
+	 */
+	ret = pm_runtime_resume(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
+	return 0;
+}
+
 static int intel_component_dais_suspend(struct snd_soc_component *component)
 {
 	struct snd_soc_dai *dai;
@@ -1106,6 +1123,7 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 
 static const struct snd_soc_component_driver dai_component = {
 	.name           = "soundwire",
+	.probe		= intel_component_probe,
 	.suspend	= intel_component_dais_suspend
 };
 
-- 
2.34.1

