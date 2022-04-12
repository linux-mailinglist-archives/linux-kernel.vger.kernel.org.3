Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE02E4FD3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 11:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358858AbiDLHmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 03:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353747AbiDLHQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:16:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAB140E40;
        Mon, 11 Apr 2022 23:57:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id s2so16691101pfh.6;
        Mon, 11 Apr 2022 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bNjBEe/YPe6Z4q3I9FKAbfmaWyUfpZN/Nwef8zNH/KU=;
        b=HXDUZRx+zwaxgI7xlkULMXh5Y+QtBcnOXlT16mLRmI7TL2jnSxkSQEC675xjS/jG1t
         pqoGTyAUJLsUK2BKmyFQeizPhltMgs/iMcSsIuyzJQvl3t/89GJUJUHDqNfi5vgAuZq9
         ey7EKWRtPPdXHh011jhNutwRey/N7slZjc0hfqnR0x8ZqfZGwe1f6zjAhOEyIBkL89tp
         L4VBSqoI3nLb2PGX6K8zHJrWifQgJ2uU/NHsMQG+Kn6c2iHE+LLrhxQhhKNHANPPUXQr
         BP9MOrxNNRGSDQQwk7CmYe8lLy32WsX/0G8OL31HCSqVxECsxpaQxprBLcK2MkZZ52hY
         OZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bNjBEe/YPe6Z4q3I9FKAbfmaWyUfpZN/Nwef8zNH/KU=;
        b=xZ9CflJoZQD0WD1L5Y/VGnvl8qLLXPK8wBnNL8X3lcRDH6LFaI9Wz/Dn/ZCfqzsBqY
         Ty13N0l1hGYjSj1cz3Uyb8yVlT15Ao0M2bo23NV82iULpzm6jKa9J2dFal+sRbKJG3r+
         6vRZL1Anc5uXQ+zmuPym2YFElBRUNwCxz6/4ypy/Pj0xfx6zyBnxV6TSha7SFEBkUCNy
         OXCTdBJL98QMjNki5OmF/n9dbL9N7WOmqA0bRHmPI9Yhns5EnZQasB+FFYqE/66xLZe3
         BadQYVkrt0nFq2DvNN5TrCqwSz8WHRf2wwTcosONh2RRN7SI2ZzSNWZsQA1JOT9C5kuA
         3nKA==
X-Gm-Message-State: AOAM531kcBpB4p5rUpcnWH2ygY1pbNNn7v3M2e/GQlGWeuft+zt+9fv/
        Nlxvsm09rOpH4EJr3wR8q6Y=
X-Google-Smtp-Source: ABdhPJwEOsSUBhuxpQW12wQ4nw3SgeA7lRPZ/kq+Y7rTFTCDN6m6jj7rBzvOGQ/DxADd6iG97ABukg==
X-Received: by 2002:a05:6a00:238f:b0:4f7:78b1:2f6b with SMTP id f15-20020a056a00238f00b004f778b12f6bmr36673622pfc.17.1649746645568;
        Mon, 11 Apr 2022 23:57:25 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id s16-20020a056a001c5000b00505688553e1sm16442805pfw.57.2022.04.11.23.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 23:57:25 -0700 (PDT)
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
Subject: [PATCH] clk: imx: scu: Fix pm_runtime_get_sync() error checking
Date:   Tue, 12 Apr 2022 06:57:18 +0000
Message-Id: <20220412065719.17735-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the device is already in a runtime PM enabled state
pm_runtime_get_sync() will return 1, so a test for negative
value should be used to check for errors.

Fixes: 78edeb080330 ("clk: imx: scu: add runtime pm support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/clk/imx/clk-scu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..18c6190eeffd 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -529,7 +529,7 @@ static int imx_clk_scu_probe(struct platform_device *pdev)
 		pm_runtime_enable(dev);
 
 		ret = pm_runtime_get_sync(dev);
-		if (ret) {
+		if (ret < 0) {
 			pm_genpd_remove_device(dev);
 			pm_runtime_disable(dev);
 			return ret;
-- 
2.17.1

