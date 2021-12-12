Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA93E471C03
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhLLSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:07:00 -0500
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:64257
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231889AbhLLSG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:06:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBFotZ3OU84nlJ4EdzZpdtQBZ2GXnE2S+YrXBDStnIwBvDDF3VLdCmigCav47yCHH4+7A3YwZzRkNLah2QAxUTFAJCZ5wTAZU43MF+epJmd7npkbRtbCxdCrDUUGrOHh7dxIZZqiCSEnrp/6rmrUZimpyL0KlYLNm/t+VIrUkJ2tY3QX6DBoUU5aDwKgTocXTlEJofYT4INRRf9EFzD3oA2KNHzmyagp6eB+cGsiGKIQPFmYMZvq181IhU5hlupYA1a58Z6jtTVJXwtbEdQDuJZRa5ICqDAMwTQsACZgAcQOsoJzWrrmx5EwbIyCHcldH1sGpb5M/Bvfz9TF/LF0uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oEb98bDMgj4hgTTGRJyGQhabsgB7TAvgDxY0QX04ygc=;
 b=PWAOZaT9CKlT+iLmWPfSp+sTd1Uiy+GW6LtUILTtHMfr440iyK3FeZ3G9IWGfxFViwx2RfnCHq2XtjxwVD3gcfB3P1MxmRXA0tKrAoV/EAL6VZp1yjiwzQnHPWVqFE8SxUEkGHkLXcXyMFTVB7g6SxCaKUhacuAPC0mYeho4NgPFkPWzaEO5p7y28BQ6XleVn/tQrCSwXKCbtOIIL1kv1OigwP/KwEy+NzpQFxOuMhpE2Ef6cd0HP024Lw1OqrrZBvIP+YIq6yzC2MqMRluKJ1a+Pq3ToWEFuIW8vKdzCUhZk3TdEbuAkp3Tc4lNQ0g0vXRrkSep5VX05zY5QXhX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oEb98bDMgj4hgTTGRJyGQhabsgB7TAvgDxY0QX04ygc=;
 b=YI73kZ8tmJtFWXfyYcoy/WJKzW+Iq07iPjexI3E4Rz3F/p/ImenAKuu/qpJYw9Ll7IDYlJpYvuZvRSSGSVI9XahRZalU8UytuANpUS14LiHwRPoQvfUUH9cpDVU+yV2p4vzk+NyfgKIMd4+wCpJnHY4KR1PnZWQhFSxjUQX/WHE=
Received: from BN6PR2001CA0048.namprd20.prod.outlook.com
 (2603:10b6:405:16::34) by BL0PR12MB5553.namprd12.prod.outlook.com
 (2603:10b6:208:1c9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Sun, 12 Dec
 2021 18:06:54 +0000
Received: from BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ae) by BN6PR2001CA0048.outlook.office365.com
 (2603:10b6:405:16::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Sun, 12 Dec 2021 18:06:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT016.mail.protection.outlook.com (10.13.176.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Sun, 12 Dec 2021 18:06:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:06:53 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Dec 2021 12:06:50 -0600
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
To:     <sboyd@kernel.org>, <linux-clk@vger.kernel.org>
CC:     <Vijendar.Mukunda@amd.com>, <Alexander.Deucher@amd.com>,
        <Basavaraj.Hiregoudar@amd.com>, <Sunil-kumar.Dommati@amd.com>,
        <Mario.Limonciello@amd.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/5] ACPI: APD: Add a fmw property clk-name
Date:   Sun, 12 Dec 2021 23:35:25 +0530
Message-ID: <20211212180527.1641362-4-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f8437c9-c20a-4f30-2238-08d9bd9a2e0c
X-MS-TrafficTypeDiagnostic: BL0PR12MB5553:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB5553D3AB4C0EBBB71027623382739@BL0PR12MB5553.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGHfjSozaPKfFIWipvohsNANQPsmos8h+M7gbLgqPOYQX6mDiR3ISwVUY+U0jan27Q5AclM5kTqiY36lUhVMeAmekeH81LxJFyrAOnk8x5fka8129vgJY7XZqr6XTNafNLAgafkc62qilLgBfPvuO5HZul12LFNF84Ld36rsiitCbDQ0DUN0kMsTZzW56eHRbqM4IERhmEmfHjHnF/tEj/UQ3DkB8dq/H8QGi+/Y9vDiue/EC4dhYhLHUDTzFrZQZWQrI96z9cHGtLTPw4jPLUq85ehZ9/wHoFypByhZ+xc6Q4ud4B4gDyxIV48rpKedszeQGkcqqwbod53GPDkOa2TPlshJmjEJ6jiik4VW6Z2qEiLWe1EBSGw8oL8e3wRj6LdO5jAWE4Gi2855EdSqV6TJ9edEuY5bDGnad1WNFAKQwriyxu44QosrcxVTMtjSlEpWgs1jUBjAU0ZS83kv+p0zkHz48o1rO9vlDL/CXA0aub7kNST8xY1vJMnSskS27kSQ9kkUW/MOk4VPDdy3KQowaPA2MTAYVxL/ZTF0TAQ/GgiB/60vcKTdAh3B/25a75BSTmEqi+ngB+rDbmlYeVtCXHAqemioxsQ8xb5Y9yQupImJkeUXAMrAe8czmdIgKPhb6E34M2OP+Wqc1XEraXXXIgMaFUynaMExHuk1CN4dj+3gNZLlg27lmkQKaWu5P0INOHLTwFgAt04yaF3bOxEsqOD2U4oUkPUXHq8vzOg1YCLMDWE/NcxjmJnYTCbgkZN8e6D0c1F9uIm5yl30nUH0PTG57Kzn3tV6nGZrBB8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(8936002)(508600001)(110136005)(54906003)(6666004)(47076005)(70206006)(70586007)(1076003)(2616005)(86362001)(426003)(356005)(26005)(40460700001)(8676002)(2906002)(36756003)(186003)(336012)(4326008)(5660300002)(7696005)(81166007)(316002)(36860700001)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 18:06:54.4327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8437c9-c20a-4f30-2238-08d9bd9a2e0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5553
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new device property to fetch clk-name from firmware.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
---
 drivers/acpi/acpi_apd.c               | 10 ++++++++++
 include/linux/platform_data/clk-fch.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6913e9712852..2b958b426b03 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,6 +87,16 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
+	if (!acpi_dev_get_property(adev, "clk-name", ACPI_TYPE_STRING, &obj)) {
+		clk_data->name = devm_kzalloc(&adev->dev, obj->string.length,
+					      GFP_KERNEL);
+
+		strcpy(clk_data->name, obj->string.pointer);
+	} else {
+		/* Set default name to mclk if entry missing in firmware */
+		clk_data->name = "mclk";
+	}
+
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index 850ca776156d..11a2a23fd9b2 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,6 +12,7 @@
 
 struct fch_clk_data {
 	void __iomem *base;
+	char *name;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

