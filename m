Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074DC5852CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 17:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiG2PhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 11:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiG2Pg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 11:36:58 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060d.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::60d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51F487236;
        Fri, 29 Jul 2022 08:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Je/PiDbTJg0oOe1MPwO9bJK2y8V3r4VFnX7sDtSFAOFfQY9TuAy+ZpPDdd+C1zQ9c1M0dB/l8lt5dluyfRS+HNTXTc+wCehTRyIngp4tS6RQomIKbHl6Y1ssWCiGSNcRKbErCQox+x487YFNtUHDSYTWFNv1rhpMXC1I89e3ylHvKPll/Vrp1nMUtXq79Ju5VGb9cNh8vVK97Im3B2BmqVUrkBjIT4vw+FnBDYivrGJjVQh3J52rIvA8pjP8yuRf0VUkeUxFJKA2JO2MogJJZKDzHW5n46+2V+g2KlVyU84DqhpBZzOpTtrJE/ua/NaJ9cesfr205qoBvY4rzUpxIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1N/7/XvPykj/YHjS0eRexhoibRmT1bwQEg8OR9IPb5E=;
 b=iYXtxMSPeD8gM5DG2graJuH2LDXS4JMe2SFPJs37zZOEZ4L0K4qmWjqab0RWbsRcCBMaSi3TnwmNYtMNTPkYVueWULn7XuIk9gWV7YlG1WtSdGvY0xB2z6ox2bE5uLSipXheDhrq0FKvOA/O22m+APSAKZdaZ02/wqVracPIDhWq6VS3VILEHZ+91/sdBNmpSwiw3LOJf9x51dZ3Wys6OH06c/oEkIXVWSxw2mBcounhxTDQLuiM6u2OnqzD017EXEit/6v/8KNjVbK89/4Tz5ZY69kuUrf7mz37CqCeNrODuQVJUWQOh5gXP5h06CLIFUn043O8YXnEUVfuTyluMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1N/7/XvPykj/YHjS0eRexhoibRmT1bwQEg8OR9IPb5E=;
 b=HH1F1H1CkzT4nWV/ftdMK+9yovbYfV+MWC869ix+uoI8Z5wTNGtYtYwo0JENTrAsb07+Gif8Nm9AZVkXcpTkZE1FSHxJk8C2TiQp+o0r5TkHBSXM8rgJIc3w3CIre0Z5XS+ZxG1Ok2XOhBf7W6nDuJPclqBWm1iCxLM0V3+ylW0=
Received: from DS7PR05CA0013.namprd05.prod.outlook.com (2603:10b6:5:3b9::18)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 29 Jul
 2022 15:36:49 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::c2) by DS7PR05CA0013.outlook.office365.com
 (2603:10b6:5:3b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.1 via Frontend
 Transport; Fri, 29 Jul 2022 15:36:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5482.10 via Frontend Transport; Fri, 29 Jul 2022 15:36:33 +0000
Received: from ethanolx5619host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 29 Jul
 2022 10:36:18 -0500
From:   Jay Lu <jaylu102@amd.com>
To:     <jaylu102@amd.com>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <james.morse@arm.com>,
        <tony.luck@intel.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <jarkko@kernel.org>,
        <xueshuai@linux.alibaba.com>
CC:     <terry.bowman@amd.com>, <yazen.ghannam@amd.com>,
        <smita.koralahallichannabasappa@amd.com>, <robert.richter@amd.com>,
        <linux-acpi@vger.kernel.org>, <jayakumar.govindankalivu@amd.com>
Subject: [PATCH 2/3] ACPI, APEI, EINJ: Refactor available_error_type_show
Date:   Fri, 29 Jul 2022 10:35:49 -0500
Message-ID: <20220729153550.181209-3-jaylu102@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220729153550.181209-1-jaylu102@amd.com>
References: <20220729153550.181209-1-jaylu102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f15713a-ac99-4c24-d770-08da71781e1f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GDruPMef7Kd40odrEdxGUcpOOFIUCprUeqLkn2o6qPDcfnhRIATFalwNqY29WUZg2SWiahODsqAkcSOECuyUin+yu8uzmpAOKp0wlyYCQ01R6E77vs8d0cxZBQQfEga+IYXKudIe1lxnh4F3YWxm6aagki8GfVDPJ7VX1G31JDEO4eEI81/XXm/zGmqw9w1tqXmFITpEv5J07E/oynmzu1+y+OCrvx+BsF5bB9knJplBdzu0R6MtV8RlItlDS8mDCHtvRBqQrGfBaueQoVHXvXp08c8Il+oC2fAn2FlILKgFUvaxoWipWDA8DSeuDTolxzJILiXlkOaD80CnvCTLVAwYeHBY3MNXJ9M1JnBuuMK88pUo0Lh2xjz4xkH15aSHe/xmIBnwNAE/SBu0oM8rleuz+RPwwf4ZMwNYoe9PRuInj/r5Vr2hlre9ffsozQZop6D/1aVhT6EuT42kudLjSxRW5wcRM+Vlz8HFsfYeMFWbed3m1ZoUhwVkQ4xjeHmdaZYJLy46KGb2oPT6eG2Egcm/ifkptFZFiqLbK467/q0EBUeWs7euwz0BevHhc9c94s5Wxr+1TYCGjO37LMngCpaQo1DAPW+5ToARaAs/nIJSVKDxAJdUHt2ky7msXlEP+uMlSLEv9A132grl2AvkxtmgUmAu2Dd8nPMSsru593CSjJxKpT3r2frm18gdKtRl6UcpQuml1fCMI74sNLUix688Fc9y+m19UCbNF79ESrn660iyW3zHv5qg9cFAAjGcF0WT+6T0Z0zl7idnLwxIpPn7JV3let6eSC6fxlBp1JLk/Nwq1ONfjHByRS9844zLIQd5X5Iqve0y9BnjCF81BC+n0VDVrM7+UcwleX/IcKM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966006)(36840700001)(40470700004)(356005)(2616005)(336012)(47076005)(921005)(1076003)(81166007)(186003)(82740400003)(16526019)(316002)(54906003)(110136005)(83380400001)(426003)(70586007)(26005)(2906002)(478600001)(40460700003)(7696005)(36756003)(8936002)(8676002)(4326008)(70206006)(7416002)(82310400005)(36860700001)(41300700001)(40480700001)(5660300002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2022 15:36:33.8639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f15713a-ac99-4c24-d770-08da71781e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move error type descriptions into an array and loop over error types
to improve readability and maintainability.

Replace seq_printf() with seq_puts() as recommended by checkpatch.pl.

Signed-off-by: Jay Lu <jaylu102@amd.com>
---
 drivers/acpi/apei/einj.c | 41 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/acpi/apei/einj.c b/drivers/acpi/apei/einj.c
index da039c630fd0..a68103280f74 100644
--- a/drivers/acpi/apei/einj.c
+++ b/drivers/acpi/apei/einj.c
@@ -569,6 +569,20 @@ static u64 error_param2;
 static u64 error_param3;
 static u64 error_param4;
 static struct dentry *einj_debug_dir;
+static const char * const einj_error_type_string[] = {
+	"0x00000001\tProcessor Correctable\n",                          /* bit 0  */
+	"0x00000002\tProcessor Uncorrectable non-fatal\n",              /* bit 1  */
+	"0x00000004\tProcessor Uncorrectable fatal\n",                  /* bit 2  */
+	"0x00000008\tMemory Correctable\n",                             /* bit 3  */
+	"0x00000010\tMemory Uncorrectable non-fatal\n",                 /* bit 4  */
+	"0x00000020\tMemory Uncorrectable fatal\n",                     /* bit 5  */
+	"0x00000040\tPCI Express Correctable\n",                        /* bit 6  */
+	"0x00000080\tPCI Express Uncorrectable non-fatal\n",            /* bit 7  */
+	"0x00000100\tPCI Express Uncorrectable fatal\n",                /* bit 8  */
+	"0x00000200\tPlatform Correctable\n",                           /* bit 9  */
+	"0x00000400\tPlatform Uncorrectable non-fatal\n",               /* bit 10 */
+	"0x00000800\tPlatform Uncorrectable fatal\n",                   /* bit 11 */
+};
 
 static int available_error_type_show(struct seq_file *m, void *v)
 {
@@ -578,30 +592,9 @@ static int available_error_type_show(struct seq_file *m, void *v)
 	rc = einj_get_available_error_type(&available_error_type);
 	if (rc)
 		return rc;
-	if (available_error_type & 0x0001)
-		seq_printf(m, "0x00000001\tProcessor Correctable\n");
-	if (available_error_type & 0x0002)
-		seq_printf(m, "0x00000002\tProcessor Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0004)
-		seq_printf(m, "0x00000004\tProcessor Uncorrectable fatal\n");
-	if (available_error_type & 0x0008)
-		seq_printf(m, "0x00000008\tMemory Correctable\n");
-	if (available_error_type & 0x0010)
-		seq_printf(m, "0x00000010\tMemory Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0020)
-		seq_printf(m, "0x00000020\tMemory Uncorrectable fatal\n");
-	if (available_error_type & 0x0040)
-		seq_printf(m, "0x00000040\tPCI Express Correctable\n");
-	if (available_error_type & 0x0080)
-		seq_printf(m, "0x00000080\tPCI Express Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0100)
-		seq_printf(m, "0x00000100\tPCI Express Uncorrectable fatal\n");
-	if (available_error_type & 0x0200)
-		seq_printf(m, "0x00000200\tPlatform Correctable\n");
-	if (available_error_type & 0x0400)
-		seq_printf(m, "0x00000400\tPlatform Uncorrectable non-fatal\n");
-	if (available_error_type & 0x0800)
-		seq_printf(m, "0x00000800\tPlatform Uncorrectable fatal\n");
+	for (int pos = 0; pos < ARRAY_SIZE(einj_error_type_string); pos++)
+		if (available_error_type & (BIT(0) << pos))
+			seq_puts(m, einj_error_type_string[pos]);
 
 	return 0;
 }
-- 
2.27.0

