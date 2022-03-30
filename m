Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAF84ECE6D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351083AbiC3UoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 16:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbiC3UoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 16:44:23 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FD143394
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:42:37 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id bn33so29333969ljb.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICtX8vJXHq3AHfULAa1Lf6IAnjSqmJ3fVv5dGbQwOvQ=;
        b=TmG125jUIg3Tal8JAqGpY1kVFpBd80svhIAJgBA+U5h1DvQ/UbfOsbOAH24UWI/y3J
         wZ2l9kUhJreEkDzFc68E1WjyKxnxeZ2H55dxbIve5ixPtq58ejQhcInNC3LrFjWbyDLI
         DE16c9zjzgbDX5CQaG+WSx5fV3hx7GC1BjeHBEFJNaxYIE/LnEiosr0Ip1h0uo8+K0Vn
         bAx6eO27KQqwtaUqWgowkVTMOir9tVcmT0j9cUbgKHM8rPps+lCEp5jgaQI4i3PTjmwS
         oUAFhPeQiZVXpFse7AToqMFVGmt8LUcXgekSdzl03aoI77Txe+NSt2IdUDmxXwdhOYLo
         eFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICtX8vJXHq3AHfULAa1Lf6IAnjSqmJ3fVv5dGbQwOvQ=;
        b=OQi+Xr9pOlZzO05+FsjldOFDspDpYfsqFgIWMxIybIasV8bgNmXbmSaHfiWOqvDnYj
         viNbKC3TvaF1cjEC6vitoCkH5s4fT10RFoefrXV9zvN4n+at+eRkEF3/7hXYjqKEHdRe
         09epBFChPhhTWeZ35MD6FS0nBbXH7odUl3m+FAgIBdgWXi+GlAbUQZz8Hy+xeK5EJA8C
         ogkeTj9wsHcLVtYSbKFn+yslGlJiuv+qbTOo17JziGoKHIf9WyZnL+oYQ5J5+WFtdg1l
         eJXM0CIYd4WNzOX9a4araYg3kTerTrh32c0fzjYn4NCQRqZTn2VtDuoUs3/OXM2ZTSV0
         ZrsQ==
X-Gm-Message-State: AOAM5327otbmvE0Lxa0CAuRwq/lOuuSlWTTDmMUIP7/X5PrzqyNFATHd
        /6BPDXzlqYiUZs5YQD6b1Ng=
X-Google-Smtp-Source: ABdhPJw1zU3I66y4H0SMYqrMyMfkJ/7RIzrRskwK10mMYT+5jMdZe1M3rv4gzdHPdGKJFOo2EWCTvw==
X-Received: by 2002:a2e:a4a3:0:b0:24a:c0bf:3d32 with SMTP id g3-20020a2ea4a3000000b0024ac0bf3d32mr8381816ljm.161.1648672955447;
        Wed, 30 Mar 2022 13:42:35 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-188.NA.cust.bahnhof.se. [82.196.111.188])
        by smtp.gmail.com with ESMTPSA id i1-20020a2e8641000000b00247d94a6ac5sm2532997ljj.2.2022.03.30.13.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 13:42:34 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: samsung: Constify snd_soc_dapm_{route,widget} structs
Date:   Wed, 30 Mar 2022 22:42:27 +0200
Message-Id: <20220330204227.25081-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.35.1
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

These structs only have their address assigned to the
dapm_{routes,widget} fields in the snd_soc_card struct,
both which are pointers to const data. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/samsung/bells.c      | 4 ++--
 sound/soc/samsung/littlemill.c | 4 ++--
 sound/soc/samsung/lowland.c    | 4 ++--
 sound/soc/samsung/speyside.c   | 4 ++--
 sound/soc/samsung/tobermory.c  | 4 ++--
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sound/soc/samsung/bells.c b/sound/soc/samsung/bells.c
index 8b83f39c3ac9..76998a4a4cad 100644
--- a/sound/soc/samsung/bells.c
+++ b/sound/soc/samsung/bells.c
@@ -386,11 +386,11 @@ static struct snd_soc_codec_conf bells_codec_conf[] = {
 	},
 };
 
-static struct snd_soc_dapm_widget bells_widgets[] = {
+static const struct snd_soc_dapm_widget bells_widgets[] = {
 	SND_SOC_DAPM_MIC("DMIC", NULL),
 };
 
-static struct snd_soc_dapm_route bells_routes[] = {
+static const struct snd_soc_dapm_route bells_routes[] = {
 	{ "Sub CLK_SYS", NULL, "OPCLK" },
 	{ "CLKIN", NULL, "OPCLK" },
 
diff --git a/sound/soc/samsung/littlemill.c b/sound/soc/samsung/littlemill.c
index 34067cc314ff..26c42892c059 100644
--- a/sound/soc/samsung/littlemill.c
+++ b/sound/soc/samsung/littlemill.c
@@ -228,7 +228,7 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("WM1250 Output"),
 };
 
-static struct snd_soc_dapm_widget widgets[] = {
+static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 
 	SND_SOC_DAPM_MIC("AMIC", NULL),
@@ -239,7 +239,7 @@ static struct snd_soc_dapm_widget widgets[] = {
 			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
 };
 
-static struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Headphone", NULL, "HPOUT1L" },
 	{ "Headphone", NULL, "HPOUT1R" },
 
diff --git a/sound/soc/samsung/lowland.c b/sound/soc/samsung/lowland.c
index 7b12ccd2a9b2..8e4579fdcd7b 100644
--- a/sound/soc/samsung/lowland.c
+++ b/sound/soc/samsung/lowland.c
@@ -140,7 +140,7 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 };
 
-static struct snd_soc_dapm_widget widgets[] = {
+static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
@@ -150,7 +150,7 @@ static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_MIC("Main DMIC", NULL),
 };
 
-static struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Sub IN1", NULL, "HPOUT2L" },
 	{ "Sub IN2", NULL, "HPOUT2R" },
 
diff --git a/sound/soc/samsung/speyside.c b/sound/soc/samsung/speyside.c
index 37b1f4f60b21..1ae1a5aae72f 100644
--- a/sound/soc/samsung/speyside.c
+++ b/sound/soc/samsung/speyside.c
@@ -261,7 +261,7 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headphone"),
 };
 
-static struct snd_soc_dapm_widget widgets[] = {
+static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
@@ -271,7 +271,7 @@ static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_MIC("Main DMIC", NULL),
 };
 
-static struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "IN1RN", NULL, "MICB1" },
 	{ "IN1RP", NULL, "MICB1" },
 	{ "IN1RN", NULL, "MICB2" },
diff --git a/sound/soc/samsung/tobermory.c b/sound/soc/samsung/tobermory.c
index 8d3149a47a4c..4a56abfc243e 100644
--- a/sound/soc/samsung/tobermory.c
+++ b/sound/soc/samsung/tobermory.c
@@ -130,7 +130,7 @@ static const struct snd_kcontrol_new controls[] = {
 	SOC_DAPM_PIN_SWITCH("DMIC"),
 };
 
-static struct snd_soc_dapm_widget widgets[] = {
+static const struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 
@@ -140,7 +140,7 @@ static struct snd_soc_dapm_widget widgets[] = {
 	SND_SOC_DAPM_SPK("Main Speaker", NULL),
 };
 
-static struct snd_soc_dapm_route audio_paths[] = {
+static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Headphone", NULL, "HPOUTL" },
 	{ "Headphone", NULL, "HPOUTR" },
 
-- 
2.35.1

