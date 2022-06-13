Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1EE549A24
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239552AbiFMRfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242113AbiFMRex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:34:53 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B42629;
        Mon, 13 Jun 2022 05:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1CTk+Ju0NGf5KXtoZtJSnFZm3paKSuvLMk+oIH7xyiOF7Fr9U/c2WRcscBn+BYycLmykAlodECfe/0xfUkEZQILlWt2kLHKSQKwtG9dCC0dFrPscVPGZ44hVRip+08ENz0gL7V4+zwHhZEOD20lNL8WSFoIMH/HiLY3K7fpqFGBMsOM+PBxsaDTmjxfIbdO3dRoUTNIf4YX5bbS73N5VU5mxIADilTeVYiFmZi4EwkRT9Egg4dZwENkIIyJhK0FeFQekM8e20Vu29XBI8jcfGBqoXt43+tzkJs7dgPI/HBXU3A8VDBHN+SEG2yRCCm/HdXHfFgfbYQ95gtKWtfSmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTlqzVvSct2hAKYXLgvPTI5RDN0nVEvfBmEXKI7LaXI=;
 b=RR7k6cCaBYkicHUYGjEEz20HjaEJ6RBtWtw6IsGdliihM4AZZiMEWdhYeK7VApelNs6ZLkmc5npSlneC7v7sGyPGF02EufnutNZU1OJ9D0WqodfvxzirTqMor02xa140e6Yci+07U8wrfi5mtjJ59x2IuJPDzu1ruBBToCSGjYVuKzru2tt/2wWb0up8XI5GKP40uSEeGidslXbO1r0GVc5ySfO19sIfoR60Xkh7NZw6St19rJ+2Whlr6T4BHxGIMMyEgLRrKsnzSxsl6Qz0vBRvp+l2gz7GnIMDsq9v+G/WKUSxvTjnp3JhlfnhjQ01nV62BD1hmOztQ1PEGdrBvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTlqzVvSct2hAKYXLgvPTI5RDN0nVEvfBmEXKI7LaXI=;
 b=ijlSLSwxJCQWqQemiFK8P0ZV4iAA/PP00GBzlpU3+7OhtMImDn34+im5+vSCo5QtdFIeI4j2x0dvVseIQsyAIa7AUsayymeEPwEzcxjAkJJqjF4QrsvFtrqsmm7RCHGhmgLBfkx/O7qT23cCyY4NaoqnJMQ9QoddMusMcihubnk=
Received: from SA9PR13CA0043.namprd13.prod.outlook.com (2603:10b6:806:22::18)
 by BL3PR02MB9036.namprd02.prod.outlook.com (2603:10b6:208:3bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 12:58:53 +0000
Received: from SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:22:cafe::26) by SA9PR13CA0043.outlook.office365.com
 (2603:10b6:806:22::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.5 via Frontend
 Transport; Mon, 13 Jun 2022 12:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0022.mail.protection.outlook.com (10.97.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 12:58:53 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 13 Jun 2022 05:58:52 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 13 Jun 2022 05:58:52 -0700
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
Received: from [10.140.6.39] (port=42756 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o0jed-000DQD-EH; Mon, 13 Jun 2022 05:58:51 -0700
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
Subject: [PATCH V8 2/3] rtc: zynqmp: Updated calibration value
Date:   Mon, 13 Jun 2022 18:28:35 +0530
Message-ID: <20220613125836.523449-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
References: <20220613125836.523449-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8e132a4-3f1e-464c-8f2c-08da4d3c7827
X-MS-TrafficTypeDiagnostic: BL3PR02MB9036:EE_
X-Microsoft-Antispam-PRVS: <BL3PR02MB903680D188AC59AAC4824425AFAB9@BL3PR02MB9036.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejfQlDC8XFf8jl1pWfq9FvWEblfJagod/mdBXoiv1whR1sL3AGfZQioiU3e3Dho6JWn1Q29yZoTAdfOXGmCkjvd1PSVJ0MeZ2JCZ+iAZCuvE5brOfzabohTI3bLUMHM9iS2GYbF1E5tlBiz/eXE5fYAirqHn4Cj7Wh9CuS/Z7nBU2+/NvA8MYBnEHY86tihNJYQ9lAl25nkuevQVfAObuNKqDTDxKn6toD7AeTzB8xPj6wNP7+v4/YVhjnSjPCyrjusC2azJUbqc5nqv258jY+Cu7Za3kHwD3Ct/ZdGbL2Qf06jMZh1UmsZwA2JO6UVY8Gk0fRzvCt64G5uEMFgg5eM0rlx12FKAZQIZUkEMFWljzLay5wEsJ5UxLNrfvuUIOQCxo7Wn9Wt70b7fYHQYMq1f4uwPmIUe/lY71UchdPZW/gLkQlPI8kOVmEa73B5vjW0RyH36YAYt5l3RsNKRd1knamlJPqgkCITuQ83s9F5kmp+Oj3GXE5RK6I0gUJ8P/tOekvIxY3ihMHpv0T4Y4vx4iW6DfAn763osh4fhG9/yrfogAlikOixhVmwkN/jBvmEUi5Ff9J6lHxQp5qqIGP4kixCuFjt5dRgdAajAfstagCGLMDAfC1dIzgGJjIg4OkFpwdk5t5nTj/GjsvdB23sqU078BvWMmS1j2DZhS/guGzHTCFBFNhAxfl24U4qXty3eJyYyQnjlNElTeUx7AiGaMGwjylc9y/geSdGjNvc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(110136005)(82310400005)(54906003)(508600001)(6666004)(4744005)(2906002)(7416002)(15650500001)(44832011)(9786002)(316002)(8936002)(70586007)(5660300002)(8676002)(4326008)(70206006)(7636003)(36756003)(40460700003)(356005)(7696005)(336012)(1076003)(107886003)(426003)(83380400001)(2616005)(47076005)(186003)(36860700001)(26005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 12:58:53.4800
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e132a4-3f1e-464c-8f2c-08da4d3c7827
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0022.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB9036
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
Changes in V8
-None, just swapped 2/3 and 3/3 patches from V7.
Changes in V7:
-New patch
-TRM not updated yet, Internal design document contains 0x7FFF as
 default value. TRM Will update in next release.
---
 drivers/rtc/rtc-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
index f440bb52be92..5da33d760419 100644
--- a/drivers/rtc/rtc-zynqmp.c
+++ b/drivers/rtc/rtc-zynqmp.c
@@ -36,7 +36,7 @@
 #define RTC_OSC_EN		BIT(24)
 #define RTC_BATT_EN		BIT(31)
 
-#define RTC_CALIB_DEF		0x198233
+#define RTC_CALIB_DEF		0x7FFF
 #define RTC_CALIB_MASK		0x1FFFFF
 #define RTC_ALRM_MASK          BIT(1)
 #define RTC_MSEC               1000
-- 
2.25.1

