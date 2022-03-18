Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666C94DD726
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbiCRJhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiCRJhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:37:11 -0400
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A842EA921
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:35:52 -0700 (PDT)
X-QQ-mid: bizesmtp86t1647596144tkbrhvl5
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 18 Mar 2022 17:35:38 +0800 (CST)
X-QQ-SSF: 01400000002000D0I000000A0000000
X-QQ-FEAT: 1vYwxPNStGlVdhmjjLS+53k4INM9GjyQdIqJJMrCR+pb1LYHnR4/aqzBpqnWV
        ueiDrL0E4KPMqka9Lw7vwy/XCn///iYN9ih43KoU1HwOdjHxGQIEN6LgBHLEH0JECrFK3RL
        dGoMa4fMbFbetSbqw9V3WYJ9vtrhXmaYvIT6xqaTpLjUrsNCQhdzovFEa9Am1JbwsavFN3I
        833ohGKSAeYcDIcL0P5znSvBEEv2dCuaM2FoXncuRXVRlhkz3VGYI4LgjDsC9HsX3BmImBq
        YmeEnOeyGTxMf8Tpa7w+ainnytBx8VUOd0FhSPjKdSY4LLosOXXR89lldHfzWvtuCgakdck
        KYQKGSYEzaMKyeG99h+MoSuQOYqVPN6f04H7YKy7alSwSm1HKk=
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH] ASoC: fsl-asoc-card: Fix jack_event() always return 0
Date:   Fri, 18 Mar 2022 17:35:36 +0800
Message-Id: <20220318093536.15385-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today, hp_jack_event and mic_jack_event always return 0. However,
snd_soc_dapm_disable_pin and snd_soc_dapm_enable_pin may return a
non-zero value, this will cause the user who calling hp_jack_event
and mic_jack_event don't know whether the operation was really
successfully.

This patch corrects the behavior by properly returning 1 when the
value gets updated.

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 370bc790c6ba..f2641c2cb047 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -457,16 +457,18 @@ static int fsl_asoc_card_audmux_init(struct device_node *np,
 static int hp_jack_event(struct notifier_block *nb, unsigned long event,
 			 void *data)
 {
+	int ret;
+
 	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
 	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
 
 	if (event & SND_JACK_HEADPHONE)
 		/* Disable speaker if headphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		ret = snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
+		ret = snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 
-	return 0;
+	return ret;
 }
 
 static struct notifier_block hp_jack_nb = {
@@ -476,16 +478,18 @@ static struct notifier_block hp_jack_nb = {
 static int mic_jack_event(struct notifier_block *nb, unsigned long event,
 			  void *data)
 {
+	int ret;
+
 	struct snd_soc_jack *jack = (struct snd_soc_jack *)data;
 	struct snd_soc_dapm_context *dapm = &jack->card->dapm;
 
 	if (event & SND_JACK_MICROPHONE)
 		/* Disable dmic if microphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "DMIC");
+		ret = snd_soc_dapm_disable_pin(dapm, "DMIC");
 	else
-		snd_soc_dapm_enable_pin(dapm, "DMIC");
+		ret = snd_soc_dapm_enable_pin(dapm, "DMIC");
 
-	return 0;
+	return ret;
 }
 
 static struct notifier_block mic_jack_nb = {
-- 
2.20.1



