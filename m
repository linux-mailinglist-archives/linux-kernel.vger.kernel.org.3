Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7A94622BB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhK2VDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhK2VBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:47 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93943C11FA35;
        Mon, 29 Nov 2021 10:26:42 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 133so15479643wme.0;
        Mon, 29 Nov 2021 10:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWzzP3/wZqXojr9D0rKdXZ64ct8p427xpqtRAcNwtec=;
        b=eaOuG6M65E3Pd/n9mztbM6SnzysPCh7Dy35mWAIAsXL5YLwSnFqRBEOe+Dh0AsFYd0
         q5rNjWz7/trGczgMTJWnmHDBWXoVch4YG/9KXarUPhtYDNRHIPnemyU3cvLWPg0f3brj
         fX/txBUlt4dHCPEq31Ex4efQ81mFS+pPn+L3puV+ZtrpzjAQnQZdQ8bPUbP2mfXotvSi
         BOKvhJEtzBtvIjKzSXrXFFLQ9Zj6zZDT3ILE9gBzTpHGVyi9eYziWc028far+RMThiRv
         9XOY84Fa0cdZdxDHZOGFbh/4xEVV8qoGVcFI4rRo/j9FCNFb0dhqvU1lkbJ7l5dH83oT
         3giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWzzP3/wZqXojr9D0rKdXZ64ct8p427xpqtRAcNwtec=;
        b=Nfy5hiAUyw3BcryWAJ6V/bMBxS3cmPBeNEAWVJzBI6SaIl8HyUdbtsJyUlJHONw/i7
         zW1ADCdQpUOzkxlSU591VPPBfXXS6S+7ZsFqdF1fpLrVH6N8qkk3nHZ+Llt5eBM1dRuO
         jzbCsowLUFhRfr9O9TSW3qpI02J4sTet/BAEMxhd5FjveCUauTBILnv4PMUB0gGuZzFI
         7BYAsHNVH4jJdblPC+Kl/KkkJm95JPsu9jgFSXLCMVzHbSuNNUcSmFYzXzItMUn5WR/R
         vIpp3Q4PZtsNoLNucIthsLtwR/IhCpKj83BgqemO2pVUmtoXFSYHU3NmYHvU6McrdHZd
         DDhw==
X-Gm-Message-State: AOAM532wx2WfinzmSjE6QvDk53AP8YRXCZtNDuQlA8o4Rgz7w8N9blFF
        RmU8W1qS/1oAQr6vtxfJ7KRLt0bzicsWSw==
X-Google-Smtp-Source: ABdhPJzfV4IJ4BrEen7JVh4JyVgHc1mWqatybftwWR01jvpOhIrMxHGiruFZnig1i2JYb7qBJf7IhQ==
X-Received: by 2002:a05:600c:221a:: with SMTP id z26mr13626wml.20.1638210401154;
        Mon, 29 Nov 2021 10:26:41 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:40 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 2/9] media: hantro: add support for reset lines
Date:   Mon, 29 Nov 2021 19:26:26 +0100
Message-Id: <20211129182633.480021-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some SoCs like Allwinner H6 use reset lines for resetting Hantro G2. Add
support for them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro.h     |  3 +++
 drivers/staging/media/hantro/hantro_drv.c | 15 ++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro.h b/drivers/staging/media/hantro/hantro.h
index 7da23f7f207a..33eb3e092cc1 100644
--- a/drivers/staging/media/hantro/hantro.h
+++ b/drivers/staging/media/hantro/hantro.h
@@ -16,6 +16,7 @@
 #include <linux/videodev2.h>
 #include <linux/wait.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 
 #include <media/v4l2-ctrls.h>
 #include <media/v4l2-device.h>
@@ -171,6 +172,7 @@ hantro_vdev_to_func(struct video_device *vdev)
  * @dev:		Pointer to device for convenient logging using
  *			dev_ macros.
  * @clocks:		Array of clock handles.
+ * @resets:		Array of reset handles.
  * @reg_bases:		Mapped addresses of VPU registers.
  * @enc_base:		Mapped address of VPU encoder register for convenience.
  * @dec_base:		Mapped address of VPU decoder register for convenience.
@@ -190,6 +192,7 @@ struct hantro_dev {
 	struct platform_device *pdev;
 	struct device *dev;
 	struct clk_bulk_data *clocks;
+	struct reset_control *resets;
 	void __iomem **reg_bases;
 	void __iomem *enc_base;
 	void __iomem *dec_base;
diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index 3d3107a39dae..770f4ce71d29 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -905,6 +905,10 @@ static int hantro_probe(struct platform_device *pdev)
 			return PTR_ERR(vpu->clocks[0].clk);
 	}
 
+	vpu->resets = devm_reset_control_array_get(&pdev->dev, false, true);
+	if (IS_ERR(vpu->resets))
+		return PTR_ERR(vpu->resets);
+
 	num_bases = vpu->variant->num_regs ?: 1;
 	vpu->reg_bases = devm_kcalloc(&pdev->dev, num_bases,
 				      sizeof(*vpu->reg_bases), GFP_KERNEL);
@@ -978,10 +982,16 @@ static int hantro_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(vpu->dev);
 	pm_runtime_enable(vpu->dev);
 
+	ret = reset_control_deassert(vpu->resets);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to deassert resets\n");
+		goto err_pm_disable;
+	}
+
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		goto err_pm_disable;
+		goto err_rst_assert;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1037,6 +1047,8 @@ static int hantro_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
+err_rst_assert:
+	reset_control_assert(vpu->resets);
 err_pm_disable:
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
@@ -1056,6 +1068,7 @@ static int hantro_remove(struct platform_device *pdev)
 	v4l2_m2m_release(vpu->m2m_dev);
 	v4l2_device_unregister(&vpu->v4l2_dev);
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
+	reset_control_assert(vpu->resets);
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
 	return 0;
-- 
2.34.1

