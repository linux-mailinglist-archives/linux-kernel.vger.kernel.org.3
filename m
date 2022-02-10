Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED9E4B1140
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 16:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243389AbiBJPFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 10:05:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbiBJPFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 10:05:32 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53D1C53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644505533; x=1676041533;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=azAEAI0Fg/kGZ09zLDIdo+Wl6+JUyPmAKn9bATV4jtU=;
  b=U/RXdM5U5T3CqTmXokNLmdhFVfW44DCdOT8ELrqM3brmPaMoOJ17SJv9
   LG+FHN5xErNYf4IVYGq2X0+tyNNegZrMpQCakLYif3m08qf3ql7SOcIkL
   uSfmkdNiN229Q8Opya9NsHAG5KqO8X95JtPy8sosLRNeQvqazF6YF+zej
   EejuHL+jK3lEvEHFaDFdBZ1taHQ9gYkl9gDXo2YrDkQ9OrGTMdi2U/B6t
   akoRQ2CZqpEGjfHUjMMs7FIGiPyhyOEku+o+tQIgLtDq9u01olj1AdKgp
   wajNfMlQcmraWRLEBlaoYIl0X51dyz4wi4rk5xbEHDwwMHQf4GAzZU6O3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="230153184"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="230153184"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="500422556"
Received: from barabano-mobl.ccr.corp.intel.com (HELO pujfalus-desk.ger.corp.intel.com) ([10.252.41.18])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 07:05:30 -0800
From:   Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To:     lgirdwood@gmail.com, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        ranjani.sridharan@linux.intel.com
Cc:     alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, tiwai@suse.com,
        linux-kernel@vger.kernel.org, fred.oh@linux.intel.com
Subject: [PATCH v2 1/9] ASoC: SOF: Drop unused DSP power states: D3_HOT and D3_COLD
Date:   Thu, 10 Feb 2022 17:05:17 +0200
Message-Id: <20220210150525.30756-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
References: <20220210150525.30756-1-peter.ujfalusi@linux.intel.com>
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

