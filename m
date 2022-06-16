Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C97F54ED06
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 00:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiFPWEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 18:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378196AbiFPWEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 18:04:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53715F257
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655417081; x=1686953081;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EB2/ghYX0CjgXaTRz9Ew0BwzZE1/EU2YhFYqdXMaUyA=;
  b=dKBUuQelFb5vTZ2EPUa8NaFKdyQPJQi6iopFuqo2C60gptfIgWqzVRiV
   vcg5Vl+E/7J26u6VM539r1OuIuSIxPTTQH9bwH1GUpdvgiXdTo26BIdEx
   gV4SfH7n4D8g4itibCpp+ceNLyrsjGAseuPhyIGKrYy8ZWc7PboH+UDUw
   oAY98eVCq4N7KeJdZUqA7tXg5OvUDAsrzedaQTtdAqH0s39WcizbETo2e
   +i0FdDQlkCm0h2rYj0fvujXpuqIsSPh+Hn4gIRBQJjcIQSkN+/ie6muKS
   KTUIL+f9EDwnyGfAOf/gJvnQbQ/gSmlVEXqAH+oIkVurOkbJ+TUESf+zi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="276936402"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="276936402"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="728084980"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.52.70])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 15:04:40 -0700
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
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 03/11] ASoC: soc-component: use pm_runtime_resume_and_get()
Date:   Thu, 16 Jun 2022 17:04:19 -0500
Message-Id: <20220616220427.136036-4-pierre-louis.bossart@linux.intel.com>
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
 sound/soc/soc-component.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-component.c b/sound/soc/soc-component.c
index e12f8244242b9..cb92e002c38bc 100644
--- a/sound/soc/soc-component.c
+++ b/sound/soc/soc-component.c
@@ -1213,11 +1213,11 @@ int snd_soc_pcm_component_pm_runtime_get(struct snd_soc_pcm_runtime *rtd,
 	int i;
 
 	for_each_rtd_components(rtd, i, component) {
-		int ret = pm_runtime_get_sync(component->dev);
-		if (ret < 0 && ret != -EACCES) {
-			pm_runtime_put_noidle(component->dev);
+		int ret = pm_runtime_resume_and_get(component->dev);
+
+		if (ret < 0 && ret != -EACCES)
 			return soc_component_ret(component, ret);
-		}
+
 		/* mark stream if succeeded */
 		soc_component_mark_push(component, stream, pm);
 	}
-- 
2.34.1

