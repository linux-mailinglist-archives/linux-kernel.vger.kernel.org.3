Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2D4AD3C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 09:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbiBHInR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 03:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351157AbiBHImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 03:42:47 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411C4C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 00:42:46 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id b9so31872776lfq.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 00:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OqsnPBD75OEIg0YKhpWxP7ylQrnXYC+DLarhM8bDSAE=;
        b=3MWbe0vi62zn/YVDnF5AtSjnMWk8c4SBFKMTP6yKlW3QOxcHBOzJnAJuDxR7FCvAGs
         Ps1jDNA7iChEK/zGZ7XUHry/uWERzhbiHUYdDpQjU2KjSMsmrlXrCF5s/LcYL3Ixpwoi
         awrIfufh4k7dLcivn5jOg2y2BbEbiAtCWZ0USyrE9hXvvZON6+yHTGjy9fblj3HTzsEh
         TiC2cYjWPffoFw3xbdE4jq6adsp2ji2X5N16P/WDZVtc66nlOiRL+WnFAydGbuBquRV7
         WP0IEiZjvq7h0IC+JrttRh7CnsEACVKT4o2Rz61YE04PQ/uvfFoeX6Kc0W0kA3jd/gqC
         /JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OqsnPBD75OEIg0YKhpWxP7ylQrnXYC+DLarhM8bDSAE=;
        b=TCcLZPdDK+8xbQTd5E7HFftowQGGXMrDzLPuXm1m2+y54BxPB/w/GDQabiUYF45l2q
         u8eAKY0jlJIrmFiqv8CVzD5CDEgQm1dsRzelcjGvUwAQtFMoVt30HIQ08SBu12Nv3h39
         4la/TGaE5ylZrN+Rc0bt0tnL2Fa2NZzanlOkKgFAsWRdZoXrB0nIfsjfhVnM8urDeHkH
         0yGenrPwj30jE5v1SBteD7SM38BMVLCuXcULpMI2cnUNlvPQI6juwizQ6zJuRqn/NOYl
         n7ExJFlcrxiHPHbqfGXE/GK3XXDlOVnHzhn+Et+Boq/w3Fj3x+tMSLw4GQch4o8AObr7
         3rrg==
X-Gm-Message-State: AOAM530RyUUvCm6O00zRjELupUJ6YOUL4xyBso2svfM5lVzkYDfspEpu
        buT6kzzDzR/ua5XMplH83EDCdA==
X-Google-Smtp-Source: ABdhPJyRjmxFsSQKhUcZklAkzKieZBtNVZ0fLTFeF4+lWwQjOFe79DqlC62orWr4LAzCsom/vZ4HFw==
X-Received: by 2002:ac2:46ed:: with SMTP id q13mr2283630lfo.99.1644309764661;
        Tue, 08 Feb 2022 00:42:44 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id o12sm1830361lfu.96.2022.02.08.00.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 00:42:44 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH 4/4] ASoC: pcm3168a: remove numeric PCM3168A_NUM_SUPPLIES
Date:   Tue,  8 Feb 2022 11:42:20 +0300
Message-Id: <20220208084220.1289836-5-nikita.yoush@cogentembedded.com>
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

Just use ARRAY_SIZE() instead.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 sound/soc/codecs/pcm3168a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 1d3821f2c5f1..7417cf45d916 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -34,8 +34,7 @@
 #define PCM3168A_FMT_I2S_TDM		0x6
 #define PCM3168A_FMT_LEFT_J_TDM		0x7
 
-#define PCM3168A_NUM_SUPPLIES 6
-static const char *const pcm3168a_supply_names[PCM3168A_NUM_SUPPLIES] = {
+static const char *const pcm3168a_supply_names[] = {
 	"VDD1",
 	"VDD2",
 	"VCCAD1",
@@ -57,7 +56,7 @@ struct pcm3168a_io_params {
 };
 
 struct pcm3168a_priv {
-	struct regulator_bulk_data supplies[PCM3168A_NUM_SUPPLIES];
+	struct regulator_bulk_data supplies[ARRAY_SIZE(pcm3168a_supply_names)];
 	struct regmap *regmap;
 	struct clk *scki;
 	struct gpio_desc *gpio_rst;
-- 
2.30.2

