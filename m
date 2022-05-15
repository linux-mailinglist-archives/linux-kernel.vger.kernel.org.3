Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38EA52761D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiEOGmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiEOGmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:08 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B529421833;
        Sat, 14 May 2022 23:42:07 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id o13-20020a17090a9f8d00b001df3fc52ea7so531095pjp.3;
        Sat, 14 May 2022 23:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yUsWY8yO7JINjNZjm2YNwG/QCXLT5+H4ss9vbx5Zd0w=;
        b=W4TO+xCxh/8tDfBX3UQBWoDFjUykmIMldo50JqnI8/SRLznz0WeUDf2jrPuAak/fEc
         t0QcGx0qKWPl3sPVp8I3sfh3FrZ1GS6nVFhJcbopsv6a70Pvr4eVBWY3JVGv518rCGY1
         Tu04TkWzKudEwoLfCxRM/sq7beVEHT6QHN/1SFx05fsnvWefiAX9XNbxgG3M1MkU56c3
         3I4A0NkgAAVOQ5csvjbjjggxw0ZHIQVEFk9DzLazqqT5A0kKrfuw4y/2u+bZtK5TXt+J
         YslAF7jV2r2s8pEwWPcqDokf3RkqthbSb/G7APGMRHe/Oq82/1anL3BDCM3y9MvXIzNz
         +EAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yUsWY8yO7JINjNZjm2YNwG/QCXLT5+H4ss9vbx5Zd0w=;
        b=o2lyIYKy96wwoJDl5NF+TZ5zleIMGC4Cxxmnga1/yCUCwx69SmfONvH2D285NAYec0
         iEA2aZj+2yk4U2oIgwZ4DRIYm0dNw+REA7nfDZhqMtSuTzVRb9uCBz/wqM5XRyVk1VLf
         YB8SH/wY6qfyHnPBO+rhWXVq+/rtSZA3iMJnz5BEK2gWKGQN4H8qQvk5VUQX+g/eaozH
         x1U63FX3nTi+kDyz/GM1IUbMShkg5WpJNfZLKtoqL0SeUVxjuD+Bf2CAbOik4c95FCof
         W2TiSJwuZv1ac38u421jntCvIMBTOuyHaSeukhRrSc84FqUrG3yetr4aFcWj82XJTU/A
         Th1A==
X-Gm-Message-State: AOAM53363tGswPFApSosYlumnDgWCPXLtdq15h+EH89ltzoG3uzs133u
        UDma0g7PiSfbfbuNBwe7uZU=
X-Google-Smtp-Source: ABdhPJz33p0ux51f2WvaEY+nQUYH4tVmxqP3fLiRfjM7Jqpa5ngaRasABu7YzWql7RGfMLkmAYYzKw==
X-Received: by 2002:a17:90b:350d:b0:1dc:6680:6f1d with SMTP id ls13-20020a17090b350d00b001dc66806f1dmr24421442pjb.27.1652596927259;
        Sat, 14 May 2022 23:42:07 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:06 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>
Subject: [PATCHv2 1/6] thermal: exynos: Enable core tmu hardware clk flag on exynos platform
Date:   Sun, 15 May 2022 06:41:18 +0000
Message-Id: <20220515064126.1424-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515064126.1424-1-linux.amoon@gmail.com>
References: <20220515064126.1424-1-linux.amoon@gmail.com>
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

Use clk_prepare_enable api to enable tmu internal hardware clock
flag on, use clk_disable_unprepare to disable the clock.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: split te changes and improve the commit message.
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index f4ab4c5b4b62..75b3afadb5be 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1054,14 +1054,14 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 			goto err_sensor;
 		}
 	} else {
-		ret = clk_prepare(data->clk_sec);
+		ret = clk_prepare_enable(data->clk_sec);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
 			goto err_sensor;
 		}
 	}
 
-	ret = clk_prepare(data->clk);
+	ret = clk_prepare_enable(data->clk);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		goto err_clk_sec;
@@ -1122,10 +1122,10 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk:
-	clk_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
 err_sensor:
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
@@ -1142,9 +1142,9 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.36.1

