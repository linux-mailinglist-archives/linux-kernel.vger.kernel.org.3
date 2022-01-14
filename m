Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC18348EBFB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbiANOrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:47:52 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58570 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241999AbiANOrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:47:49 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id A6C881F46A72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642171668;
        bh=cTHqww4IZbi5PdxScVJ5RmgEFWGNWZU4AMAqnvnN1vM=;
        h=From:To:Cc:Subject:Date:From;
        b=D8AJQ4G4r14QCgGUpRCWn6AKwg2pAfphNZFKn9dWfT35vWJoI66KVSW7wOn/gXH8F
         8+A7uBI3Sn2tDAHAu12zTel7evWbULUfMEnbsbcxcD7qYOmoOwRj5QuEa6f11pCGRl
         5TKGmqC9UO3H/KHxP4s6DO9sC+IGFySuqpp0mit5cnsdk9mYk37bFOnzi4dGPnKHZv
         ANmplostgKQQYVTggvCRI3XtxFzRbJFVi+xojzgODipky/Se7m9u57A3wmx0z3RvM+
         VgAMkZairRwIwTkLmvYFbS+bM97KSZJjTomHxGawqHkf0W88KMMwmKbb8P1u8d1H3U
         7bYait9ekDf5w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     bjorn.andersson@linaro.org
Cc:     mathieu.poirier@linaro.org, matthias.bgg@gmail.com,
        pihsun@chromium.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] rpmsg: mtk_rpmsg: Fix circular locking dependency
Date:   Fri, 14 Jan 2022 15:47:37 +0100
Message-Id: <20220114144737.375621-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During execution of the worker that's used to register rpmsg devices
we are safely locking the channels mutex but, when creating a new
endpoint for such devices, we are registering a IPI on the SCP, which
then makes the SCP to trigger an interrupt, lock its own mutex and in
turn register more subdevices.
This creates a circular locking dependency situation, as the mtk_rpmsg
channels_lock will then depend on the SCP IPI lock.

[   18.014514]  Possible unsafe locking scenario:
[   18.014515]        CPU0                    CPU1
[   18.014517]        ----                    ----
[   18.045467]   lock(&mtk_subdev->channels_lock);
[   18.045474]                                lock(&scp->ipi_desc[i].lock);
[   18.228399]                                lock(&mtk_subdev->channels_lock);
[   18.228405]   lock(&scp->ipi_desc[i].lock);
[   18.264405]

To solve this, simply unlock the channels_lock mutex before calling
mtk_rpmsg_register_device() and relock it right after, as safety is
still ensured by the locking mechanism that happens right after
through SCP.
Notably, mtk_rpmsg_register_device() does not even require locking.

Fixes: 7017996951fd ("rpmsg: add rpmsg support for mt8183 SCP.")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/rpmsg/mtk_rpmsg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/mtk_rpmsg.c b/drivers/rpmsg/mtk_rpmsg.c
index 5b4404b8be4c..d1213c33da20 100644
--- a/drivers/rpmsg/mtk_rpmsg.c
+++ b/drivers/rpmsg/mtk_rpmsg.c
@@ -234,7 +234,9 @@ static void mtk_register_device_work_function(struct work_struct *register_work)
 		if (info->registered)
 			continue;
 
+		mutex_unlock(&subdev->channels_lock);
 		ret = mtk_rpmsg_register_device(subdev, &info->info);
+		mutex_lock(&subdev->channels_lock);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't create rpmsg_device\n");
 			continue;
-- 
2.33.1

