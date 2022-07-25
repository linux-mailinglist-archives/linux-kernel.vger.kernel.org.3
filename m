Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1183B57FE21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbiGYLLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiGYLL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:11:28 -0400
Received: from sender4-op-o13.zoho.com (sender4-op-o13.zoho.com [136.143.188.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6DCB7CC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1658747433; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fW8TaQMdY65k4a6PKbwO5EvXQYUat5GJl3nk4ojQxYKztgFdxYaf+Hzzd+ScGnx0RY/pxBnIEDpHFwgGtCL6CdpzZlQH+Cfqvz/pgOM3LaBoFg1MLc5bIbv1rMTjmGGozmtprtA3Y13eoVpsfefJ6aaX8QXHz2/kSFY2UkIXxXQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1658747433; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=td2HD537TFOqVAXGmobMSbf6TwwoP0HqZ6KHlLX2n6Q=; 
        b=DvLAml3IlrBKQOcRZbveXUhmdO6ZcRNg7fPMsr428hc65vAErcS820j243ZZcuF2L9w/NHdKB+JAzukmV5woADgN74+/o4Ko51MwHVcP58lVnV7koQe/2UGEMiFDfEPyhJHHCXZg9Jd1aIeVypWZ5SQ1LXt7mQ6ncdUkcWpW/jc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1658747433;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=td2HD537TFOqVAXGmobMSbf6TwwoP0HqZ6KHlLX2n6Q=;
        b=NSK+g8lymnxFsW3NBxxSdluCZuP91qRNACJuzv0Vu4ZueHaC7FrumKdnPz6ml8Kk
        mOcm2peOuCbTo1acgIkx0CrpIBDzCHflXN3ygeXkfNmel1c/kh6vCtQrd+f3ghqU5VI
        r5NPUJo98R7/rctNerhhHYq+wPd8WsDaVe9yaQfo=
Received: from edelgard.icenowy.me (59.41.162.230 [59.41.162.230]) by mx.zohomail.com
        with SMTPS id 1658747431498424.62638727725675; Mon, 25 Jul 2022 04:10:31 -0700 (PDT)
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <uwu@icenowy.me>
Subject: [PATCH 2/2] ASoC: Intel: Skylake: try to get NHLT blob with PCM params as fallback
Date:   Mon, 25 Jul 2022 19:10:02 +0800
Message-Id: <20220725111002.143765-2-uwu@icenowy.me>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220725111002.143765-1-uwu@icenowy.me>
References: <20220725111002.143765-1-uwu@icenowy.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switching to use pipeline parameters to get NHLT blob breaks audio on
HP Chromebook 13 G1 (at least with MrChromeBox firmware).

Fix this by retrying to get NHLT blob with PCM parameters (which is the
old behavior) if pipeline parameters fail.

Fixes: 87b265260046 ("ASoC: Intel: Skylake: Select proper format for NHLT blob")
Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
---
 sound/soc/intel/skylake/skl-topology.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 19994ec8bba1..3d5a3ee1c82c 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1858,6 +1858,15 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 					pipe_fmt->bps, params->s_cont,
 					pipe_fmt->channels, pipe_fmt->freq,
 					pipe->direction, dev_type);
+	if (!cfg) {
+		/* Retry with PCM parameters, as the old behavior */
+		cfg = intel_nhlt_get_endpoint_blob(dai->dev, skl->nhlt,
+						mconfig->vbus_id, link_type,
+						params->s_fmt, params->s_cont,
+						params->ch, params->s_freq,
+						params->stream, dev_type);
+	}
+
 	if (cfg) {
 		mconfig->formats_config[SKL_PARAM_INIT].caps_size = cfg->size;
 		mconfig->formats_config[SKL_PARAM_INIT].caps = (u32 *)&cfg->caps;
@@ -1866,6 +1875,8 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 			mconfig->vbus_id, link_type, params->stream,
 			pipe_fmt->channels, pipe_fmt->freq,
 			pipe_fmt->bps);
+		dev_err(dai->dev, "PCM: ch %d, freq %d, fmt %d\n",
+			params->ch, params->s_freq, params->s_fmt);
 		return -EINVAL;
 	}
 
-- 
2.37.1

