Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB9484C0160
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 19:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbiBVSdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 13:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbiBVSc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 13:32:59 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B2B9E9EE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:33 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c192so12166513wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 10:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ht2zsDCw6mTpQAlwd9QIJhSI+uSP7rAlJbSv+42FdW4=;
        b=LXUOfvYcs0kbsRz+8veIC8emfQuSsGfkrwhm84FAWeP9sc3AI+0gN0owZNz+Zr72pY
         cIAKJyS4Gub9M71Vn2dsP4KurE2gzAozuSkzWPopWbzIIIDVrCC9lo5yVnRmZyuv8apq
         bq3hSG/PvG/efxwji5GBYA0YoTOaPOIau9kF2l3M8rR6QoJxNxkzQvnuA+QUVWZTiRem
         Q0GcIFB73m2Wyh3aTZJKXEE+jhJwEpG1rDVCnI3V/SxWCAlaWl5yaI07DOGu2z4B+LzX
         N0hB1DBPZ/RIpP7cWo20uCgw6RSQp/JCb/U3jONsszLTAbYxKt22RZ7Oird9AZ4rvs76
         BGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ht2zsDCw6mTpQAlwd9QIJhSI+uSP7rAlJbSv+42FdW4=;
        b=rSwLYFGdvLFiyVch15yJVYY0cnZaGHiKHbdYw1Vh53wEmks8s9kQhbWu8U6jaL4zvF
         uPsVDlFu5nXliEZgbqY8D0Gb6MY/dkpTIKchjmWryriwgZ9n+OCOi8rx7bViD/4A6Eh8
         2eIEu3S+OQwRpS0Mv4a3WGvepsPJizl6NzIqvzZtTK1688TmGlSOnqUmBXVtaDzWfgv7
         o36B32+EsG0+IldmiwdmhyeB+wklgb2F8aqmTO4X/b1EIOWhqEiV+6ysVfkq4KKAjgL7
         0JebOCsDf+dXp0u04VC8ZTmOxxEhgNtNWAvsp8J0+g4daebz2hIjs3/kS+j6lB7zMwuA
         WC0g==
X-Gm-Message-State: AOAM533KcrpKia/jY/ym/W3kOGJBeSOyIvsUyCw0+pMDmAusxF40OXlc
        8/jadSh4fEy0HxrK3qLICCem2w==
X-Google-Smtp-Source: ABdhPJyRSJz2xS81gFD3nqaVdA3VppkmlAX5k2fgyY5ea3oCaj0wITSJje5BPCTZboDEjS4yLjtmyg==
X-Received: by 2002:a05:600c:a03:b0:37b:daff:6146 with SMTP id z3-20020a05600c0a0300b0037bdaff6146mr4479777wmp.85.1645554752394;
        Tue, 22 Feb 2022 10:32:32 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id l28sm57642165wrz.90.2022.02.22.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 10:32:31 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 6/9] ASoC: codecs: wc938x: fix accessing array out of bounds for enum type
Date:   Tue, 22 Feb 2022 18:32:09 +0000
Message-Id: <20220222183212.11580-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
References: <20220222183212.11580-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accessing enums using integer would result in array out of bounds access
on platforms like aarch64 where sizeof(long) is 8 compared to enum size
which is 4 bytes.

Fix this by using enumerated items instead of integers.

Fixes: e8ba1e05bdc0 ("ASoC: codecs: wcd938x: add basic controls")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wcd938x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index cf61d23bfb1c..deecc83eb592 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -2506,7 +2506,7 @@ static int wcd938x_tx_mode_get(struct snd_kcontrol *kcontrol,
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
 	int path = e->shift_l;
 
-	ucontrol->value.integer.value[0] = wcd938x->tx_mode[path];
+	ucontrol->value.enumerated.item[0] = wcd938x->tx_mode[path];
 
 	return 0;
 }
@@ -2530,7 +2530,7 @@ static int wcd938x_rx_hph_mode_get(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct wcd938x_priv *wcd938x = snd_soc_component_get_drvdata(component);
 
-	ucontrol->value.integer.value[0] = wcd938x->hph_mode;
+	ucontrol->value.enumerated.item[0] = wcd938x->hph_mode;
 
 	return 0;
 }
-- 
2.21.0

