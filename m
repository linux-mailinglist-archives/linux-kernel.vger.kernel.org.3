Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E0468589
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377680AbhLDOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241606AbhLDOlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:07 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0399BC0613F8;
        Sat,  4 Dec 2021 06:37:42 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id z7so13728700lfi.11;
        Sat, 04 Dec 2021 06:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4TNl0maOw+qQ0xQdJvO/oCdL3KHkM/Dk/mjk1tn/kI=;
        b=COMMbo7ny6O2X7VC2bO3A8YCnuhGGEFEaUha/goMyT5rSXGmnf65P2mapZ5oZzbmG4
         ZEZhwX2qHGjLs/Cn/xlZT5jlT90jNksb6FW/Tz9DNLHNhFMtt/booCU7gU+Jhw+aaNp9
         CJp3S0FM89SUomn8FX5wKwj2yMYh3o/X3wttFD6ip9LWGFaAnmMoh0x6eBtHqHImiRKu
         M8iC+nGIW9lkd4uC4TICm8SNvPpoSBs+C6Q8U4Fxr+xuf7FSoHyB5Yr/xTMEF6ZPN7q3
         RW+5PyoDmQbxH+ezEZdEur+pRt8XQOteoKEeaZAKVaVBt+vlX3nVmax/ugJrEf3G+gtH
         Ot8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4TNl0maOw+qQ0xQdJvO/oCdL3KHkM/Dk/mjk1tn/kI=;
        b=PDkq/7RUJI+ulgiObFKKwZ2wm58rIQEjysUfQJXjjiXtjzwMB8rvNL4dhSSTW6IUwb
         dir+6+4xQIswz6Sz1nbis/Bp+aJn4E7Zngl2VCwm/VqcKhf0gQzwh3b+7SVtEmw/bFNt
         ZjQ4GKPX8N5PZFrOct0szwLtYVr2uqGM0kCO7OTCL+3JxWTmmqawempHYwByL+p8zvRI
         /NhNpjwP+kHB4Fta1TxRYUrJ4jIUqZYsG+x7E3kkBclRXBlN5HKNOHJ1EmqYF2QFwga+
         OFhDyyesKEh8vUp9+FE+lrEO4KSFb+70a5CPBfDgzvSYbBl0SPp+/a0fPsI6fwRbZORc
         DQdA==
X-Gm-Message-State: AOAM5323qcbItKQf+oQmoXmViZwxAp0qtvXgcBi0ZONRaqjKdOxismXv
        JMt87rgYx8hYVeFSpzad2Lc=
X-Google-Smtp-Source: ABdhPJwBGwFZ1VAmA8VX6TtGQ+4nXtKkxDzfgCjkV2ceUAS/H+mhlKQL1kqjfLM7Div+f7+OlDjKAg==
X-Received: by 2002:a05:6512:3d10:: with SMTP id d16mr23491738lfv.78.1638628660353;
        Sat, 04 Dec 2021 06:37:40 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v4 11/22] ASoC: tegra20: spdif: Support system suspend
Date:   Sat,  4 Dec 2021 17:37:14 +0300
Message-Id: <20211204143725.31646-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support system suspend by enforcing runtime PM suspend/resume.
Now there is no doubt that h/w is indeed stopped during suspend
and that h/w state will be properly restored after resume.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index bc45a0a8afab..a4aa5614aef4 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -345,6 +345,8 @@ static int tegra20_spdif_platform_probe(struct platform_device *pdev)
 static const struct dev_pm_ops tegra20_spdif_pm_ops = {
 	SET_RUNTIME_PM_OPS(tegra20_spdif_runtime_suspend,
 			   tegra20_spdif_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 };
 
 static const struct of_device_id tegra20_spdif_of_match[] = {
-- 
2.33.1

