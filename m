Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39D4C0091
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbiBVR5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiBVR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:56:59 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C572616C;
        Tue, 22 Feb 2022 09:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEOEuqhglLcZGcjEfGnLXKJb+Q/z48fjnmda+FEyFV3BNq8SI00Rg5ndhex1ZOG2zdYxljmIyVsu3sdJMEUtqRFwcgFj2D6h9nbyn1uA8uiUxixt+gsKKfLgNSymClsDIo9lnEjhn/JYLzLw7Wo4qmG+b+ETS7HxFn5RDLgRIXKMTitS+WpAfaLeZZRz8Ow1XIUBGXKWAQw8N8nRK/GGuibLmSvAL5kbSH7o/eF14xBFVKpKOKQFhpsiNUVfguBNs+7M+MyQQcDnzJVLyqzyct1ugvthlHZ7Ue7AeaksyXD0EOXaYdLI5ko/GyV0YXiJOSSP5Uh6QUKjmZYU7j6VqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o6E7VW35yfPY/5YK76r775RyTXcm/5OBWphdgA9l8jg=;
 b=a4bVthXut4N0wsoVQj+UZK4M58Rak4wbgG3y/n59Odho7SS8hEw3Ak3zMJSamzKWCxUZrKG8HaR/PhM7IdnsAQQTqN/aRWLwjtAFUQLOIayq2wequLna5it85p1wRVIGmi33ODZHbBI24Mleq9XQ1t8vTijUA6MC4W7E7K5KaP7c2L+i9dlxjUONmvUlEnjE5Qs1pOiDYc9oFa/biIULtAMjuC8dNF781NtxMjTMIlWUg7uNHshZpmzrb/RJ0rtFB6OyXMW0jzlaihSG/Ye/RbsW4LZmtqAzf55IOf3Qi+SvMfRD6isnrboEV3m0J+Wvmaj4PsyjOx0sR9tyCUNuWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o6E7VW35yfPY/5YK76r775RyTXcm/5OBWphdgA9l8jg=;
 b=rCuLSm9jblNo9EtKF7K4k+cJ7QB3bYaOpgXgegLt8pBDl2tFwzq2AqoJaZgdb/5zNi3qViOFnhcGabB5qPZyUqImp5cWHDyD8uT6zHMwAA7gI7wH5rvuUFC7P3sDI7DoTVSW62Fvgv1p0vOOPlMOi665PfqBVX52ZNyNZ0/XbCPKZLEplbEImk+bWYm1PzB4x8YOVtbwGqV9w8y1SOM3Buklm8/5F1JUxRJU/0pHXfjwpRUOYxZgBKtSG+arikfvSplYQC2BowYKV/qK/138Lk2BVr1IZJgpd2hzySpqoA+EKoBwiyJ4WUQlhTV7nWECMdXiDic+9UZjphKO9dxsCQ==
Received: from MWHPR22CA0001.namprd22.prod.outlook.com (2603:10b6:300:ef::11)
 by DM6PR12MB2698.namprd12.prod.outlook.com (2603:10b6:5:42::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 17:56:29 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ef:cafe::87) by MWHPR22CA0001.outlook.office365.com
 (2603:10b6:300:ef::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27 via Frontend
 Transport; Tue, 22 Feb 2022 17:56:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 22 Feb 2022 17:56:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 22 Feb
 2022 17:56:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 22 Feb 2022
 09:56:27 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Tue, 22 Feb 2022 09:56:24 -0800
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <linux-spi@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
CC:     <skomatineni@nvidia.com>, <ldewangan@nvidia.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <p.zabel@pengutronix.de>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH v2 0/5] Tegra QUAD SPI combined sequence mode
Date:   Tue, 22 Feb 2022 23:26:06 +0530
Message-ID: <20220222175611.58051-1-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f39e5895-3562-45ca-15f9-08d9f62ca742
X-MS-TrafficTypeDiagnostic: DM6PR12MB2698:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2698728DF8336946CE13B48CC33B9@DM6PR12MB2698.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPbop0P/iNz1xqjbOzlk+TTzjOZxqLn2JEG12MuboVWPPq7+m7eofNef1gsjUwmy4papK2CSX+GUrczlpOem0x0GOy9ARLU6UpIiUVMMzi93e6IgUO/UBhoYRALlTsEzlNOm4kjyW0BwGtrQPYcQGpzxsL3nnBYCQ4GxNoCjw5hXS3cXXP5OsaRZcFXb8f7KyiFtYCvum3tNOCteCXOWGK+iWOIPQAwjjRpitGXrvE/DBS0rItcwcXRjiWvE5eeZlcrxFuzmPxfOUsuzL33gqjONtNgJ4vzrKhHEhiVV6btsTlPUx5LV5BHDb/I7m9edCGlBT2gsHrn1ZZdwRfaHJbR3IYLz6qYid+4eNl0H4fjB2ExCW9ZeMY+xKJnZL1vLxjq43i040cgHmIG8tQR/0v8lCwiaX7+x+5JDimYhM1kU54GUSgTQRrv413BBnVl59Lv/Bqe0tBC1IDm1NSBdXe+j47BZvD0z/POPLbZjXa8/+xsMDx7FKvDpaZw1gZjLg6idyszZjnuaOvAUZjDzPkTva5Qq+H9WVeJ+T7q21GFNIA1RHSnBjaAfHDVUbLazfPUNIt8VH5PTPLqu0Y7+cS1uNmfLKDDDILJdHVFSw6u6RmnOvlyXpd1aEaHTke+eU2Nbdj72qLHgDrYurKYxzD+EfhToo7mB56jLG7KEWDs6lJhDpSI3dBwsyeYUSFIU8SSbLO2FVaO0noKR/OZf5A==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(426003)(4326008)(70586007)(5660300002)(336012)(508600001)(110136005)(2616005)(1076003)(70206006)(186003)(6666004)(7696005)(36756003)(316002)(83380400001)(107886003)(47076005)(26005)(8676002)(4744005)(8936002)(36860700001)(2906002)(40460700003)(356005)(81166007)(54906003)(82310400004)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2022 17:56:29.3662
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f39e5895-3562-45ca-15f9-08d9f62ca742
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2698
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI support for Tegra210 QUAD SPI driver and support
new Tegra194 feature, combined sequence mode.

v2 changes:
- use combined sequence mode as default
- remove property to switch transfer modes
- fix compilation warnings

Krishna Yarlagadda (5):
  spi: tegra210-quad: use device_reset method
  dt-bindings: spi: Tegra234 QUAD SPI compatible
  spi: tegra210-quad: add new chips to compatible
  spi: tegra210-quad: add acpi support
  spi: tegra210-quad: combined sequence mode

 .../bindings/spi/nvidia,tegra210-quad.yaml    |   1 +
 drivers/spi/spi-tegra210-quad.c               | 330 ++++++++++++++++--
 2 files changed, 300 insertions(+), 31 deletions(-)

-- 
2.17.1

