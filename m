Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FC855323F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbiFUMhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350040AbiFUMhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:37:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A888521E21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:37:06 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z11so13011168edp.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bU6rFWiQHEAzXH5Km60JkBglStbc5oDQ/bTLOOpf4uM=;
        b=ejFqEa/1gvWMktEt5vUiEOJgMbiYOiZeCiQjAKN4ccq2OgPCTam+d+uwh5nbq5B+aT
         uHz0EX/hKwLRPqJ3T91VES6I0YK9UwQnsiUWTg1UoogJGzjbQfkvp8lL9ObtDkG3MRW2
         3O52CpdxVLucJP/HqusvDIol7iixTCXRTBEsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bU6rFWiQHEAzXH5Km60JkBglStbc5oDQ/bTLOOpf4uM=;
        b=UZgKqA2mp8Iub22+FD0VOtS5e9hDHmgKH1PInJY4iF5TIRbqE6lGf0UZsE8fYnKIPJ
         pz39yIBdkRvsh2WYr7A4cUuCo1JRg8W7adhm1fksq22wv6P2XeaE0K0tC2celje222QI
         zYuv5YKQBliHz5t1vkrn9EnhYpcvmMMgele5D/byC4NvXXconDjeIkNYSd0d5+X+qzIU
         JqLdmEanUVy2C1pNhGVcTruTwuWxR9EZgijdHE8RQYj1DKe+Ao6OrzTzcRwI9ZJYkws8
         agEtP0mN/GKUqDMj5B00X6nQ4e5xveiH9FUEcJLts570L0csI9s9OWSSz/v+OXdPNpNQ
         oIaA==
X-Gm-Message-State: AJIora8fbXDt8MOp/mrsqGNXdaryzoXDVPhnk2XEzlnIVGftV4K+kSx6
        F2+bsMoq1a98vCs6nbzg1VCAQXe6z+O2lw==
X-Google-Smtp-Source: AGRyM1vzaS5C7AOu0OH7wfU5OuXBZVhpB2Qq4D/zyU5t0N8rPezW5nwdrZ7T2z+hxnLL2h/OnxT0dg==
X-Received: by 2002:a50:fc15:0:b0:435:7897:e8ab with SMTP id i21-20020a50fc15000000b004357897e8abmr15840327edr.17.1655815024956;
        Tue, 21 Jun 2022 05:37:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z6-20020a17090665c600b006feb6dee4absm7639089ejn.137.2022.06.21.05.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:37:04 -0700 (PDT)
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
Subject: [PATCH v4] dmaengine: mxs: fix driver registering
Date:   Tue, 21 Jun 2022 14:36:59 +0200
Message-Id: <20220621123659.1329854-1-dario.binacchi@amarulasolutions.com>
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

The addition of the `_probe' suffix to the `mxs_dma_driver' variable was
suggested by the following modpost warning:

WARNING: modpost: vmlinux.o(.data+0xa3900): Section mismatch in reference from the variable mxs_dma_driver to the function .init.text:mxs_dma_probe()
The variable mxs_dma_driver references
the function __init mxs_dma_probe()
If the reference is valid then annotate the
variable with __init* or __refdata (see linux/init.h) or name the variable:
*_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console

Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for i.MX23/28")
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc: stable@vger.kernel.org

---

Changes in v4:
- Restore __init in front of mxs_dma_probe() definition.
- Rename the mxs_dma_driver variable to mxs_dma_driver_probe.
- Update the commit message.
- Use builtin_platform_driver() instead of module_platform_driver().

Changes in v3:
- Restore __init in front of mxs_dma_init() definition.

Changes in v2:
- Add the tag "Cc: stable@vger.kernel.org" in the sign-off area.

 drivers/dma/mxs-dma.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca4..4c878bf1e092 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -834,15 +834,11 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_driver mxs_dma_driver = {
+static struct platform_driver mxs_dma_driver_probe = {
 	.driver		= {
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
+builtin_platform_driver(mxs_dma_driver_probe);
-- 
2.32.0

