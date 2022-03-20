Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB96F4E1A60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 07:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244799AbiCTGYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 02:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiCTGX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 02:23:57 -0400
Received: from smtp.smtpout.orange.fr (smtp09.smtpout.orange.fr [80.12.242.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88B511DD32
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 23:22:33 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id VoxRnDXVQAWDQVoxRnHo6V; Sun, 20 Mar 2022 07:22:31 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 20 Mar 2022 07:22:31 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: topology: Avoid open coded arithmetic in memory allocation
Date:   Sun, 20 Mar 2022 07:22:26 +0100
Message-Id: <3bbf03cfd1966bc6fb6dd0939e039fc161078a61.1647757329.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kcalloc() instead of kzalloc()+open coded multiplication.
This is safer and saves a few lines of code.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/sof/topology.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 369693cc6d10..8e9d8e079d68 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1096,7 +1096,6 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
 	const struct sof_token_info *token_list = ipc_tplg_ops->token_list;
 	struct snd_soc_tplg_private *private = &tw->priv;
 	int num_tuples = 0;
-	size_t size;
 	int ret, i;
 
 	if (count > 0 && !object_token_list) {
@@ -1109,8 +1108,7 @@ static int sof_widget_parse_tokens(struct snd_soc_component *scomp, struct snd_s
 		num_tuples += token_list[object_token_list[i]].count;
 
 	/* allocate memory for tuples array */
-	size = sizeof(struct snd_sof_tuple) * num_tuples;
-	swidget->tuples = kzalloc(size, GFP_KERNEL);
+	swidget->tuples = kcalloc(num_tuples, sizeof(*swidget->tuples), GFP_KERNEL);
 	if (!swidget->tuples)
 		return -ENOMEM;
 
@@ -1547,7 +1545,6 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 	const struct sof_token_info *token_list = ipc_tplg_ops->token_list;
 	struct snd_soc_tplg_private *private = &cfg->priv;
 	struct snd_sof_dai_link *slink;
-	size_t size;
 	u32 token_id = 0;
 	int num_tuples = 0;
 	int ret, num_sets;
@@ -1659,8 +1656,7 @@ static int sof_link_load(struct snd_soc_component *scomp, int index, struct snd_
 	}
 
 	/* allocate memory for tuples array */
-	size = sizeof(struct snd_sof_tuple) * num_tuples;
-	slink->tuples = kzalloc(size, GFP_KERNEL);
+	slink->tuples = kcalloc(num_tuples, sizeof(*slink->tuples), GFP_KERNEL);
 	if (!slink->tuples) {
 		kfree(slink->hw_configs);
 		kfree(slink);
-- 
2.32.0

