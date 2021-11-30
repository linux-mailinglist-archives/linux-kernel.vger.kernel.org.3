Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CFFC463AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:05:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243474AbhK3QIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243347AbhK3QIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:38 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:18 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso19929016wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 08:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cf22A45pIeR4jTVVQeT79V6xpjlvyZZcaz2Nd53SNwU=;
        b=zieBOBgJlezxLM6a+mgn0ZoGwqWpWXR0ep4C0N3OKYR3G6hMjrB3u2lVsIUIKPB4AF
         IPS6tjfHpQDPGXP3q3eHbMXs6WB5Bqh5f4nCrDfasPgsd47iPhIis9/4Dfh/gdpWZI0C
         S8vIJmUvHq4XgKVlQWISEu3p0RzYMZ4FXdMS5hOWBsue5ewlinM/VhHGicUAVbboEn/E
         emdm14dHBi1MQP7QVli6CKznIhjM0tc1U8wgibKyL7fA+ghefz5xVhlrbs5B+N3eGE/O
         vhbKkOzomFum02wWFxCtWdkUeb96R5GH52kRZcFy8rK/jmBdEqrhD8zrNWtRTv+dcay2
         VKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cf22A45pIeR4jTVVQeT79V6xpjlvyZZcaz2Nd53SNwU=;
        b=tjl4qfdLR4ptH56s/jm8TPZodK2wnzk0SbTpmlNQenPlizIAUiQIhxmB+M8OOAAsoe
         x0D+doUV8fucLdzVvEJpZNqQ+o+C91GZ3K1a4EV3kdZfTC/OgVgDh7GnagiezVhkonyW
         SwDoUH7UQdi0xaSC5YZ1fI1YE6bjiKkCNqWDi2sQvUgDJMIEskvOzpGB4Xg/FldFEPLl
         c6Zndg0TC/edF7KkhNFMPhgSj+Fz2/MSgwImOzvtrSLh7vlxBoxDXcaIqmU+AwcuXFBQ
         LmCNREJXZV/k7Bkl6mRqqxXiFXwuPhRsSurjcXnAkbGCZ5LNZUM+fXoyjz25S7W+mc/N
         R9uw==
X-Gm-Message-State: AOAM532BdLlB1scyaaO5gY22JKpsxcG9byYcHhE0SA8XdecL9JtIHXBV
        2Ub34tCuuFXt17Wyt/8iYho1EQ==
X-Google-Smtp-Source: ABdhPJzLcAC1smNz3lM+4F8KaRwpxqBWaK5zP1R57JU/TzPu4Nnobd90HPstMEfd9+bqfB8qj2ULmA==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr347711wmn.93.1638288317080;
        Tue, 30 Nov 2021 08:05:17 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id g18sm16719409wrv.42.2021.11.30.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 08:05:16 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/4] ASoC: codecs: wcd934x: remove redundant ret variable
Date:   Tue, 30 Nov 2021 16:05:05 +0000
Message-Id: <20211130160507.22180-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
References: <20211130160507.22180-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

return value form snd_soc_dapm_put_enum_double() directly instead
of taking this in another redundant variable.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd934x.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index eb4e2f2a24ae..3294c685d4d8 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3420,7 +3420,7 @@ static int wcd934x_int_dem_inp_mux_put(struct snd_kcontrol *kc,
 {
 	struct soc_enum *e = (struct soc_enum *)kc->private_value;
 	struct snd_soc_component *component;
-	int reg, val, ret;
+	int reg, val;
 
 	component = snd_soc_dapm_kcontrol_component(kc);
 	val = ucontrol->value.enumerated.item[0];
@@ -3443,9 +3443,7 @@ static int wcd934x_int_dem_inp_mux_put(struct snd_kcontrol *kc,
 					      WCD934X_RX_DLY_ZN_EN_MASK,
 					      WCD934X_RX_DLY_ZN_DISABLE);
 
-	ret = snd_soc_dapm_put_enum_double(kc, ucontrol);
-
-	return ret;
+	return snd_soc_dapm_put_enum_double(kc, ucontrol);
 }
 
 static int wcd934x_dec_enum_put(struct snd_kcontrol *kcontrol,
-- 
2.21.0

