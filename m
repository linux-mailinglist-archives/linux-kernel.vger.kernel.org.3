Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67079547BFF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 22:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbiFLUee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 16:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiFLUec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 16:34:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7445331213;
        Sun, 12 Jun 2022 13:34:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id h19so1630226wrc.12;
        Sun, 12 Jun 2022 13:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLO4+liZettN7NhTXRO4r2yJBN1H2FVkqYbOicYerBo=;
        b=X5OBdH28x9HgFoBcWsY3ulpULpoUF3jFjFVlEFMpFgUx3IREZW/hJYT/c1iQaKfxeq
         ndL1X8IFDh05l0q3leMTlePr/vGN8J4dEo8G+CyygvfkLz2o7s4amu4W2jQtVS+l/+u3
         NyvQqX6LDPRcdgV4mvF2uUchiySoVVwzxWGSLQqHaI7zPvUHqoQKt3DJdxyhBRI8hlmL
         doKoD3lVtTzZiJMkNHOQWQMo5R3/7bdvwG7hKlSw2IIZ9jq77ku8z9/xjLrxbvX4ElfV
         QWFetwJJlZQjHNiar2TR1PWGQ9VjKsKQZ5t+95CF2b9gbmDJ/HFSFo8KxDtJ+xSEmNmL
         E6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pLO4+liZettN7NhTXRO4r2yJBN1H2FVkqYbOicYerBo=;
        b=yy50jzTzyzKPN3uPFqRTW/zjIJavrERh40GeVMGaY9UayUuv0kFUPctCNQHGW4sBIU
         0ynWzrlXXM4Qh5CnbZ63DSE5rmid+p8lUqRreR/FB0b3+xGPF8c9VC3shQERFlEuEVng
         UUi0s8psLfnjTJIKYwnT9gjQBXtajXDuyjJxAkNkLZl7r+f3SJEWjjd0LSPY3swZPTm7
         MguiV3yFpo/xCIY7HLwitWgoT/LdHzgLVAp7yK3b2pJpEcVnOaUj/ehiUz128VHzLwMG
         tRdiFF3eVLsRqsN85Ag+jmm2MyMlOCyEe8U6jeS6FnYoZ1O0nQOpFHIGMv80CwPbTqwg
         TzRw==
X-Gm-Message-State: AOAM531ELvHnr9ASbADmKwPGyXsMZ4YunDG5cVyGZtXTxScLcUxvJVFA
        hcbVXXJwrDbztONvoyVnHjn0YgLZbn6vUg==
X-Google-Smtp-Source: ABdhPJzUlKOUvC8cBsTg326yD2TNlhEPA2C1hFzYli75wU1R8FclFOC5cNtWRhXNszJsuzDOQrKDfQ==
X-Received: by 2002:adf:fb05:0:b0:20a:e113:8f3f with SMTP id c5-20020adffb05000000b0020ae1138f3fmr53765523wrr.534.1655066069955;
        Sun, 12 Jun 2022 13:34:29 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id e10-20020a5d4e8a000000b00210320d9fbfsm7706817wru.18.2022.06.12.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 13:34:29 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andi Shyti <andi@etezian.org>, Mark Brown <broonie@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] spi: s3c64xx: set pointers to null using NULL rather than 0
Date:   Sun, 12 Jun 2022 21:34:28 +0100
Message-Id: <20220612203428.2754823-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.3
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

There are pointers being set to null using use. Use NULL instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 0ce58105dbac..819b660dae82 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -354,7 +354,7 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	sdd->rx_dma.ch = dma_request_chan(&sdd->pdev->dev, "rx");
 	if (IS_ERR(sdd->rx_dma.ch)) {
 		dev_err(&sdd->pdev->dev, "Failed to get RX DMA channel\n");
-		sdd->rx_dma.ch = 0;
+		sdd->rx_dma.ch = NULL;
 		return 0;
 	}
 
@@ -362,8 +362,8 @@ static int s3c64xx_spi_prepare_transfer(struct spi_master *spi)
 	if (IS_ERR(sdd->tx_dma.ch)) {
 		dev_err(&sdd->pdev->dev, "Failed to get TX DMA channel\n");
 		dma_release_channel(sdd->rx_dma.ch);
-		sdd->tx_dma.ch = 0;
-		sdd->rx_dma.ch = 0;
+		sdd->tx_dma.ch = NULL;
+		sdd->rx_dma.ch = NULL;
 		return 0;
 	}
 
@@ -808,8 +808,8 @@ static int s3c64xx_spi_transfer_one(struct spi_master *master,
 	if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
 		dma_release_channel(sdd->rx_dma.ch);
 		dma_release_channel(sdd->tx_dma.ch);
-		sdd->rx_dma.ch = 0;
-		sdd->tx_dma.ch = 0;
+		sdd->rx_dma.ch = NULL;
+		sdd->tx_dma.ch = NULL;
 	}
 
 	return status;
-- 
2.35.3

