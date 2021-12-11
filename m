Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21EED471743
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 00:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232279AbhLKXMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 18:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhLKXMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 18:12:20 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AACFC061751;
        Sat, 11 Dec 2021 15:12:20 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id bi37so24404583lfb.5;
        Sat, 11 Dec 2021 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ym10hnKuBcKIeD8nrAPP58e/kT21b1G7mLiKyPVSoD4=;
        b=E4wlOElmgq674cOJXJQJXdmVOktVmiFgjL5N4aj28JpOAZdJSt9+4bG7fgykIVrqa2
         At1U9jdqcTVZrBgym5DzdRTR5Q12P+JsrVNWkJkwkjcXVOppe1/92PR9yr1MGaAULjad
         1KzUsponnMNj9ks6BdyeClPCbe8txCoo9bUfIpXvZKe3SlovsXB9TQpbfucZKO0hcA0b
         m5qvGodI8eL0B9st8CUfHt4LGoAcnICxQUOUlXVHmeLQbJam230QznJ/8zsYFIH8BuVy
         cXn2mZSRRllixL6vj87XhkVW2RGN1RHF8ISureR1JTRPSGsgxp79p3UwAf2J2SbTss3k
         tifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ym10hnKuBcKIeD8nrAPP58e/kT21b1G7mLiKyPVSoD4=;
        b=k68BbjYF5BH25htjGAaIzMUyOR0CrgX3TLREjSQmc1+FasU44XqOsfA0OsYp8A2ZwL
         09PKYKxbmJ9gu6JH74p19lDQT2NhGXuDBvLNrm0aCPdJwTMHU7Atz23JkI0PBa9lSNn8
         nhtIy8VXAUnD3zQeOoTqPETi4qQYNzRbo/Jeq0CagNnHcPVnOZIwHcrx6TP2m395z+1p
         /0DGnpOAT3iW3pzmS5KlSjTG+KFs+D/L291qKrjmqMeHuLbF3UcwYkYEffN3idVkqxJX
         pjm7SjZrpAaycDJP+/p3rtrwv9Tf7s+dtRgXzrGk0v//v/rEOkfBiF/ZXRKOe19zHgRz
         nDrQ==
X-Gm-Message-State: AOAM533ahKHP9Dv2Jqza5MgQ4/tPeg0YNwir9NtG2x8oi3+C0MsXHCra
        qWr78XrmP1S6kmYKtSSDjh4=
X-Google-Smtp-Source: ABdhPJzNfB/rGRkTLf61EvGxKr6RAEK9Chuavx+JfSsufGjNr/bGWUj5dyCuKl8VcMqRB6aDPI3wnQ==
X-Received: by 2002:a05:6512:344d:: with SMTP id j13mr21650892lfr.347.1639264338308;
        Sat, 11 Dec 2021 15:12:18 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id t204sm793683lff.87.2021.12.11.15.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 15:12:17 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ASoC: tegra: Restore headphones jack name on Nyan Big
Date:   Sun, 12 Dec 2021 02:11:46 +0300
Message-Id: <20211211231146.6137-2-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211211231146.6137-1-digetx@gmail.com>
References: <20211211231146.6137-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UCM of Acer Chromebook (Nyan) uses a different name for the headphones
jack. The name was changed during unification of the machine drivers and
UCM fails now to load because of that. Restore the old jack name.

Cc: <stable@vger.kernel.org>
Fixes: cc8f70f ("ASoC: tegra: Unify ASoC machine drivers")
Reported-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 9 ++++++++-
 sound/soc/tegra/tegra_asoc_machine.h | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index f3e86bd714b4..a73404879aa1 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -124,10 +124,16 @@ int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_card *card = rtd->card;
 	struct tegra_machine *machine = snd_soc_card_get_drvdata(card);
+	const char *jack_name;
 	int err;
 
 	if (machine->gpiod_hp_det && machine->asoc->add_hp_jack) {
-		err = snd_soc_card_jack_new(card, "Headphones Jack",
+		if (machine->asoc->hp_jack_name)
+			jack_name = machine->asoc->hp_jack_name;
+		else
+			jack_name = "Headphones Jack";
+
+		err = snd_soc_card_jack_new(card, jack_name,
 					    SND_JACK_HEADPHONE,
 					    &tegra_machine_hp_jack,
 					    tegra_machine_hp_jack_pins,
@@ -660,6 +666,7 @@ static struct snd_soc_card snd_soc_tegra_max98090 = {
 static const struct tegra_asoc_data tegra_max98090_data = {
 	.mclk_rate = tegra_machine_mclk_rate_12mhz,
 	.card = &snd_soc_tegra_max98090,
+	.hp_jack_name = "Headphones",
 	.add_common_dapm_widgets = true,
 	.add_common_controls = true,
 	.add_common_snd_ops = true,
diff --git a/sound/soc/tegra/tegra_asoc_machine.h b/sound/soc/tegra/tegra_asoc_machine.h
index d6a8d1320551..6f795d7dff7c 100644
--- a/sound/soc/tegra/tegra_asoc_machine.h
+++ b/sound/soc/tegra/tegra_asoc_machine.h
@@ -14,6 +14,7 @@ struct snd_soc_pcm_runtime;
 struct tegra_asoc_data {
 	unsigned int (*mclk_rate)(unsigned int srate);
 	const char *codec_dev_name;
+	const char *hp_jack_name;
 	struct snd_soc_card *card;
 	unsigned int mclk_id;
 	bool hp_jack_gpio_active_low;
-- 
2.33.1

