Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58850D677
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbiDYBOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiDYBOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:14:31 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A114D63CD;
        Sun, 24 Apr 2022 18:11:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id z30so5491198pfw.6;
        Sun, 24 Apr 2022 18:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YSoCH0xVGmx+Sdnu3ggx76S2cnidmkkBhFjPR4Sas3Q=;
        b=eyAYYSh01WWPXIJLX/iUTF9URHfNEL/mtDXc3taArEVl5Iynmgn+WbCXqlZc2ldIC/
         h0bfG6wXJFRFCxaaKz5CF0rWaGnJ28JrUdPVvpUzWArWjYgcrgVbKtsR2dIRVJuLqKTu
         BFLHffJwBOdLOPkUIitqqTdw9L4xq4M73vtX+7B6KJQzxjMDSAROQUWkBO4a3SUi8jQA
         g11pxgD9rIzDbOXf8ZKxMGoqRfOjJcJJ/1B1/hldzilMJvA13rmVNA+m/oGvcXcPHvrk
         Ca68izmnC0REjk4qmvFrk2EjYLSaOnsgKGLDv1hcUqSwsC9kxIYszIMDA25HOv3a4G3V
         qJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YSoCH0xVGmx+Sdnu3ggx76S2cnidmkkBhFjPR4Sas3Q=;
        b=ejbRbXMOA7zzq2VHOxxxpyfXHfb2/kFWzHARZTYAzOAOQK6QQNCp4ANe80K9zMh33W
         +lPAFXDcFcDgH6R0r8qmQuYJ/JAw0lqCjMtaoequqAQyy10IRwROC7vPzLF308q5AQPM
         INfdqBURCEjRuooo6OiPqAaDg92a5UVdJpGMTozFJYK95KomkNZ49UL9epDrpnty+q2A
         /jJp32hYmRF19d7WZ9qcUSWoeZrvzwuGYkm3ME+Uebq8IhrHmJ7ZcoMD3MHeprQCyzm2
         vcOj/xjZfRUOaqT1LdaQ2nPXCHcuiQ+qu294icV7NXFL0NERA1cGDpuxe4VpVwXHC+fd
         cmRA==
X-Gm-Message-State: AOAM5310OnmpnVbZfQnxELRx+vdNSBdW+qzoIb/zsxOiFsslf624Pv2T
        ELRR56+754cjy+TmIOs5c0Zn8dAXtqXAwZhE
X-Google-Smtp-Source: ABdhPJwjHPGVOQINTadNkXbVqfZRxpPxLBKfTY2pBzNO0y9ZECO7/SZbHVLb9GTtJhJsZ2tGBrnR7w==
X-Received: by 2002:a63:1114:0:b0:3aa:30b3:dd5f with SMTP id g20-20020a631114000000b003aa30b3dd5fmr12725982pgl.222.1650849088179;
        Sun, 24 Apr 2022 18:11:28 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id f186-20020a62dbc3000000b0050d3aa8c904sm2458157pfg.206.2022.04.24.18.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 18:11:27 -0700 (PDT)
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
Subject: [RESEND PATCH v2] clk: imx: scu: Use pm_runtime_resume_and_get to fix pm_runtime_get_sync() usage
Date:   Mon, 25 Apr 2022 09:11:17 +0800
Message-Id: <20220425011117.25093-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
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
changes in v2:
- change pm_runtime_get_sync to pm_runtime_resume_and_get
- current check works fine for pm_runtime_resume_and_get() so stay the
same.
Link: https://lore.kernel.org/all/20220412065719.17735-1-linmq006@gmail.com/
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

