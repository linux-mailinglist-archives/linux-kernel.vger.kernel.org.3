Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89338466C2B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 23:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349359AbhLBWbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 17:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349201AbhLBWbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 17:31:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6036AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 14:27:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k4so733720plx.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 14:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M08JekQWWfhJJuhYr6RW4wOJsoWLfsGZRbqzD6i13fw=;
        b=B+i5Ls7wrF2++Xq/jQqVhKISURVDtWKr+Of7/Dbgq4Bt0C+Du6oFRWA53Qp3IZsQQ7
         vBkw6heR9rBQQrudufmJ7YQtxEqEPEG/ZP/vQpiuLI5+EWmoNlFCXYRhrjDHtIsVeViS
         YQ7CULwmnkFx1q1lQulAPU/9RUSQeXpwOhWow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M08JekQWWfhJJuhYr6RW4wOJsoWLfsGZRbqzD6i13fw=;
        b=5TEfaXc9r2w5NxxtpEAG1ADHiC77cAjcl6vxjWCU8tR0UIEj5X0UqiSdNJaIn9fg4q
         p7I3OG1JWvFBsvtJvh1OR+g+K7ed2QG57qUogBUa8dZ7TMGrriiQmI0Yx6Caz1/QnXS7
         9kilA/NeOSDZbD4Zen9RS79LwAiTg83hcWYKIn+YyU4t8Hes16BS+BkSq9dCbZBrjBGP
         TFYkf33flfelboB727JwqtSyiTVNNgE6iLKHT6a2MdOxnh754D3kzu8pZwjfK+6MfqCu
         P2OTsoDtyN5f3uIiYPb5+4n4t8abLWOpzgvSPU+2apCZzWbQjRRWMNpZlkYYEBCrf0XR
         4khg==
X-Gm-Message-State: AOAM5305vMMsI5X7ySmEaj7f+TrtN+jPH+L0IjgDXaBGyF/iCmFDX968
        PjTH/uHzQkpnG280YpcmhelqiQ==
X-Google-Smtp-Source: ABdhPJyvaIgvk3KgS40jCQL1KZMeoM4fJb4tO+zhFvPEG+xtzKlHXn84csPkGOfPvvfWPE3xS8XVvw==
X-Received: by 2002:a17:90a:df96:: with SMTP id p22mr9145224pjv.129.1638484056924;
        Thu, 02 Dec 2021 14:27:36 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:201:f4f2:1b7e:5aea:bf3c])
        by smtp.gmail.com with ESMTPSA id q9sm836934pfj.9.2021.12.02.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 14:27:36 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH v4 01/34] component: Introduce struct aggregate_device
Date:   Thu,  2 Dec 2021 14:26:59 -0800
Message-Id: <20211202222732.2453851-2-swboyd@chromium.org>
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
In-Reply-To: <20211202222732.2453851-1-swboyd@chromium.org>
References: <20211202222732.2453851-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'struct master' with 'struct aggregate_device' and then rename
'master' to 'adev' everywhere in the code. While we're here, put a
struct device inside the aggregate device so that we can register it
with a bus_type in the next patch.

The diff is large but that's because this is mostly a rename, where
sometimes 'master' is replaced with 'adev' and other times it is
replaced with 'parent' to indicate that the struct device that was being
used is actually the parent of the aggregate device and driver.

Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/base/component.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 2d25a6416587..d25048d04b70 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -9,6 +9,7 @@
  */
 #include <linux/component.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
@@ -63,7 +64,10 @@ struct master {
 
 	const struct component_master_ops *ops;
 	struct device *parent;
+	struct device dev;
 	struct component_match *match;
+
+	int id;
 };
 
 struct component {
@@ -79,6 +83,7 @@ struct component {
 static DEFINE_MUTEX(component_mutex);
 static LIST_HEAD(component_list);
 static LIST_HEAD(masters);
+static DEFINE_IDA(aggregate_ida);
 
 #ifdef CONFIG_DEBUG_FS
 
@@ -440,6 +445,7 @@ static void free_master(struct master *master)
 		}
 	}
 
+	ida_free(&aggregate_ida, master->id);
 	kfree(master);
 }
 
@@ -460,7 +466,7 @@ int component_master_add_with_match(struct device *parent,
 	struct component_match *match)
 {
 	struct master *master;
-	int ret;
+	int ret, id;
 
 	/* Reallocate the match array for its true size */
 	ret = component_match_realloc(match, match->num);
@@ -471,9 +477,17 @@ int component_master_add_with_match(struct device *parent,
 	if (!master)
 		return -ENOMEM;
 
+	id = ida_alloc(&aggregate_ida, GFP_KERNEL);
+	if (id < 0) {
+		kfree(master);
+		return id;
+	}
+
+	master->id = id;
 	master->parent = parent;
 	master->ops = ops;
 	master->match = match;
+	dev_set_name(&master->dev, "aggregate%d", id);
 
 	component_master_debugfs_add(master);
 	/* Add to the list of available masters. */
-- 
https://chromeos.dev

