Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81ADC471741
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 00:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhLKXMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 18:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhLKXMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 18:12:19 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF48C061714;
        Sat, 11 Dec 2021 15:12:19 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id m12so18703472ljj.6;
        Sat, 11 Dec 2021 15:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPxf9grrnoWloQst2uU9IfqibnQT7tauNIkF1tWEVPM=;
        b=iv1VPRF+eoCMivY+B3upLgqHfCb4yEjs/UwpHIyzSI3osJrZtB1Uq4IM2Keaz6gflL
         o8nurH5MMlhEda26gC433U5qD5D+Q3FaV9OsfIyVxjFOVSjXN3nLmMjeWzmb/N8tq0D6
         09hvmSkKcZm5NwuqSteHIBZtZuNtfurf3sQPyi/Cgdtxw5SD2rxmO81Yc+R1P0X9WtXl
         Q6h3vt8JU7EyWrJ5/oZ2qHtOxQZzveu1w8apbHDCXuEJH/+BOWmUAfoC+oy1JCAtoUuJ
         45VhxEEc3FrvaiWKl8VDfCNJKDgopkHDT6DjaCZ++UlX4gk2FQQ8a+8sITwjaTTBCon0
         Pdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kPxf9grrnoWloQst2uU9IfqibnQT7tauNIkF1tWEVPM=;
        b=RukHX/CNkXFiREGE0sa5Hv7GqHnbP6hb0TsYXU/5uEpUrCJn8w6HhcHTxZAozvCQoe
         hiMYd8uVUu89G29/wkX7esWIiD+DpFfbiYeq9A9g76IClNvjIs9rJxBOhbmvmAIbXV/v
         YxpPVqDhfFZHoHH53MZEj9Bnaw5B7pzc4lp36ySYn+xJ38WqYwADlnd1JFSYdKYMP3Hw
         qTsZ1Yjf3k1v/vJjBvqxcJdPPWusnIzd2v7ogWNw5GsD++AOst7fJA4V/huabgAyCwmN
         QS07KvuPT7tmBgEuOcl6O0DaZd+tYN4Cy/HMe0JXigDofKNcEBB4gv8g72zvYuLca/Vp
         WNiQ==
X-Gm-Message-State: AOAM533YE6mEsVQ+7Jy2X/Ddb6r+rTqVnBjAttudx6WgW65xx1ZxG81M
        m2UtwPvdbT+MP1QRZqsZtCk=
X-Google-Smtp-Source: ABdhPJz6U8F7uSQT0Ay6KQjB8ZUSZ03cdHyOnttDpC7Q5jA4IEL7tkiNymo0ZLbxwH4T2DRTMeznkA==
X-Received: by 2002:a2e:700d:: with SMTP id l13mr20988515ljc.219.1639264337371;
        Sat, 11 Dec 2021 15:12:17 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id t204sm793683lff.87.2021.12.11.15.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 15:12:16 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Thomas Graichen <thomas.graichen@gmail.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] ASoC: tegra: Add DAPM switches for headphones and mic jack
Date:   Sun, 12 Dec 2021 02:11:45 +0300
Message-Id: <20211211231146.6137-1-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UCM of Acer Chromebook (Nyan) uses DAPM switches of headphones and mic
jack. These switches were lost by accident during unification of the
machine drivers, restore them.

Cc: <stable@vger.kernel.org>
Fixes: cc8f70f ("ASoC: tegra: Unify ASoC machine drivers")
Reported-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Tested-by: Thomas Graichen <thomas.graichen@gmail.com> # T124 Nyan Big
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra_asoc_machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/tegra/tegra_asoc_machine.c b/sound/soc/tegra/tegra_asoc_machine.c
index b95438c3dbf7..f3e86bd714b4 100644
--- a/sound/soc/tegra/tegra_asoc_machine.c
+++ b/sound/soc/tegra/tegra_asoc_machine.c
@@ -116,6 +116,8 @@ static const struct snd_kcontrol_new tegra_machine_controls[] = {
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic 1"),
 	SOC_DAPM_PIN_SWITCH("Internal Mic 2"),
+	SOC_DAPM_PIN_SWITCH("Headphones"),
+	SOC_DAPM_PIN_SWITCH("Mic Jack"),
 };
 
 int tegra_asoc_machine_init(struct snd_soc_pcm_runtime *rtd)
-- 
2.33.1

