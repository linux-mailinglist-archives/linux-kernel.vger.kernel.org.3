Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695464622B8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 22:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhK2VDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 16:03:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbhK2VBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 16:01:46 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E4FC11FA2E;
        Mon, 29 Nov 2021 10:26:40 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c6-20020a05600c0ac600b0033c3aedd30aso13029799wmr.5;
        Mon, 29 Nov 2021 10:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BpKcc9rm5rbzAZatIAOzggrBDPf3twFeL6olSbnXxPU=;
        b=EZ2uJ0rggm5rd6nlRpQ3ZxOHTGwskWknuwJ6X+/H7KG8oZmW/z/QRYVDK9o7wjR+hy
         idmmsd17KgTQuF2MQoR3LbzYlRh7cufHoCaby3K8ycNUnFl4bKxdAh5yp6f5s3uLTML2
         4dRkc0LvnTVeZ0RlH+4BzsFK+dxwrxBEZN8X5PFIwAzYTs9Bdg5N8X73gT+ozxFexXU/
         MUCK+tIQUasz5ngu+sOyUIm03pUYuy4+cAj3sFeasL9anUiNtCYlqsv20PU8RAsJmHJJ
         VixmPiqpOPz++oel9+YKVCLs4Hj0525uVrxJaQl3Uiyca3H74nC8Hn6tlaavFPUQgqe7
         x4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BpKcc9rm5rbzAZatIAOzggrBDPf3twFeL6olSbnXxPU=;
        b=vghTDUMtNfkzuE4Sdq6nkV3XtcDhpw5cYduXelsUP+veeam64Zr0GbXgmPt6ldDznf
         QqV6/bAk4c5XYMv+PxZY4G+g2ICUqB8sLNfURfmlGqjz/B6s1/z3aAYKeV8UPI0IBQdr
         JnG00MuFzmJ8JOC1gPBs1TMt8NKPvH/cIfbf3tZd4OKj89mBj7bJHNrEDcd/vMoXPoze
         Z9Gm+K3B0qJ1p3g4YT8CSB7hD0lvvWwcBr368sb9Iz6vQ4mHm6NVN2w5kirsMIkoP/hb
         PUwkIkze6y6B08B82Ipd5EjZLiCmvi6Eh47Waj6dVAxjBS4IVv51+IJCXhDZNbZjijvP
         D0mg==
X-Gm-Message-State: AOAM530Iw/gPMuStbELdfRkpgM6Pvom0HpNZO07KEt07sBrJ3067+lRB
        MKfNCwIpjRVPWL/GH+NOlR2WAc5Ak0Tmrw==
X-Google-Smtp-Source: ABdhPJwaFk4yVUq5kkGJf2GasjPsTe3ndZ0bAmMTH8Ot4orQxTQlScuG9Re3xVxW2eh9++aRYdlK/Q==
X-Received: by 2002:a05:600c:3846:: with SMTP id s6mr20926wmr.55.1638210398970;
        Mon, 29 Nov 2021 10:26:38 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id o12sm85907wmq.12.2021.11.29.10.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 10:26:38 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     ezequiel@vanguardiasur.com.ar, nicolas.dufresne@collabora.com,
        mchehab@kernel.org, robh+dt@kernel.org, mripard@kernel.org,
        wens@csie.org, p.zabel@pengutronix.de, andrzej.p@collabora.com,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 1/9] media: hantro: Fix probe func error path
Date:   Mon, 29 Nov 2021 19:26:25 +0100
Message-Id: <20211129182633.480021-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211129182633.480021-1-jernej.skrabec@gmail.com>
References: <20211129182633.480021-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If clocks for some reason couldn't be enabled, probe function returns
immediately, without disabling PM. This obviously leaves PM ref counters
unbalanced.

Fix that by jumping to appropriate error path, so effects of PM functions
are reversed.

Fixes: 775fec69008d ("media: add Rockchip VPU JPEG encoder driver")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/hantro_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/hantro/hantro_drv.c b/drivers/staging/media/hantro/hantro_drv.c
index ab2467998d29..3d3107a39dae 100644
--- a/drivers/staging/media/hantro/hantro_drv.c
+++ b/drivers/staging/media/hantro/hantro_drv.c
@@ -981,7 +981,7 @@ static int hantro_probe(struct platform_device *pdev)
 	ret = clk_bulk_prepare(vpu->variant->num_clocks, vpu->clocks);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to prepare clocks\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = v4l2_device_register(&pdev->dev, &vpu->v4l2_dev);
@@ -1037,6 +1037,7 @@ static int hantro_probe(struct platform_device *pdev)
 	v4l2_device_unregister(&vpu->v4l2_dev);
 err_clk_unprepare:
 	clk_bulk_unprepare(vpu->variant->num_clocks, vpu->clocks);
+err_pm_disable:
 	pm_runtime_dont_use_autosuspend(vpu->dev);
 	pm_runtime_disable(vpu->dev);
 	return ret;
-- 
2.34.1

