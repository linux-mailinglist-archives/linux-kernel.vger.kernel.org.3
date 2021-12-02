Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7538466C74
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349436AbhLBWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377368AbhLBWbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:33 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4447C061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso912086pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0P0B2t7jpcQb6RReBEhUJcwiQBX6wggU1M1usRBo/kI=;
        b=MJAsiBHpO2q/hsdSciuVFwOT83PxpG9KpLTTD6y0Jx+32jDfUTd5R+reXnN94kI7HS
         GgGdo4Mh4lZoXjrW/jAhRMOM4ufPOdIVKUiioIwtOhV78I9fsMuFVoRq2DG3CtFH2zh0
         FkzOE9NnxFQxGfNLVwIhT2jCD7yS3hFy2CGxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0P0B2t7jpcQb6RReBEhUJcwiQBX6wggU1M1usRBo/kI=;
        b=KyBEMirdWCpjhWh5spg2eQigmOqbso6e6hLUUak7CiHqSI8UmfMuNA/pACdQUEbBZW
         IqvtRuYSe2G1HO6G5Kczje1ePzZvbq/VwhucmZUFEhl/t1WbyPzZnH0SlxLyto7QioWv
         tGsEkyNKFCkA2sIZMHmQf1IsbimutvECfv8dxP6lXbzT3ViQqq361mBBHNQprqHT5I2U
         VKIm0KKcn2um3W76YlYzaedQZriAHSQCmTUAtYAXx9erN07ZUoQUvCbBvjDG0/XGohnM
         rih/4U3TlxUuZ0FmOunbvq/2tQN/lfCIljLTajh0riP/HFGQSXldyBffDDZ+icgD7k78
         p9Gw==
X-Gm-Message-State: AOAM5329AbS8OiNLjYxSgSBt53MctR0cD37BYn0n8iBkdNYhWFDPh/fG
        yEiucn5rzLz1S85pDzFQBFTNSQ==
X-Google-Smtp-Source: ABdhPJzRLHHfwflAzf8KYyKYQgwlkeL0VlCcI9nc3Zp0HIXLhrAJVU/FYievGfLqo9GNTzZdkvDo5Q==
X-Received: by 2002:a17:902:c7c2:b0:143:bdf7:1670 with SMTP id r2-20020a170902c7c200b00143bdf71670mr18130203pla.61.1638484072251;
        Thu, 02 Dec 2021 14:27:52 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:51 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 19/34] drm/meson: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:17 -0800
Message-Id: <20211202222732.2453851-20-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211202222732.2453851-1-swboyd@chromium.org>
References: <20211202222732.2453851-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/meson/meson_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 7f41a33592c8..3028f2a45f66 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -356,13 +356,16 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
 	return ret;
 }
 
-static int meson_drv_bind(struct device *dev)
+static int meson_drv_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
+
 	return meson_drv_bind_master(dev, true);
 }
 
-static void meson_drv_unbind(struct device *dev)
+static void meson_drv_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct meson_drm *priv = dev_get_drvdata(dev);
 	struct drm_device *drm = priv->drm;
 
@@ -386,9 +389,13 @@ static void meson_drv_unbind(struct device *dev)
 	}
 }
 
-static const struct component_master_ops meson_drv_master_ops = {
-	.bind	= meson_drv_bind,
-	.unbind	= meson_drv_unbind,
+static struct aggregate_driver meson_aggregate_drv = {
+	.probe	= meson_drv_bind,
+	.remove	= meson_drv_unbind,
+	.driver = {
+		.name = "meson_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int __maybe_unused meson_drv_pm_suspend(struct device *dev)
@@ -502,9 +509,7 @@ static int meson_drv_probe(struct platform_device *pdev)
 	if (count) {
 		dev_info(&pdev->dev, "Queued %d outputs on vpu\n", count);
 
-		return component_master_add_with_match(&pdev->dev,
-						       &meson_drv_master_ops,
-						       match);
+		return component_aggregate_register(&pdev->dev, &meson_aggregate_drv, match);
 	}
 
 	/* If no output endpoints were available, simply bail out */
-- 
https://chromeos.dev

