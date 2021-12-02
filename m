Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDC534667FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 17:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359600AbhLBQ3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 11:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359483AbhLBQ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 11:28:45 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674C3C06175D;
        Thu,  2 Dec 2021 08:25:22 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id b40so72784842lfv.10;
        Thu, 02 Dec 2021 08:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwvCc+bauYKKq4pTyZaKz2pCnGZty8ijk6MykhM6LJk=;
        b=oR1svtpFFFrX6rnK1/i6hTs3JfvrWzZLGz+BNZ7MGG1iAqeVqZHD5xG5kTrA3u/jSl
         s15Q6dojw39Auj8CN0XO2FI5wmxyYl3p3EKf7mDJAku4r7BNCwqds3yBkDHyAXaGCQxy
         GduQFHq10+2oaKKnx2+2SBJO+ke+fYSB+k1qu7/5ltFxZ0wOj5tcFqTA3sw13+Y24oeg
         94WOSY8quWXzpexYWKXqSJDuZA9AEGEtLlVtS0kFGLiDqnqWh5e497qz21iuFqaj8wAj
         hs+P2RIRIOA5/frljQdARGykDlBwPfTEnDuzJmYOkREs9EkQbmzzXMrUMLl1BArGClaz
         xh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwvCc+bauYKKq4pTyZaKz2pCnGZty8ijk6MykhM6LJk=;
        b=fFCWRilZ7QN2ujs3Lr0yJcogiW9Jq/CbGitezylkjfKIM5VwxfLCEZG+VKj2gckmNR
         5nziM1Wtg0YSDKIHmoNHNw+6Lj4uFLsP+uJt00JueK3xw4NL2BPppc8LremMRIzumJCa
         fJn//bIn9ei8S18o7G8vC4zIbEyv8N0mjsu7j3zPqlEI3o0ZHxqNAydcV22RKZwh8k6y
         JN+w6G/DUeXMkOJxE4cs8UyWt96VXIFa4JYvbzyNcWsv5nuSS/IYYo4uKBCVl0L+8cNw
         IJBmfQvGQNGQWSY9QEnZ5c0t1VRNYWpuGwV3MynlabT2/bJZau3Cjs0+/oF/S1wBGb1w
         XPDA==
X-Gm-Message-State: AOAM531sZOm//KF3GjKp0WxQnPH4+JYhUIA5FuVSUurAK4VgfvDnIPxh
        q0qGRSvSi2yi8NxyuXflojA=
X-Google-Smtp-Source: ABdhPJzzfGS2ufUUhP2/9TRcFenSN5tQ2vXd3c+kggMycyFqzrFJs422Hi0yfHfkBSOhAXlwwSc3Kg==
X-Received: by 2002:a05:6512:40c:: with SMTP id u12mr12933189lfk.473.1638462320726;
        Thu, 02 Dec 2021 08:25:20 -0800 (PST)
Received: from localhost.localdomain (94-29-46-111.dynamic.spd-mgts.ru. [94.29.46.111])
        by smtp.gmail.com with ESMTPSA id d18sm36806lfl.30.2021.12.02.08.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 08:25:20 -0800 (PST)
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
Subject: [PATCH v3 05/20] ASoC: tegra20: spdif: Set FIFO trigger level
Date:   Thu,  2 Dec 2021 19:23:26 +0300
Message-Id: <20211202162341.1791-6-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211202162341.1791-1-digetx@gmail.com>
References: <20211202162341.1791-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIFO trigger level must be not less than the size of DMA burst, otherwise
audio will be played x4 faster that it should be because part of the DMA
data will be dropped on FIFO input buffer overflow.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index 7751575cd6d6..6f0570cde964 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -69,6 +69,14 @@ static int tegra20_spdif_hw_params(struct snd_pcm_substream *substream,
 
 	regmap_update_bits(spdif->regmap, TEGRA20_SPDIF_CTRL, mask, val);
 
+	/*
+	 * FIFO trigger level must be bigger than DMA burst or equal to it,
+	 * otherwise data is discarded on overflow.
+	 */
+	regmap_update_bits(spdif->regmap, TEGRA20_SPDIF_DATA_FIFO_CSR,
+			   TEGRA20_SPDIF_DATA_FIFO_CSR_TX_ATN_LVL_MASK,
+			   TEGRA20_SPDIF_DATA_FIFO_CSR_TX_ATN_LVL_TU4_WORD_FULL);
+
 	switch (params_rate(params)) {
 	case 32000:
 		spdifclock = 4096000;
-- 
2.33.1

