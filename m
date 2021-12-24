Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6202347EF6D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352885AbhLXOMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:12:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352862AbhLXOMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:12:44 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C42C061757;
        Fri, 24 Dec 2021 06:12:44 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso11718445pji.0;
        Fri, 24 Dec 2021 06:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LKtQV5KTRsG9IHxm4FJ8noeMZxbwDc6IHyeC+WfY/3c=;
        b=DOT5KFFjCWbDDy6H/GZFBUsGa3dz2hC7lZ8IKarFYPUHQ31k8cjnbIyjeAL/l0rufw
         ZmjgZvi1UVw7zXFVPSRV5Ov9viyJVT/FSQU3zrh07RzGit/ITcDnAjVeV/730uTizIhi
         XMHg/0zL+tKPfY2Z/Yqbi3ONp3LeL/DGYJDIwnloo/D4J76szcbBqFJSx/cj05ZLfp4I
         2U6QXtr6udQVy8304kBPQhLqJ7nT39eY27Qt/ubmh60/C4xc5nM9L/x+86lY3BXikp27
         Sv81vhP/56kDSmPm+We2kN0a0o076Td9DH8wsbp6xcgpgElKpy4xjlYAYtWdjgmIx7Gj
         Uz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LKtQV5KTRsG9IHxm4FJ8noeMZxbwDc6IHyeC+WfY/3c=;
        b=ykMLZ3nTS6ag0RnxBVMzpNgVv7j+HxwbHwBXF+vx0k2ZY5AUVxB8t5KP2CwP6FRwjn
         O0zb6Q9J4y7hJgSkPin3RavatavbjkYgTTlleySi9A3K9/Un9jlRry1TAzYpSOTvtDau
         uUPD3eKRx/ucQDBM+NmtdQEIDuquZeLVIx0eYEhL20ki/AyOMgcFeuNMWQ0Fs+sn24jk
         Oqe9wAyBtQe9eL5bm/HIm/HX7B5DqOIst/xlJWStD2tME8NLjpb6Bi+4e0+GA1CnutMk
         Z4HCTPdBdoA5ZmoGKSQfDcLtkAWF07B3G6NxVeEO3NFSMVmTAgEYni+MKzXsEMHJpDh+
         9jOQ==
X-Gm-Message-State: AOAM532h6k/sq6BdnPctipyTphb6h8tdZwxWNVT9buRQwgKKNzjzKvEE
        qY2NUzUKAyxjVzBwfetKSeg=
X-Google-Smtp-Source: ABdhPJybx5hHsfhWlT1HsaOLuNvrZcxSGTni5JZ12FBvhaUDzheqGWOdte4SVFVxdXW4UpeapPdsDQ==
X-Received: by 2002:a17:90b:3b92:: with SMTP id pc18mr4228293pjb.213.1640355164338;
        Fri, 24 Dec 2021 06:12:44 -0800 (PST)
Received: from nj08008nbu.spreadtrum.com ([240e:47a:800:94db:99e3:c3c:2dfc:8554])
        by smtp.gmail.com with ESMTPSA id h7sm9919140pfv.35.2021.12.24.06.12.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 06:12:44 -0800 (PST)
From:   Kevin Tang <kevin3.tang@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc:     kevin3.tang@gmail.com, pony1.wu@gmail.com, orsonzhai@gmail.com,
        dan.carpenter@oracle.com, zou_wei@huawei.com,
        lukas.bulwahn@gmail.com, zhang.lyra@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v1 2/2] drm/sprd: fix potential NULL dereference
Date:   Fri, 24 Dec 2021 22:12:13 +0800
Message-Id: <20211224141213.27612-3-kevin3.tang@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211224141213.27612-1-kevin3.tang@gmail.com>
References: <20211224141213.27612-1-kevin3.tang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_resource() may fail and return NULL, so check it's value
before using it.

'drm' could be null in sprd_drm_shutdown, and drm_warn maybe dereference
it, remove this warning log.

Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Signed-off-by: Kevin Tang <kevin.tang@unisoc.com>
---
 drivers/gpu/drm/sprd/sprd_dpu.c | 3 +++
 drivers/gpu/drm/sprd/sprd_drm.c | 8 ++------
 drivers/gpu/drm/sprd/sprd_dsi.c | 3 +++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sprd/sprd_dpu.c b/drivers/gpu/drm/sprd/sprd_dpu.c
index 06a3414ee..69683b7ba 100644
--- a/drivers/gpu/drm/sprd/sprd_dpu.c
+++ b/drivers/gpu/drm/sprd/sprd_dpu.c
@@ -790,6 +790,9 @@ static int sprd_dpu_context_init(struct sprd_dpu *dpu,
 	int ret;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
 	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!ctx->base) {
 		dev_err(dev, "failed to map dpu registers\n");
diff --git a/drivers/gpu/drm/sprd/sprd_drm.c b/drivers/gpu/drm/sprd/sprd_drm.c
index a077e2d4d..54030839e 100644
--- a/drivers/gpu/drm/sprd/sprd_drm.c
+++ b/drivers/gpu/drm/sprd/sprd_drm.c
@@ -154,12 +154,8 @@ static void sprd_drm_shutdown(struct platform_device *pdev)
 {
 	struct drm_device *drm = platform_get_drvdata(pdev);
 
-	if (!drm) {
-		drm_warn(drm, "drm device is not available, no shutdown\n");
-		return;
-	}
-
-	drm_atomic_helper_shutdown(drm);
+	if (drm)
+		drm_atomic_helper_shutdown(drm);
 }
 
 static const struct of_device_id drm_match_table[] = {
diff --git a/drivers/gpu/drm/sprd/sprd_dsi.c b/drivers/gpu/drm/sprd/sprd_dsi.c
index 911b3cddc..955c5995a 100644
--- a/drivers/gpu/drm/sprd/sprd_dsi.c
+++ b/drivers/gpu/drm/sprd/sprd_dsi.c
@@ -907,6 +907,9 @@ static int sprd_dsi_context_init(struct sprd_dsi *dsi,
 	struct resource *res;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
 	ctx->base = devm_ioremap(dev, res->start, resource_size(res));
 	if (!ctx->base) {
 		drm_err(dsi->drm, "failed to map dsi host registers\n");
-- 
2.29.0

