Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCD4490428
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiAQImK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238332AbiAQImH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:42:07 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49DFC061574;
        Mon, 17 Jan 2022 00:42:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id ie23-20020a17090b401700b001b38a5318easo21423765pjb.2;
        Mon, 17 Jan 2022 00:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5onbuFYOFRTdmiOefhelTPb1vtwXuvBGEeko4zL+Gus=;
        b=lTFBGVb3VI9Pp2XzCX2o8oK0JNGpsLGozrM3M1pjfrgUTyKilWjfe018znEQQv00kV
         uCJ9mZYr2imldsl/X7kKLT/qOTkXfTGSVPjsHAj0hnD5X0jhxQF6pY8Vin51SsJOmeFH
         M79mBIFgVl02iGw6F8gXajYURE5fbTboA6l6Qctc8hRcIdEsAqLNzvPTvnLVJlIa2K2w
         P4aFuwve2uJhkrbDpOESzn8uZUoZdO1BaVxYm5yvxvGRCXcf/QNl9pSPUJ1axlU7jpA6
         IK9On/cYQtiTwawot8vSXJ7AjbBUGfq/B3vtkjSBgMVRtncEg0OqgxJ6T+Am3FQ1FO7E
         DFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5onbuFYOFRTdmiOefhelTPb1vtwXuvBGEeko4zL+Gus=;
        b=h2Pl1iySROm2WA887ymNoG+9FSBXUDeyIm5nU8953lv9L6FbtoRlWML4qLXpswcepw
         Za5NKrzjJr74qiaFpOrISoF1KqI4XKr9e82IdoGFhgEUg0BxqAHHi8BDJb93w78RGz3c
         GaMYnMgZokTrTbwnBgs5PzWVrD6Ru40CPeadeLP/By5LP5AcMt95ZW3AeqkIMwmnALFe
         puCooOwIj6IjHhXREY1S9YlYn9enoI9fW/JK0rXPPkiA/WBpH2f4BuFoNZatkD+U6LZB
         bkzsy+xfJiBqacKQqQ7Qv9La3LBKPZ6UarukIC3Tudm4lzRRuryUni6LcdvGKrEpi2OW
         vJVQ==
X-Gm-Message-State: AOAM530CxDTYl2JOrHyNQlowe9jBb7zo0+32RoiLPdcDWUrT4xwU0q6T
        Jn0aauupGbbPuA5ZTilX8n0IwW3hByY7Fw==
X-Google-Smtp-Source: ABdhPJyUyt6ygJ1Q5CL/MBBOFkS0XS5iZbCH1+5RzfcHne//TAXKgwCe8S9+NnrYFtBqbf2mb0udFA==
X-Received: by 2002:a17:90a:380b:: with SMTP id w11mr23856163pjb.113.1642408926493;
        Mon, 17 Jan 2022 00:42:06 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([240e:47b:800:d5d1:d9c9:3c3f:6ba3:517a])
        by smtp.gmail.com with ESMTPSA id b7sm6385498pff.61.2022.01.17.00.42.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jan 2022 00:42:05 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, mark.rutland@arm.com,
        javierm@redhat.com, tzimmermann@suse.de, lukas.bulwahn@gmail.com
Cc:     zou_wei@huawei.com, kevin3.tang@gmail.com, pony1.wu@gmail.com,
        orsonzhai@gmail.com, dan.carpenter@oracle.com,
        zhang.lyra@gmail.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: [PATCH v2 3/3] drm/sprd: check the platform_get_resource() return value
Date:   Mon, 17 Jan 2022 16:41:56 +0800
Message-Id: <20220117084156.9338-1-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may fail and return NULL, so check it's value
before using it.

Reported-by: Zou Wei <zou_wei@huawei.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

v1 -> v2:
- new patch
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 5 +++++
 drivers/gpu/drm/sprd/sprd_dsi.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 06a3414ee..1637203ea 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -790,6 +790,11 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O resource\n");
+		return -EINVAL;
+	}
+
 	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!ctx->base) {
 		dev_err(dev, "failed to map dpu registers\n");
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 911b3cddc..12b67a5d5 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -907,6 +907,11 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi,
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(dev, "failed to get I/O resource\n");
+		return -EINVAL;
+	}
+
 	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!ctx->base) {
 		drm_err(dsi->drm, "failed to map dsi host registers\n");
-- 
2.29.0

