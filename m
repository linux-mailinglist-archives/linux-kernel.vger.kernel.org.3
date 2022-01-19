Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3959493429
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 05:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351603AbiASE4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 23:56:24 -0500
Received: from tkylinode-sdnproxy-1.icoremail.net ([139.162.70.28]:64606 "HELO
        tkylinode-sdnproxy-1.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S232968AbiASE4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 23:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=49zBCY9KQsAb1xr/pbdv8Gk6y+VEm9m4YdC386ca2X0=; b=a
        YWN8svgNyPW3TSyDKOARO1jYBDwUHEzqim7qCVvqttjKpKqSWjr4alS9TvDTt8zJ
        yDqLBmMr2dotPjuWvNCSrxHCxpWxggP5X95dFCqpfLnKcFsx5Mzkjpbq1XEaDfsn
        t5LjW4SkERmA7hGF1WFJYaB5nDzGHRw4l9ZmtYlEkM=
Received: from localhost (unknown [10.129.21.144])
        by front02 (Coremail) with SMTP id 54FpogBHR7M7medhSU97AA--.7476S2;
        Wed, 19 Jan 2022 12:53:15 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     hjc@rock-chips.com, heiko@sntech.de, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH] drm/rockchip: Fix runtime PM imbalance on error
Date:   Tue, 18 Jan 2022 20:53:14 -0800
Message-Id: <1642567994-26165-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: 54FpogBHR7M7medhSU97AA--.7476S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4Utw4UJw1fXF1DJF48Xrb_yoW8WFWUpw
        4kJFy0vrWxuayjqrWDCF4kXrZ0ka9FyayxGrs7GasxZF12yF1Dtw15uryFqF43Xr97AFya
        vrs7Aa47JF42qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF
        04k20xvE74AGY7Cv6cx26w4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
        AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
        c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
        AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbXdbU
        UUUUU==
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEKBlPy7uA+KwAVsh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() will increase the rumtime PM counter
even it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/rockchip/cdn-dp-core.c   | 2 +-
 drivers/gpu/drm/rockchip/rockchip_lvds.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 4740cc1..05c6abf 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -100,7 +100,7 @@ static int cdn_dp_clk_enable(struct cdn_dp_device *dp)
 		goto err_core_clk;
 	}
 
-	ret = pm_runtime_get_sync(dp->dev);
+	ret = pm_runtime_resume_and_get(dp->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dp->dev, "cannot get pm runtime %d\n", ret);
 		goto err_pm_runtime_get;
diff --git a/drivers/gpu/drm/rockchip/rockchip_lvds.c b/drivers/gpu/drm/rockchip/rockchip_lvds.c
index 0b97241..721ee0f 100644
--- a/drivers/gpu/drm/rockchip/rockchip_lvds.c
+++ b/drivers/gpu/drm/rockchip/rockchip_lvds.c
@@ -146,7 +146,7 @@ static int rk3288_lvds_poweron(struct rockchip_lvds *lvds)
 		DRM_DEV_ERROR(lvds->dev, "failed to enable lvds pclk %d\n", ret);
 		return ret;
 	}
-	ret = pm_runtime_get_sync(lvds->dev);
+	ret = pm_runtime_resume_and_get(lvds->dev);
 	if (ret < 0) {
 		DRM_DEV_ERROR(lvds->dev, "failed to get pm runtime: %d\n", ret);
 		clk_disable(lvds->pclk);
-- 
2.7.4

