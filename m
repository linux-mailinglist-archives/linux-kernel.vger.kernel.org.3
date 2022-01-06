Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063FB486C5E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244710AbiAFVqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 16:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbiAFVqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 16:46:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8174C061212
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 13:46:11 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id g11-20020a17090a7d0b00b001b2c12c7273so5406402pjl.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 13:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyFhWuo5Hgtey/EJ0ER9SojRROyEQ1lmEqqEKYabFj8=;
        b=LLJLmS+EadBgDQ+Aos6iptCIFgGQZC4BhHifui4nHYr+soQbQCsuRZf8eUfhEXakUF
         dCR3ZG3GODKgQD6iIPo9rc4CpzlKlxMLQQeuKOmYu2NLvK1RZzv62Y8acfrUkVf786px
         6GNKOfhOa4RrRJZPK8de4dHA9uZuSsO3EcRSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tyFhWuo5Hgtey/EJ0ER9SojRROyEQ1lmEqqEKYabFj8=;
        b=Z+3m5dzhOUQ58StaFzoz5GTouSewZf/YyPi3+9Kh/bMEsU2a+Zr/6+P1hfaEQ0XaqO
         fEI1GyvJO27mK7rJB6azcJK9vPKE+29Kj6M8gaAj9X8gEFIfDmpqizIsiiXUlfb9aVj7
         QmqaFiu7UNcybwefex9mWEgKbccoZq5Y5cQVRETuGCC15gZW4+BHWsI1erRjdu/ULsEP
         MMBj3qIuqOfKHDR2jetuwc5EeJvNy6OMa9AfLVPu3+IYTiQC1OViNz3ifF1crjvSL03R
         ivI+8wLJDmkYMrsTJwEv1rlCaeqNBEGy1Uxjqhpf09qr14LL7fTJjmX91udZH+iLqB+5
         2TxA==
X-Gm-Message-State: AOAM531a4Ut79Eb0DAi3Z/z8+ET1OmziVLP4G+0EM4EiIet9QrK3CNFH
        tD4tEkJKtCkHh5SRcTZVnRaUyg==
X-Google-Smtp-Source: ABdhPJyyF7cPL+yI9hyzDjsYLKeK8/7opWbfS9Q9aFqPjk9CLzLHOaxee/DCuNvQMK+M3j2T3mtM3A==
X-Received: by 2002:a17:90b:3143:: with SMTP id ip3mr12288271pjb.58.1641505571119;
        Thu, 06 Jan 2022 13:46:11 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:1ebe:a8fd:f9b0:7e85])
        by smtp.gmail.com with ESMTPSA id 10sm3539960pfm.56.2022.01.06.13.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:46:10 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v5 09/32] drm/malidp: Migrate to aggregate driver
Date:   Thu,  6 Jan 2022 13:45:32 -0800
Message-Id: <20220106214556.2461363-10-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
In-Reply-To: <20220106214556.2461363-1-swboyd@chromium.org>
References: <20220106214556.2461363-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

TODO: This can be updated to move the drm helper logic into the
aggregate driver shutdown op.

Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/arm/malidp_drv.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 78d15b04b105..e6ee4d1e3bb8 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -702,8 +702,9 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	return 0;
 }
 
-static int malidp_bind(struct device *dev)
+static int malidp_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct resource *res;
 	struct drm_device *drm;
 	struct malidp_drm *malidp;
@@ -894,8 +895,9 @@ static int malidp_bind(struct device *dev)
 	return ret;
 }
 
-static void malidp_unbind(struct device *dev)
+static void malidp_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 	struct malidp_hw_device *hwdev = malidp->dev;
@@ -921,9 +923,13 @@ static void malidp_unbind(struct device *dev)
 	of_reserved_mem_device_release(dev);
 }
 
-static const struct component_master_ops malidp_master_ops = {
-	.bind = malidp_bind,
-	.unbind = malidp_unbind,
+static struct aggregate_driver malidp_aggregate_driver = {
+	.probe = malidp_bind,
+	.remove = malidp_unbind,
+	.driver = {
+		.name = "malidp_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int malidp_compare_dev(struct device *dev, void *data)
@@ -949,13 +955,12 @@ static int malidp_platform_probe(struct platform_device *pdev)
 	drm_of_component_match_add(&pdev->dev, &match, malidp_compare_dev,
 				   port);
 	of_node_put(port);
-	return component_master_add_with_match(&pdev->dev, &malidp_master_ops,
-					       match);
+	return component_aggregate_register(&pdev->dev, &malidp_aggregate_driver, match);
 }
 
 static int malidp_platform_remove(struct platform_device *pdev)
 {
-	component_master_del(&pdev->dev, &malidp_master_ops);
+	component_aggregate_unregister(&pdev->dev, &malidp_aggregate_driver);
 	return 0;
 }
 
-- 
https://chromeos.dev

