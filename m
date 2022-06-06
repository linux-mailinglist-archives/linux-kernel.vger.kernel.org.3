Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6554F53EA63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbiFFO7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 10:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240222AbiFFO7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 10:59:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9931D3082D2;
        Mon,  6 Jun 2022 07:59:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUDFSlYlAocvtpknFbAXnyRm7AdNzF5fy/dJdnhV6mf3swejXWKa0A3nvD0Ch3B/m401sAZpJxDjmpGw+tcWjF0a8cAZFS4FL2aorVu2u3CDfEem8wUy9yt6lVkfMdtlzN/kZC8eIx/ODBW4OkFWZL6jbuTT/yiLvoIhv0JsiCvZZslXBec+dmYxa62zR4JyxlqoCkObCv3BxIHkNCJSwco4xE8vdFa/5QMJaDT+MyoY8fDvxCrM5saYosmvBK88z7lVfAY8SzSe0J1Q1pVEzvkq2iYWeRZ7t//IiRclmvZl8KFYlgJGPL0EKhZdK1VDKwGZVcOAqpr8l/cMe+pk9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2OB4KP4HPqBeNN7TQwLpJSiJbmDC/7/zpPMKNArzKE=;
 b=XbQRPf7Gxth6dDh/D8twiV/oAJPJuT70xsBXt9FIZTyA7FiXDAFn/cY+MyLxqDP7j41QhtLsb790toD5AyGptmgzDAYkJP8iAKGprevlD907YL0wY6loJ7wbsv2uHUzheLRTPxJZffCV0x8y2FcCNCGjlrRpfXQAZh/9JvUTiivbxHM5LNAS3ORV6VNzfxzJheqMS7W41BNdWduRVH1NGDo/KGFPBFwpaDXiHZ/xcsXBMUSYJtZRjonLhIkQQ2NxYDFrXyApp7IXg8L5qna/8o9InB3q/qLJExOFSmmSpLLuu5xJ/KtGa2tmd6Vh0pJ9mskMYwBCAtAEYjoKP5nM/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2OB4KP4HPqBeNN7TQwLpJSiJbmDC/7/zpPMKNArzKE=;
 b=NTiIz3s9R2mH3VC1cTbXYJ6jYuKyLi+qReQwKYs7fVMcotE4L6eRs3D2592cRMB4kBdYfNVO20laBDZYHCc8UUGtNGJ8Ht75YmyrFvRKZPi4Ca/LsXsJri+jX+hnYIH9jqx9hem+f41xT7gL0vukFQQOQIl1UJEIA/pHw4P8C67ibwA8FHXA/M79zquhwpcRUCIbVsuVjITd3TrAb87YYlI1BDvD3gdBQTiyxJ8Bq9R31Z9jC5yRkPqiWcUsKccMTdpQOyOcS+iMbswkzp8G7cM3XpSiMYW3nQeyHv77iKMywlJjxLM5cCylBatoIUDVw0VpQrZwg/LafleYOSavMw==
Received: from BN0PR04CA0139.namprd04.prod.outlook.com (2603:10b6:408:ed::24)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Mon, 6 Jun
 2022 14:59:30 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::92) by BN0PR04CA0139.outlook.office365.com
 (2603:10b6:408:ed::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.15 via Frontend
 Transport; Mon, 6 Jun 2022 14:59:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5314.12 via Frontend Transport; Mon, 6 Jun 2022 14:59:30 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Mon, 6 Jun
 2022 14:59:29 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 6 Jun 2022
 07:59:29 -0700
Received: from audio.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.22 via Frontend Transport; Mon, 6 Jun
 2022 07:59:25 -0700
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
Subject: [RESEND PATCH v3 4/6] arm64: defconfig: Build Tegra OPE module
Date:   Mon, 6 Jun 2022 20:28:55 +0530
Message-ID: <1654527537-31038-5-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
References: <1654527537-31038-1-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acaf9cc2-31f5-4265-bbb5-08da47cd28f2
X-MS-TrafficTypeDiagnostic: CH0PR12MB5332:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB5332A5D070242B9A1783611BA7A29@CH0PR12MB5332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNDeNcAB6CJD5Z6PfRdrjyaUQvFsOOngNdFR9QaiSfGRQG2MhjKXy8lgpvHh7uDbKedH6fO19bbQjsO/5rDWjbu7v2+70pf+mtY6zldCn1r7tbc6/vSfwDsEsBh5fA6zgl38MlnQWtNZebRO2YatVfrk8q0PYK2gsUSBf4TaggYJnhBjd0YghAkSeKeQemKOvF365VcytzgpGdOn3A5FNCviaKQXgOwNpqcfj3vkGfPId7PSQTgm0PCPYR6VcUDwnMyJ5IKFLo4x+waVD6I2jVzxGOVE2IJ+ugYiTyglNklmaYdbTA5vL+LtuKI8N3inoVDUR/aCwErpMVzzkmjN0tiXTD9DVs/5DPcArvxdwfLBtSEqHo4SMVF5YnnyGTZdzbnVNWCLv2ChGkh3wwpMJh3Poj/SKQei4fJKzoT/1I3bPwlI1kmlBAd+o0V5TvGAeDSVAYwFPWV5TFeXcLwmAOzsYZhOQlB0vip1hCi87+bKuIt4zQTrWcwYeLy7TVkC49NmVic8cCx7FOoxymyGxA0QpGeQ4M3VOa2cOZLymxUjH0mSWFYlLqkZCAaWreuWfgu9x6BSFBPBKYR6gaK9R6db4NUOTaolP0nfYrgpQt4QsUnAWb/Wa7dCcVREu11LuW1KqUri3aB7mJIGO4aE6dXrCB9YPZYIs3Jl10m4qaDG5/PFofy9GSty4Bwm+P4s/amxVD2l+4bSl4wMXktepQ==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(7696005)(6666004)(54906003)(82310400005)(36860700001)(86362001)(4744005)(40460700003)(2906002)(5660300002)(7416002)(4326008)(8676002)(356005)(316002)(36756003)(426003)(47076005)(336012)(107886003)(186003)(508600001)(70206006)(8936002)(81166007)(110136005)(70586007)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:59:30.5335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf9cc2-31f5-4265-bbb5-08da47cd28f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

