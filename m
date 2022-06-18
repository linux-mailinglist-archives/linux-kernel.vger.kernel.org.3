Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DB45505B8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 17:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbiFRP0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbiFRP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 11:26:13 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A7060F0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 08:26:12 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 2aKvolTjCEMbD2aKvouZnU; Sat, 18 Jun 2022 17:26:11 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sat, 18 Jun 2022 17:26:11 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Gerd Hoffmann <kraxel@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/bochs: Fix some error handling paths in bochs_pci_probe()
Date:   Sat, 18 Jun 2022 17:26:08 +0200
Message-Id: <0e676e4d56ab5b10fcf22860081414445611dfa7.1655565953.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remove() function calls bochs_hw_fini() but this function is not called
in the error handling of the probe.

This call releases the resources allocated by bochs_hw_init() used in
bochs_load().

Update the probe and bochs_load() to call bochs_hw_fini() if an error
occurs after a successful bochs_hw_init() call.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
I've not been able to find a Fixes: tag because of code re-arrangement
done in 796c3e35ac16.
---
 drivers/gpu/drm/tiny/bochs.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/tiny/bochs.c b/drivers/gpu/drm/tiny/bochs.c
index 4f8bf86633df..d7a34ed4be3e 100644
--- a/drivers/gpu/drm/tiny/bochs.c
+++ b/drivers/gpu/drm/tiny/bochs.c
@@ -581,13 +581,17 @@ static int bochs_load(struct drm_device *dev)
 
 	ret = drmm_vram_helper_init(dev, bochs->fb_base, bochs->fb_size);
 	if (ret)
-		return ret;
+		goto err_hw_fini;
 
 	ret = bochs_kms_init(bochs);
 	if (ret)
-		return ret;
+		goto err_hw_fini;
 
 	return 0;
+
+err_hw_fini:
+	bochs_hw_fini(dev);
+	return ret;
 }
 
 DEFINE_DRM_GEM_FOPS(bochs_fops);
@@ -662,11 +666,13 @@ static int bochs_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent
 
 	ret = drm_dev_register(dev, 0);
 	if (ret)
-		goto err_free_dev;
+		goto err_hw_fini;
 
 	drm_fbdev_generic_setup(dev, 32);
 	return ret;
 
+err_hw_fini:
+	bochs_hw_fini(dev);
 err_free_dev:
 	drm_dev_put(dev);
 	return ret;
-- 
2.34.1

