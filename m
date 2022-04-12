Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E86D4FEAC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiDLXah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiDLXaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:30:23 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A84167FAB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:30:28 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-de3eda6b5dso284513fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vBKcvDi6CIJKmNgGiKzG9IDKFs6HRQ+M0y0opPEzec=;
        b=Li42pSPRBDwh9favf8mNAZvTLje+On/JwkP/+OkECysra18UerCG0iIB2XDh6JVqiU
         jmHnNYDHsmopxQG1ludXIudO6v+BLLSBZ9w+vKH/sFMIk5kfzmhMMttwkI/S6X3RDm64
         TP2UQiA73N3VGZyUsbZoJJ8Jt0tyxooZcC0qlOMLpOTtw3kFFMjX2PPey54G6xP1uXSn
         Ah9hpaB6GC44trmgk9v0U9cq0/AT30l/UHc1hhTWiIyWYOVZJz7Q7D06hVV9Ihsy+9qS
         58kiEa3SIjBP6ei0ry4olhrjFfkUGpVIVUNF7qlONjjjoHoQfOcY6b/8aqOLQBY3GYmz
         SlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5vBKcvDi6CIJKmNgGiKzG9IDKFs6HRQ+M0y0opPEzec=;
        b=buDmuJDeIQaTHEUVIG5UYOW1J3pgIlQMDAaxZ4X71EL9Mvpz9YIL34OsmqnR97rD6u
         G+xN/LYoaun2GVCSui6nQRx6F2VMeIKMu8zJ9L2Dix3MZn7J7cdCha3aaMkT1MgIZVtn
         KuSNmCZI9MQZy6cLSyXypxZKs1S9ErDl1Njdpr9xJZu+PsUnevsd7x0lGexGRA9KP+gw
         ynIq7OaVD7zsDKkXVbxiGCUuz8FvE14dKqoaYvIYHbHL0Fy4KouTlWotqV7LHioZEtam
         mK55ddiBnCg+jpDBp/xa1zYM6rG/gEjH+/bLKTOJQr42AF2Bc5h3NM6gG2jurmaauJwI
         4AnA==
X-Gm-Message-State: AOAM533yr56K/YiaMm6sJcJnNBZWBvS5GSOvsG9lVw0QmaUa2u9PemCv
        ntmXk1yA7/90cWv9weDwSfePx1272qy4LyhU
X-Google-Smtp-Source: ABdhPJzMZS37Sds0GvVpxuJms6iJZvO26UMhJ/hWzaU1vUUqhCZLPnero3oTtvR+hPFtihCNtsI35A==
X-Received: by 2002:a05:6870:b417:b0:d4:547c:7a76 with SMTP id x23-20020a056870b41700b000d4547c7a76mr3035145oap.65.1649798626829;
        Tue, 12 Apr 2022 14:23:46 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id i15-20020a056870a68f00b000e2f50df070sm1024747oam.36.2022.04.12.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:23:46 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] i2c: qcom-geni: Use dev_err_probe() for GPI DMA error
Date:   Tue, 12 Apr 2022 14:26:01 -0700
Message-Id: <20220412212601.2384274-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
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

The GPI DMA engine driver can be compiled as a module, in which case the
likely probe deferral "error" shows up in the kernel log. Switch to
using dev_err_probe() to silence this warning and to ensure that
"devices_deferred" in debugfs carries this information.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index fc1dcc19f2a1..5b920f0fc7dd 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -843,10 +843,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		/* FIFO is disabled, so we can only use GPI DMA */
 		gi2c->gpi_mode = true;
 		ret = setup_gpi_dma(gi2c);
-		if (ret) {
-			dev_err(dev, "Failed to setup GPI DMA mode:%d ret\n", ret);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to setup GPI DMA mode\n");
 
 		dev_dbg(dev, "Using GPI DMA mode for I2C\n");
 	} else {
-- 
2.35.1

