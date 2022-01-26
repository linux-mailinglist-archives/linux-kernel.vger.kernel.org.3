Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00CCB49C8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240785AbiAZLgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240774AbiAZLgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:01 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B8CC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:01 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso1774866wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 03:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aniun3FP07/lm5WG5tDXe1tN8Nb0Xcv5gX8sytXFnHQ=;
        b=OVAIp1Nvla6MOTka4KhoRHptBE1bSiVkdUmm34BZZCZs9pCMjk7WFqRd2PcNoYz5i2
         qz++CHRUqs0Hc1Jjy2ZwyZdyvBL/5M7hK8K96SRgIBRA0mDOOX2R/eFf/Nd17+rmoIaL
         ZOUU7k9Z1bboObbL8LMgK7mFs+G2m2O3hf/7sddakD/OS0etWyU/MMRWgJH2AuJNqIYy
         KpNSTxkq1cluZHgj9g2ig05xAVNj+ooydvh2bXGk3mcJP/GjjRc9dsjlqVIy2QWjRlLp
         akowBvkd7Rfvnq56SwnmJvGZpPTIeWQClm0hHPSGKzjSp0fVunF7P0Fq8Ra/8R+xj96s
         InTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aniun3FP07/lm5WG5tDXe1tN8Nb0Xcv5gX8sytXFnHQ=;
        b=jS77kXyXlc9hpMrY9sWpX8BZEgEH5JPpHaH67HsQGsuTfPfoBjHvIxmE/3xy2tpetF
         zYlh9svn7hfpLmqJyRwqMy630MGR88FhsGfezx6xDPQd58SphqU9oEK+o+apRsnQ3RDu
         qe3XYJamRdFDfMxibgF5yIqDHLhDeziiqfgy0MFZCFXC6Ck2pf9kJxC0+jXIgv0andJp
         VWbs729nwTf7bgl3d5xHg7lBWNjMtCiwpHK2oGerb4oktukO/cdCT/SkU+JidHXzqUGP
         8dy5K7tbwCpnAPdX4qhvh4jQpFrUbNBEM0lNSXgfsa6IcRZuYYZxmoUl6OUO47XptGM2
         pdYw==
X-Gm-Message-State: AOAM531nSdVN6VN5GSoi1VDCvP+3bp5syVp7hRTQbERlRbEldA8NfDGx
        q40qe94va7cuAKcfDJlKdbrmsA==
X-Google-Smtp-Source: ABdhPJxVyM8l27hJP0QIDKsw9OQz0F2CEok4J4VqFVcvD191PyElZ8pHn1FtNv1K7u/ZM7SeuzaRng==
X-Received: by 2002:a05:600c:19c8:: with SMTP id u8mr6955120wmq.92.1643196959897;
        Wed, 26 Jan 2022 03:35:59 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n14sm11999188wri.75.2022.01.26.03.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 03:35:59 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: codecs: wcd938x: fix incorrect used of portid
Date:   Wed, 26 Jan 2022 11:35:46 +0000
Message-Id: <20220126113549.8853-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
References: <20220126113549.8853-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mixer controls have the channel id in mixer->reg, which is not same
as port id. port id should be derived from chan_info array.
So fix this. Without this, its possible that we could corrupt
struct wcd938x_sdw_priv by accessing port_map array out of range
with channel id instead of port id.

Fixes: e8ba1e05bdc0 ("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index eff200a07d9f..5994644c8702 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1432,14 +1432,10 @@ static int wcd938x_sdw_connect_port(struct wcd938x_sdw_ch_info *ch_info,
 	return 0;
 }
 
-static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 ch_id, u8 enable)
+static int wcd938x_connect_port(struct wcd938x_sdw_priv *wcd, u8 port_num, u8 ch_id, u8 enable)
 {
-	u8 port_num;
-
-	port_num = wcd->ch_info[ch_id].port_num;
-
 	return wcd938x_sdw_connect_port(&wcd->ch_info[ch_id],
-					&wcd->port_config[port_num],
+					&wcd->port_config[port_num - 1],
 					enable);
 }
 
@@ -2593,6 +2589,7 @@ static int wcd938x_set_compander(struct snd_kcontrol *kcontrol,
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 	struct wcd938x_sdw_priv *wcd;
 	int value = ucontrol->value.integer.value[0];
+	int portidx;
 	struct soc_mixer_control *mc;
 	bool hphr;
 
@@ -2606,10 +2603,12 @@ static int wcd938x_set_compander(struct snd_kcontrol *kcontrol,
 	else
 		wcd938x->comp1_enable = value;
 
+	portidx = wcd->ch_info[mc->reg].port_num;
+
 	if (value)
-		wcd938x_connect_port(wcd, mc->reg, true);
+		wcd938x_connect_port(wcd, portidx, mc->reg, true);
 	else
-		wcd938x_connect_port(wcd, mc->reg, false);
+		wcd938x_connect_port(wcd, portidx, mc->reg, false);
 
 	return 0;
 }
@@ -2882,9 +2881,11 @@ static int wcd938x_get_swr_port(struct snd_kcontrol *kcontrol,
 	struct wcd938x_sdw_priv *wcd;
 	struct soc_mixer_control *mixer = (struct soc_mixer_control *)kcontrol->private_value;
 	int dai_id = mixer->shift;
-	int portidx = mixer->reg;
+	int portidx, ch_idx = mixer->reg;
+
 
 	wcd = wcd938x->sdw_priv[dai_id];
+	portidx = wcd->ch_info[ch_idx].port_num;
 
 	ucontrol->value.integer.value[0] = wcd->port_enable[portidx];
 
@@ -2899,12 +2900,14 @@ static int wcd938x_set_swr_port(struct snd_kcontrol *kcontrol,
 	struct wcd938x_sdw_priv *wcd;
 	struct soc_mixer_control *mixer =
 		(struct soc_mixer_control *)kcontrol->private_value;
-	int portidx = mixer->reg;
+	int ch_idx = mixer->reg;
+	int portidx;
 	int dai_id = mixer->shift;
 	bool enable;
 
 	wcd = wcd938x->sdw_priv[dai_id];
 
+	portidx = wcd->ch_info[ch_idx].port_num;
 	if (ucontrol->value.integer.value[0])
 		enable = true;
 	else
@@ -2912,7 +2915,7 @@ static int wcd938x_set_swr_port(struct snd_kcontrol *kcontrol,
 
 	wcd->port_enable[portidx] = enable;
 
-	wcd938x_connect_port(wcd, portidx, enable);
+	wcd938x_connect_port(wcd, portidx, ch_idx, enable);
 
 	return 0;
 
-- 
2.21.0

