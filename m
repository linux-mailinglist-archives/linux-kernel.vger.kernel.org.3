Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858C54B4296
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241170AbiBNHNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:13:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiBNHNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:13:41 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5033583BC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644822812; x=1676358812;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I7BC7uehC4gM2EkjutEKUCeYM2QbUvM4xLthNGJb+Wc=;
  b=T+sj4Ij6kIm2MAHBWd/1RslpLLzEfV80IEhchD+jdg4oinFwpGlm7/c2
   A0ScEPxmu2E4g3zhyvg5qzl8lugSPrT3/TsDZG4Wzhe9iSUYVvigvlVxD
   zb3ps/Z+sIORE7A7YW8I2E58yUWVGV+FjJOv5e39BydAkVmGsjM5y2fc3
   t3Dk/n7SNXXvV3Pc44D/aOxdA83uQLg+d8qrQ1VzA8snBIH0iweELjIek
   GreoASDthiGtnJfJA8MpAbVF11T+0yKBTU8PpsrKYiKVwL4g1rjM8Vce+
   +yc8OARznKMLe/yMpy67jbf1+K2EScPGwN3Aq7xDDRxxejexAO3bZIvet
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="237441050"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="237441050"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:13:32 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="527949550"
Received: from amrobles-mobl1.amr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.47.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:13:29 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH v2] ASoC: SOF: Makefile: Fix randconfig sof-client build when SND_SOC_SOF=y
Date:   Mon, 14 Feb 2022 09:13:30 +0200
Message-Id: <20220214071330.22151-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel's kernel test robot found the following randconfig combination:
SND_SOC_SOF=y
SND_SOC_SOF_CLIENT=m

In this the sof-client object is not going to be built into the snd-sof.o
and we will have undefined references to the sof-client functions.

Fixes: 6955d9512d0e ("ASoC: SOF: Introduce IPC SOF client support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Ujfalusi <Peter Ujfalusi <peter.ujfalusi@linux.intel.com>>
---
Hi Mark, Pierre,

Changes since v1:
- fix author and SoB from gmail.com to linux.intel.com

When the client support was added we did some permutation tests (at least I did)
but missed this combination.
It is a valid one for sure and the proper fix is via the Makefile.

Sorry for mising this

Regards,
Peter

 sound/soc/sof/Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
index 4d31282c847d..a0459f06c68a 100644
--- a/sound/soc/sof/Makefile
+++ b/sound/soc/sof/Makefile
@@ -2,7 +2,9 @@
 
 snd-sof-objs := core.o ops.o loader.o ipc.o pcm.o pm.o debug.o topology.o\
 		control.o trace.o iomem-utils.o sof-audio.o stream-ipc.o
-snd-sof-$(CONFIG_SND_SOC_SOF_CLIENT) += sof-client.o
+ifneq ($(CONFIG_SND_SOC_SOF_CLIENT),)
+snd-sof-objs += sof-client.o
+endif
 
 snd-sof-$(CONFIG_SND_SOC_SOF_COMPRESS) += compress.o
 
-- 
2.35.1

