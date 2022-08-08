Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6971858D040
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiHHWnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbiHHWnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:43:02 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3285167E8
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 15:43:00 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1659998578; bh=aQrCd+ijZmlO1Kgsm6C6rwa65AVL97zN0C3e6zixLi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DiIM2ZSDHO+5xRGl9iDX/udWRADomI2tu+BybuCkpI19KgpSGU89WsAHxovyXE0Ah
         g+ErzsGRNeNXpTMl1lmrKQso5rqM8P0AzrKMDWTXjucDNpQ3aYJGEOGUUW2j+r85Gr
         fzgKJ/0j82AmKlTVa5mrjzO13NgdfuWy2cxdpivY=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     asahi@lists.linux.dev, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ASoC: apple: mca: Add locks on foreign cluster access
Date:   Tue,  9 Aug 2022 00:41:53 +0200
Message-Id: <20220808224153.3634-4-povik+lin@cutebit.org>
In-Reply-To: <20220808224153.3634-1-povik+lin@cutebit.org>
References: <20220808224153.3634-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In DAI ops, accesses to the native cluster (of the DAI), and to data of
clusters related to it by a DPCM frontend-backend link, should have
been synchronized by the 'pcm_mutex' lock at ASoC level.

What is not covered are the 'port_driver' accesses on foreign clusters
to which the current cluster has no a priori relation, so fill in
locking for that. (This should only matter in bizarre configurations of
sharing one MCA peripheral between ASoC cards.)

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 sound/soc/apple/mca.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index ab41fd1a2444..1e2464e89d1c 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -159,6 +159,9 @@ struct mca_data {
 	struct reset_control *rstc;
 	struct device_link *pd_link;
 
+	/* Mutex for accessing port_driver of foreign clusters */
+	struct mutex port_mutex;
+
 	int nclusters;
 	struct mca_cluster clusters[];
 };
@@ -297,16 +300,21 @@ static bool mca_fe_clocks_in_use(struct mca_cluster *cl)
 	struct mca_cluster *be_cl;
 	int stream, i;
 
+	mutex_lock(&mca->port_mutex);
 	for (i = 0; i < mca->nclusters; i++) {
 		be_cl = &mca->clusters[i];
 
 		if (be_cl->port_driver != cl->no)
 			continue;
 
-		for_each_pcm_streams(stream)
-			if (be_cl->clocks_in_use[stream])
+		for_each_pcm_streams(stream) {
+			if (be_cl->clocks_in_use[stream]) {
+				mutex_unlock(&mca->port_mutex);
 				return true;
+			}
+		}
 	}
+	mutex_unlock(&mca->port_mutex);
 	return false;
 }
 
@@ -331,8 +339,10 @@ static int mca_be_prepare(struct snd_pcm_substream *substream,
 	 */
 	if (!mca_fe_clocks_in_use(fe_cl)) {
 		ret = mca_fe_enable_clocks(fe_cl);
-		if (ret < 0)
+		if (ret < 0) {
+			mutex_unlock(&mca->port_mutex);
 			return ret;
+		}
 	}
 
 	cl->clocks_in_use[substream->stream] = true;
@@ -350,6 +360,11 @@ static int mca_be_hw_free(struct snd_pcm_substream *substream,
 	if (cl->port_driver < 0)
 		return -EINVAL;
 
+	/*
+	 * We are operating on a foreign cluster here, but since we
+	 * belong to the same PCM, accesses should have been
+	 * synchronized at ASoC level.
+	 */
 	fe_cl = &mca->clusters[cl->port_driver];
 	if (!mca_fe_clocks_in_use(fe_cl))
 		return 0; /* Nothing to do */
@@ -722,7 +737,9 @@ static int mca_be_startup(struct snd_pcm_substream *substream,
 		       cl->base + REG_PORT_CLOCK_SEL);
 	writel_relaxed(PORT_DATA_SEL_TXA(fe_cl->no),
 		       cl->base + REG_PORT_DATA_SEL);
+	mutex_lock(&mca->port_mutex);
 	cl->port_driver = fe_cl->no;
+	mutex_unlock(&mca->port_mutex);
 	cl->port_started[substream->stream] = true;
 
 	return 0;
@@ -732,6 +749,7 @@ static void mca_be_shutdown(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct mca_cluster *cl = mca_dai_to_cluster(dai);
+	struct mca_data *mca = cl->host;
 
 	cl->port_started[substream->stream] = false;
 
@@ -742,7 +760,9 @@ static void mca_be_shutdown(struct snd_pcm_substream *substream,
 		 */
 		writel_relaxed(0, cl->base + REG_PORT_ENABLES);
 		writel_relaxed(0, cl->base + REG_PORT_DATA_SEL);
+		mutex_lock(&mca->port_mutex);
 		cl->port_driver = -1;
+		mutex_unlock(&mca->port_mutex);
 	}
 }
 
@@ -963,6 +983,7 @@ static int apple_mca_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	mca->dev = &pdev->dev;
 	mca->nclusters = nclusters;
+	mutex_init(&mca->port_mutex);
 	platform_set_drvdata(pdev, mca);
 	clusters = mca->clusters;
 
-- 
2.33.0

