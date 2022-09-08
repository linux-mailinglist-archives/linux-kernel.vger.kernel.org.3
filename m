Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE7A5B21B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiIHPLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiIHPLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:11:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7913B13D
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:11:50 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso2767358pjm.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=evICa2gP1OZP3o4uj2q6UUkKvForG1fKNpFXQceaCWU=;
        b=EqmtlG1EAApXEHPAJtRBAEY3KRn2qNipV7J7wV23a7+9xkZs61Aozim+Aj5IpshuOL
         RTvka8w/TCO9lBxh7znsR6pIpfOZv+a2P4ITvHmeV/Kq31miqSqcHlha/9ZVtniOdKmT
         ky5+rrH1c5YDZVrEZFER1XpuSN1YyZ2LKagyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=evICa2gP1OZP3o4uj2q6UUkKvForG1fKNpFXQceaCWU=;
        b=1x8mk+hCMTLApsnTq7EKQV3+YbzcA+fqSeGCKK3xD+rczve2Y8o2eGNFZ432XXu4E+
         jAI9Kede/wr0BNLcrcyeVSA8kwYEB7AiWwqTLyAC6fiuT7lS3oJui+28J0Ozs0zE++UV
         IGfH0K+/2SS5mryq2sbK3SniMliM4f3DdoijStcf8UqQd1jH3TDxC4p8EuPwrnmZYZm7
         JIWAlzATWVG3Nm0K3lO3SWudAbjLGH3j9RMTiBncogo59fBesFb6L+xbKVa2HcuBxLyc
         CdH40srtBAi/TlJHCrA1pOs1fL+O6NDtCW8QhJEx56CELbyXr0rt96kEW5Fjmy8dbfWg
         id6Q==
X-Gm-Message-State: ACgBeo370iLlV0lR58IoV8xPmRVCLikQm/yRQUTTDDaUvDaI2iRyAd1n
        UD+A7q7hPrM9T3GE8dby5yMWrQ==
X-Google-Smtp-Source: AA6agR6yoSUpGUarSfWA17yyn6yPMU3yzNaqtpF6IjQdc28o5dU7QuUtAkXWsncXc5yfzIzSjer2KQ==
X-Received: by 2002:a17:90a:df13:b0:200:ae8c:700c with SMTP id gp19-20020a17090adf1300b00200ae8c700cmr4784872pjb.203.1662649909840;
        Thu, 08 Sep 2022 08:11:49 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id e16-20020aa798d0000000b005360da6b26bsm14892692pfm.159.2022.09.08.08.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:11:49 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Liam Girdwood <lgirdwood@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v1] ASoC: rockchip: i2s: use regmap_read_poll_timeout to poll I2S_CLR
Date:   Thu,  8 Sep 2022 15:11:42 +0000
Message-Id: <20220908151142.1479810-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_read_poll_timeout to poll I2S_CLR.
It also fixes the 'rockchip-i2s ff070000.i2s; fail to clear' and
return -EBUSY when the read of I2S_CLR exceeds the retry limit.

Fixes: 0ff9f8b9f592 ("ASoC: rockchip: i2s: Fix error code when fail
to read I2S_CLR")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 39 +++++++++++++------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index f5f3540a9e18..02905eec615e 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -163,18 +163,14 @@ static int rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			regmap_read(i2s->regmap, I2S_CLR, &val);
-
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					ret = -EBUSY;
-					break;
-				}
-			}
+			ret = regmap_read_poll_timeout(i2s->regmap,
+						       I2S_CLR,
+						       val,
+						       val != 0,
+						       20,
+						       200);
+			if (ret < 0)
+				dev_warn(i2s->dev, "fail to clear\n");
 		}
 	}
 end:
@@ -226,17 +222,14 @@ static int rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 						 I2S_CLR_TXC | I2S_CLR_RXC);
 			if (ret < 0)
 				goto end;
-			regmap_read(i2s->regmap, I2S_CLR, &val);
-			/* Should wait for clear operation to finish */
-			while (val) {
-				regmap_read(i2s->regmap, I2S_CLR, &val);
-				retry--;
-				if (!retry) {
-					dev_warn(i2s->dev, "fail to clear\n");
-					ret = -EBUSY;
-					break;
-				}
-			}
+			ret = regmap_read_poll_timeout(i2s->regmap,
+						       I2S_CLR,
+						       val,
+						       val != 0,
+						       20,
+						       200);
+			if (ret < 0)
+				dev_warn(i2s->dev, "fail to clear\n");
 		}
 	}
 end:
-- 
2.37.2.789.g6183377224-goog

