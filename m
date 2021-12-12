Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60A26471C00
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbhLLSGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 13:06:53 -0500
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:26369
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231889AbhLLSGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 13:06:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVb/e/FUFrKLOwLZqQaJCdJZ9C8+BVKNw2D3503IWDj6wO+J3J3+1iO3+wQyEj36S7sMubI6DyndM4mZv6C0INxAkDmET0VPSNuvOzrWTVThQqppdGs5uAuhDindd5ThALCpJImZQottik0IZ8c7Bqca0KgWbhafzCE0osjmStBEAuvG8dizd2ZiRvPLdd9uRBRfPXqDDG09yXF43KZFVrMsDowcuKLfiGoXlp3yBWcreRvzGumJSRwbiq4jvskwKhUEE8YN06NvVQyZTaQZxBtbt44ikAA3nVdueXW9KUJLI5cQAohD4GPmgiY/EwpmNgLC1zbiSgLsj1d5flt+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z24shn7wM+/vTlbL67SJ6MCU5pFSo38Z8UHCa4xiK7w=;
 b=fpOjqbMzKQ4nNtbw5rYZzN5A3AYfHhWMH/Ot1DkyOiqaePDZRE/6BUG35YsDtt3vzf4xKSr3abEsKbtSOCaybl9/DAD/d/RvBz8fQaWwgx32VptQ/ORX9/hXh9mbciKTVUfyoUxy63w2F1DUjNsvK8fj60w0FiRDB5AFXIxvAkKCjD6ewYaxf7uiJ0gw+7v6mAnqbardzHz94q5QkyQ5wsxFurosRR1KwwCZF0ZHRhkVIGhreaia9atvAfnjxZ895QGzQu8AmgnskHWGgjKmm3HiKt+pE4WScsYsA9O5SfKiQIy7r2/H59J4IKSJ6BLT49UweFExwdge16cN3ifs+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z24shn7wM+/vTlbL67SJ6MCU5pFSo38Z8UHCa4xiK7w=;
 b=hKxXWJwZh5p2bSEpVsMZqCrH2FIhggEsXCj/bHMjqx2Hd4RL0unHIhyVOoMohxQlYCSpg4tu5AtZMYVNTINQqaoouo9xJ+R6yBjJ/702NGAGRiC0pL9Ds40RMaZ8LbmS+VuEtqoc8XHeV9cwOpc1BpQXOiIzhLuhpGkAtatF4oA=
Received: from BN6PR11CA0022.namprd11.prod.outlook.com (2603:10b6:405:2::32)
 by BN6PR12MB1506.namprd12.prod.outlook.com (2603:10b6:405:10::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Sun, 12 Dec
 2021 18:06:47 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::6f) by BN6PR11CA0022.outlook.office365.com
 (2603:10b6:405:2::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11 via Frontend
 Transport; Sun, 12 Dec 2021 18:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4778.13 via Frontend Transport; Sun, 12 Dec 2021 18:06:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Sun, 12 Dec
 2021 12:06:46 -0600
Received: from chrome.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Sun, 12 Dec 2021 12:06:43 -0600
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
Subject: [PATCH v5 2/5] drivers: acpi: acpi_apd: Remove unused device property "is-rv"
Date:   Sun, 12 Dec 2021 23:35:24 +0530
Message-ID: <20211212180527.1641362-3-AjitKumar.Pandey@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
References: <20211212180527.1641362-1-AjitKumar.Pandey@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e32cf2ec-1bb9-4213-07ca-08d9bd9a29cb
X-MS-TrafficTypeDiagnostic: BN6PR12MB1506:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB150628760B7C703A994BA80682739@BN6PR12MB1506.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2wQqmzRWjr+1ALqqylviemvYEe890BM3ldvXZAiKKbu/tbdthyXoQHUmp1zCbkOwp/Y8xTrPaeJ1qeEtRLQFmdtUY8F+i/tbAMTIl1ezwEPDFNu40P7JSNZVzhNtp42uSGMQ/mInPOsXbF8LogscM/zAUO7ymcIVLeOQnCHTwv2neNIatmRgpql6oX5YfL+F98z2GrjZKSS7uyEU1CQk5XhMyDTVlh+5An11h8lHFPibUJPoUYyDETHV6ZMAvJCU4lkZMk3J7pMcX5lIjY6h84U9Mkr0d/tTfM3Uj+Zv6f6+Zz8WjRd7EKkcEJufhdMcqHeKfIoF+Agsz/N+VwpC44tCktHYgaKc0wAeSPdccos7qKQ3TN7wP3wuzfHewp2GbTNJQkHi/1msUHOVJuPlqTHpS5irEqGQS/9jjCZmPNBJEUY5Rfkks3lFUBLhzWUOc7zrS2G46jRrsnUUJwOpQpKbA1JWA/+gueQ6LXNLzp3ct+4kGSd4rD/hEVucsZ3I5B4CQBWcjsZRgmT3QyvCPkP9BhpbTRywGLzX6o3LmCA2jvEtI3Rzo4VyiyGKnQ57Pst3vFGJMQeVzQolKHVlIV+KucIZys4nxNZrBUy2fqqHHyLfE/YdxOiEuijTL9AErIQ33Zjo37k2aHYyaxv/8MnIses8uiWW9fo5uFEraU6biKnuWjmXlYNj0yRSv82ypcLivEk09prO99HjuxDebneSk6xBlKbvQMs/wLK95ri7Zqj+2U6SwG7wUXGouybNbO9s8Wzjfzb+KslSEplDHcuFl9SJQe0F/lH5S3WwL9M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(6666004)(2616005)(356005)(70586007)(8936002)(36860700001)(4326008)(81166007)(70206006)(426003)(1076003)(2906002)(36756003)(83380400001)(40460700001)(8676002)(316002)(336012)(7696005)(26005)(186003)(5660300002)(110136005)(54906003)(86362001)(508600001)(47076005)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2021 18:06:47.2952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e32cf2ec-1bb9-4213-07ca-08d9bd9a29cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1506
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially "is-rv" device property is added for 48MHz fixed clock
support on Raven or RV architecture. It's unused now as we moved
to pci device_id based selection to extend such support on other
architectures. This change removed unused code from acpi driver.

Signed-off-by: Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
Reviewed-by: Mario Limonciello <Mario.Limonciello@amd.com>
---
 drivers/acpi/acpi_apd.c               | 3 ---
 include/linux/platform_data/clk-fch.h | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/acpi/acpi_apd.c b/drivers/acpi/acpi_apd.c
index 6e02448d15d9..6913e9712852 100644
--- a/drivers/acpi/acpi_apd.c
+++ b/drivers/acpi/acpi_apd.c
@@ -87,9 +87,6 @@ static int fch_misc_setup(struct apd_private_data *pdata)
 	if (ret < 0)
 		return -ENOENT;
 
-	if (!acpi_dev_get_property(adev, "is-rv", ACPI_TYPE_INTEGER, &obj))
-		clk_data->is_rv = obj->integer.value;
-
 	list_for_each_entry(rentry, &resource_list, node) {
 		clk_data->base = devm_ioremap(&adev->dev, rentry->res->start,
 					      resource_size(rentry->res));
diff --git a/include/linux/platform_data/clk-fch.h b/include/linux/platform_data/clk-fch.h
index b9f682459f08..850ca776156d 100644
--- a/include/linux/platform_data/clk-fch.h
+++ b/include/linux/platform_data/clk-fch.h
@@ -12,7 +12,6 @@
 
 struct fch_clk_data {
 	void __iomem *base;
-	u32 is_rv;
 };
 
 #endif /* __CLK_FCH_H */
-- 
2.25.1

