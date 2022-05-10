Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AC521C81
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243121AbiEJOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbiEJOeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:34:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16792F29D2
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:53:16 -0700 (PDT)
Received: from kwepemi100012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KyKDf49VnzGpdw;
        Tue, 10 May 2022 21:50:26 +0800 (CST)
Received: from kwepemm600005.china.huawei.com (7.193.23.191) by
 kwepemi100012.china.huawei.com (7.221.188.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:53:14 +0800
Received: from ubuntu1804.huawei.com (10.67.175.30) by
 kwepemm600005.china.huawei.com (7.193.23.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 21:53:13 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <emma@anholt.net>
CC:     <mripard@kernel.org>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] drm/vc4: hdmi: Fix build error for implicit function declaration
Date:   Tue, 10 May 2022 21:51:48 +0800
Message-ID: <20220510135148.247719-1-tanghui20@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.30]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600005.china.huawei.com (7.193.23.191)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_connector_detect’:
drivers/gpu/drm/vc4/vc4_hdmi.c:228:7: error: implicit declaration of function ‘gpiod_get_value_cansleep’; did you mean ‘gpio_get_value_cansleep’? [-Werror=implicit-function-declaration]
   if (gpiod_get_value_cansleep(vc4_hdmi->hpd_gpio))
       ^~~~~~~~~~~~~~~~~~~~~~~~
       gpio_get_value_cansleep
  CC [M]  drivers/gpu/drm/vc4/vc4_validate.o
  CC [M]  drivers/gpu/drm/vc4/vc4_v3d.o
  CC [M]  drivers/gpu/drm/vc4/vc4_validate_shaders.o
  CC [M]  drivers/gpu/drm/vc4/vc4_debugfs.o
drivers/gpu/drm/vc4/vc4_hdmi.c: In function ‘vc4_hdmi_bind’:
drivers/gpu/drm/vc4/vc4_hdmi.c:2883:23: error: implicit declaration of function ‘devm_gpiod_get_optional’; did you mean ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
  vc4_hdmi->hpd_gpio = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
                       ^~~~~~~~~~~~~~~~~~~~~~~
                       devm_clk_get_optional
drivers/gpu/drm/vc4/vc4_hdmi.c:2883:59: error: ‘GPIOD_IN’ undeclared (first use in this function); did you mean ‘GPIOF_IN’?
  vc4_hdmi->hpd_gpio = devm_gpiod_get_optional(dev, "hpd", GPIOD_IN);
                                                           ^~~~~~~~
                                                           GPIOF_IN
drivers/gpu/drm/vc4/vc4_hdmi.c:2883:59: note: each undeclared identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors

Fixes: 6800234ceee0 ("drm/vc4: hdmi: Convert to gpiod")
Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 6aadb65eb640..823d812f4982 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -38,6 +38,7 @@
 #include <drm/drm_simple_kms_helper.h>
 #include <linux/clk.h>
 #include <linux/component.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/of_address.h>
 #include <linux/of_gpio.h>
-- 
2.17.1

