Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BB65930F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbiHOOpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 10:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiHOOpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 10:45:36 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E65C25D5;
        Mon, 15 Aug 2022 07:45:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwu+ZFyz1j9cwafCgQU1eRn9AmyljWpyqaa99CHT/EhqkKFv7LDLqFzjalGyvUO+x3+i3VmprmcIwQAT2kz7x4jM8ugghySj1aSpwNc9ii3szIIvlVfGbPMAbmXSZjCDEKe3KjmChZDunHD+s2JBDrxFfo5RxhaHjtvykp3t/C+Q1U+sh01c7Y4KAL7IVQ5mIG+318yynBmQzX4nzC1rp4uAwjeaMTgg0yP6ibP7VqcF3EzJcIGx8ncey9YOjNmTvgp2/Hj7yYKAlpRDByoOTUisu+4zVmpEKN9M0xyT4LvOnEo7//FHFmMeT52BSGqkUSWrM6vyPqAY3hPnL9sEnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rV6aFZhwlMIKe8BW/4iD7Fc9HRKFVUHewdKVeTg9ruU=;
 b=dgYmHyjj2ry/9pHotuLz++WDbw5REGzfCnQKF3vtH6lFrncydGY0g8Lcp7LdpgyO7/s3CSzi5r1g0hZVpvrFwNrAQ/lUiH6FH34r1YYB6wFJvK8SUu2vFahfSPDBq2PhwaGcxmmze2Ry6v99rjMqIBnycNTrlyj/Z2Sejaa4Pd5fscIDXKEcQhz4MtImz6P4xRJ2eKDcZZGnb1P1TTW83kHeIqgebU+buyp+TLYpQuYXMNugBFpzgRw/vuAaWw5sn6AfEIHDlVOMmx94qYIMgrbtp0xBXZjPYinNtBLaNnT2WINAkPlc3MLRxfdHM5/f2tEKAEtpo8xs6b24uO3gNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rV6aFZhwlMIKe8BW/4iD7Fc9HRKFVUHewdKVeTg9ruU=;
 b=H589z16b7ptR8TAf77TnthvYj2dNQV+eOGstSZAJysrpLIPVWWRjsbf3b2H9zi7J0zpBFapC6QxVU/XSVb3M2TRM3gaX4T3aklgWqWcWmgF/78PiWRc5lpimbgaB8YwijhnYEiyhUMaQ8Wel9nRqh1M1fRIWA61KJ08SZMyN6vAypuh6yyL9ItpOQKk0BYbaJYQXmldVcJCOOq9nhj5UyXvbTqUpSAZNfuzL8l5ssHvENjP34pt5mmthRt6q7Oc9dEPgNA+HyJFLwV6GsNVhgn59wbp2hOLRmtXPp7PU5sStuTYSLy+9/UQYQRM7B/b3cmGBHNkmilcRDOAPTbDI8Q==
Received: from BN9P221CA0012.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::7)
 by DM5PR12MB2424.namprd12.prod.outlook.com (2603:10b6:4:b7::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.17; Mon, 15 Aug
 2022 14:45:32 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::b2) by BN9P221CA0012.outlook.office365.com
 (2603:10b6:408:10a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Mon, 15 Aug 2022 14:45:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5525.11 via Frontend Transport; Mon, 15 Aug 2022 14:45:32 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Mon, 15 Aug
 2022 14:45:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 15 Aug
 2022 07:45:30 -0700
Received: from jilin-desktop.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Mon, 15 Aug 2022 07:45:28 -0700
From:   Jim Lin <jilin@nvidia.com>
To:     <jckuo@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <balbi@kernel.org>,
        <gregkh@linuxfoundation.org>, <jilin@nvidia.com>,
        <bhsieh@nvidia.com>, <linux-phy@lists.infradead.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH 0/2] usb: tegra: power down UTMI pad
Date:   Mon, 15 Aug 2022 22:44:47 +0800
Message-ID: <20220815144449.9525-1-jilin@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6e5feb56-3f6b-454d-0dd5-08da7eccce26
X-MS-TrafficTypeDiagnostic: DM5PR12MB2424:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: voCeQl3ucvl5cQXKTo6CybMF8/5ecmypcvT6NwcJ82X5rnzCKSzp65evS6CQ4WW5k8eoCRK7S7JaeuiCOcpjf+/EXWQvHMsx3TTRYZygzS4+vvz5Qo7/s6940CxWEyprzkOEKZ4aR3OvttBNbbmJiT6c82gGgTmS3RnuU1iEHjaVCFzJTP8+6Rvqi8IpoUsRSiOsjKGszrSJpRxu3QG/orGgdojMf9T2TJvx9ZmTjz8tOu6EhBP/Ixiubj1V9M6WcawCm/dpZR3aha5hlWNXUv7dSz7ILtLIceX53L/NGhvRVrhDH3xss8Z/GuwadZnmBHVS6mWZhYVJczNWG4Ayqsfe6DX41nsK9C0hGtFhginRMXj44qu+nhBqG57cB78LIo+bpfAgxjAewdOqRnOUYBSV4sKCENwelraPbcMwkqb1KgAEmD9cbkNZr/o5Qhply63BbCzYdqLseAxmZGPDt4SUbF2wT0JmlzW7hmwfCVtsmKkZqAtK53pWKOP0CONu9VnXAv+BeZ+ENhGxmaNKVy4zEMdxa/E/SofEiwd2Jctne9AOGFBPGBFXepcwF3vfN7/wt6L2ATGdMWE82Sr/R69Go/i5r/2t3leOe5/Mod/gQUZ4H80Z7b7XJTpJPZDFwhn3QeXNJfxY3ZCIMrn/NTuWgpSGvrxXMo+ImXXg2284zfD1YaaSjt35fYsgK4HUWhBQcnqSZFtaVcJkyAeA1JhYgLrq/MhM6KeUvOpXO0+WC5xqp1vjgMb8wudHz1OS2zuYXdq6pv8XcyY/qMCM86kybsayz7IAgy/OVuJmST4sARp8plnVRz6qCiBECo8Rvq1GmOThIR2Nk9uzMtU0kA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(40470700004)(40480700001)(36860700001)(83380400001)(40460700003)(81166007)(356005)(86362001)(82740400003)(70206006)(70586007)(316002)(478600001)(82310400005)(4326008)(8676002)(54906003)(6636002)(186003)(336012)(426003)(1076003)(7696005)(47076005)(26005)(5660300002)(110136005)(2906002)(2616005)(36756003)(8936002)(6666004)(4744005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 14:45:32.1656
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e5feb56-3f6b-454d-0dd5-08da7eccce26
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2424
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Make functions to be generic and public for tegra host/gadget driver 
 to power on/down UTMI pad
2. For tegra gadget driver to power down pad after disconnected

Jim Lin (2):
  phy: tegra: xusb: add utmi pad power on/down ops
  usb: gadget: tegra: Reduce pad power

 drivers/phy/tegra/xusb-tegra186.c   | 19 ++++++++++++-------
 drivers/phy/tegra/xusb.c            | 22 +++++++++++++++++++++-
 drivers/phy/tegra/xusb.h            |  4 +++-
 drivers/usb/gadget/udc/tegra-xudc.c |  4 ++++
 include/linux/phy/tegra/xusb.h      |  2 ++
 5 files changed, 42 insertions(+), 9 deletions(-)

-- 
2.17.1

