Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5258654ED09
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378660AbiFPWEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233061AbiFPWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:04:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0B60DA0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417083; x=1686953083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l2zzEpI/NGYD3sJTCPiXWhJ1G6S1YXmPElHQQZQzDlU=;
  b=NuhqOtkO67V9p5Gd3eVopnOurCAVzdDE7ME3DUXMz+/7aqpteU0BYzTy
   9BP8Rj/qyg8WOLk0CejkNptmixjhSjg0yDt4R+mjATClvEboHsk9h+VnN
   8pKFpVG5vYm8mqVVsx2/Igi1AcajMp4rtNecNZ7SJ7yakfR9UqO2A7Dd6
   XKinGqZ8w5G7vEA/FUorrb8+l8APvBUCy1KzqNeF0tpd1/5Dx0Pk6LO8E
   0gJ4WzxygL/KCEoiZlO34HIrUohc3+ee7WO5S4R5VLSES0l7efscaumYd
   37oRpM00Wiz/5srIxGdA9GWwu/ib6HHg1TIN0xf42IkdgrepthAgVyVtv
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276936411"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276936411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:43 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728084991"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.52.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 04/11] ASoC: wcd-mbhc-v2: use pm_runtime_resume_and_get()
Date:   Thu, 16 Jun 2022 17:04:20 -0500
Message-Id: <20220616220427.136036-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify the flow. No functionality change, except that on -EACCESS
the reference count will be decreased.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 31009283e7d4a..98baef594bf31 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -714,12 +714,11 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 	struct snd_soc_component *component = mbhc->component;
 	int ret;
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(component->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(component->dev);
 		return ret;
 	}
 
@@ -1097,12 +1096,11 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	mbhc = container_of(work, struct wcd_mbhc, correct_plug_swch);
 	component = mbhc->component;
 
-	ret = pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
 	if (ret < 0 && ret != -EACCES) {
 		dev_err_ratelimited(component->dev,
-				    "pm_runtime_get_sync failed in %s, ret %d\n",
+				    "pm_runtime_resume_and_get failed in %s, ret %d\n",
 				    __func__, ret);
-		pm_runtime_put_noidle(component->dev);
 		return;
 	}
 	micbias_mv = wcd_mbhc_get_micbias(mbhc);
-- 
2.34.1

