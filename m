Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E5C471C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhLLSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhLLSLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:11:01 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C695C061751
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:11:01 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id l22so26996949lfg.7
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 10:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EFH32R/A8nKeoiQKEQd1o39+iKWJFk8VbMvazM8aas=;
        b=PwLLqn2jtPgs4ZWqSP2LYkAwhq3gUsDH6gd+Dgi2Pn9pNHSysoSQQurPYzyyIJhQ7A
         7wF4a8tUFyFqT+LSHa3INHCpE/hgVLjg+axv0yAp0l/TLzZAK1QSwcdmkfkcwp7wBlwI
         89Uxa8zDSvcN0+QO9HKHHDJKU6Nf4kb4vUjjMHUCqaKBMz1yy/taQCgJwBIED8/MFFLU
         YRIuyHwA2ox8R2yH5VaYUAjI9waNtNTNkasB8DnUF8wi5HhMXVnkJMb2O5h0Jgadx187
         lu3FK1b0ZxGhxJ8X6LACU82NnpXjZ+LSUTN12PNIAgBG3Fz0NRJAkBKydqCAk//wgFcr
         +tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5EFH32R/A8nKeoiQKEQd1o39+iKWJFk8VbMvazM8aas=;
        b=2ym0IqVh3PskFlQHkHyKp0SmO4/M3yjb1qbrbdVOpYAE6MqJbIbXY1EvMUjRWTrGJq
         D855jHMhFHtJY+OpHHJ7UcwHh/b0pKJK9xanZ8W315FMUJzFOmZ9Ket1QKSza+aqll1b
         T6lFqwTJ+MXgB1EzqBIZZ/E4z3SfnFIBWvUSFh059JPUINkn23RH/S7F0mJoHZpp0Z26
         db/miOj23VRzIay4HS/RNEyrLvY50d3z1hr/LWaGLXk+tCrf9VLBZL7giVw2Gh+F8Q6b
         SFiILxlR/svjO83jWw/jPjLn8fJ1nSle6hoolWNu3ZiTHlOF5zDoH2tKq7qV/pIaxj4l
         wIig==
X-Gm-Message-State: AOAM530HMXV57ZLMn9TUGeZU1Uo1OdWnTxUPHdZOsgDfjG5BgndW6Aby
        QqgVi/sFmSRsdXSFtZlRkWpx5A==
X-Google-Smtp-Source: ABdhPJx2q3hRmHoqk/Aq5FNWiKiOKG/xa/RK/FiJVpoc4XG9at3CTlaVHM8/sXx2HKXarvzHSne2iw==
X-Received: by 2002:a19:604b:: with SMTP id p11mr23368383lfk.392.1639332659381;
        Sun, 12 Dec 2021 10:10:59 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id e11sm1109229lfq.65.2021.12.12.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 10:10:58 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Wolfram Sang <wsa@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanho Park <chanho61.park@samsung.com>,
        Jaewon Kim <jaewon02.kim@samsung.com>,
        linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: exynos5: Fix getting the optional clock
Date:   Sun, 12 Dec 2021 20:10:57 +0200
Message-Id: <20211212181057.20210-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"hsi2c_pclk" clock is optional and may not be present for some SoCs
supported by this driver. Nevertheless, in case the clock is provided
but some error happens during its getting, that error should be handled
properly. Use devm_clk_get_optional() API for that. Also report possible
errors using dev_err_probe() to handle properly -EPROBE_DEFER error (if
clock provider is not ready by the time I2C probe function is executed).

Fixes: c93ac09df2a8 ("i2c: exynos5: Add bus clock support")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/i2c/busses/i2c-exynos5.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
index 693903e80892..b812d1090c0f 100644
--- a/drivers/i2c/busses/i2c-exynos5.c
+++ b/drivers/i2c/busses/i2c-exynos5.c
@@ -814,9 +814,11 @@ static int exynos5_i2c_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	i2c->pclk = devm_clk_get(&pdev->dev, "hsi2c_pclk");
-	if (IS_ERR(i2c->pclk))
-		i2c->pclk = NULL; /* pclk is optional */
+	i2c->pclk = devm_clk_get_optional(&pdev->dev, "hsi2c_pclk");
+	if (IS_ERR(i2c->pclk)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->pclk),
+				     "cannot get pclk");
+	}
 
 	ret = clk_prepare_enable(i2c->pclk);
 	if (ret)
-- 
2.30.2

