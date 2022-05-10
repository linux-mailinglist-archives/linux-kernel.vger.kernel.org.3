Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E62BD521D53
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbiEJPDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiEJPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:03:23 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757CC22906B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:26:46 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AA1Sdn011815;
        Tue, 10 May 2022 16:26:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=2ANARSm+ciPJ+EjWxzvHYDRB4kCEaNE52zN2k7UHgmI=;
 b=cnAreZzybHx90XAf0OpH2JQdBBCyuOAxvBFJiz/p45vtOREgtV/yR42ihA+9J6VTrCqA
 618UFwYEMvF4Ez5JUQMtfHEtmvQurvbYOoDZzy5ARYPvDgJceIW4IubgmN6Dh1W49xWw
 h0asDzAQouDf7OoofPM8wuJxqY0OmzbWdrtT8iNJNH8ZyeiQaPJnlTwGnuvArTKr0rEz
 g+rsUZRVf/zGhh3LMX06Nj4KKExpLvZWLlv3O8txWDsDcdBbFw2ds4UID+kxL14DsC76
 Wx2/vCAcPSWYaO8qd4y960rfj5CvqPVcbAQGaDT3eLpZGOf0RX+BJZIoq+aCH3byyrMc gg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3fwfngjywv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 16:26:21 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5449610002A;
        Tue, 10 May 2022 16:26:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 408252291D0;
        Tue, 10 May 2022 16:26:17 +0200 (CEST)
Received: from localhost (10.75.127.50) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Tue, 10 May 2022 16:26:16
 +0200
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To:     Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] drm/stm: ltdc: fix unchecked dereferenced pointer
Date:   Tue, 10 May 2022 16:24:03 +0200
Message-ID: <20220510142403.835902-1-raphael.gallais-pou@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_03,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer of struct *drm_crtc was dereferenced before checking it was non
NULL. This could potentially create a kernel panic.

Fixes: 79b44684a14e ("drm/stm: ltdc: add support for CRC hashing feature")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 6bd45df8f5a7..9c0fadd58d2a 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -1120,7 +1120,7 @@ static void ltdc_crtc_disable_vblank(struct drm_crtc *crtc)
 
 static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 {
-	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
+	struct ltdc_device *ldev;
 	int ret;
 
 	DRM_DEBUG_DRIVER("\n");
@@ -1128,6 +1128,8 @@ static int ltdc_crtc_set_crc_source(struct drm_crtc *crtc, const char *source)
 	if (!crtc)
 		return -ENODEV;
 
+	ldev = crtc_to_ltdc(crtc);
+
 	if (source && strcmp(source, "auto") == 0) {
 		ldev->crc_active = true;
 		ret = regmap_set_bits(ldev->regmap, LTDC_GCR, GCR_CRCEN);
-- 
2.25.1

