Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D0D5542D7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiFVGSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiFVGSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:18:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A92EE1C;
        Tue, 21 Jun 2022 23:18:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e40so9854647eda.2;
        Tue, 21 Jun 2022 23:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Exzm/TXSqD/Huvr9EUdQ5bsQgg0FbL+KozVE0rZYqD4=;
        b=qHQLTuz+Hgm1AtobLz/J6k/+zw6PveTJjpiZGYiyr9Q4LXqwdCH/Z3iNOnVExvRHuS
         xfwh6As67tnPwKJ1GQhbPDCe4WFletfstvuemoc3gqz9ODfu35fmeOBo288nmSfu+e23
         WJHRw8yNGl2UrjQ2s0V6wOkvdSnLKGMqmJ/delTBuFsRYASRTC91MjLTAXmZ8MQWo0Hu
         +CuAbzHl7IrDaNNs+QanH6V0RQA7o+WXdoMgsVD5dVR+CLnjY990wT6uuO/J+SsjJUjW
         /QmqrIGdY6iQoy3C6opnhwh5jSzUIj+Ekc12s0go0icKPg9FpZjHoAUD+k9imenW2hyP
         mL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Exzm/TXSqD/Huvr9EUdQ5bsQgg0FbL+KozVE0rZYqD4=;
        b=ABF267xEGOVj70jO5eQcUCgHQp3PYblgHLB0J68fBHLJA2IyZzQr5pEgX5++GZdpSx
         lDmdxJeg8iTLjQg80kZSDSWmoct8rUWAJvgKW/bbY9YEGXgiikEe5RPNi+65XhlDJUZN
         qfG1qq1tRSGUwNSmN7jGjGXgxvR5sVHHMhw5m6LlXywpcCVDd30NfBcruuCL/6gD/U1I
         ZrOFv+f8DBWh5jQm0Iri5/Nh2fn8DsCNt6+GjtTNsARrFCLp6HrD70vGtzmiElDRVLQm
         dVAFV6RwESMZJd/OmVDcNTJQbuC3NNnXeI19RG5CMxN36caa9w1RG1iP9NPPirGwA3JT
         NHCA==
X-Gm-Message-State: AJIora87MDV6cbkrgpMTZNlkOTYHNguN2r8Peqhqbct9RbbK4lRdp43+
        dNcTgH0PTcrAHQmWXqfNG5I=
X-Google-Smtp-Source: AGRyM1vMxIQS7+qafURtjJ3iealGus6Mn+sXlXnmUGfOw9hfIOoMLNCdsAYlRN3FBWTR5pbMjflLsg==
X-Received: by 2002:a05:6402:4390:b0:42e:b7e:e9ac with SMTP id o16-20020a056402439000b0042e0b7ee9acmr2215633edc.97.1655878693636;
        Tue, 21 Jun 2022 23:18:13 -0700 (PDT)
Received: from localhost.localdomain ([185.107.95.225])
        by smtp.gmail.com with ESMTPSA id x16-20020aa7cd90000000b0042fb3badd48sm14040764edv.9.2022.06.21.23.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 23:18:13 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: wcd9335: Use int array instead of bitmask for TX mixers
Date:   Wed, 22 Jun 2022 10:17:45 +0400
Message-Id: <20220622061745.35399-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Currently slim_tx_mixer_get reports all TX mixers as enabled when
at least one is, due to it reading the entire tx_port_value bitmask
without testing the specific bit corresponding to a TX port.
Furthermore, using the same bitmask for all capture DAIs makes
setting one mixer affect them all. To prevent this, and since
the SLIM TX muxes effectively only connect to one of the mixers
at a time, turn tx_port_value into an int array storing the DAI
index each of the ports is connected to.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 sound/soc/codecs/wcd9335.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 7d40a61b03b0..a4d92f7aef9e 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -342,7 +342,7 @@ struct wcd9335_codec {
 	struct regulator_bulk_data supplies[WCD9335_MAX_SUPPLY];
 
 	unsigned int rx_port_value[WCD9335_RX_MAX];
-	unsigned int tx_port_value;
+	unsigned int tx_port_value[WCD9335_TX_MAX];
 	int hph_l_gain;
 	int hph_r_gain;
 	u32 rx_bias_count;
@@ -1334,8 +1334,13 @@ static int slim_tx_mixer_get(struct snd_kcontrol *kc,
 
 	struct snd_soc_dapm_context *dapm = snd_soc_dapm_kcontrol_dapm(kc);
 	struct wcd9335_codec *wcd = dev_get_drvdata(dapm->dev);
+	struct snd_soc_dapm_widget *widget = snd_soc_dapm_kcontrol_widget(kc);
+	struct soc_mixer_control *mixer =
+			(struct soc_mixer_control *)kc->private_value;
+	int dai_id = widget->shift;
+	int port_id = mixer->shift;
 
-	ucontrol->value.integer.value[0] = wcd->tx_port_value;
+	ucontrol->value.integer.value[0] = wcd->tx_port_value[port_id] == dai_id;
 
 	return 0;
 }
@@ -1358,12 +1363,12 @@ static int slim_tx_mixer_put(struct snd_kcontrol *kc,
 	case AIF2_CAP:
 	case AIF3_CAP:
 		/* only add to the list if value not set */
-		if (enable && !(wcd->tx_port_value & BIT(port_id))) {
-			wcd->tx_port_value |= BIT(port_id);
+		if (enable && wcd->tx_port_value[port_id] != dai_id) {
+			wcd->tx_port_value[port_id] = dai_id;
 			list_add_tail(&wcd->tx_chs[port_id].list,
 					&wcd->dai[dai_id].slim_ch_list);
-		} else if (!enable && (wcd->tx_port_value & BIT(port_id))) {
-			wcd->tx_port_value &= ~BIT(port_id);
+		} else if (!enable && wcd->tx_port_value[port_id] == dai_id) {
+			wcd->tx_port_value[port_id] = -1;
 			list_del_init(&wcd->tx_chs[port_id].list);
 		}
 		break;
-- 
2.36.1

