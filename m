Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0A24BCF60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbiBTPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244162AbiBTPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3185834BBA
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:57 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id p9so22804741wra.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CoWqM2l43A/te3Ur17qgQhFWUP8Vq6EXRZYnZTGBH/g=;
        b=SPvPyJ3sGYx36ctC/gjYjNfy5zsbC6v5XjQQZOE+TRYSIEZO8jaASlc0SrpqB9zEUe
         6JWanLcklXJV8BcF4eOSjz9e2tW5OLebkQ4qoyxBUj9ZWk35mwKbSctcFyuKZvn2ro75
         Tn7QrYmz5MNW+m00iUKPHz3NfRtdjnaO9n2gHTbh0962pxwPptJY0tOhn/vxj6FlsjLQ
         cUi3qjENX4CVrGB8B9UjNJ+eMFZbScpEPapvlNEPURSZxEH1D7TBdZM9tWyMBhXgjF35
         /UliI1CLraylFz2h7MHcLSJVpgvbZkYC5v5Ti7oYotxaI0EMJQckVCyTcbp3CuVl9rDF
         fCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CoWqM2l43A/te3Ur17qgQhFWUP8Vq6EXRZYnZTGBH/g=;
        b=ef0IvHZo046GdYp0v0dg5bv3M8ZgENudN/VBd/wA4yJfKO1ZaJemEAOiUo4kkyQXqh
         SbT6xbWzle5rAIs4mnAcNlOKpQQhkEbSwvjOFqI4fnHHJn1JYXMJInBrA0gHW12S81bw
         g7wY/WPboPu3JhnsBMAQ9nFqwkUkUN1jZDyyQpZedFV7XVEitRsayrfGoTOL0HA3wDJ4
         LI/yDTZS2tq4sg0na/VNqdqvwuOiOE82nLfj+Y2sQoOoRIXsHG439X4UJClUWnIGWQFn
         OvzdoGC6rWkM2N55jmxOmU4n9KekIO+8sVa25XmYQ3dW/wtKhXPGIxImX0v35zXJCHIa
         OKkw==
X-Gm-Message-State: AOAM532kP5RqANcClDAuWwMFi9gUsck3J5Z+scdkNO0zk5IyM9Und9zy
        +OYNRyDw+CFNKgJRb9qA8Dvk7g==
X-Google-Smtp-Source: ABdhPJxX/7lBlES0VDcR5um2H0CrrDMY/XCV+ngbPFAqPEGvYRF82EU1+uBVBsUjGiVKU9sxYma1wg==
X-Received: by 2002:a5d:6dab:0:b0:1ea:1c5d:904d with SMTP id u11-20020a5d6dab000000b001ea1c5d904dmr1815499wrs.51.1645370155769;
        Sun, 20 Feb 2022 07:15:55 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:54 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 07/13] nvmem: meson-mx-efuse: replace unnecessary devm_kstrdup()
Date:   Sun, 20 Feb 2022 15:15:21 +0000
Message-Id: <20220220151527.17216-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

Replace unnecessary devm_kstrdup() so to avoid redundant memory allocation.

Suggested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/meson-mx-efuse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 07c9f38c1c60..13eb14316f46 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -209,8 +209,7 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-	efuse->config.name = devm_kstrdup(&pdev->dev, drvdata->name,
-					  GFP_KERNEL);
+	efuse->config.name = drvdata->name;
 	efuse->config.owner = THIS_MODULE;
 	efuse->config.dev = &pdev->dev;
 	efuse->config.priv = efuse;
-- 
2.21.0

