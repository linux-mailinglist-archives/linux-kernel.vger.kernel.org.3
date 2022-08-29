Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0358B5A4E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiH2N3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiH2N3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:29:25 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE025175A5;
        Mon, 29 Aug 2022 06:29:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MG2gFioQRd393edyZdNDGNzpaevewiXzx00n/D4khYmxud7Tr+LYsJC5zswFXjmKMfk0m4lsxymV6ZrxY+fNExEDUtIWTXhBh5vHTNCgQEC+8NcgVJo2T3Mm2qWHFHVTJMuvo2o6FwDdgrcSz++LkKONdW+7oHwXEFz0hM0r1VAxEvoWKyn0Mz0QX8bGa6PYd4x3NihZnHgfZFNV8pJs9M7ixlHG962m8UJ8uvxOHZn7H1n6WSFwpCCEN5R2fR8YnqLTe9nNK4cFvl2vUd/X4EY582EeKEZpo7JDp9yoYfFcZxG6NonSH2Hpl4ljKTI2qAEB1L/wOtIY1f2EY90hxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xSJjRcgg/532Juh2XbTd4Y/tZ1aN24c4BmxM+xCeHk=;
 b=bbMui2kllPDdScKNieWWSccA35En/5aem76hzCC3sylMA+TKhZ64yNGFs63CrKLg3iPUmUSArRNm7JDtALqHPfYz98gBuWjc7RHUWP/rUnDmAuGmqLAOfzULpcKn7JCt4qRg9spE58EZ3TR2syuQGS4yhCsDZIcWIm24ATnyxaFeDRQobpKvUGGgPMm06opNiP45qf5wVRv8KmpD/8A8ZFR4d/kCN6JffSk1+9IF+EH/k1h28Qpam7E/XEiSlVA0zH6lmZUpRLyU6TCUpewP48XEtkxaKanNy82vMpbuiW5EtWXf4m+zllvVtVNttrVCBQ7+FnJp0nCVMMX9Q1R+ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xSJjRcgg/532Juh2XbTd4Y/tZ1aN24c4BmxM+xCeHk=;
 b=I8gQ8TW0C4z8DgCDSpCyCt75wHh2k5mZFP1w9ia7L03PqUP2yQKidFC1bMQKjdEyLVUCqYi11aYQQjvczGA3IIrjJT78bmqN/uTXj007PP1i42tJ3f2RHZbKL0xjQRIZm63MV6jHqObBLD3ON6SjHpimn8+GKRrQriZa2puP9hk=
Received: from MW4PR04CA0355.namprd04.prod.outlook.com (2603:10b6:303:8a::30)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 13:29:12 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::5e) by MW4PR04CA0355.outlook.office365.com
 (2603:10b6:303:8a::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 13:29:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 13:29:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 08:29:10 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
CC:     <hdegoede@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v2 1/4] ACPI: s2idle: Add a new ->enter() callback for platform_s2idle_ops
Date:   Mon, 29 Aug 2022 08:29:04 -0500
Message-ID: <20220829132908.5254-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829132908.5254-1-mario.limonciello@amd.com>
References: <20220829132908.5254-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0da723c7-ea1a-42f0-5d1b-08da89c27606
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 630xAkuK3lf0IYdhyPVkM0rM4/MUSD5Ll8/D6pP/b9QSGmOMsC1qls66Yo5K17BenfwJVRwHhaR0f1BZwyz4BdBgGynT8CqV4h9YEfIMQ5nklz2EBBfd6JgJqrTeghau5OjT+uW0AMhDX72sWNp2TTu6voTv9+7/UXDETyWZ/uGP/LC+v4wcI8gQOmn0BaQIzSM8W3sZrfkZJTGEa+jJwGjODKtOJipc9be7Ik7V7P8rd33NJn6G7pENeY4LfpENL7+ynILOllI6jBRhqi+jxzzdzLGr4T1f9JgkmTB+T4GidcJ4PrLcPaYVkDvVxVlqRDV9zkPCVN2+/lXzUAlAaZutY6fEW5CYJH2rA28mN056jg3pnP4RdxnbZwLzIoru4/55EG8R4/wqZjeNiXfq7/BG42ui6QBbsnSIrWg1KjKVT5q19KhvkBwqcZiuHcehTmd1F5nK74u629HOPZuM+TQ0EvYG33hXUHXe7B6Xeas4mU4qNygMomW3BGUz9LoRRn19e3ilaB1nWQ1Q5dpRFy+K0JxwWiAa8WGjO7yTq2JWOd5R/IlSfZdS9CbxftZk7MdsP9IEHy3oTRAxHeJNH3b/7EYo4F6u2QaJlGNR9GFkG5TYP5yxudoIQlweUdP2HKQ10mobpXOEt0oZCMvvLfyoHEM3KqJcJGBDzH9RnMY+tZma/pSo8LlCweW0VpfeQwv0cMn+SwhOGADjY7IMW3p8XIzFOzgnwfsbK2PD+yGt/gP7am2Ha1vx0HtO2m+/sPzaTul0KL2Nj1lxQW5Rdpe9Cvxi+8tTjvlt4JCYZj5Gpxr4VKJtzBSyqivNjhrz
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(376002)(136003)(40470700004)(46966006)(36840700001)(82740400003)(110136005)(36756003)(82310400005)(1076003)(70206006)(81166007)(2616005)(316002)(8676002)(70586007)(54906003)(4326008)(86362001)(356005)(336012)(186003)(40480700001)(2906002)(47076005)(426003)(83380400001)(40460700003)(8936002)(36860700001)(16526019)(5660300002)(44832011)(6666004)(478600001)(26005)(7696005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 13:29:12.1260
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da723c7-ea1a-42f0-5d1b-08da89c27606
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms it is found that Linux more aggressively enters s2idle
than Windows enters Modern Standby and this uncovers some synchronization
issues for the platform.  To aid in debugging this class of problems in
the future, add support for an extra optional callback intended for
drivers to emit extra debugging.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Add a prototype for `acpi_s2idle_enter`

 drivers/acpi/sleep.h      |  1 +
 drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
 include/linux/acpi.h      |  1 +
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    |  3 +++
 5 files changed, 20 insertions(+)

diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 7fe41ee489d6..7856930a7da9 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 extern int acpi_s2idle_begin(void);
 extern int acpi_s2idle_prepare(void);
 extern int acpi_s2idle_prepare_late(void);
+extern void acpi_s2idle_enter(void);
 extern bool acpi_s2idle_wake(void);
 extern void acpi_s2idle_restore_early(void);
 extern void acpi_s2idle_restore(void);
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b778e6..c984093a3657 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
 	return 0;
 }
 
+void acpi_s2idle_enter(void)
+{
+	struct acpi_s2idle_dev_ops *handler;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return;
+
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
+		if (handler->enter)
+			handler->enter();
+	}
+}
+
 void acpi_s2idle_restore_early(void)
 {
 	struct acpi_s2idle_dev_ops *handler;
@@ -527,6 +540,7 @@ static const struct platform_s2idle_ops acpi_s2idle_ops_lps0 = {
 	.begin = acpi_s2idle_begin,
 	.prepare = acpi_s2idle_prepare,
 	.prepare_late = acpi_s2idle_prepare_late,
+	.enter = acpi_s2idle_enter,
 	.wake = acpi_s2idle_wake,
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..9df14b5a875c 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1076,6 +1076,7 @@ struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
 	void (*restore)(void);
+	void (*enter)(void);
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
 void acpi_unregister_lps0_dev(struct acpi_s2idle_dev_ops *arg);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 70f2921e2e70..5a3fdca0a628 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -191,6 +191,7 @@ struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
+	void (*enter)(void);
 	bool (*wake)(void);
 	void (*restore_early)(void);
 	void (*restore)(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..0c08032d6b50 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -136,6 +136,9 @@ static void s2idle_loop(void)
 			break;
 		}
 
+		if (s2idle_ops && s2idle_ops->enter)
+			s2idle_ops->enter();
+
 		s2idle_enter();
 	}
 
-- 
2.34.1

