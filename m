Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC94AD3C8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351338AbiBHInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350981AbiBHImp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:45 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379F5C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:44 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id z20so23393909ljo.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SqcXIt39hShtKj54ZerZJEIaFZk+FrZV1s2XWCXxyw=;
        b=GBxw4kKR0joqbiZYz79uUSB9b2Zp2Zq+1eMvhtf1Ac1BmvTGd6BsEvmwkCkvocSnsS
         9xvM6rXbEpDJHmHhuYFQK8iGxjYyygD7x58gMbrhhBdIEUDi7xoX5w/4l4kc6UCnU05S
         MZ8a2vzicDPPC4w9i0Ugy135JxLJwWR3ZBgpiOhYb8GAcxj3AvUtv4ZMb874OvgabLw+
         +7hEEum8vy4INAKgeHb8aaQ/E/F41kVT4jvgClVu/0xFPGiZ8aYiVfTkpoxVPTxo3Nd0
         aoynGWCm1BCwlnmvUskt8F5g2EE8uFrUUychYlknnDwWzPQMxWAXRPQIezuBo/ifrD7U
         NbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SqcXIt39hShtKj54ZerZJEIaFZk+FrZV1s2XWCXxyw=;
        b=CGR7xhmjAZ9OBZIgoAfre2/6CXh5MBYXbm4bmE2AVIj8qIr6rtU4QnsD55F/d8e+lI
         n80gqfUJtgzO7Y4eyXYMKChVdiQx2TDvFD/NrdLWpFAj9RRx2nxLoQMTafi25ox85uKz
         0l0hu801C+LJq1J6Ls1ifWXTjklKz5orMKBu+zOFqJHyoOC8o6vxNNMF8H5fKrk+ChX7
         PGqnSpk1e32TO6G7jxbkp6Wwa1imDu+7mn3vhawD7YMBfH47XLz7bWWZX2buIAHdvi/8
         Jn3FaiEVCN1r8cFOxnBejndwAVFEI5fpj4XoBQwsBD1xCAwxtuAoLCpEj+wcRczGokFZ
         jzhg==
X-Gm-Message-State: AOAM531AIs/EmD6xD88ywwuwyaxhfXgAPQuAYVv98YsTWtgADHVVm4Ct
        lsgIfQNq4wtcaTwDZcIbG40mqg==
X-Google-Smtp-Source: ABdhPJz4lF2QXG+jryZwq6Ylmt24RIWtcNM+ZFjykyOOoX1MQeeQeKh9mmcRvwrBb5iaC7ORnycxEw==
X-Received: by 2002:a2e:a5c3:: with SMTP id n3mr2173139ljp.212.1644309762594;
        Tue, 08 Feb 2022 00:42:42 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o12sm1830361lfu.96.2022.02.08.00.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:42 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 2/4] ASoC: pcm3168a: refactor hw_params routine
Date:   Tue,  8 Feb 2022 11:42:18 +0300
Message-Id: <20220208084220.1289836-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
References: <20220208084220.1289836-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- group together code lines that calculate value for msad/msda field

- rename variables to better match their meaning:
    val -> ms,
    max_ratio -> num_scki_ratios

- update variable types to match exactly parameters or return types
  of the calls where those variables are used

- write two fields of the same register in a single regmap call

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/pcm3168a.c | 67 ++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 987c5845f769..526e4562ccb5 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -462,40 +462,45 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 	struct pcm3168a_priv *pcm3168a = snd_soc_component_get_drvdata(component);
 	struct pcm3168a_io_params *io_params = &pcm3168a->io_params[dai->id];
 	bool master_mode;
-	u32 val, mask, shift, reg;
-	unsigned int rate, fmt, ratio, max_ratio;
-	unsigned int tdm_slots;
-	int i, slot_width;
-
-	rate = params_rate(params);
-
-	ratio = pcm3168a->sysclk / rate;
+	unsigned int reg, mask, ms, ms_shift, fmt, fmt_shift, ratio, tdm_slots;
+	int i, num_scki_ratios, slot_width;
 
 	if (dai->id == PCM3168A_DAI_DAC) {
-		max_ratio = PCM3168A_NUM_SCKI_RATIOS_DAC;
+		num_scki_ratios = PCM3168A_NUM_SCKI_RATIOS_DAC;
 		reg = PCM3168A_DAC_PWR_MST_FMT;
-		mask = PCM3168A_DAC_MSDA_MASK;
-		shift = PCM3168A_DAC_MSDA_SHIFT;
+		mask = PCM3168A_DAC_MSDA_MASK | PCM3168A_DAC_FMT_MASK;
+		ms_shift = PCM3168A_DAC_MSDA_SHIFT;
+		fmt_shift = PCM3168A_DAC_FMT_SHIFT;
 	} else {
-		max_ratio = PCM3168A_NUM_SCKI_RATIOS_ADC;
+		num_scki_ratios = PCM3168A_NUM_SCKI_RATIOS_ADC;
 		reg = PCM3168A_ADC_MST_FMT;
-		mask = PCM3168A_ADC_MSAD_MASK;
-		shift = PCM3168A_ADC_MSAD_SHIFT;
+		mask = PCM3168A_ADC_MSAD_MASK | PCM3168A_ADC_FMTAD_MASK;
+		ms_shift = PCM3168A_ADC_MSAD_SHIFT;
+		fmt_shift = PCM3168A_ADC_FMTAD_SHIFT;
 	}
 
 	master_mode = io_params->master_mode;
-	fmt = io_params->fmt;
 
-	for (i = 0; i < max_ratio; i++) {
-		if (pcm3168a_scki_ratios[i] == ratio)
-			break;
-	}
+	if (master_mode) {
+		ratio = pcm3168a->sysclk / params_rate(params);
 
-	if (i == max_ratio) {
-		dev_err(component->dev, "unsupported sysclk ratio\n");
-		return -EINVAL;
+		for (i = 0; i < num_scki_ratios; i++) {
+			if (pcm3168a_scki_ratios[i] == ratio)
+				break;
+		}
+
+		if (i == num_scki_ratios) {
+			dev_err(component->dev, "unsupported sysclk ratio\n");
+			return -EINVAL;
+		}
+
+		ms = (i + 1);
+	} else {
+		ms = 0;
 	}
 
+	fmt = io_params->fmt;
+
 	if (io_params->slot_width)
 		slot_width = io_params->slot_width;
 	else
@@ -553,22 +558,8 @@ static int pcm3168a_hw_params(struct snd_pcm_substream *substream,
 		}
 	}
 
-	if (master_mode)
-		val = ((i + 1) << shift);
-	else
-		val = 0;
-
-	regmap_update_bits(pcm3168a->regmap, reg, mask, val);
-
-	if (dai->id == PCM3168A_DAI_DAC) {
-		mask = PCM3168A_DAC_FMT_MASK;
-		shift = PCM3168A_DAC_FMT_SHIFT;
-	} else {
-		mask = PCM3168A_ADC_FMTAD_MASK;
-		shift = PCM3168A_ADC_FMTAD_SHIFT;
-	}
-
-	regmap_update_bits(pcm3168a->regmap, reg, mask, fmt << shift);
+	regmap_update_bits(pcm3168a->regmap, reg, mask,
+			(ms << ms_shift) | (fmt << fmt_shift));
 
 	return 0;
 }
-- 
2.30.2

