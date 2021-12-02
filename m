Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786D6466CAF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377668AbhLBWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244201AbhLBWbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061FAC061374
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:28:03 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id np6-20020a17090b4c4600b001a90b011e06so890055pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=twEuombJQmVZYlzCOOAcE1ksFq/a2VDjCMuKxzRCQIk=;
        b=Vmq7R0uniulp1DeTd5ImpEzQGrh6zfbWWVaNJdvx+iztqArXgXiU+lWEbbZGf9yRt5
         9SiNk8dMVa94Y6Wt2myrSXV471vpxmqWU+FY1HflWZXXw6yhJoT3b1soIKuXTOgFNVad
         ksarLtgl3XwLKiUyG3kwR1OpROsS2bKghclEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=twEuombJQmVZYlzCOOAcE1ksFq/a2VDjCMuKxzRCQIk=;
        b=qa1ZSacoTZww/s/7I7TojNFqmcaFg5rCdxJiTfyKt1PZ+OOxmRocG88PhOQBN+x1FM
         mGDvX7Dntb/og4ngkqKuiTnf1fHGg5isoLKqZozs058Pmzkwl/Ml9BhE2RPu/3Mz3e1c
         injZ3Tp8FmPMCqylIFbBlBbHTnF1ww5lCm2QwhQ4iS+/2YtzSSVcFy5pSi5f5mbcQr5s
         /+ZLEFrlx4XDAS/x7en5l4WYuqGOtU0MyhS0mJjW+Tz2LWifHNLH6oOwUw4s/ZYjs8Xe
         9AOjvWryfUIbXqeXk4Vrr7rMCowIz+TclcQ8jmW8NSKMmGsd6UUyiN+sMJnHevNWuHDV
         OaDQ==
X-Gm-Message-State: AOAM5317J0k+vB08gNEwsHWvTH/ePzqzPt/4l+sDqApHNdf8anoeAgdF
        mmel1wP9YasYWaKVPg77CIbR3g==
X-Google-Smtp-Source: ABdhPJzc18sbrdkaWxZGqynaCTS8c2C8G6d/iIHzTfoUUvjEPBt4MSBejJHjCvNVYPHsG8WgZ1wkeQ==
X-Received: by 2002:a17:90b:3850:: with SMTP id nl16mr9384332pjb.10.1638484082626;
        Thu, 02 Dec 2021 14:28:02 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:28:02 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 32/34] mei: pxp: Migrate to aggregate driver
Date:   Thu,  2 Dec 2021 14:27:30 -0800
Message-Id: <20211202222732.2453851-33-swboyd@chromium.org>
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

Cc: Vitaly Lubart <vitaly.lubart@intel.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/misc/mei/pxp/mei_pxp.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index f7380d387bab..50688a6fb1a9 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -83,8 +83,9 @@ static const struct i915_pxp_component_ops mei_pxp_ops = {
 	.recv = mei_pxp_receive_message,
 };
 
-static int mei_component_master_bind(struct device *dev)
+static int mei_aggregate_bind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	struct i915_pxp_component *comp_master = mei_cldev_get_drvdata(cldev);
 	int ret;
@@ -98,17 +99,22 @@ static int mei_component_master_bind(struct device *dev)
 	return 0;
 }
 
-static void mei_component_master_unbind(struct device *dev)
+static void mei_aggregate_unbind(struct aggregate_device *adev)
 {
+	struct device *dev = adev->parent;
 	struct mei_cl_device *cldev = to_mei_cl_device(dev);
 	struct i915_pxp_component *comp_master = mei_cldev_get_drvdata(cldev);
 
 	component_unbind_all(dev, comp_master);
 }
 
-static const struct component_master_ops mei_component_master_ops = {
-	.bind = mei_component_master_bind,
-	.unbind = mei_component_master_unbind,
+static struct aggregate_driver mei_aggregate_driver = {
+	.probe = mei_aggregate_bind,
+	.remove = mei_aggregate_unbind,
+	.driver = {
+		.name = "mei",
+		.owner = THIS_MODULE,
+	}
 };
 
 /**
@@ -173,9 +179,7 @@ static int mei_pxp_probe(struct mei_cl_device *cldev,
 	}
 
 	mei_cldev_set_drvdata(cldev, comp_master);
-	ret = component_master_add_with_match(&cldev->dev,
-					      &mei_component_master_ops,
-					      master_match);
+	ret = component_aggregate_register(&cldev->dev, &mei_aggregate_driver, master_match);
 	if (ret < 0) {
 		dev_err(&cldev->dev, "Master comp add failed %d\n", ret);
 		goto err_exit;
@@ -196,7 +200,7 @@ static void mei_pxp_remove(struct mei_cl_device *cldev)
 	struct i915_pxp_component *comp_master = mei_cldev_get_drvdata(cldev);
 	int ret;
 
-	component_master_del(&cldev->dev, &mei_component_master_ops);
+	component_aggregate_unregister(&cldev->dev, &mei_aggregate_driver);
 	kfree(comp_master);
 	mei_cldev_set_drvdata(cldev, NULL);
 
-- 
https://chromeos.dev

