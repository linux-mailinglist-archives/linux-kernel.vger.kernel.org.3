Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A585140BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 05:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiD2DIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 23:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbiD2DIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 23:08:32 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2621C84EFB;
        Thu, 28 Apr 2022 20:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjEw5oqWgzjzzLcneUTed7nXKWPAqIqhUrBxBv2lK1Y9wgKFWVJP1aog5ifCQOLhmfhoROCZhmKtpq9lSu2rGFhS58LgJKVgbJAk966L982oQ3WPovNDKqsKvQXo1M4nX3eagXxFR5jp0GEJBLG7OaGErpAQfEvzUIXe84Koy2ZQR1TkUyiwtKYZrfkDdd/pKmogbiSAR19qZIBCOAtTlT2q3DFy/0g6MgHk/bgOf0yDAiasTBCvjMy5wOtD/7qyqhBuZhi7e8ht+/afKxg0y2pRKr0LtOUsQicQYyDOA0qMkjs8UHL2QPSHFM8MwFwCgl57pCQ9myy5oHocLjRqIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F4I+H016npTBsnXz8iKlWPLUzRJ0uy3/KKLwhz1lI8Y=;
 b=QJ3BXPvhxoPiQ3bLVTuD5L2UoEkDZvI1EtbAhRjpJENClPbiI6uKZQ5kRJRUCmhiOSWRT6ccyxcUTRVp9yq5GSsvNKKmwl/m8tkgGCHSCSHyMKTQiwdnNDvHuMtHdlNALkl4Xe27KL61u5gcctE3CUnQVakjJG+jZU/QjN1dXAp+mOvw9+iuvfTq705xZa8HXFT41Gvy15uW0aRVLu6MUB4j07Kzor/MVSpvbZ3PEbieSMiv+lwT8jrMTj4YopTgyNzaanfDZi5HF0cExUy3CaECNOYg4dlcvuYac7ebTR0dS+/eAYE9h1RgoglbsKg3fE6oQIcJDKDjGHaqkfx1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F4I+H016npTBsnXz8iKlWPLUzRJ0uy3/KKLwhz1lI8Y=;
 b=V4HkTo8lV02hQvcYMSGElfCCVuVqYFjXwO/7ol7dlEvibd9oQLT81uJRN7wT+XWWP5hmYnXWSF6eUnfDGFnsUI2jvVrjFMvAwvuKdjyxYlxl63awujqpuihzgUMJnaritGnV+0Y6cmfhfceXocUDMbHa1l5QwiKc7dPjIC4v6g4=
Received: from BN9PR03CA0561.namprd03.prod.outlook.com (2603:10b6:408:138::26)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12; Fri, 29 Apr
 2022 03:05:12 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:138:cafe::8d) by BN9PR03CA0561.outlook.office365.com
 (2603:10b6:408:138::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 03:05:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 03:05:12 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Apr
 2022 22:05:10 -0500
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/2] platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
Date:   Thu, 28 Apr 2022 22:05:00 -0500
Message-ID: <20220429030501.1909-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429030501.1909-1-mario.limonciello@amd.com>
References: <20220429030501.1909-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f74d939-5b12-4d6b-1320-08da298d13ae
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB2636DE134E3028093379467DE2FC9@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlYh3dh6RO6FiyWnBaVQA0bHqCBZnL7KEpBXz9PkcYw0cNh+uIDG2wxV6rrdiRcNt6qmhAgMT+42NxRHhKVjqnsIW/I+sn2mAo62DLiLAFuiiKahnhTkpu12TMSUfjHhPNAoBJmmMHkplf/lWqc7UmlZa9Q/H+sPyNKgf8pVjC5RIqpy/B9GMO5XTU6qKhc486m3g068SJcM0gSORKnnLcJ1h6V8kzspwksT4f05lpgaEgdDC5UF/hbKXrzISmtyaBydO6HKHso8aj8ufEKOC5GZTri1ZIPU8HB9x/GIwZJ8gDZyjdK9KItbWrGrskyX4zChKea5V/M8L7ud+fq1kLp2dCsoox3thGkBh5wE7FaTJdwnjd/z3aAXzgA/cn3iuZdo36qjdsMLgfrPVygu4DsXjAQa5XYdaKZs0A8MEeXmzUVFDn+jIowKJyduK7RVY4Ht43pzMqnL7zelgEwBZPW2ZtLjnOe0GgC6IyUjaU0a0f/2/6W/gbJAx5xhyJVMZEzBSLTr1VUXr7eZL4G1FX6orQlgshCz5A+VbYc9LRjqoz5xyXB9WK5cDGyx0tfB6eaQWOP2sKgd6danBry/42/qbXdtcs+DfkJUicMYtIW29PIJZNLsXPmSu1zHjT90R1BZCUuwlAStQo6TPpUuidne6ianuXNCFEq64r+eBGn8XsIarOU94C40LCND3ALUf4aId+JIGNJX/4hZAG2eHg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(16526019)(186003)(7696005)(70206006)(2906002)(36756003)(70586007)(44832011)(83380400001)(5660300002)(316002)(36860700001)(4326008)(8676002)(8936002)(110136005)(54906003)(336012)(426003)(2616005)(86362001)(40460700003)(82310400005)(47076005)(508600001)(81166007)(356005)(6666004)(1076003)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 03:05:12.2868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f74d939-5b12-4d6b-1320-08da298d13ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMI matching in thinkpad_acpi happens local to a function meaning
quirks can only match that function.

Future changes to thinkpad_acpi may need to quirk other code, so
change this to use a quirk infrastructure.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c568fae56db2..f49f59130c3c 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -309,6 +309,15 @@ struct ibm_init_struct {
 	struct ibm_struct *data;
 };
 
+/* DMI Quirks */
+struct quirk_entry {
+	bool btusb_bug;
+};
+
+struct quirk_entry quirk_btusb_bug = {
+	.btusb_bug = true,
+};
+
 static struct {
 	u32 bluetooth:1;
 	u32 hotkey:1;
@@ -338,6 +347,7 @@ static struct {
 	u32 hotkey_poll_active:1;
 	u32 has_adaptive_kbd:1;
 	u32 kbd_lang:1;
+	struct quirk_entry *quirks;
 } tp_features;
 
 static struct {
@@ -4359,9 +4369,10 @@ static void bluetooth_exit(void)
 	bluetooth_shutdown();
 }
 
-static const struct dmi_system_id bt_fwbug_list[] __initconst = {
+static const struct dmi_system_id fwbug_list[] __initconst = {
 	{
 		.ident = "ThinkPad E485",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20KU"),
@@ -4369,6 +4380,7 @@ static const struct dmi_system_id bt_fwbug_list[] __initconst = {
 	},
 	{
 		.ident = "ThinkPad E585",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20KV"),
@@ -4376,13 +4388,16 @@ static const struct dmi_system_id bt_fwbug_list[] __initconst = {
 	},
 	{
 		.ident = "ThinkPad A285 - 20MW",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20MW"),
 		},
+
 	},
 	{
 		.ident = "ThinkPad A285 - 20MX",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20MX"),
@@ -4390,6 +4405,7 @@ static const struct dmi_system_id bt_fwbug_list[] __initconst = {
 	},
 	{
 		.ident = "ThinkPad A485 - 20MU",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20MU"),
@@ -4397,6 +4413,7 @@ static const struct dmi_system_id bt_fwbug_list[] __initconst = {
 	},
 	{
 		.ident = "ThinkPad A485 - 20MV",
+		.driver_data = &quirk_btusb_bug,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_BOARD_NAME, "20MV"),
@@ -4419,7 +4436,8 @@ static int __init have_bt_fwbug(void)
 	 * Some AMD based ThinkPads have a firmware bug that calling
 	 * "GBDC" will cause bluetooth on Intel wireless cards blocked
 	 */
-	if (dmi_check_system(bt_fwbug_list) && pci_dev_present(fwbug_cards_ids)) {
+	if (tp_features.quirks && tp_features.quirks->btusb_bug &&
+	    pci_dev_present(fwbug_cards_ids)) {
 		vdbg_printk(TPACPI_DBG_INIT | TPACPI_DBG_RFKILL,
 			FW_BUG "disable bluetooth subdriver for Intel cards\n");
 		return 1;
@@ -11496,6 +11514,7 @@ static void thinkpad_acpi_module_exit(void)
 
 static int __init thinkpad_acpi_module_init(void)
 {
+	const struct dmi_system_id *dmi_id;
 	int ret, i;
 
 	tpacpi_lifecycle = TPACPI_LIFE_INIT;
@@ -11623,7 +11642,10 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.input_device_registered = 1;
 	}
 
-	return 0;
+	dmi_id = dmi_first_match(fwbug_list);
+	if (dmi_id)
+		tp_features.quirks = dmi_id->driver_data;
+	return ret;
 }
 
 MODULE_ALIAS(TPACPI_DRVR_SHORTNAME);
-- 
2.34.1

