Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A14A59BD26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbiHVJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233690AbiHVJwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:52:53 -0400
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5B32982F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:52:49 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1661161966; bh=vlMP781/oXy0hq0r4ltXOAMB3iba6lm5wXlI3u78Kgw=;
        h=From:To:Cc:Subject:Date;
        b=f7I3ouv1HuHUcHG2reTt21c57K0g62OrI/HNlNy7838nkBYjVjP8isR/FQU00B6Vg
         5xsWVT7cICDooy/rVlSEz/t84v2/r5P8254lrPDzBqDzuoLNKPNC2bmfZLdb9XvW11
         7CRTyQ6hTgcBIANPVcqLZTCy/7Ptxca9/yEsS0JM=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH] ASoC: dapm: Export new 'graph.dot' file in debugfs
Date:   Mon, 22 Aug 2022 11:52:42 +0200
Message-Id: <20220822095242.3779-1-povik+lin@cutebit.org>
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

Provide a DOT summary of the DAPM graph in a newly added 'graph.dot'
file in debugfs, placed in the card's DAPM directory.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---

Sample output: https://cutebit.org/macaudio-j274.svg
(With unupstreamed sound drivers on Mac mini (2020))

The helper bufprintf macro triggers checkpath.pl:

ERROR: Macros with complex values should be enclosed in parentheses
#47: FILE: sound/soc/soc-dapm.c:2235:
+#define bufprintf(...) \
+               ret += scnprintf(buf + ret, bufsize - ret, __VA_ARGS__)

but adding in {} to the macro body interferes with the if/else
constructions later, so I left it as-is.

 sound/soc/soc-dapm.c | 141 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 73b8bd452ca7..86524908c3fd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2210,6 +2210,143 @@ static const struct file_operations dapm_bias_fops = {
 	.llseek = default_llseek,
 };
 
+static ssize_t dapm_graph_read_file(struct file *file, char __user *user_buf,
+				    size_t count, loff_t *ppos)
+{
+	struct snd_soc_card *card = file->private_data;
+	struct snd_soc_dapm_context *dapm;
+	struct snd_soc_dapm_path *p;
+	struct snd_soc_dapm_widget *w;
+	struct snd_soc_pcm_runtime *rtd;
+	struct snd_soc_dapm_widget *wdone[16];
+	struct snd_soc_dai *dai;
+	int i, num_wdone = 0, cluster = 0;
+	char *buf;
+	ssize_t bufsize;
+	ssize_t ret = 0;
+
+	bufsize = 1024 * card->num_dapm_widgets;
+	buf = kmalloc(bufsize, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	mutex_lock(&card->dapm_mutex);
+
+#define bufprintf(...) \
+		ret += scnprintf(buf + ret, bufsize - ret, __VA_ARGS__)
+
+	bufprintf("digraph dapm {\n");
+	bufprintf("label=\"%s\";\n", card->name);
+
+	/*
+	 * Print the user-visible PCM devices of the card.
+	 */
+	bufprintf("subgraph cluster_%d {\n", cluster++);
+	bufprintf("label=\"PCM devices\";style=filled;fillcolor=lightgray;\n");
+	for_each_card_rtds(card, rtd) {
+		if (rtd->dai_link->no_pcm)
+			continue;
+
+		bufprintf("w%pK [label=\"%d: %s\"];\n", rtd,
+			  rtd->pcm->device, rtd->dai_link->name);
+	}
+	bufprintf("};\n");
+
+	/*
+	 * Print the playback/capture widgets of CPU-side DAIs, and link
+	 * them to the PCM devices. Keep a list of already printed
+	 * widgets in 'wdone', so they will be skipped later. Do not put
+	 * these widgets in a component cluster like we will do with
+	 * the other widgets later, since that just clutters the graph.
+	 */
+	for_each_card_rtds(card, rtd) {
+		for_each_rtd_cpu_dais(rtd, i, dai) {
+			if (dai->playback_widget) {
+				w = dai->playback_widget;
+				bufprintf("w%pK [label=\"%s\"];\n", w, w->name);
+				if (!rtd->dai_link->no_pcm)
+					bufprintf("w%pK -> w%pK;\n", rtd, w);
+				wdone[num_wdone] = w;
+				if (num_wdone < ARRAY_SIZE(wdone))
+					num_wdone++;
+			}
+
+			if (dai->capture_widget) {
+				w = dai->capture_widget;
+				bufprintf("w%pK [label=\"%s\"];\n", w, w->name);
+				if (!rtd->dai_link->no_pcm)
+					bufprintf("w%pK -> w%pK;\n", w, rtd);
+				wdone[num_wdone] = w;
+				if (num_wdone < ARRAY_SIZE(wdone))
+					num_wdone++;
+			}
+		}
+	}
+
+	for_each_card_dapms(card, dapm) {
+		const char *prefix = soc_dapm_prefix(dapm);
+
+		if (dapm != &card->dapm) {
+			bufprintf("subgraph cluster_%d {\n", cluster++);
+			if (prefix && dapm->component)
+				bufprintf("label=\"%s (%s)\";\n", prefix,
+					  dapm->component->name);
+			else if (dapm->component)
+				bufprintf("label=\"%s\";\n",
+					  dapm->component->name);
+		}
+
+		for_each_card_widgets(dapm->card, w) {
+			const char *name = w->name;
+			bool skip = false;
+
+			if (w->dapm != dapm)
+				continue;
+
+			if (list_empty(&w->edges[0]) && list_empty(&w->edges[1]))
+				continue;
+
+			for (i = 0; i < num_wdone; i++)
+				if (wdone[i] == w)
+					skip = true;
+			if (skip)
+				continue;
+
+			if (prefix && strlen(name) > strlen(prefix) + 1)
+				name += strlen(prefix) + 1;
+
+			bufprintf("w%pK [label=\"%s\"];\n", w, name);
+		}
+
+		if (dapm != &card->dapm)
+			bufprintf("}\n");
+	}
+
+	list_for_each_entry(p, &card->paths, list) {
+		if (p->name)
+			bufprintf("w%pK -> w%pK [label=\"%s\"];\n",
+				  p->source, p->sink, p->name);
+		else
+			bufprintf("w%pK -> w%pK;\n", p->source, p->sink);
+	}
+
+	bufprintf("}\n");
+#undef bufprintf
+
+	mutex_unlock(&card->dapm_mutex);
+
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
+
+	kfree(buf);
+	return ret;
+}
+
+static const struct file_operations dapm_graph_fops = {
+	.open = simple_open,
+	.read = dapm_graph_read_file,
+	.llseek = default_llseek,
+};
+
 void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 	struct dentry *parent)
 {
@@ -2220,6 +2357,10 @@ void snd_soc_dapm_debugfs_init(struct snd_soc_dapm_context *dapm,
 
 	debugfs_create_file("bias_level", 0444, dapm->debugfs_dapm, dapm,
 			    &dapm_bias_fops);
+
+	if (dapm == &dapm->card->dapm)
+		debugfs_create_file("graph.dot", 0444, dapm->debugfs_dapm,
+				    dapm->card, &dapm_graph_fops);
 }
 
 static void dapm_debugfs_add_widget(struct snd_soc_dapm_widget *w)
-- 
2.33.0

