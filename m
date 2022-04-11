Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E9D4FBDA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 15:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346684AbiDKNsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 09:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346721AbiDKNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 09:47:37 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55C613DDC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 06:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoZbyfXSryiTATKYUEGCa7j7K4Rs0rtwNVZ5KTuq+ysoVX/RONHhFCxuKQMcgzWHB+TqYpLfLGDb4joRdWMJkLjdSPPWoAJgafrqIrsj4KGZLQlSwWlVIjLZU+V9kP04FqLWuePmYUk5sU9ctsB4UpOTIlnBwtBrHEylv86x+v8hgCg7zRt5q/uYI1MD2lpdSC9FNmgrdTEkHT2Z3toQjMK61y6GqpmQp3BL3nJS7bYJ3x8QVo8I7dLNbPQCFx/myS6hPVec2VHFU+diY7LBYQ1xmQa3sO/IP/T9qUKD+5MQ5hPTIu8FrcDqKaesklJSzOQmLP9PkrNIocEqELRUTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvLQymGLA9IKpWZj6MYe7GrfQ54t8h2BDCAITOkzCWQ=;
 b=e2xERpRKrZ3T77z5IvNj81YIuKq3Hqjo6wjNV5vs/ueiS7isrzl/JkTlHWGgwCgHwhp23TqxkZ3aokqmJzAC+YJv6UxEQhMbuZ62WWiJsJunhwKfYFyZLdr6C4LtvokSaUgShAKgR7t9uAzgTaGQCvkrsU3kqB2jYC1D6ck1xVhur9Txk8xKfd4RTmnFEcCDF4knluV11tEVupDk3hAKBZn8D6T1JjvlFNBKEqnkhJoPrjQYTUeD/sDbAB5CLN6To0sKIHzX+s5PmgbkwgVg4EhnSmljrU5bUgZ7A0eu2C98ihtayyGqjfcSMV2+J8qxhfO82aD8mDJ93F0xVzuLdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvLQymGLA9IKpWZj6MYe7GrfQ54t8h2BDCAITOkzCWQ=;
 b=lnqNqE0X4GZqvaPx5qIgMCK8jGrjmU+CjHb+g7/Q3hgwteUCWdpFcf9xzWH6dbpT9IAnoodrdbcQOylOeuIv/25OiYKuyi5nGfSagbdCpL1mKKgTnW2+gXCHJOrUvq7HeAj8mJAjrB/9zki0+IXB5dfU0BqC+1mzOPSLT8yG8Tc=
Received: from MW2PR16CA0002.namprd16.prod.outlook.com (2603:10b6:907::15) by
 BN8PR12MB4771.namprd12.prod.outlook.com (2603:10b6:408:a5::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.29; Mon, 11 Apr 2022 13:45:17 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::c5) by MW2PR16CA0002.outlook.office365.com
 (2603:10b6:907::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 13:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 13:45:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 11 Apr
 2022 08:45:15 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
CC:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] ASoC: amd: Add driver data to acp6x machine driver
Date:   Mon, 11 Apr 2022 08:45:31 -0500
Message-ID: <20220411134532.13538-2-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51e69060-e45d-48ce-1ec7-08da1bc18384
X-MS-TrafficTypeDiagnostic: BN8PR12MB4771:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB47710FAABEE01A68D7E075EFE2EA9@BN8PR12MB4771.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IH9P6tZiDW3q6gm+qwxAN8UYh7EFOsdWlprVwpYVjr+ijQJ3en/rS1qyaZt4Qzxa76P0Tm7pEUMZxXeP2MSidXH01A5oZjjQRrelWWcx9uocXPpP2JaJ7FXlzQWgenf9YRlRwF2Ykd1tN7Lt8vF550XTy98Kqm91X+etX0QrZOI4xirEzzTWzu0ccS4aHn1uY0YF2EA+VqXI3Uf/3JTXwMKvPa7AWVzdvWOJlknjx26lKn77v51Cw20PC5OvsIIROXRjh+v/Xzs+CigowkYjEyPxrrMF0wxdM+Wujpz5MKznk4SR/WVV9MhwObAcIdAlpTFqMYZ0KGazlnrFZ3+YosUjG0iVC/lFA3Io/sWCgJfht0EbUwMRRQL3iypazMySpczVZr7ts79mrqnuYtwx5UK1arA8QSgeF5iv6j/XzKmLdhktIu0h4I3tFvBlyc2xBytiW6EG8KuB+tL1LPcbo+5gLSxsIysBo3HfselwZKPXrNYSLsjIbWhUMoIzLVmFQPDgR7qvswkPhYuU0VbsAy0b2VA5YmdmIOZAUctylCW8Q/XB3LwN0nGL6YiKCCyxTQx5JtTa6cI/GpssVSHdTe7G7W+k8oZ5EZ/9bsp+qKha85H8ueb0OE2BsaGNKlKIIAMCH2pZsdkk0QzaW6BgRvj3nQlMTIEZ+oRA3PSQjIiSp9HXYPIFitN4elDsaTArKCamyVmQTS9a2QUlNOcJMqJPAqZRqZecCSudjeqtXBQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(356005)(81166007)(5660300002)(1076003)(26005)(86362001)(40460700003)(316002)(508600001)(110136005)(7696005)(54906003)(2906002)(6666004)(2616005)(336012)(4326008)(44832011)(36756003)(426003)(82310400005)(47076005)(8676002)(70206006)(70586007)(83380400001)(8936002)(16526019)(186003)(36860700001)(32563001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 13:45:17.3583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e69060-e45d-48ce-1ec7-08da1bc18384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4771
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently all of the quirked systems use the same card and so the
DMI quirk list doesn't contain driver data.

Add driver data to these quirks and then check the data was present
or not.  This will allow potentially setting quirks for systems with
faulty firmware that claims to have a DMIC but doesn't really.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 9a767f47b89f..959b70e8baf2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -45,108 +45,126 @@ static struct snd_soc_card acp6x_card = {
 
 static const struct dmi_system_id yc_acp_quirk_table[] = {
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D2"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D3"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D4"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D5"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CF"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CG"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CQ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CR"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21AW"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21AX"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21BN"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21BQ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CH"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CJ"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CK"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D8"),
 		}
 	},
 	{
+		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "21D9"),
@@ -157,18 +175,21 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 
 static int acp6x_probe(struct platform_device *pdev)
 {
+	const struct dmi_system_id *dmi_id;
 	struct acp6x_pdm *machine = NULL;
 	struct snd_soc_card *card;
 	int ret;
-	const struct dmi_system_id *dmi_id;
 
+	/* check for any DMI overrides */
 	dmi_id = dmi_first_match(yc_acp_quirk_table);
-	if (!dmi_id)
+	if (dmi_id)
+		platform_set_drvdata(pdev, dmi_id->driver_data);
+
+	card = platform_get_drvdata(pdev);
+	if (!card)
 		return -ENODEV;
-	card = &acp6x_card;
 	acp6x_card.dev = &pdev->dev;
 
-	platform_set_drvdata(pdev, card);
 	snd_soc_card_set_drvdata(card, machine);
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
-- 
2.34.1

