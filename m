Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6405AC4AA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbiIDOKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiIDOKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:10:44 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23B72B18D
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 07:10:42 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fa2so6191036pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 07:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=C3neU1AtxmqWdDSuYqkB7lF7A3shUmwSCsbgD00NRVo=;
        b=TGI1HUQ/5A3/uzMQv8C2zewVZr/OY4vypQbommNxD5sQavjSSSDRWLjlzWCal2oEhF
         vpr4/CDDA/nEGztaBVVD8NaVQB3OtkrtheeVpQEIIMZhAKUqH0ZFamQdtAPFCTLr0i60
         iM/t1rOXa6v8pbbmsCfEfJUZk4qc3h9rDXkI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=C3neU1AtxmqWdDSuYqkB7lF7A3shUmwSCsbgD00NRVo=;
        b=e1DvghU8+ubtSgBxCydkFmWPDf0DIbtoHyOBTvio3HO4fwMqo0Y5/kPIChaONvBffj
         oorHHLc3Uv2tUsW9EWtQX+T9LsksPVNYWwin518v78BdssJ1Huuv2a2n8S4D1P5YnfXw
         sRMcPtykANs+Ki878Lckkgj4SvBhYSqxEHAvmnpsaVetW9tCa8X0vSwG8+VU8rgXBHj8
         QzQhPhpZE7kvh1Gn6ZE7XEk/44rfAAEKkacCArqYiYz7HE0tCL22bawdaLFgI707Yhtz
         eI9W1bgHUi8fCnVGO3NHH2rHCrs4gxctq4hqgVZG+s1qt77pEX2owVVGomzqvggtqb3f
         ZIPw==
X-Gm-Message-State: ACgBeo3mV7P9emj8P5o7lC0TvbmBPx5JMXGiy6CBUmF0GVw7sZp+bx1c
        APv3mHrLzJoG7hsaOrLDyOuilfxOygnduw==
X-Google-Smtp-Source: AA6agR7W2dAAZHLXIRcbnomqLVD5PKLOUBKC64dhk5b5GYVE46etYXIyADU10b/L0HCyE+aVCdIRsQ==
X-Received: by 2002:a17:902:820f:b0:176:9654:354d with SMTP id x15-20020a170902820f00b001769654354dmr4925350pln.79.1662300641893;
        Sun, 04 Sep 2022 07:10:41 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (host-79-31-31-9.retail.telecomitalia.it. [79.31.31.9])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090a170900b001fe136b4930sm8606760pjd.50.2022.09.04.07.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 07:10:40 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-amarula@amarulasolutions.com,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        stable@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v5 1/2] dmaengine: mxs: use platform_driver_register
Date:   Sun,  4 Sep 2022 16:10:19 +0200
Message-Id: <20220904141020.2947725-1-dario.binacchi@amarulasolutions.com>
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
control module, is probed later than subsys initcall level. This driver
uses platform_driver_probe which is not compatible with deferred probing
and won't be probed again later if probe function fails due to clock not
being available at that time.

This patch replaces the use of platform_driver_probe with
platform_driver_register which will allow probing the driver later again
when the clock control module will be available.

Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org

---

Changes in v5:
- Update the commit message.
- Add the patch "dmaengine: mxs: fix section mismatch" to remove the
  warning raised by this patch.

Changes in v4:
- Restore __init in front of mxs_dma_probe() definition.
- Rename the mxs_dma_driver variable to mxs_dma_driver_probe.
- Update the commit message.
- Use builtin_platform_driver() instead of module_platform_driver().

Changes in v3:
- Restore __init in front of mxs_dma_init() definition.

Changes in v2:
- Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.

 drivers/dma/mxs-dma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca4..18f8154b859b 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -839,10 +839,6 @@ static struct platform_driver mxs_dma_driver = {
 		.name	= "mxs-dma",
 		.of_match_table = mxs_dma_dt_ids,
 	},
+	.probe = mxs_dma_probe,
 };
-
-static int __init mxs_dma_module_init(void)
-{
-	return platform_driver_probe(&mxs_dma_driver, mxs_dma_probe);
-}
-subsys_initcall(mxs_dma_module_init);
+builtin_platform_driver(mxs_dma_driver);
-- 
2.32.0

