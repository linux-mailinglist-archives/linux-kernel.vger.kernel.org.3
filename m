Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 801FF4C87CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiCAJYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiCAJYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:24:35 -0500
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BC9E093
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:23:53 -0800 (PST)
X-QQ-mid: bizesmtp73t1646126609twc082qa
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 01 Mar 2022 17:23:24 +0800 (CST)
X-QQ-SSF: 0140000000800050D000B00B0000000
X-QQ-FEAT: dpyQmELDBxGKbuakA6l8ljWpsjY69dFAv/8RDBqxadSZx5WofEUutzrOtsWDE
        +IZzV12LWxeMkEeUxu1RkKJ+S8wlAsdBviHVUdC2YJvpo3YN1MAq27cbanglTNVWXolTvNB
        /fo/TP//5N6GMlyy380x7tLBZab7Ix8ygitW1Jg29M+Rww1rAPJbygAC2JkhiWvdPbariAr
        nP21RbQv3vEF3D/7TxrFf2AtEcG+thXpFAQHX1eCkfp3g/vwRj+A1vPVDHj9shj7ra4EcaJ
        Gzva7GGzAZAJJsnTyPCWDLyYLVdHsfhSbNsTUk1wBG82wTOEsIYgvEgEpd/0iLgne2uE1V3
        809Q/s4XhuUVk+5tXM1ED7/IxSroQoPSlEezWSP4A2GqgoURCY=
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] Asoc: au1x: Use devm_snd_soc_register_component()
Date:   Tue,  1 Mar 2022 17:23:22 +0800
Message-Id: <20220301092322.5523-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using devm_snd_soc_register_component()
instead of snd_soc_register_component()

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/soc/au1x/ac97c.c    | 2 +-
 sound/soc/au1x/i2sc.c     | 2 +-
 sound/soc/au1x/psc-ac97.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/au1x/ac97c.c b/sound/soc/au1x/ac97c.c
index 3b1700e665f5..795bba756585 100644
--- a/sound/soc/au1x/ac97c.c
+++ b/sound/soc/au1x/ac97c.c
@@ -275,7 +275,7 @@ static int au1xac97c_drvprobe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &au1xac97c_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &au1xac97c_component,
 					 &au1xac97c_dai_driver, 1);
 	if (ret)
 		return ret;
diff --git a/sound/soc/au1x/i2sc.c b/sound/soc/au1x/i2sc.c
index 740d4e052e4d..a3c9d52ef337 100644
--- a/sound/soc/au1x/i2sc.c
+++ b/sound/soc/au1x/i2sc.c
@@ -265,7 +265,7 @@ static int au1xi2s_drvprobe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctx);
 
-	return snd_soc_register_component(&pdev->dev, &au1xi2s_component,
+	return devm_snd_soc_register_component(&pdev->dev, &au1xi2s_component,
 					  &au1xi2s_dai_driver, 1);
 }
 
diff --git a/sound/soc/au1x/psc-ac97.c b/sound/soc/au1x/psc-ac97.c
index 05eb36991f14..3f60313822e7 100644
--- a/sound/soc/au1x/psc-ac97.c
+++ b/sound/soc/au1x/psc-ac97.c
@@ -411,7 +411,7 @@ static int au1xpsc_ac97_drvprobe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = snd_soc_register_component(&pdev->dev, &au1xpsc_ac97_component,
+	ret = devm_snd_soc_register_component(&pdev->dev, &au1xpsc_ac97_component,
 					 &wd->dai_drv, 1);
 	if (ret)
 		return ret;
-- 
2.20.1



