Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA344B9937
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiBQG1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:27:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235422AbiBQG1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:27:30 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150135.outbound.protection.outlook.com [40.107.15.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFF1EAC8;
        Wed, 16 Feb 2022 22:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiIwYW6w2/WKfx+u1idxbYbF5pv9/8eK9jZS5Gh0eCEaiPUIbvnQS3ejt7X/vSIg6VFVp9MXSdyfYLllA/x23PFquuTN6SvuT4GWCmDBUAc6QYBQzfZsOMeF3Ffkw+UvsUBF5MGvDiKjXHhu1uNWKOZh+IqZYLvS6T8MP6u8DjvGdL3hcBaZTT5Q8QCQ41AByKLLjkb4spPQ0ZwdAfuGX2Oa61hawjAPJiarSSYR6oljRML5NkP0v1bLUSkSpabuY2zIa6+O+giJ6P1eobjI6AKfVTQPvs5irMMSqhQ0Y0NDWUrYzW7zfHH3CzlCJl175/j+1kQkOVeRk7t9CbuIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwonQa9ulfYbt8Q5CBYWwfj/UMSev+QgAHRfFUt0qJs=;
 b=ZRcnuOU6cN58G2wauZTfBJQjKatwoMWCSkjvg5tplRhC5fV63xxtov4vhYsjWF/8h4kf0zYWb/n+wWvme1hPoYJHvs8tttctC+gfOOy12qAUJPvoLAz31vx0fdQcZAUsRoMcTDeXIyYsRU4MqhVAUlkfEZr1zvhxwXRNCHeDlESM/RXBKCn6MG1OaowAMOPg05wwfeONgpVW6sTa5sWC9WB8Z5PKoAcnc5Ph9hKpwA1JYdqNHmKE1RMPP6swhj0VCO+kfwUc5Lo/8g+kVK0wZHXCRqDkUxmSWPVOOpNz+h/ZWEeEdOuR88LKeeCoXtrVACs5qEez0dFtecmCXFr5eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwonQa9ulfYbt8Q5CBYWwfj/UMSev+QgAHRfFUt0qJs=;
 b=kYL5K2xV7eQQU2bWpA8Ub4brZgzR/LdSzxvC4gB3QevpHzkMNWAu61ck5VGnK2TOIHQJBgMdeIw1lfU7Si/u6Rz4lWYJZgLeZcnA3Uo/Ca5HXeu5oiTYO90527vhxEuUSM502Kxitn/q7Gsdu+So+o+DsF8yX8/+GqVu0y8RbvY=
Received: from AM6P192CA0086.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::27)
 by VI1PR06MB4192.eurprd06.prod.outlook.com (2603:10a6:803:76::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Thu, 17 Feb
 2022 06:27:09 +0000
Received: from AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::d0) by AM6P192CA0086.outlook.office365.com
 (2603:10a6:209:8d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17 via Frontend
 Transport; Thu, 17 Feb 2022 06:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 AM5EUR02FT043.mail.protection.outlook.com (10.152.9.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 06:27:08 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org, bsp-development.geo@leica-geosystems.com
Subject: [PATCH V2 0/5] iio: accel: sca3300: add compitible for scl3300 
Date:   Thu, 17 Feb 2022 06:27:00 +0000
Message-Id: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d4e54cc-6e8e-4ad2-e8db-08d9f1de8665
X-MS-TrafficTypeDiagnostic: VI1PR06MB4192:EE_
X-Microsoft-Antispam-PRVS: <VI1PR06MB41926B1BD17BEAE1DBD26416D7369@VI1PR06MB4192.eurprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZPYpsrtmro7TcrLUsapxEvJApz9r0onF1GGftMUjERZYCmkNq8Nz8lpykA9WiYxGOZLRZ6GsfdGwV5WffXNKM5VHxfiVhPSCmnsqEhetOZ/k5tS25WZUUwnjIyFUag/BYzs5ACZXmtorUEWfJx4pIQ+/CrwgMMomgeGyTrV8bdkx6pz8ffTVMgQi66FKROb7fw7GlngqtIGQJaHAYV9oIoOmXx3UD2mH3Rn+WL/E2/iFB7Al0u79oGvS0PihIa1sk77Vfa7iO3+pA9FST9Ai0TR6DBpaeaiLQNGGQwjjSajSeuF5xOgoYuvueMrlAbYv+tCSy/lGEfnb2NkpfAK8FdL4dZeCenoEHX0xWuUaIlqfRMT+kVioAJjj+rmMOjQHFycfpJ00VkNZQqNoUd2+u12S/iAzefHhjsYIrLnpccvDlHJIcVPBkudEMvTqWr7kQ1KWQg9xg3kbzLd3hDZ+uT5HwXH3wg7whWGGsMPHZ9E7JPDkVEl4OMd0vpVmSZl9qVLj7Q0ilUphqBhwTOG3atP65Y3DFFq5aCpoo9bjyiLbbvgHlviktUFJU3Z56+vr0vRcAHZOqoVuLQuaNhzmdtzb70Zvq6QCQ+mJFt5vMY432cHliCR9j6ta8V+JfLNdWgeXGEdrggvZzuufN3OKcbGR7b5qyhJBk+qlQNwFG97nFsK+JrrpnV29DoviaKT
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(36736006)(2906002)(82310400004)(356005)(2616005)(118246002)(956004)(36756003)(86362001)(8936002)(70586007)(83380400001)(4744005)(5660300002)(107886003)(4743002)(4326008)(6486002)(26005)(336012)(186003)(47076005)(508600001)(316002)(1076003)(8676002)(81166007)(40460700003)(70206006)(6666004)(6512007)(6506007);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 06:27:08.6939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d4e54cc-6e8e-4ad2-e8db-08d9f1de8665
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR02FT043.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB4192
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only.
Modifed for support SCL3300.
Verifed with SCL3300 on IMX8MM.
Splited the change for review.

Same as sca3300, scl3300 have 3-axis acceleration,and temperature.
Different with sca3300, it can output inclination data directly.
The change add the support with scl3300, support inclination data output.

Change in V2:
Drop the extra interface for set/get opration mode.
Drop the interface for enalbe/disable inclination output,
set inclination output is alwasy on.
Fix the findings in V1.

LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels.

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 271 ++++++++++++++----
 2 files changed, 222 insertions(+), 50 deletions(-)

-- 
2.25.1

