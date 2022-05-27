Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D397D535E36
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350983AbiE0K1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350962AbiE0K0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:26:42 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4AC108A9B;
        Fri, 27 May 2022 03:26:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DegHRzZKqDIPx6CdkyPWej1e9HwZRMYvvu8SA1esQNU79Z+DwX1DOnaVh3lIGgj0hE6XN+dwXYF7gxA5/dDrxAeHVDvpjUV/CJq6x5fpJOl5NXjLdgitujbiAyp4EF9gcho7J32QAw5cJ0YH1VjCtrsoRekynwDKnKUoSH/dpi/EE/t+NrNuUyQnV7ptcUTL3W02P5fP/2zK7FHX2ah0f7zBr3OlpNBHtEJXDwsaqfrRAXjMO+VLNePRde/0+KAjZdhLfEj4uoHVEtTodKxsfYg5x49QfcrplaRsvOD/4fE3eoAlkoAFU5XVITpk7zV2p+eyZlcpf7uNjgReVPxNzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2OB4KP4HPqBeNN7TQwLpJSiJbmDC/7/zpPMKNArzKE=;
 b=YXJPXMwUmxySrWi/tT/Y9R/cwZEHlqaNlQrYOHxzRmlvENWMfXIm/vsjXdTrIOT9E2wvb0fQHGO/G79qe7i8b6HpEBool+6Kcv9HnGweu0PT+EZuxKgDFxEa73wBredFS8eV+Kql/OaySj534YpuzY57vX7LzsFU6UbKfoSlK+NawVs1PcSWD2UORLqtbXFdslozJuebsk8hDy0yNlJEy9drvDjEEkt9g81WuV6edAFzTbAgLAKzrBZCNQO51CB56eHxu5f1vVhkIFXTEioQ4Waj4vBI+uyCUzf1cyBhmBp9v0SLBdtZQOZ76z4jEfCVxpPjiBC6gE9XPKemeuivlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2OB4KP4HPqBeNN7TQwLpJSiJbmDC/7/zpPMKNArzKE=;
 b=f42EwroF9N03Dag72121GPc7kYyGuPkGlHLAXYeTxgkLG6yFvrXJVcduTktXfLllDMkamHcfl5ct1CdXDAjMbHY5D97qB8AKq5bPvmE0jC2AZDXU47RuvB71elMpN4pJlEe4CRuh8uJVdfrHHP1oOeWjFU6SkUJ6SJL3uKqzSoZrWUHhdDmAUDQrlj/4+IAqFSIXa+P5nfztgl/eDi3Iw9WEnX2lEBUdW62rIjtgjjweFvmhlHjTBPxf8aoofIVSgTFd5MEujnSIEYg9GFjSwJnmKeRNiYeEDdheQgDDdZx8jouRPJBNFuChNJsUXVav6bGUXaspA3BG2dkMEAr6cQ==
Received: from BN0PR04CA0182.namprd04.prod.outlook.com (2603:10b6:408:e9::7)
 by BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Fri, 27 May
 2022 10:26:40 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::a6) by BN0PR04CA0182.outlook.office365.com
 (2603:10b6:408:e9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Fri, 27 May 2022 10:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5293.13 via Frontend Transport; Fri, 27 May 2022 10:26:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Fri, 27 May
 2022 10:26:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 27 May
 2022 03:26:38 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Fri, 27 May
 2022 03:26:34 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <jonathanh@nvidia.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v2 4/6] arm64: defconfig: Build Tegra OPE module
Date:   Fri, 27 May 2022 15:56:10 +0530
Message-ID: <1653647172-2569-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
References: <1653647172-2569-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96876b0c-3456-4a8b-d51b-08da3fcb6347
X-MS-TrafficTypeDiagnostic: BN9PR12MB5147:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB514717962B50AEA90F94A920A7D89@BN9PR12MB5147.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TorqRFwzhkiolnQLvufFyeujyoWp6Xp22hVx65tYdF5XhxkBis8ZyXRJ6Tm3Yt6vsRhbJITa6yDVJsVYNOkx95Cz1oNjrXLiiC1Kv2Hw6wkqKLB1pFhgF2EYUq8kFtMvV8sDRsYzc6MbFlN+s3Hd0Q5GxUrrMSEMZ9GQ33m+CSVqouy+cxDLyObasv9S/AAJ+Jq3lRxFaSnkcobwUiSFOTStsSCIqhisDoxrVeSyJrLi/RuhTuGkjmZwrBS/hjBiiyZnhqlhnAz4Tb6V3Wii51O8LVvKvjGGkAQ6aVi1qA1ZEPdZtYW+hR3/7nvV1PgL1QMnL9SI0yG99+j+uj7bccylJ6SZwTpO8pIPMzGIn/c+4W8fn7C19bmrcimix33VoF1l1e5zRjaOXxJ6cW0xejA0xqXO1xCMukWvXnPI9LUMOQ8jCGt4i4lh2MMMjFqUqlwps12IMlbXWFd9bTOTX4FiT9FOR/TaQ7ZCFaAnXPQpfIgA13UC7X1kJz3r4JfXaJt3qF+VUXtxsAxj1uR5bs8GD0FIhzkZO+xQ6C8mGVuJw/aznIGOco0L+NrM6bzo61ttQXRp8KEQiTflDB2UB4uk/Wq7RJpjvDTZmZtUtwIdcYBbox/m5cAlbUjXMW2eQV/aFEBf3tjLdtzHaIDSPmEf0UnLGkpV7QUuSHCO+qTC+qwXgnEAlNwf3ILkhYlaPTEFTtwszSpAtEpBom4W+Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(4744005)(81166007)(8676002)(2616005)(4326008)(70206006)(70586007)(356005)(107886003)(508600001)(8936002)(36860700001)(7416002)(86362001)(7696005)(40460700003)(5660300002)(54906003)(110136005)(36756003)(2906002)(316002)(47076005)(186003)(336012)(426003)(82310400005)(26005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2022 10:26:40.1190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96876b0c-3456-4a8b-d51b-08da3fcb6347
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Output Processing Engine (OPE) module is a client of AHUB on Tegra210
and later generations of Tegra SoCs. Enable the driver build to use
this in audio path.

Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d11053..3e154cb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -808,6 +808,7 @@ CONFIG_SND_SOC_TEGRA=m
 CONFIG_SND_SOC_TEGRA210_AHUB=m
 CONFIG_SND_SOC_TEGRA210_DMIC=m
 CONFIG_SND_SOC_TEGRA210_I2S=m
+CONFIG_SND_SOC_TEGRA210_OPE=m
 CONFIG_SND_SOC_TEGRA186_ASRC=m
 CONFIG_SND_SOC_TEGRA186_DSPK=m
 CONFIG_SND_SOC_TEGRA210_ADMAIF=m
-- 
2.7.4

