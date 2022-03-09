Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468914D3629
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237794AbiCIQxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 11:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235990AbiCIQqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:46:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF26BC117C;
        Wed,  9 Mar 2022 08:41:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so1858429wmf.0;
        Wed, 09 Mar 2022 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x22hoyeECM1u+upqH/e0Xmtm+AvHSl2XKbJTxi43ww=;
        b=AOBKB7Ne7QnmXlHEDX9CGVGVTWCnx6xbpXaD0cyMfd3Yamuk0lqAm0P6x/Aw8yppEH
         tlmPK+WBtZ7A5zmsDdF4wR1H9yjBGQG4NvjlUcqKJy6evXu2EHjq8zjrgrWu9XWX/Rq9
         Q8slrLLsJyFwcMhlACMHlf9f4b4QzlDxle22HU6yajXU1kx/rAGqo1CzglaoHNGqoM8j
         2cC1plJvM6WNSMwPOhDY4pzKzjkIFoU9B0XS3nNUCLyTBZlqMyhS2X27vgsaHxijpKSP
         3wK0j9AOQenwsagUnv4CXl3CqG2d6cJasM63U5WBhZ9oH1zv3MVXtUASU4HK7QYLI4/B
         bQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7x22hoyeECM1u+upqH/e0Xmtm+AvHSl2XKbJTxi43ww=;
        b=rE7I86Uus15MQtT3ayNBF47yaSakEGeSmPhmOJu727JFingECIe2Wj9g/MHIAA0jBU
         pP8SkftZHHOxC1DlU+vNkGdmH2K9bCBn4hIXAze9bUcBQndzhQs3feW3K4GhKCme0Unv
         e3cHrRtLo0y1HYT7nus83ClwQC2GwqOw7vVrT2e4xG1mgYoTo1l3DfTrJ+FA9nkHcUzx
         cPW6ZbG1zT1KfATNS2IVb0okevQgK8DHP7h5Pizl2Ew8GUDL5dpa3OZvO3sYUc3+83ia
         fE0+ZjL/b4pY5EQxV8wxOd3ynGUkQ0lHYvg6TOAyR6gLWy33OhipYpkGUpGP3SXk6QUI
         fiMw==
X-Gm-Message-State: AOAM530eH/f1F0ne3w6zvOi4TKOq08YTrJMQRd5VFU7ZtVOSINh/Ca+G
        saspHOgrMp4TDep4uHV16Jw=
X-Google-Smtp-Source: ABdhPJw4ogyQTVUBPnGoIt3hnAAKuZHragQxGmxAjdCC1F8j8j0eFa0s8iX9M1hGhdV0n3tqLHgLaQ==
X-Received: by 2002:a1c:f003:0:b0:381:17f5:21b8 with SMTP id a3-20020a1cf003000000b0038117f521b8mr192386wmb.158.1646844078137;
        Wed, 09 Mar 2022 08:41:18 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d5906000000b001f0639f69e6sm2169091wrd.55.2022.03.09.08.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:41:17 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: atmel: mchp-pdmc: Fix spelling mistake "microchopnes" -> "microphones"
Date:   Wed,  9 Mar 2022 16:41:16 +0000
Message-Id: <20220309164116.178685-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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

There is a spelling mistake in a dev_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/atmel/mchp-pdmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index c44636f6207d..871834fb9b77 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -892,7 +892,7 @@ static int mchp_pdmc_dt_init(struct mchp_pdmc *dd)
 
 	dd->mic_no /= 2;
 
-	dev_info(dd->dev, "%d PDM microchopnes declared\n", dd->mic_no);
+	dev_info(dd->dev, "%d PDM microphones declared\n", dd->mic_no);
 
 	/* by default, we consider the order of microphones in mchp,mic-pos to
 	 * be the same with the channel mapping; 1st microphone channel 0, 2nd
-- 
2.35.1

