Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D6D4FBDA7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346692AbiDKNsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346727AbiDKNri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:47:38 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD5C12622
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R775j2g95y/zQoB7q8Ft4PSSndRZuRlr8XplAQuCO6W1QK5shNpszKtdI5SBspsqjdDK64934EoBOhyvrpK8e+FIPPvMg5KJppvrwXLoyKsEnsTDSaSo6nghL1lAX3zMiMyfVN5Ryig/UAbWuXL4xn9T0x5Hoc61o2bnEklXu7JrWHaYJZNXuiKqTrxesiHt8YnxPJCOHeyutPekkDUpP8F566ML/uMcpQvlXEJ+K5E49viHhYMRnaWUK4M6X9HDmGBhNQJtz9BLWK0+7ZXE+fmg/kZRDrmzVJQUXFZJj0zyrw/m2CUY6UROgou3g5RbeUjYHHjIJ8i2nKCkGmcsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9MquOv/ee4K45MQQQHs0409tnPKYdvItVoSqTwKB/Q=;
 b=YaeQ39fkfQRo4xE0wcQ9nbcxW19vkT0B4uE6oEnvG30qKeEeF5IXfSugfuIdpSqfIeNcd4DCX89uVtmTX7jTfptQ0sEUYPCkutuTzg3R3CuZEXlALbfRNjAWNm+9KZIBr8Zd0BM6VJYVrBfeENdWDgj91t6H0qC2cg+iuvLdgfhL5oBpbqIy8nAIuZI34k/hV4P3l6sfgeHXLHOYMf/Wd6mPylpTJx1Zk3FpABOsoX02+sb0csUyZRyDpT1Es5Zi8/uL3St4gbA6DxwBcRZAhWN33Ppq4Hnz8u8kFQUm6rIpi3sfCljqM8IvXz1zAI3v4OLfKklYp/ldgM/pn/PTlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9MquOv/ee4K45MQQQHs0409tnPKYdvItVoSqTwKB/Q=;
 b=YAT95n2M3T12ZoHr42rRr9kNmEfRD0PdYcCeSnJymRpguY7l3R+uVjc4NUK+j1YXNrAvAv/7/cxTXQrRCXxhaoUUvCinILvR1apBhrYwCAQsGQBdrs/j8ynu50bLK+YvfCeJnG+0aUMg/jGt8fCuOe/QQUG57bkF8ZrwibXQgDc=
Received: from MW2PR16CA0001.namprd16.prod.outlook.com (2603:10b6:907::14) by
 MN2PR12MB4469.namprd12.prod.outlook.com (2603:10b6:208:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 13:45:18 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::53) by MW2PR16CA0001.outlook.office365.com
 (2603:10b6:907::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 13:45:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:45:18 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:45:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
CC:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2]  ASoC: amd: Add support for enabling DMIC on acp6x via _DSD
Date:   Mon, 11 Apr 2022 08:45:32 -0500
Message-ID: <20220411134532.13538-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411134532.13538-1-mario.limonciello@amd.com>
References: <20220411134532.13538-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44b9be03-2805-4d20-792a-08da1bc18402
X-MS-TrafficTypeDiagnostic: MN2PR12MB4469:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4469085F78259EC429B3DB9CE2EA9@MN2PR12MB4469.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sl4XoV2bba5rflRjAloj3vS3HlFE1dhzUa7ugG875u68j4vMJIk6MrWtC5MZ1ZQLIbq6merlrLlv786jAnAKsdfi29gpjs4EM40JN+fBfUx9ut1HTohJOFRuOzbmQfB90K2e8kPfFfIzvFdD8eclnjHlXJ9DQzNCLsmY724ndfRIuC6MmOrY92Lk+ImxI8dhtENeCXkKnmEEjtDLtkxmdN0rcF7XrvbVfBn50x6YXD/x6ZYWMCTCu9Pvw6QoOaZB2H91RmH3KgI3CGtSXttj4hJsfBS9H2y3Zz1Hdx+nIBev0zv1nsgpGXr4DI25mo3H9uuLMLDPdpSszaFTdynhozK5DSPGp0mjIr/Yz4jfxUFl7Xpv07DRjHyjunHUCumgaXNXwkRLq1lshdqr7PjxQjdDdixdfoExIPQuZAq5gL90hp/d7JXuJkhYWyqTZ2btiW0IvYHOdhvlqy99U8yg0W5y4SyS5AZcQIfjPayEeVP+WikkpjSQrXbt8xVMRzfKQnqbcUNpgNZ3Ufb0J0fXCi9pp2vIsgZDIhFY+CCCrKdq+Ng1RtS/FbG2Yg4fvX9cJ3EOaJwmZcRLPvs+zfRhUkbG/m0m7qeErzBYI92O7YqIV2pVlSBsrHl+c3ug2nzI8FYoBq7w2fnOA1KhjKweiP3DuL2k6Swx89MaYBL+cdYSB8VlP/DUPolU3R9YTxjM3iviVWhjcTgKho9J+NHcS72ZR721MMeRACRf/wNZodw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(356005)(5660300002)(40460700003)(82310400005)(70586007)(110136005)(70206006)(54906003)(8676002)(508600001)(81166007)(4326008)(426003)(44832011)(316002)(1076003)(2616005)(2906002)(336012)(36860700001)(186003)(16526019)(26005)(47076005)(86362001)(6666004)(7696005)(36756003)(8936002)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:45:18.1864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b9be03-2805-4d20-792a-08da1bc18402
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the acp6x machine driver requires a hardcoded list of systems
that physically have DMIC connected.

To avoid having to continually add to an evergrowing list of systems add
support for a _DSD that can advertise this.

OEMs can add this _DSD to their BIOS under the ACP device to automatically
add the device to this driver without requiring any driver modifications.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 959b70e8baf2..f06e6c1a7799 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -12,6 +12,7 @@
 #include <sound/pcm_params.h>
 #include <linux/io.h>
 #include <linux/dmi.h>
+#include <linux/acpi.h>
 
 #include "acp6x.h"
 
@@ -178,8 +179,19 @@ static int acp6x_probe(struct platform_device *pdev)
 	const struct dmi_system_id *dmi_id;
 	struct acp6x_pdm *machine = NULL;
 	struct snd_soc_card *card;
+	struct acpi_device *adev;
 	int ret;
 
+	/* check the parent device's firmware node has _DSD or not */
+	adev = ACPI_COMPANION(pdev->dev.parent);
+	if (adev) {
+		const union acpi_object *obj;
+
+		if (!acpi_dev_get_property(adev, "AcpDmicConnected", ACPI_TYPE_INTEGER, &obj) &&
+		    obj->integer.value == 1)
+			platform_set_drvdata(pdev, &acp6x_card);
+	}
+
 	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
 	if (dmi_id)
@@ -188,6 +200,7 @@ static int acp6x_probe(struct platform_device *pdev)
 	card = platform_get_drvdata(pdev);
 	if (!card)
 		return -ENODEV;
+	dev_info(&pdev->dev, "Enabling ACP DMIC support via %s", dmi_id ? "DMI" : "ACPI");
 	acp6x_card.dev = &pdev->dev;
 
 	snd_soc_card_set_drvdata(card, machine);
-- 
2.34.1

