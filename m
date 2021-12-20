Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCBF47B5E2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 23:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhLTW3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 17:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhLTW3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 17:29:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE8AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:29:16 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso22192400yba.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 14:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uLgnyu9H28L0o4/5g5fqJKfG3fFXBkc3fYhacdUUcgw=;
        b=cAXdrsPYMReIJqz5vlx1QjZTgEROMGiIeIGg1hnr/dFqoONdlmTAcHo/00CNsg9RxU
         VoaXWs4KjXDtiw09HbCVQmTDwztU7VhdbAXGWfZIMoPgIkdCLjV9liJf5kwBiT848LLC
         /7LjQ/Y2BXrJFEl49u4tdH1lYhgVhQrlrndd0HCoKPQG2Tk0KA0F/BpRVUJiI1CyfO02
         n7jPM2h//GsKPjnQuzyBJg08CqTtwMF304ADnRMgvyMhkw2OXoYYImgn5UU+PLBcZbnB
         wZuqV46o3YyE31IQCkjN8bKShJgE+LJigzGE2Rtvkn/LNW5A8gPyZBiyiKenCPN+bbNJ
         QhAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uLgnyu9H28L0o4/5g5fqJKfG3fFXBkc3fYhacdUUcgw=;
        b=BfXB9QQrTzFRrG+o/5JhriG/baFyeMPf7dOfFEox1vyOGiIxc+o22VmTwZ7YQY/EqS
         vAZFBUSXeXKx7KFKd7gTlDzQaU1mNS4bdG/VkBQlQPOre+vguEi6Tki8pOWDd0w0q6Cj
         RLPiJRfIjopf/eWFjy5/r33t7eqWnlt/8PoKmEfMs/U58nlQrtIQSRu0Q5XfCu29d2Kd
         p6TGL7pASdVTaMlduDwO7kKRALP21Sy6tjJ7ZlOWm1MP18nerMrAEvc9An8FO0cWBbvw
         uWLpu6brkodokAYVIHAjTg0BuxIaoy6fggpd3SfKs+wtzmZSglmWNGf3YCk2Ewt6vlh5
         dUDg==
X-Gm-Message-State: AOAM532s978+YhKSmhaB6rs6nqYFrW2lv3MmJ0E5vAEkbYDFTgmxmHJ7
        KDYSb+7VqGuh98h7iJTDsU2sdGtPO+Wp
X-Google-Smtp-Source: ABdhPJxYHlhZeIVsUaUYKhbs/4y+GhYqRHEH5FjjkMj0Er17reckxShJn6sW2n6m/r22H7ANDMdsJK08zQQc
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:f6d7:6572:2e42:ea7d])
 (user=rajatja job=sendgmr) by 2002:a25:b682:: with SMTP id
 s2mr433602ybj.736.1640039355990; Mon, 20 Dec 2021 14:29:15 -0800 (PST)
Date:   Mon, 20 Dec 2021 14:28:26 -0800
Message-Id: <20211220222828.2625444-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 1/3] drm/privacy_screen: Add drvdata in drm_privacy_screen
From:   Rajat Jain <rajatja@google.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Hans de Goede <hdegoede@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Benson Leung <bleung@chromium.org>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, gwendal@google.com,
        seanpaul@google.com, marcheu@google.com, dtor@google.com
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow a privacy screen provider to stash its private data pointer in the
drm_privacy_screen, and update the drm_privacy_screen_register() call to
accept that. Also introduce a *_get_drvdata() so that it can retrieved
back when needed.

This also touches the IBM Thinkpad platform driver, the only user of
privacy screen today, to pass NULL for now to the updated API.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Initial version. Came up due to review comments on v2 of other patches.
v2: No v2
v1: No v1

 drivers/gpu/drm/drm_privacy_screen.c    |  5 ++++-
 drivers/platform/x86/thinkpad_acpi.c    |  2 +-
 include/drm/drm_privacy_screen_driver.h | 13 ++++++++++++-
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
index beaf99e9120a..03b149cc455b 100644
--- a/drivers/gpu/drm/drm_privacy_screen.c
+++ b/drivers/gpu/drm/drm_privacy_screen.c
@@ -387,7 +387,8 @@ static void drm_privacy_screen_device_release(struct device *dev)
  * * An ERR_PTR(errno) on failure.
  */
 struct drm_privacy_screen *drm_privacy_screen_register(
-	struct device *parent, const struct drm_privacy_screen_ops *ops)
+	struct device *parent, const struct drm_privacy_screen_ops *ops,
+	void *data)
 {
 	struct drm_privacy_screen *priv;
 	int ret;
@@ -404,6 +405,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
 	priv->dev.parent = parent;
 	priv->dev.release = drm_privacy_screen_device_release;
 	dev_set_name(&priv->dev, "privacy_screen-%s", dev_name(parent));
+	priv->drvdata = data;
 	priv->ops = ops;
 
 	priv->ops->get_hw_state(priv);
@@ -439,6 +441,7 @@ void drm_privacy_screen_unregister(struct drm_privacy_screen *priv)
 	mutex_unlock(&drm_privacy_screen_devs_lock);
 
 	mutex_lock(&priv->lock);
+	priv->drvdata = NULL;
 	priv->ops = NULL;
 	mutex_unlock(&priv->lock);
 
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 341655d711ce..ccbfda2b0095 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9782,7 +9782,7 @@ static int tpacpi_lcdshadow_init(struct ibm_init_struct *iibm)
 		return 0;
 
 	lcdshadow_dev = drm_privacy_screen_register(&tpacpi_pdev->dev,
-						    &lcdshadow_ops);
+						    &lcdshadow_ops, NULL);
 	if (IS_ERR(lcdshadow_dev))
 		return PTR_ERR(lcdshadow_dev);
 
diff --git a/include/drm/drm_privacy_screen_driver.h b/include/drm/drm_privacy_screen_driver.h
index 24591b607675..4ef246d5706f 100644
--- a/include/drm/drm_privacy_screen_driver.h
+++ b/include/drm/drm_privacy_screen_driver.h
@@ -73,10 +73,21 @@ struct drm_privacy_screen {
 	 * for more info.
 	 */
 	enum drm_privacy_screen_status hw_state;
+	/**
+	 * @drvdata: Private data owned by the privacy screen provider
+	 */
+	void *drvdata;
 };
 
+static inline
+void *drm_privacy_screen_get_drvdata(struct drm_privacy_screen *priv)
+{
+	return priv->drvdata;
+}
+
 struct drm_privacy_screen *drm_privacy_screen_register(
-	struct device *parent, const struct drm_privacy_screen_ops *ops);
+	struct device *parent, const struct drm_privacy_screen_ops *ops,
+	void *data);
 void drm_privacy_screen_unregister(struct drm_privacy_screen *priv);
 
 void drm_privacy_screen_call_notifier_chain(struct drm_privacy_screen *priv);
-- 
2.34.1.307.g9b7440fafd-goog

