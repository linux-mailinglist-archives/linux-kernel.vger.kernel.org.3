Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26E346C26E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240467AbhLGSNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:13:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:52983 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231267AbhLGSNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:41 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224513436"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224513436"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:10 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="751385219"
Received: from charriso-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.98.250])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:08 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 1/6] ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
Date:   Tue,  7 Dec 2021 11:37:40 -0600
Message-Id: <20211207173745.15850-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
References: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We allocate a structure in dpcm_be_connect(), which may be called in
atomic context. Using GFP_KERNEL is not quite right, we have to use
GFP_ATOMIC to prevent the allocator from sleeping.

Suggested-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/soc-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3b4412183344..f66808dfb508 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1113,7 +1113,7 @@ static int dpcm_be_connect(struct snd_soc_pcm_runtime *fe,
 			return 0;
 	}
 
-	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_KERNEL);
+	dpcm = kzalloc(sizeof(struct snd_soc_dpcm), GFP_ATOMIC);
 	if (!dpcm)
 		return -ENOMEM;
 
-- 
2.25.1

