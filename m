Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D8D5AA620
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 05:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiIBDEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbiIBDED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 23:04:03 -0400
Received: from cstnet.cn (smtp23.cstnet.cn [159.226.251.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84BD89F8E7;
        Thu,  1 Sep 2022 20:04:01 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-03 (Coremail) with SMTP id rQCowADHzkq8cBFjs39uAA--.13267S2;
        Fri, 02 Sep 2022 10:55:56 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     deller@gmx.de, broonie@kernel.org,
        maarten.lankhorst@linux.intel.com, daniel.vetter@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH 1/2] video: fbdev: gbefb: Convert to use dev_groups
Date:   Fri,  2 Sep 2022 10:55:55 +0800
Message-Id: <20220902025555.3833920-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: rQCowADHzkq8cBFjs39uAA--.13267S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr4xAF4kJrWkXFWxuw1rZwb_yoW8ur1fpa
        n5JFySgr4UG3WUGw47Cr4UWa45Ar1vva4rXryxKw4S9r15ZrW8Wa4kJa4UA3s5JFykW3Wj
        qr1Dtay8CF4qgF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK
        6r4UMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
        0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
        0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
        WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Gr0_
        Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb18P
        UUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner. Moreover, it can
guarantee the success of creation. Therefore, it should be better to
convert to use dev_groups.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
 drivers/video/fbdev/gbefb.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 6b4d5a7f3e15..1582c718329c 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1072,17 +1072,12 @@ static ssize_t gbefb_show_rev(struct device *device, struct device_attribute *at
 
 static DEVICE_ATTR(revision, S_IRUGO, gbefb_show_rev, NULL);
 
-static void gbefb_remove_sysfs(struct device *dev)
-{
-	device_remove_file(dev, &dev_attr_size);
-	device_remove_file(dev, &dev_attr_revision);
-}
-
-static void gbefb_create_sysfs(struct device *dev)
-{
-	device_create_file(dev, &dev_attr_size);
-	device_create_file(dev, &dev_attr_revision);
-}
+static struct attribute *gbefb_attrs[] = {
+	&dev_attr_size.attr,
+	&dev_attr_revision.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(gbefb);
 
 /*
  * Initialization
@@ -1221,7 +1216,6 @@ static int gbefb_probe(struct platform_device *p_dev)
 	}
 
 	platform_set_drvdata(p_dev, info);
-	gbefb_create_sysfs(&p_dev->dev);
 
 	fb_info(info, "%s rev %d @ 0x%08x using %dkB memory\n",
 		info->fix.id, gbe_revision, (unsigned)GBE_BASE,
@@ -1248,7 +1242,6 @@ static int gbefb_remove(struct platform_device* p_dev)
 	gbe_turn_off();
 	arch_phys_wc_del(par->wc_cookie);
 	release_mem_region(GBE_BASE, sizeof(struct sgi_gbe));
-	gbefb_remove_sysfs(&p_dev->dev);
 	framebuffer_release(info);
 
 	return 0;
@@ -1259,6 +1252,7 @@ static struct platform_driver gbefb_driver = {
 	.remove = gbefb_remove,
 	.driver	= {
 		.name = "gbefb",
+		.dev_groups	= gbefb_groups,
 	},
 };
 
-- 
2.25.1

