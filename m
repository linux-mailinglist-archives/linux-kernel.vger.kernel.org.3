Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78DBF5280AC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiEPJUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiEPJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:20:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A9025E9D;
        Mon, 16 May 2022 02:20:11 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24G6TQla012162;
        Mon, 16 May 2022 11:19:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=c+mjziGB6Z5wVNAfWJLwF0CJbOzVqeGZSPufTdfYcCY=;
 b=aJqJcviV3TTX0aX7QTgdd9Qsdg/7DvBBWvWFbXRmYM6p+llBP/Beg60yqu8M638hfHhl
 Wbu1XX+wLtnAFg1FxhGujMmY8slvU6hanVzc2vKvWDojt9Pqmbf92bgF7MEn/QIVIMrD
 S/qTQrcfnRFcaWbs3jx758AW1uQpB15VBBrBlOQ5/sX5gVC/RW4uBJhlFFn+7rcsBjuN
 79OBWete7vB5idWwUVkfSiNUWL4/7ENobF3EvuISFe63YOZxCXUlwgt1Fcy48cdAbxG4
 BWoRZi5T3w8IDNt95oO5sojsYKIi9dUpmXqvTJwuYLunGHZJ3QJUScQ7B/7i8rakWYkl 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3g21ukggc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 May 2022 11:19:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 217B4100034;
        Mon, 16 May 2022 11:19:59 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AF932171DB;
        Mon, 16 May 2022 11:19:59 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 16 May 2022 11:19:58
 +0200
From:   Hugues Fruchet <hugues.fruchet@foss.st.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>
Subject: [PATCH 1/3] media: st-mipid02: add support of pixel clock polarity
Date:   Mon, 16 May 2022 11:19:32 +0200
Message-ID: <20220516091934.263141-2-hugues.fruchet@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
References: <20220516091934.263141-1-hugues.fruchet@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
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

Add support of pixel clock polarity.

Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
---
 drivers/media/i2c/st-mipid02.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
index ef976d085d72..59b48026c752 100644
--- a/drivers/media/i2c/st-mipid02.c
+++ b/drivers/media/i2c/st-mipid02.c
@@ -50,6 +50,7 @@
 /* Bits definition for MIPID02_MODE_REG2 */
 #define MODE_HSYNC_ACTIVE_HIGH				BIT(1)
 #define MODE_VSYNC_ACTIVE_HIGH				BIT(2)
+#define MODE_PCLK_SAMPLE_RISING				BIT(3)
 /* Bits definition for MIPID02_DATA_SELECTION_CTRL */
 #define SELECTION_MANUAL_DATA				BIT(2)
 #define SELECTION_MANUAL_WIDTH				BIT(3)
@@ -494,6 +495,8 @@ static int mipid02_configure_from_tx(struct mipid02_dev *bridge)
 		bridge->r.mode_reg2 |= MODE_HSYNC_ACTIVE_HIGH;
 	if (ep->bus.parallel.flags & V4L2_MBUS_VSYNC_ACTIVE_HIGH)
 		bridge->r.mode_reg2 |= MODE_VSYNC_ACTIVE_HIGH;
+	if (ep->bus.parallel.flags & V4L2_MBUS_PCLK_SAMPLE_RISING)
+		bridge->r.mode_reg2 |= MODE_PCLK_SAMPLE_RISING;
 
 	return 0;
 }
-- 
2.25.1

