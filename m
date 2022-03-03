Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BE4CBEA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbiCCNQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiCCNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:16:29 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2063.outbound.protection.outlook.com [40.107.101.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98716186BAB;
        Thu,  3 Mar 2022 05:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hc2NEHt0N3Ju+JtnNQ7/7tLS/LlX8eVtbJUrtrUNYUtHPIta8vO/tRRmc7ikzZ+gq7V7OVFiH36cGLSUwNkXAMW1QqtpOxR83yA5m8UtB5fj7M73T074uOn2BYflmbb1+0tjBZA1/YIaqurqVHlLY43CuIIEeRknpxfi0DGXmcSGqEjzsQbFZ9bUIcaf8qRZ9LfPT4eFu4RuryrvUKWvk5AAMCO9N0TQ3WNDult+Sebg/Giuy0fG5/+8q+jVu15V+KiZ2ksrfMtci+hZpjHv+nRSEkIBXU6yhYzdrl6J71xts999mgY8PXZaJw6KlePgEfCAGuZIL+2T5AYI2VZVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCY0PjvjQQIRh1jPG8Y2F1HEm/+uELb27my03YldztQ=;
 b=k4ibRkS9F934ydCpqkF6EC4bUgfIskDVtnaWhXUDB2kAQd4jPERCY4hYHaUT3DTyZPIsplLdVtW4orUWjhNnwtd6eRyoNVnApr9x9S+HgDCLRcnvwYs9sIfZKGwVbL9CuPcEF3paTm6Zcpyta1uBF8NpZr6TMUrtVMm0p6Gtyll54FNpV8z0OT6WDiIqa1HHyDn94leypNaIHYaCn1ENjraB1IFYrN2ezF8gaawATJzgfJKFIFBYKsuThH4OiXVfTIFSn3chttu46DOveajglIKKi2E75SEX1RYRtojgg4D0iAgVwvhT8NUxScWzCyirbGDBJPKWbKLfxwjUyaQL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCY0PjvjQQIRh1jPG8Y2F1HEm/+uELb27my03YldztQ=;
 b=N+n3211G9D7CeM7XkDx1q9IWyjzDh7oRAVWr9FzCGbGQBcqdeA4Nl7Ihru0FZarTmNJI3HDwrmD6zlvo9hSizj1IIyLlDO6h2CDijrI6MoQo+g9tvmttcYR9BFUXLtkfKlB8bnF+L6vU/Nin4EEv/SI04Gju9G17/O9NM/CpRgs=
Received: from DM5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:3:13d::18)
 by CY4PR12MB1224.namprd12.prod.outlook.com (2603:10b6:903:39::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 13:15:41 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::3c) by DM5PR20CA0032.outlook.office365.com
 (2603:10b6:3:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 13:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 13:15:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 07:15:39 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 4/5] thunderbolt: Clarify register definitions for `tb_cap_plug_events`
Date:   Thu, 3 Mar 2022 07:13:27 -0600
Message-ID: <20220303131328.4150454-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303131328.4150454-1-mario.limonciello@amd.com>
References: <20220303131328.4150454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6603b415-c5b2-4bec-08e9-08d9fd17eafc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1224:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB122486812C84BC1BDC5591EFE2049@CY4PR12MB1224.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uw7TrNw8UpSuy2O3MVbpCXyGjwNDHKjp+KEFSo8qoHsLOuAunOLYQ4ptvXDXdEwpgYACOFYLsEDLjnR3OI35nk+l2pLq2EtBc2M8+0FPOVgwnD1x7Bw1KQCWnX+OMt/VdX5QgwwmLM9BjKaO0BLBhhEtwKXfiDSPOP/oOV7OduN9+P07bYajCEJEeHYAstYsVIPvDQn4NusdbEeUg1fzICe8KE4QD0D0I6SdIA4cgnVD8pPHNHary99lXMWVElFbn1/Cj1HaF2OsB1VCqjdV15MaOeGdWHYtrLQi1DifuzVwwAoxIn8a3c3B7DPCX5jgIPCUYyuRZ9cy+EJN0sjvIabuHTnzA4jyb6F9bVVjLkdy+zfO6kQzpUSh6vKvzCOjULqeJCP5uHg4UCpIQPp7oBecwXYyCduAEf/oGEKD1jlkyiJvnSlq980cJGgf8q8QtKcuOgCVSoPWmcyjOYtb9xH0BYjPmJbAr9lvgqOhMmKwPJn1S2F1F/HfTJxg5/6nI1bM2uRCzDBrzZ8j9M1KGMkrKjCfqcQLzlGmG4+r/cO0CeHWY8jZ0XFU9SnjZFsJqhSTQyRXUjplb/2FVKhCICeInLRxRtmSXsLlwDGzcUnlkPo908mI72sfuA/FkhAnMOlzUt45ikbNlzBi4+BkAiKiHIBRInYkDrDvaqKwmc3D1Wc8u1MGt/NcLHHhCFVIS5FNNQnMiX1BwUyT+1jKyJp0O5XxMrF/guj+vI2wPLM=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(8936002)(70586007)(40460700003)(83380400001)(4326008)(70206006)(2616005)(2906002)(86362001)(26005)(82310400004)(5660300002)(16526019)(186003)(44832011)(6666004)(426003)(336012)(36756003)(8676002)(36860700001)(508600001)(316002)(6916009)(54906003)(356005)(81166007)(1076003)(47076005)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:15:41.7003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6603b415-c5b2-4bec-08e9-08d9fd17eafc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1224
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB4 1.0 specification outlines the `cap_plug_events` structure as
`VSC_CS_1`.  This shows that 4 bits of `VSC_CS_1` are TBT3 compatible in
USB4, but TBT3 controllers also support disabling XHCI.

Update the names and comments to more closely match the specification.
This should not change anything functionally.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
 * Don't reassign plug_events to 4 bits.  It's 5 in TBT3 controllers and
   4 in USB4 controllers that are TBT3 compatible but not actually used
   anywhere.
 * Rename prefix of CS_1 bit assignments
 drivers/thunderbolt/tb_regs.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 70795a2aa9bb..db3005cba203 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -146,14 +146,14 @@ struct tb_eeprom_ctl {
 
 struct tb_cap_plug_events {
 	struct tb_cap_extended_short cap_header;
-	u32 __unknown1:2;
-	u32 plug_events:5;
-	u32 __unknown2:25;
-	u32 __unknown3;
-	u32 __unknown4;
+	u32 __unknown1:2; /* VSC_CS_1 */
+	u32 plug_events:5; /* VSC_CS_1 */
+	u32 __unknown2:25; /* VSC_CS_1 */
+	u32 vsc_cs_2;
+	u32 vsc_cs_3;
 	struct tb_eeprom_ctl eeprom_ctl;
-	u32 __unknown5[7];
-	u32 drom_offset; /* 32 bit register, but eeprom addresses are 16 bit */
+	u32 __unknown5[7]; /* VSC_CS_5 -> VSC_CS_11 */
+	u32 drom_offset; /* VSC_CS_12: 32 bit register, but eeprom addresses are 16 bit */
 } __packed;
 
 /* device headers */
@@ -464,6 +464,10 @@ struct tb_regs_hop {
 
 /* Plug Events registers */
 #define TB_PLUG_EVENTS_USB_DISABLE		BIT(2)
+#define TB_PLUG_EVENTS_CS_1_LANE_DISABLE	BIT(3)
+#define TB_PLUG_EVENTS_CS_1_DPOUT_DISABLE	BIT(4)
+#define TB_PLUG_EVENTS_CS_1_LOW_DPIN_DISABLE	BIT(5)
+#define TB_PLUG_EVENTS_CS_1_HIGH_DPIN_DISABLE	BIT(6)
 
 #define TB_PLUG_EVENTS_PCIE_WR_DATA		0x1b
 #define TB_PLUG_EVENTS_PCIE_CMD			0x1c
-- 
2.34.1

