Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8739576B05
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 02:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiGPAHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 20:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiGPAHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 20:07:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B850215FD3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 17:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657930027; x=1689466027;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B0NmcVWqBiIJwuMdhqHTpX2jPTKLv5AzIu63NOheRms=;
  b=vqiWTO6yMVu/vajEF3vmmtwNSIVzbGDP3eYiqMn5cWF8yYEq7Nf8/u1h
   hwZ08tF8Yf/QTGd3H0ozUcYX1JmiXhNNt7Oo/lhMFHTPAuA98zIleNKhU
   /5Kln8GN/JIBKN1TQ515G7ZK8MdBEZkKArBfogaRGZD91u4CTXGepa+LJ
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 15 Jul 2022 17:07:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 17:07:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 15 Jul 2022 17:07:06 -0700
Received: from maru.qualcomm.com (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 15 Jul
 2022 17:07:05 -0700
From:   Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
CC:     Jamie Iles <quic_jiles@quicinc.com>,
        Graeme Gregory <quic_ggregory@quicinc.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 1/2] mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
Date:   Fri, 15 Jul 2022 17:06:42 -0700
Message-ID: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

4bait will set the erase size to 0 if there is no corresponding
opcode for the 4byte erase. Fix spi_nor_select_uniform_erase to skip
the 0 erase size to avoid mtd device registration failure cases.

Reported-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
---
Changes in v3:
 * Added newly in v3.

 drivers/mtd/spi-nor/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 502967c76c5f..666ef6ce9549 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2113,6 +2113,10 @@ spi_nor_select_uniform_erase(struct spi_nor_erase_map *map,
 
 		tested_erase = &map->erase_type[i];
 
+		/* Skip masked erase types. */
+		if (!tested_erase->size)
+			continue;
+
 		/*
 		 * If the current erase size is the one, stop here:
 		 * we have found the right uniform Sector Erase command.
-- 
2.25.1

