Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4997527624
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 08:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235876AbiEOGmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiEOGmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 02:42:24 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AAF21E1C;
        Sat, 14 May 2022 23:42:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso11470591pjg.0;
        Sat, 14 May 2022 23:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5SvJ/++bycunC3OKTAB9+JnJnOimY+H66XGtoS2w60s=;
        b=jrwaBKFl5d35QZ+3Gee2JrXoy7jVYCOzlLjUKMZ00zqNMc4yv3WfXcp3A1Irk2aD4y
         NHYe7fdu1w2rvINacTdaZsuNalurMXEFmu4dajXvHlIF6fEcGSuSAAmI821cUxO7UjLm
         T6xQdGAjpDNecUPguBmvEsOWjR1ScYtxo3v9VVkxtPaTlR+ZZ53VXeWYZQfx/fFNIilS
         az/p6n/0+RaYr0W8QnQe3gwjPHsOEx+GTyAjfDIEUoMbDqWNZW5aPLZENyceBVgKT/VO
         e8GRHJRCpNaEmFe89deWgZRv2GlMK56yVyuKiATL3+K/sJNTjosJiHhakkCww3cKbfZh
         2EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5SvJ/++bycunC3OKTAB9+JnJnOimY+H66XGtoS2w60s=;
        b=1/CVOIgl9axhSrIcOyuBRgNOdQTdFJ3sw8igd5FKKTnGoiekyo1gphKF5aG3I5qQec
         QQYo0eWS9/o7RG6Xr2RRVNRJCTufN9W8/XNfqGxauo6c6Zhele5UXz7+if/Pu+t5Nt1C
         efPrK98CSWHBpuopYuyFW2TBsqheMQteqkO4gMgJnzkvy9GjatVrJ9CG/PSWUJQZ+gTh
         dEHC5nGP1/y3Cu7W21q9k0LlU3LruztaRveDnyS/lU0EbblqG1wX+2Pg8oIAjZHUtDfK
         TKDgi2vtvHnp+VNV6L5Av32iV/syAHWIAMiC+nqRCfCwoIpuZxatXjkHnUxnoVRJgDWX
         4fqg==
X-Gm-Message-State: AOAM532JBzc9Mv2QeJJ0DpI+mwp4kJFpM+3WfAKEBGH+kVBnzKajfroI
        S7SL/94v/Zr31p6/rhU4fy4=
X-Google-Smtp-Source: ABdhPJzWcVVfdugYBkVY7O80ZUsr97cxYMYWRp1vfSYA4vb0IAvOv+WNAehaqvlWeMBCDABHd9zg/A==
X-Received: by 2002:a17:90a:ba11:b0:1df:2d09:1308 with SMTP id s17-20020a17090aba1100b001df2d091308mr3500270pjr.184.1652596941625;
        Sat, 14 May 2022 23:42:21 -0700 (PDT)
Received: from alarm.. ([103.51.72.28])
        by smtp.gmail.com with ESMTPSA id g24-20020a170902d5d800b0015e8d4eb2e3sm4568687plh.301.2022.05.14.23.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 23:42:21 -0700 (PDT)
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
Subject: [PATCHv2 3/6] thermal: exynos: Check before clk_disable_unprepare() not needed
Date:   Sun, 15 May 2022 06:41:20 +0000
Message-Id: <20220515064126.1424-4-linux.amoon@gmail.com>
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

All code in clk_disable_unprepare() already checks the clk ptr using
IS_ERR_OR_NULL so there is no need to check it again before calling it.
A lot of other drivers already rely on this behaviour, so it's safe
to do so here.

Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v1: improve the commit message
---
 drivers/thermal/samsung/exynos_tmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 1ef90dc52c08..58ff1b577c47 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -289,8 +289,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 
 	mutex_lock(&data->lock);
 	clk_enable(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_enable(data->clk_sec);
+	clk_enable(data->clk_sec);
 
 	status = readb(data->base + EXYNOS_TMU_REG_STATUS);
 	if (!status) {
@@ -323,8 +322,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
 err:
 	clk_disable(data->clk);
 	mutex_unlock(&data->lock);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable(data->clk_sec);
+	clk_disable(data->clk_sec);
 out:
 	return ret;
 }
@@ -1119,8 +1117,7 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 err_thermal:
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 err_clk_sec:
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
 err_clk_apbif:
@@ -1142,8 +1139,7 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(data->sclk);
 	clk_disable_unprepare(data->clk);
-	if (!IS_ERR(data->clk_sec))
-		clk_disable_unprepare(data->clk_sec);
+	clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.36.1

