Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A774447F83E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 17:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhLZQeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 11:34:22 -0500
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:64346 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhLZQeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 11:34:21 -0500
Received: from pop-os.home ([86.243.171.122])
        by smtp.orange.fr with ESMTPA
        id 1WTRnylNK3ptZ1WTSnZDSZ; Sun, 26 Dec 2021 17:34:19 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 26 Dec 2021 17:34:19 +0100
X-ME-IP: 86.243.171.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     linux@armlinux.org.uk, airlied@linux.ie, daniel@ffwll.ch,
        airlied@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] drm/armada: Fix a potential double free in an error handling path
Date:   Sun, 26 Dec 2021 17:34:16 +0100
Message-Id: <c4f3c9207a9fce35cb6dd2cc60e755275961588a.1640536364.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'priv' is a managed resource, so there is no need to free it explicitly or
there will be a double free().

Fixes: 90ad200b4cbc ("drm/armada: Use devm_drm_dev_alloc")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/gpu/drm/armada/armada_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
index 8e3e98f13db4..54168134d9b9 100644
--- a/drivers/gpu/drm/armada/armada_drv.c
+++ b/drivers/gpu/drm/armada/armada_drv.c
@@ -99,7 +99,6 @@ static int armada_drm_bind(struct device *dev)
 	if (ret) {
 		dev_err(dev, "[" DRM_NAME ":%s] can't kick out simple-fb: %d\n",
 			__func__, ret);
-		kfree(priv);
 		return ret;
 	}
 
-- 
2.32.0

