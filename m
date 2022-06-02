Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE27253B432
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiFBHPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiFBHOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:14:54 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7CBDC83F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:14:54 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o17so3809615pla.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T86Xkl4zAQRDqlX+Sbg7KzV+2Znm3kmGhJEJ2gH5oPs=;
        b=kjIm42IQKm9p8crvtuLlXRMrgIPGHqf/cbX5Jp1nkyGBMxpECnqZ5tNw4G30RPSxSl
         ihT2VakbiG/ZXL6SWwJp0zuQ7kQ8ePWf8/YKs4gc0Fj5aAxPTjQzdgDFlI52vn/qTfxY
         cjAU9JiqpoH+7H2BLO9XA48OAW57jwI7UKzmewXbkmcjWWnVmYin3Mh8utHbnOGfqaBo
         cD1jkJAmTugEOEEctTHVa+GoP0iAFf3DXCI9k5QRDWt42VAAe/Gcz7HYnjFTIvdHH2NQ
         D8R/hTPIsSDjcxWOgyKWl6jTZpX27yZUh6IbNcbzODpP3uB4O/YQ/UO2LD9O63doGyfL
         vvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=T86Xkl4zAQRDqlX+Sbg7KzV+2Znm3kmGhJEJ2gH5oPs=;
        b=tGv+fhPPhLlvnYNd1XXguWyPuKgoC3GzgTOUm7foJcQ7o7vKJgGN5/Qh5gZ2/I1bSb
         bRCTiHz8asLPPkaK+vzX8CegqiUAojTZB4FWrrs7IvUOPG8+7pAiindoYQmMphqtYL1p
         dVdz3Qa9w9IByJNsDKe3jiGp+dGsmOtqwEupsRWeSf2vMCwSnE7bCcCe3xznxlgK+jPt
         1HP9r2qCUjFuy7W15kt/PB8WY5S5l/+qiomEL3vM02mDNohiwlqEqp9JGKywpEImm6pK
         izUO6diGqeWUNumldwUuMoOSwfZQlXg3XA73dRs9G8Gt19/mqHyom/Y6cjFk7LcWBvyD
         vkXA==
X-Gm-Message-State: AOAM533b71TXzQl8iQ9HtTDt7BgS/3JB7KO17J4OGELRZao977BsjFds
        JGSHik/eWMcnlSaVdY9s2m4=
X-Google-Smtp-Source: ABdhPJwZZAKpu/HC9yA8XNgWRXb+XzH/3iyXB2zHZjMV/93ih8NOdK4sZduf3oXx1JZX6HglGbpQ6A==
X-Received: by 2002:a17:902:f60c:b0:156:82c9:e44b with SMTP id n12-20020a170902f60c00b0015682c9e44bmr3519920plg.106.1654154093526;
        Thu, 02 Jun 2022 00:14:53 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b00163cb0a8392sm2674737plb.168.2022.06.02.00.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:14:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] ASoC: imx-audmux: remove unnecessary check of clk_disable_unprepare
Date:   Thu,  2 Jun 2022 07:14:48 +0000
Message-Id: <20220602071448.277968-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Because clk_disable_unprepare already checked NULL clock
parameter, so the additional checks are unnecessary, just remove them.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 sound/soc/fsl/imx-audmux.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index dfa05d40b276..f434fa7decc1 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -71,8 +71,7 @@ static ssize_t audmux_read_file(struct file *file, char __user *user_buf,
 	ptcr = readl(audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	pdcr = readl(audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
@@ -218,8 +217,7 @@ int imx_audmux_v2_configure_port(unsigned int port, unsigned int ptcr,
 	writel(ptcr, audmux_base + IMX_AUDMUX_V2_PTCR(port));
 	writel(pdcr, audmux_base + IMX_AUDMUX_V2_PDCR(port));
 
-	if (audmux_clk)
-		clk_disable_unprepare(audmux_clk);
+	clk_disable_unprepare(audmux_clk);
 
 	return 0;
 }
-- 
2.25.1


