Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9164A5280AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbiEPJUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiEPJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:20:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824D25EA0;
        Mon, 16 May 2022 02:20:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G88H8D019063;
        Mon, 16 May 2022 11:20:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=jsjDMVAKri3Xuqbm+T4vNwGLBnLq9IeueRAW8u9QgKw=;
 b=ZH/1gV2gGwBn8gVx6rSUfuQIZaEtfcQoVHpxwBBFyc8JiEmdQgdJCZJHlveBgV3ZUBgk
 SYk/ML9DKIMC2eVB2o9O3br5+LjYwcWudl/cvjWACDlj0iZjFzNHf5JmHRgins/LRQ3G
 3e4FXvUavE8VKKsGbcoCYcKb7AQrJYNF859/9MqQitU+YA1LV3uDkngLRddnfYPhVZgP
 thKTvC8ipEO9S+GjbevAzAiyq8thgPf17ZOD6GIhLEoIi/UEDU599FtNCdCDSeu0M3lu
 0x88BSHpkgVSK7qmm/bfLPqc+ccwPj/1A1Detu6wdfjAeNYrOz3HeNhllCJ5Qwr2XTun dA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21ukggch-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:20:00 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6EAB810002A;
        Mon, 16 May 2022 11:20:00 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6947E2171DB;
        Mon, 16 May 2022 11:20:00 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 11:19:59
 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>
Subject: [PATCH 2/3] media: st-mipid02: add support for YVYU and VYUY formats
Date:   Mon, 16 May 2022 11:19:33 +0200
Message-ID: <20220516091934.263141-3-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
References: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_06,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alain Volmat <alain.volmat@foss.st.com>

Those two formats were missing in the list of supported MBUS
formats.

Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index 59b48026c752..fe884d81b08b 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -64,7 +64,8 @@ static const u32 mipid02_supported_fmt_codes[] = {
 	MEDIA_BUS_FMT_SGRBG12_1X12, MEDIA_BUS_FMT_SRGGB12_1X12,
 	MEDIA_BUS_FMT_UYVY8_1X16, MEDIA_BUS_FMT_BGR888_1X24,
 	MEDIA_BUS_FMT_RGB565_2X8_LE, MEDIA_BUS_FMT_RGB565_2X8_BE,
-	MEDIA_BUS_FMT_YUYV8_2X8, MEDIA_BUS_FMT_UYVY8_2X8,
+	MEDIA_BUS_FMT_YUYV8_2X8, MEDIA_BUS_FMT_YVYU8_2X8,
+	MEDIA_BUS_FMT_UYVY8_2X8, MEDIA_BUS_FMT_VYUY8_2X8,
 	MEDIA_BUS_FMT_JPEG_1X8
 };
 
@@ -133,7 +134,9 @@ static int bpp_from_code(__u32 code)
 		return 12;
 	case MEDIA_BUS_FMT_UYVY8_1X16:
 	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YVYU8_2X8:
 	case MEDIA_BUS_FMT_UYVY8_2X8:
+	case MEDIA_BUS_FMT_VYUY8_2X8:
 	case MEDIA_BUS_FMT_RGB565_2X8_LE:
 	case MEDIA_BUS_FMT_RGB565_2X8_BE:
 		return 16;
@@ -164,7 +167,9 @@ static u8 data_type_from_code(__u32 code)
 		return 0x2c;
 	case MEDIA_BUS_FMT_UYVY8_1X16:
 	case MEDIA_BUS_FMT_YUYV8_2X8:
+	case MEDIA_BUS_FMT_YVYU8_2X8:
 	case MEDIA_BUS_FMT_UYVY8_2X8:
+	case MEDIA_BUS_FMT_VYUY8_2X8:
 		return 0x1e;
 	case MEDIA_BUS_FMT_BGR888_1X24:
 		return 0x24;
-- 
2.25.1

