Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3427E54AE21
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 12:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352266AbiFNKSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 06:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiFNKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 06:17:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7366E419A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:17:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id s12so16233143ejx.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 03:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7A7nTmdaI9/bcr+2R0SqLAb+aR5IHo7VJJCTzS5ZF6s=;
        b=HWVuub0cau9MEvLNm1/l0bFz9qGQTxJJVGMyDa0eazCpvT+V1EJ+579Ljji9OjeT4K
         utpCbQRbb3gSMMlMc23ZZnBR9baABXEhxSWsRmVFDTnZwKtnMyyuDvKB6d9a0uyLgy/y
         XFOhOM+ZbJdk3t0BJ7Yfo3kXHyXJyyF9360SA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7A7nTmdaI9/bcr+2R0SqLAb+aR5IHo7VJJCTzS5ZF6s=;
        b=1WltRjmrNHNkxvXcs9/caqje4ZmX2HZ6W2RzES2G7qYSpEZ5cFOGAln0dPfJ4WTprq
         /0S2UU3Wb2X+iIRPuCvdGA8YstPHPlrWXxdsP3enSd/04Z1pUbjPIw0oj0DUE6TkPXJm
         NR4E4065+d6NWckzP6QQ7CQe+gNyKjEA3ZLctVDwtHO4wHiw78m/Ibraz78sLO2snBMK
         K0APblJtPD09A+C6fCeEPUOJtwpCoRW1wWO8Fi2sxM3Zx1nRsP2wAwho/OIdF/XmGJ34
         DYJ58Y3xf4Llao9+SsljzCMLIFpqF8CilGIPW0T5XZRbY/edWtN5huexMeLZ+qUWMQws
         ynNQ==
X-Gm-Message-State: AOAM532AacYiaOmBJoJxl3UcNggjJuq0cg5GPDpO+4s6ngofRh9M/5tA
        33jCVHf9hQFIwrnd2piNAJqWcTMvOTekVQ==
X-Google-Smtp-Source: AGRyM1uSGDUHuyUQPJNZ4pVQMMzgj9Aj3XhH2tdLGyOUMiYZyrozh51lRXj+PKvb4y9+ZonVCHMDJw==
X-Received: by 2002:a17:907:d24:b0:712:1142:88c7 with SMTP id gn36-20020a1709070d2400b00712114288c7mr3673468ejc.435.1655201876750;
        Tue, 14 Jun 2022 03:17:56 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id dx6-20020a170906a84600b007094f98788csm4878838ejb.113.2022.06.14.03.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 03:17:56 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] dmaengine: mxs: fix driver registering
Date:   Tue, 14 Jun 2022 12:17:51 +0200
Message-Id: <20220614101751.3636028-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Driver registration fails on SOC imx8mn as its supplier, the clock
control module, is not ready. Since platform_driver_probe(), as
reported by its description, is incompatible with deferred probing,
we have to use platform_driver_register().

Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org

---

Changes in v3:
- Restore __init in front of mxs_dma_init() definition.

Changes in v2:
- Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.

 drivers/dma/mxs-dma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca4..6e90540fedc4 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -741,7 +741,7 @@ static struct dma_chan *mxs_dma_xlate(struct of_phandle_args *dma_spec,
 				     ofdma->of_node);
 }
 
-static int __init mxs_dma_probe(struct platform_device *pdev)
+static int mxs_dma_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	const struct mxs_dma_type *dma_type;
@@ -839,10 +839,7 @@ static struct platform_driver mxs_dma_driver = {
 		.name	= "mxs-dma",
 		.of_match_table = mxs_dma_dt_ids,
 	},
+	.probe = mxs_dma_probe,
 };
 
-static int __init mxs_dma_module_init(void)
-{
-	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
-}
-subsys_initcall(mxs_dma_module_init);
+module_platform_driver(mxs_dma_driver);
-- 
2.32.0

