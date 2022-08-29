Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C5D5A51C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 18:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiH2QaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiH2Q34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 12:29:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AFAB60E9;
        Mon, 29 Aug 2022 09:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyrxVzwXrSJBkk5qgyvmxi9PO5Bi/fpvXDnQuyiIK93kclVSOGl+qtsM0Q5WYZBm93ow/oOaMJHr+7W99AtG3MQR+mvlgjEMUx0vSeWEm9OuiiEGbu3MsSDOSenajEqBbpn1SXfe50l+fEPeuBp8X64XxtQA+5fRPkVtnlxDQ8FzJYnAKUSEPYzJ/F/8+a+Q3Tpvl8Ds9Mn+iv/WWnmv51QkIvaKrS83c6jBh7VEFA2/I6oQNban4X5wICcDSPPuBhwqPsNMsAjMkAtwzuN3gENUj7HibU1E+0Wk8sBiOdu8Lntdx2LAw1MA0FrmtJwu/cTv50o6P2IgNp6QCAaB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb2Ept+u+ewMhpGkAhWhnISYkF5IZQ4dtnvc2u3KeNc=;
 b=Dw1SXC0lFLmRAvzOHffADxEYZQB7X16eaMGbGzMfJcQCTjo3M5ZGEEy4mCyi59h7sX/3ovejsxpYqkOdqy7wJgiQpsWK2PVR9RHY2CttpDMDVxnu07YGAREPwyQievnNJlnFjSqmnMaDZ77AKMqqdAl1GJW0uVd05VpoQCxrX82dUk1FE/JMT9MMr6tbAVxWFmW6PG5a1gE/X+6CNRIUuFMLDB7vyI43E4ewGKt/iungEIrHwxmAQxLD+SXEUUV2Oj/F8w+Qso8jQBoZYyevitmJTc8B9M37b6YU0I/2+9sGwR1FZTMJd8DtV8HPiUYFv7JITc1hs+65//9RJAXNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb2Ept+u+ewMhpGkAhWhnISYkF5IZQ4dtnvc2u3KeNc=;
 b=Y0vpIHRlAQT3qkHfi7hgzw+SKEO41ffllDuTJQY8dZj8qJP4UuMXrzZz3pDrqxUknFCE3Pu726PxQ0egc1/fAbI5eFHWaepKQhrHZGEe2ZYVRnBLa5Aq+dER44FHcJLeRmR+sndw+C96fNqJb4EmHlKp50RjzM44SpqtyJe7/JU=
Received: from MW4PR03CA0024.namprd03.prod.outlook.com (2603:10b6:303:8f::29)
 by DM6PR12MB4975.namprd12.prod.outlook.com (2603:10b6:5:1bd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 16:29:49 +0000
Received: from CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::ac) by MW4PR03CA0024.outlook.office365.com
 (2603:10b6:303:8f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 16:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT082.mail.protection.outlook.com (10.13.175.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 16:29:49 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 11:29:47 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Len Brown" <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>
CC:     <hdegoede@redhat.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 1/4] ACPI: s2idle: Add a new ->check() callback for platform_s2idle_ops
Date:   Mon, 29 Aug 2022 11:29:49 -0500
Message-ID: <20220829162953.5947-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829162953.5947-1-mario.limonciello@amd.com>
References: <20220829162953.5947-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9279c4f2-6ab6-47e2-97a4-08da89dbb152
X-MS-TrafficTypeDiagnostic: DM6PR12MB4975:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Kks2yAlutitOSK5ZFYR6gwfxvJlWsdERE+q3Ugr+WyNzS5+POgz4l24EjRh/GmkXGQgWgZKlJxgejrEv8IkfliBoleEEYcAlEkWFtVzYHKWbeNIiFIVf70YmnqOvHixgyk246xPRV5jb6Lti5fU543ApSIxNzp0J/tEo6WbACJvGmIyBkSJyXwvKXDCkapbd0NSmrkq61D1cmOgCM6IJDaQZBYuTJJOhmG2MUA4WGLqy3jDSrmv+9J/RKP3j3+2JEzDyAn0lx/hWgzuhL60LWt38zpuuuRQ4CTDbcSy0OGYpQzpM3bCSrSH/hCNxD0OAbAZO7XoRD9hN9EHnY0RbThwuYZ8Bwcq1wnrnGKGc4TB550pFbDbrmd0kgaPD2YqUsICCQJ5mUTXeGU+bL8/jE7OPOTaecK+X3kTdF+atabfvOApAuDDgA68YMqQ7EtTBjUjvOFRXUZSV75PMKtkqanUHQ71841RrlKKUHic7ansG4KEQPz80hmvfbCTh6ygJHuKLmBiRut8iV0+15kOoYejTmn9oU6M01wfNarGrV/Q23c+oecnJvxd5AlltasspEa0lo28H65sSY3su5C4X8NEuUwQND9WBffVu+UDntL0gP5AiYYdvXS2mAiQQJpocvzmaGjyDzslDTAiCLFy+gjvYj0+rGP9+zJseuLta+pr8U6jcXmAwjpF7RsyjW/xi9FbXm3QraBP0StcGUFkGbw+GHi4Sfl15x+zKgEijfXhxfWR01EZPmeQ1bXMy2n330dxWgeaugWmSV7ULOIIHcE5/QE3DiE/6x247PhxhfQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(40470700004)(46966006)(81166007)(41300700001)(40460700003)(5660300002)(36860700001)(8936002)(40480700001)(16526019)(336012)(186003)(83380400001)(426003)(47076005)(2616005)(86362001)(1076003)(7696005)(44832011)(2906002)(26005)(82310400005)(36756003)(316002)(110136005)(478600001)(54906003)(82740400003)(356005)(70206006)(70586007)(8676002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 16:29:49.0294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9279c4f2-6ab6-47e2-97a4-08da89dbb152
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4975
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
v2->v3:
 * Rename to *check
v1->v2:
 * Add a prototype for `acpi_s2idle_enter`

 drivers/acpi/sleep.h      |  1 +
 drivers/acpi/x86/s2idle.c | 14 ++++++++++++++
 include/linux/acpi.h      |  1 +
 include/linux/suspend.h   |  1 +
 kernel/power/suspend.c    |  3 +++
 5 files changed, 20 insertions(+)

diff --git a/drivers/acpi/sleep.h b/drivers/acpi/sleep.h
index 7fe41ee489d6..d960a238be4e 100644
--- a/drivers/acpi/sleep.h
+++ b/drivers/acpi/sleep.h
@@ -18,6 +18,7 @@ static inline acpi_status acpi_set_waking_vector(u32 wakeup_address)
 extern int acpi_s2idle_begin(void);
 extern int acpi_s2idle_prepare(void);
 extern int acpi_s2idle_prepare_late(void);
+extern void acpi_s2idle_check(void);
 extern bool acpi_s2idle_wake(void);
 extern void acpi_s2idle_restore_early(void);
 extern void acpi_s2idle_restore(void);
diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index f9ac12b778e6..474aa46f82f6 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -486,6 +486,19 @@ int acpi_s2idle_prepare_late(void)
 	return 0;
 }
 
+void acpi_s2idle_check(void)
+{
+	struct acpi_s2idle_dev_ops *handler;
+
+	if (!lps0_device_handle || sleep_no_lps0)
+		return;
+
+	list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
+		if (handler->check)
+			handler->check();
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
+	.check = acpi_s2idle_check,
 	.wake = acpi_s2idle_wake,
 	.restore_early = acpi_s2idle_restore_early,
 	.restore = acpi_s2idle_restore,
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 6f64b2f3dc54..acaa2ddc067d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1075,6 +1075,7 @@ acpi_status acpi_os_prepare_extended_sleep(u8 sleep_state,
 struct acpi_s2idle_dev_ops {
 	struct list_head list_node;
 	void (*prepare)(void);
+	void (*check)(void);
 	void (*restore)(void);
 };
 int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 70f2921e2e70..03ed42ed2c7f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -191,6 +191,7 @@ struct platform_s2idle_ops {
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
+	void (*check)(void);
 	bool (*wake)(void);
 	void (*restore_early)(void);
 	void (*restore)(void);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..c6272d466e58 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -136,6 +136,9 @@ static void s2idle_loop(void)
 			break;
 		}
 
+		if (s2idle_ops && s2idle_ops->check)
+			s2idle_ops->check();
+
 		s2idle_enter();
 	}
 
-- 
2.34.1

