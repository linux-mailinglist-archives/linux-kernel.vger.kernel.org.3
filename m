Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFADC4B5CE6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 22:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiBNVfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 16:35:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiBNVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 16:35:00 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60B2158798;
        Mon, 14 Feb 2022 13:32:26 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id c192so10338847wma.4;
        Mon, 14 Feb 2022 13:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYGIU0lBgl4d0sNWP4gNGrwgFdAF2VqmrC+fnt5WHX8=;
        b=lEibEIIHHaNkCIBCOonaCkB5WT0qXvdINVme8DbMAQ4gXD8Y8gZ7MmRFtd+jeI340G
         P3yf2zfHNl4eNYBwgYS2eODg+RA4I5mMh1mCS+Lsd+UlvDz55haq+BGGz2DX4ZB3rtAo
         B7HUaJ0ax5xaUp++lwEdMWrz65Ju6n935WWXFf38LS6uYUOqNAD5fRcTd3xzF2R3J3CZ
         L5pZq0TOkqyPaqpej5PXp/t89XLsmWFHUYxavOGXBPiE0pNqlCvoX0ifpawuBMaanR7a
         hAU0T9yUZknzlJnd9XDhiGBMjpXYDKAzF+6oK2uqe197+OOhOiRiJba/J48mBYHoIjwn
         XcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYGIU0lBgl4d0sNWP4gNGrwgFdAF2VqmrC+fnt5WHX8=;
        b=rb3yvXW62IM0hvQQX7fAgqOjBtKs82xeoP/E4OgUPtalPg0/0amQmJ0d98b/4Lveqm
         fv5FcNLz2dIyXq2IS7R0l5P2Qp8IXyi8l74+WHup3nW2AjKtA8mDWQM1RgxEDD8H3SXk
         7lPxm1o62i/AqcO8s1IHez8Lg2rxVA5txFvuTIdyYkjR4b6IZ58jGQP3bYoSF6nD/mlH
         W9HRV74kbG9EViHRxbGhjL5bFeLFPS/h5617+74HIvEkWdoL/xiwoVVF1FOYYktPBTrV
         eSdx5cuLFKASIXbE/3S/tM6Okr63DFzzu4IpN9bY7lxqjpySH8s17ub+NgoMHLSBSKYW
         /LIw==
X-Gm-Message-State: AOAM533zGAbPUrun+KQ1KOwGxpwLN+JGvWv1YtszM2sK5u0WsHUayA6N
        KJnbVUnDMMfCnV9EVaXl9GE=
X-Google-Smtp-Source: ABdhPJzA+5buwGThU/StogQFez2aB+m4K2P39OqNL7jF9GJPAEIJXA4IsgbPmSGM6C562aVhBfktGg==
X-Received: by 2002:a1c:7318:0:b0:37b:fa1b:1472 with SMTP id d24-20020a1c7318000000b0037bfa1b1472mr496215wmb.57.1644874345208;
        Mon, 14 Feb 2022 13:32:25 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id 3sm26537410wrz.86.2022.02.14.13.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:32:24 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tegra20: spdif: make const array rates static
Date:   Mon, 14 Feb 2022 21:32:23 +0000
Message-Id: <20220214213223.65780-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't populate the read-only const array rates on the stack but
instead it static. Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/tegra/tegra20_spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra20_spdif.c b/sound/soc/tegra/tegra20_spdif.c
index d09cd7ee6879..64c2f304f254 100644
--- a/sound/soc/tegra/tegra20_spdif.c
+++ b/sound/soc/tegra/tegra20_spdif.c
@@ -186,7 +186,7 @@ static int tegra20_spdif_filter_rates(struct snd_pcm_hw_params *params,
 	struct snd_soc_dai *dai = rule->private;
 	struct tegra20_spdif *spdif = dev_get_drvdata(dai->dev);
 	struct clk *parent = clk_get_parent(spdif->clk_spdif_out);
-	const unsigned int rates[] = { 32000, 44100, 48000 };
+	static const unsigned int rates[] = { 32000, 44100, 48000 };
 	long i, parent_rate, valid_rates = 0;
 
 	parent_rate = clk_get_rate(parent);
-- 
2.34.1

