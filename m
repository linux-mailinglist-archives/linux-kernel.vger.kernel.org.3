Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B651B1E9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359620AbiEDWeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378995AbiEDWeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:34:01 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA90C21836;
        Wed,  4 May 2022 15:30:24 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a15-20020a17090ad80f00b001dc2e23ad84so6372384pjv.4;
        Wed, 04 May 2022 15:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05T8i0+/PhBWfmzSmGEc9JpZJPtIF9nNUsrsOP/fpmc=;
        b=RZKu1XfXAE8UfCxZHF3rjoV3qJ7nzjtop773a23dXY+OPI6B2xhFOBKC8gKXybFTbA
         yqs+3MG9uZYJjD8NZp0SgmOl9yPwfH3ndue3Wz0VRT2w1fBd11Zk1RLiN7/M4/u7wnS+
         15bGvBua/rjzDjpE2tKbdpSsLj6yokrgF7glOcARQDH4+Gf3e3isDg9pZ1c3/k12Mlts
         m3j3EaMdXajtE3quRNfd8+J5FBRtlm5KLRwMM4l1nojAHYzEPkiOC7AJmiWzMgZGzTqS
         f+WQ5MQLGblRsQoxefByFsNAV6s4Yag+nZaiEjuFqeFE4By6DAfjEQ9upVXDfbCiSYPV
         +TqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05T8i0+/PhBWfmzSmGEc9JpZJPtIF9nNUsrsOP/fpmc=;
        b=I35i2G1FTJgSy243PVCGvhhQrv+UCgOkpJQAjgCH4xCrTs1cUvUChUQGkFYcxW5CbR
         YcTD1hK/j+qAli6h2FonYDyg07cpDz3a2ASij68t5Goan75wKgZBh3IhXGBS8JWHcJ/G
         v/+vXIFuLBKS62nCI4MwcfJdiQfHaTAN/3PirtKKS46h6xRlJ+agwf6YRnIjdhLSZ47Y
         jha6OHrHcygXKLvgALpr/j+GdMLX0oF4Na+wh+9NFR98jP6H9MhiaAkpffNeWU+y8k0B
         PpfuloseH3pSHCZWmxJ0LWhtwaCSesUuSr6k6X5WwCSy0a2A9VLszr00cITk4xc79sMG
         omrg==
X-Gm-Message-State: AOAM531jOxxYxq/Q1OAwf9OZgsWpdwMAz72N/D0pUgv4R0rEYafKjSoL
        hNytbsCF/Ny2q404kN4f3Ww=
X-Google-Smtp-Source: ABdhPJydwSZ5hTagFlFxyR6+zxeGxfQxTqQu/drVtS1I2yCv+vTiUNWE8xrkLxIV+59r7ptPIw0GXA==
X-Received: by 2002:a17:90b:4f81:b0:1dc:681e:248 with SMTP id qe1-20020a17090b4f8100b001dc681e0248mr2174615pjb.98.1651703424399;
        Wed, 04 May 2022 15:30:24 -0700 (PDT)
Received: from stbirv-lnx-2.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p4-20020a1709028a8400b0015e8d4eb257sm8882284plo.161.2022.05.04.15.30.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2022 15:30:24 -0700 (PDT)
From:   Justin Chen <justinpopo6@gmail.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        justinpopo6@gmail.com
Subject: [PATCH v2 1/2] gpio: pca953xx: Add support for pca6408
Date:   Wed,  4 May 2022 15:29:16 -0700
Message-Id: <1651703357-25154-2-git-send-email-justinpopo6@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
References: <1651703357-25154-1-git-send-email-justinpopo6@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for pca6408 which is the 8-bit version of the pca6416.

https://www.nxp.com/docs/en/data-sheet/PCA6408A.pdf

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
---
 drivers/gpio/gpio-pca953x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index d2fe76f..4909175 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -71,6 +71,7 @@
 #define PCA_CHIP_TYPE(x)	((x) & PCA_TYPE_MASK)
 
 static const struct i2c_device_id pca953x_id[] = {
+	{ "pca6408", 8  | PCA953X_TYPE | PCA_INT, },
 	{ "pca6416", 16 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9505", 40 | PCA953X_TYPE | PCA_INT, },
 	{ "pca9506", 40 | PCA953X_TYPE | PCA_INT, },
@@ -1198,6 +1199,7 @@ static int pca953x_resume(struct device *dev)
 #define OF_957X(__nrgpio, __int) (void *)(__nrgpio | PCA957X_TYPE | __int)
 
 static const struct of_device_id pca953x_dt_ids[] = {
+	{ .compatible = "nxp,pca6408", .data = OF_953X(8, PCA_INT), },
 	{ .compatible = "nxp,pca6416", .data = OF_953X(16, PCA_INT), },
 	{ .compatible = "nxp,pca9505", .data = OF_953X(40, PCA_INT), },
 	{ .compatible = "nxp,pca9506", .data = OF_953X(40, PCA_INT), },
-- 
2.7.4

