Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62EAE4900F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 06:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiAQFD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 00:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiAQFD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:03:27 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71953C061574
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:03:27 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id h11so28357213uar.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 21:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FiX6saUHa8tVXRR2pHw4nDfUBFLj+hL82kG5LF2eBdE=;
        b=Pe8h9X12WGtdQqLsjvkYCgh9YwVwNQuiyWCD+D2ElDyMJEpxjbgr+/kWvuhVCNuBSd
         lCwAseOQfu1D7csJyUCRDAFi3oWkZ+40OCZTXmHZ0zlm/8LRQJ5Azerhk43bixsiq+ND
         eRDh0lAxFiQvOT1siqzq+AP472Sr+UMTMpAVWUlczMTRqZk9JOxp6Ad9R6HLJeE8i2IK
         ON4rwGJc3vUyue1cZwO2b6nYWD1xrObw2ydur/Zcn/e9UzlSPOs8c4oS4fKbJSP8ut4J
         b5j4Jn43pvSZ/Y55Qj6o4ujfNItonT+WjEKYL5qrTmiywCLAW1C8+oylFsQAx9l6P0E2
         Bn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=FiX6saUHa8tVXRR2pHw4nDfUBFLj+hL82kG5LF2eBdE=;
        b=EYiMPzCErSJd0BIYFelSzAxfY5UyngF/X3znHOfaRk8ZVPqmv2g/X3i3ffagxZOXt1
         O42PdHsPrydoROUif6F9Xv/bFOaD2PwllmGLT7zSx43GcwbJHTynlFQ/jZ93RAe/Q9Zn
         DuetVdA6fEPqqRNklJVeP7wekD70nR0dwv0TYOq+nyFwaBb91NpYYIEn3HSBDhGM07a4
         LzNdb6A6dCk3eWnk48KPuJe8OX4sTuhaDyQz7C5NNK83SBqp1LUQf1ivf7beSlJSqB+c
         vos5Jj7ae4LaGKmZEohcxnY+EnLXGvNE2swmO0GCgHkejEi79qwGkD2x+larAsw7Oqg3
         rzDw==
X-Gm-Message-State: AOAM530zRlm+hXWIkILQ/GBlbFA21p2BKIR2UlKePvrhmgkoyodgdR2k
        Ug7ozvTxGciCBP3xvJr1Mm9CrD2vCHFxI3s3
X-Google-Smtp-Source: ABdhPJz76tG0q0wKXnD43AKOEaEGErm27DJnaqkJ7NI14WMk3UwR/gAtlSgheL3vdfuM0t+KzW6FhA==
X-Received: by 2002:a9f:25b6:: with SMTP id 51mr7935322uaf.111.1642395806522;
        Sun, 16 Jan 2022 21:03:26 -0800 (PST)
Received: from kubuntu-desktop.. ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id k77sm1012686vka.20.2022.01.16.21.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 21:03:26 -0800 (PST)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, geert+renesas@glider.be
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, fazilyildiran@gmail.com
Subject: [PATCH] ASoC: mediatek: fix unmet dependency on GPIOLIB for SND_SOC_DMIC
Date:   Mon, 17 Jan 2022 00:03:24 -0500
Message-Id: <20220117050324.68371-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SND_SOC_MT8195_MT6359_RT1011_RT5682 is selected,
and GPIOLIB is not selected,
Kbuild gives the following warning:

WARNING: unmet direct dependencies detected for SND_SOC_DMIC
  Depends on [n]: SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && GPIOLIB [=n]
  Selected by [y]:
  - SND_SOC_MT8195_MT6359_RT1011_RT5682 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && I2C [=y] && SND_SOC_MT8195 [=y] && MTK_PMIC_WRAP [=y]

This is because SND_SOC_MT8195_MT6359_RT1011_RT5682
selects SND_SOC_DMIC without selecting or depending on
GPIOLIB, depsite SND_SOC_DMIC depending on GPIOLIB.

This unmet dependency bug was detected by Kismet,
a static analysis tool for Kconfig. Please advise
if this is not the appropriate solution.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 sound/soc/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 9306b7ca2644..0d154350f180 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -216,7 +216,7 @@ config SND_SOC_MT8195_MT6359_RT1019_RT5682
 
 config SND_SOC_MT8195_MT6359_RT1011_RT5682
 	tristate "ASoC Audio driver for MT8195 with MT6359 RT1011 RT5682 codec"
-	depends on I2C
+	depends on I2C && GPIOLIB
 	depends on SND_SOC_MT8195 && MTK_PMIC_WRAP
 	select SND_SOC_MT6359
 	select SND_SOC_RT1011
-- 
2.32.0

