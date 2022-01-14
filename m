Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810D948F2C4
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiANXCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiANXCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:02:33 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD8C061746
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:33 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id x20so3915495pgk.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K2v+tf3/coBADjHlh/X456ouYdTDi9mxyKcdvb4sAww=;
        b=VoKx/O+RdQ97dNYCMkBu/pvrz+/Fne9QTD5/ufOzQc2tIbl2VwuKirYICxRUmOaxU7
         bzMP9wvZcj0rii2XVRaGz2CB77+ByOkbDWFdmqSt03chP8478o1isqsZ72dK5ERh1qCg
         ZD1l5mA8b+oYH1T/dEcNRmhZAhXZfQvq12+jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K2v+tf3/coBADjHlh/X456ouYdTDi9mxyKcdvb4sAww=;
        b=aIMtvUIr1fK1S8SWEA7xBbt2N84wtzCvQCJk5vZ1C0rRGs0023Uj9o6mgT5apwYyQF
         9hi1ntTvoyUKf1xV/CjgaT52+m7k/EYCdruUzJFS1t0Iy6UP4WQjsxbimeYvqTZLgmDP
         3ohdubSUqsioo/I46i4ixiep411rNRzSBFCnqs5xZ4uuKzWDsW7fs5W3HCRxklE/72uG
         BNoo7K38qLFOC6jCHoNoU4D0ZswM/zaRcdJdS/a0gnK36B4QtE5OpHcmLZ9sEZBUeeIn
         uF2W6a9F9JCssYhPnBFeRfI7SvSmPk8jJj3+ZvtP/5+87dRHUqQif7vLSHCFuUB7kTyb
         PQ4Q==
X-Gm-Message-State: AOAM530iNCkboMTel9gnx4wA55VrF+IwvVrzefCbQUMcY+zwVTSz5Fm0
        klI3fAgwXyxqDWtbT5IQnRtL3w==
X-Google-Smtp-Source: ABdhPJyJxad9FH/It6rpaHOKDPCSlkdbKW/X7HtmB2tbRUwLIpcP+QTk8BQyjl2RIOc9OttHVlG6qw==
X-Received: by 2002:a05:6a00:1413:b0:4bf:a0d7:1f55 with SMTP id l19-20020a056a00141300b004bfa0d71f55mr10925475pfu.13.1642201353019;
        Fri, 14 Jan 2022 15:02:33 -0800 (PST)
Received: from localhost ([2620:15c:202:201:76ab:ede1:503d:1c39])
        by smtp.gmail.com with UTF8SMTPSA id l27sm5307598pgb.0.2022.01.14.15.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 15:02:32 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-rockchip@lists.infradead.org, Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 3/3] ASoC: rk3399_gru_sound: Wire up DP jack detection
Date:   Fri, 14 Jan 2022 15:02:09 -0800
Message-Id: <20220114150129.v2.3.I3c79b1466c14b02980071221e5b99283cd26ec77@changeid>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
In-Reply-To: <20220114230209.4091727-1-briannorris@chromium.org>
References: <20220114230209.4091727-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the cdn-dp driver supports plug-change callbacks, let's wire it
up.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

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

