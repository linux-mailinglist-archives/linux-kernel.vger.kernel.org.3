Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99914D8643
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiCNN5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiCNN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:57:00 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE2246664
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:55:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZID6BoQz+yQiwcAYiI/OL4Rh/Zrvvny33UQIXOsqRDUhbDISku2djYqcBONRJTPJQnvL1JaIEfP9fRSIBCEvT/UgHAsOephy74idMFIHtlW7GcVue8QNCuQVE0MOaTIaYxxfWo3rVe3RTwwMVAvtN/T+9VNUoxMva+0SXhUGOyHrMEJiwDLl784xN0mCWsaZH6tBZT6DXEDQOoG+NPgvLYcLLzp2PaeXnr9lq+NBFQHJVuvX7vz6S+45d4R+XTeeX0Vrlr7kOomBQ6nRDdYwtr6VD6qA3UUqWjHssmiIoPDETp/opTQbfbvRe8I5QQAf4uFYlDOlzBy9VQt+rn9Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=box0ifK6MdtZ6NUwtqf17AyrAAlhhyzzYQ9mfQ5VXtY=;
 b=XFiLj5GXcCeRGD30I9a7PO9IUtB5KDMNW+NXCDpFq6YQtw1h6wlqeBWOdLvWLuWCqacrsnGiaLErFJ+G7w6Q224rxZXj4b7l0GhWsfwH5PC9Rt6l3TzWTgWvIIF/saslKhJHyWpkAXIVUJ7f5S/6qwq5qqd5gSXHgo7S/9QRr35WKkDRhoriOe5XuMq29WkAkJ3I6aBe8VNT4lCQeT49KgI8JYPrZhwV5KCkEg37KDXxOCpYuz2G/rGhNXsCqlvOyB3yj9Voe9Kh1GAqriKRNY59Rb8OMbCJWg7U+7hnf5OdgKqr9c1Y7vTCx8+lsLv9wCsw+wxwokQAJThRO5/RoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=box0ifK6MdtZ6NUwtqf17AyrAAlhhyzzYQ9mfQ5VXtY=;
 b=02UvHGSn5iNRGBRSzCGFm3NzOu3qdE6Rs0nATeK79i17u0F/1EovjBLXirk9pOnRTICInbYKdaxSF3xsBMivaqRiqV+mwhrj67spQFhJUrCKp6cx/HCqQ/Y34Lo8DDeqbjO8ecGDnS9bzk1BBJQFuUFUbun/g5yyNVP+PY97Zpw=
Received: from BN9PR03CA0229.namprd03.prod.outlook.com (2603:10b6:408:f8::24)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 13:55:45 +0000
Received: from BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::76) by BN9PR03CA0229.outlook.office365.com
 (2603:10b6:408:f8::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25 via Frontend
 Transport; Mon, 14 Mar 2022 13:55:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT057.mail.protection.outlook.com (10.13.177.49) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 13:55:44 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 14 Mar
 2022 08:55:43 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <mario.limonciello@amd.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     Patrick Huang <patrick.huang@amd.com>
Subject: [PATCH] nvme-pci: Disable LTR for simple suspend
Date:   Mon, 14 Mar 2022 08:55:37 -0500
Message-ID: <20220314135537.1565-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 380f626e-2d72-468c-588a-08da05c255e9
X-MS-TrafficTypeDiagnostic: PH7PR12MB5734:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB57344907897A122A6827AB5EE20F9@PH7PR12MB5734.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33ClTEPxExz+vKXJFATrZXRIUYDBlSGukEJBUdtNp5IumvjvVqcSwB0AY2SVYBevMtJJwk1+m+Hw/rP7P6oU2rQwjOLi2lJCZ09VxgnHFMHnFD7YE7Cn1oCRSm84KHjUKqfGfR+tP0yEgkHw7PzuRuqzoleFD4/D7YFO5ohbf5vvx5gAOajADG4OfDFRwW7YQFGplCzlHqwBhrt+8NObKdasf6VPdcvSx41pmeH1AWLOw1yTZf8HY+eFauPL80JX+IyPS+wTu2mlyEoTw/kYjIC+FS+KlCcQIMDy5fIH7iIKV7kP+RQSjmYNJxcYpOJRINQzrtrh3bRPr1kEJeMtt6+UdWD9tHbXUEJfWUXvpsVb+ae1/VG99gXNnLHSGiCnM8Do+LPmaQmN/ao2PTPkBUADsbAMP+dQaWEMQd5+kcTi6uG/nCxFW6NdIVrKWgMGjweblV8mkQRjE2KwfaQepa10KxGAuF7zHr6NLi5X2AuDpyrWbYLcjQzJ3gxYMSPpt+xT0nAX0D8EKZaZsr2eQs51wcVOU/GxK7Ls+W+V1Tpkw0UzqvlyIzdSNNdTDmGYqlOkzEO1TBF0KixgqjwN6PZIzN8FDmMZC5PPUof2tobtRSdSgZ/gUDmEax4UjF1oyxkTAUrpOPXxz4hx7cBBdrEeLxyE+0+TJkzaxbvy9x14ZossAafj8K0s2rPCsBvExZ2O1wgUeSyVdoLDgwD+Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(6666004)(36756003)(110136005)(86362001)(36860700001)(2616005)(47076005)(1076003)(26005)(186003)(16526019)(336012)(426003)(83380400001)(7696005)(356005)(4326008)(8676002)(82310400004)(70206006)(70586007)(2906002)(316002)(15650500001)(81166007)(8936002)(5660300002)(40460700003)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 13:55:44.8715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 380f626e-2d72-468c-588a-08da05c255e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drives from SSSTC are showing stability problems after s0i3
entry when the Linux kernel is in s2idle loop if LTR has been
enabled. This leads to failures to resume.

This appears to be a firmware issue specific to SSSTC SSDs, but to
avoid this class of problem, disable LTR when going into s2idle and
simple suspend has been set.

Co-developed-by: Patrick Huang <patrick.huang@amd.com>
Signed-off-by: Patrick Huang <patrick.huang@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/nvme/host/pci.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..8d193c0842ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -139,6 +139,7 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	bool restore_ltr;
 
 	mempool_t *iod_mempool;
 
@@ -3214,11 +3215,30 @@ static int nvme_set_power_state(struct nvme_ctrl *ctrl, u32 ps)
 	return nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, ps, NULL, 0, NULL);
 }
 
+static void nvme_suspend_ltr(struct device *dev, bool disable)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	if (disable) {
+		u16 word;
+
+		pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &word);
+		ndev->restore_ltr = word & PCI_EXP_DEVCTL2_LTR_EN;
+		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+					   PCI_EXP_DEVCTL2_LTR_EN);
+	} else if (ndev->restore_ltr) {
+		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+	}
+}
+
 static int nvme_resume(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 
+	nvme_suspend_ltr(dev, false);
 	if (ndev->last_ps == U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
 		goto reset;
@@ -3239,6 +3259,11 @@ static int nvme_suspend(struct device *dev)
 
 	ndev->last_ps = U32_MAX;
 
+	/* If using s2idle with simple suspend, disable LTR to avoid problems. */
+	if (pm_suspend_target_state == PM_SUSPEND_TO_IDLE &&
+	    ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)
+		nvme_suspend_ltr(dev, true);
+
 	/*
 	 * The platform does not remove power for a kernel managed suspend so
 	 * use host managed nvme power settings for lowest idle power if
-- 
2.34.1

