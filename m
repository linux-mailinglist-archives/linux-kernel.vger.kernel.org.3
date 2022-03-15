Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A97C4D92A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbiCOCc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbiCOCcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:32:53 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9D473A7;
        Mon, 14 Mar 2022 19:31:43 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u2so144867ple.10;
        Mon, 14 Mar 2022 19:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsGzSUuRAUEHH/9SM8pnSMjXSu1YX9VwAzHp5uJO3Bo=;
        b=SG5515+bdjCSQH5TVjdvzA0SK6Uio2R/TvBkAU2wCBacAYVukzHSTcac/Rf3MlRazC
         PwTYCKE02yWjMCAQxUAdmNKlzZe2z8zy07nyYoVzXEw7Y1OVRoePD7V9lF7VNNahUv3L
         B5m4SB4SvfZacPiMXdsNjUD0OBXHmgXCB5Dsana21MIN/2VB5O9M7J61lYqlm/IlPtTQ
         PZOQUFLuOvDQCv0lJ7+5G175b6NUweNXRyIoJ/TkKyR63lQPMxgK7tZNRt1SUTTocPv7
         SXl9hjC72Q1xBKXUs7M1clgyEMNUgTGjX24rIfYKrOGt7q9sDpo/7IR2RopvhwHXpIaM
         bNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsGzSUuRAUEHH/9SM8pnSMjXSu1YX9VwAzHp5uJO3Bo=;
        b=wMNcOjFzgCKqWTzh4g42S9OWHplxhEiioqkByLFqP2AqNmjZHqU4R28K1oO4WSZeBD
         MdJUnIIGip718hL4sdyQR2zprRsXrn5sKJJif/QHE6ETqPgr6D21Jl37QX+kSOJ2bjdw
         9+iHz74woDZAx6pwjTmrsckCI0vXmUpabIUYZzhjb3L3eYm6zhcDXi5chWdvKN7ePuUS
         Df+4kCKmPwJh6QlCEMyjnFaPZ8yZAweEQL2qeimCkkaN6GUU9g1rlegE6Z2sVHOU0JMQ
         FOjAg4qfbqfNyZMhNTIHOcIOv4QkqLNxBJQYmfzjSbeTrigX/EyXYrJ638UFFh1hZW65
         h25A==
X-Gm-Message-State: AOAM532H681xlzJM5FqXXCKgMU4sLNB65cM3MN4Ibj/VAxBpD+KQoz86
        jrSRU7ds9BbpdV7O24e0DRA=
X-Google-Smtp-Source: ABdhPJx3e0thfMZRyXjYf49ySSC0Jr5740y5Bhz/nQTIW5Em1or5HO+v6U26gDMredBMgOeFWZSOrg==
X-Received: by 2002:a17:90a:5ae4:b0:1bf:9c61:6973 with SMTP id n91-20020a17090a5ae400b001bf9c616973mr2149929pji.73.1647311503033;
        Mon, 14 Mar 2022 19:31:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q2-20020a056a00150200b004f8d80ced3csm2050220pfu.40.2022.03.14.19.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 19:31:42 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     broonie@kernel.org
Cc:     ldewangan@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] spi: tegra20: Use of_device_get_match_data()
Date:   Tue, 15 Mar 2022 02:31:38 +0000
Message-Id: <20220315023138.2118293-1-chi.minghao@zte.com.cn>
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

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/spi/spi-tegra20-slink.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index 2a03739a0c60..80c3787deea9 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -1006,14 +1006,8 @@ static int tegra_slink_probe(struct platform_device *pdev)
 	struct resource		*r;
 	int ret, spi_irq;
 	const struct tegra_slink_chip_data *cdata = NULL;
-	const struct of_device_id *match;
 
-	match = of_match_device(tegra_slink_of_match, &pdev->dev);
-	if (!match) {
-		dev_err(&pdev->dev, "Error: No device match found\n");
-		return -ENODEV;
-	}
-	cdata = match->data;
+	cdata = of_device_get_match_data(&pdev->dev);
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*tspi));
 	if (!master) {
-- 
2.25.1

