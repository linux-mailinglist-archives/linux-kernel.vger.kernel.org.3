Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1E44C009C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiBVR5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiBVR5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:57:11 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673BF92D10;
        Tue, 22 Feb 2022 09:56:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcPdoDYqqS3/jUk2Nc9pVX5PZX6V/6SjTNX8p77SrCjru27TwOGNr6jqo039+S9roV+3l1QuVsra3D3tZvyxdubQYuGHkuLB2uy8kx6nNoUFRPeYcl+7wONk50qHDc+5artVT+WwbRgETg1UaZf6sdNfuUJIVZstPP4rbgtN0DvJiIwflIVMOA2xg7Di7RGiEQ4llxH1WfC13nFe0tiDcerSgsIv7n9ttJErhh3VhErGwQGGMJcOU/jsZxc91Mefmvq2Hn1/0dafpKSChzzB2hK9/K1oSlMTrVOLyOu17d2unJd7XNnKYkUlKHbIXH1q4CLFizsAi3JR+6wXaVEslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZfm37I/Zq5TW2O3iXn7qEteyn09glQiAw2hLK4y9jE=;
 b=H5qbPJwLu/JPEH1l8e/9iFk1SNZpHeMGyEsquuzfGev9yehjmIhrcJKFY+aQvxvmlbXaNsBy4rvENcWJfWMMef7HDYh3Yp3P40k8cDY4o890hc3lASs5tgLCRbgZWdkVWguR+hdvhQDG3xCJDHoWCh181TjqpUqO2ThkNw6303/+nNSt/kwHWAtyjf9wDeCcQg0TuVDPfzY+4TEuUh+4MRUR6TyUxbMoI6kXDS4yBCs4qecUUhsNsImnUAb6lVZPueSEeTSfMVVv2GO0w9UF77uqpEqkG0fxHaEvwkRDztVZsxogWuvIz79pvcYXbGPEvy2/BEcZi77vUhpJvCox9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZfm37I/Zq5TW2O3iXn7qEteyn09glQiAw2hLK4y9jE=;
 b=JkanHqVjMUFCr8kjjcwwSYgaY588ADUKJW8JZfbAiYrhpgGadEEnylHnkvpY4w7mSyyNp368qNx0qLwtDGkdZriMJv2XfjZrJ4a6ouzqAntyoRWPFUBNrUe56tStDZoVKVBCwS64XzOpDKLd4HIm3aN8AfRhNCNRIjGHUTkXQQ8SojK1Z3OmR/H5HogssePxe3burE3yXx/fk/LLnq9t1iP2807QXBZzRbyfDrrXeBuptCZZXpxagBw5a+JW1E5OjY+OPQ/ruqQkWSUC3zeKyu3v2euTYxFo0Je/CZGqvSapoEhbgtG0w38Vvz5LILFsdFWKw4nrpsYm7hnrkLQFRg==
Received: from MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::30)
 by SA0PR12MB4349.namprd12.prod.outlook.com (2603:10b6:806:98::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 22 Feb
 2022 17:56:42 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::68) by MW4P221CA0025.outlook.office365.com
 (2603:10b6:303:8b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4995.15 via Frontend Transport; Tue, 22 Feb 2022 17:56:41 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:35 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:32 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
Date:   Tue, 22 Feb 2022 23:26:08 +0530
Message-ID: <20220222175611.58051-3-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220222175611.58051-1-kyarlagadda@nvidia.com>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8364434c-5718-4c6e-f793-08d9f62caeb2
X-MS-TrafficTypeDiagnostic: SA0PR12MB4349:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB43490D5A039353112822F4E1C33B9@SA0PR12MB4349.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f+aZEyDWLAgMYcn3UYsxu6xP6obeNUGN7XAkP2vIYzFsucJAVEI76OuwSDUtRzBT8XtFYpGMZIYqW5tFC9diXmGGb9Z/KDqOTu6tk4YtnH9K9k+Bz9DzOTezbwey/55a3+N3vpIPWAK6L90NfrOc4Keq1WJP2tM0njcoAtAtdLOy/2kk1PMGza0v9rEkxfowxRzQax8v/9EocXD/FJLRY0tio7ykFiT1+mKBfOsQBtR2TMDwkE+R+fwEwWdDZ2clhCRwRJjvAfurBMoPdbkUj7lsjbOKNpxdjIqq1kyVcK6dv93Kx/3xH/qKoFN8AL8wkcx7DRG/7aJlFy+f5Kjd/fC5o9rWVXyV4UnLLCB6EOAkJ+eUOC7MDN5ZNR3sq9CQWZG9SOjQZY8Ye6sZ9Ar8sv/edtcGb78D9jgNSWZBnvWi/VlHfHpKa13aAz7xV9dywYbOio04/18L87cAVbWFyEovBkbOaunrfdxfqqf06j11ld6xIX0bUb4H63vrk1yFGg4ngwIrumceIJXb8KmV0C4rJT0lhS3o9Exr7/TZ7I2MuNXJUTc25uQVsfAEA8YLMB8HOtPNO3eFUUmXuvC0NH0mgRXPPQObHEnbylOwwDEOCCxPTMipZbnoyF7fT3bET0f2p+f+o0gB4Cf7YiObXf4H6FEH8QpjfygtsSBLm/2JV+BP3+n27oQDAsqtiteXACkOHGz6Va+eB0WQdVroAA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(86362001)(40460700003)(4744005)(107886003)(82310400004)(2616005)(26005)(186003)(1076003)(2906002)(426003)(336012)(36860700001)(356005)(508600001)(47076005)(70586007)(8676002)(4326008)(70206006)(8936002)(7696005)(5660300002)(6666004)(316002)(54906003)(110136005)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:41.8500
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8364434c-5718-4c6e-f793-08d9f62caeb2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4349
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for Tegra234 for Tegra QUAD SPI

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
index 35a8045b2c70..6efea8970e62 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml
@@ -19,6 +19,7 @@ properties:
       - nvidia,tegra210-qspi
       - nvidia,tegra186-qspi
       - nvidia,tegra194-qspi
+      - nvidia,tegra234-qspi
 
   reg:
     maxItems: 1
-- 
2.17.1

