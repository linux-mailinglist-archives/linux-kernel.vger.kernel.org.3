Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F4E5A4000
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiH1WVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiH1WVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:21:33 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2041.outbound.protection.outlook.com [40.107.96.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD22F667;
        Sun, 28 Aug 2022 15:21:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJPRWXMP3127IxaY85Sj0pIaiplVJKcfietT3MY0QS9+AfiTBfGyzyGFuk/HMxkEhCPnUIWsbbJ/ZoW8o6eFx50/dQhdlIrPAUJmJyh8haXmKJVzH/CHQDGjo6RfJq8O3J4KFAJtT9g4LDl335r91RFS3yIkRS+OBgyewyVB/HFPAm1CoKWq5HjwAcFiqkdXhu5IhwtG4rec6gXWveUOY8B5yb02LJXtYWS+el+UMleMpLkLdoMO6cXxJ1kMmQRT9pz8bRQ65xvE9y1RfLSnaBtl7q8NhNpAaRNVdh+sswimaTD0BxK6Vw1I6u6KRgckCMno8cYU7qxbYsddUx+GoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drevcUYjzqs21Vih8vPeyiPAB2TElvuLnvfR/597mSY=;
 b=graSdPx9f8pkW0kUhWhMU9V+pKLQgH3hxN5WGOPfLyx1FkbwmeG8t5tQZ0WxqW8WMNzQ2fMELwSBrZxjerO2ewO3cY+7bTV6XiacAvWHvQJ9ShLkPQ+2+IDlJY39I5ayddqnIl9pCSvrDKfxOuQFmz3rXQn6DeFaen0nRvjPm39XgmVjcUSdhpx74GTUzySLl8hEgtkab3XTeQIVXTghyx0wS2plUFWov17aMg/nbdLas9kfilRe1SoFDhgyYRTXI+lj7nPZPlgtz0h78A9PMf03E4aM3QyT0lOm75YxNA9EPvQx7pKyARXU5Qtw1W9hH5uQt9vdn/vEh6Zzqxy0TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drevcUYjzqs21Vih8vPeyiPAB2TElvuLnvfR/597mSY=;
 b=1zLwBMB9RvBvn+BvfxgU+aomB1GksXd8mvNXsAxF2y9OM4Kbv2Adfkd3h+mL0IZqrZV1hgBRkikboCF/EHTFH+O9rcEgJ9ETlxwQT2K9tXk5s08Y3mfcViQL96nsTJt0qCwUJlrcLRFxLlbdy+ZtvGEzovYkiGjvNmln6oVtAxQ=
Received: from DM6PR02CA0157.namprd02.prod.outlook.com (2603:10b6:5:332::24)
 by DM5PR12MB2391.namprd12.prod.outlook.com (2603:10b6:4:b3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sun, 28 Aug
 2022 22:21:22 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::f) by DM6PR02CA0157.outlook.office365.com
 (2603:10b6:5:332::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Sun, 28 Aug 2022 22:21:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Sun, 28 Aug 2022 22:21:22 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 28 Aug
 2022 17:21:21 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
CC:     <hdegoede@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 1/4] ACPI: s2idle: Add a new ->enter() callback for platform_s2idle_ops
Date:   Sun, 28 Aug 2022 17:21:18 -0500
Message-ID: <20220828222121.4951-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220828222121.4951-1-mario.limonciello@amd.com>
References: <20220828222121.4951-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcb7d181-b852-45eb-9f37-08da8943a381
X-MS-TrafficTypeDiagnostic: DM5PR12MB2391:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VodE49efcsnJRBXN2MfqTxJ8z56ivvRNPS/M5P9673njBtMhsMRtfRL+b4vuiqQonwiJ9+rEPNQZ78Txyr5g+hqirTTTg4/P2I7SbV18r8jmwWgVGnDkC5Te53KfQqeLQVgtZvWessotM4kNYmeeJh2sRiD1U2SWeBkIQn9Bivs8ofroyY9yK6dR5QSCk3hpceaUY9Owy05/un0QLt8AsbbSibrkV0xBYITQCpTOCcTP4XKOJkfrsXAJub28h+7LjRqVugooNNkW+sxybeU93/Md8JUZWVRb1LDm12ALu7dcf/CEuQrhSjSS6IxmpqzjQpBa1h0D0+okPjLhIuTBuneWnpCy+AjnFKzcletNmad2OkJTuePFz//UHG6BNO9SBMVnumuK0cTgN/wwfHSO+HRsoaJL2/UChjWpoIBvzaztL4l8Ijds0OawJ/MT1Y9XwQaiZJxIypbYTJq4z2zHviibGssZMp2u3hU4ztLQHc8xS3p67tmtJhFAFaGOr/ngoADIQxVyFxYZlpnE3ADbbUjjY4M5uMqK81uTnpEkoPQhjlyjbC0un7qfkCg5Rge7f4dAX95Ke/T/QFv+qR0a3peQTGSosI7tJfFVGpPO9c2/kbkMZDsIO5Vd6/05BsWRnm9XFrAn3o7qfPjzX/uyCKdb6Pe3Wk+TUFSKvmuFdHtw3ijjz/E/LgPHY67GLWxwcEOLpXdzJ5+V+p3gBWFc0wzHK46Bas/tOuhCFcWyD0j45wiizM2EbpXvmwL31DBlgfrL2Rt+4u3FQR7J4i0gICbyscZUCGJmcg3k16tA4GKTKC0Xy70rXP5RBXfCbdFe
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(376002)(136003)(36840700001)(40470700004)(46966006)(6666004)(7696005)(86362001)(26005)(36756003)(426003)(336012)(186003)(16526019)(1076003)(47076005)(478600001)(41300700001)(83380400001)(2616005)(40480700001)(82310400005)(40460700003)(4326008)(8676002)(54906003)(70586007)(316002)(70206006)(110136005)(82740400003)(81166007)(356005)(44832011)(8936002)(5660300002)(36860700001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2022 22:21:22.2529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb7d181-b852-45eb-9f37-08da8943a381
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2391
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
 drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
 include/linux/acpi.h      |  1 +
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    |  3 +++
 4 files changed, 19 insertions(+)

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

