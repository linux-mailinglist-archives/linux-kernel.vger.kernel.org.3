Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 587A8487432
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 09:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346059AbiAGIgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 03:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346041AbiAGIgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 03:36:39 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60DBC061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 00:36:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso9794668pjm.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 00:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=0usgNPuxO2Xbite7dIWl/eUqLBFFjy4eURRS5eQlexE=;
        b=db7Z0ELzm+ApbLFsM9kaoTKg5fw9dbZ6VA0Cr13+Zl2LzqmSGdSDtLVH3KTB09Ekyt
         vrM918SYbXswzfnRiP5IYevCGXXj8avAtt+q3iS7l5RkQENFvOasfI7JrKDDq+52i2lA
         4/PRS5KtpQhEPAzQXVlK52YmyDsiLxO/efb28hj+KW2B2QSeeLPQRq5hqwtspAwXBa6n
         ffEvYvumpV4JDPyMZYpcmSjlXIvQ2WE4GBdQ8N/f1266lHwBiuFcbj1Jzg5Ls7Nb0ziz
         lBQER0SA3Y8NYj/gpmtbHgZwwWnsPtsTBEddeX0KqPgbMxdq4qQ2NjmriVUNhx66YbTr
         zDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0usgNPuxO2Xbite7dIWl/eUqLBFFjy4eURRS5eQlexE=;
        b=jhbkIC4ogJDyOZANVT/SRXQL/mBGJoapCbgzBZJvX1ubtDLQPJVda758a8nl/0t+kD
         kPfjPdGbSRDgMP3mNyDSda6bWDDlASmZgnr95C2AQF+SbyGGvhfDkBE4ytxa90H81tkp
         l43mSA8s5DCzg9LDvqYNGfuS1/oxh8uv4osNhi+1tvW6uuwVNTI+ZHkBvLHCDdA8oToG
         czdbYJNJ4piwYdqZDdWUXeq8miE4r/66RcxLDh9Z7ieKjRNcGbZqg61rnS+Fu5dKkMCj
         nhSVIxIYgK7kPij5XlKnK/cKgjWG5rXfR1sTgufeBuCr8faiaDAT/llCRn4IJma1XWsP
         p1Rw==
X-Gm-Message-State: AOAM533pkCqOQ6QUYEVBhsxXXim2fpLEi9eyfSAb00msB7E0IVhKuLVg
        8ydMQr0gDDRtjMuIQWTnTSM=
X-Google-Smtp-Source: ABdhPJwFX+BUrAd7opzOCSQBmNe+AAAzzMRjvfY3Q5YfyjPq15ioRx70dDlJsKdD6o6knFYNsznE3g==
X-Received: by 2002:a17:90b:1986:: with SMTP id mv6mr14795706pjb.37.1641544598539;
        Fri, 07 Jan 2022 00:36:38 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id l1sm3909919pgn.35.2022.01.07.00.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 00:36:38 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
Cc:     linmq006@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Saravana Kannan <saravanak@google.com>,
        Ondrej Jirman <megous@megous.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sun4i: dw-hdmi: Fix missing put_device() call in sun8i_hdmi_phy_get
Date:   Fri,  7 Jan 2022 08:36:32 +0000
Message-Id: <20220107083633.20843-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reference taken by 'of_find_device_by_node()' must be released when
not needed anymore.
Add the corresponding 'put_device()' in the error handling path.

Fixes: 9bf3797796f5 ("drm/sun4i: dw-hdmi: Make HDMI PHY into a platform device")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index b64d93da651d..5e2b0175df36 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -658,8 +658,10 @@ int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
 		return -EPROBE_DEFER;
 
 	phy = platform_get_drvdata(pdev);
-	if (!phy)
+	if (!phy) {
+		put_device(&pdev->dev);
 		return -EPROBE_DEFER;
+	}
 
 	hdmi->phy = phy;
 
-- 
2.17.1

