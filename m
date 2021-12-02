Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C3946682F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359627AbhLBQa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359681AbhLBQ3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:29:41 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C07DC0613FD;
        Thu,  2 Dec 2021 08:25:30 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l22so72780702lfg.7;
        Thu, 02 Dec 2021 08:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OxcYUIueLlQa52jFEvuy/N4e/ZecehjJr4Gk4VLaFrk=;
        b=I36KU8MZVlIM3GrcPcUk71WextQQmOsKJ8L6PvyMA5NCP5WFFU6uZxN2ZXTVjc0QxY
         BfUMtdl3qwAZ31uIpKXI8Kj3I0AHT2j75uX/LMaZ8D92Pne7S4gUIt2d/yzcyQJBsBzA
         l8/Vdp0b/10Z6SBjsIFNBeylHjzKyJb99EpU5cr6XvuCGzxjU/Zo3gtFEJqL3TUsWezt
         xDeBtIAVLxNQz09hNenjujxy/LC7yybW7UQR2aW4i3UohNhaPPywhbjKuoDgZicqqJ6x
         xHajm9tPwhuQ/t78FZF2KI2dLyjvyqbwNrGr5Ce2yE6abqt7VS3DXBX6uowDzl9ljfnR
         5znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OxcYUIueLlQa52jFEvuy/N4e/ZecehjJr4Gk4VLaFrk=;
        b=yrCPeg0G7WLSkwaa4Rr2yKApCkmSsr0BF+VZvHoMFgSsIeQwrJhSswQH0bXZBJnOXr
         UYG2r5CGn5qlSCjiUIc8lxTyX2zi3ej3+TuUX0Df5yw03RHfOE6CtEcF0ev2YwjuRWEg
         GswN9ZyQxfEVqZdh2qWCr2J6FsNWgkOXgZUmMpM/oLpSc3z3LV8AHNeUnlXUBlAu/Bg+
         dRSGI94MRSY4XVdU0o07P3/J86Qw1IETSC7tdIQ8KRc95CQcpyPGxgXQKcMUaREnoG0G
         UyvIMb0ejn9PmUQQAngtAlXU+59ANOfo72w14+PXKDeQxJCYvJV8EOhAWMhEYFgQrYHJ
         GGjw==
X-Gm-Message-State: AOAM531XHxB52+vqZiPK/CSBp3A1oVPZkv/NBXR9awdJDWANTjxE4vFY
        xuIJ6v3Pk8eMKKafoqPKD8o=
X-Google-Smtp-Source: ABdhPJy5alaon9JWfGyAgcM+Lp6GPPApvSuwcMDKG9goTRM8TzwT6/nCrJurJ/RP0JtE1gz6hhWriA==
X-Received: by 2002:a05:6512:3251:: with SMTP id c17mr12374298lfr.440.1638462328985;
        Thu, 02 Dec 2021 08:25:28 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:28 -0800 (PST)
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
Subject: [PATCH v3 14/20] drm/tegra: hdmi: Unwind tegra_hdmi_init() errors
Date:   Thu,  2 Dec 2021 19:23:35 +0300
Message-Id: <20211202162341.1791-15-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
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

