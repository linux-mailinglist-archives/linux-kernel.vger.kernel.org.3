Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A781D4F1AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352065AbiDDVSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380363AbiDDTrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:47:24 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD631230;
        Mon,  4 Apr 2022 12:45:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xj6PKB/SHDaBwRbsFQJmo+M/np/oNnlJppq1u1m7xgFQriAaLkXzPtbfZSF/0oA3Q4PN6UIaXcByjtiSbRxHj+uU4lVRScLFB7XHpBqk5Bf0CGa1+51kb0C+csDWTjJ9nifZVoIZJQGX+qddWAx/FZAdHhQQhSRRc2eGuuUt+mdoasi52RN88gBjkFuWTuw7/CcMdfmYsa0HDkrouQgH36nIldFD8VUdaw9bRnmvoQQoyFbKyXIMOh3c9Q2b6HbhlNEyO2PNMbml4qAuX76UsU7LAFJm4RObyV0l07JzBH5VtIRUaY3wtPA50G3vpryqML1pWjBm6edzBGLP+L0d7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdERx16PR9HHajtUTwXW/lEFDHIP70JfKe8a+jmXIAE=;
 b=nTrvf49ecL6/RB7AE8c8WfSgfD/jk4DK4jOJt9ObTjHpKf3uO8xWxusXYkVHJRZ1zH5QtwCvR0lsmWNRSh5g6XgMYeJcV4iKkzQjt0N5b9T9w4FqxtVLmXvH3sstB/PR/bxkbtnt9tjeWfW1DSzshpvTSkHjiCjvELpsAE/gc6SOcG6ItkWC07B/5djSC6e5O7uvhGbREla92QdGMl17dIzXUTJkWjSO5WeU5xX8l7P7yKE7/AHaVfJg0b6+K8z0Oi5aK8/+hfr2m9OoT+VoUlSdQob8nqSjLzn3cwmcXWIu5YUpapw9iakKpHMRHAVHqpzNAcCytJbe5M3sDzShHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=opensource.wdc.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdERx16PR9HHajtUTwXW/lEFDHIP70JfKe8a+jmXIAE=;
 b=Y21A2tqIGU0AO0UcGnKXSKQU2mVSN9lT3Sl8WIzJC7n8ndWdUlxLLBy7hHccBA+HBhErBXVUKbrzHjuErgMh/zrtPJvl8DRVTy5EyhhZbkNCmWOPAj19rs3zd79JaTwX/diB5hNC++kD6OSLrfXraoPT3Sf3y7cOH/I7rm/aStQ=
Received: from MW4PR04CA0061.namprd04.prod.outlook.com (2603:10b6:303:6b::6)
 by DM6PR12MB4793.namprd12.prod.outlook.com (2603:10b6:5:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 19:45:25 +0000
Received: from CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::64) by MW4PR04CA0061.outlook.office365.com
 (2603:10b6:303:6b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 19:45:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT029.mail.protection.outlook.com (10.13.174.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 19:45:25 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 14:45:23 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 2/2] ata: ahci: Protect users from setting policies their drives don't support
Date:   Mon, 4 Apr 2022 14:45:10 -0500
Message-ID: <20220404194510.9206-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220404194510.9206-1-mario.limonciello@amd.com>
References: <20220404194510.9206-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a49ec5e-07c4-400e-c32d-08da1673a9f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4793:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47931ECE876425C83AE07F6DE2E59@DM6PR12MB4793.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwSXqcNLXE9M65Re3krOmLC5bXlnTnSlpzMqrix0eBt1wHqInClt81Ubty/VvxPHab2k5KoNeS0pEJoLPWT5ACgoznVXjXLvqXU9HGWwO1PbpfMyYcvAQc/kTCsVOQLiE1PNzKgKgk4Y/FIeALeL2AF1xwSzYi0wfjzrTX9WVMetg8wZs8BxmDRxGb/4b/eKVndjnCtG3pQAlS5sE3n/1lgsgjXvktUUaz5lKk5StD+8bmWRmc49lvDqzmvTNMA4sHCTg1otS8VKT2GvBHbN2r6N3G3pqaqJQm6NKva5iepsNcySaKsn7TTS4C/vR/u5NIcOpOejXvD8F5XItYWNl8nCiCq7r3SbiOGTFsQ8cPqgnlyJ1yUiF9eMXwggDsHWYshzAnkFO1upPw/QITiiJKXMp3CFN3Nk+HgVFDO3r/z+6YjKCX0qZZ9h0qJslSu36qGG+mPz+VoEUl1OWogDksnDO5TUZzneUr0hGkrSk1ah6t925hhr+D9Q8NGLflbz27OYr+lkBlzu7fGSEs1X5qH/iNsDpEHALViNJsRMIfy0AlrR8ngVzpSfnpc8dQI90wl/G0C3IFlJjNbm9YkWuXSD70O/j9pESKZN0hm0rnKPoefW0wR5zbE9zFA7C6cZwFEAwR8YTbOAB0aHZuwWKrMXYxxVYhbiFuVwFz5C5TENE5VxfI9A72vJ1PULdtNIIajXgUBBTs1qa8LSjCnu2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36756003)(356005)(36860700001)(86362001)(6666004)(186003)(508600001)(336012)(26005)(2616005)(1076003)(16526019)(426003)(7696005)(81166007)(4326008)(44832011)(70586007)(70206006)(6916009)(8676002)(316002)(54906003)(40460700003)(5660300002)(47076005)(2906002)(82310400004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 19:45:25.2806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a49ec5e-07c4-400e-c32d-08da1673a9f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the default low power policy applies to more chipsets and drives, it's
important to make sure that drives actually support the policy that a user
selected in their kernel configuration.

If the drive doesn't support slumber, don't let the default policy for the
ATA port be `min_power` or `min_power_with_partial`.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Fix typo
 * Try to reset to CONFIG_SATA_LPM_POLICY unless that's too aggressive
   then take MED_POWER.
 drivers/ata/libata-sata.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/ata/libata-sata.c b/drivers/ata/libata-sata.c
index 044a16daa2d4..b41de7e03dce 100644
--- a/drivers/ata/libata-sata.c
+++ b/drivers/ata/libata-sata.c
@@ -13,6 +13,7 @@
 #include <scsi/scsi_device.h>
 #include <linux/libata.h>
 
+#include "ahci.h"
 #include "libata.h"
 #include "libata-transport.h"
 
@@ -368,10 +369,21 @@ int sata_link_scr_lpm(struct ata_link *link, enum ata_lpm_policy policy,
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
+		policy = (CONFIG_SATA_LPM_POLICY < ATA_LPM_MIN_POWER_WITH_PARTIAL) ?
+			 CONFIG_SATA_LPM_POLICY : ATA_LPM_MED_POWER;
+		dev_warn(ap->host->dev,
+			"This drive doesn't support slumber; resetting policy to %d\n", policy);
+	}
+
 	rc = sata_scr_read(link, SCR_CONTROL, &scontrol);
 	if (rc)
 		return rc;
-- 
2.34.1

