Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A3652B2EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbiERG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbiERG7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:59:12 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1664339D
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:59:11 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x143so1286654pfc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmSH4WeEBLasFK029hFJFejLoqVw7N7yZPY1rCf/FfU=;
        b=cvFS50VivsG2a7DUQM7O/jQw4CymgJ9LbNkb818N52p4s2zAa1WFjiS8iB6HMqZRvW
         6qDOkWsWqkMxV+IyEMpYo2pRFTd/9TZ5lt8pF0UQyZtcQbsuHTemqTMQVtF/bL483l2c
         m7G7hqDQnoySGOYbKJka6x2gX3+X4P2/M+4NnZSMPttUt7hHaNBzTkSVcrqYxCxRnnhj
         FQXcFw6JMAY1/tz6Ad3E85ciWSSTPopjgDX41NV3dfcsJhdHgF5pQ+zN3GlKlPmPCmqX
         j2tlCJnnLs4PQvIQk5aNrS/AsMO5S3krdBtERgZkrYPZek/lVFVrpm2J6OwlcCy52AyQ
         GZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YmSH4WeEBLasFK029hFJFejLoqVw7N7yZPY1rCf/FfU=;
        b=QPSf/TCUXMGdJUR1/UG1VahSio7cNEOMASQCSPj0kStQzL+IxFiDPXgA61oLZYLTiW
         o0Uk0xhE4JtUyg2G8iUe4GLRfJytN6C4weqt4kU3bJUkFmNp91egb8FKae7pgnJ3/Gey
         wM1K8FSSqMa5l6XJ27sabc0+5NyB0Gbijpu3qf1qjbj4tmYT5K5ML4RLKpAJyU0Uy9nn
         N1TL5hSqlbLS3zwFBNraKgNZMYjEo4yXHsA7mUdKtc3e/9o6oJ3AISMRgtQrzjAbB88y
         qEhB4JWSRgzANKyG1eUdHRoLSFrY78bdNppxpzyUJmi4cn4/vSCpj21MsIbThEE0DK5F
         Y7/g==
X-Gm-Message-State: AOAM531MJ8HMp0hcTuG1jMSU2gv+UZuanupIzN92LM3+5HLRQaTJn+x8
        WXgXiYAPkSuHlbNCQ9Xb6F4=
X-Google-Smtp-Source: ABdhPJxtTMXDI+f8tNs/ZUpIsUhmPUx1tJVZHzwxzEtN7KEf2Pc2d4NnQjrjCMBLpm/lgwNquFXuxA==
X-Received: by 2002:a63:4602:0:b0:3f2:7215:1ac0 with SMTP id t2-20020a634602000000b003f272151ac0mr10925036pga.179.1652857150712;
        Tue, 17 May 2022 23:59:10 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79f10000000b0050dc76281a6sm990241pfr.128.2022.05.17.23.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:59:10 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch, architt@codeaurora.org
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] drm: bridge: sii8620: fix possible off-by-one
Date:   Wed, 18 May 2022 14:58:56 +0800
Message-Id: <20220518065856.18936-1-hbh25y@gmail.com>
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

The next call to sii8620_burst_get_tx_buf will result in off-by-one
When ctx->burst.tx_count + size == ARRAY_SIZE(ctx->burst.tx_buf). The same
thing happens in sii8620_burst_get_rx_buf.

This patch also change tx_count and tx_buf to rx_count and rx_buf in
sii8620_burst_get_rx_buf. It is unreasonable to check tx_buf's size and
use rx_buf.

Fixes: e19e9c692f81 ("drm/bridge/sii8620: add support for burst eMSC transmissions")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/gpu/drm/bridge/sil-sii8620.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index ec7745c31da0..ab0bce4a988c 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -605,7 +605,7 @@ static void *sii8620_burst_get_tx_buf(struct sii8620 *ctx, int len)
 	u8 *buf = &ctx->burst.tx_buf[ctx->burst.tx_count];
 	int size = len + 2;
 
-	if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
+	if (ctx->burst.tx_count + size >= ARRAY_SIZE(ctx->burst.tx_buf)) {
 		dev_err(ctx->dev, "TX-BLK buffer exhausted\n");
 		ctx->error = -EINVAL;
 		return NULL;
@@ -622,7 +622,7 @@ static u8 *sii8620_burst_get_rx_buf(struct sii8620 *ctx, int len)
 	u8 *buf = &ctx->burst.rx_buf[ctx->burst.rx_count];
 	int size = len + 1;
 
-	if (ctx->burst.tx_count + size > ARRAY_SIZE(ctx->burst.tx_buf)) {
+	if (ctx->burst.rx_count + size >= ARRAY_SIZE(ctx->burst.rx_buf)) {
 		dev_err(ctx->dev, "RX-BLK buffer exhausted\n");
 		ctx->error = -EINVAL;
 		return NULL;
-- 
2.25.1

