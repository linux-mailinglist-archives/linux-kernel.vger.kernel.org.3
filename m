Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8DC49EB90
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiA0UCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343622AbiA0UB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 15:01:58 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6031EC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:01:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id j16so3702986plx.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 12:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mlOjEQaGgQJEWexKeIDPB6ZywfuO0Krhl/6WTCAgp1U=;
        b=eyrrZkbzPEVq72Z6fNYVKdNXOMuVYUB7XGcmAelArR/eBBTm4qv34sUVGHRw2+3Xjb
         qxYlvdBkbnSilPXGvWPCeiDXV+5AgRyZ6rpwDbyu6pszvNmM2d966CHxA1CXRr6njd4o
         N75g5GBD63J2h2qcjJmsi51wKmNMAMIts0FjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mlOjEQaGgQJEWexKeIDPB6ZywfuO0Krhl/6WTCAgp1U=;
        b=CfZUghf71Gxzmx9HZXWtcICX/uod69NPP5lHxJZNJFoh9rfOrTjNszksQxJ45pNy4e
         zzKVg+QitzwMwhEZBmu7T0OC4+RcZKiuXSX1uCbotWELyfdrI7BakRoIIGHZKYHsA231
         BovWc4N2CcOKw91NA36ZhzaFXvNOPIn95F5L3agYhdcrqpC8AXNePzADSkhornqfyCrH
         5WSsBF/txfdSTqv1X1Mm2oxYMEIqhQ7Uynu+WhwqdAk1NUstlQmgKGgvLQ2tTcQ1ZJui
         VNRZsBrqPmrqoae9VMY9CQm6/0ql46OFDX2uos6I7nKi28mYPprP/p+VIOUEf3At0xXn
         PX4w==
X-Gm-Message-State: AOAM530oFX5P8di7pkMVTLxv/Zw6P+aRTAxb1UTPBNOtJFwHTfIPXiYw
        biJbYovLbeeRKjd0wcblAe1hxQ==
X-Google-Smtp-Source: ABdhPJw9tnBKTD10bdf8LXuHDZN29rkJYFCfmvP96l1VR5CM/34SWpZehvfM/GsxZluqGTjuFM522g==
X-Received: by 2002:a17:902:f68e:: with SMTP id l14mr4800119plg.164.1643313717953;
        Thu, 27 Jan 2022 12:01:57 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:9246:1838:3243:3071])
        by smtp.gmail.com with ESMTPSA id k21sm6561190pff.33.2022.01.27.12.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 12:01:57 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v6 03/35] component: Add aggregate_device_parent() for driver use
Date:   Thu, 27 Jan 2022 12:01:09 -0800
Message-Id: <20220127200141.1295328-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127200141.1295328-1-swboyd@chromium.org>
References: <20220127200141.1295328-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows aggregate driver writers to get the parent of the aggregate
device passed to their probe/remove/shutdown functions.

Suggested-by: Jani Nikula <jani.nikula@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c  | 6 ++++++
 include/linux/component.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index dc748ef0b23b..13ac2004a913 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -71,6 +71,12 @@ static inline struct aggregate_device *to_aggregate_device(struct device *d)
 	return container_of(d, struct aggregate_device, dev);
 }
 
+struct device *aggregate_device_parent(const struct aggregate_device *adev)
+{
+	return adev->parent;
+}
+EXPORT_SYMBOL_GPL(aggregate_device_parent);
+
 struct component {
 	struct list_head node;
 	struct aggregate_device *adev;
diff --git a/include/linux/component.h b/include/linux/component.h
index aa69ea0401d3..c39dea7824af 100644
--- a/include/linux/component.h
+++ b/include/linux/component.h
@@ -43,6 +43,7 @@ int component_bind_all(struct device *parent, void *data);
 void component_unbind_all(struct device *parent, void *data);
 
 struct aggregate_device;
+struct device *aggregate_device_parent(const struct aggregate_device *adev);
 
 /**
  * struct component_master_ops - callback for the aggregate driver
-- 
https://chromeos.dev

