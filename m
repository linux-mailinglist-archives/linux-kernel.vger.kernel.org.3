Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064856292D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiGACde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiGACdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:33:32 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBDD36172;
        Thu, 30 Jun 2022 19:33:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBdFpQoCKmVqpotBhAaYDukTaKwekuVhf6UaSH429yPlITGFIndAofIol7q6oIQD4cwzsvBCJlxKfkJP8fYOMYuqxTiwcqKJVC+7IZqw2hioiLKATg//HdGwRzm6VPMtlgRfI/LYBPqVIMyqS1lSx9r1bY1UWhz/feeIKXYWGmi+Nrty4ASE7smOYg1FxhffIyfaG3qDAtV1kmi7qca9FSWtPfB0rrvTDAIRKvGOZILboYN1gYqzK4roO4P9MSQ9dvQs4jp5SxJKDf6yKNTzAruS1Ybf8iMineJxbTmqcdlTEAOiVhsX/RNMQBwFGN2qiN2Ow1pa4D4xRy+lcX72tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IsvzINeDA1EmJW6/cTEZLWUzUcYEh0Adxx/Md7fx5zc=;
 b=KslqM4G+DLL9pvkQWA/DZRCmpk6kaHkkNVO/L+hoPQ0p5gXxCeaHStZ7lkJA9+3AHWFNMgiGlQ2e45hmy4Cx4RzjTi9M/gNs4eXzAAHPSxI9xu/Vw8AKdrY9mcGGGn6RX2aOhKDYLgjmNgp5RQkVNo+pi8rAeLcnX+qmHayVBCq9tKweTMUZiRUdIhZWzTUTJY5ugyqPG+MVPWCSJhjQ2uhyAGRhzqkPUavY8lDKeoKS3MmF2hefQqscHI3KsUl7R5znEZgXDDvEyoCsttCbAGTQBw2UjMQWSD+MFbtNxSTm9PmmxNX4XrW0pGBROhWuXJe+mt6B/BV21BhJ9olq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsvzINeDA1EmJW6/cTEZLWUzUcYEh0Adxx/Md7fx5zc=;
 b=vuCvn0tnw8iwM5/Hs/LUWvcTfm8ydzOTwtm4a95A/ZkzN8XgtX/nwzyYvgvlIO3RTrZfb2eZKRktrC2cVfAjcU12HJ8AVWakHvLJkXlryRzFwuZICP9k3MPZVNKFWsTq3bDq8TbGaDzlpZUwz33hbF78SVkxI9SbkpkM+gnJldM=
Received: from BN9PR03CA0962.namprd03.prod.outlook.com (2603:10b6:408:109::7)
 by BY5PR12MB4052.namprd12.prod.outlook.com (2603:10b6:a03:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Fri, 1 Jul
 2022 02:33:29 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::78) by BN9PR03CA0962.outlook.office365.com
 (2603:10b6:408:109::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Fri, 1 Jul 2022 02:33:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Fri, 1 Jul 2022 02:33:28 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 21:33:27 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 01/10] PM: suspend: Introduce `pm_suspend_preferred_s2idle`
Date:   Thu, 30 Jun 2022 21:33:19 -0500
Message-ID: <20220701023328.2783-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ceea068-d2dc-45d9-4114-08da5b0a1536
X-MS-TrafficTypeDiagnostic: BY5PR12MB4052:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ri8z5G/+PD7EEZFm+y8dyWYuKO5mg/9r9J1ZRBgjUbcel6YzdKgG8br0pIqZJ7DnRNQlr/cxD6oI+5jdncnHIHT3G+9r1bbHUM7ZQRm9P3YjxwO9m9S+bW3yyQ2OEByWfIHlVbbbTCTMZ5U4KaXGH2X2vzv99RPs0bj/OuhAabJzx0hWikZ91cmE340X82QyzCEMp/aYpRqW0Gf0LsAbHlb6B7zswHM0mJ4+tJzoKEuyd5e4hthhc/x5rbZI7XcxH2BDs2LXcJ9Jz4+X895t8LNqFst9LBES7Ilzodl9zhR11gYcqGKbGPUgVIkY7tbzjCjerdDEKmoQug+Pf9bYQ+NP9RTclrNsCANIGifJR33wFtXfMMiy92l6TOnUwqzwluZL4tjl6ZtfJ31xHGUaDnfvYxeyGRc8gJ3DrFiBopAS6m7fdxLYWb1yJJfZkXg0bArNwY1tOyah9YksMNDrG8n5jFLrpD+AEDtZR0jQ9IrSWx1qFEXQDZ3+qHHkdjC9X8InDZoCS7WBXIPf0NNNxxhiO8m8V2LQFMRopj305GIMbaC8WLjCTGsn4EfoToYkZ/FSrCtJHSV5ZODbDgpzujU889yTp+yySiwl1AF3QntS2L36g5geQmKW2oCYBSbvT64pUfQ+QacQXC8XBjtVYZdSY8mIO1ThurOmMJNmpsFJ5dJjGLthRtNRn6DjGusXQ007ICyuGw3h6164lrcZYJ14BhxnySexfqkpkBwMlrCqh6GBxP6DEW34k+PScMq1XmHR94z9g8JRohcL8eVwd8B5kUBU7pLczYToLAx14FWdqsTjXVDbjMgeYws+4c6p3BZP63sYaNIgEwyu5vEc2RHTZ+1jxWjYb4t1Ji2VHUo8KoUToUVKxZXxWE1qclxP
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(36840700001)(46966006)(40470700004)(41300700001)(6666004)(5660300002)(478600001)(82310400005)(2906002)(316002)(356005)(82740400003)(26005)(186003)(16526019)(40460700003)(81166007)(36756003)(1076003)(4326008)(8936002)(70586007)(86362001)(7696005)(15650500001)(426003)(47076005)(44832011)(110136005)(83380400001)(2616005)(336012)(54906003)(8676002)(40480700001)(36860700001)(70206006)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2022 02:33:28.9399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ceea068-d2dc-45d9-4114-08da5b0a1536
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many drivers in the kernel will check the FADT to determine if low
power idle is supported and use this information to set up a policy
decision in the driver.  To abstract this information from drivers
introduce a new helper symbol that can indicate this information.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 include/linux/suspend.h |  1 +
 kernel/power/suspend.c  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 70f2921e2e70..9d911e026720 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -305,6 +305,7 @@ static inline bool idle_should_enter_s2idle(void)
 	return unlikely(s2idle_state == S2IDLE_STATE_ENTER);
 }
 
+extern bool pm_suspend_preferred_s2idle(void);
 extern bool pm_suspend_default_s2idle(void);
 extern void __init pm_states_init(void);
 extern void s2idle_set_ops(const struct platform_s2idle_ops *ops);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 827075944d28..0030e7dfe6cf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -9,6 +9,7 @@
 
 #define pr_fmt(fmt) "PM: " fmt
 
+#include <linux/acpi.h>
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
@@ -61,6 +62,22 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+/**
+ * pm_suspend_preferred_s2idle - Check if suspend-to-idle is the preferred suspend method.
+ *
+ * Return 'true' if suspend-to-idle is preferred by the system designer for the default
+ * suspend method.
+ */
+bool pm_suspend_preferred_s2idle(void)
+{
+#ifdef CONFIG_ACPI
+	return acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0;
+#else
+	return false;
+#endif
+}
+EXPORT_SYMBOL_GPL(pm_suspend_preferred_s2idle);
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
-- 
2.34.1

