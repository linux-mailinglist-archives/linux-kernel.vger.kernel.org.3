Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120AB5AFC52
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIGGZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiIGGZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:25:57 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054F07B7B5;
        Tue,  6 Sep 2022 23:25:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCkj05VlXDKbyuNHVL2U6kEwjy7zXmF1xtT6I5+ih99XlF1OTgErkTBknpvdddmLq+b47B7bBNJFJ8ychbhY/YIvWjOE74R88nDSko5XKCNKPsTbeNpoDQL6LGXs3GTvSpHQ+2DvJwRZH+ofdBp0AbuTQuCfMLHYlICtAPJJQI+BQqRQbBaB4n26h4H0InqXi8OIqo3S8wD0MdOt4/5sLbGcgpqH42QTfQs3XXGT+K2zhLj4jFVa40yfq29ofJhW73Cxa1qsn2gMLTIA5G/V+ydBCb8/twt5QOL8Vhq04Hg+N2V93GTiOJr+81x6/gEeDxN8IK2L+h9OQnbRYHfYIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLklXDKF+k8D1FSWSemc0oAXuZTCMNQl3LhTOSx1YOw=;
 b=C7xUh8CfmdmEpbiNr9E3XKRdiQiKkbRjJREDZ7UoqxPsPJwu4rllrmiLC939hyz75a+kzE1KJaeo+Jb+hbCoZ+G6CELdOriM/1A28giQaSOU/l35jZ7NpPZKWIQk5oKkGvpJntDKruJxyu8Tw051Ro1GZgcvqU6THlun0rs6fojB5+lPZSjFvruS4R/SJiy/lqzHzpJWc9h6fPzWr+MneLNrGgSNy/r793eych5uSV6quSKUQX3QJE+xXiEblHWGlKrW/mV9QhMbf6GeZ4Gp6Zg3jAM9mWcJxO84cejix/+78y3AVQQVAEi0pTzW4dBSTXzX2d2+Rc1/NDBKu7AM2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LLklXDKF+k8D1FSWSemc0oAXuZTCMNQl3LhTOSx1YOw=;
 b=tGLuR0M7aY/a1kd52h1R/16nghLIELSdYWNbj6vKftVpveSgfXnGinOQaQVhLVGODb7FaD9/yMHPBJCoqYsYPjGZDUsmxjsJPX8EA/lwIr/T5fKESlOhe+dQ8xVWKsAKZwr1NvxqAj1vop1olVsc68a5TtnOB1+J0Clb4clOeW3u1Lq9WC8erbm7p7vAUzrK3bJzDnVUv75fIicT0SvSwyuTCXT92k+l2b85NREXopbV3ZHasM9YpOSZ568eCvIP1/vqq1wmST1CTAMHZ8Lg5wGB1sWIKCaSOeWLxKG+DJQNC3jIP9U4EWOEQQSkK9TbFggdoWpOcYRBOMs3Of7xFg==
Received: from MW4PR03CA0344.namprd03.prod.outlook.com (2603:10b6:303:dc::19)
 by DM4PR12MB7525.namprd12.prod.outlook.com (2603:10b6:8:113::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Wed, 7 Sep
 2022 06:25:51 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::e8) by MW4PR03CA0344.outlook.office365.com
 (2603:10b6:303:dc::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Wed, 7 Sep 2022 06:25:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5612.13 via Frontend Transport; Wed, 7 Sep 2022 06:25:51 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Wed, 7 Sep 2022 06:25:50 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 6 Sep 2022 23:25:50 -0700
Received: from sandipan-pc.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 6 Sep 2022 23:25:47 -0700
From:   Sandipan Patra <spatra@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <kyarlagadda@nvidia.com>,
        Sandipan Patra <spatra@nvidia.com>
Subject: [PATCH 1/3] dt-bindings: pwm: tegra: Add compatible string for Tegra234
Date:   Wed, 7 Sep 2022 11:55:43 +0530
Message-ID: <20220907062545.30203-1-spatra@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|DM4PR12MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e53c49e-2f08-4467-21b5-08da9099cfb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2jq+SJO/ntYqTG8+cwVCQeZ4q11PFjbb+55mrcdhPieB3usWknKkpT/QO/90goon0iHr0WGq9oMgZbREXFE4rAN0OLe7tMpTaSmo32/QT0YVgK1GRO3EE84bcJtKw573k+a/vnfqRuVer+Tayr+o5qYA4BsyP7Sq7C9FqeH81zZ5DxRauPcicLsrwHg2qi8WT3MS915AV+o1vUuj58kIFMP3pnGoxzfhcEGlBNYjcxcK/cGjNd+yBs59uRSiMUh4PEp2BTwohkZ7CAjxH5EsVJ1KbiHxyW8xsB55kSzZHk8gxuK704Bi07rzhzM8tfOhQdz/xlsInuBQaGJ4crOg/RtVED9AbNAnqoq4TYRCZ5r63BSGe6ZLpYGPqOY7h5c3/IzBAiqjvIJYcGLUwxykfooulag1f2EtrNYDR4gb4+BuCGynm6K8XX0poczn3qUAZhUL5Q1ReEr0A7lxWAac9w+OPOkm9QKPO0ijUHTDydNVVeHi1DhgCGjb24wXcxIJ9drMEH444bSD7Wk8NBC9ynWXBVJd+wlIIv3WO54A3S/Ybbx6ENVBGqOwEaAbcCKZ29Wpv4R8M1OZk//RNZ2hPZwYm/E7TPlWQ+kv7Ot0dpWpIAjo/p3KLAAp2WZ6+IQo7zgJkoOSWUHxxj4T4J4h/1CfWB5Ww4t1cqZnv6L0bO8pbOjbHqi4ONOcH5ivbJluO2WBhCmZ65Q+6bD1w2NBmSZrQOFHTkGShmQf6y9C7ce1KY6KutGds2rbr1RQQ76cRAZHEnuujg7ClBhg08jnD2B/iX1ksdBBsOIB50oyj5Ycrpb4+caxbVrFXuLWt/2DA+TXBbM47uEg6V2eXHKyxg==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(46966006)(40470700004)(36840700001)(6666004)(41300700001)(107886003)(7696005)(86362001)(26005)(82310400005)(356005)(81166007)(40480700001)(36860700001)(478600001)(336012)(186003)(40460700003)(4326008)(2616005)(83380400001)(47076005)(82740400003)(426003)(36756003)(8676002)(2906002)(110136005)(316002)(1076003)(70586007)(8936002)(54906003)(70206006)(5660300002)(36900700001)(16060500005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2022 06:25:51.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e53c49e-2f08-4467-21b5-08da9099cfb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7525
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra234 has 8 different PWM controllers and each controller has only
one output. Add a device tree compatible string for Tegra234.

Signed-off-by: Sandipan Patra <spatra@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
index 74c41e34c3b6..331c1e66e8fa 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.txt
@@ -9,7 +9,7 @@ Required properties:
   - "nvidia,tegra132-pwm", "nvidia,tegra20-pwm": for Tegra132
   - "nvidia,tegra210-pwm", "nvidia,tegra20-pwm": for Tegra210
   - "nvidia,tegra186-pwm": for Tegra186
-  - "nvidia,tegra194-pwm": for Tegra194
+  - "nvidia,tegra194-pwm": for Tegra194, Tegra234
 - reg: physical base address and length of the controller's registers
 - #pwm-cells: should be 2. See pwm.yaml in this directory for a description of
   the cells format.
-- 
2.17.1

