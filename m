Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1553050CEE2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiDXD2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiDXD12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:27:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B52174F46;
        Sat, 23 Apr 2022 20:24:27 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id f22so8232850qtp.13;
        Sat, 23 Apr 2022 20:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqBlRZKmWXonJqRPv0/gmIodrBlaINi/8RFwh4KPYVo=;
        b=IGCNjuJzMB0egqttIvZuaEMfeM4P3pewgaNHqC2ykJS+bmBF+pboRCYd4uikqES3Ap
         vQUeKeCXbx38GV9GK0QqvlLoXXeoCTpYg86Lp1uaSK/cOwVhFlJkWyBKZKE+nEmWRuBi
         biVS0WdQflPqhNZQHv6rlJR4ZPKmH2yZ6ELQY38zO6N141H3AmXqrugAlzQDlC6korgg
         2chSzUSyo0uCvWWKs1iqjsCL3TQQKbyhP6uXPy0Rt0U0NT0dMbKRiLQrpr2lvXVeL5T8
         jdubCP933OMf8QpngLLn9SOhHd1wwtmZbJwLTcB4zTURLkXfUNq7zzTYJ4Wxy8Ceyq+o
         ZA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqBlRZKmWXonJqRPv0/gmIodrBlaINi/8RFwh4KPYVo=;
        b=XB3d0AT0fAcM2f3U+zP7awFeaAb8bjC6BTFpJAPycm+dECf0ofA8/zPujBVRIdFG8Q
         VEsJDC7/tBOZaoLZFU/GiTtrPIzsADzp57QdixfmWAFnKH7UbShzx1WXY3W1/t2lopH+
         HorhmnnjpTJJVuVVc0matGQ1sPpTkP8fvShtPNfXodHxED6W1UCi7jSICBuw9/73jJA+
         bvlUmrTBi3wyzHqdqEv5TYUj27cUT5jXnFwrkSxxpNGopxYAfLOQgUvMh2isC6illsMa
         sBAJO7Wfpx0QEj25FTesdLycOv8JTNTkMY1STAQu6q8m6mKt1B2bpnXewkY2gtg1FDMn
         mFGg==
X-Gm-Message-State: AOAM531sswyAoMAABq+MmjTOyVvMdnQ3+5L+OhxWm4yNpLOf0DxbsJ/6
        78GKNsrWSDjdIW0ulOnRZQY=
X-Google-Smtp-Source: ABdhPJx3igzCHoeO0tVtEqABqsVn0BHEEn7rMTXyCjjgErjXpg5VcP7xv+7pqhEZa4T6Hf8jzXTRTw==
X-Received: by 2002:a05:622a:256:b0:2e1:a01b:a538 with SMTP id c22-20020a05622a025600b002e1a01ba538mr8163370qtx.167.1650770666773;
        Sat, 23 Apr 2022 20:24:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f14-20020ac87f0e000000b002f28b077974sm4043923qtk.87.2022.04.23.20.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 20:24:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     dmitry.baryshkov@linaro.org
Cc:     airlied@linux.ie, bjorn.andersson@linaro.org, cgel.zte@gmail.com,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, lv.ruyi@zte.com.cn, quic_abhinavk@quicinc.com,
        quic_khsieh@quicinc.com, robdclark@gmail.com, sean@poorly.run,
        swboyd@chromium.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] drm/msm/dp: fix error check return value of irq_of_parse_and_map()
Date:   Sun, 24 Apr 2022 03:24:18 +0000
Message-Id: <20220424032418.3173632-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <0e6028f6-3fc1-2a27-0a45-0e024c632248@linaro.org>
References: <0e6028f6-3fc1-2a27-0a45-0e024c632248@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

The irq_of_parse_and_map() function returns 0 on failure, and does not
return an negative value.

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chipsets")
Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
v2: don't print rc, and return -EINVAL rather than 0
---
 drivers/gpu/drm/msm/dp/dp_display.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a42732b67349..c3566e6564b1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1239,10 +1239,9 @@ int dp_display_request_irq(struct msm_dp *dp_display)
 	dp = container_of(dp_display, struct dp_display_private, dp_display);
 
 	dp->irq = irq_of_parse_and_map(dp->pdev->dev.of_node, 0);
-	if (dp->irq < 0) {
-		rc = dp->irq;
-		DRM_ERROR("failed to get irq: %d\n", rc);
-		return rc;
+	if (!dp->irq) {
+		DRM_ERROR("failed to get irq\n");
+		return -EINVAL;
 	}
 
 	rc = devm_request_irq(&dp->pdev->dev, dp->irq,
-- 
2.25.1

