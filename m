Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0955854ED08
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378455AbiFPWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiFPWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:04:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1E75F257
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417080; x=1686953080;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8yDu8pljCT7lbter28rnZGmrSNHwi6FSg6lKKzg7Hfs=;
  b=MA+FjrAYMxkDv176CrJhQ+anztTLRxnBFMtKnr07rEO4qH1V94uED69E
   AGmP0YkfArH9ntKbURyhWiahxwykopgKK9U726XIULqnKXAuR3+pV89cf
   ehxkCE4l6Vix+Joj8HxKiONp2LfjqkSTwvvuZNEJpLkVI8K2l2J/zMEPv
   CezMeuVKa69fcnZK2x7mgzo7aq4kbiSkpOZ3tBGjUAy8eDQ5/TU5Aonza
   ggxcxWgOiglJlcTrnRh+Q8b/7z+NevtSr9FLzj56It9NihVzmAMF/GV9F
   /ogeJQfBSvDtQsToMBvwAnJceanXdKLkwpfpUicZEUXLdKJMLT3CnjTew
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276936398"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276936398"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728084970"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.52.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:39 -0700
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
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/11] ASoC: Intel: skylake: skl-pcm: use pm_runtime_resume_and_get()
Date:   Thu, 16 Jun 2022 17:04:18 -0500
Message-Id: <20220616220427.136036-3-pierre-louis.bossart@linux.intel.com>
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

The current code does not check for errors and does not release the
reference on errors.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/intel/skylake/skl-pcm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 55f310e91b55c..9d72ebd812af9 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1380,7 +1380,10 @@ static int skl_platform_soc_probe(struct snd_soc_component *component)
 	const struct skl_dsp_ops *ops;
 	int ret;
 
-	pm_runtime_get_sync(component->dev);
+	ret = pm_runtime_resume_and_get(component->dev);
+	if (ret < 0 && ret != -EACCES)
+		return ret;
+
 	if (bus->ppcap) {
 		skl->component = component;
 
-- 
2.34.1

