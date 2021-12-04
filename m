Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D33F468457
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352709AbhLDLMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350310AbhLDLMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:12:21 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114F2C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:08:56 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id i63so11251377lji.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EE2Aep+jzbNqeFIyDplIxE6aoRA2LQ+0Z3/L7vZF67o=;
        b=VkyAlKODkweCl4uYOVgFOaCyEaVJQwOIfx7o1nriD6KMOg0uThbCiFgNzvZf4nMy1f
         bABo8G2x62Nwq6qGlxemlgDCvNMonPRQwBF7FVG7aNvj0osuPLFXtMorzLubywKq8Uwx
         LfPuOGstqgkdTcoQq1XicAMbs9B/E2F45T7Q3Kkzg6eAoHG2ayBqgvtiK0tvmF63n0VP
         sWZS/tX4leOdcPJPTq+p9v4XrPIjtVAitiG+2PfEVr9gM//giBIJGwGXYBxUrfJ1cF5o
         YTUtyzu43K7wZ6EDVoBhafSAuMtLxzTMF2ZOgknNyknyE/L6pvgwhz35BpkjhkxGpciE
         6A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EE2Aep+jzbNqeFIyDplIxE6aoRA2LQ+0Z3/L7vZF67o=;
        b=VwZPtJLHh23lWq9LucfMC5EXWwhtmORh5Openvx31UzFkRIOak3PiBaPkJjDsxta4f
         3YPNns+h3AialNj9OQodSbuOOC412sY00F9+HWgfVUB0Q4RAoO0In4boV32R/3aFlZsE
         DiC4q02pT9grMDrcfc7XbzCj0YqYpXBHvsOcAlrlFdDWQRUvWGLeHfu1t7jCTfLiQwTl
         igq0jRFF8ZVjVRDy2+5mRFCJgm7LfFNxU5bKjbc0BH7z6xyQ7N9m2u+6jehBS7R2dg/6
         ewlKVrBmDJHlNGz7sN0ReEmw1l5tt6zNfJgWQVvW5GFjRgNwCSBHvsVzrn7o1O5OYwIc
         TT8w==
X-Gm-Message-State: AOAM532ZTd8rGlVkcrJYK14/HVwqtZAKToa3yFnIFN0yThMtrIsy1bqm
        4bBMidzSYy/lMMo7Q6HBilQ=
X-Google-Smtp-Source: ABdhPJyhhMJAekexkhVaSN1HqWhcFK5cczGTw1oAaXDgTGPyddkMDM9bs2c1jJFfrysr1i4qkNI7Tw==
X-Received: by 2002:a2e:b5d2:: with SMTP id g18mr23741985ljn.354.1638616134335;
        Sat, 04 Dec 2021 03:08:54 -0800 (PST)
Received: from localhost.localdomain (h-155-4-221-129.NA.cust.bahnhof.se. [155.4.221.129])
        by smtp.gmail.com with ESMTPSA id h8sm724538lfe.94.2021.12.04.03.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 03:08:53 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] ASoC: amd: acp6x-pdm-dma: Constify static snd_soc_dai_ops
Date:   Sat,  4 Dec 2021 12:08:48 +0100
Message-Id: <20211204110848.21322-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of acp6x_pdm_dai_ops is to assign its address to the ops
field in the snd_soc_dai_driver struct, which is a pointer to const
snd_soc_dai_ops. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/amd/yc/acp6x-pdm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/yc/acp6x-pdm-dma.c b/sound/soc/amd/yc/acp6x-pdm-dma.c
index e604f4ea524f..7e66393e4153 100644
--- a/sound/soc/amd/yc/acp6x-pdm-dma.c
+++ b/sound/soc/amd/yc/acp6x-pdm-dma.c
@@ -318,7 +318,7 @@ static int acp6x_pdm_dai_trigger(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static struct snd_soc_dai_ops acp6x_pdm_dai_ops = {
+static const struct snd_soc_dai_ops acp6x_pdm_dai_ops = {
 	.trigger   = acp6x_pdm_dai_trigger,
 };
 
-- 
2.34.1

