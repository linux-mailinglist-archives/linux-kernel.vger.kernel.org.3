Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3865559592F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiHPLBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 07:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiHPLBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 07:01:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E481AF09;
        Tue, 16 Aug 2022 03:27:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfO56ftuEHhNzKdaE7RgEVc152Mm7bVQfxREJ+tiwS2KTsgiiF2pBH4chrPz3tbV3jyb49IDhCSqdmR+1uds0aSOn7d4h9izgKT4AEC/roYir64TzBL136k/ShymXpBGlfcH4l3dGA+lVmOf5Cf8sx18GZ7Swz2umn1KNIr+FUJS4pMVS9BLn7lP8qRVVWXVhYbHAz5nkMlRbedQYecJr8Uw8qoepzOlnNbVOpemMAdRDjjPjlFNlZbX8kgg40dGHXKN64dPya7R3ToZ79dBcx0rkg1OuAP+OajOD8NE817f532EtNt9A1zO1DsjnbUWqf28QzbZf6M7C2O6wCtLFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhPwrDBhtNQdqSvTZ7g2W7T4spW6Q8y37yDYVA87EZM=;
 b=aYTaPKQR3q2WR5iPKhHKFUJNNtQ02VPkFePC9CjlxEEtK31DxyYQkhMGeLh7ZwEiSO6bbyDTciptQQMvuW7C3iZMP9LYsm7k+PA97ww2rdEccoi6d4iU38/pm0zG1h0PIPmYPvRflNM6VreqxQ12+Db2iyJstld26hA2gXo2vMKi9aWLZ3mveghAozzryxClyYqNQCR5uDJBmvuodAZpwnViTeRbGvKUNRPrBvACf6Sc/jM61TfJ8BV45N5hKghNUy0+OnEbyAYoYrYxG0FkLtCQ7CGEfQVrVTwKCpB/Lr/gJgy0ujDXVRFEr1Xt/GgZ2Uw5o04qJEAaLQnuu8yQ5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhPwrDBhtNQdqSvTZ7g2W7T4spW6Q8y37yDYVA87EZM=;
 b=TYgvk3sOr2mZBamTMZ7XDkNVbe/UYaiXGfRM8rRaxyHGWvgBB25kCuGom6c+Odki+44yaO2XzXE1zVxRhoG9kqYRTLdAuB4/BhYCDR92NuOr5hpGCrzMn+N1wf3itG8BxMIp9ezFHgsk337lUqtt2zEvCc4DwdT+d7K68ek/cpnErdjDqOZGXsoQx/Q2nlhc21PSVJr0AFXit+JqRnxgZw7brv9CDU8vriyVeFd6HiNS7g4Cr4qdiwgsE6rNmEUOgQ2F2eAo06BvrzpFd8KggFuMymdWjfRSHYNmDLBd0OJLGEqv6REVcvBmSV0MayLwj29O3KURUdYjVZ6Wd7KrWQ==
Received: from DS7PR06CA0043.namprd06.prod.outlook.com (2603:10b6:8:54::25) by
 CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Tue, 16 Aug 2022 10:27:31 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:54:cafe::31) by DS7PR06CA0043.outlook.office365.com
 (2603:10b6:8:54::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.16 via Frontend
 Transport; Tue, 16 Aug 2022 10:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5546.7 via Frontend Transport; Tue, 16 Aug 2022 10:27:31 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.38; Tue, 16 Aug 2022 10:27:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 16 Aug 2022 03:27:29 -0700
Received: from pshete-ubuntu.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.29 via Frontend
 Transport; Tue, 16 Aug 2022 03:27:27 -0700
From:   Prathamesh Shete <pshete@nvidia.com>
To:     <linus.walleij@linaro.org>, <bgolaszewski@baylibre.com>,
        <linux-gpio@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <jonathanh@nvidia.com>,
        <thierry.reding@gmail.com>
CC:     <smangipudi@nvidia.com>, <pshete@nvidia.com>,
        Manish Bhardwaj <mbhardwaj@nvidia.com>
Subject: [PATCH v2] gpio: tegra186: add Tegra234 PMC compatible in GPIO driver
Date:   Tue, 16 Aug 2022 15:57:25 +0530
Message-ID: <20220816102725.14708-1-pshete@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <Yhe0pCpfeCpyfPWg@orome>
References: <Yhe0pCpfeCpyfPWg@orome>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 419c3691-e547-4f33-5a7e-08da7f71ed2e
X-MS-TrafficTypeDiagnostic: CY8PR12MB7361:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FVYdGrwuk6LeyM6TCPSyO6M5TCUQ84TMWhrQKchGnSTGIfkUzp+HBfnhhnTqXNJWhka9y7gW4ZfKaUChuiLHrvEduc3o+gRx6CdUzdUfd7fOB/RwlFcf1vB20Pe7sD+J9RHjMjs1KFh3aYmX7Tem9OctdK+tTlAewZE1AQxvTLlpePxo2Omi9+TE6iCVAJrOZvzgQZ3x0C+99pKK+dTVFRAG33DUgae7aYjdB1kAGVxSE7AhzfTPjQpKi19VksSDvsbhY4XL6snOiB3N6TYAUJw0HQPJ3NOZd3RKFl+NIZpGYjglAuER8RK/j95K/gb6xoUN9luB0wWmY8W6Kgeqzw1j5CKQFpzf6hX10Ge1fSdhpn/b1x3E5xH9yuKQEYiZuaLjFiIshpTkaPj1bbXr/uh3VZ9O0gRXA6QzKNY0BMJUIrbT3u6fRQ4xBW8+CRw48X83fR+wj+VjZnqOugyHFnyDtSRkBQ+y45jWhO1ThYaAzLIBkWX92672t11xe+1B84zSaZXFHKauTGNpQhIBYr3I+hEai0WznGQe+rFZXDhAG82fnRaiJgsqHLA722jyd3ajqPvDpdTpy3YB2Kf+5oQ1srbbCe5WItStoOtlPkBVJ3TNbF7DQxRJP0pZZiaUbVQgoMSAY2WGsML36+brpNJeVZF9C/cBlN3XnjAzI8oMrWFNMFdWcQbWCS8wRz5cPAzzqjo2yX3a6tMaQlBtvo3VlraiwAUOg/aNlunF4Ilu3/xPCNQZVDCF1qhngrZ3LLINAXlCNdnFzNmq8DVvMdjb+wUVzZStj0DPeFysUsy2sExDLoSFQB//tfIUg0vsj2A1oUbO6AaaiwaH6VAzpg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(40470700004)(46966006)(82740400003)(86362001)(316002)(40480700001)(8676002)(70206006)(81166007)(4326008)(356005)(5660300002)(70586007)(4744005)(426003)(336012)(478600001)(47076005)(7696005)(2616005)(41300700001)(1076003)(54906003)(8936002)(186003)(110136005)(36860700001)(82310400005)(2906002)(107886003)(40460700003)(26005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 10:27:31.2210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 419c3691-e547-4f33-5a7e-08da7f71ed2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using this patch we are adding PMC compatible string for
Tegra234 in GPIO driver so the IRQ hierarchy can be set.

Signed-off-by: Manish Bhardwaj <mbhardwaj@nvidia.com>
Signed-off-by: Prathamesh Shete <pshete@nvidia.com>
---
 drivers/gpio/gpio-tegra186.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 54d9fa7da9c1..824a355ff27a 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -669,6 +669,7 @@ static unsigned int tegra186_gpio_child_offset_to_irq(struct gpio_chip *chip,
 static const struct of_device_id tegra186_pmc_of_match[] = {
 	{ .compatible = "nvidia,tegra186-pmc" },
 	{ .compatible = "nvidia,tegra194-pmc" },
+	{ .compatible = "nvidia,tegra234-pmc" },
 	{ /* sentinel */ }
 };
 
-- 
2.17.1

