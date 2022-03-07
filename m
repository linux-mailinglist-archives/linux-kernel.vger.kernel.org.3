Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33194D0297
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 16:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243366AbiCGPVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 10:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbiCGPVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 10:21:32 -0500
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501EE8D69D
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 07:20:37 -0800 (PST)
X-QQ-mid: bizesmtp90t1646666426tldfkns3
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Mar 2022 23:20:20 +0800 (CST)
X-QQ-SSF: 01400000002000C0I000B00A0000000
X-QQ-FEAT: FXvDfBZI5O5S/McaXi3cuxWk1Q1MS5RO0634j6zHeJ9soIovgRq6aHksoO4dB
        Fp+b/c1Eh+7wKGISBy/dpcDywCZoSh/PorAiLF2JoJLO/zfLzgBVRQo1jaSKywaWNMgfBmq
        udq3gkFSgNmO8wt6ba0wTPVfnJi1wxRu+JDGgGcyKcKLLmlXI9utNVYV+4Gdb01J9DOM6hi
        A+9wq3gOzss2m6x1WSlXjcatagVz19ri8Mb+WTlo/ZgI6cKrmML7DOgjmn4VWAHYVSYaogb
        /jFf5aS3soon7mlQzyf/euGpParnitMfQehTT29NK2NtN5XH0NYHDSe0vd1RzuSo/KnvyV/
        3SRYxUz/TAluAkQTabdsQUnw2K+c32319vcITKnvnSb+9v/9RI=
X-QQ-GoodBg: 2
From:   Lianjie Zhang <zhanglianjie@uniontech.com>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lianjie Zhang <zhanglianjie@uniontech.com>
Subject: [PATCH v2] ASoC: Intel: catpt: use asoc_substream_to_rtd()
Date:   Mon,  7 Mar 2022 23:19:39 +0800
Message-Id: <20220307151939.32870-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can use asoc_substream_to_rtd() macro,
let's use it.

Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>

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



