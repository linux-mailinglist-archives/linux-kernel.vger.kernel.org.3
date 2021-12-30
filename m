Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B534820EC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 00:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240949AbhL3X4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240792AbhL3X4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 18:56:16 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7A5C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:16 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so8340164wme.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 15:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rFvL7pdJQp8AYfej671RZFZags7RQdaCXA8Avf0aczk=;
        b=WoQxQyHHNEuujtmRefYts9/eJvYCQLHQHjB5GUm+LIPKgtBu8tbq0hb9pwu6JW2x2p
         aBo/klSOksfErwIeTjmWA3cs0bKZyZBbIVVLm5QXOsvtDkmK03X1NK3HN1rdyugLFQNM
         stdiUoZ3oZMkJzzxu6NDLmY21Da5OTeKgqU+K+uDpGXVyCkU8nc31kdKMYv0rCSjnjSp
         9Lo2k7gPJh1REyQGsi6Cf6/jAMqqFCYhDW5jVfMGw6+TqI0iiqRVhn7LDtgBQgMynEMQ
         55AQFf724ym8bQLeuJBM05h3db/C7F0G5352ZMEFNc/14JrNjuL/wbNoEEh6sUfIVFyK
         1Uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rFvL7pdJQp8AYfej671RZFZags7RQdaCXA8Avf0aczk=;
        b=5L+0prwpKAhVRb7/gSGdaVzR6dSeH+eT7CPq7NYd+RcdBlOd1x7S3b8XzFOlCZo076
         8JwZgQUwZQzcvsp4P8YQPxg22cxHwoqK0JVmiu76zbrQHODrihFJCxf2dY/fdvjqZmni
         kXq0VpmyzQh7dmy7in2oqBLxtWk2oF1BLDnMWxLt3fRqviFGWLWEsz5X4tmFsLFEfdUz
         9+B3+amItzDChsZgiSSZjNMcH7W5R9UNfHg8oxP7uLKiFda7AllMfrBdggcAhnOhYVdj
         Ckm5xOC82UvDQjYI3TPzQzaQFe955gSjGAZitUhwxQOd6E+OYse51+iXiqmbTE9MtAmE
         3VUQ==
X-Gm-Message-State: AOAM530ZKkucFOh1PJUxoiFdIyPluNw/SF/qxFUefLIqTC/v6Wh3IlqU
        8qdVT04LxhGwWQXQfDF2lDA=
X-Google-Smtp-Source: ABdhPJxI/IQ7vUSEInzQPgR4Ojrd7saifRClJXyk6CmGxJ/+kfFq1nRZcPYQTz7DzXSB3+0RMGs1QQ==
X-Received: by 2002:a05:600c:1e12:: with SMTP id ay18mr27786824wmb.14.1640908574997;
        Thu, 30 Dec 2021 15:56:14 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c23-c015-2400-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c015:2400:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id f16sm35137581wmg.27.2021.12.30.15.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 15:56:14 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] drm/meson: osd_afbcd: Add an exit callback to struct meson_afbcd_ops
Date:   Fri, 31 Dec 2021 00:55:14 +0100
Message-Id: <20211230235515.1627522-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
References: <20211230235515.1627522-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use this to simplify the driver shutdown. It will also come handy when
fixing the error handling in meson_drv_bind_master().

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/gpu/drm/meson/meson_drv.c       |  6 ++--
 drivers/gpu/drm/meson/meson_osd_afbcd.c | 41 ++++++++++++++++---------
 drivers/gpu/drm/meson/meson_osd_afbcd.h |  1 +
 3 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
index 80f1d439841a..b919271a6e50 100644
--- a/drivers/gpu/drm/meson/meson_drv.c
+++ b/drivers/gpu/drm/meson/meson_drv.c
@@ -385,10 +385,8 @@ static void meson_drv_unbind(struct device *dev)
 	free_irq(priv->vsync_irq, drm);
 	drm_dev_put(drm);
 
-	if (priv->afbcd.ops) {
-		priv->afbcd.ops->reset(priv);
-		meson_rdma_free(priv);
-	}
+	if (priv->afbcd.ops)
+		priv->afbcd.ops->exit(priv);
 }
 
 static const struct component_master_ops meson_drv_master_ops = {
diff --git a/drivers/gpu/drm/meson/meson_osd_afbcd.c b/drivers/gpu/drm/meson/meson_osd_afbcd.c
index ffc6b584dbf8..0cdbe899402f 100644
--- a/drivers/gpu/drm/meson/meson_osd_afbcd.c
+++ b/drivers/gpu/drm/meson/meson_osd_afbcd.c
@@ -79,11 +79,6 @@ static bool meson_gxm_afbcd_supported_fmt(u64 modifier, uint32_t format)
 	return meson_gxm_afbcd_pixel_fmt(modifier, format) >= 0;
 }
 
-static int meson_gxm_afbcd_init(struct meson_drm *priv)
-{
-	return 0;
-}
-
 static int meson_gxm_afbcd_reset(struct meson_drm *priv)
 {
 	writel_relaxed(VIU_SW_RESET_OSD1_AFBCD,
@@ -93,6 +88,16 @@ static int meson_gxm_afbcd_reset(struct meson_drm *priv)
 	return 0;
 }
 
+static int meson_gxm_afbcd_init(struct meson_drm *priv)
+{
+	return 0;
+}
+
+static void meson_gxm_afbcd_exit(struct meson_drm *priv)
+{
+	meson_gxm_afbcd_reset(priv);
+}
+
 static int meson_gxm_afbcd_enable(struct meson_drm *priv)
 {
 	writel_relaxed(FIELD_PREP(OSD1_AFBCD_ID_FIFO_THRD, 0x40) |
@@ -172,6 +177,7 @@ static int meson_gxm_afbcd_setup(struct meson_drm *priv)
 
 struct meson_afbcd_ops meson_afbcd_gxm_ops = {
 	.init = meson_gxm_afbcd_init,
+	.exit = meson_gxm_afbcd_exit,
 	.reset = meson_gxm_afbcd_reset,
 	.enable = meson_gxm_afbcd_enable,
 	.disable = meson_gxm_afbcd_disable,
@@ -269,6 +275,18 @@ static bool meson_g12a_afbcd_supported_fmt(u64 modifier, uint32_t format)
 	return meson_g12a_afbcd_pixel_fmt(modifier, format) >= 0;
 }
 
+static int meson_g12a_afbcd_reset(struct meson_drm *priv)
+{
+	meson_rdma_reset(priv);
+
+	meson_rdma_writel_sync(priv, VIU_SW_RESET_G12A_AFBC_ARB |
+			       VIU_SW_RESET_G12A_OSD1_AFBCD,
+			       VIU_SW_RESET);
+	meson_rdma_writel_sync(priv, 0, VIU_SW_RESET);
+
+	return 0;
+}
+
 static int meson_g12a_afbcd_init(struct meson_drm *priv)
 {
 	int ret;
@@ -286,16 +304,10 @@ static int meson_g12a_afbcd_init(struct meson_drm *priv)
 	return 0;
 }
 
-static int meson_g12a_afbcd_reset(struct meson_drm *priv)
+static void meson_g12a_afbcd_exit(struct meson_drm *priv)
 {
-	meson_rdma_reset(priv);
-
-	meson_rdma_writel_sync(priv, VIU_SW_RESET_G12A_AFBC_ARB |
-			       VIU_SW_RESET_G12A_OSD1_AFBCD,
-			       VIU_SW_RESET);
-	meson_rdma_writel_sync(priv, 0, VIU_SW_RESET);
-
-	return 0;
+	meson_g12a_afbcd_reset(priv);
+	meson_rdma_free(priv);
 }
 
 static int meson_g12a_afbcd_enable(struct meson_drm *priv)
@@ -380,6 +392,7 @@ static int meson_g12a_afbcd_setup(struct meson_drm *priv)
 
 struct meson_afbcd_ops meson_afbcd_g12a_ops = {
 	.init = meson_g12a_afbcd_init,
+	.exit = meson_g12a_afbcd_exit,
 	.reset = meson_g12a_afbcd_reset,
 	.enable = meson_g12a_afbcd_enable,
 	.disable = meson_g12a_afbcd_disable,
diff --git a/drivers/gpu/drm/meson/meson_osd_afbcd.h b/drivers/gpu/drm/meson/meson_osd_afbcd.h
index 5e5523304f42..e77ddeb6416f 100644
--- a/drivers/gpu/drm/meson/meson_osd_afbcd.h
+++ b/drivers/gpu/drm/meson/meson_osd_afbcd.h
@@ -14,6 +14,7 @@
 
 struct meson_afbcd_ops {
 	int (*init)(struct meson_drm *priv);
+	void (*exit)(struct meson_drm *priv);
 	int (*reset)(struct meson_drm *priv);
 	int (*enable)(struct meson_drm *priv);
 	int (*disable)(struct meson_drm *priv);
-- 
2.34.1

