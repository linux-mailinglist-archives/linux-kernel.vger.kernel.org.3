Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199D15930F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240812AbiHOOp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiHOOpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:45:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC096253;
        Mon, 15 Aug 2022 07:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDkYivnxehNBXB4aox/iPax0EJdYUOw5IouL5+ajnlbTeothVsauN2iAFlZuuocHY/BVad/3D8y3Rz+RXtKvxt65BmYxuZmd0x/fFsYaBvGc/J4iyFs8j11fRfNjhpSYzFGMqvZxSvhn08NvWb2FVOYAA9Zgp9ofqHJCTBM7oP9khJMZJXFd/U/01lqc3AVMKYMclbu1rLXaPsrF4GGF3xUqQn/1InexY/icpaTkdU8dr+ZTOKGiuds6J6hPOflQ1Z+oVDuSk3dnU7zUhh29g3ccAgaWpzmBReLbGfIqcuSnx1lhG3az+rAE/kdU+JX8hx4D5eEVgBeD8d6GRc4YgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fij/vQJdID+GPEWhz9oLFHc+Oav2a7wYAcccMSFRG1Y=;
 b=N26qsuJnloXR9LiUaUjmHd32CUPgn2YhN6ySw542PJxZNy4hbIe4hTV/heL9oZizRv/JoMNRUyPGBZRzTjyhygCCgaPS1pnSetlkep6hH34NTVgZ12WNqAb5/CeifSYPcj7/D0cphXHfLzuNppwMSmJYmukvYevIwT5m8vOrX14PTpE+DgsowLiAMyclKDJr//Mnt8TEzIcKmvRwcaJv7W+QGtRAlqAGjHL9Di5p6Hu51bDNmhfq6SEFxs/IEbHX+7jhgq0cPRSBBaIXO6wIufl2J7UVroR2W9qKQvrlb+WRKWDrsn09B3fb66lxKitlvMjii1U7VXnx7URMsvwp4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fij/vQJdID+GPEWhz9oLFHc+Oav2a7wYAcccMSFRG1Y=;
 b=A+HAnjIfU9XZ3SJFLgJoffyGp8WrAw9yX+lbl34KEHkQ6oBEb1LLZt+kH0HWvGBLZZ0JOaZtxoI9mKtU1ep58FtZatAms+61sWsfi4wyQlvqaIIh4Xv8S/+Wr2uB09HhWopsG8v+yszf/nV7sKN202ouIL9xKZeLMTWRfmzZNW24UPCMnuSVhoRVLEG1z9rHO80KYJrOLZDK/nFWvjcFbG+3+XVKDxHyFBcBZLLz7s2lBPZn1iquQXJ2pPDntyrDW9lPgWFmh17K/ZJqWABbyOw/m8FMwXjdZtGjmMQaH6qxipwS38tjJLsVUrcsB9baBcjyFUKuUIwT71vW1lp8vA==
Received: from DS7PR06CA0014.namprd06.prod.outlook.com (2603:10b6:8:2a::11) by
 BY5PR12MB3843.namprd12.prod.outlook.com (2603:10b6:a03:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 14:45:38 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::bd) by DS7PR06CA0014.outlook.office365.com
 (2603:10b6:8:2a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10 via Frontend
 Transport; Mon, 15 Aug 2022 14:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Mon, 15 Aug 2022 14:45:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 14:45:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 07:45:36 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 15 Aug 2022 07:45:34 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <jckuo@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <jilin@nvidia.com>,
        <bhsieh@nvidia.com>, <linux-phy@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH 2/2] usb: gadget: tegra: Reduce pad power
Date:   Mon, 15 Aug 2022 22:44:49 +0800
Message-ID: <20220815144449.9525-3-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220815144449.9525-1-jilin@nvidia.com>
References: <20220815144449.9525-1-jilin@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8e5b580-2b1a-4119-3633-08da7eccd193
X-MS-TrafficTypeDiagnostic: BY5PR12MB3843:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiDHpCWayrFr2RF72y+oKcvk2AK3mjwWcMn+qk0+8eZzzsHw6ad1fBJit11DvKpcZHY2zydYIx06QMy093HfpPjTb93nBwhSoM0PU4e6LTkZbq7MnRXeJyB945ktfSLwc8ev1tSim194TI5hz6LuQpJM0UPiTf5ZhJRPh/PRwms9GClgKKxdMEyhmFRkx4mC5pFqoDWzMHkrmEY/4X6MXkNTMwH55BcBJImHdoKujfv8J5c7jq5iTJLOTOiSLwSZPE8ohUfwwEMhSFpH6xN+plD1jBy6D3gkztIdQDHYNArtMQ4AVFB3A0Kd+spaxzCWoqXg0E8672iOPsd8xaiVsaU+xT0g0WhcB6CksZPbM08Rji71GIKc7+AEjGVlpVsWKa+LoR6zGT79FY3Rv5eAkMc2ie3rk5BUQLNkKE/5R1HewMT1V7eV8zBVBVxMazjiuYGXk3JZiPRhJQhnkYBED5hjPgkKst3HjKo9CxrgTuGPP66aJrdMonVdWI8ksTo/YzQUlTcEyzvyxltUpbZFe4OhFN6VQuz1mGt7jE4rsR1f0ZYx+4RFHSJ5xRDYYFa+mlpLgm1RRzd7BIFl+vs7N9kPs4fsZ3q2wyHZFCw6lJFVexeJxsUnxZ4pl5XF15rJ8Rn/TJqkHvLPDQ5fZ5uXXeWTsz6T5491MUgHiXDLmExSuxBK87BqsSaRIsRpWdNF/4+qpSl78j6bHyr6cChr9h68wjl/bYgD44y/KfozcF0o+o+sQDORneLtgHHNhXCtK62Ra9dZVQN1jiHoL+DUV5z1HIKAtVlY7yEBOX6JHJPJuYwqXIF64ERhJ7yQCEHwaazCO8cmR/6jTesyO25gbQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(346002)(136003)(376002)(40470700004)(46966006)(36840700001)(86362001)(186003)(36756003)(36860700001)(82740400003)(47076005)(2616005)(426003)(7696005)(1076003)(356005)(336012)(81166007)(6666004)(26005)(316002)(478600001)(54906003)(6636002)(41300700001)(8936002)(110136005)(8676002)(2906002)(5660300002)(70586007)(40480700001)(4326008)(82310400005)(70206006)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 14:45:37.9766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8e5b580-2b1a-4119-3633-08da7eccd193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3843
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program USB2 UTMI pad PD controls during port connect/disconnect.
Power down pad after disconnected to save power.

Signed-off-by: Jim Lin <jilin@nvidia.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index 43f1b0d461c1..f03bed263922 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -703,6 +703,8 @@ static void tegra_xudc_device_mode_on(struct tegra_xudc *xudc)
 
 	pm_runtime_get_sync(xudc->dev);
 
+	tegra_phy_xusb_utmi_pad_power_on(xudc->curr_utmi_phy);
+
 	err = phy_power_on(xudc->curr_utmi_phy);
 	if (err < 0)
 		dev_err(xudc->dev, "UTMI power on failed: %d\n", err);
@@ -757,6 +759,8 @@ static void tegra_xudc_device_mode_off(struct tegra_xudc *xudc)
 	/* Make sure interrupt handler has completed before powergating. */
 	synchronize_irq(xudc->irq);
 
+	tegra_phy_xusb_utmi_pad_power_down(xudc->curr_utmi_phy);
+
 	err = phy_power_off(xudc->curr_utmi_phy);
 	if (err < 0)
 		dev_err(xudc->dev, "UTMI PHY power off failed: %d\n", err);
-- 
2.17.1

