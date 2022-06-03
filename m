Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A03A53CC39
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245457AbiFCPV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiFCPV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:21:58 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24345F5A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:21:56 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253FFQEC017973;
        Fri, 3 Jun 2022 17:21:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=7RCLFoGqMwTmWEP7WwIcV4ALshtLZtePe1d/3kYJpfU=;
 b=KrC/+YrEsWQe42iiuS+l4zU073QLJc54Ep69vmPu+ecGLUdIsLhBJy44BsCf1DMn5x4/
 AGyWyWEV7MqqXiJswP/VHYVd8X7jWkKanR9NFJ0l4FcCnfOCwh7OGH9cPzbXQ7XDE9Tg
 VB4KgVEvGl5I05OtTLR3UVsNYicuoX3QVjWkw9TkaNULE+wWMsVEQXMa5L7r/kqb/8iH
 sis7944pWyd32hcWbhx6fLJOP3mq+s6AIrm/J5YrhEQiz5NEeYQR9AsUvP8wq3P6TJ3K
 U0J7khybIeMsZ5LybP4qDrK1aIzXXpla4qkEpnnjNv1MiCSqrfbKrDotz3KF4wi8PyWL sA== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gbc2w747p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 17:21:25 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AAE4540128;
        Fri,  3 Jun 2022 15:42:54 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F34E3226FAA;
        Fri,  3 Jun 2022 15:42:03 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 3 Jun
 2022 15:42:03 +0200
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
Subject: [PATCH] drm/stm: ltdc: disable all layers before crtc shutdown
Date:   Fri, 3 Jun 2022 15:41:51 +0200
Message-ID: <20220603134151.591997-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_05,2022-06-03_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All plans must be disabled before the CRTC shutdown helping
the crtc to restart from a clean situation (without unwanted
planes already enable).

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 drivers/gpu/drm/stm/ltdc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index 6bd45df8f5a7..eeefc3260c07 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -787,11 +787,17 @@ static void ltdc_crtc_atomic_disable(struct drm_crtc *crtc,
 {
 	struct ltdc_device *ldev = crtc_to_ltdc(crtc);
 	struct drm_device *ddev = crtc->dev;
+	int layer_index = 0;
 
 	DRM_DEBUG_DRIVER("\n");
 
 	drm_crtc_vblank_off(crtc);
 
+	/* Disable all layers */
+	for (layer_index = 0; layer_index < ldev->caps.nb_layers; layer_index++)
+		regmap_write_bits(ldev->regmap, LTDC_L1CR + layer_index * LAY_OFS,
+				  LXCR_CLUTEN | LXCR_LEN, 0);
+
 	/* disable IRQ */
 	regmap_clear_bits(ldev->regmap, LTDC_IER, IER_RRIE | IER_FUIE | IER_TERRIE);
 
-- 
2.25.1

