Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D894E20CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 07:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiCUG7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 02:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiCUG7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 02:59:45 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78A83F8AB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 23:58:16 -0700 (PDT)
X-QQ-mid: bizesmtp82t1647845884t804rf5r
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 21 Mar 2022 14:57:57 +0800 (CST)
X-QQ-SSF: 01400000002000D0I000000A0000000
X-QQ-FEAT: geCjBjpTnm5MCuhbl7WYFcVXtSlLYe9nC1Ht/79OMySzfSxUeFWMlEVlP+knM
        OezqIH5y7A/rfELeaajZVCAAx4GrtoyySSDJmz7ddbkXeiUfWifuSxk/Bi9creqz6xIm/Jm
        Uu2MMJxb28nTNTn8X70dH7T5IYaZk9lBtgzED1Ka/XyEVb6eqQN4t7L914gqT01Yzk7hw6r
        S42MAr0xF076OqnTq2umNB9bzMI1NIMvSfWdJKMDjmiBsRMEX2aW1VC38gydlWoIJsYmYQF
        6CJjxuUTdWSnPaojt+XOZgN7dpg0tmUTH+g0KM/fHg9zn9nAyVwFJkrsz/DshH06pVsMVOZ
        8lJ+UsPbx8dPh1DVoEcN2sD3aXON/Z9fhYrV5we
X-QQ-GoodBg: 1
From:   Meng Tang <tangmeng@uniontech.com>
To:     nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v2] ASoC: fsl-asoc-card: Fix jack_event() always return 0
Date:   Mon, 21 Mar 2022 14:57:54 +0800
Message-Id: <20220321065754.18307-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign8
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 370bc790c6ba..d9a0d4768c4d 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -462,11 +462,9 @@ static int hp_jack_event(struct notifier_block *nb, unsigned long event,
 
 	if (event & SND_JACK_HEADPHONE)
 		/* Disable speaker if headphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "Ext Spk");
+		return snd_soc_dapm_disable_pin(dapm, "Ext Spk");
 	else
-		snd_soc_dapm_enable_pin(dapm, "Ext Spk");
-
-	return 0;
+		return snd_soc_dapm_enable_pin(dapm, "Ext Spk");
 }
 
 static struct notifier_block hp_jack_nb = {
@@ -481,11 +479,9 @@ static int mic_jack_event(struct notifier_block *nb, unsigned long event,
 
 	if (event & SND_JACK_MICROPHONE)
 		/* Disable dmic if microphone is plugged in */
-		snd_soc_dapm_disable_pin(dapm, "DMIC");
+		return snd_soc_dapm_disable_pin(dapm, "DMIC");
 	else
-		snd_soc_dapm_enable_pin(dapm, "DMIC");
-
-	return 0;
+		return snd_soc_dapm_enable_pin(dapm, "DMIC");
 }
 
 static struct notifier_block mic_jack_nb = {
-- 
2.20.1



