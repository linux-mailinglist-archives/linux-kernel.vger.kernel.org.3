Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D2B4CE4EC
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiCEMwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiCEMwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:52:20 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB9775C37
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:51:26 -0800 (PST)
X-QQ-mid: bizesmtp90t1646484673tmmsihaa
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Mar 2022 20:51:08 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000000A0000000
X-QQ-FEAT: GiB59JtT4hAixvUU2qMoUK1jxRaTIQvQpwNoHAYOtAikGp4o7FujPsm4KBCi+
        uVQPuReEEfBKYprwtvfCTYJs5343XjPZY3W2QVV+JWWaMPx0guzNqRTPAMYx6Rp58oRc4Qy
        XdgY/PXb+IZhSwYshdtwFPgWq8tfStviCNxVXMLeOI0zc9hzZUt/89SWqZx/GJsbWsHaRvI
        bSK/lbPRwInv6hWY/wfJ6rY9NBPjWTq98g2GWfGbdihVmt1UXD8rDEDnxxSnv6kJI3k+oAh
        LxS/966DoHhRMeTB8/XwlQ0Z7t03Z/473ci74uTPQekaGGSF5HjDJbKaQPDCvv6Jw+KAd8e
        PWXuDcRZER2Ot/R0Fc=
X-QQ-GoodBg: 1
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH] ASoC: intel: use asoc_substream_to_rtd()
Date:   Sat,  5 Mar 2022 20:51:05 +0800
Message-Id: <20220305125105.142704-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can use asoc_substream_to_rtd() macro,
let's use it.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
index 939a9b801dec..a26000cd5ceb 100644
--- a/sound/soc/intel/catpt/pcm.c
+++ b/sound/soc/intel/catpt/pcm.c
@@ -74,7 +74,7 @@ static struct catpt_stream_template *catpt_topology[] = {
 static struct catpt_stream_template *
 catpt_get_stream_template(struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtm = substream->private_data;
+	struct snd_soc_pcm_runtime *rtm = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtm, 0);
 	enum catpt_stream_type type;

@@ -593,7 +593,7 @@ static int catpt_component_pcm_construct(struct snd_soc_component *component,
 static int catpt_component_open(struct snd_soc_component *component,
 				struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtm = substream->private_data;
+	struct snd_soc_pcm_runtime *rtm = asoc_substream_to_rtd(substream);

 	if (!rtm->dai_link->no_pcm)
 		snd_soc_set_runtime_hwparams(substream, &catpt_pcm_hardware);
@@ -604,7 +604,7 @@ static snd_pcm_uframes_t
 catpt_component_pointer(struct snd_soc_component *component,
 			struct snd_pcm_substream *substream)
 {
-	struct snd_soc_pcm_runtime *rtm = substream->private_data;
+	struct snd_soc_pcm_runtime *rtm = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtm, 0);
 	struct catpt_stream_runtime *stream;
 	struct catpt_dev *cdev = dev_get_drvdata(component->dev);
--
2.20.1



