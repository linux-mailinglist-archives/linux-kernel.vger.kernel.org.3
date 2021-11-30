Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C997463AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243375AbhK3QIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhK3QIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:36 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B20C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:17 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so15142189wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eiq8mrs4KypbI40KDxp0gW63RCTeIkT2fpDQjEs0zV8=;
        b=sDuza+FZX9QSH3qeNGT+X+DA4wb9mg3F2wJVZ3Y1NX77eEyJsKvTViqNq4bss6VT8X
         PTthJDo/VTQ6pVnvRQPbmpUUz1imxJHKY4DCcE0CCRjcu4s8B7bvGpQP5WbMzkSpHR7f
         mX/NbBx2IlSBKyMAUkQFMmO3BnMa+pcvN8abRYv59VXmjuz+yBZMQMoBfiaQxfQsPU25
         9n+Mfg3UYyzKOASyn+A4h7Mg91hI7te93byBsAc8cl/2wCn0vSHZbhHojD7BnpABdI6b
         aUf+2Oo7bC/UcsAsEk2z89ZMDLRfQlkNcLohcL9jaamWALeKf0ekd/dAJzz2DQmDzNTT
         gEMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eiq8mrs4KypbI40KDxp0gW63RCTeIkT2fpDQjEs0zV8=;
        b=PwIZ3b2+GEEYn/4IP97hsZiizJBxhdYi1/4NvbRj2m40IWVnYenPhzvSXISKE0wQeS
         4HIXGm/NiPyhkPJ2vfoMnpqgTeHPOiwh01wfmz4gQ0hO+4wpswIyWZXoIz6oPtlYqZH4
         SkrUOIUtvg/GC2ZEg2iHT/k8pywpzZezuZlO5U76azAi850yrlUJQAB35N2zy2nhYM9G
         Me1WXMS0IEH5S5iULDznCS5V+eIobHtHl1u52oT9eR8hXmhOg0Q1re46wfK1CmTErfv9
         hmPFMTBQfztTRmU7ssDFyuCvgf6LvSBKPc0qfGZ9uCX4fQ3QSilyhXBrvgqnU4td/PQt
         C2Fw==
X-Gm-Message-State: AOAM532e16cq/IMJnAtg/sf/NHeBepUH/QLtvxBTXWs4ftnoXJHRo0hK
        27xZfh6bdXwwoKawiqSSQESHLQ==
X-Google-Smtp-Source: ABdhPJxyr8BMwJKco7wRY8An11NgrVbV9pVbtue9NByormM7We4hBoSLLdbMlHxs4rByG8OkV8b5MQ==
X-Received: by 2002:a1c:4d0b:: with SMTP id o11mr402887wmh.68.1638288315526;
        Tue, 30 Nov 2021 08:05:15 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g18sm16719409wrv.42.2021.11.30.08.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:05:14 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: codecs: wcd934x: handle channel mappping list correctly
Date:   Tue, 30 Nov 2021 16:05:04 +0000
Message-Id: <20211130160507.22180-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently each channel is added as list to dai channel list, however
there is danger of adding same channel to multiple dai channel list
which endups corrupting the other list where its already added.

This patch ensures that the channel is actually free before adding to
the dai channel list and also ensures that the channel is on the list
before deleting it.

This check was missing previously, and we did not hit this issue as
we were testing very simple usecases with sequence of amixer commands.

Fixes: a70d9245759a ("ASoC: wcd934x: add capture dapm widgets")
Fixes: dd9eb19b5673 ("ASoC: wcd934x: add playback dapm widgets")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 119 +++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 31 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 4f568abd59e2..eb4e2f2a24ae 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3326,6 +3326,31 @@ static int slim_rx_mux_get(struct snd_kcontrol *kc,
 	return 0;
 }
 
+static int slim_rx_mux_to_dai_id(int mux)
+{
+	int aif_id;
+
+	switch (mux) {
+	case 1:
+		aif_id = AIF1_PB;
+		break;
+	case 2:
+		aif_id = AIF2_PB;
+		break;
+	case 3:
+		aif_id = AIF3_PB;
+		break;
+	case 4:
+		aif_id = AIF4_PB;
+		break;
+	default:
+		aif_id = -1;
+		break;
+	}
+
+	return aif_id;
+}
+
 static int slim_rx_mux_put(struct snd_kcontrol *kc,
 			   struct snd_ctl_elem_value *ucontrol)
 {
@@ -3333,43 +3358,59 @@ static int slim_rx_mux_put(struct snd_kcontrol *kc,
 	struct wcd934x_codec *wcd = dev_get_drvdata(w->dapm->dev);
 	struct soc_enum *e = (struct soc_enum *)kc->private_value;
 	struct snd_soc_dapm_update *update = NULL;
+	struct wcd934x_slim_ch *ch, *c;
 	u32 port_id = w->shift;
+	bool found = false;
+	int mux_idx;
+	int prev_mux_idx = wcd->rx_port_value[port_id];
+	int aif_id;
 
-	if (wcd->rx_port_value[port_id] == ucontrol->value.enumerated.item[0])
-		return 0;
+	mux_idx = ucontrol->value.enumerated.item[0];
 
-	wcd->rx_port_value[port_id] = ucontrol->value.enumerated.item[0];
+	if (mux_idx == prev_mux_idx)
+		return 0;
 
-	switch (wcd->rx_port_value[port_id]) {
+	switch(mux_idx) {
 	case 0:
-		list_del_init(&wcd->rx_chs[port_id].list);
-		break;
-	case 1:
-		list_add_tail(&wcd->rx_chs[port_id].list,
-			      &wcd->dai[AIF1_PB].slim_ch_list);
-		break;
-	case 2:
-		list_add_tail(&wcd->rx_chs[port_id].list,
-			      &wcd->dai[AIF2_PB].slim_ch_list);
-		break;
-	case 3:
-		list_add_tail(&wcd->rx_chs[port_id].list,
-			      &wcd->dai[AIF3_PB].slim_ch_list);
+		aif_id = slim_rx_mux_to_dai_id(prev_mux_idx);
+		if (aif_id < 0)
+			return 0;
+
+		list_for_each_entry_safe(ch, c, &wcd->dai[aif_id].slim_ch_list, list) {
+			if (ch->port == port_id + WCD934X_RX_START) {
+				found = true;
+				list_del_init(&ch->list);
+				break;
+			}
+		}
+		if (!found)
+			return 0;
+
 		break;
-	case 4:
-		list_add_tail(&wcd->rx_chs[port_id].list,
-			      &wcd->dai[AIF4_PB].slim_ch_list);
+	case 1 ... 4:
+		aif_id = slim_rx_mux_to_dai_id(mux_idx);
+		if (aif_id < 0)
+			return 0;
+
+		if (list_empty(&wcd->rx_chs[port_id].list)) {
+			list_add_tail(&wcd->rx_chs[port_id].list,
+				      &wcd->dai[aif_id].slim_ch_list);
+		} else {
+			dev_err(wcd->dev ,"SLIM_RX%d PORT is busy\n", port_id);
+			return 0;
+		}
 		break;
+
 	default:
-		dev_err(wcd->dev, "Unknown AIF %d\n",
-			wcd->rx_port_value[port_id]);
+		dev_err(wcd->dev, "Unknown AIF %d\n", mux_idx);
 		goto err;
 	}
 
+	wcd->rx_port_value[port_id] = mux_idx;
 	snd_soc_dapm_mux_update_power(w->dapm, kc, wcd->rx_port_value[port_id],
 				      e, update);
 
-	return 0;
+	return 1;
 err:
 	return -EINVAL;
 }
@@ -3815,6 +3856,7 @@ static int slim_tx_mixer_put(struct snd_kcontrol *kc,
 	struct soc_mixer_control *mixer =
 			(struct soc_mixer_control *)kc->private_value;
 	int enable = ucontrol->value.integer.value[0];
+	struct wcd934x_slim_ch *ch, *c;
 	int dai_id = widget->shift;
 	int port_id = mixer->shift;
 
@@ -3822,17 +3864,32 @@ static int slim_tx_mixer_put(struct snd_kcontrol *kc,
 	if (enable == wcd->tx_port_value[port_id])
 		return 0;
 
-	wcd->tx_port_value[port_id] = enable;
-
-	if (enable)
-		list_add_tail(&wcd->tx_chs[port_id].list,
-			      &wcd->dai[dai_id].slim_ch_list);
-	else
-		list_del_init(&wcd->tx_chs[port_id].list);
+	if (enable) {
+		if (list_empty(&wcd->tx_chs[port_id].list)) {
+			list_add_tail(&wcd->tx_chs[port_id].list,
+				      &wcd->dai[dai_id].slim_ch_list);
+		} else {
+			dev_err(wcd->dev ,"SLIM_TX%d PORT is busy\n", port_id);
+			return 0;
+		}
+	 } else {
+		bool found = false;
+
+		list_for_each_entry_safe(ch, c, &wcd->dai[dai_id].slim_ch_list, list) {
+			if (ch->port == port_id) {
+				found = true;
+				list_del_init(&wcd->tx_chs[port_id].list);
+				break;
+			}
+		}
+		if (!found)
+			return 0;
+	 }
 
+	wcd->tx_port_value[port_id] = enable;
 	snd_soc_dapm_mixer_update_power(widget->dapm, kc, enable, update);
 
-	return 0;
+	return 1;
 }
 
 static const struct snd_kcontrol_new aif1_slim_cap_mixer[] = {
-- 
2.21.0

