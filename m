Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A1D5216A3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiEJNRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242432AbiEJNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:16:00 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8383C4B5;
        Tue, 10 May 2022 06:11:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJKx+zIUGI2A2wJo13+pAaiKp1vJ7LK6onIBhAEUmiS65VjVG0wfR0ztcZMrlqhUJpq2Xf51MhrbmldCaFiDOkB7tK4C+S0wy9jWsufQUK/vc4V4Yz/tH8TAzwWTM1jJ3o2T90ihkS2c1mPt393BpWRB+jSH3P7rxRVWZo0LifWKOeYUTDyrqlNadrBotXDRB63EID3DpXuZdZ6kRTmuomPDLbBuX2QXPKta+O4DZYbbnIWc4mB2QLUOpqcANWuz+8/saxjGA1VbMCZGe/rmHfkQXmGNzX2N2fqWf3mK7Ay7d4axP03sLjhqWpp4+6DNaxQBCOqVS42si8ARzBxbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FI/pwYLqHWuWsEAhBA0/Cy2yG24Pn1hzjmezjRxPyxM=;
 b=LXwGTcFP70Ni32ipQ8/VpL/mpPkNtB0EOWAJM8/6reozPPSbpHrnkoeFaIPYXSLl4OofM0nWiI0xkZGJ2/aIS8//pYcYlTKva3WcxlXf4e7Swaru2GF6mGrb+/z5d1mdZ4UIGGsNl87v7AlMgAfrpkI5e3RNVG8T3PY6mc4AJVqTw55LnAHe3AQibq7qg4VzxYAnNip0oSFFwQPP3F96i2SU5L5dKxRTE/nF5sCGea3fjZO2Ko4HogD7v2BBgnM1B5PTC+JKXBReoBxY8sRAEtpjn0jbSW4F4xIMtwPSEVFdGvAkpiUYZZZGfcyB8NtPVN0eLPOrMqLqFzhsJvw+aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FI/pwYLqHWuWsEAhBA0/Cy2yG24Pn1hzjmezjRxPyxM=;
 b=hRxDGxCIh0IcM8RRXbKJw86Uwao6JF+Xu3Dgs/B8hNQB55P/jm4LGGR3DoYWbV6H5fNvHEjEBY9kCwFVIa2EQ4tjA+/3YlxhwFak5DmDBQ/hvu5YSAP/RNwG0MkKD04x2cvjACwUSJCMNwTjasdLRSwNWwt/KUBHl8FBrwROzTI=
Received: from MW4PR03CA0157.namprd03.prod.outlook.com (2603:10b6:303:8d::12)
 by CY4PR12MB1157.namprd12.prod.outlook.com (2603:10b6:903:3b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 13:11:36 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::bf) by MW4PR03CA0157.outlook.office365.com
 (2603:10b6:303:8d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 13:11:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 13:11:36 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 10 May
 2022 08:11:33 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>
CC:     Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default
Date:   Tue, 10 May 2022 08:11:36 -0500
Message-ID: <20220510131136.1103-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c929dfdb-f0ec-4c0b-7321-08da32869d10
X-MS-TrafficTypeDiagnostic: CY4PR12MB1157:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB11572B5902D29299D832BEBFE2C99@CY4PR12MB1157.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWddaeDpdWTK9Zk0R7ll4vIg4YtHiaG9mv5odu9DHnEBNp8OBzmNMNTmw63NyyzVL0zHqSKr2kBNyaRVObUUSyVsM4WR9xDm5y8WvrVGMB8DL33JRosxFlPQ9Vq04s/NMb5P3nneWprFvXHMCkOsE0zLGqo29AW1b3zk9SLLXUDhtROwP22fJp68CogwNsquonz/raoN4trfq5XNiaPbGt6Fo/9W76hj46T5nPxjrDlmKyX6mLP4DujrkBxwzo+Anyc0J+Q0tgUaZApVmBIeeBSasXoM4Hxb6x+J+7jRcDP/jmqztmRcwdi+kziiKOpZmTL54AT1kAxuYpZEcLmMheuTEroFSQdbC/9EFa4QlRv/VHTBxbEaYIeyfTxb0RMvYsjyF/S7ZsmISE8yeNiFgpLkKQDkXZs0jZ8qgpcDmo0gZ+aaNUzh4L9t+0ZOg17iF23t+5dALBC95BuLfrnK5MfNf2kr1b+GBEVvuXVKHf1OnnzgMwcp3aQrrp37bDlNAqS3yhqhQrF6+llaLXEjVa4Qw2tA0hWaIDz15Ux/EY5MzWv0vBehcwFaCosSrh1ST0gnGkV3I8n9RQMEODhZuz+fviaaRLh9muE8wcgPL3TWYxbKSylzeOb+jxL4NyXX/rObLRu+AJ6zr5qseTEefD22lP8NNjww3AvmdrqZOhl7SzNTejdM2Cuy6EdHps4KBA7E8O6RFCt/6fKOwEUB6lFnyYtT2Wbdbw83PpEWJ2ktWxWpDO8ikOPYCeE/QTUWRFBHimwxJqKxcEeidwnquPI+MyD8navcr2sAZifbXCI=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(36756003)(508600001)(36860700001)(5660300002)(44832011)(8936002)(4326008)(70586007)(70206006)(356005)(8676002)(82310400005)(83380400001)(2906002)(316002)(15650500001)(26005)(1076003)(2616005)(966005)(86362001)(16526019)(110136005)(40460700003)(81166007)(426003)(47076005)(336012)(186003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:11:36.6579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c929dfdb-f0ec-4c0b-7321-08da32869d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1157
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASUS B1400CEAE fails to resume from suspend to idle by default.  This was
bisected back to commit df4f9bc4fb9c ("nvme-pci: add support for ACPI
StorageD3Enable property") but this is a red herring to the problem.

Before this commit the system wasn't getting into deepest sleep state.
Presumably this commit is allowing entry into deepest sleep state as
advertised by firmware, but there are some other problems related to
the wakeup.

As it is confirmed the system works properly with S3, set the default for
this system to S3.

Reported-by: Jian-Hong Pan <jhp@endlessos.org>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/acpi/sleep.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index c992e57b2c79..3147702710af 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -373,6 +373,18 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
 		},
 	},
+	/*
+	 * ASUS B1400CEAE hangs on resume from suspend (see
+	 * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
+	 */
+	{
+	.callback = init_default_s3,
+	.ident = "ASUS B1400CEAE",
+	.matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+		DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
+		},
+	},
 	{},
 };
 
-- 
2.34.1

