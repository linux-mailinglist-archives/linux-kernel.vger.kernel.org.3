Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E07D4EA5D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbiC2DRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiC2DRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:17:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B3118D994;
        Mon, 28 Mar 2022 20:16:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRT+uJ4W7ia0p9qJaHnZOp69Ne30Xan02UPIWT4+KhtQfvMGA18MeUqeo9kTU4fLbugoqNTuW/MhokomLx8acQRKfqIt1aE8+t5DINRByvuDWPOZqz8BiHyZRXSHqW0DSewdi9Q7LRQ3e9cLJsyLzWnupHXGaeWiCOq2aMImkNkjyvx7/2j9yofKkjvXh0vehu4wbFKdA/q4FhCtTXjij4YdhxSj+bTZPe4dGqRgRWh8KxyiZyEls5Ig1qj+WjqL73j8b7ZjGoqztWk1Ov7RV1cF0/QLGeu3pIdEVr3SeW/A4BI/QaR/6hq4+soLwht2+1vAzCsqdEqrzwCKPqh5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtNFohs/U1tWZRNn1oyc2ADDVyu8/D4lDo6Iid53kE4=;
 b=BYwIZ1f8VLDKuu9FbzJwGTLIa5JF48z8ACfImveRGOvWZ5zO/CyWvkQrpv3X1SS++CXOMFDvvR0DMJE2c2/m4gEWO0bYcPCSTcbNXmo1JnP6fAy3uNlq8nL3tySR0Hs9fq4/32Nkk8795Rw4xF9eWH2VRW/yiThIJJYoHAF1ljhDpvz/LfxMJ4T12AYdDVfLE/4raBEI46uEcYkrdJFSh4QaCPtZ+sZckdQCJeNRAdgf2eQdSmtwmtMWNPPA0gfV9A9e5rmqcDtDEo2bVVFrTIySS4JBnvK3jr5aEdILK2LUvOH6Bb+15CuIaXVy3ReCJ349uP8UgS7iIEkpFBVk/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtNFohs/U1tWZRNn1oyc2ADDVyu8/D4lDo6Iid53kE4=;
 b=STWNC7QhtCVENCdEtvtHk7+Vz97HUJuz7BFsBItGl2VKj2g3H+Lj2LBIzxV/FdyYFHfu52pXJ+9hTRC/VWNAy49d/ocxSZB8JqkaSk+8etX7gqDXFELO9MpJs19NNVENE2v0a/gq/iMy9gTjLfjroDqvYSB1Aidu3O0qbjjh/JY=
Received: from DM5PR19CA0042.namprd19.prod.outlook.com (2603:10b6:3:9a::28) by
 BYAPR12MB3512.namprd12.prod.outlook.com (2603:10b6:a03:134::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Tue, 29 Mar
 2022 03:15:56 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::51) by DM5PR19CA0042.outlook.office365.com
 (2603:10b6:3:9a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23 via Frontend
 Transport; Tue, 29 Mar 2022 03:15:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 03:15:55 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 22:15:53 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
CC:     open list <linux-kernel@vger.kernel.org>,
        "open list:AMD CRYPTOGRAPHIC COPROCESSOR (CCP) DRIVER" 
        <linux-crypto@vger.kernel.org>,
        Kerneis Gabriel <Gabriel.Kerneis@ssi.gouv.fr>,
        Richard Hughes <hughsient@gmail.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH 1/4] crypto: ccp: cache capability into psp device
Date:   Mon, 28 Mar 2022 22:15:50 -0500
Message-ID: <20220329031553.798-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082cc340-5e21-4029-fa75-08da11327016
X-MS-TrafficTypeDiagnostic: BYAPR12MB3512:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB35129BFFABE852766733506EE21E9@BYAPR12MB3512.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3I5lKmia2sBrXJrDlelDlsJ7CyX9+37iLgl/RfvpQ7tMdAQ2dzIJvSYXh9lX5b88NvbbwjlZasrc8ry5kNTaDesnqmXvPzfofH1O4At/NtmH+tkae8yPD+tJYf91ZUCD1sdrPIg/amGK11lzmH+IvoNmEfvftLwOSzanfLlK7aAhHXsZC+LC6Bqf54hoFZB3kFfxfxChB9HWIHdrgm3ZCJrxmarnxcuD7I85T8H2U8eBfWUjUD9bErWHT39nmXAN/Vr01eyy18AHFOGDzQtz9YSRFcbKNvR+7NomMmNvx4cYZY6OzYoW6Y7WAnDrTk+74VhwI0eHyvWsDDeJ6Ph+MPOGmxGtwlyjwp5nk241wNw+uP/Z7psY8I3jdvye3T+yhhExNPYhR+NN/dUQBp4cZ/ni3vIkcifs7aVINDiHzji+H7qxYr2QzOD9LFtWay2EC6YSFXcOGqblIMbV7wviS8oU62DJ+Sl6o/p+Q930Cz25vLyEe3sPniTGv6a/367kD+P4PXYJw5+EBSgN+N7pWvW+S+z7fp19aEHbB5W55xWD2pJ28Vxi48Ikw6gL1v9LZPOQryv4CwSwThOUjjGGuyoqUkznaFg+YF7qEO5tGU1RRHNxhbvFEEawFRiWpUPpR0PR3n5zJVY4iiPUPucAP5N51YdKJBNdtffx/rP9aUFf1MCQ3N4q/6ohneHTB0pPSWLwmrQVWIPvEHcnnOJ0qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(8676002)(336012)(70586007)(2616005)(110136005)(316002)(86362001)(70206006)(7696005)(508600001)(26005)(82310400004)(1076003)(16526019)(186003)(83380400001)(426003)(54906003)(40460700003)(81166007)(5660300002)(36756003)(2906002)(356005)(44832011)(36860700001)(8936002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 03:15:55.1843
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 082cc340-5e21-4029-fa75-08da11327016
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The results of the capability register will be used by future
code at runtime rather than just initialization.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 37 +++++++++++++++++-------------------
 drivers/crypto/ccp/psp-dev.h |  5 +++++
 2 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index ae7b44599914..8cd404121cd5 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -70,17 +70,17 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 	 */
 	if (val == 0xffffffff) {
 		dev_notice(psp->dev, "psp: unable to access the device: you might be running a broken BIOS.\n");
-		return 0;
+		return -ENODEV;
 	}
+	psp->capability = val;
 
-	return val;
+	return 0;
 }
 
-static int psp_check_sev_support(struct psp_device *psp,
-				 unsigned int capability)
+static int psp_check_sev_support(struct psp_device *psp)
 {
 	/* Check if device supports SEV feature */
-	if (!(capability & 1)) {
+	if (!(psp->capability & PSP_CAPABILITY_SEV)) {
 		dev_dbg(psp->dev, "psp does not support SEV\n");
 		return -ENODEV;
 	}
@@ -88,11 +88,10 @@ static int psp_check_sev_support(struct psp_device *psp,
 	return 0;
 }
 
-static int psp_check_tee_support(struct psp_device *psp,
-				 unsigned int capability)
+static int psp_check_tee_support(struct psp_device *psp)
 {
 	/* Check if device supports TEE feature */
-	if (!(capability & 2)) {
+	if (!(psp->capability & PSP_CAPABILITY_TEE)) {
 		dev_dbg(psp->dev, "psp does not support TEE\n");
 		return -ENODEV;
 	}
@@ -100,11 +99,10 @@ static int psp_check_tee_support(struct psp_device *psp,
 	return 0;
 }
 
-static int psp_check_support(struct psp_device *psp,
-			     unsigned int capability)
+static int psp_check_support(struct psp_device *psp)
 {
-	int sev_support = psp_check_sev_support(psp, capability);
-	int tee_support = psp_check_tee_support(psp, capability);
+	int sev_support = psp_check_sev_support(psp);
+	int tee_support = psp_check_tee_support(psp);
 
 	/* Return error if device neither supports SEV nor TEE */
 	if (sev_support && tee_support)
@@ -113,17 +111,17 @@ static int psp_check_support(struct psp_device *psp,
 	return 0;
 }
 
-static int psp_init(struct psp_device *psp, unsigned int capability)
+static int psp_init(struct psp_device *psp)
 {
 	int ret;
 
-	if (!psp_check_sev_support(psp, capability)) {
+	if (!psp_check_sev_support(psp)) {
 		ret = sev_dev_init(psp);
 		if (ret)
 			return ret;
 	}
 
-	if (!psp_check_tee_support(psp, capability)) {
+	if (!psp_check_tee_support(psp)) {
 		ret = tee_dev_init(psp);
 		if (ret)
 			return ret;
@@ -136,7 +134,6 @@ int psp_dev_init(struct sp_device *sp)
 {
 	struct device *dev = sp->dev;
 	struct psp_device *psp;
-	unsigned int capability;
 	int ret;
 
 	ret = -ENOMEM;
@@ -155,11 +152,11 @@ int psp_dev_init(struct sp_device *sp)
 
 	psp->io_regs = sp->io_map;
 
-	capability = psp_get_capability(psp);
-	if (!capability)
+	ret = psp_get_capability(psp);
+	if (ret)
 		goto e_disable;
 
-	ret = psp_check_support(psp, capability);
+	ret = psp_check_support(psp);
 	if (ret)
 		goto e_disable;
 
@@ -174,7 +171,7 @@ int psp_dev_init(struct sp_device *sp)
 		goto e_err;
 	}
 
-	ret = psp_init(psp, capability);
+	ret = psp_init(psp);
 	if (ret)
 		goto e_irq;
 
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index ef38e4135d81..d811da28cce6 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -45,6 +45,8 @@ struct psp_device {
 
 	void *sev_data;
 	void *tee_data;
+
+	unsigned int capability;
 };
 
 void psp_set_sev_irq_handler(struct psp_device *psp, psp_irq_handler_t handler,
@@ -57,4 +59,7 @@ void psp_clear_tee_irq_handler(struct psp_device *psp);
 
 struct psp_device *psp_get_master_device(void);
 
+#define PSP_CAPABILITY_SEV			BIT(0)
+#define PSP_CAPABILITY_TEE			BIT(1)
+
 #endif /* __PSP_DEV_H */
-- 
2.34.1

