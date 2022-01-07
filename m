Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99AD8487CB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiAGTCP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiAGTCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:02:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9653CC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 11:02:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q80-20020a252a53000000b006108776aa8fso3889037ybq.17
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 11:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XKqA0opv4M4SaNqXIm2oaAfqaVAuDkjjew1Gl5x5T9U=;
        b=ESu9DC4vrz6HeENQfJChPjaki11V1gcQp3tf8QEL/+/Xl07GyceqzwNO7+dmu87xzM
         ukpNfeL8+hZSbSY+lXwWBZu8bLhWTaeAcZ5sJrkR4gBmnL2HXpJEgXpKwhVLqjgRmi/I
         G+CpPUETSI7ajU/SKuJOuu8UCvUjOlx/QK0tvgKaRyjHP/0I1gkMwtkhY6DZbfwonu0n
         6dUTIrx/uIxx9DlrN5OOu24agrtCc93ClAM0KkEulDRkgm2yYq8cHvfTUz4fq7VuMYwo
         BjTeVHetnToH3nI2odefLMevS1VYgvLepLgHHDsQLm/nCayaG/wSRa8yXKiaxVyto9pK
         RQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XKqA0opv4M4SaNqXIm2oaAfqaVAuDkjjew1Gl5x5T9U=;
        b=v22TFpbqT7+NiD9WKbbDLRiSUHDJd3BtTsgDCB2vT88yeJyRYv0WRU4MpMh8lUzFrW
         CGbXiW9UxQdLQeEKLaVoDhR5/JGROxEP1dHvLkuHwoyecSEdZbHOUyWJix44F6soBrMs
         iIWObSt0qt4/CcDyQufX/hTBQurJif6y3P6IZWksNtQsrDXEKnmw9UT11NPWTnG9OrTU
         VMCSz09VzEyEvrzqsgxtElIgvGLpg5UKC1FOcR26MQzR6YouKPevt6/NNkz31yEz2qIz
         ln+iURMUpl9ymx6dQS3yiQMW+J3hgzBeV2ExIvFCcjNtG+kXDcggBb9p/JrkT+PLb82S
         040A==
X-Gm-Message-State: AOAM530QkSVrnGrgoKRQb5Htj0GLufdOAyc5fcTIyLJrx2X5VMPQPVBB
        zzwMWIMab8oCgpkuQARtd36XJX8GMVJd
X-Google-Smtp-Source: ABdhPJy9w719lrPNxGvR88f1uEbtYLF9F0d0YWou0rqUOxsKwUHhc5dLG3y/doJK42uX6mkm6zZCWFvnyvNa
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:6a56:3de8:84b7:696d])
 (user=rajatja job=sendgmr) by 2002:a25:bc89:: with SMTP id
 e9mr6223917ybk.577.1641582133784; Fri, 07 Jan 2022 11:02:13 -0800 (PST)
Date:   Fri,  7 Jan 2022 11:02:06 -0800
Message-Id: <20220107190208.95479-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
Subject: [PATCH v5 1/3] drm/privacy_screen: Add drvdata in drm_privacy_screen
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
        seanpaul@google.com, marcheu@google.com, dtor@google.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Benson Leung <bleung@google.com>
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
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v5: Same as v4
v4: Added "Reviewed-by" from Hans
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
2.34.1.575.g55b058a8bb-goog

