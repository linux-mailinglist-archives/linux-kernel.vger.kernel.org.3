Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C455A20FA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiHZGka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 02:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245032AbiHZGkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 02:40:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91E19DF9E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 23:40:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jzj/PbrR50Q3Xp8sDQH3JpCUYgAxT4l5trXcq17RqNskcMYovyVWdzKLT4OifPpRgPYsBbNWh80nk0G2Z5Gi0XiIK+fnS/Z+LBZVL8D1NvIbf9gtjtLcHko6XlP/vMvqUYxQTACw3CGk2/KDueiYE1i+wWqxF68gfPeSdCDD0tduoxTuLlQr9bm6D/0CEwZmJLGsEeN6EibSaSZa+N3ayPJSJ+Cg/JPSsv6umH3zNWZ4MjeadOUKIZaQ6oMuKtDQqFvJxjJ4+uOPYItefQcU5y89KSkTqKQZdAmh8ubjp8DeVWLZhxpzsJTl7XSPBIBUJ+eBkCO7bdcidUPkC6jm2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFOYWb4We7sRfIsKV+ibIkuDuCguNLOo2k4pv2Nm58Q=;
 b=KnlWq+dulnw8+u9A2egDM8o6niugsYZhP3vlZgIeirEuO4AzMovKj6hIyQ7nGHYV0CxUbx6nBteflEV6iozPvlIOfKovghy34tjDjvHfBXc+dwg7dYNYToL8PfNhClG1lEaYQwzlX0LxosDidqROStA+EZAYiH9k3DRXlkoFeds1Y36kDth4Do64IrTnZGJ66pRiW61xSnmoNidJnHya0WRdaEzeL3TN3ht1Kl4OLs+m9cMRKjK3MQCjaCboDWr1lbCgd0JfW3pgvjOeohmbgvL05d3w4ujKMiHgNcGggIx178nmsNPm9mGPAf5cjo8j6sOL2zw6P/zEaso6rkioKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFOYWb4We7sRfIsKV+ibIkuDuCguNLOo2k4pv2Nm58Q=;
 b=TY7X0Cf0mmrS+8zIA0r8mjXcvU4HSHh5aUSIbw1bJ0t8fBZkyR+qQ9RlYxlvxNNMWMfsAj+1pfg2h3n89jajHRm7vOgRCi2PK2JHqvt0B1K7BBF34750nseS0NC/6BCzRV6ojqJPA2DjlTUG1WsiX5Z3MCIZG46gLH9B9Ogasms=
Received: from DS7PR06CA0033.namprd06.prod.outlook.com (2603:10b6:8:54::15) by
 CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Fri, 26 Aug 2022 06:40:17 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::a) by DS7PR06CA0033.outlook.office365.com
 (2603:10b6:8:54::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Fri, 26 Aug 2022 06:40:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.14 via Frontend Transport; Fri, 26 Aug 2022 06:40:16 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 01:40:15 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 26 Aug
 2022 01:40:04 -0500
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Fri, 26 Aug 2022 01:39:55 -0500
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
Subject: [RESEND v2] ASoC: amd: acp: Modify dai_id macros to be more generic
Date:   Fri, 26 Aug 2022 12:12:45 +0530
Message-ID: <20220826064250.3302260-1-venkataprasad.potturu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4848c9a-f3e2-44bd-6a44-08da872dd671
X-MS-TrafficTypeDiagnostic: CH2PR12MB4070:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dKW+l0PTfMmjDtwLVyZpC9iqM+7mOkcX1mgIR5aQ6lckG3P4Xe/1QQalwFq7Vtmo0kUqB2JXiKs/Wir2rlmOwW8QuXZv5K/jfOSCGpcyqYZpfP4PVrG3w/yJa5pyvBLi1kixLlm3fq7Ysa2Fo/EEmxQjBGSThzzlFOHNMzRyGje4h11ANBL0BC34XXp+WFSGzwf5ZVV52WeUhAgv794Av9w1uNeittA5QCqzkNNHFeE6HeyR7ALkmmQOg82VqcxQrcgIirpk5CmFSQYVh2lSB0OSiiN4kttBrlTPvOpol1IxbQYxddiHwXUgeIQYHPnAJIUOgMSDF1eG0s3TgdpGFpcptXg9Le+r5pYkGkZ5kuIOthIrc2yji5Z9q32deb3WqkS2v8UQ9AzDINQx7434sE/HahzJYkW+fGBbv8i7vsovzycXpfvTsLf3FzXQK/qALxdCyhbYf8GJ18QZ9k0RVAhfa2VFKOFdHQVytVldPhzEFKeg9cpk1JfaW30RwL8BhtXFTHYknbaOMzTTZlCezac47EMZU2qlB6D9FycFKiLoFqDFGsIyC3kPSvCtYC20iQZtxTYRE6M6hJyLdpplfUoeeoiLhl+zZwIajAwzmBBu0b9OkwYRTPa1A40Bt/DBA4tGWK1cc6hcqWh4iAFtUh2v9MJFrDsxSsHfnKlnXakjqLE50cfMdY9VA9SfJDmlHHWjOZG8x61xprlsf8MSvC4CK2cLLgXU6Rbht+5fBojI8B4K4zlWr72+s8+55f3nRqZURH2H3c5ltG2dRYBb3+zixqrma5SyfmlWv0mWnBLmJchpes3g3zRnSFJEh3wxyxKi6MGNkpobWRv7FaxdYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(86362001)(4744005)(5660300002)(2616005)(6666004)(41300700001)(7696005)(4326008)(8676002)(70586007)(70206006)(40460700003)(478600001)(40480700001)(36860700001)(186003)(83380400001)(426003)(336012)(47076005)(1076003)(26005)(81166007)(356005)(2906002)(8936002)(82740400003)(82310400005)(316002)(36756003)(110136005)(54906003)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 06:40:16.6131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4848c9a-f3e2-44bd-6a44-08da872dd671
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change dai_id macros to make I2S instances in order.

Signed-off-by: Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
---
 sound/soc/amd/acp/amd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index af9603724a68..60a7c95f134f 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -21,9 +21,9 @@
 #define ACP3X_DEV			3
 #define ACP6X_DEV			6
 
-#define I2S_SP_INSTANCE			0x00
-#define I2S_BT_INSTANCE			0x01
-#define DMIC_INSTANCE			0x02
+#define DMIC_INSTANCE			0x00
+#define I2S_SP_INSTANCE			0x01
+#define I2S_BT_INSTANCE			0x02
 #define I2S_HS_INSTANCE			0x03
 
 #define MEM_WINDOW_START		0x4080000
-- 
2.25.1

