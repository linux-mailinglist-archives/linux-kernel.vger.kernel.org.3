Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB57D46681B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359514AbhLBQaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:30:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359676AbhLBQ3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:29:40 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB2EC0613E1;
        Thu,  2 Dec 2021 08:25:28 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b40so72785475lfv.10;
        Thu, 02 Dec 2021 08:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I4TNl0maOw+qQ0xQdJvO/oCdL3KHkM/Dk/mjk1tn/kI=;
        b=q69PrNnnB342xHj0Cmqq2IVpuiQ2yIr1SiDnwh853ktdMDtdg2yLC7IW7gqRU4i6/U
         5nKC8Jp00I0jT4jKqq+MuCr4Z4iDPu+tBACGO5C7TYYhrCPaNBaxyj4V10DohzUP9wD/
         5OXCvt9fdCHB0NcTEHQf58Qiaj6Qs0YNyJ3mawa5+QnakKhRkEZO/+6AJoHjpf3C6gG1
         5ER80osacA2YezjNOQZ8SmyD85KO87uHQL7SPIpDejg6m3uyLioFtPKYKnRrNDk2z/si
         ymaCyxjh9lLmGm1XlzjUWX1olcNo964QNqvZTbdt6kcNceEvlsWzqTK9/qJRnRE89zN1
         WsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I4TNl0maOw+qQ0xQdJvO/oCdL3KHkM/Dk/mjk1tn/kI=;
        b=QPMmiie0n2Npkh4huazZo9XULyCTsiGlop4QnA/GGFCOd5oqlyNCp8Do/Vhr2t9gb2
         Gz6ZAesMhhirndFHhDI9+47PM/bTl87kK+3HjUT9bD1qsuTGjXUg9S7yq77JQ573e8HZ
         TI6Z7kgIUbh04Oazi9kfSyVGMG1buQU/0jRwo1g/DKL/wgNycrMtCCaGNqSTu5d78ayR
         XlF68D1uahmHI2ETtwd4TL3hfAe9OE3G6YfyXKEymbFk6ro/MYBr5eMi9rDLPS6lzusb
         PP8qY/rxXzjxbvJETv9aLVrnYbeoiTBAP5wcOM92c6lx2g0QG6eCZsAXGG+ceNFcFcSn
         oXZA==
X-Gm-Message-State: AOAM532ItmgZDPcB3B5dhCtYSvojSEdQKP8GyOIEmk/FyOvnXj0Zkkve
        lL22En5n1fhLdDbWaxmCi/4=
X-Google-Smtp-Source: ABdhPJwz0qeqhDbbsnUNCtz+fTMa7GcVlIXkWFGDQHWdI9fpFBeUVePGAgCtQXEjmzk6lOE1dH7qyw==
X-Received: by 2002:a19:6b08:: with SMTP id d8mr12695068lfa.39.1638462326465;
        Thu, 02 Dec 2021 08:25:26 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:26 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, Rob Herring <robh+dt@kernel.org>
Cc:     linux-tegra@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3 11/20] ASoC: tegra20: spdif: Support system suspend
Date:   Thu,  2 Dec 2021 19:23:32 +0300
Message-Id: <20211202162341.1791-12-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

