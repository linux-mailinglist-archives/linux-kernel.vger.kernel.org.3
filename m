Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B994EB1FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiC2Qnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiC2QnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD424B5F1;
        Tue, 29 Mar 2022 09:41:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7teMFSlL43QeXLl/RuzDyWMs/8jeSkxO6LpzyNhJFxm4oa7+VTbRI4ZAFjnc9d5TSPxlwVyCWJ7VfkQMUxNeUn+Crd69Y7iqOAFlt78mX3+dlyiKlNRk+R87MYFvX+ID415NhX6ng+fIHOEZVzWg5U7ZGPbJbTd4PQ2CpPeJQ5U3CKPFVOMkaZaJg9YHQUAWtYUjW79Y5dcsgZgsTzu9Qb8XAGnptYVom6I7AeDF5fqoSrISD8oh7OEmSZ8cygmvVMm3RgqgvXasuijiURWtt1PCmK9eqqHlzRpbi/OMARKEHET/eZe5jLUORbrwvR2Jq62UBjHLCf+SVrvTDHnlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mtNFohs/U1tWZRNn1oyc2ADDVyu8/D4lDo6Iid53kE4=;
 b=eSCfOAAtVM+pMBRaTcwHVViekDCL3+X7A/Zmzu3LM8/sY9tGBgDqbKqvXMIKamSBLfmRKA+v6V6SY2CA+lM4LC2BBa/+s3oAje9jOg41vX3alc5vVpS8IiP+B3+driQWbNd//nmzCsf7bm2WMr6gvRL00vpVB8+gtfrgB3qFqtR/lRjtp2ZpeY0NgGEJ4kZVeGo5aHat2T5NBMJ/yQfEhrISIhVrphRiSs39ppmx74BbkRgPBdPLQvKXx9X6GlBAXrpS5WKzJrEu9XWvw0wbCHY6Q+slpqiHci30deMqu5XfV+zm22L/HILLOh4Fn6x1zgBw8+h/MgKS1QLxUnODeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mtNFohs/U1tWZRNn1oyc2ADDVyu8/D4lDo6Iid53kE4=;
 b=XXAwv3aIOdHLqT96s3xcprVIKEo21g6H4ekcp+K1i1uORoQl77Semz+0SMVzVcy44L6S6x5wbtXDd+zkrv3G6/h65Es3Q71CUpnuEZ/GcpDesgEs5FyRO7/IO/coqo8pewKiXQXhvhAJQJRw5VAKZpys0rfHO6t2nALbFacPTWs=
Received: from MW4PR03CA0022.namprd03.prod.outlook.com (2603:10b6:303:8f::27)
 by MW4PR12MB5665.namprd12.prod.outlook.com (2603:10b6:303:187::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 16:41:26 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e9) by MW4PR03CA0022.outlook.office365.com
 (2603:10b6:303:8f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 16:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 16:41:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:19 -0500
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:18 -0500
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
Subject: [PATCH v2 1/4] crypto: ccp: cache capability into psp device
Date:   Tue, 29 Mar 2022 11:41:14 -0500
Message-ID: <20220329164117.1449-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329164117.1449-1-mario.limonciello@amd.com>
References: <20220329164117.1449-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB06.amd.com
 (10.181.40.147)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62a78c54-65cb-4f98-e2a5-08da11a2f6a5
X-MS-TrafficTypeDiagnostic: MW4PR12MB5665:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB56650E2DECB7FC17A8CF46DDE21E9@MW4PR12MB5665.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqJ0Q3QGjdgwg4aRj1HTHp56Ed9vUXqiwnnJ+lHECUzppqAcg2snOYHouv+BM/BAuOqFroyjddoWbGmJkQsIDor5gBvE5OyzEo5PeNxfymFVdQiTfVHQO9Iz/pyyFU/diN/gNrz3YOkY8MQaqxZIGdVhT05VTWiBQaiEkxVPIQXuYILuIUQbd1/f2VJzGK72GlbuSY5YuvGqUcI+xbaP3znYt61hYecjD0K44DhfDXx6kdlrvJzy6hVTOiQrwAv1t6EoUmNR1GvovkzvygD3xRsTfHubl/sN4xFgaz6i1Tq3KTHAaE8bBWL+8KDI+4AjE6/Xv605UYHxCcEadKDokl9wNdemY8U4ZceLDaLx/C9j35OP8mCS6QAhC8Sn0gesYlOivSPRBuxFQ8T4VQb6N+L9f0gIaz40L4kFDNUZvyde3bScgOX5CYnL3qHNRlUNQHZF7KltPRR23N0bDMUbuasix4aMmmTTP2/5GrIkjJ7iyZ+y4TdIIWbqpCKQp1L9JBCCWX896B2sxZ4QFO7yXzz+hKSdOC9M6265pNb8cqFVAC6NPm0fuIydPG1L9ml6nu6cVPbpNd3iXGIgjPFP8hOS1RaUb2+DDEtxXHsmYd2h/ysHUDxzbD6SKmZbYna0sRQ8WrltbmplzRizZdfWs2cV3XLoGq8w9ZWhsnlSsLpfMNpTMebJX/AivsluBz3dGBb2xoD19QiQUFFhoIEEkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(47076005)(356005)(6666004)(86362001)(83380400001)(81166007)(36860700001)(16526019)(110136005)(54906003)(36756003)(40460700003)(316002)(70206006)(508600001)(8676002)(82310400004)(5660300002)(8936002)(44832011)(70586007)(7696005)(1076003)(26005)(4326008)(2616005)(2906002)(426003)(186003)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:41:24.4912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a78c54-65cb-4f98-e2a5-08da11a2f6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5665
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

