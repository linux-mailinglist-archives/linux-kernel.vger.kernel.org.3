Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A394FB8F8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbiDKKHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345059AbiDKKHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:07:19 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e88::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BAA11162;
        Mon, 11 Apr 2022 03:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPAJrQBvuOO62zFTRYs69EOyT5yPNn/P1FIYZUMO6DT4BvpduKKjOouXYQ2Xn++px4JxcyVQO9gC8cex0RqjrsQpiib8sihHZnLl4mVjA5jDs352e2jRkU0jwI+E4NXxMbHFWoGK4jwOHmtmLFxFHi56bmlpUO3oRl1C3ycc5UqG7VD8/tjukZ+JaqsdteU9/bPp8cKZaPiJVnqEGEhI+S8Tzqo86wdhss+AUezU61eUvJEYsMvYuNu5axJxkJ1T1TjFEAEMtdLRubAaAol35QdoWE9BAeeR7PP9qz1q2Zu27i9LIFWPD2lxQqkUnzNhQgv2XKr7N/QOKDkUCrYYEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSUZLPVJwEa1ckpu00lCKIxlWqQv0Jh1Y3UOXdBimNE=;
 b=kEBG6SY+3ACfRAhdPIjc36mhZ0zWbjzBy9ZWSSrJMgJkDynB4gdo/DlTZKMVLX74XZBBhNxHrttncJtJSMNEoetWjhGfsgpA4mWIo2t5iELpb6sq8YoBH1hIuNxYOSzOPI0mcXHPeDF5EotU7Fx9whoF70tmi/EGrpvkvFx+zeJjyRQs06HBnQhi/prusIaSlNopYk20HkGnWWjmvjHcU/j1Zpe+05wO7upxFk73e7Q6mo0xI+hirXru14+6xfbCSYBkWjCvA6fg5M13QEW27HYOu75eRa0UAM2z9z+L71cxsKhnWyekErtpzsnupHlMDC8U3uIduQRkTtB2cKQbPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSUZLPVJwEa1ckpu00lCKIxlWqQv0Jh1Y3UOXdBimNE=;
 b=Gpvnh4J6WhP9m0/ysGKVQRh7JvOMoaGEk4RgfI+UWOo2XEpCDrQcaG9GcyqB5ea3XZQyZqQSiCuhtirIWsDvQGRvRtnXA/CANzdL+/Bk8ewrghDq3Son3i3iUFC+RHL2kKFoLLthjUakFI2xPJjft2UWM7rLrY3yOn9/julCtfg=
Received: from BN9PR03CA0543.namprd03.prod.outlook.com (2603:10b6:408:138::8)
 by BY5PR02MB6755.namprd02.prod.outlook.com (2603:10b6:a03:205::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 10:04:56 +0000
Received: from BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::38) by BN9PR03CA0543.outlook.office365.com
 (2603:10b6:408:138::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 10:04:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT008.mail.protection.outlook.com (10.13.2.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.21 via Frontend Transport; Mon, 11 Apr 2022 10:04:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 11 Apr 2022 03:04:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 11 Apr 2022 03:04:55 -0700
Envelope-to: linux-clk@vger.kernel.org,
 robh+dt@kernel.org,
 gregkh@linuxfoundation.org,
 sboyd@kernel.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.59] (port=36530 helo=xhdshubhraj40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1ndquk-0003Jf-Uk; Mon, 11 Apr 2022 03:04:55 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-clk@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <gregkh@linuxfoundation.org>,
        <sboyd@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH v14 3/5] clk: clocking-wizard: Rename nr-outputs to xlnx,nr-outputs
Date:   Mon, 11 Apr 2022 15:34:41 +0530
Message-ID: <20220411100443.15132-4-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dcc176df-b8d0-40a3-6851-08da1ba2bb11
X-MS-TrafficTypeDiagnostic: BY5PR02MB6755:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB6755CED9A982718E80105B6EAAEA9@BY5PR02MB6755.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnBeajwKUFoLEwLTonTFkhf7M4dPbk4EtESc57JeFIdshvReUyAa7gQKOFjiJV14h91oI3eXvDi/6ibsljT2bGOkIwfd05YCx9LqDnj7NvALUPhI5nqoeLcnUw+mR0knLKvdb5AqAtnnx53W40UrqWTUI+rWlOKLCZ7DO9RycOE+N0NXo8UGcIJBOEQQOAEtUnQDkpaDmFEScG/hNPKKVpjOnvJPrziWj8kvhSZQGC51zIVLuoKlAkRrc7miwSuRMYFZyqVUKQbyDla9V+mrMkdEVtZcVSsMkZb9W4m+ardz5muwM3SsWJB5NKamzzCQSdShaZfVt4RPPR7KFgK9J7K177Z9zPzfbkaXw0P1Ggwc/VGLTFtK4OLncckzOsSB7F2wQcp4xJXVxYFKxucPLDUuwzrdFdXSUO3morWXnMtV0vJFsPi/qLIxbO37XIaD0I4rRrEtf2ZeAWq7cY3lhUiuf+6XUc1Yh3lQkxGmjBiXibMJgfaxXfRrz+uyE/Uw0Ma9UmK1Kz3Ury5ZFpUgzXeKUxizM/olI8gf+zOXmuGTYXW85h3NQdNoMB2YwTHfIFe1z5YiI4MhZCPnNE6reosGASPnn0vjD3A5gbV4R/ntANkKqYCzF0BIDPd5eq3s1c166xinQp52+g2y44dqytamsS+iO4yTzS3o++byeyVsNP66tZkWMfFpv1jHf4pD/3GJiG4f/OyVAPTkt5fB6g==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(26005)(186003)(7696005)(6666004)(356005)(316002)(7636003)(426003)(70206006)(70586007)(107886003)(4326008)(2616005)(336012)(6916009)(36860700001)(5660300002)(9786002)(83380400001)(44832011)(8676002)(4744005)(1076003)(36756003)(2906002)(47076005)(8936002)(40460700003)(508600001)(54906003)(82310400005)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 10:04:56.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc176df-b8d0-40a3-6851-08da1ba2bb11
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6755
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename nr-outputs to xlnx,output.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/clk/xilinx/clk-xlnx-clock-wizard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
index ec377f0d569b..1e0818eb0435 100644
--- a/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
+++ b/drivers/clk/xilinx/clk-xlnx-clock-wizard.c
@@ -480,7 +480,7 @@ static int clk_wzrd_probe(struct platform_device *pdev)
 		goto err_disable_clk;
 	}
 
-	ret = of_property_read_u32(np, "nr-outputs", &nr_outputs);
+	ret = of_property_read_u32(np, "xlnx,nr-outputs", &nr_outputs);
 	if (ret || nr_outputs > WZRD_NUM_OUTPUTS) {
 		ret = -EINVAL;
 		goto err_disable_clk;
-- 
2.17.1

