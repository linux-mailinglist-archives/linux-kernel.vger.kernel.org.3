Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7075A587713
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiHBG0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiHBG0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:26:40 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FFBB1E9
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 23:26:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0zSOOLYJxq0dyQpnIdYXUVKxjZYbHJtk8OFTiCipJyOAdqCYn2VfY/9tZGAMTh2NGHgZPUKLYkkZNke5BqXhmQ1q4A3tc8bQRVqP4Luhr3iq4hp8n1Zpd5/nOePL1fVwjceN4pTQUAnuTfVDX0lfWHAaqeeIG7CwSAFJM9upxvz6+WFkykcCHfHuqfvQ98ed/+ZpNGVdZVEFVwMo02o8S9X1nS9oBFLFKkXpPdY85pk4I03qKHcOiwoVo1i7Qwj9SYXQumcJOTmhlyBjjzzWmFtmdyXrAKC7DFn0TRAXHGb2oqaWkBon13tStHv/06WWd2w8xGYUTLKVAnVA5Kjzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lNYwRT0HOV1T+ruOorfnkMTeOju96NR6FLGLzAYxlI=;
 b=TiCcy7H2/CqM2zw4tcjOiX7FwYoDoW4ozqq3opkTq9B9jOPyyktDqnmbU5F83GjBnegsOJFORk8TElwIimwW/BCMSCuhwa0Wjn02bDwaMGijHFmTzJO3paMYDP0IT0NbMA3ewzw3tUCJaXDzKbU3Dpr9gnQz+4SPta2olYgeiNpffL6krk6QqGxJCJKiX8WnFyaDJPKjobHf/TkvEOfUf8hhZVl1RnIXvP0VT+c5lKKOh2MqpzX3auRD3G8VC4dz6Z4jnKD/SPaVbP62o/SGsLDsw33iQpbBWv7WFLoGHQs2Qd5JQp4DrkrxNvaR+8xguv/C5WP2eL59MafrhOXUTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lNYwRT0HOV1T+ruOorfnkMTeOju96NR6FLGLzAYxlI=;
 b=GJqZpdihgmzAnXhMbfwHQq9G4FP5HDxlnIRLqF0iVsqngD/Sq/fZYU/tVMJqT6AUVjOzB1rQH/+DLWeVVamX24CGzKdIyl27w9KtvvyDsqFI5AMeV3WusqFVkaWKeRN6F7E1Ocs0Wt9BTuam0KuonVF3D5JQRxqvUZn2h+SuuRs=
Received: from DM6PR21CA0023.namprd21.prod.outlook.com (2603:10b6:5:174::33)
 by BY5PR12MB3937.namprd12.prod.outlook.com (2603:10b6:a03:194::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 06:26:36 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::95) by DM6PR21CA0023.outlook.office365.com
 (2603:10b6:5:174::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.4 via Frontend
 Transport; Tue, 2 Aug 2022 06:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 06:26:35 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 2 Aug
 2022 01:26:34 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 1 Aug
 2022 23:26:29 -0700
Received: from amd-Z97X-UD7-TH.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 2 Aug 2022 01:26:25 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        syed sabakareem <Syed.SabaKareem@amd.com>,
        Pananchikkal Renjith <renjith.pananchikkal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: yc: Update DMI table entries for AMD platforms
Date:   Tue, 2 Aug 2022 11:55:00 +0530
Message-ID: <20220802062503.159328-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ad7e505-2ec9-4905-01d2-08da744ff303
X-MS-TrafficTypeDiagnostic: BY5PR12MB3937:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y53bcyj0XQ6uJwYGK7ydZjxqd04J+d3dFqZnh8ftF++nwovfTiMNeqt85OfKypGKi84nx7dFVUGKZmPA3q7bPXghDi1IpK4nz8z6UIf6mN7z+CqMu4hKJVqGMv+Ico/sPh7sd1sjx55T/dhvzPUYzrIpgB3gIiZ6FveeGaCQQZHYUdEbJqwutI2s0H9bNhS3i3CVQOOspcRZdTCQu57FpBbnwpL59R0xYkvFs8CsZiq7qvD7us1TjMPrmDMhDicVE64SRecAV8fIXv9DRfPDYmx/ni7XCL9iYWdV6LgiPl1BzE76Z/64aWp57aCRp50u3+XdfHZb0/d96LpqZsLBPcRQ6Njcaq3MQ7D4g9Be9SCK2TKNvRSx5Yy5hDeyfNSZ5RPX1jMgDf2flVvae8RlFSgcaoEkPwYjMvQuTXLF7+1iYQV6q77tK9C1UY+5A/BPRzoMy72EzT929xUVN/3/cUieEZRFU/PdM6zqX9Wlt8YvMnSbDF7Pcx12+zw1woFuqH4cfK1ASK0iQcOk/YqEr5P/iDNu3QSX70UtXTTPc+MxI+Gm3M0EQs3qNn5KO3U8Npe+gG0wYLmRanS7t0MvxAhuZWIw1Gswho9aClqcwDoV02Cw7czQdhp5Q8epktInhEgoUhiSACOHsXEEaoYbeXZikeQedkZlFCNXjlk1MojhQVr0eWWA6irpIZDkiV/eZnY+dXhXBoppKIEZ/gOgNAGeh6AiTcHoNwg8UIEAfy4gzQIlfFCPV8baEo3lTaHfcTEfkPs+D9Ly311G14XaI/2B/esUx9+Hk9L7LwATPLDnd7GA6j7du2buxjJ/CPMoz4PI65e9hItctIMHtNp9/k8P+3Zk8h5uugJKuVAvQjXM5l/zqkgYHXFAlsKbgG59
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(396003)(346002)(46966006)(36840700001)(40470700004)(36860700001)(6666004)(316002)(83380400001)(2906002)(15650500001)(41300700001)(40480700001)(8936002)(86362001)(70206006)(70586007)(478600001)(4326008)(8676002)(966005)(5660300002)(40460700003)(356005)(82740400003)(82310400005)(81166007)(47076005)(426003)(1076003)(7696005)(2616005)(186003)(36756003)(336012)(26005)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:26:35.3708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad7e505-2ec9-4905-01d2-08da744ff303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: syed sabakareem <Syed.SabaKareem@amd.com>

Updated DMI entries 21EM, 21EN, 21J5 and 21J6 for
AMD platforms P15v Gen 3 and P14s Gen 3.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216267
Signed-off-by: syed saba kareem <Syed.SabaKareem@amd.com>
Reported-by: Pananchikkal Renjith <renjith.pananchikkal@amd.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index ecfe7a790790..e0b24e1daef3 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -143,6 +143,34 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EM"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EN"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J5"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J6"),
+		}
+	},
 	{}
 };
 
-- 
2.25.1

