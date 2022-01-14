Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC1AB48F0D8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 21:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244263AbiANURV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 15:17:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244251AbiANURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 15:17:17 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1342C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:17:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id x83so3736259pfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 12:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=10U/YKtex+AND9dtDxjk3FYBvBwLFUl9f2fbhlUXUs0=;
        b=XQy4pyO/wUwsYqGsKtflTgY0GMz4pfjd2qpY31JHWTpxrdp5kycdY6uXSFa3MXVWe6
         wq/hlaXeACBG7Euq/bmzfc3SM6AC4Pu4laUwxAAWlVJsx2bVy0Izg+KtkO5gPiaBeCOw
         LsILH7rVPeqwj+OUGJjnT/KYlOKhVhKT8tdiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=10U/YKtex+AND9dtDxjk3FYBvBwLFUl9f2fbhlUXUs0=;
        b=kUhC9XJteLpi7IL+AM8aPmIut2mPAqilKjOuKQirMErplll02L4ALq7tIa70wTqAXE
         loRpcYqffKbrXobvub0em5f8NByUE4Gw/TdegtuYxn+k/QZ0a0lcqF7Xnm9nU/LHTQ19
         InPuELmWgYWw87zv0btQ0b6dtXKHDoE3FHDg2zMbQ9pmj2KL6OJuhZpFsJvu9XcXPx/N
         ckRo6JgHY7ueQqleX+/c1MZfD6/y91DeXmU58ObVCqhPsM40iIARvLj0sF5QpfmSj24j
         ZElR4MJSWKy9DchZqJSSxw2OJKNx6E4VX7L/HqJyeFIzc6/TOqssGtq4ou5O7zy88JWG
         mCjA==
X-Gm-Message-State: AOAM5327tvmkCiV82fxAADTUUq91jJ9FQCM90I929djo1i7SuxxnVaHY
        8HkJ0m/Aq33vQgbSBRLzcZxbbQ==
X-Google-Smtp-Source: ABdhPJxqbQOjbira1atGPpNHzh9Q82DXtSjtZWs+75WZcndu3r13+lzxdf+ODqr/TYUZIBqpyhshZg==
X-Received: by 2002:a63:6b81:: with SMTP id g123mr9615156pgc.140.1642191437321;
        Fri, 14 Jan 2022 12:17:17 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76ab:ede1:503d:1c39])
        by smtp.gmail.com with UTF8SMTPSA id g15sm2354365pfm.142.2022.01.14.12.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 12:17:16 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Sandy Huang <hjc@rock-chips.com>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Lin Huang <hl@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/3] ASoC: rk3399_gru_sound: Wire up DP jack detection
Date:   Fri, 14 Jan 2022 12:16:52 -0800
Message-Id: <20220114121515.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220114201652.3875838-1-briannorris@chromium.org>
References: <20220114201652.3875838-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the cdn-dp driver supports plug-change callbacks, let's wire it
up.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 sound/soc/rockchip/rk3399_gru_sound.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index e2d52d8d0ff9..eeef3ed70037 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -164,6 +164,25 @@ static int rockchip_sound_da7219_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
+static struct snd_soc_jack cdn_dp_card_jack;
+
+static int rockchip_sound_cdndp_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	struct snd_soc_card *card = rtd->card;
+	int ret;
+
+	/* Enable jack detection. */
+	ret = snd_soc_card_jack_new(card, "DP Jack", SND_JACK_LINEOUT,
+				    &cdn_dp_card_jack, NULL, 0);
+	if (ret) {
+		dev_err(card->dev, "Can't create DP Jack %d\n", ret);
+		return ret;
+	}
+
+	return snd_soc_component_set_jack(component, &cdn_dp_card_jack, NULL);
+}
+
 static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
@@ -315,6 +334,7 @@ static const struct snd_soc_dai_link rockchip_dais[] = {
 	[DAILINK_CDNDP] = {
 		.name = "DP",
 		.stream_name = "DP PCM",
+		.init = rockchip_sound_cdndp_init,
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			SND_SOC_DAIFMT_CBS_CFS,
 		SND_SOC_DAILINK_REG(cdndp),
-- 
2.34.1.703.g22d0c6ccf7-goog

