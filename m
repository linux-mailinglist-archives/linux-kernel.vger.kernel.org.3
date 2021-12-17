Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE5547935D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbhLQR6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:58:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240013AbhLQR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:58:12 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC486C061751;
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id a37so4537606ljq.13;
        Fri, 17 Dec 2021 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=btGZfuKkvHGlpDu1vpCSHhDujyvUpwrfJCWjKl++rLQ=;
        b=hTeyIA3ZMR1GhJuhwrMK33OO6tU4vclI8f1veWvFSxUY32rLFMAmHLt1tF9OU0+BXt
         V8V7ezaLiZ6dtUp/Tdhhz4QLhbJwRVqJmY1ECIqUgOJ4K1GZ84CLz1wO9EmEZIUrk7k0
         UkKZhLQBBvDUbnuJv98SnQQRZsHAQJgc0wd4JlA5DL11S+xtIScRTIyK71r0mY7WxBH2
         eTCkSZ9umnI5ZasO6qcp+6wPQ1cFpSgKQ/Xfz0YmFfLsRpp9L+KtauwBTV+crq642CLp
         GysCVKk6qi6IhRxGLdRTXCjbw8iN1bor/3Qa+ARhNPYp7ThEFNDmJUUNcpGGOf2F/o2L
         qxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=btGZfuKkvHGlpDu1vpCSHhDujyvUpwrfJCWjKl++rLQ=;
        b=bYl6UNMgUMBhFHfjjbkyt14gg++9jBjImTFzQUOrR7YaLPGSc7wh1olDhjbqrdb5dn
         +E3NRKZe/5w5tVsDNrbUkwVuM3i6RYoarwGj5q0kmbsPeFtmd3FWyrMISNeOcIATdsWV
         /QQyFdzWJubde/CL/S8odgkWDKP1YaSgcz9U89zBROJQeDpe13BoyMzohjGcGp4d8LSw
         jL57jKEkAwO3cwLahfLex8MTfRNf9QSBsmWYv8ZIkJ9dqdKKgTv6c/MKAWwfCwJfdbnL
         3kuTfQ6Uz2lihyckXvFfOZz3P0zoLkBU7EBwy622LDydIbOKjGRyDBUpeGiglzhcL8NC
         NYcg==
X-Gm-Message-State: AOAM531Fd+pvPT/hzHnJCSegBvIT7or8FsShyiWRl78E7ch8KtlHKGQy
        vntOziNKtFLIb3axGKa9E/M=
X-Google-Smtp-Source: ABdhPJwc6k2Csr10tHFwoicg91w/boebavr0X5MJSYT45hxlb3vZvhXbsT4HBnNCjE7+UvzLbzTfbA==
X-Received: by 2002:a2e:548:: with SMTP id 69mr3636945ljf.225.1639763890228;
        Fri, 17 Dec 2021 09:58:10 -0800 (PST)
Received: from localhost.localdomain (94-29-63-156.dynamic.spd-mgts.ru. [94.29.63.156])
        by smtp.gmail.com with ESMTPSA id w23sm1479244lfa.191.2021.12.17.09.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:58:09 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 09/11] ASoC: tegra20: spdif: Support system suspend
Date:   Fri, 17 Dec 2021 20:56:04 +0300
Message-Id: <20211217175606.22645-10-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211217175606.22645-1-digetx@gmail.com>
References: <20211217175606.22645-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support system suspend by enforcing runtime PM suspend/resume.
Now there is no doubt that h/w is indeed stopped during suspend
and that h/w state will be properly restored after resume.

Acked-by: Thierry Reding <treding@nvidia.com>
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

