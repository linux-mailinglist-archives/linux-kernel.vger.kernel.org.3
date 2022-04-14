Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D717D500925
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbiDNJE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbiDNJCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:02:41 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8FB11146
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:00:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id t12so4121350pll.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 02:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm6j4Sj81g1kNoBEMCttfjxLkn0RWePq1WSEM7XPmtI=;
        b=fxHH32p5j0e+cdXaMKgpfUspQX84794ZwP+Pf19RC5R0BLWEj+NyAaWz8nz7IPUrOW
         1NOs4YA249O7wbPC0KZzR/8lHcPHtMGBkjJ456cIFSglWwHyTuq4jY81Y6MBvG2fiyY+
         nt8oLvp/huyt+32y5hg6RHMqA9v2+w3OteeRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Bm6j4Sj81g1kNoBEMCttfjxLkn0RWePq1WSEM7XPmtI=;
        b=tBx310n7kYY9KgXKPA/rl5EfD9o2GFDbQo2EpC3GUewohrxpWxEwZVg6rTjD+ZN4W5
         h0h0G+UrCJiUEKXGMkBKd+b+uhNYk4uslkVEx+GU01Icv3+gd0Mc45rLZqSWFOxXEDGA
         h7c5Il6hNZrXtLlLSFfsk/nBeWflf6l0BUQfclj0284l8TOMUZlinzWnWjZ8mrKSvByU
         SQ/HAVxuAeK/vMXiO0xEYtra7jk4AccQMVQzzWu+7nl63x7tFmdcvihE81Uf0Fdp57mY
         I7pnyl39NQvAedb891X7G6aB0Dht5LbVSU6cnfFSKUkUZsEfs4O5bQjRjCFV/H6W7qzn
         EzWQ==
X-Gm-Message-State: AOAM533R1bte8iyqKzvZNCqT99bZCXJL/u84mU3c1oU4DaxiJm0JEmmv
        bJKf2eDp8EqJT+HifVFDGA1qyg==
X-Google-Smtp-Source: ABdhPJx7X+z3T7obGlkfwniBmq4ySimshUk0QxfezcyPmQw82MV8mGhksCsy7itbjwsr0JNQdzeAVg==
X-Received: by 2002:a17:90b:4b11:b0:1cb:2a65:f275 with SMTP id lx17-20020a17090b4b1100b001cb2a65f275mr3229394pjb.33.1649926816349;
        Thu, 14 Apr 2022 02:00:16 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:b53a:7315:ec5:64b0])
        by smtp.gmail.com with ESMTPSA id q9-20020a638c49000000b00398677b6f25sm1340942pgn.70.2022.04.14.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 02:00:15 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Robert Foss <robert.foss@linaro.org>, Xin Ji <xji@analogixsemi.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Fill in empty ELD when no connector
Date:   Thu, 14 Apr 2022 17:00:04 +0800
Message-Id: <20220414090003.1806535-1-hsinyi@chromium.org>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speaker may share I2S with DP and .get_eld callback will be called when
speaker is playing. When HDMI wans't connected, the connector will be
null. Instead of return an error, fill in empty ELD.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6516f9570b86..f2bc30c98c77 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1932,14 +1932,14 @@ static int anx7625_audio_get_eld(struct device *dev, void *data,
 	struct anx7625_data *ctx = dev_get_drvdata(dev);
 
 	if (!ctx->connector) {
-		dev_err(dev, "connector not initial\n");
-		return -EINVAL;
+		/* Pass en empty ELD if connector not available */
+		memset(buf, 0, len);
+	} else {
+		dev_dbg(dev, "audio copy eld\n");
+		memcpy(buf, ctx->connector->eld,
+		       min(sizeof(ctx->connector->eld), len));
 	}
 
-	dev_dbg(dev, "audio copy eld\n");
-	memcpy(buf, ctx->connector->eld,
-	       min(sizeof(ctx->connector->eld), len));
-
 	return 0;
 }
 
-- 
2.35.1.1178.g4f1659d476-goog

