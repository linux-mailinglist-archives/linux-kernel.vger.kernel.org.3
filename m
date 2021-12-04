Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56D4D46858F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385211AbhLDOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242841AbhLDOlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:41:10 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5D4C0613F8;
        Sat,  4 Dec 2021 06:37:44 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b1so13693175lfs.13;
        Sat, 04 Dec 2021 06:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxcYUIueLlQa52jFEvuy/N4e/ZecehjJr4Gk4VLaFrk=;
        b=d4JHR4e9Tfq2drgPiQPOEWI/A9kfWJA+tfced71PQBHCRUEfZsydKbZhpd/5ptbv1j
         w+PGcxYbFFThWeum/lgKvwUVn+2Btl6QdzG9ojRhj3jVeqVzY7numyCvU8YBxFh1aec1
         dI7L2o2Io/20kOjxQDwxBdUbHUPOvYJChvySM6hzMlhawgNxNHI96mFcxjnLxaNezIFj
         K3UvzRePyvLb4V7bUsUKIb2PiptOuQglxAVXybFqiUWZljVUA1F0epLPeS2S13Pdcp6Z
         ooo++s9sqkOF6jKlWazC/SzHdD/295aQ54ax40XBjRNqTjb7uzDTQX/Oi8Wlf80W+P+a
         1rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxcYUIueLlQa52jFEvuy/N4e/ZecehjJr4Gk4VLaFrk=;
        b=pDryU9pWk3uMCmhZ2K7uQVLWF2pUds2MfS4JdQuEeK7puXtb3XEx9+LjYGnJ7+u/kF
         Q0X99dHTkwVKy5t8oCuxsScmbIs/69o6kr8bW8xXE/oKV1ep6w5nxazvA6nJ2PDTNjdb
         SYksmqDG2chyAWERDwoQtI/7SrqkOslGqiU8vAMDdXSlW7z+ch5gCVZG+xOb9e2iLhnX
         eMDGloDVo1HgTtD84W4YrxCwBjJpp9V1Uc9Crs5c6d/6kHpTtPMLJyfjWWYHFUDBqP0K
         PqSgt0rf59AR+D3se46cyF8c8Je5r4KXdg+LBOajCaBS/1bMu6KLVvL0iYey+Q/7vayM
         fOsA==
X-Gm-Message-State: AOAM530mum18urV8R8k1HTSnfWfta4dlLRfQwPDMV1I6lXXFHjHpw2do
        5JCNe/amzVVVGrK+ixV9cIw=
X-Google-Smtp-Source: ABdhPJxlgKfJiD7JvMzK1OyvgCUJ5A1miPAL4icM4r9MPzx1Ky/E3f131wx20rQata12xqR1oKlQ9g==
X-Received: by 2002:a05:6512:234c:: with SMTP id p12mr23603437lfu.157.1638628662905;
        Sat, 04 Dec 2021 06:37:42 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id g36sm782934lfv.16.2021.12.04.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 06:37:42 -0800 (PST)
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
Subject: [PATCH v4 14/22] drm/tegra: hdmi: Unwind tegra_hdmi_init() errors
Date:   Sat,  4 Dec 2021 17:37:17 +0300
Message-Id: <20211204143725.31646-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211204143725.31646-1-digetx@gmail.com>
References: <20211204143725.31646-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing error unwinding to tegra_hdmi_init(), for consistency.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/hdmi.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
index 3242baddc5e7..cc42476fd023 100644
--- a/drivers/gpu/drm/tegra/hdmi.c
+++ b/drivers/gpu/drm/tegra/hdmi.c
@@ -1456,22 +1456,31 @@ static int tegra_hdmi_init(struct host1x_client *client)
 	if (err < 0) {
 		dev_err(client->dev, "failed to enable HDMI regulator: %d\n",
 			err);
-		return err;
+		goto output_exit;
 	}
 
 	err = regulator_enable(hdmi->pll);
 	if (err < 0) {
 		dev_err(hdmi->dev, "failed to enable PLL regulator: %d\n", err);
-		return err;
+		goto disable_hdmi;
 	}
 
 	err = regulator_enable(hdmi->vdd);
 	if (err < 0) {
 		dev_err(hdmi->dev, "failed to enable VDD regulator: %d\n", err);
-		return err;
+		goto disable_pll;
 	}
 
 	return 0;
+
+disable_pll:
+	regulator_disable(hdmi->pll);
+disable_hdmi:
+	regulator_disable(hdmi->hdmi);
+output_exit:
+	tegra_output_exit(&hdmi->output);
+
+	return err;
 }
 
 static int tegra_hdmi_exit(struct host1x_client *client)
-- 
2.33.1

