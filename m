Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471174B0B7D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiBJKz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 05:55:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbiBJKzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 05:55:24 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F1FC24
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 02:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644490526; x=1676026526;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azAEAI0Fg/kGZ09zLDIdo+Wl6+JUyPmAKn9bATV4jtU=;
  b=WY3A/Bcr4LB2Oke1WV4hFpfE81F+S6cXboCrCRWmGV6MWEs1voKXZe6a
   1ioqE117y9TNdyDmnGn+tiFfy+Dk/nEJpu077SxYeBgcJ+Pe+x7qCKhZ/
   fOvQeB8YrRkyj0MMPQV3if8XN27FmyZ8g2b+/bu+vlMPdVT9/NQSUvNMR
   PV+A71/oyyvd24WBzqNIgIb2YDMJMqnBE1paB8zuFns9Kbq2ZrvN9G7u+
   Ty3pWAQqQeTrX44F7C3FcoOjiDZrCsiFe91WUNm+IOPSF/iTxUxcdu000
   MshkyxlHs8Eocpv5beWsYjyGC/hkeLJxdHdV5OtigYbf8yObqW2tQd+cx
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="310202829"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="310202829"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="679106841"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 02:55:23 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH 1/9] ASoC: SOF: Drop unused DSP power states: D3_HOT and D3_COLD
Date:   Thu, 10 Feb 2022 12:55:11 +0200
Message-Id: <20220210105519.19795-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
References: <20220210105519.19795-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only reference to D3_HOT and D3_COLD DSP power state is in
intel/hda-dsp.c in form of a dev_dbg() print.

Remove them as they are not used and even if they are they could be
re-added via the substate.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/hda-dsp.c | 6 ------
 sound/soc/sof/sof-priv.h      | 2 --
 2 files changed, 8 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 0fe522549c91..8ddde60c56b3 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -498,15 +498,9 @@ static void hda_dsp_state_log(struct snd_sof_dev *sdev)
 	case SOF_DSP_PM_D2:
 		dev_dbg(sdev->dev, "Current DSP power state: D2\n");
 		break;
-	case SOF_DSP_PM_D3_HOT:
-		dev_dbg(sdev->dev, "Current DSP power state: D3_HOT\n");
-		break;
 	case SOF_DSP_PM_D3:
 		dev_dbg(sdev->dev, "Current DSP power state: D3\n");
 		break;
-	case SOF_DSP_PM_D3_COLD:
-		dev_dbg(sdev->dev, "Current DSP power state: D3_COLD\n");
-		break;
 	default:
 		dev_dbg(sdev->dev, "Unknown DSP power state: %d\n",
 			sdev->dsp_power_state.state);
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index e48402ce4bdb..6358f8c84cce 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -84,9 +84,7 @@ enum sof_dsp_power_states {
 	SOF_DSP_PM_D0,
 	SOF_DSP_PM_D1,
 	SOF_DSP_PM_D2,
-	SOF_DSP_PM_D3_HOT,
 	SOF_DSP_PM_D3,
-	SOF_DSP_PM_D3_COLD,
 };
 
 struct sof_dsp_power_state {
-- 
2.35.1

