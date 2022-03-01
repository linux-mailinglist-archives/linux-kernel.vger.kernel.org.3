Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52A54C8123
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 03:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiCACrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 21:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCACrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 21:47:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C173BF95
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:46:30 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id i1so12337610plr.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 18:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=Oh77CwmcM8TqQGwRDvYrvPiyyCBaVXCwM96gKvsyh0c=;
        b=cKgQn+iSiUti9x7VYjmZIZ10o8SAl7Y55nkiuo/+bpRiPYT1stJ6ggJklb6u8XoRXz
         Et4saEOaAACuxUhA1LAMv3LrHG0QnCibU1WHYFFXRcTuEVUXSTwfOJWC9J9rM5JBoaGy
         lO6aMbnnF8nD5xgx3LfQT30MOoGHCyhEMGEdl3wV72ofW+zuFdNtIHBO596XSNBiBIz3
         0EQsVSJppoMLizuOB+7u12dFxO5D2ViwDzDcjYgQXoOYDBS5pHW1YaeipwaEUHqVZKTe
         yT9HyrNfXmv7O+FY+O1N/Gp8dPlSc6ViSO8LnEerMvzDovesI7Rqj4gtLgFX48UNUfNd
         1bzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=Oh77CwmcM8TqQGwRDvYrvPiyyCBaVXCwM96gKvsyh0c=;
        b=ndcVEmY5lgvtW54WRL/N3zB7IKTxURRjzaWhpgaTVTeCOf+LYNtMgPUDKXVz9rwLva
         mni9E240TcsrCVV5dzpUbL4SLuGWNr9IzeotBDr3MtOtYNj652AmzB2Z41fddpmgwLQY
         Z3j1bUKJrOcB5m83iZZUqdRAxfl6IZl0GwR3V+lKdE0ExzGCAqlfIEpOVK8e//Fa3xrW
         fs4BqRz583D3Cp7q9cYHrJbs0kbWZxSL37kYZ47P4PK82MqKszkZUNizSnSLl07wLe6p
         qiN3oRbIryfK77+Ki1ZiPEPZ8DqKq3BACtBFnBhBznKdynwxYrfZrPZySvdaB31CSsgw
         UW3w==
X-Gm-Message-State: AOAM531j9rmnD8/MDhoUN/v+yfyGQF03dJRAQtywuoVGvozLeST9YyWF
        h1jGUg5R37OBMuGbsDwu6o0=
X-Google-Smtp-Source: ABdhPJxuyzzCqyPsxftZG5kik28R9flxKAT1VMHHtF755Tw/FboWjZE+mIlnRbvPeZonXtIveEVwPQ==
X-Received: by 2002:a17:90a:a78f:b0:1bc:8042:9330 with SMTP id f15-20020a17090aa78f00b001bc80429330mr19438763pjq.229.1646102789999;
        Mon, 28 Feb 2022 18:46:29 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id t8-20020a6549c8000000b00372eb3a7fb3sm11399940pgs.92.2022.02.28.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 18:46:29 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] phy: mapphone-mdm6600: Fix PM error handling in phy_mdm6600_probe
Date:   Tue,  1 Mar 2022 02:46:11 +0000
Message-Id: <20220301024615.31899-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220105123947.17946-1-linmq006@gmail.com>
References: <20220105123947.17946-1-linmq006@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth.
If the probe fails, we should use pm_runtime_disable() to balance
pm_runtime_enable(). And use pm_runtime_dont_use_autosuspend() to
undo pm_runtime_use_autosuspend()
In the PM Runtime docs:
    Drivers in ->remove() callback should undo the runtime PM changes done
    in ->probe(). Usually this means calling pm_runtime_disable(),
    pm_runtime_dont_use_autosuspend() etc.

We should do this in error handling.

Fixes: f7f50b2 ("phy: mapphone-mdm6600: Add runtime PM support for n_gsm on USB suspend")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- remove unused label
- add pm_runtime_dont_use_autosuspend
---
 drivers/phy/motorola/phy-mapphone-mdm6600.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
index 5172971f4c36..3cd4d51c247c 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -629,7 +629,8 @@ static int phy_mdm6600_probe(struct platform_device *pdev)
 cleanup:
 	if (error < 0)
 		phy_mdm6600_device_power_off(ddata);
-
+	pm_runtime_disable(ddata->dev);
+	pm_runtime_dont_use_autosuspend(ddata->dev);
 	return error;
 }
 
-- 
2.17.1

