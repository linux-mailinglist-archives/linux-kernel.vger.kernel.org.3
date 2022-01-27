Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B849249EC17
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343769AbiA0UDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343835AbiA0UCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:02:33 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54FEBC06176D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b15so3708037plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bh1F2H75iE3V27brrpMBVo1PNF+smDK9eKi3jTHA3NU=;
        b=gBKI7blbHBCAqe/knpU0g1G0b00mGDxRkbOl8V2KlrayGyInp0tb8zKjsSLCC9ba+B
         6txoAVtYIwGp0wJWz0h5GuwHFrsX9EJiYKEomLmWAvMba/VOdsiRGqAPMfw6JL64I3K0
         aBC4w7Eku4mmFe1Gk8VnGwVPT0vOj9wX53kac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bh1F2H75iE3V27brrpMBVo1PNF+smDK9eKi3jTHA3NU=;
        b=rB5432A2e0qDKbpEvCjYGi34oQgKWssUwgXoiVDT9c7i9pzEV80fG3JH3VFSbi9n6m
         fFylsB9sIvraN7MWjIQln2vpu64FzW3VyvlVtQJ1ueaED0ykfaaC3zV1nHZeMTlaq55C
         CWzh9AwUgHuGUFLsa0rvF8X7LKfdUDwy2zmkDno/NJ7baXceN1IFiq3VTAHuhbg/B9rq
         IQ4lAdKICeyRGVICsSIO+k4fRvMxxJR5Ye8RasBLQUEVojnr/aRWheoPslx6I3GeKytt
         4s5odWqtvkqYTW4FxA7rPQl25p6PAix8bFB/o39u69DDqvRctiYy68IvShxRf+5H89NB
         H0Rw==
X-Gm-Message-State: AOAM531aGbl3IRBDn9hOpF6+CM5+sb14F9NV7vRJdUjXF+Uw4T+TOF56
        Qas2eDCq3xIz11Tnf/+MAP3vDw==
X-Google-Smtp-Source: ABdhPJzxet8MofwljRD08XsFu9WsvUyEhN8qPVrflK9qDEebKLMf9x4c3sDMbaNHei4PnCArHyeJbw==
X-Received: by 2002:a17:90a:d58d:: with SMTP id v13mr5855255pju.210.1643313744767;
        Thu, 27 Jan 2022 12:02:24 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:02:24 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 23/35] drm/tilcdc: Migrate to aggregate driver
Date:   Thu, 27 Jan 2022 12:01:29 -0800
Message-Id: <20220127200141.1295328-24-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use an aggregate driver instead of component ops so that we can get
proper driver probe ordering of the aggregate device with respect to all
the component devices that make up the aggregate device.

Tested-by: Jyri Sarha <jyri.sarha@iki.fi>
Cc: Tomi Valkeinen <tomba@kernel.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/gpu/drm/tilcdc/tilcdc_drv.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
index 3ddb7c710a3d..c12c579ce66f 100644
--- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
+++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
@@ -529,13 +529,16 @@ static const struct dev_pm_ops tilcdc_pm_ops = {
 /*
  * Platform driver:
  */
-static int tilcdc_bind(struct device *dev)
+static int tilcdc_bind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
+
 	return tilcdc_init(&tilcdc_driver, dev);
 }
 
-static void tilcdc_unbind(struct device *dev)
+static void tilcdc_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = aggregate_device_parent(adev);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 
 	/* Check if a subcomponent has already triggered the unloading. */
@@ -545,9 +548,13 @@ static void tilcdc_unbind(struct device *dev)
 	tilcdc_fini(dev_get_drvdata(dev));
 }
 
-static const struct component_master_ops tilcdc_comp_ops = {
-	.bind = tilcdc_bind,
-	.unbind = tilcdc_unbind,
+static struct aggregate_driver tilcdc_aggregate_driver = {
+	.probe = tilcdc_bind,
+	.remove = tilcdc_unbind,
+	.driver = {
+		.name = "tilcdc_drm",
+		.owner = THIS_MODULE,
+	},
 };
 
 static int tilcdc_pdev_probe(struct platform_device *pdev)
@@ -564,12 +571,9 @@ static int tilcdc_pdev_probe(struct platform_device *pdev)
 	ret = tilcdc_get_external_components(&pdev->dev, &match);
 	if (ret < 0)
 		return ret;
-	else if (ret == 0)
+	if (ret == 0)
 		return tilcdc_init(&tilcdc_driver, &pdev->dev);
-	else
-		return component_master_add_with_match(&pdev->dev,
-						       &tilcdc_comp_ops,
-						       match);
+	return component_aggregate_register(&pdev->dev, &tilcdc_aggregate_driver, match);
 }
 
 static int tilcdc_pdev_remove(struct platform_device *pdev)
@@ -579,10 +583,10 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
 	ret = tilcdc_get_external_components(&pdev->dev, NULL);
 	if (ret < 0)
 		return ret;
-	else if (ret == 0)
+	if (ret == 0)
 		tilcdc_fini(platform_get_drvdata(pdev));
 	else
-		component_master_del(&pdev->dev, &tilcdc_comp_ops);
+		component_aggregate_unregister(&pdev->dev, &tilcdc_aggregate_driver);
 
 	return 0;
 }
-- 
https://chromeos.dev

