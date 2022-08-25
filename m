Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512305A0A74
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237119AbiHYHkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbiHYHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:40:13 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA489A6B7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:40:11 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w20so9221709edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RU54cpq6xFDfYIiWI0hjya9fxH7V6i4vjs7uIhxYr4o=;
        b=hkghtKvrZenKgXZaC63trBWiQ+6Um1lBE9pUPkORWtKMQQW1/7mqvH6gmV65qY/wwZ
         5njyRbUSsIS2WeD7dEKpvJR0sYG9kBUAh1wnKPTwZYGLmBeKMHvqp+Z3ATk4xsFDxXh6
         0v+WbxpXU+ZYkAgqCzHZlwQW51CX1ceTU0l3Fo5EBdijTrAauS2Y7pNebEBBnWlcI+DG
         /r9PZs4uHUR5JpyYMmGZBYCrvdE1leRV+BGvEdMEjDHYCDLE8k6E91BLmoqiAqeaPPZn
         ZOieuFCWDMF2zfjQp5lv+d/SbRdOaI6Vb1m+vK4U+Uwyt1qUqX/3IcF8x/Hth0PfqDRj
         KNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RU54cpq6xFDfYIiWI0hjya9fxH7V6i4vjs7uIhxYr4o=;
        b=uXtX02V3cQvdz9AqaqgpB19s4ZLnLc9rrk7n/k4FPU0ucGRyyhMOxpaaXq36s9FlTs
         Zf5qnz7XB1NoyEMe9cgyCFZ7k8hXIyrBHXMIqP7/Lrn7tDUbOJhILdoukVHd422jJ7X9
         YiymEa7whcW9IQ5XxO6AXq9Bt6aiKPxdCNCy33GcZ/w2fVat1XGRiroBxZ+1/RtMkXue
         g0gXgipTFfKQxqESSmz47QpKER+VGRcBsGb2y5vtIOB3jiezm8WKnXZHxCSsjBlH6MCq
         Gd6LOnyg1P/FXWGjzJSHR6oRs/eR7zYth7obNgIRl1KYxp69hmrlkFlJViUcYOan65to
         QRmg==
X-Gm-Message-State: ACgBeo2whTAc0DytGfKBsM9xzFx9DfhxmNjAnq+WfikDy/tATSoMSFRh
        bamZNn1qwR1iPSsQVQlFWn43Kg==
X-Google-Smtp-Source: AA6agR6UIpby530LFJIjlq4/dasFIE0oy3awaLabyiNM3p7RD/h5t86m4/Vjyk1nnS01CCrVBVeL7Q==
X-Received: by 2002:a05:6402:26c3:b0:446:c642:6b9c with SMTP id x3-20020a05640226c300b00446c6426b9cmr2126019edd.385.1661413210485;
        Thu, 25 Aug 2022 00:40:10 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id jg31-20020a170907971f00b0072b3406e9c2sm2106267ejc.95.2022.08.25.00.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:40:09 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
Date:   Thu, 25 Aug 2022 09:40:07 +0200
Message-Id: <20220825074008.33349-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825074008.33349-1-jinpu.wang@ionos.com>
References: <20220825074008.33349-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, also change the type for dma_len
from int to unsigned int.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mmc/host/meson-mx-sdhc-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
index e92e63cb5641..da85c2f2acb8 100644
--- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
+++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
@@ -381,14 +381,14 @@ static void meson_mx_sdhc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmc_data *data = mrq->data;
-	int dma_len;
+	unsigned int dma_len;
 
 	if (!data)
 		return 0;
 
 	dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
 			     mmc_get_dma_dir(data));
-	if (dma_len <= 0) {
+	if (!dma_len) {
 		dev_err(mmc_dev(mmc), "dma_map_sg failed\n");
 		return -ENOMEM;
 	}
-- 
2.34.1

