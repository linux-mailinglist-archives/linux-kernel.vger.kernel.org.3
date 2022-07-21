Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B3857C44E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiGUGSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiGUGSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:18:45 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B0045993
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 23:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YNthUB9QLiWTF590gnacxO970rBq1fwQ0dhO0iZ5itcQExTm//mcI+ItyIG++CVkrxz1qkNiP6VJ9M6G3QbXakC6C24wTR9xrcJKH/dStrKFc1ihiiNWRkixn3GIE+v/8IRW2B01AIX7HNdvfw2Xgs6HlGgBgN9CL+kOENYZEmMAVdHDt/NqT66chdcD40xzJlyb2kg4S2v8ab4Nx5P0y5Y+KbTwWlSdFBRZnJaFdDI7YWk99yMBhmAkyfclA6kTihpT2E/z+Hyl5PO+Y7jVlblTeTkQ/s/a+tyaEHCe50mx3mYlmOIuH+QIDU3S6rsRH+I/kvcWGXyXCVFddJ+b3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/p+rk0BGYC0DgF53jOHSj9wrk5wufS85RPVfdOhWV7k=;
 b=EbssZ/WUIUzvmdn1qAHDEoomRDY+bp5wzhiTK6Fme5PiJBFx1/MEvtpgTCTW1DkOUrmUNt4jDKXmFjuQcvNYcgCH6kcrjIPymSr7N5texUtfKZH6+2rX2i+4RRK5sYyYjpdVRZgQRq5Np4l2l5qpan3dJhmrDFRscNLk7g14B8jggxtP4cEn4ssCTh1OgPZ/GaAB4tJtQfu0ITf7GW8BcFw+sEXbfGl8Pk6Z5sFQUjE3swp+n383xBA+wLZXQYJa5cY4ZmjavWMcMRjDwpK5DE88MeAVBkAiqoU3Fwv/EP7YJc5Z61tam3X1Naw+hwqNGdXbN85IVFWB/idlUWX73g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/p+rk0BGYC0DgF53jOHSj9wrk5wufS85RPVfdOhWV7k=;
 b=tLRoFjKVwgtXzTxGFIQkoW7Zn/0nSukWhHKlwi5WTDFyIMHjdx2xGyWINHx2gOjT+ueVuU2d/yC5rH0gDWpNp/u1OxoKgwJJv3jK/h0YePWN+rp2sq82kLsbaVVShVE96p43XZklVPvVpDe6lr6ke9EWgtVCuXtwUjMxJXuEbg8=
Received: from BN0PR08CA0029.namprd08.prod.outlook.com (2603:10b6:408:142::15)
 by MN0PR12MB6174.namprd12.prod.outlook.com (2603:10b6:208:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 06:18:40 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::ce) by BN0PR08CA0029.outlook.office365.com
 (2603:10b6:408:142::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18 via Frontend
 Transport; Thu, 21 Jul 2022 06:18:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 06:18:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 21 Jul
 2022 01:18:39 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Thu, 21 Jul 2022 01:18:30 -0500
From:   Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <vsujithkumar.reddy@amd.com>, <Vijendar.Mukunda@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <ssabakar@amd.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] ASoC: amd: acp: Add error handling cases
Date:   Thu, 21 Jul 2022 11:50:37 +0530
Message-ID: <20220721062043.3016985-5-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
References: <20220721062043.3016985-1-venkataprasad.potturu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db7fa325-035d-4875-a34c-08da6ae0da94
X-MS-TrafficTypeDiagnostic: MN0PR12MB6174:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygj2I0UUC6Ok80adDwG2nUytn8nFBVJwiwJHlM+0xx5QiBbUU0moQpzizM91ehiXjdm8xpAHza72pPTvaE59llRJXFlNlVz5zabxKJINCIN2Bih9wQvlYVDgKqzt7MCo7wtioWXr8Y8VJVprRmQYPZRXAJ+mS0T4Ymuxn66ZDv/WB6RS7aduFVTSYT1PN5DyDV6SviJJGU2kvepL/auqPMMTeCpQOHuskBnmrdskpuHDJuFdF8N7IBiqkZ9LJeffHJwCAnVphbVBwq8M7+Qb2LCPKhQQ/1BI9qASVJjLRmk+l1qg1Ddd/LGfWK2NykJ57Jza0Q5rofRhoEOwmI4pvyuqIBRAUUNO6of4qRdsrHM701a+ZmrvBnyMb9Oo0Dzph6k03dKWbSr0fsk8NScsbstHJxOy6DfmKUfGj6QYheTrbaBR1YZ4KNZ1DsJlelp9UmTkzyzRv1PQxQMw20AN6W6UoZyUQgGOaVZjtez6O06yQ52yV2zrYnmFlitqung+8up7qO+gRqphonahY1OK28Hfyg8GUT6eA/XUkzar/vfBQqrdAeZLZPf8SdDL42aZbsewRKu6k9o9TDnuQCq366lzGeRjoQk7lFjYdTTjwGyqmXkmJ5ca0NRHlKlc0JVMRtpC35QxJxiCgD5om8uuh/mz1jiMJqoA/euVZOlirfaOksYAJa7J6Sgh+rx7RuOcPgJU2CJjiPPPGkv1w4vYQJ2dLb68D4r9EMBnv2kEa7VXkBmrHqiKybqEl7FLCLFLcIXQuLYoMFKORN3N9GIgon6cEMHup+NdqSYkEHd19UQQp5EzpyEYtyqu3yRqG5f6QNS33/Z0X3sqG9ukYdQXuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(40470700004)(54906003)(110136005)(40460700003)(26005)(316002)(83380400001)(70206006)(70586007)(47076005)(336012)(8676002)(36860700001)(426003)(36756003)(86362001)(2906002)(82310400005)(40480700001)(186003)(2616005)(41300700001)(8936002)(7696005)(81166007)(4326008)(1076003)(5660300002)(356005)(82740400003)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 06:18:39.8114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db7fa325-035d-4875-a34c-08da6ae0da94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6174
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add error handling in acp pci driver probe function.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/acp/acp-pci.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/acp/acp-pci.c b/sound/soc/amd/acp/acp-pci.c
index 34d75603eea1..2c8e960cc9a6 100644
--- a/sound/soc/amd/acp/acp-pci.c
+++ b/sound/soc/amd/acp/acp-pci.c
@@ -70,7 +70,8 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 	ret = pci_request_regions(pci, "AMD ACP3x audio");
 	if (ret < 0) {
 		dev_err(&pci->dev, "pci_request_regions failed\n");
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto disable_pci;
 	}
 
 	pci_set_master(pci);
@@ -89,22 +90,29 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		break;
 	default:
 		dev_err(dev, "Unsupported device revision:0x%x\n", pci->revision);
-		return -EINVAL;
+		ret = -EINVAL;
+		goto release_regions;
 	}
 
 	dmic_dev = platform_device_register_data(dev, "dmic-codec", PLATFORM_DEVID_NONE, NULL, 0);
 	if (IS_ERR(dmic_dev)) {
 		dev_err(dev, "failed to create DMIC device\n");
-		return PTR_ERR(dmic_dev);
+		ret = PTR_ERR(dmic_dev);
+		goto release_regions;
 	}
 
 	addr = pci_resource_start(pci, 0);
 	chip->base = devm_ioremap(&pci->dev, addr, pci_resource_len(pci, 0));
+	if (!chip->base) {
+		ret = -ENOMEM;
+		goto release_regions;
+	}
 
 	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * num_res, GFP_KERNEL);
 	if (!res) {
 		platform_device_unregister(dmic_dev);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto release_regions;
 	}
 
 	for (i = 0; i < num_res; i++, res_acp++) {
@@ -133,8 +141,16 @@ static int acp_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id
 		dev_err(&pci->dev, "cannot register %s device\n", pdevinfo.name);
 		platform_device_unregister(dmic_dev);
 		ret = PTR_ERR(pdev);
+		goto release_regions;
 	}
 
+	return ret;
+
+release_regions:
+	pci_release_regions(pci);
+disable_pci:
+	pci_disable_device(pci);
+
 	return ret;
 };
 
-- 
2.25.1

