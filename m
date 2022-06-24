Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60A3E559912
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFXMCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:02:29 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5727E029;
        Fri, 24 Jun 2022 05:02:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODbcioiebyEn+GMyFpapdEyy6DllJQN0JOY0TUPZXWm60QWcmg4IrbXYH4Rf2qjCVFUd9yHfQEIoEjtds6OV4NmouhCsUgwOZKheVtsX6pihX84/DuAkO6YeXxi5Op9l6zysv0UqJ68TMCYweetrAFnjwlq/beZLu9eyr2P3ZewXY+8cN+MiwnQq/mHrPCLJOVGKe2PnjpRINzOMI/Pu74o0dZ9ZevPXlGvox1TzGiNQG8qQBDU/ZeYtUDRF4QvuNTTJ/cELBxg+YDYvkyEVUkDSjrF+D6WizZqOuBo5wb9XFtIR4pLeOecbHPTQVDqnGBZVlx0N7o+UKshnRTPa5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNZTBIlAlxyvmLWOk8lZ1AWMoKlmlvRx+3WHKUZu0Vg=;
 b=jp0sypzJCDyxu3AtjWPFEpAeoMXyXlq5zBr4bOHb/xGauPKRIhkIIQul7fySPW0Lpuw/QqzeDsZEMUoGwEMTQvk97FVhW0PCxeCy/KUNGLkRhX3XIbjq3RtR/t9EOGXApu37tfdBiyzGqTFad/eT7M/KnLw3XvixyeHrP0PEOBktxJlpSQg5SR7LC49P1BQzKhb5PHanuo5yOlFMFHB5iExY4/ZF63Uts7FsHQWc3B95iiPnbtPKF5CHYZ7SAR6Mfebgn/dCZLea9Az3/sHOx2kpLOCBm3+Kht7C7Va9SKE9m/eycxtHoO7rujkS6NQMp6V6ya2oB1UV9POuZ1uCPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNZTBIlAlxyvmLWOk8lZ1AWMoKlmlvRx+3WHKUZu0Vg=;
 b=KoIXvGHEKEkY8dyK9EMfsDIAvs6dQtPTYl++ECo9l0RT6nkg9IpacDP71gpPIMVAftJqxAsemgIAOszOkMBs4zVsvyA71bznfkjMXJbfUhVXYgpM3zK1eXjLN6tegzBzcu7TwbjoN+uiwZyQpCag9zqn34ibSqNZsxH/XJ+yFJc=
Received: from SA0PR11CA0005.namprd11.prod.outlook.com (2603:10b6:806:d3::10)
 by CH0PR02MB8211.namprd02.prod.outlook.com (2603:10b6:610:ea::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 12:02:26 +0000
Received: from SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::f) by SA0PR11CA0005.outlook.office365.com
 (2603:10b6:806:d3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Fri, 24 Jun 2022 12:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0060.mail.protection.outlook.com (10.97.4.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Fri, 24 Jun 2022 12:02:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Jun 2022 05:02:16 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Jun 2022 05:02:16 -0700
Envelope-to: git@xilinx.com,
 a.zummo@towertech.it,
 alexandre.belloni@bootlin.com,
 robh+dt@kernel.org,
 srinivas.neeli@amd.com,
 neelisrinivas18@gmail.com,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 git@amd.com,
 peter@korsgaard.com
Received: from [10.140.6.39] (port=57958 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o4i0t-0009E0-Mo; Fri, 24 Jun 2022 05:02:16 -0700
From:   Srinivas Neeli <srinivas.neeli@xilinx.com>
To:     <a.zummo@towertech.it>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <srinivas.neeli@amd.com>,
        <neelisrinivas18@gmail.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <michal.simek@xilinx.com>, <sgoud@xilinx.com>,
        <shubhraj@xilinx.com>
CC:     <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@amd.com>, <git@xilinx.com>,
        Srinivas Neeli <srinivas.neeli@xilinx.com>,
        Peter Korsgaard <peter@korsgaard.com>
Subject: [PATCH V9 2/3] rtc: zynqmp: Updated calibration value
Date:   Fri, 24 Jun 2022 17:32:02 +0530
Message-ID: <20220624120203.2817457-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
References: <20220624120203.2817457-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339c6eb6-6c37-461c-c14c-08da55d967ad
X-MS-TrafficTypeDiagnostic: CH0PR02MB8211:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T8TKQ78M8BEk4GgG6qmxy1Lt93haLIa5FGBFCqhV35vnutn4CP7F742wAPqwpXXg0DPKbtZfFNDVtudVMDZIQaqIBmXqaz8lAshftf2FILLyhd7DH0J7KwGblR1IkdAkh6YpqCjFdLG9/cZFkV4gOb7jSTpbxlhLGfr7RX7zl/FRb7UNJ2sI/9FL0XFVdHQY71pVIBXPwHhHabXKezuFLAl6AJZ5N6SxWTeBh5oibh+mcCXES4WhpgWvssckRSTzV7uKa5RGZX030P5MmraEJWW2fot8aBDYZ/OTbxcaJNwdfr9XzR1s0gaqOHJSbz3u/ZKskzcVDGlQTYnSp+NMGex/pu9x19Ny3QU6vKuLrZWqIpf83yp/T6rsNa/42rOBi/+QnPciRfy/sE0nOozNLNn0ikgDruA9fhEPJHrCxvqBHXvUXiltZ/6zGPlpIrrhfp8xq32kjsvzWgYlzvO+WHTguQuXeaWhBNd1QuL+AuudyBPjiY8SskVzjrpucHEqwJvMd57hA3LrOig4NlzD8SE2Wt1PM58yzOEVbf6qEYEvfZQeF29L5fkrJH2OVyF22Jsg/cikW/KmvCva0xkU6jdUUabjRpU3rNYB8fmat4+wiP5V6bL7bV+mIfNre3/mP1dPVNfJ0RzEW2d4UpFFDq1nLWdT3ehvxVJXk2b2Rr7mp9KHVUByrUbqNZNjUqqj96t7DnBvHIfYijDroDsBpdo69q5W5h5fKaWE9otVb+skaNIVJsSyhBf9Aur8AxMI23dznXpm4L2sXq6L7Xl8GsX2TVft4k4PM4aKwh/xacOzrkj1SU9cAJ3KcaiQTVFYmOMRrqapyYoYx/CN2OqmPWkon/YoNGTo7GDSikwk6eM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(40470700004)(46966006)(36840700001)(40460700003)(36860700001)(82740400003)(7636003)(8676002)(356005)(4326008)(6636002)(316002)(54906003)(110136005)(40480700001)(336012)(186003)(70586007)(2906002)(7416002)(8936002)(47076005)(15650500001)(70206006)(44832011)(5660300002)(4744005)(2616005)(1076003)(426003)(9786002)(83380400001)(82310400005)(478600001)(6666004)(41300700001)(26005)(36756003)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 12:02:26.1113
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 339c6eb6-6c37-461c-c14c-08da55d967ad
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8211
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per RTC spec default calibration value is 0x7FFF.
We are in process to update the 0x7FFF as default value in
the next version of TRM.

Signed-off-by: Srinivas Neeli <srinivas.neeli@xilinx.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
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

