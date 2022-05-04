Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D385198FF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiEDH6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345931AbiEDH5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:57:55 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F79915701;
        Wed,  4 May 2022 00:54:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fWWidEzhOvYX9ivOz1mifW2drRItnn6WbIEoLZHbYlECql1Xtu0yGRC9EQMO3jazrMd2bolcpNJmmlbQw0raoyskIgrAD6Ywr0H3r0XD30yBnqNX5jIElU49Zx0cMIkI9gFuMlRkK40oBDyhAzge5o9mLUNZr2WNflmHuUV6/dGgRX9uGJFZWYegONL8aMk0bH7fpkrw6VmE6oRbyGfr7t1HNlhD3H05FqCHqP2suVocZ8OsCkF0sB4jjfr77IPFUXa1Ik0avXVMLg9cYMflbJ9HNqkMP1hI6jOohsU6Z+j7qxfdHEgAPa0X4gzuDXEWFgl8tzvWEpgiITtw8ooSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aIlBSywv8dekTD0tu+Z3a8Y7zSg9oSstQEXJwz8lVco=;
 b=ARyjAEh52ohbLsb3vatG8pKrVh6Vd4g1Hl3JF9HtSpuL2eD4WDpxymh/E+5TN/KipihQHv+LXSQlpg41KNkDiKIphYboyTKjkOJzwS0qNGhXKZfYxBFkLgPRgGaVgiIx/oK2S1TQ/K8yYDCjUjozVk3b8D2uCqVT0FriYUyvvssnuf+gq0eNqPWu4BXj3NwXtBauHFNLg51tVUJUg/2w18rRo9gQ/oM0Di8eMRFVIEA1b4Q2LiAqWf7Oz/pdYUhfAspgwRjGGP2EDwgV/12T9FRUk/LrLlLH+t4E3D5XSdnptUDSvI6qMrg7sDFCxN8TgQ/1pIBuIoa0oVj84UA5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aIlBSywv8dekTD0tu+Z3a8Y7zSg9oSstQEXJwz8lVco=;
 b=eXAN21ml/YuQJu7jrHyo2uQIzapfwtknx+ZUkSexnuFZWUBa9aD/6Chix66IfE6arMiYBgprCBnYPbqDLrNX7lCwFiGmuSEyuegE9uNn1DEQIlUH96R7UM3+cdr3+oH710TMLJwe748zyOiNtu+kgK9XlkisrNN7NH9oPAr8DJY=
Received: from SN1PR12CA0069.namprd12.prod.outlook.com (2603:10b6:802:20::40)
 by SN6PR02MB4528.namprd02.prod.outlook.com (2603:10b6:805:b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.25; Wed, 4 May
 2022 07:54:18 +0000
Received: from SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:802:20:cafe::bc) by SN1PR12CA0069.outlook.office365.com
 (2603:10b6:802:20::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 07:54:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0037.mail.protection.outlook.com (10.97.4.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 07:54:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 4 May 2022 00:54:02 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 4 May 2022 00:54:02 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 balbi@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=46956 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1nm9pi-000B5T-6E; Wed, 04 May 2022 00:54:02 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <radheys@xilinx.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sivadur@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 2/2] usb: dwc3: xilinx: Add gpio-reset support
Date:   Wed, 4 May 2022 13:23:09 +0530
Message-ID: <20220504075309.6244-3-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220504075309.6244-1-piyush.mehta@xilinx.com>
References: <20220504075309.6244-1-piyush.mehta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41945fa2-ad94-4331-06f5-08da2da34ab1
X-MS-TrafficTypeDiagnostic: SN6PR02MB4528:EE_
X-Microsoft-Antispam-PRVS: <SN6PR02MB45285B71AD2B7D02CC4D49A5D4C39@SN6PR02MB4528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tTYWvmNtOTc7fI624irmPHSJKbxs39Kjh5F3d1WVdyEnRXtzdYC/9RzxaZR7cJAf4YCMfJpcII/+kdmNG29r6qTUkz6xX5x2Yvf1lvEnNwQRSBTPMB5jaFyR/FLUZpQEgZE1drTefcLD26x+C7tV5b6/FSDkJLxImayfUWfR+34ubCkwBVgCzPAlu3yimz10tzR+M5w9GMgg1DJ0RkCbk2LDsgFl21mMDy9XZ0dLaawEWaIxDkfCcebDWmJo0iKlIeC3YyPNjrNKmWol62heVJixXmvIYSpqBlgpgWQj4ihYl1Hj6dqaq1X53WkcpgMp+eRirjJ0mXvXDt/C5tArFXie3Z6q3Ne7aRI1AJsD2jH+mCG+aNa0ls26RqVK/CI6CityQT6sVpyEuxUw4TRhPJXKCGetCC3zSdjvsloJLZrwvNXL/vAvIBSi+WRFDgDtK7LcCxjngNFDzPH0Cutf0UO4WI+DSFBjBS8DXOgCfWEQOuo6PuL50Fa5S7hfm3faQ7k3VOIJaln0Cu9AZHAJVKYVpPKnqD8OXeaA1MFMtFUH0KKtzjGIw1F36ytCy6CAp+ZUmqTGMmBIFkIt9BNeXBHUBcE/2YhGpwNZcM+I+FBX32/W/oY2qYRdnFjLqXpT57hj7LqryOB/ROswZj47bQqGxLmU4YcPvoVwFFwWn7+RRTaQ9F/N+NQBaeucA4tG0q8cP9SF981auzZBqCx/XJHe3sAwdYfoxz1Vz3XOq6k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(110136005)(44832011)(508600001)(54906003)(5660300002)(83380400001)(36860700001)(82310400005)(70586007)(9786002)(8936002)(2906002)(36756003)(316002)(6636002)(4326008)(8676002)(70206006)(7696005)(107886003)(2616005)(1076003)(186003)(47076005)(426003)(336012)(26005)(40460700003)(356005)(7636003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 07:54:18.1600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41945fa2-ad94-4331-06f5-08da2da34ab1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4528
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a USB GPIO based reset for dwc3-xilinx driver. The PHY
needs to be reset after the completion of phy initialization. As part
of the reset, check for gpio-reset binding before toggling the pin.
This feature is advantageous when the user toggle GPIO to trigger the
ULPI-PHY reset.

Delay of milliseconds is added in between low and high to meet the setup
and hold time requirement of the reset. The reset-gpio error handling is
added for error notification.

Some GPIO controllers must be accessed using message-based buses, like
I2C or SPI, to address this problem, updates GPIO access with sleep API.

This reset is specific to the zynqMp.

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/dwc3/dwc3-xilinx.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index a6f3a9b..67b237c 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -13,6 +13,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>
+#include <linux/of_gpio.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
@@ -98,6 +99,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 {
 	struct device		*dev = priv_data->dev;
 	struct reset_control	*crst, *hibrst, *apbrst;
+	struct gpio_desc	*reset_gpio;
 	struct phy		*usb3_phy;
 	int			ret = 0;
 	u32			reg;
@@ -201,6 +203,21 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 skip_usb3_phy:
+	/* ulpi reset via gpio-modepin or gpio-framework driver */
+	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(reset_gpio)) {
+		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+				     "Failed to request reset GPIO\n");
+	}
+
+	if (reset_gpio) {
+		/* Toggle ulpi to reset the phy. */
+		gpiod_set_value_cansleep(reset_gpio, 1);
+		usleep_range(5000, 10000);
+		gpiod_set_value_cansleep(reset_gpio, 0);
+		usleep_range(5000, 10000);
+	}
+
 	/*
 	 * This routes the USB DMA traffic to go through FPD path instead
 	 * of reaching DDR directly. This traffic routing is needed to
-- 
2.7.4

