Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B0F463AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbhK3QHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243089AbhK3QHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:07:42 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86ECC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:04:22 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so15145285wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBqKZOVerJy7pcVyrJJrQZ25FBoDm1K0Bq5fYG0ijLA=;
        b=kXrSWYSesneu2dOdRsX/77bitmMhu4G8ptXAtC8ILtscF+oY54VkX24FdrXMWQ2QFm
         HaWBeeWU/BnocmPDxjFq6uOOh47F+RH150CSNkwUPn2iiCPidY+DTeCb0QmKHalxilp9
         Z4Tj08BqYxHNaEf0NN4N1QbYtdCjROPmB5b7nJr9Jbvv1kUZmh0DfxKHVJwc5Lk6r78m
         D6flTjbGV405zK/5cCvyeLUMQuszHMNI3KAaXhrObdL/6uHWpJJYEAtVTFKSgRu13V4v
         wgXaUAY289x89C816KF4hdHbyKNITPfxkfrRLPZ5RxPwa3bf5R1YpSgGPwi6iXa04Pcr
         cADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IBqKZOVerJy7pcVyrJJrQZ25FBoDm1K0Bq5fYG0ijLA=;
        b=VuMPhbdFv7mdZvJejIZPsAqBIM9tQjXMmDp1dzSwGLKQgoh24ZmkFDt65qwMoOyIUD
         SuvxQCzyHskwkuhozESKm4Pe2LFZXM9tkYUJ69UWKySR5jthgga3O+eJc5liyRqrCwKG
         2EmPLm//WP0hOGnWDBxQWmnyPnFyfGyPrFKUED+Lo/kyxQlMpGMsLEIv6LdK6cfb8IRh
         BTeQeTbgxfj0QWsN/dVLG6jOOg/kbaCbwFw4LuidvLoq/Ns9i2B1bblGWfmjDMp9NPcN
         Hw73FkZ0Qfct6DOCKefqeJlcBgyn5nM/2uG7r1Vw4ezspfAOf0HTXhz5aOChEnR7fV04
         1sbw==
X-Gm-Message-State: AOAM5310/kc7iWHzAgeshH1sP9U2dlSEbJ5Bwz6hUVriODAJEU+HYqn8
        r1mCGp5N+hSQgkRBzkSKgYk1g5HKh4xLYA==
X-Google-Smtp-Source: ABdhPJzH1M+SjpU9Vy+aHmc/yVN/loWXQPV7DkHX3N5YUeLFM1Y1Cn70yiQQDhW77cHNXV7lTr0H+w==
X-Received: by 2002:a05:600c:b46:: with SMTP id k6mr343605wmr.45.1638288261355;
        Tue, 30 Nov 2021 08:04:21 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m20sm3097575wmq.11.2021.11.30.08.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:04:20 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qdsp6: q6routing: Fix return value from msm_routing_put_audio_mixer
Date:   Tue, 30 Nov 2021 16:04:14 +0000
Message-Id: <20211130160414.21616-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

msm_routing_put_audio_mixer() can return incorrect value in various scenarios.
Fix this, so that change notifications are sent correctly.

Fixes: e3a33673e845 ("ASoC: qdsp6: q6routing: Add q6routing driver")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6routing.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6routing.c b/sound/soc/qcom/qdsp6/q6routing.c
index cd74681e811e..928fd23e2c27 100644
--- a/sound/soc/qcom/qdsp6/q6routing.c
+++ b/sound/soc/qcom/qdsp6/q6routing.c
@@ -498,14 +498,16 @@ static int msm_routing_put_audio_mixer(struct snd_kcontrol *kcontrol,
 	struct session_data *session = &data->sessions[session_id];
 
 	if (ucontrol->value.integer.value[0]) {
+		if (session->port_id == be_id)
+			return 0;
+
 		session->port_id = be_id;
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 1, update);
 	} else {
-		if (session->port_id == be_id) {
-			session->port_id = -1;
+		if (session->port_id == -1 || session->port_id != be_id)
 			return 0;
-		}
 
+		session->port_id = -1;
 		snd_soc_dapm_mixer_update_power(dapm, kcontrol, 0, update);
 	}
 
-- 
2.21.0

