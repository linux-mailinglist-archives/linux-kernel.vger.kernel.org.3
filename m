Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2944F1329
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357972AbiDDKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358365AbiDDKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:33:09 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E7619FCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 03:31:11 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:33812.235363298
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id B11F6100214;
        Mon,  4 Apr 2022 18:31:07 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-b7fbf7d79-bwdqx with ESMTP id 27abb62f3e924871848e2b959bd4c426 for l.stach@pengutronix.de;
        Mon, 04 Apr 2022 18:31:09 CST
X-Transaction-ID: 27abb62f3e924871848e2b959bd4c426
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
From:   Sui Jingfeng <15330273260@189.cn>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] drm/etnaviv: add function to create etnaviv platform device
Date:   Mon,  4 Apr 2022 18:31:04 +0800
Message-Id: <20220404103106.1970456-1-15330273260@189.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 This patch separate the code related to the platform device creation
 so that it can be reuse by other function.

 An immediate benefit is we need call of_node_put() only once in the
 for_each_compatible_node(np, NULL, "vivante,gc") loop instead of
 three.

Signed-off-by: Sui Jingfeng <15330273260@189.cn>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c | 47 +++++++++++++++++++--------
 drivers/gpu/drm/etnaviv/etnaviv_drv.h |  4 +++
 2 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 0b756ecb1bc2..69d879e623b8 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -659,10 +659,39 @@ static struct platform_driver etnaviv_platform_driver = {
 
 static struct platform_device *etnaviv_drm;
 
-static int __init etnaviv_init(void)
+int etnaviv_create_platform_device(const char *name,
+				   const char *data[],
+				   unsigned int num)
 {
 	struct platform_device *pdev;
 	int ret;
+
+	pdev = platform_device_alloc(name, PLATFORM_DEVID_NONE);
+	if (!pdev)
+		return -ENOMEM;
+
+	if (data && num) {
+		ret = platform_device_add_data(pdev, data, num * sizeof(char *));
+		if (ret) {
+			platform_device_put(pdev);
+			return ret;
+		}
+	}
+
+	ret = platform_device_add(pdev);
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
+
+	etnaviv_drm = pdev;
+
+	return 0;
+}
+
+static int __init etnaviv_init(void)
+{
+	int ret;
 	struct device_node *np;
 
 	etnaviv_validate_init();
@@ -683,22 +712,12 @@ static int __init etnaviv_init(void)
 		if (!of_device_is_available(np))
 			continue;
 
-		pdev = platform_device_alloc("etnaviv", PLATFORM_DEVID_NONE);
-		if (!pdev) {
-			ret = -ENOMEM;
-			of_node_put(np);
-			goto unregister_platform_driver;
-		}
+		of_node_put(np);
 
-		ret = platform_device_add(pdev);
-		if (ret) {
-			platform_device_put(pdev);
-			of_node_put(np);
+		ret = etnaviv_create_platform_device("etnaviv", NULL, 0);
+		if (ret)
 			goto unregister_platform_driver;
-		}
 
-		etnaviv_drm = pdev;
-		of_node_put(np);
 		break;
 	}
 
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.h b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
index f32f4771dada..944001a21ca2 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.h
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.h
@@ -81,6 +81,10 @@ void etnaviv_gem_describe_objects(struct etnaviv_drm_private *priv,
 	struct seq_file *m);
 #endif
 
+int etnaviv_create_platform_device(const char *name,
+				   const char *data[],
+				   unsigned int num);
+
 #define DBG(fmt, ...) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 #define VERB(fmt, ...) if (0) DRM_DEBUG(fmt"\n", ##__VA_ARGS__)
 
-- 
2.25.1

