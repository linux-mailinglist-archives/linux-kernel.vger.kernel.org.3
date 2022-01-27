Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578BB49EB96
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343664AbiA0UCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbiA0UB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:01:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F407C061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:01:59 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s2-20020a17090ad48200b001b501977b23so8674534pju.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnLXiJbCUaC6XTZzeAM0x5jkp+ZwTQGnS1QkwL8Pb08=;
        b=lWqllZqrDcVmSKuLBzM5NetfRm+wmp9lMVdzziEYwXfKf4DloUdfa+Hdk0K+m5nRv5
         08JmDvKm12bU1zd+uSV5KyJxyXHDBz0ytGNa5+M+uSId9nA4tL0CF53rTjg3W9Pgts8F
         CKDmILXBrnN/1i89gLb87AXvEofiPkb6aj2jo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnLXiJbCUaC6XTZzeAM0x5jkp+ZwTQGnS1QkwL8Pb08=;
        b=TUCoKi1L5Fx+aBcMgVDvduhY51gHkEJcwBoLxKT+kGS2rAfyJW12kUUpemyjWq97rg
         WsneUaTrF8TRT49XXKtZsWnerkP59hH/q3BMZJvwlg7I4FIp7IS6a1YnB9k1zE2ZQGIZ
         1+UZQkK6W/brzKgdFzSEvhYrn+XJKYcCWoQL2hqme3plBiqYiAk1TAOBtOl9Wwa6vmbq
         u1S6BszAOVPKYwM4iKJqAvOCRJVYAJiYkykdJALdoYPvRfM5+uwoF183tTOY8uA5JesZ
         q/C/L3UMgksaSNAgaUX1otnMRtSvoe1G3jRvp7XzjIAC/5AUGePRvV/7OgbamBroqw41
         zN7A==
X-Gm-Message-State: AOAM532VjIjHUkxBQo0gasib/DaHh6h75bFngx81pBq5/yxthLSGw7ew
        XIWaSIDKe88AjmGL//gThMenpg==
X-Google-Smtp-Source: ABdhPJwELBm2hJJkKCHCGDWi0uz0RH9y0pifltZnK5CSGFtfaIxRrrrZ6UAYfSEjLNlhVwuFfkr4HQ==
X-Received: by 2002:a17:90b:3b46:: with SMTP id ot6mr9864097pjb.179.1643313719206;
        Thu, 27 Jan 2022 12:01:59 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:01:58 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 04/35] component: Add {bind,unbind}_component() ops that take aggregate device
Date:   Thu, 27 Jan 2022 12:01:10 -0800
Message-Id: <20220127200141.1295328-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
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
 include/linux/component.h | 23 ++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 13ac2004a913..5b91a114786d 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -735,8 +735,13 @@ static void component_unbind(struct component *component,
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
@@ -801,7 +806,10 @@ static int component_bind(struct component *component, struct aggregate_device *
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
index c39dea7824af..073cbe9fea32 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -6,6 +6,7 @@
 #include <linux/device/driver.h>
 #include <linux/refcount.h>
 
+struct aggregate_device;
 struct device;
 
 /**
@@ -20,18 +21,39 @@ struct component_ops {
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
@@ -42,7 +64,6 @@ void component_del(struct device *, const struct component_ops *);
 int component_bind_all(struct device *parent, void *data);
 void component_unbind_all(struct device *parent, void *data);
 
-struct aggregate_device;
 struct device *aggregate_device_parent(const struct aggregate_device *adev);
 
 /**
-- 
https://chromeos.dev

