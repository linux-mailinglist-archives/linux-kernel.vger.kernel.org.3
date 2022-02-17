Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3F74BA24D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241681AbiBQOBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:01:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbiBQOBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:01:30 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7133A2B0B0D;
        Thu, 17 Feb 2022 06:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645106473; x=1676642473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DYznwx5dXH097XmlK1oyi9a51is+vbtNveAKiaCJeUg=;
  b=wdCNkc2znlONgEwhzFALGYrQTxihZ0JMeN9p+udN3ay/XdTEYtiVRhkv
   5S+DjSbE9IbkvUpwBOkInCLH36z/XBlWt4aPi7pSP3p91qe2u9bekT5Ai
   nmGkYxOpel1HeInzbJ2f2+RbKnGuvaYLQoGlwOD5WALfNmGTK6jOrunKr
   lH2ODCG/0sukqiCky/IqACj6HFT0ljQlp1zLwt3yf7Vc0fZQVQd9QrmNE
   4sslsDb03lxPS5EkCVHuU1ExpoH0173Zwc+fxp2xZHb/GyFN0scvcAudJ
   SvXmMZ3elqECCovXW79blXtNlsjI9uzVTLupPNxzumUTD6W3SNBGa0KbC
   g==;
IronPort-SDR: Fykht/l+LCwGpjr/k8LMa/3SUWrXG3kFHr3Yx/GNdewziLO/wUY5ir2dSl0nEYn2Tmo7k7Nthy
 d2qNXRi6tpfYIRN9u1Ndoa03gsgBTOsA23FpZKEDPbR0aTk3BmofMCut+cEUGXlMaHQE+P+KTG
 t9091gr6o0dpiYxRa3RQyuBsYCinR4OCosTBbdsIwigJH5054WcQkQ5WZa44zSEtPiiy5f4zKS
 PM91hLecEoSSWXOKz4B8qU1NyTSM6Ea38830+h4fBV9FV00mzQl97BCUsfHD2yZ5DjPKaelifx
 ecQ6dS8nK0QY9fQmJy8E+vFM
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="149064584"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Feb 2022 07:01:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 17 Feb 2022 07:01:12 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Thu, 17 Feb 2022 07:00:55 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>, <jacopo@jmondi.org>,
        <hverkuil-cisco@xs4all.nl>, <nicolas.ferre@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <claudiu.beznea@microchip.com>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v5 12/13] ARM: configs: at91: sama7: add xisc and csi2dc
Date:   Thu, 17 Feb 2022 15:56:44 +0200
Message-ID: <20220217135645.1427466-13-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217135645.1427466-1-eugen.hristev@microchip.com>
References: <20220217135645.1427466-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable XISC and CSI2DC drivers.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 arch/arm/configs/sama7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 0368068e04d9..9918cff93e5b 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -127,6 +127,8 @@ CONFIG_MEDIA_SUPPORT_FILTER=y
 CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_PLATFORM_SUPPORT=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
+CONFIG_VIDEO_ATMEL_XISC=y
+CONFIG_VIDEO_MICROCHIP_CSI2DC=y
 CONFIG_VIDEO_IMX219=m
 CONFIG_VIDEO_IMX274=m
 CONFIG_VIDEO_OV5647=m
-- 
2.25.1

