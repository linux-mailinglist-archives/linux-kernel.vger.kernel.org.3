Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C2E517BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiECBan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiECBam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:30:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3AA220E6;
        Mon,  2 May 2022 18:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VtCqU6C+dP6nR+zrMSo5df79WH9hz3eCwVmJ0isY9s4w71/Hb6JiQA97nwGxtQQE177KhGlZvjxmeSRddayPl1zEzh5I4kEC0WO8MRF9HjlhODQgEg7CEZ8JeiYGobsegY0bQ6H2Eupag0l/EdFEa9O7zG9LsEHVbCW/r4XA2tnuKQQ14izR+VgLItwS3qeKI3hGffJHl2a2BB6UGka1RBa7RQ96pAk8M3kZPVBfMiI+OdDAAUrrzkVdQaNikYsa7q79mEHF/9jocGwT2ppbkyxXcGhF7s941r/eAaiYBjNE5pRVkErCQ8FYJSH8uMqkfJwjNqg2wQT4rUenk0ZIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOogBhO0a/Lz5j+NTG0CThQBOS39/Ip7HWEGaLa22Qo=;
 b=VMhAxx+ygBtvTUJZJPZDZTPyqoTY4eZCSho/0Ej+GncRCYyQjCgF5ywwd2KpMBEGVJzA1DlVjBD+s4cZR9jzOU2Pz4lNQvET9f29ZiQEUB3+o6YB68fG5Mi0WcbuUSvPfdmVgXJmY+6AwHBcA27+kAP7jbcEPi2TmLaOWuePuabF88TUY179TKjiEuzxPtgwBHyigdk8HWlOHsCRFaj+N4chDd5jSfl0dEbxO8sJPCTS5xJ+rOAUN1TtOt3MCdhsiqgC4hlFPCWjQ68tkFltahM1qNAK6OjKgDAbCrITl9CMfQZAe2+lueuURVn3083GIdOQvyp6ztbm97pKoUgEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oOogBhO0a/Lz5j+NTG0CThQBOS39/Ip7HWEGaLa22Qo=;
 b=0d7RBQs/7DraCfekzzXIA6TExVcaAVogzyCFma/jAd3NUoY/umw/dhtYfAfoRh8Cz3t1llsod9X46y4u6r465vi1rIivX3Y132aJobnzVQfjQ7nfOvqVK1+xfEOC/6Ghvbk7cAtMxD6r/mDYE99TBN+CoDNj+LKD4mmITdRl2xo=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by MWHPR1201MB0256.namprd12.prod.outlook.com (2603:10b6:301:53::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 3 May
 2022 01:27:05 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::2) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Tue, 3 May 2022 01:27:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Tue, 3 May 2022 01:27:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 2 May
 2022 20:27:02 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Pearson <markpearson@lenovo.com>
CC:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Gross <mgross@linux.intel.com>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <ibm-acpi-devel@lists.sourceforge.net>,
        "open list:THINKPAD ACPI EXTRAS DRIVER" 
        <platform-driver-x86@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Fix compilation without CONFIG_SUSPEND
Date:   Mon, 2 May 2022 20:27:00 -0500
Message-ID: <20220503012700.1273-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f1ad23-a02d-4221-f3a9-08da2ca4084f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0256:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0256D794AF7FADE41A0BF04FE2C09@MWHPR1201MB0256.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ub9WuejCM0av1GeihqxU1fUY/GljmOEm6OGcIiqmCCyHzm08v+oUG9chv6fGdCo3h7karZGB+rRxoP969wwoy+Obf/tZBi4XsV91TOJFuAegCW7xPl5ViTFmzriI1ng4O6L0i17X0wOTrMDZcLhec1nUfCP9khu6TWzEkY5MBbs4lt4DP5K+OoKZJ1lBqyHb9d4XYwrt4YFPVIYlYY6qmX7/Mlm7i1g5BNvIiseKqcf/AoFKyKZ7BDjo0Pthc0/XrB4zkH7rmmflz+qv/YlwfIn0Jm3hghFvbkN/NMcE2+6tuz1ymSEx0BhguVYvkl0d40acvQnXkBLJo8R42csPsYYsvBVkp+SenZgXVk+QIoiTr40yItMaNkKEfxV3qAYih48CwSrw0oCL7CmV7e3Z/IzrbujW/6WOK7uusLiuGPpQ8dMeu3Tk+FfGHFlKdaibZ/HmMPbmUPMeztO6+2g2enIp+LY3YqNpU3OdAhthKCcD7HbITVkrSQq8diCNWhmLbxu5tMRw8ha7cn5qZBtjpLg3FlfloDaV52Zh3EMdnTbXUNGtU3bi5hFs8x9HVpCntEO3xl4gWrljvZ0jlr2YTGVFJ5jk6/W9SS5K7LS6/XJ52hbAu8sJBMw2O2+ybRZiwwyVCKmjEZCHn8NCyOLUb0sAomNEvHGYFpOBeiEGn2sO/nqdxIlhLriXCaaZD4NvEIvr8oB+4ul4roUeUAPW/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(86362001)(8676002)(70586007)(4326008)(110136005)(70206006)(508600001)(36860700001)(82310400005)(54906003)(316002)(2906002)(36756003)(336012)(83380400001)(426003)(40460700003)(186003)(16526019)(47076005)(2616005)(1076003)(8936002)(356005)(81166007)(5660300002)(7696005)(26005)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 01:27:05.0187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f1ad23-a02d-4221-f3a9-08da2ca4084f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled without `CONFIG_SUSPEND` the extra s2idle quirk handling
doesn't make any sense and causes a kernel build failure.

Disable the new code with `CONFIG_SUSPEND` not set.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index f385450af864..2833609fade7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -4482,6 +4482,7 @@ static const struct dmi_system_id fwbug_list[] __initconst = {
 	{}
 };
 
+#ifdef CONFIG_SUSPEND
 /*
  * Lenovo laptops from a variety of generations run a SMI handler during the D3->D0
  * transition that occurs specifically when exiting suspend to idle which can cause
@@ -4517,6 +4518,7 @@ static void thinkpad_acpi_amd_s2idle_restore(void)
 static struct acpi_s2idle_dev_ops thinkpad_acpi_s2idle_dev_ops = {
 	.restore = thinkpad_acpi_amd_s2idle_restore,
 };
+#endif
 
 static const struct pci_device_id fwbug_cards_ids[] __initconst = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x24F3) },
@@ -11569,8 +11571,10 @@ static void thinkpad_acpi_module_exit(void)
 
 	tpacpi_lifecycle = TPACPI_LIFE_EXITING;
 
+#ifdef CONFIG_SUSPEND
 	if (tp_features.quirks && tp_features.quirks->s2idle_bug_mmio)
 		acpi_unregister_lps0_dev(&thinkpad_acpi_s2idle_dev_ops);
+#endif
 	if (tpacpi_hwmon)
 		hwmon_device_unregister(tpacpi_hwmon);
 	if (tp_features.sensors_pdrv_registered)
@@ -11743,11 +11747,13 @@ static int __init thinkpad_acpi_module_init(void)
 	dmi_id = dmi_first_match(fwbug_list);
 	if (dmi_id) {
 		tp_features.quirks = dmi_id->driver_data;
+#ifdef CONFIG_SUSPEND
 		if (tp_features.quirks->s2idle_bug_mmio) {
 			if (!acpi_register_lps0_dev(&thinkpad_acpi_s2idle_dev_ops))
 				pr_info("Using s2idle quirk to avoid %s platform firmware bug\n",
 					dmi_id->ident ? dmi_id->ident : "");
 		}
+#endif
 	}
 
 	return 0;
-- 
2.34.1

