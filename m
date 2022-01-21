Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A85496355
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381884AbiAUQ5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 11:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380449AbiAUQ46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 11:56:58 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1BC06177C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:56:04 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id n22-20020a9d2016000000b0059bd79f7777so12089606ota.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJAPsXsyMyStdrgiiG/42UEEzPqRzVav9xb3OpyRVHQ=;
        b=Twc9JkSiDP8VFRJqzluEaW2Z+2+GsDobGXcC4mRcD907KrgRdR7biXOtGDPPZ2UBWt
         SPMO43Mn+NBkptudLVDrRUTuJPwBucOHSQvFhxsq2Tf7rxv8Qs8gegVEYIJ5nXRbv8uQ
         x9Z2CA/QUQmuSwk7MhgPz/pdOBc9invJxmtmwXQBb5fjr1FWY/BqXLqFTgcGCvKfPjyH
         RDA6E5h78KUKRRB/ZI+IbfQHiEh6q55IMcPdqQYJD4jzqlu50WlCa1PLLmJQlwOMncv3
         nrku0yGN4/fMx3DFztsEOuLHsE0Vuq7C4jRLm6GufgYAYvmaOg5563KJ1tass8i47vFZ
         +xpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJAPsXsyMyStdrgiiG/42UEEzPqRzVav9xb3OpyRVHQ=;
        b=gykTHJNNvNOcN2NMvyI0C4FC5Mj8Mh+kzDWmIVm//98Xi7SUyPV4abVZF9irf9BLH+
         oqGkK96NCzezuMsc78+GPb70HFmVvDkwbGmXk6b426DQjwnVoqttNPUwVpqpOoO5wZxa
         6KIr0sSTQudCej4zdEWoHMeoaxyA3pOqwVMAZzK3Mf7kcRZSYpkMAjYdnb0+ds+6lOgl
         h3FRj7XQaHeltUyfVbybl7Xss6GFtt+UtpU93DeL/ubmH9cHGF6g4GojXW7DhD1oq9XU
         Hx8cpmDtTz4wgRhiJ1eAjVBla88Hg4EpncIRh6GeXY2rQ825DleUrsKB4lX184u6OS4b
         7yNg==
X-Gm-Message-State: AOAM531ylhE1UaTkPkuxJjSLb34ucejSFJ05suGVxgdxl9TRtX2nAmbs
        2OtRCfUYhp2L+diBQYcazjg=
X-Google-Smtp-Source: ABdhPJzeJejm8YYaXmOdZw3QExcnXsXNYn1jraBIWNvWa+5iSEwrJf3YLpi7qF8eTFUbVqtjFmtDxw==
X-Received: by 2002:a9d:74d0:: with SMTP id a16mr3413937otl.47.1642784164101;
        Fri, 21 Jan 2022 08:56:04 -0800 (PST)
Received: from thinkpad.localdomain ([2804:14d:5cd1:5d03:cf72:4317:3105:f6e5])
        by smtp.gmail.com with ESMTPSA id y8sm1089271oou.23.2022.01.21.08.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 08:56:03 -0800 (PST)
From:   Luiz Sampaio <sampaio.ime@gmail.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-kernel@vger.kernel.org, Luiz Sampaio <sampaio.ime@gmail.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH 31/31] sound: soc: sof: changing LED_* from enum led_brightness to actual value
Date:   Fri, 21 Jan 2022 13:54:36 -0300
Message-Id: <20220121165436.30956-32-sampaio.ime@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220121165436.30956-1-sampaio.ime@gmail.com>
References: <20220121165436.30956-1-sampaio.ime@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enum led_brightness, which contains the declaration of LED_OFF,
LED_ON, LED_HALF and LED_FULL is obsolete, as the led class now supports
max_brightness.
---
 sound/soc/sof/control.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/control.c b/sound/soc/sof/control.c
index ef61936dad59..02e40aef9995 100644
--- a/sound/soc/sof/control.c
+++ b/sound/soc/sof/control.c
@@ -39,9 +39,9 @@ static void update_mute_led(struct snd_sof_control *scontrol,
 
 #if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
 	if (!scontrol->led_ctl.direction)
-		ledtrig_audio_set(LED_AUDIO_MUTE, temp ? LED_OFF : LED_ON);
+		ledtrig_audio_set(LED_AUDIO_MUTE, temp ? 0 : 1);
 	else
-		ledtrig_audio_set(LED_AUDIO_MICMUTE, temp ? LED_OFF : LED_ON);
+		ledtrig_audio_set(LED_AUDIO_MICMUTE, temp ? 0 : 1);
 #endif
 }
 
-- 
2.34.1

