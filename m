Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3679F4718DE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 07:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbhLLGYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 01:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhLLGYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 01:24:23 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE21C061714;
        Sat, 11 Dec 2021 22:24:22 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id DD556425C1;
        Sun, 12 Dec 2021 06:24:16 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: [PATCH v3 1/3] of: Move simple-framebuffer device handling from simplefb to of
Date:   Sun, 12 Dec 2021 15:24:05 +0900
Message-Id: <20211212062407.138309-2-marcan@marcan.st>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211212062407.138309-1-marcan@marcan.st>
References: <20211212062407.138309-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code is required for both simplefb and simpledrm, so let's move it
into the OF core instead of having it as an ad-hoc initcall in the
drivers.

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/of/platform.c          |  4 ++++
 drivers/video/fbdev/simplefb.c | 21 +--------------------
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index b3faf89744aa..793350028906 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -540,6 +540,10 @@ static int __init of_platform_default_populate_init(void)
 		of_node_put(node);
 	}
 
+	node = of_get_compatible_child(of_chosen, "simple-framebuffer");
+	of_platform_device_create(node, NULL, NULL);
+	of_node_put(node);
+
 	/* Populate everything else. */
 	of_platform_default_populate(NULL, NULL, NULL);
 
diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index b63074fd892e..57541887188b 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -541,26 +541,7 @@ static struct platform_driver simplefb_driver = {
 	.remove = simplefb_remove,
 };
 
-static int __init simplefb_init(void)
-{
-	int ret;
-	struct device_node *np;
-
-	ret = platform_driver_register(&simplefb_driver);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_OF_ADDRESS) && of_chosen) {
-		for_each_child_of_node(of_chosen, np) {
-			if (of_device_is_compatible(np, "simple-framebuffer"))
-				of_platform_device_create(np, NULL, NULL);
-		}
-	}
-
-	return 0;
-}
-
-fs_initcall(simplefb_init);
+module_platform_driver(simplefb_driver);
 
 MODULE_AUTHOR("Stephen Warren <swarren@wwwdotorg.org>");
 MODULE_DESCRIPTION("Simple framebuffer driver");
-- 
2.33.0

