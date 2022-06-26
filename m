Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFF55AFC7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 09:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234058AbiFZHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 03:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiFZHIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 03:08:55 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23012AFD;
        Sun, 26 Jun 2022 00:08:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ab6lhQzEUXKEQi7c5lBd1uHessbkMQGhX+rRn/dWGaLMvC3BJpM1ytF+QaVDWWghe7yo8cE5gUwgGEWdMDbEuA80t3q7R3qocAZi9gp+RjRV3P8zeQZgKwuss/YPglPuGkc8UoINRxiNDvTf88x6qZPDMxMkzpoma89LmGJjaCHa/Ippah01TUXD0jkcOCzUwnUFw/LiJC7s+rINqMLemB18FDGi44f1lXCZTJHPfgBgl5nZYEQBYkaSJojR7eDalUKkPw0/wFIojSYg6PH3xW6EWJMuHl6/L0EKri8kHvogG68lkNbA0Xdn7hjSlr8jMvvZ5F3clLDtLUgPjlfWug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl1ecw6+6UbFuumzQI8ORtbZHlWhzrFkYIEJsA0E0wY=;
 b=LgLZLdxPdc1mC4vga7fc7kYqEYHrSs5w0H6UXN50Yv8Cn/QULpZOVKlnNfiByH961GYOII6EFUzV8FalK9frvsivbt/720THwIekE2sIQtdJYpONTUSuIan+5hJhdFKGVrK3LAglXLf2u1IgCHF/U+LyZHoAWTGJYZF2yIwrqab4TIK3+4GVBoOGNL9euMYdBHavtdwZApwmkqsfLrSVbUXGdKUHcrw+uZWT376/SqECrSAHyTB9J5E7v0FL1uLrQCf9io3G7I+2hMcdMNjh+eBwfW9rQhBOVZGcnKSvXOBSYSbYqNg4rxKlSrRRKvoIY/qBXGybtgRApIpcVAqOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=towertech.it smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl1ecw6+6UbFuumzQI8ORtbZHlWhzrFkYIEJsA0E0wY=;
 b=NrhqvIto+Ool+GyUcs9b8Z6Cv6DsgAqNAuk5niPJnLz5jORXb78Os9idClcrqq81ZGwvxSeudoevJHeZ0ykQJWb4gXBJkxQJnWNSPHVnc8oOvV+B1YTgDOSF0zPLmM7yMQNRfnRye4sK811dGxP93gzD64Beihy/CVMVb3o+Xl8=
Received: from BN6PR1201CA0014.namprd12.prod.outlook.com
 (2603:10b6:405:4c::24) by MW4PR02MB7236.namprd02.prod.outlook.com
 (2603:10b6:303:72::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Sun, 26 Jun
 2022 07:08:48 +0000
Received: from BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:4c:cafe::27) by BN6PR1201CA0014.outlook.office365.com
 (2603:10b6:405:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Sun, 26 Jun 2022 07:08:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT032.mail.protection.outlook.com (10.13.3.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Sun, 26 Jun 2022 07:08:47 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 26 Jun 2022 00:08:45 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 26 Jun 2022 00:08:45 -0700
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
Received: from [10.140.6.39] (port=59232 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <srinivas.neeli@xilinx.com>)
        id 1o5MNw-00061W-QO; Sun, 26 Jun 2022 00:08:45 -0700
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
Subject: [PATCH V10 2/3] rtc: zynqmp: Updated calibration value
Date:   Sun, 26 Jun 2022 12:38:16 +0530
Message-ID: <20220626070817.3780977-2-srinivas.neeli@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
References: <20220626070817.3780977-1-srinivas.neeli@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5b1f77d-61a5-4d5e-f2a7-08da5742b6d2
X-MS-TrafficTypeDiagnostic: MW4PR02MB7236:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +JDjkXEBxdH1rH3fLoc4iP/lq2CenS9qB6mYiuvM0ns37YymaY3WTKWtLUqPkb/Yd1OkfAP1hjdEhkudfwLDe6yeuPJffm+uaiL1D3Q657CT2uqGZc+fbXKtaIDlzk+sK1nRKrhZ6Tok3WXmw29rsiKV1oevr6+ZTfHID2KYMMT/CW30MMgZ/0UjxpmnAK4iPfRBF31nbu/v5vkN1lz7pnqv6K108ILVZu6V4wXkOecFsufzT0X+qjUFCwM/MaQH1xlvb5DbNsMvuU8VD957kf9McBd5ME55XiwPBuQLlNFhnxd9aHxxnCWLte4yCekRbRJtZ8IH21EihmvsN5VNzCWVVldIsZEruiKGgT6T8J/5CoqhSJJLGBHQNeLUe7VFe9MDyleTUT8F5C+z59MdOzldDlVKLD7neqHPMM5yDMrAClHgJ2acNpFY8b1zxBaeOcNxjBRnjrzaEiVEEqEfK6zIUwsFt+6xDR2g92EMhnF9lbOmz8HZOU3SbwESaCXuLEx2Ul/Ci1+Jh6frQd2UohDdeLrldNqdg7nLMTGQB+nO0aLL/SUVmI3+Vti0Ub6Uv9FvtP9XQLvRuSH/K97j/Tgj6uLBQPO118/HfApXvR9siLHaMpGNMTKl+pTfRybybRmlBrcw1ZR7GGW4ZaOB1wA9Q5JxD73lJ5LjYyCeJRk917JEaeS/rXyf0+C3wzn2FtUdFfQRpgL0aAC6kdYmu9JZTlcLz6CtPsHAOhN1VvAu50px4tjkaSGOXKKaWmUOdOZSOmlJHh3f7CCblrkQzPjEtYkgwvFZTIyVUOnrfCW+PNzU2OjFbzYhTRBIYRVG0ijoTRwAeVRcFCV9yq7HVv06ZNsiH1iYipiApEuv5Po=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(40470700004)(36840700001)(46966006)(6636002)(36756003)(36860700001)(7636003)(356005)(316002)(40460700003)(110136005)(82740400003)(54906003)(2906002)(4744005)(40480700001)(6666004)(26005)(7696005)(1076003)(82310400005)(83380400001)(4326008)(70586007)(8676002)(70206006)(5660300002)(15650500001)(186003)(336012)(2616005)(47076005)(426003)(41300700001)(44832011)(478600001)(7416002)(9786002)(8936002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 07:08:47.1832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5b1f77d-61a5-4d5e-f2a7-08da5742b6d2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7236
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
Changes in V10:
-None
Changes in V9:
-None
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

