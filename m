Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078634B3F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiBNCFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:05:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbiBNCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:05:11 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55E353B56
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:05:03 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id b35so13282951qkp.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 18:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH45NlfdWRTfweoUutUuJvBXViZnbk5RQ/1+2Xcuqxg=;
        b=PeEKjS6mLh0yV+FjsVcrUmmAf98M9Ce7Z+8NDNQ+UmEtnI7mHx3A7T/CULb0a5uxGi
         od82XtsfRt28HryZe67RGewDJr6AtVJ1VxxlzFHm+bAc4A+HL0GcARixvYPdtG7wKBME
         xRb09UXgR0ylwGumT7cMc1SWuN1YfFAdofEWFnEiqLcEkthQGImMD0QO02dkhfUba6In
         O1Uwll6ee1Q2kZiStzg3K/Uee7yncwPyeGNMP9oF7GuXcP4Dinrde5WV5gBhgapzkrO5
         FFAwEf2fk3SlcLDCG3u/ZCZe90Tx/ZwX9o8unwfWL7020xu5hqXPA2QBtOyL/pRsKlVO
         eYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aH45NlfdWRTfweoUutUuJvBXViZnbk5RQ/1+2Xcuqxg=;
        b=v3Ip9UK0PRCgBw4zpIj/F4uWumQ0i2v4tt9fYCnZXBwjmQIRtdAQWjr/B2btcUWjQO
         qnLD7EHOJjP+WKPrFK0ZGHNV/ElDqyr3ojP73kvedtg6D+Cl0atuG5TpntTEWiF0dLuf
         lH4m4AwTi4koQeiDTBER9Uk3Bd6cjaUYXzD8NWARnuOFG7eC3VmsQX7BIaMKyQyMhxIg
         i8A8q7vC3pCmZq9E+acoGjnCu4HZMWzFTjjEIYxETN6zXh27jAFX8pAsySR5reFtTW5j
         soTOaT7A1WD0EhYgJSeKpa6h7Og+o94vm8l18TjZ+YyUK5+A9VCu66hkZhaPMqw8W/4J
         qYIg==
X-Gm-Message-State: AOAM531xMKzP6zjlwtA1abGVtJ7yQExdIn9CdeNMU9p0W23ReB2qOb7w
        VwM/PoHjcC7KK3NpVpHJ/hA=
X-Google-Smtp-Source: ABdhPJwnbbKlb6/+9IP4/B70ReOp8eVtnIAo8INn36B5rGjuPolaQSEqwMy798c1jC/joZUZwXPeyg==
X-Received: by 2002:ae9:e642:: with SMTP id x2mr3160677qkl.29.1644804302805;
        Sun, 13 Feb 2022 18:05:02 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id j19sm12424487qkp.120.2022.02.13.18.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 18:05:02 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     joel@jms.id.au
Cc:     airlied@linux.ie, daniel@ffwll.ch, andrew@aj.id.au,
        linux-aspeed@lists.ozlabs.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] drm/aspeed: Use of_device_get_match_data()
Date:   Mon, 14 Feb 2022 02:04:54 +0000
Message-Id: <20220214020454.1714560-1-chi.minghao@zte.com.cn>
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

From: "Minghao Chi (CGEL ZTE)" <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index 65f172807a0d..9fe1983bd9c3 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -132,7 +132,6 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	struct aspeed_gfx *priv = to_aspeed_gfx(drm);
 	struct device_node *np = pdev->dev.of_node;
 	const struct aspeed_gfx_config *config;
-	const struct of_device_id *match;
 	struct resource *res;
 	int ret;
 
@@ -141,10 +140,7 @@ static int aspeed_gfx_load(struct drm_device *drm)
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	match = of_match_device(aspeed_gfx_match, &pdev->dev);
-	if (!match)
-		return -EINVAL;
-	config = match->data;
+	config = of_device_get_match_data(&pdev->dev);
 
 	priv->dac_reg = config->dac_reg;
 	priv->vga_scratch_reg = config->vga_scratch_reg;
-- 
2.25.1

