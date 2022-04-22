Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02A750AD3F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 03:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443107AbiDVBgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 21:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344083AbiDVBgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 21:36:16 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EBC49F94;
        Thu, 21 Apr 2022 18:33:24 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k14so6161905pga.0;
        Thu, 21 Apr 2022 18:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ihxe6zxbUA/1vzj66/JVhIWgSQBXfTvpOsIAjBTzmgI=;
        b=dMgP5O6mpu60na3kHGDMSK73m9DHFBs2SGazQ1eRLrH0DwCHnlEfFT8bmKffGEga+C
         yiugD8GVWVG32heRbcq/6H35SUnC90ACuAyGywpOaDYjPTPviqG2YxJFvOs4J3Pg5RVk
         EU6m/ozHfU4JfH5S/b1YU8D4cUE2YGUoXFnI46nqv2C3L/hqLF0MY7rO4Fht5PlXk2Vy
         iNbHpyQm7dqb3Ui6U/pnIVg8MHQhRjGSDP0ScdZcUyO1PrpQvg6OW+nJ835fulm0iYLP
         Hi3yhfO6w81oYUsokRogJ9MECCBYWz09wGRww4n4/IJQH9pYpUq8CqUc6NbI35ms6T3g
         VJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ihxe6zxbUA/1vzj66/JVhIWgSQBXfTvpOsIAjBTzmgI=;
        b=B6A+gmbfjxko9sjhSUnHyDp/corV8z5yjJDR2bcZIdzHDs2TV/mrA6L3LVAR0U5YRM
         yPAxFigIkW1lA/4ednO/ByG9V9bSnErvcW+ARgrOfc2w+6/n+A9TfUlGOMX4UwjLPmk9
         lBF/BR7HbL0QGo9YICDQaN7VfKv+JvK75Ks1uQp9L62TurGDxU88z4yZetjoBfhK7mSN
         JL/tyOYvCeaU4QsseEajZqfNRwu/q+k4WADx+HgoBr9iZ6fhB1789hWJ5mAbES3eQNli
         bflpUl7lY713bY/csXVkF11zV9FVcDKeTgibZRB+8Cy84Qrq4pGRTiJmwqbE55bjNl19
         IeKQ==
X-Gm-Message-State: AOAM5339WsGHpkyCWLoKqYNj3ngVAK8GhrIFQIQdIVG3V/d68t7QMlKP
        5JSsBzcKOz/12g0//LuoWws=
X-Google-Smtp-Source: ABdhPJyZwxQGChQpNHE19k0m0w52P/We+iqsLDG16PSwTJvTGWUMlaU+NNKLetC+Bi3ifjkdMJWr/w==
X-Received: by 2002:a63:2a02:0:b0:3aa:c641:cd86 with SMTP id q2-20020a632a02000000b003aac641cd86mr537891pgq.614.1650591204218;
        Thu, 21 Apr 2022 18:33:24 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 21-20020a630715000000b003aa63b1fd1bsm395634pgh.1.2022.04.21.18.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 18:33:23 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
Date:   Fri, 22 Apr 2022 09:33:16 +0800
Message-Id: <20220422013317.30362-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220422012059.52267C385A5@smtp.kernel.org>
References: <20220422012059.52267C385A5@smtp.kernel.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1.

Also, we need to call pm_runtime_put_noidle() when pm_runtime_get_sync()
fails, so use pm_runtime_resume_and_get() instead. this function
will handle this.

Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/imx/clk-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..2044e62980e3 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -528,7 +528,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 		pm_runtime_use_autosuspend(&pdev->dev);
 		pm_runtime_enable(dev);
 
-		ret = pm_runtime_get_sync(dev);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret) {
 			pm_genpd_remove_device(dev);
 			pm_runtime_disable(dev);
-- 
2.17.1

