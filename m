Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5E57C44D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbiGUGSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiGUGSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:18:31 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2046.outbound.protection.outlook.com [40.107.95.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C9481C5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:18:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYuRY99WDwqgIxaFSsoZR/T+y9HuLCXSP7awsnPd9ct4c0Kvn6tNONo4NhJyAbDJa/4YkefM3mALazes6AnJApXDzHGEXR3G5TfYKhmrvBIZQMWiEkZeXHeM8kjk8qjFqg+1gdVzRfXt5tu6mA/GP0TqCdRR+erVyfSWUzVcXn3KbmUnLyeAeSQjthOQKa1geOSJYh1/RuvWymdj5aS9jQzX3G3HevO2F0soDaYLVBbdV44AsqzfaRsCszdlEQUnDLornV3IASMNnBlcSipfk5c61JrYeCO6mlkBDuU1oukt8xWHQq+l42Qlkuy3wTPKVe8m8HWrBPEBYEvEuREMSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53UPKWwddkq2HDXrU43x19XlSwhYok/Q3gxki6j0hhc=;
 b=f+uxY9sqQFyRND3AhzVZkvJy0a40rJuwWTxaT8naFtqYZYqH44ITVDSMNtD37TPqTnMgKh6YsiMH5Umm7Y9ctSqEC/kzX1KT/TyxtLAzZlBW9Xslt/6iiRGNhBFTKnV+o9Z47M1ZMbdsciegoBFakFggg1P976+phmb7b/QK3Agn5tY3by4oHh66qjNUWlfU3nSoAtXYaZAm3utGomxDL543V6fiSV6azNs1n0hX9aaItXA9zJmjiMgzIGSMvl0iJ5Pj2bXRyvugIV3jdtOay/fS+N+aoDQ8nNTpplxN2kHBJu57FA4a0i9KESvq9KjhiRwgmJRfs+FR6P20iQm6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53UPKWwddkq2HDXrU43x19XlSwhYok/Q3gxki6j0hhc=;
 b=Z9VZmSeXpLPbKutGf7WnPp00LTxblvIk++SMj6FX63xaG/iwxEQvOOmCIY8L5Bugh+6uS9XRddRSIFzhzn2+eKDHpaYuRxuNxqBomTP5DwSFP9AsjutLbRgaocm1FjMYzfVH8J3BMvbot769+hPUte0e/kc5/icnoHtNYVdqrUQ=
Received: from BN7PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:20::32)
 by BL1PR12MB5827.namprd12.prod.outlook.com (2603:10b6:208:396::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Thu, 21 Jul
 2022 06:18:28 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:20:cafe::48) by BN7PR02CA0019.outlook.office365.com
 (2603:10b6:408:20::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25 via Frontend
 Transport; Thu, 21 Jul 2022 06:18:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:18:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:18:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 20 Jul
 2022 23:18:27 -0700
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 21 Jul 2022 01:18:18 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ASoC: amd: acp: Modify const resource struct variable to generic
Date:   Thu, 21 Jul 2022 11:50:36 +0530
Message-ID: <20220721062043.3016985-4-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fe8301a9-1ee1-4eb3-1479-08da6ae0d3b4
X-MS-TrafficTypeDiagnostic: BL1PR12MB5827:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q5L9Z5/Mrj7J0T3tfbj+327wSqiwpOga5DbrojdxYt1qWRtEHJG0xEG8YpJrX51k2tfDvBZYU26NqhFybSCPdy/zvfmxs4WvEywwjIdHoPvDLeCijORC5nwrhLi9f7BAI71wOXvQ15bweAkFST4PCHVVqnd9lypYIbLEjIzZ2BiqvxPGuniK+TlnuaPJs0DrrPOFYrl+gR8nZ3bT/HC4GLNvhx80kroF/JODbBKB1Y64Wf8gYVwjgAzNFIa8IxFCiZR0InypAfD9fdRLtuaWxCd2WRE0uLcUz5TslzgnY+Ki9Hd3X2a9GnNpRJtS8lA3yZ2XuE36+Rzt2Y7OU4vCwKFJWuXc/BUtCVupTxSCXnGNTerDH9higC7KpgjPVj8DJ+EaaBEfSCYQ4pSaBBrpSqnnDbswnkSro57dktXF99q+7/tR0GeOXZhE0JYAevjUk5awXTsDidTIM68j7/GdKW/6zWGEpENZBmoEAQqq3gBaEkl8+yP9yjmWbTOVLxNJnVMW5k50t7kJp7yYgpHdQTzgTZPDQcFq0IKV7DjJekgnXL8oJd6phGG+CD1ngB63QTiz/NpBOa5qZJk/yW0L9bYtMen1XCZ9k1cjNR79IKxZqTJvitNxAkV0HSruFGAjdbvyQRs0OTejEVoymBiEhX7M0vaJkaguz/MarfQ4mZBLDXUbrTk4kwBb5KKueYfpJLSh4Znn20/flDRP3AzgUMMoUmH2m2AICWSgkfh3m70Vu4Q4Jj4iRjM/rTk5QRbmzAgR7Yg/lT6oVi4ukgf/yTHEUFozU2ICcpVyJeagHfnt32z9sXZQG9/4YW1MxpdcKb193YU59JwZPZfdQDSdUJyRC5pbZ2vu2/4a+zy56eA=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(36756003)(5660300002)(40480700001)(8936002)(2616005)(2906002)(82310400005)(86362001)(40460700003)(8676002)(70586007)(70206006)(1076003)(82740400003)(478600001)(426003)(186003)(41300700001)(4326008)(26005)(54906003)(356005)(110136005)(6666004)(316002)(7696005)(336012)(36860700001)(83380400001)(81166007)(47076005)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:18:28.2578
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe8301a9-1ee1-4eb3-1479-08da6ae0d3b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5827
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change platform specific constant resource structure variable
to generic name.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index c03bcd31fc95..34d75603eea1 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -29,7 +29,7 @@
 static struct platform_device *dmic_dev;
 static struct platform_device *pdev;
 
-static const struct resource acp3x_res[] = {
+static const struct resource acp_res[] = {
 	{
 		.start = 0,
 		.end = ACP3x_REG_END - ACP3x_REG_START,
@@ -75,16 +75,15 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 
 	pci_set_master(pci);
 
+	res_acp = acp_res;
+	num_res = ARRAY_SIZE(acp_res);
+
 	switch (pci->revision) {
 	case 0x01:
-		res_acp = acp3x_res;
-		num_res = ARRAY_SIZE(acp3x_res);
 		chip->name = "acp_asoc_renoir";
 		chip->acp_rev = ACP3X_DEV;
 		break;
 	case 0x6f:
-		res_acp = acp3x_res;
-		num_res = ARRAY_SIZE(acp3x_res);
 		chip->name = "acp_asoc_rembrandt";
 		chip->acp_rev = ACP6X_DEV;
 		break;
-- 
2.25.1

