Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5804ED0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352012AbiCaAH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiCaAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:07:21 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1278B2E0BC;
        Wed, 30 Mar 2022 17:05:34 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648685133; bh=Ea0QBaJP2Xhb2qk22MNKaoz+blbZuooVi0kGOsoChyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VpQis266M9BalLOWg7P4c+68owWtkGGUriBUeUvRyIyl43yyS9AeR6+npb/uhLoFt
         cMdw2Woc8wg62T4OF3zn6GU3pC59+r9ZlLV67mAu/hz1u2cugNWW+fk+SqwpnZqlhG
         tWrI+oOjiZ4p8wuTk6iLkVWaYDX6HAojQwwwLI0o=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: [RFC PATCH 4/5] ASoC: Introduce snd_soc_of_get_dai_link_cpus
Date:   Thu, 31 Mar 2022 02:04:48 +0200
Message-Id: <20220331000449.41062-5-povik+lin@cutebit.org>
In-Reply-To: <20220331000449.41062-1-povik+lin@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function is an analogue of snd_soc_of_get_dai_link_codecs to help
machine drivers read CPU DAI lists from devicetrees.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 include/sound/soc.h  |  4 +++
 sound/soc/soc-core.c | 80 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 0ab664500b8f..0bf9d1d0768c 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1266,6 +1266,10 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 				   struct device_node *of_node,
 				   struct snd_soc_dai_link *dai_link);
 void snd_soc_of_put_dai_link_codecs(struct snd_soc_dai_link *dai_link);
+int snd_soc_of_get_dai_link_cpus(struct device *dev,
+				 struct device_node *of_node,
+				 struct snd_soc_dai_link *dai_link);
+void snd_soc_of_put_dai_link_cpus(struct snd_soc_dai_link *dai_link);
 
 int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 			    struct snd_soc_dai_link *dai_link);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0bf05d98ec0d..a97476ec01ab 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3400,6 +3400,86 @@ int snd_soc_of_get_dai_link_codecs(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_link_codecs);
 
+/*
+ * snd_soc_of_put_dai_link_cpus - Dereference device nodes in the codecs array
+ * @dai_link: DAI link
+ *
+ * Dereference device nodes acquired by snd_soc_of_get_dai_link_cpus().
+ */
+void snd_soc_of_put_dai_link_cpus(struct snd_soc_dai_link *dai_link)
+{
+	struct snd_soc_dai_link_component *component;
+	int index;
+
+	for_each_link_cpus(dai_link, index, component) {
+		if (!component->of_node)
+			break;
+		of_node_put(component->of_node);
+		component->of_node = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_put_dai_link_cpus);
+
+/*
+ * snd_soc_of_get_dai_link_cpus - Parse a list of CPU DAIs in the devicetree
+ * @dev: Card device
+ * @of_node: Device node
+ * @dai_link: DAI link
+ *
+ * Is analogous to snd_soc_of_get_dai_link_codecs but parses a list of CPU DAIs
+ * instead.
+ *
+ * Returns 0 for success
+ */
+int snd_soc_of_get_dai_link_cpus(struct device *dev,
+				 struct device_node *of_node,
+				 struct snd_soc_dai_link *dai_link)
+{
+	struct of_phandle_args args;
+	struct snd_soc_dai_link_component *component;
+	char *name;
+	int index, num_codecs, ret;
+
+	/* Count the number of CODECs */
+	name = "sound-dai";
+	num_codecs = of_count_phandle_with_args(of_node, name,
+						"#sound-dai-cells");
+	if (num_codecs <= 0) {
+		if (num_codecs == -ENOENT)
+			dev_err(dev, "No 'sound-dai' property\n");
+		else
+			dev_err(dev, "Bad phandle in 'sound-dai'\n");
+		return num_codecs;
+	}
+	component = devm_kcalloc(dev,
+				 num_codecs, sizeof(*component),
+				 GFP_KERNEL);
+	if (!component)
+		return -ENOMEM;
+	dai_link->cpus = component;
+	dai_link->num_cpus = num_codecs;
+
+	/* Parse the list */
+	for_each_link_cpus(dai_link, index, component) {
+		ret = of_parse_phandle_with_args(of_node, name,
+						 "#sound-dai-cells",
+						 index, &args);
+		if (ret)
+			goto err;
+		component->of_node = args.np;
+		ret = snd_soc_get_dai_name(&args, &component->dai_name);
+		if (ret < 0)
+			goto err;
+	}
+	return 0;
+err:
+	snd_soc_of_put_dai_link_codecs(dai_link);
+	dai_link->cpus = NULL;
+	dai_link->num_cpus = 0;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snd_soc_of_get_dai_link_cpus);
+
 static int __init snd_soc_init(void)
 {
 	snd_soc_debugfs_init();
-- 
2.33.0

