Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8FD5465E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349405AbiFJLis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346859AbiFJLiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:38:15 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48487CDCB;
        Fri, 10 Jun 2022 04:37:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UvbBxp3EdLqYRcAzsf6f+ljkavgiVQzYKpCBguTbpx9jGG4h93V3M6vFYfKpmQ5eouWo3ope4kZ79Dfkcnb9EZP0gahCrSMOpYoyIKvxt5q1g8bIOi2RJRasl00pVsbJVD68pY+WV20TPnz+Xzplt4SirjYpI6y02w1KuxK9QI1EZQmx8NNdVBr1/9ZUmocW8j2JRNCrdZmMzzNtGtdlpU0Jrbx1xt4bYOo1yqeiv27byICf1htNtpAQDVhWIizWMfIrZz3z1DOW1BXlmB5tj63obgAXKlzsnjuu4Fk08GUjSV0fpShbfbcjK5KWPkahLcAxT+A4Q6Fhvtfhl9V3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BilvxH1CXwSb6NBAg9shBOxM3x5GNuQ86//VEdBMkWE=;
 b=lD3M6vwDffoYKbTXrBAohTdT+0xzymUhVmwhMgA71UWwk53SNTrFrSQE+z2IQYllSryM/A4+jROfq/MitLdODXw20WCTSP1MCYGQbIa/udWcb5E2cEaXqQFv8pCR/BPM8DTk7kF0D/xnbOGLlmDN3keDHG6zBOjrkqK3Y+Nb3oxMgRCGE4EJwBaW8zxUMIJ0sv6XPc8OpnUnKTxvgYzK+9pbUu/HBza3cVa/OG1M0MbiFDv7Y/kWYmX3IWuRf/8BEp8/BUZCJp5k6MBzo2RbVTMpJn8OYNw2Jb9MecOnygBiZdi5Z9RjB3C7t22uUUXc91yQyJwW+h5t9c1G+HaSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BilvxH1CXwSb6NBAg9shBOxM3x5GNuQ86//VEdBMkWE=;
 b=FdJ0CfaZAleN3/btGjBFs+G5rAza7lRj1XXNRp0TNieQK36vQsQ+kdTcEynwF6Ds0FvxNhQ9hxgz8hB9Yk8Y4orcgJwUrCXxZdzmrUEbmzQrd9qjwlpux5UimP28OsN7VxntdP6t9xNGxj7yEkJ4EBYNiVVOaej3Uamwl7v+4Og=
Received: from SN2PR01CA0037.prod.exchangelabs.com (2603:10b6:804:2::47) by
 BL0PR02MB5634.namprd02.prod.outlook.com (2603:10b6:208:85::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12; Fri, 10 Jun 2022 11:37:36 +0000
Received: from SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
 (2603:10b6:804:2:cafe::81) by SN2PR01CA0037.outlook.office365.com
 (2603:10b6:804:2::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 11:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0048.mail.protection.outlook.com (10.97.4.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 11:37:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 10 Jun 2022 04:37:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 10 Jun 2022 04:37:34 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=39538 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1nzcxE-0002aq-D3; Fri, 10 Jun 2022 04:37:34 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>
Subject: [PATCH V7 3/3] rtc: zynqmp: Updated calibration value
Date:   Fri, 10 Jun 2022 17:07:09 +0530
Message-ID: <20220610113709.2646118-3-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
References: <20220610113709.2646118-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41483507-179f-4741-ac3b-08da4ad59db5
X-MS-TrafficTypeDiagnostic: BL0PR02MB5634:EE_
X-Microsoft-Antispam-PRVS: <BL0PR02MB56345794731CB95396F2A61BAFA69@BL0PR02MB5634.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PVCoVYM9hwpt8LPkQIoSwDh3rWABpx+jghkoKIftLMFw3T1bWOOd4YNHkaMlxFbt308Leh/UPWzlYRaNgLJRFThTWFZH9LmYApHwtsc5DhiUo/zhf2Rk37HUWwYDsoKYTSiNcNtgUGhmyaI6ef3pdPYZ6MDgI4+fYqI3urxvSJwNIo1/dAzWE7pzZ302Ht6ISC7rFhuOnoH20tRdd3BOUPGshJJe/SK7O1O6ffqWoHlQfRSEjk6XXpovVk+Z+rcdQl41ZiNP1qfsgtOwL4ZHmo/FnbKWzt54XCIjhrp1uD9myro2rVbHQ/47rI4C0vrv44rTsdE6IUsXj2oI/PPX+Gw3PrngzU46jafNh/WksxcFGgLA0cNQwye8QIu05R8aupc8GHVsTt7iArecQ37YtQGem8SroJqz6x8FKyhF+fx/Av3ToMXpFtDU53WvFGOOXDXQXAf8CA1LENifyEKZi3+n+atpFyzLWB3qAVswDF0w7WQec0SbrjO7aAPgHZ7pU7/ndeWI5cyRoJy9THLp2oAd9j5+fHTz+udYoCSVEhNJFXULno03sSdBR2nSnEMuP/80kVYEnaMBzwUbX8DBIuIukAs1yCTcdds5YSzlvMZaIOWwOSDdeJYtYOCI+rT+y33gSq7osOucR0UeVlMQoC9EI2OpGcrLaTmUlnDQ9u+nnA3Lw2yyRbgzh29cRr3JqBWjIAeE+4YhuJIYalm39N//JxQd/5/kJ1hNKBKldjI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(40460700003)(26005)(54906003)(110136005)(6666004)(83380400001)(316002)(70586007)(70206006)(7696005)(2616005)(336012)(426003)(186003)(107886003)(1076003)(508600001)(47076005)(82310400005)(8676002)(4326008)(8936002)(2906002)(9786002)(36756003)(36860700001)(5660300002)(356005)(7416002)(44832011)(4744005)(7636003)(15650500001)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 11:37:35.9983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41483507-179f-4741-ac3b-08da4ad59db5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0048.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5634
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per RTC spec default calibration value is 0x7FFF.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
---
Changes in V7:
-New patch
-TRM not updated yet, Internal design document contains 0x7FFF as
 default value. TRM Will update in next release.
---
 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index 39b23f88ee26..1dd389b891fe 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -37,7 +37,7 @@
 #define RTC_OSC_EN		BIT(24)
 #define RTC_BATT_EN		BIT(31)
 
-#define RTC_CALIB_DEF		0x198233
+#define RTC_CALIB_DEF		0x7FFF
 #define RTC_CALIB_MASK		0x1FFFFF
 #define RTC_ALRM_MASK          BIT(1)
 #define RTC_MSEC               1000
-- 
2.25.1

