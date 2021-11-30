Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72002463AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbhK3QIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243379AbhK3QIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:41 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FDFC061748
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:21 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso19931747wmr.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zwiut7mFwVpOIkozl/7l8HWaVugd0GDlQFwZ0pbcpWc=;
        b=DC3LRUknToLtww9XliTaOCRIG9zbvS3PC1QegcsvRglKmY7uWF5UlMZDIPFsQkgCtH
         XNHlkiTBMAl1cqz+qKkWUWiTdTf9HDc2eYiVL7p9ViGDCqXzASbxn5dlvZNmcHwbV7pf
         2eLtPbNilBuHNPVAgK2SmyNk4FtW4w/ynJr/IbiRvx1G0nNqDcVev5hQc0WJ/z4nRj62
         uVmB8D8d4THEISnVdo7tbBqj1WCSYZWkyk3GjAtmEOmlXm8rEdLi+WK6p4JG/M4TU1eQ
         5Qj+a2nNreS3aF6+5vZYbT4JThzIWiqUQI69+DgVDatZx2fWfaPtKLl5dp2iQWcVSSge
         ULwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zwiut7mFwVpOIkozl/7l8HWaVugd0GDlQFwZ0pbcpWc=;
        b=MSYp+xjaoZDaU5ppAM68QEH1gBGvNpc95C+nT1akk405ePV29Js3XPtXtwMAGh4Wv9
         SP4Q2/divdfh8heNGptUa5a7FYIodZBs3VyBCLKGxuWqDWyrD9U8octXYm4D6gtFy3fQ
         Yy+qlRqOkZKgoWbMFkYxrxdrRotMdveTQ0PD85QQ8y7a0vlLRR+y7yKloScSJWEzSHkf
         JOWIN/fnfBzOwUNUZQydAVaNhQRpFTxNzphZojSiIAqtHJu1JYsoHeCwfmLwg6N1iSlg
         1ji7j2aU9dQTHtCbwntNwNy4gTFSbnVAD16I2gcTZtb6987b/Qmi6Tm9tNbSaeVJE4uK
         xxUg==
X-Gm-Message-State: AOAM533BWaNYFcHrL+GYusZuAtbBvDuES5idwGUljYqj/LfPYXGFA3j8
        l9Zysv/IdeKp+ciXUwJUn0iPeg==
X-Google-Smtp-Source: ABdhPJxtW93MuDdgIrHLAiFiqQ3gvI5ucjAo1K99MBBW5zlCNu9ULHrL5CDQWbObdUNIoy6DfRriiw==
X-Received: by 2002:a05:600c:1f17:: with SMTP id bd23mr360470wmb.57.1638288320134;
        Tue, 30 Nov 2021 08:05:20 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g18sm16719409wrv.42.2021.11.30.08.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:05:19 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] ASoC: codecs: wsa881x: fix return values from kcontrol put
Date:   Tue, 30 Nov 2021 16:05:07 +0000
Message-Id: <20211130160507.22180-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wsa881x_set_port() and wsa881x_put_pa_gain() currently returns zero eventhough
it changes the value. Fix this, so that change notifications are sent
correctly.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index 2da4a5fa7a18..564b78f3cdd0 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -772,7 +772,8 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 
 		usleep_range(1000, 1010);
 	}
-	return 0;
+
+	return 1;
 }
 
 static int wsa881x_get_port(struct snd_kcontrol *kcontrol,
@@ -816,15 +817,22 @@ static int wsa881x_set_port(struct snd_kcontrol *kcontrol,
 		(struct soc_mixer_control *)kcontrol->private_value;
 	int portidx = mixer->reg;
 
-	if (ucontrol->value.integer.value[0])
+	if (ucontrol->value.integer.value[0]) {
+		if (data->port_enable[portidx])
+			return 0;
+
 		data->port_enable[portidx] = true;
-	else
+	} else {
+		if (!data->port_enable[portidx])
+			return 0;
+
 		data->port_enable[portidx] = false;
+	}
 
 	if (portidx == WSA881X_PORT_BOOST) /* Boost Switch */
 		wsa881x_boost_ctrl(comp, data->port_enable[portidx]);
 
-	return 0;
+	return 1;
 }
 
 static const char * const smart_boost_lvl_text[] = {
-- 
2.21.0

