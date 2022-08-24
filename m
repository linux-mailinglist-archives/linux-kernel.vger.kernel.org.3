Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BF959FF1A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiHXQHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbiHXQHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:07:25 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DFA80E82;
        Wed, 24 Aug 2022 09:07:22 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661357240; bh=aO38GJDIP/5aJG6S0vIu2Re6vO0yDujEU8aBKTpUOoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Bxm61ZEynvpzn8cGD8yFgOWSblB7WYZYp8swzU6lksYgeFKL2Psl7tZMrQrQOgrEo
         o3qi86pna0Z+tnErdiyTmXsRMS6yaSjPN4brbS0SN8OLPzluwbGpU2uGRLSkfoeim0
         6HGwKNyD5af9aDowtXFhKbnpOaCQnNKr6itIwkgM=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ASoC: apple: mca: Add locking
Date:   Wed, 24 Aug 2022 18:07:15 +0200
Message-Id: <20220824160715.95779-5-povik+lin@cutebit.org>
In-Reply-To: <20220824160715.95779-1-povik+lin@cutebit.org>
References: <20220824160715.95779-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 sound/soc/apple/mca.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/apple/mca.c b/sound/soc/apple/mca.c
index 807b85469408..aa67d57c9a9b 100644
--- a/sound/soc/apple/mca.c
+++ b/sound/soc/apple/mca.c
@@ -158,6 +158,9 @@ struct mca_data {
 	struct reset_control *rstc;
 	struct device_link *pd_link;
 
+	/* Mutex for accessing port_driver of foreign clusters */
+	struct mutex port_mutex;
+
 	int nclusters;
 	struct mca_cluster clusters[];
 };
@@ -296,16 +299,21 @@ static bool mca_fe_clocks_in_use(struct mca_cluster *cl)
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
 
@@ -349,6 +357,11 @@ static int mca_be_hw_free(struct snd_pcm_substream *substream,
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
@@ -721,7 +734,9 @@ static int mca_be_startup(struct snd_pcm_substream *substream,
 		       cl->base + REG_PORT_CLOCK_SEL);
 	writel_relaxed(PORT_DATA_SEL_TXA(fe_cl->no),
 		       cl->base + REG_PORT_DATA_SEL);
+	mutex_lock(&mca->port_mutex);
 	cl->port_driver = fe_cl->no;
+	mutex_unlock(&mca->port_mutex);
 	cl->port_started[substream->stream] = true;
 
 	return 0;
@@ -731,6 +746,7 @@ static void mca_be_shutdown(struct snd_pcm_substream *substream,
 			    struct snd_soc_dai *dai)
 {
 	struct mca_cluster *cl = mca_dai_to_cluster(dai);
+	struct mca_data *mca = cl->host;
 
 	cl->port_started[substream->stream] = false;
 
@@ -741,7 +757,9 @@ static void mca_be_shutdown(struct snd_pcm_substream *substream,
 		 */
 		writel_relaxed(0, cl->base + REG_PORT_ENABLES);
 		writel_relaxed(0, cl->base + REG_PORT_DATA_SEL);
+		mutex_lock(&mca->port_mutex);
 		cl->port_driver = -1;
+		mutex_unlock(&mca->port_mutex);
 	}
 }
 
@@ -962,6 +980,7 @@ static int apple_mca_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	mca->dev = &pdev->dev;
 	mca->nclusters = nclusters;
+	mutex_init(&mca->port_mutex);
 	platform_set_drvdata(pdev, mca);
 	clusters = mca->clusters;
 
-- 
2.33.0

