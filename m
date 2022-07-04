Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA3564EA6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiGDH1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiGDH1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:27:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8FE65EB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:27:04 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Lby5F3npfzkX8g;
        Mon,  4 Jul 2022 15:25:37 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Jul 2022 15:27:02 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Jul
 2022 15:27:02 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-m68k@lists.linux-m68k.org>
CC:     <geert@linux-m68k.org>
Subject: [PATCH] m68k/amiga: fix missing platform_device_unregister() on error in amiga_init_devices()
Date:   Mon, 4 Jul 2022 15:36:44 +0800
Message-ID: <20220704073644.2384999-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing platform_device_unregister() before return
from amiga_init_devices() in the error handling case.

Fixes: eeed227966da ("m68k/amiga: Add error checks when registering platform devices")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 arch/m68k/amiga/platform.c | 99 ++++++++++++++++++++++++++++----------
 1 file changed, 73 insertions(+), 26 deletions(-)

diff --git a/arch/m68k/amiga/platform.c b/arch/m68k/amiga/platform.c
index d34029d7b058..29fc296abf70 100644
--- a/arch/m68k/amiga/platform.c
+++ b/arch/m68k/amiga/platform.c
@@ -131,10 +131,14 @@ static const struct resource amiga_rtc_resource __initconst = {
 };
 
 
+#define AMIGA_PLATFORM_DEVICES	13
+
 static int __init amiga_init_devices(void)
 {
 	struct platform_device *pdev;
+	struct platform_device *pdevs[AMIGA_PLATFORM_DEVICES];
 	int error;
+	int i = 0;
 
 	if (!MACH_IS_AMIGA)
 		return -ENODEV;
@@ -145,6 +149,7 @@ static int __init amiga_init_devices(void)
 						       0);
 		if (IS_ERR(pdev))
 			return PTR_ERR(pdev);
+		pdevs[i++] = pdev;
 	}
 
 
@@ -152,8 +157,11 @@ static int __init amiga_init_devices(void)
 	if (AMIGAHW_PRESENT(AMI_AUDIO)) {
 		pdev = platform_device_register_simple("amiga-audio", -1, NULL,
 						       0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 
@@ -161,46 +169,61 @@ static int __init amiga_init_devices(void)
 	if (AMIGAHW_PRESENT(AMI_FLOPPY)) {
 		pdev = platform_device_register_simple("amiga-floppy", -1,
 						       NULL, 0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(A3000_SCSI)) {
 		pdev = platform_device_register_simple("amiga-a3000-scsi", -1,
 						       &a3000_scsi_resource, 1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(A4000_SCSI)) {
 		pdev = platform_device_register_simple("amiga-a4000t-scsi", -1,
 						       &a4000t_scsi_resource,
 						       1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(A1200_IDE) ||
 	    z_dev_present(ZORRO_PROD_MTEC_VIPER_MK_V_E_MATRIX_530_SCSI_IDE)) {
 		pdev = platform_device_register_simple("amiga-gayle-ide", -1,
 						       &a1200_ide_resource, 1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
 		error = platform_device_add_data(pdev, &a1200_ide_pdata,
 						 sizeof(a1200_ide_pdata));
 		if (error)
-			return error;
+			goto err_unregister_pdevs;
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(A4000_IDE)) {
 		pdev = platform_device_register_simple("amiga-gayle-ide", -1,
 						       &a4000_ide_resource, 1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
 		error = platform_device_add_data(pdev, &a4000_ide_pdata,
 						 sizeof(a4000_ide_pdata));
 		if (error)
-			return error;
+			goto err_unregister_pdevs;
+		pdevs[i++] = pdev;
 	}
 
 
@@ -208,29 +231,41 @@ static int __init amiga_init_devices(void)
 	if (AMIGAHW_PRESENT(AMI_KEYBOARD)) {
 		pdev = platform_device_register_simple("amiga-keyboard", -1,
 						       NULL, 0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(AMI_MOUSE)) {
 		pdev = platform_device_register_simple("amiga-mouse", -1, NULL,
 						       0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(AMI_SERIAL)) {
 		pdev = platform_device_register_simple("amiga-serial", -1,
 						       NULL, 0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(AMI_PARALLEL)) {
 		pdev = platform_device_register_simple("amiga-parallel", -1,
 						       NULL, 0);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 
@@ -238,18 +273,30 @@ static int __init amiga_init_devices(void)
 	if (AMIGAHW_PRESENT(A2000_CLK)) {
 		pdev = platform_device_register_simple("rtc-msm6242", -1,
 						       &amiga_rtc_resource, 1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	if (AMIGAHW_PRESENT(A3000_CLK)) {
 		pdev = platform_device_register_simple("rtc-rp5c01", -1,
 						       &amiga_rtc_resource, 1);
-		if (IS_ERR(pdev))
-			return PTR_ERR(pdev);
+		if (IS_ERR(pdev)) {
+			error = PTR_ERR(pdev);
+			goto err_unregister_pdevs;
+		}
+		pdevs[i++] = pdev;
 	}
 
 	return 0;
+
+err_unregister_pdevs:
+	while (i > 0)
+		platform_device_unregister(pdevs[--i]);
+
+	return error;
 }
 
 arch_initcall(amiga_init_devices);
-- 
2.25.1

