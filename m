Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788744D1A45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 15:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347427AbiCHOVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 09:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239822AbiCHOU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 09:20:59 -0500
Received: from smtpbg516.qq.com (smtpbg516.qq.com [203.205.250.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816104B412
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 06:19:59 -0800 (PST)
X-QQ-mid: bizesmtp72t1646749192tnj1p904
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 08 Mar 2022 22:19:45 +0800 (CST)
X-QQ-SSF: 01400000002000C0I000B00A0000000
X-QQ-FEAT: +frVms9LjlpphZQq1TQE4txJeZ4Ct3/bYc4jxNrpvjoCjzk7SUf7NebxCA01P
        SqFfMPXogaxMZBgwBM8mMxzg+qMKLZ1qcUesjS1rHrAHR731GMzCzQKkYxUgO59vdmQu4Ar
        PE91n0RUgDJpdi27EZ3cT5H2AswkNKZXnFE9lmWNBD2ELxAOO8lXE5Td5wfovy9ADqHEwJt
        eAaYj5K1fWAKnlPOR7B/cid/ne7kPk5PwZf7n3jW9xWmZGPoeqToL2BJQ8xJa+qP50eQ3Ze
        7iHHyi4SIeizTq+WIcgY59NN1Y6mhMjXJVXjMJkqGVLEzGcAyIRXTW+khgiwKF1MgWLNfVG
        7/TPmgklf/tTU3QG1FjuMVyotqLhgiWFQm+0FPg
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
Subject: [PATCH v3] ASoC: Intel: catpt: use asoc_substream_to_rtd()
Date:   Tue,  8 Mar 2022 22:19:36 +0800
Message-Id: <20220308141936.59331-1-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now we can use asoc_substream_to_rtd() macro,
let's use it.

Signed-off-by: Lianjie Zhang <zhanglianjie@uniontech.com>

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



