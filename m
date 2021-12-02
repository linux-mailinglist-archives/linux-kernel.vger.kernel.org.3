Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935CA466C3A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377228AbhLBWbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349355AbhLBWbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:03 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D25C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:40 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id z6so945017pfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHTGmIfG7F9SDIRewz7zNR4I/bW/soPNx1fVWL7SSqg=;
        b=TIhzbwW7xTHq27qJYHACDhp2KHurEns7No/8zr4oeHK5WpKcaX2tdKQG/2Sq6MTgMc
         u6JYB1BJuxA9+Ndi47NNPXQzi9rkXp8AibeeFayghSUdd/814AmzOwFPk79RSADLlHrG
         ZRj61JMjB9Ung1m1l2YWQAdc4oNREC4YGw5XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHTGmIfG7F9SDIRewz7zNR4I/bW/soPNx1fVWL7SSqg=;
        b=1blRvhOJbwog3+ip43uQ77ZUo1MJJz04k5IX5Dhu5fpK3pevXaBOx+XwwrlC1kG2s+
         D/tvfpqrckojB91DzY6GjzpfywQ8cPe703FR5gkYvkuRntVXgu3eO0SCwcOys2DP994l
         xzbv79cPF3fhqAabOHresfym+cK5iTQT89YOdknkZLQhxIBnuzmJh3Z0WlqSclAGkLAl
         5O59zXFpIBXunaNJlyZXnpb8aL0UDMYMJh2Ln2pDtmwbCNn1FsoMH7NmT+vg8z9WOiU2
         OYBZRWNtgDezsJoz+bDpCLpsgdqdRTMcdpFtVb84YMalPGG/4/dicUpKHMFCwnBaAeSm
         WysA==
X-Gm-Message-State: AOAM532J5ngAcbfKfGm0KqvRvbZpSzW//C6IeK+fGkAATQKrE7YNhvZD
        /M1HIZuaD20h/80QbPf4uP25Jg==
X-Google-Smtp-Source: ABdhPJzqNNOM+2d0wWt373IhGLQCkfpQ8uaLs4Awk+SD55er6894XsVy3NxTKfixb7gtqrTcou2m/A==
X-Received: by 2002:a05:6a00:15c1:b0:49f:d21f:1d63 with SMTP id o1-20020a056a0015c100b0049fd21f1d63mr15298896pfu.18.1638484060421;
        Thu, 02 Dec 2021 14:27:40 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:40 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 05/34] component: Add {bind,unbind}_component() ops that take aggregate device
Date:   Thu,  2 Dec 2021 14:27:03 -0800
Message-Id: <20211202222732.2453851-6-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211202222732.2453851-1-swboyd@chromium.org>
References: <20211202222732.2453851-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We'd like to get more device model features in the component framework
so let's pass the struct aggregate_device pointer instead of the parent
device pointer to the component binding functions. This will allow
drivers to inspect and control things related to the aggregate device in
case they need it, and they'll always be able to get back to the device
they were using before by using the 'parent' member of the aggregate
device struct.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c  | 14 +++++++++++---
 include/linux/component.h | 22 ++++++++++++++++++++++
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index dc38a8939ae6..e9e58b56cda4 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -699,8 +699,13 @@ static void component_unbind(struct component *component,
 {
 	WARN_ON(!component->bound);
 
-	if (component->ops && component->ops->unbind)
-		component->ops->unbind(component->dev, adev->parent, data);
+	if (component->ops) {
+		if (component->ops->unbind)
+			component->ops->unbind(component->dev, adev->parent, data);
+		else if (component->ops->unbind_component)
+			component->ops->unbind_component(component->dev, adev, data);
+	}
+
 	component->bound = false;
 
 	/* Release all resources claimed in the binding of this component */
@@ -765,7 +770,10 @@ static int component_bind(struct component *component, struct aggregate_device *
 	dev_dbg(adev->parent, "binding %s (ops %ps)\n",
 		dev_name(component->dev), component->ops);
 
-	ret = component->ops->bind(component->dev, adev->parent, data);
+	if (component->ops->bind_component)
+		ret = component->ops->bind_component(component->dev, adev, data);
+	else
+		ret = component->ops->bind(component->dev, adev->parent, data);
 	if (!ret) {
 		component->bound = true;
 
diff --git a/include/linux/component.h b/include/linux/component.h
index e99cf8e910f0..d8dcbf9733da 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 
 struct component_match;
+struct aggregate_device;
 
 /**
  * struct component_ops - callbacks for component drivers
@@ -19,18 +20,39 @@ struct component_ops {
 	 *
 	 * Called through component_bind_all() when the aggregate driver is
 	 * ready to bind the overall driver.
+	 *
+	 * Deprecated: Use bind_component() instead.
 	 */
 	int (*bind)(struct device *comp, struct device *master,
 		    void *master_data);
+	/**
+	 * @bind_component:
+	 *
+	 * Called through component_bind_all() when the aggregate driver is
+	 * ready to bind the overall driver.
+	 */
+	int (*bind_component)(struct device *comp, struct aggregate_device *adev,
+			      void *aggregate_data);
 	/**
 	 * @unbind:
 	 *
 	 * Called through component_unbind_all() when the aggregate driver is
 	 * ready to bind the overall driver, or when component_bind_all() fails
 	 * part-ways through and needs to unbind some already bound components.
+	 *
+	 * Deprecated: Use unbind_component() instead.
 	 */
 	void (*unbind)(struct device *comp, struct device *master,
 		       void *master_data);
+	/**
+	 * @unbind_component:
+	 *
+	 * Called through component_unbind_all() when the aggregate driver is
+	 * ready to unbind the overall driver, or when component_bind_all() fails
+	 * part-ways through and needs to unbind some already bound components.
+	 */
+	int (*unbind_component)(struct device *comp, struct aggregate_device *adev,
+				void *aggregate_data);
 };
 
 int component_add(struct device *, const struct component_ops *);
-- 
https://chromeos.dev

