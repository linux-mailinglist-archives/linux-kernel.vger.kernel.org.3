Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2C54F5EA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382155AbiFQKsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380514AbiFQKsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:48:02 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24F6A64BDE;
        Fri, 17 Jun 2022 03:48:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiac8m0crUL5yIa+oAPe4V3oRr3NRBWUhc4hHy+GxKdlWgVuaJIjl7MfWwAn6C7ku8ORqKDF7CXO5q/OpjQU0j9fJ7Y7h2o54QZqwIZ1fkIiFL7isJg5aXC2ioXmOOydabYhEkrnteYA9MH/RdAHSa+qiPEQc+0W/S5h63d8bhtIrFbD+8t6RRVOC+QTe64Y83SzvomhKQwOykXpTy9MgFDqDx5uOc/GRvCaP32fvcE/yr1SW1IlH6fJkv5eo6xJkZJXfARd5Kk+KU+BlI+gCCs43xK4ey4QR5pRD3M45jjCDxmV7G0c9oNqG4C/MA1iAHXky6vbAVPEbfzP5i7O5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Sr14pksdLyrxxdBOMtkBYHPvMFWVgs/WfZnfF/+pM=;
 b=deegUGb8M2QspFI1YWCIX+r1vh4eStnwt7VsGXeYgYI/vjhDnp4zKgjMKvnzbSkuT0Q11lxzVwepyiP++wHvVRVgsGmTbXys8X9dH0IqcJR/x7/Q1VbB/aDYKXzSKAHPwoxFNG+WFZ44oMLvpGagq12QEnKWMap2NiZyCHC8nQPYaxW404Zv0VearwgkTVunu7Bs7aXgPmRRt+eR4Rzwy/HTIw9GxdPo/Abx68bk9s/Ij25voUEfjoH3M4C8wADwntz0/j7tEgAVuuIoMN3aIMgSM1Uj+LCa1ET4OcGrUTm7UVWZi6c3t0oCcwhxvLaxraLZdDOvPqsfwHwbQZPq5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Sr14pksdLyrxxdBOMtkBYHPvMFWVgs/WfZnfF/+pM=;
 b=aBAG9owIyaMPgvCIMiNHsaZjfOyAWVpc1SIOYbwYRPGjuKbO6ah4hu6NM6666cxrGrcwyvfnNKVhfoYHyjsH1YETcTk9y3ktspvtdeO459bJGfxgkezTL2T3iU9QqjN30R1HzsrJuIQ3wWHeNB72IVeYVTtWv1H7eXaSof20zaQ=
Received: from DM5PR04CA0031.namprd04.prod.outlook.com (2603:10b6:3:12b::17)
 by BYAPR02MB4981.namprd02.prod.outlook.com (2603:10b6:a03:71::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 10:47:56 +0000
Received: from DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::28) by DM5PR04CA0031.outlook.office365.com
 (2603:10b6:3:12b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14 via Frontend
 Transport; Fri, 17 Jun 2022 10:47:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com; pr=C
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT020.mail.protection.outlook.com (10.13.4.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5353.14 via Frontend Transport; Fri, 17 Jun 2022 10:47:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Jun 2022 03:47:54 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Jun 2022 03:47:54 -0700
Envelope-to: git@xilinx.com,
 saikrishna12468@gmail.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linus.walleij@linaro.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.23.64.1] (port=60019 helo=xhdvnc101.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lakshmi.sai.krishna.potthuri@xilinx.com>)
        id 1o29W6-000B0E-6x; Fri, 17 Jun 2022 03:47:54 -0700
Received: by xhdvnc101.xilinx.com (Postfix, from userid 14964)
        id B974621637; Fri, 17 Jun 2022 16:17:08 +0530 (IST)
From:   Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <git@xilinx.com>,
        <saikrishna12468@gmail.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
Subject: [PATCH 3/4] pinctrl: pinctrl-zynqmp: Add support for output-enable and bias-high-impedance
Date:   Fri, 17 Jun 2022 16:16:58 +0530
Message-ID: <1655462819-28801-4-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
References: <1655462819-28801-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1babcc64-0787-41ca-b0e3-08da504ed6d0
X-MS-TrafficTypeDiagnostic: BYAPR02MB4981:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB4981C5701D1E4B0230CB4F91BDAF9@BYAPR02MB4981.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0XvK+oYiOSW0ooR8hD9zhQntL4WLqoFSsdQhpmQRE5pg+pdLWy9C9Sv79tbDv/IBqNN58vitmnPJg+lssnKJ96i2YWpQhxU+huyvPWDKj4d7dn7a64JWCxshvuiEuCJy+SdvHR5e4LLa38YmUKB/KsuMGxmKHUBoj1qV//WEoweErVf+w2CgtCGoU9p0BAZkX6hzihrlzrE/CD74ukcA7ZmwkUOi1YkUg2UDBD1XK6fh18rZlM3IMWwLJoH0fe9Qr9iB48ugOUKTaYLC/WGd0AMGz0Ycwqt32qd78YTN8kyqcv1LE9jkvtR2WCXNfv4EDHNb9lXYv4i+i5nce7OmjNWMsz5HiSBPBJPf7VegdU2+7d/iQtyh27thr9nguJ5phuLQcDjRl86sImqJxQFtMnmsIlmuNzeGXZcvUTSgp5D2Lz+6GsxuJ+6ZDiKtg/U4WRPFIJqTgLWrMOUzN+K/biGevVxrzc37yuaX4yYjNtR3YtNzXtVdNougwKh8clPrUOLOiKwaAzCjlZRMhlk8vOgBgdO5Rh0LW9YXBLUWH9FtymG00MIr7sY2oUoEIkBz7k06qVhR0knBOirCCqZbL0ie3gP2JaZ2ZwRyTLXqy+1wzp7PL+EzDr8cGjOt2MacR5LoaWZyq+JD+v8IE0xaqz8ZS6KYlijfxqDhz8ViDxachoD31zuTqTnJYh54TrsXOjZ928FC8CFcdH71sNMXlg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(426003)(40460700003)(6666004)(42186006)(36756003)(316002)(82310400005)(5660300002)(107886003)(8936002)(356005)(8676002)(110136005)(336012)(2906002)(47076005)(508600001)(54906003)(26005)(36860700001)(2616005)(7636003)(70586007)(4326008)(186003)(6266002)(70206006)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 10:47:56.7081
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1babcc64-0787-41ca-b0e3-08da504ed6d0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT020.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4981
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to handle 'output-enable' and 'bias-high-impedance'
configurations. As part of the output-enable configuration, ZynqMP pinctrl
driver takes care of removing the pins from tri-state.

Signed-off-by: Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>
---
 drivers/pinctrl/pinctrl-zynqmp.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pinctrl/pinctrl-zynqmp.c b/drivers/pinctrl/pinctrl-zynqmp.c
index e14012209992..b25e9e76fbf8 100644
--- a/drivers/pinctrl/pinctrl-zynqmp.c
+++ b/drivers/pinctrl/pinctrl-zynqmp.c
@@ -410,6 +410,10 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 
 			break;
 		case PIN_CONFIG_BIAS_HIGH_IMPEDANCE:
+			param = PM_PINCTRL_CONFIG_TRI_STATE;
+			arg = PM_PINCTRL_TRI_STATE_ENABLE;
+			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
+			break;
 		case PIN_CONFIG_MODE_LOW_POWER:
 			/*
 			 * These cases are mentioned in dts but configurable
@@ -418,6 +422,11 @@ static int zynqmp_pinconf_cfg_set(struct pinctrl_dev *pctldev,
 			 */
 			ret = 0;
 			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			param = PM_PINCTRL_CONFIG_TRI_STATE;
+			arg = PM_PINCTRL_TRI_STATE_DISABLE;
+			ret = zynqmp_pm_pinctrl_set_config(pin, param, arg);
+			break;
 		default:
 			dev_warn(pctldev->dev,
 				 "unsupported configuration parameter '%u'\n",
-- 
2.17.1

