Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856ED4B427C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241268AbiBNHID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:08:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241257AbiBNHIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:08:01 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A07B57B3D
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644822474; x=1676358474;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zRwIjWadERt36ALUSui8bA9C99V5TX7zIVkUucu64Fk=;
  b=kARk2L75EgygpKjUlKJStPO6T7Hbbdr7hx75DLG4hCKyJ9YF3dlkwEUv
   tSsHueHgwVOKktJiDC5xb+mPpxz5zWc3+OXEkz0EQEJSfgwBkfbn9HD16
   7jLcnM5c6llx8iyJkpIxlC+ymtTfyB1NQ5fI+c7N3wko1XzdN+cthR1u7
   qU/IrQOOKGdc/rhWjZS/QJKkFatVktDlEX2BQthOsaOZJfieqxVo3M3AC
   ++l9zuIRJW7cLNEgHVIIikVXKfT86OaCO49kAkp4Ohvd6Z73cO4yTVLF+
   HU9coh+H92VyudDGUkIpplszhXn8MKdYiBcTnJROF9SksvMTE4pi/8INO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249778422"
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="249778422"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:07:53 -0800
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="543255797"
Received: from amrobles-mobl1.amr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.249.47.75])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 23:07:51 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH] ASoC: SOF: Makefile: Fix randconfig sof-client build when SND_SOC_SOF=y
Date:   Mon, 14 Feb 2022 09:07:52 +0200
Message-Id: <20220214070752.21063-1-peter.ujfalusi@linux.intel.com>
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

From: Peter Ujfalusi <peter.ujfalusi@gmail.com>

Intel's kernel test robot found the following randconfig combination:
SND_SOC_SOF=y
SND_SOC_SOF_CLIENT=m

In this the sof-client object is not going to be built into the snd-sof.o
and we will have undefined references to the sof-client functions.

Fixes: 6955d9512d0e ("ASoC: SOF: Introduce IPC SOF client support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
---
Hi Mark, Pierre,

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

