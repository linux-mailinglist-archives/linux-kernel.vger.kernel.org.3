Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E3B4CB58B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 04:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiCCDwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 22:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiCCDwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 22:52:24 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F44C1405C5;
        Wed,  2 Mar 2022 19:51:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5jJouINcKbMoc5MSo7zdp+VK2x+VZKfCVMSNf2ZzbtX6pBdiwza1YDCaETot5aBRBA+1jEx6duRsUkCntDIhc2G+PfUavqA3GqMMjB0HKHr59HbhMD6HNe7PS8ZA/CR24jObE/9b40+N7r3VJ3Y/oKCL4Dad/qv8hb2XcOJR/C7OCLFmUxzWCIqEnASiEKhEHmO8cu6fzP67kxHaXDPpnRYmDFvb5i+pZI22p5uVqE1OLtj6n7NP50cvUH39FP5+YiH44fuDxJQrHtkIVHjtz4G74mZfE9Tjsjwm/54B4BUMq4OCsU/OtFMQLogAg/mcV/hSGnnsLWVvmH5Eaa80g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIctQZav3YSIb8sBPetf94C0BXcYO6Sqq6BRdIjJokc=;
 b=NsQ6QxsqSSENaDLf3fIDHS8WwQsmkAaQBP5xCideIGAXzUZUEbdLBMuiCJBvtkAXV59aTcmoHycsqcMQWfeVOf5kEqnagRDxfEAd9/t/x2gngsxbgYsVTVq+fpVrJxzh86ui12k1Sn0OSCiZQqjCFghnyfZn4oPUPKTzBKy+jS6yHs7T/j+c4cCPGKYpUmrIp/6uh9AhDaJ4Tgpg6NJ8vF6Djn6PXm1J73eLOZdL0/6wPDauuq4SIBDAJ0l0XQRRPs3l+iZ2St7/3uLc8dc6aP8NL5L16Z3oIc2IfNCGWxf+S0Bn+gMrMHk9IlxWZthlHIwhxOmtHCqnTTUStXN6mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIctQZav3YSIb8sBPetf94C0BXcYO6Sqq6BRdIjJokc=;
 b=tUg09tg1H760PXwVZcmU5DAT/mFFZ0pt5hIuPvGvh5qwcWfP8SVK7AdOeopvDwkZrC0J/w4dXYPNrkZQAnLqamJNuuJMXOAgkjg2aDE/FlSzKgx18MFaHQktjeai84526Pu8rtQ/qPvxXxOs8IN09o4EtktOKhU+ppjs78vBRAk=
Received: from CO2PR04CA0070.namprd04.prod.outlook.com (2603:10b6:102:1::38)
 by SN1PR12MB2574.namprd12.prod.outlook.com (2603:10b6:802:26::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 03:51:34 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::31) by CO2PR04CA0070.outlook.office365.com
 (2603:10b6:102:1::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 03:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 03:51:33 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 21:51:31 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 2/2] ata: ahci: Protect users from setting policies their drives don't support
Date:   Wed, 2 Mar 2022 21:49:12 -0600
Message-ID: <20220303034912.3615390-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303034912.3615390-1-mario.limonciello@amd.com>
References: <20220303034912.3615390-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30d4301b-cdcd-476c-8f53-08d9fcc91bfe
X-MS-TrafficTypeDiagnostic: SN1PR12MB2574:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB2574D7091CBF68DBD9DBD220E2049@SN1PR12MB2574.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JEEBXjGcWZe3ewBu5uhxhsus21JMFwWJUZutoCejHq14yF/mphIF1ypoDR5LIQHNVkFxTh5KC7od17D9fs3+RWC2Nt0Anq7MEDzNkZr3VXo8Cy4XwXOXoHU6xQnpnB10OOx6JLKbPZJPaJyHKU8hE12OW5syOs+wTvA5Lb54Txsbitoo9Ewh+Ua8nsLKyHj+1qOxIj9VMnHeyKlI+0CBsVbD8mwvKqTUdZBO13WHZfKoyoJdLSlKfBLWYy5V7WgEJRobJT78u93LYx6Jg2at85U7oj4smx1SpTMR6ZOADZcxovcObTiJgvVz3vKiBK8ONCwINIb69JiExi+a970pKiFkuVaGek4hSo8vAQYOb5hFiyvfqLlDczor9XuV9d4DqU3miiQsX/uZcbu+2jp3PFE9UkkAkwVgqnyA7rq0OpHbv0Ny5LIT2AvHGEvS0LO71pFVQrI4az7vkMMyXx2hgdUPaoe/DkhrgiowmHCegqbfo+CwVy7VmPsxzIPWLfCYTXNUmans7i8XEt6jzebYQDyWFhO4dsfUUou1WG93xJW9kN3XBuB3mqdNC1Dvp/Lch+tMhfkx+nNefqIhVxFAbVqe/gCigKYQkWGrBByYy0yD9L5VK1xzk7qnIIdaXnhJ09GgtXKIxyNpfrGQcpeZiYmExE/vdPbqBzCjoeXs6qNr3Q0EnvjudS4454yFggsbOoI8CDdtB9+sgAewbS7Esg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(4326008)(5660300002)(40460700003)(70206006)(70586007)(47076005)(44832011)(8676002)(336012)(426003)(16526019)(356005)(36756003)(2616005)(81166007)(1076003)(508600001)(8936002)(186003)(26005)(82310400004)(6666004)(2906002)(54906003)(6916009)(86362001)(36860700001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 03:51:33.6054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d4301b-cdcd-476c-8f53-08d9fcc91bfe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2574
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the default low power policy applies to more chipsets and drives, it's
important to make sure that drives actually support the policy that a user
selected in their kernel configuration.

If the drive doesn't support slumber, don't let the default policies
dependent upon slumber (`min_power` or `min_power_with_partial`) affect the
disk.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Changes from v1->v2:
* Move deeper into codepaths
* Reset to MED_POWER rather than ignore
 drivers/ata/libata-sata.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 071158c0c44c..0dc03888c62b 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -13,6 +13,7 @@
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
+#include "ahci.h"
 #include "libata.h"
 #include "libata-transport.h"
 
@@ -368,10 +369,20 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 		      bool spm_wakeup)
 {
 	struct ata_eh_context *ehc = &link->eh_context;
+	struct ata_port *ap = link->ap;
+	struct ahci_host_priv *hpriv;
 	bool woken_up = false;
 	u32 scontrol;
 	int rc;
 
+	hpriv = ap->host->private_data;
+	if (policy >= ATA_LPM_MIN_POWER_WITH_PARTIAL &&
+	  !(hpriv->cap & HOST_CAP_SSC)) {
+		dev_warn(ap->host->dev,
+			"This drive doesn't support slumber; restting policy to MED_POWER\n");
+		policy = ATA_LPM_MED_POWER;
+	}
+
 	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
 	if (rc)
 		return rc;
-- 
2.34.1

