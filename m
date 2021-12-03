Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3351046738B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379375AbhLCI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:59:45 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40450 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350768AbhLCI7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:59:43 -0500
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B380wFr003800;
        Fri, 3 Dec 2021 09:56:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : subject
 : date : message-id : mime-version : content-type; s=selector1;
 bh=cmrBGM+3iRDXCSmRYdnfWthI/23p1rdwmYTRmVd+4vU=;
 b=ARnTBzVXIrrf6iGM5r+xo/fE9mIWMIonWvY/3+APbbe1xupDuG48rDXU5juEFBH7wXFn
 K91xhp8iUojPsNllkevKqpSyaQtt9t6hAO8K4Y4nk5+d4maPkOoiTsVygi2Cy+OVlYw9
 TA20PgjPKeBJcw+Xi9Kij55fSdd9/ncvla1BqKF5uWxdUwvySF+XtJggJA6maJTW4LfE
 q6FhXf2eG5vK6ymd20vpRg2M2Xgbm+z6j4prA5pX5WtxSF7xRWNnMMzMA4mvEqJ4qQHJ
 g5LKGjFTBcF+NPb9UpHT68MWKFIn3SQ/O94AzKaol8Q+ku1E2CfMZfYlWbpuoXNkevt6 kg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3cpxs3mrep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 09:56:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8723210002A;
        Fri,  3 Dec 2021 09:56:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 75ABC226FAF;
        Fri,  3 Dec 2021 09:56:04 +0100 (CET)
Received: from localhost (10.75.127.47) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Fri, 3 Dec 2021 09:56:03
 +0100
From:   Yannick Fertre <yannick.fertre@foss.st.com>
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/stm: remove conflicting framebuffers
Date:   Fri, 3 Dec 2021 09:55:12 +0100
Message-ID: <20211203085512.11127-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_05,2021-12-02_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of using simplefb or another conflicting framebuffer,
call drm_aperture_remove_framebuffers() to remove memory allocated.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 222869b232ae..5ba46f70f081 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -14,6 +14,7 @@
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_aperture.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_drv.h>
@@ -193,6 +194,10 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_put;
 
+	ret = drm_aperture_remove_framebuffers(false, &drv_driver);
+	if (ret)
+		goto err_put;
+
 	ret = drm_dev_register(ddev, 0);
 	if (ret)
 		goto err_put;
-- 
2.17.1

