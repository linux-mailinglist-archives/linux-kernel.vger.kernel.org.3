Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A863955FA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 10:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiF2IEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiF2IEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 04:04:36 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899A3B3F6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:04:29 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id jh14so13391823plb.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 01:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tphUaJRWmGfbf+rcQQvvdTAaHw/IgKryhTSbMG303fk=;
        b=kbp3SymyDcrr+av2CLzAaJ76U24aRBFW6qsAWMQJGR2htBnuWGvLCgalt6z/9/NmEc
         NYAfdcJUNOfMQCpCkh4e9mKK6tdsIRgQA3MxiqiHyNqa8GjPRZJajLDPkoWHecHitd0N
         Xx9kXZJ5tjyhVlfINrOFta2j0NZ+Epkj0WilE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tphUaJRWmGfbf+rcQQvvdTAaHw/IgKryhTSbMG303fk=;
        b=G2qbyuiVOCjMNtxz9ZExzukiPxDZYirNdxMl3VYsv0S9H4boej0J4g/IXa+HMr7PMw
         URGXhbGzu3MANcuqK+rXVh5HkivF20lO7Qo7AX5fXmNXbjpoRQGrhY+Sv6jAK9vc+Six
         U2WcqzjB5BcVfuzFo71yKDm+9SP0m9yUzku3crpQnqJaXB02jckq7uQ4xx/0R/9vKQ6i
         7Y0psrxFK4AOlvt8RXPZShPvtx+gVdJmnUTFLOe5CFmWCyz3ZLIzv9AobVWDdu/S/nc7
         n21O63rYCIHmtYyMvnZMadjCvQW1SCZ6L96h5o7ap2X8JD1sfwa92ftM4qYI3PuSu1DU
         r3BQ==
X-Gm-Message-State: AJIora/m/ApEERQ7iz+w8+oTMPCTd61hAyxxag2TBpj6o8a9S6MVQqY5
        ewVocscfgvaQnmCUV8fsgA/k6LGswSrfbg==
X-Google-Smtp-Source: AGRyM1vD7+R3YGDCxJmwjPFiWHdqVH/Qs7cs5QFTjqLhaftK9VZtL0He5C1/fsJNXhqqZ4K3pDox+A==
X-Received: by 2002:a17:902:7481:b0:16b:7a53:3b4c with SMTP id h1-20020a170902748100b0016b7a533b4cmr8071158pll.54.1656489869151;
        Wed, 29 Jun 2022 01:04:29 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id 11-20020a63164b000000b0040d4c8e335csm10579256pgw.75.2022.06.29.01.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 01:04:28 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Chen-Yu Tsai <wenst@chromium.org>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v1 1/2] ASoC: rockchip: i2s: Remove unwanted dma settings in rockchip_i2s_probe
Date:   Wed, 29 Jun 2022 08:04:21 +0000
Message-Id: <20220629080421.2427933-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unwanted dma settings in rockchip_i2s_probe.

Fixes: 44f362c2cc6d ("ASoC: rockchip: i2s: switch BCLK to GPIO")
Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
---
 sound/soc/rockchip/rockchip_i2s.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 0ed01624a2db..285b6455be28 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -817,14 +817,6 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 
 	i2s_pinctrl_select_bclk_off(i2s);
 
-	i2s->playback_dma_data.addr = res->start + I2S_TXDR;
-	i2s->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->playback_dma_data.maxburst = 4;
-
-	i2s->capture_dma_data.addr = res->start + I2S_RXDR;
-	i2s->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	i2s->capture_dma_data.maxburst = 4;
-
 	dev_set_drvdata(&pdev->dev, i2s);
 
 	pm_runtime_enable(&pdev->dev);
-- 
2.37.0.rc0.161.g10f37bed90-goog

