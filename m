Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33B55280C2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiEPJVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242129AbiEPJVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:21:34 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED7D26100;
        Mon, 16 May 2022 02:21:24 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G8E5W1005786;
        Mon, 16 May 2022 11:21:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=Q4W3Tjig+WlwJ7hKJLTi8rI/emUqtqXFj0FeCqRaQ3Q=;
 b=qsI4yD4DpV+Z45Pez3UNwySlSjWcJ/PvPbwCIRwr0Dd1WZGmEwouNqMRfB16+DQ0tZQM
 xtDh1Fn8SNIoUC1WHCD3bAsETNyoJ2+5FGJa4qye8plxHejH1SFwolBCwq3xJDpPDh51
 EI75uhr/lMRpEoxoygHz/hPZ5TfXe+HNbtrytXiH72IMfVJpTO+zGxOFUxbgIlLxBqv5
 4rRzUt29spMX2U9kaMsDVgUuFipAG4/8OXQHiASpM566vCDw1glg0VbmF+Fyu14qykQk
 da7T6RQArxsFzrar7zt3rrzpksHW9QPw1ZM4c/4vW6CuT7yZzW8uEB4gQUW0rWEEWmmQ hA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21j8hxph-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:21:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EDCF810002A;
        Mon, 16 May 2022 11:21:06 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E753F2171DB;
        Mon, 16 May 2022 11:21:06 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 11:21:06
 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
CC:     <linux-media@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>
Subject: [PATCH] media: stm32-dcmi: add support of 1X16 serial pixel formats variant
Date:   Mon, 16 May 2022 11:20:48 +0200
Message-ID: <20220516092048.264036-1-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-16_05,2022-05-13_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugues Fruchet <hugues.fruchet@st.com>

Add support of 1X16 serial pixel formats in order to support
CSI-2 camera sensor exposing 1x16 pixel formats only.

Signed-off-by: Hugues Fruchet <hugues.fruchet@st.com>
---
 drivers/media/platform/st/stm32/stm32-dcmi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/st/stm32/stm32-dcmi.c b/drivers/media/platform/st/stm32/stm32-dcmi.c
index 09a743cd7004..b2ba4d95bfa3 100644
--- a/drivers/media/platform/st/stm32/stm32-dcmi.c
+++ b/drivers/media/platform/st/stm32/stm32-dcmi.c
@@ -1592,25 +1592,31 @@ static int dcmi_set_default_fmt(struct stm32_dcmi *dcmi)
 	return 0;
 }
 
-/*
- * FIXME: For the time being we only support subdevices
- * which expose RGB & YUV "parallel form" mbus code (_2X8).
- * Nevertheless, this allows to support serial source subdevices
- * and serial to parallel bridges which conform to this.
- */
 static const struct dcmi_format dcmi_formats[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_RGB565,
 		.mbus_code = MEDIA_BUS_FMT_RGB565_2X8_LE,
 		.bpp = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_RGB565,
+		.mbus_code = MEDIA_BUS_FMT_RGB565_1X16,
+		.bpp = 2,
 	}, {
 		.fourcc = V4L2_PIX_FMT_YUYV,
 		.mbus_code = MEDIA_BUS_FMT_YUYV8_2X8,
 		.bpp = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_YUYV,
+		.mbus_code = MEDIA_BUS_FMT_YUYV8_1X16,
+		.bpp = 2,
 	}, {
 		.fourcc = V4L2_PIX_FMT_UYVY,
 		.mbus_code = MEDIA_BUS_FMT_UYVY8_2X8,
 		.bpp = 2,
+	}, {
+		.fourcc = V4L2_PIX_FMT_UYVY,
+		.mbus_code = MEDIA_BUS_FMT_UYVY8_1X16,
+		.bpp = 2,
 	}, {
 		.fourcc = V4L2_PIX_FMT_JPEG,
 		.mbus_code = MEDIA_BUS_FMT_JPEG_1X8,
-- 
2.25.1

