Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFD94FBDAB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiDKNsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346683AbiDKNsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:48:04 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AB11401E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mpsmYnPJMcipXK1cE2FECzjKmUufFrOj3XEEPqirqqkYg/h2SUET7DqULLnzD7qU/qZGjxh/U6paxhJmxKtJndS3GzF4iRqEYoDLQsDPBg+CjAMasMqg6ga+c7TjmSniIWtmnpPd1p/8FPyk/7EIw3HuAGpvhXbI+K/XfomA7Wm3rPg1nuU3bwC0UOUK+Wre+nrlBebLGRZIIoItOwqU47bmSF1F9zzQRqvSBNVTFZq0MUNxrEk2uiRIXsvi2OSAJiMUV46S8QYLNtzVBa+L+PG6AiYMLfhXpoadaw/BAG5DPkc/Un8k08OuH/VqEsi3Yw6GvZnfeqI/k9OkdlN09g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okp9xA5U1pR6WHvK1mRrAkptRPI1Y6gf6yo421lNJ8g=;
 b=fd2HRYkFatR1Z5szNIykMLUgH7dCjWpdRP4ErTX7K+IqoR9e6aROrSMNcn+hG6x6SzlydDLmcsnKWm8slEeuicse0+2vV2d+P4uQztyXaYNCfr21l51WK+3D1SyQV/yqqSgH/RMoma/1UNMW87Jxl2fdnxbGOCP97EzZelOYI3QN0nVC6lQOkS1juF9kfGMnv9GydGgTXRnwQpUuUOn776MfatILvfPcy96KMw3vzu0T5mME356l9q1Jh3rJ3MV1D0IOOAYTowpm6dMFGew5sdz6oz73eiHbi1pOOuRHVOpEw0UqlO2dJpX/ZOzJGTDKP9qRlYo7ZcrAXrpSewwGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okp9xA5U1pR6WHvK1mRrAkptRPI1Y6gf6yo421lNJ8g=;
 b=jB6e2A5IHjByv8MfCSauk6zUpQdDbVnRDiW9HfF+fvK0Yugbn0I6P6GK/sAZTKItCIkulSPfMic215vZ6ZzeAdCdDFSfZNMQvZ+9NvVRIEQ0MG3iy6MNfnksJFtAxxSfv80jrMaqwaKGZoZJsFEZsIS4G07i8w64PnbbEpep+/E=
Received: from BN8PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:70::48)
 by PH0PR12MB5436.namprd12.prod.outlook.com (2603:10b6:510:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:45:46 +0000
Received: from BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::2a) by BN8PR04CA0035.outlook.office365.com
 (2603:10b6:408:70::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 13:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT060.mail.protection.outlook.com (10.13.177.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:45:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:45:44 -0500
Received: from vijendar-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.24
 via Frontend Transport; Mon, 11 Apr 2022 08:45:40 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Alexander.Deucher@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <Mario.Limonciello@amd.com>,
        <Richard.Gong@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: add new YC platform varaint support
Date:   Mon, 11 Apr 2022 19:11:15 +0530
Message-ID: <20220411134119.1767646-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b751265-737e-4cfa-757d-08da1bc19485
X-MS-TrafficTypeDiagnostic: PH0PR12MB5436:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54365344EDAA680E9CF8C38297EA9@PH0PR12MB5436.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngmr+Q5iD/iihy2TbacKIcaREkKqWpWIdYbGOhNnQqG07CxZ6eP7hiCDRwX8UslRkSkYGg72VqcJWTG3sgw9GAwq6TlKJnuhobfxTYHdu18hVp6kgpfEZtMCoNoEnNLqjFkFcqT4kZQQiq45xBq6RzEkTVMzlPzNLF09vB5tZ7d6pDzTG4AFF2htq1UZXe7h4wfRPvJXVKeKAotPF1mAHEB/jTVH5JfxLv/9l9W2EQqQRuB/cANzq4xgLeu7QVw+7QeUQLdp5/sBKKhiCp2aJd8umyU3c373StAuofVHt4oGGKJj31HJaJq4c0/8/Zs8xqieeAo5jMYA85oik0aBaAezqAHvhGnIiBiTLebg69diVwGNwOJG6QkMRN5eEFXViWtSHc3+vb3412BrzcDRaEhZH1NBTny1Sg0B816OVKxduqwxVigDBAGM0XoSuAIL6C63fdxEj0KSanXeSxgJAsQy696pixFSJwcs8wRYhsjvgFIupD/MAoBPq0Dgza6jJIfsJ3k8FabzldApPuxL0GtqeUjLDYQbYDlOGOo6wJo5v10dpRuFzB2R0KypMdXcf2kjNaoqAzdhdiHzeuJWS1Nfkw83Sq8jciM6zYxHeIIAe7LWPR+nuYTXqJaTo75qF6FnTrkX2cQolzcQHJr8/O4qQrUrqtM/kKnxCN3pk2yMOEtJS6mhxBgyoywUd7xGsZyXD25ODWXwdqG5/lk88Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36860700001)(26005)(2906002)(186003)(82310400005)(336012)(70206006)(83380400001)(86362001)(47076005)(8676002)(36756003)(40460700003)(70586007)(426003)(1076003)(81166007)(2616005)(356005)(508600001)(316002)(54906003)(110136005)(5660300002)(8936002)(7696005)(6666004)(4744005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:45:46.0133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b751265-737e-4cfa-757d-08da1bc19485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5436
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update PCI revision id check for the new YC platform varaint.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/yc/pci-acp6x.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 7e9a9a9d8ddd..20f7a99783f2 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -154,9 +154,14 @@ static int snd_acp6x_probe(struct pci_dev *pci,
 
 	irqflags = IRQF_SHARED;
 	/* Yellow Carp device check */
-	if (pci->revision != 0x60)
+	switch (pci->revision) {
+	case 0x60:
+	case 0x6f:
+		break;
+	default:
+		dev_err(&pci->dev, "acp6x pci device not found\n");
 		return -ENODEV;
-
+	}
 	if (pci_enable_device(pci)) {
 		dev_err(&pci->dev, "pci_enable_device failed\n");
 		return -ENODEV;
-- 
2.25.1

