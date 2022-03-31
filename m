Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959D24EE318
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241691AbiCaVOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241645AbiCaVN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:13:56 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D504422B6EF;
        Thu, 31 Mar 2022 14:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqx5mQpXRydIcFTGKNxhZehMG9+6n/iioUQ2JJFlDOWUP5LJp7HKKNSDCiSNGDvSoWfUsJqR+X2quUYae/r3Q39hGLGqMPJ4fPDUqkMJyQG03+3qxUDzTWYMzV8BP58h96V+5Beiye4dGgYoWLqAAWEMlgBmknePBcCywnEEGMriQkhQBOHUPcAghXTt+ziSyNM4cia1dhcC11wNwTQESgppQGIyqZPe3mtaldWifpfp4QP7SC9yqMddFwhZFovIKpGWoLFufOr7vFZvQ+TzX2Nvl3CKiBw15kqjkl/9LnowNzSrgmmfACgsxni7btqY1XIzB2EzWMh3Axy704F/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2co5/rOsE00fTAmw0G6l6ePxmNfTTKvFhHjEQWydebY=;
 b=RByb9MzrQWixMVpJhYlpi0+DzFalG4Q8sms4983lEML1KJOdw8ZBHbx0MkkBDFEzB9MDHz66W68/nLjqvh+qCKyp5JothlpQFj39F72lKYp1Pm5xFhpCHD6J3JYRf1yFv1fDyXj7XTHM3ahopwwOZPsN8rAFd5xXC9QudHObr47CWPrLIcyuJef9E12uChVgfM36fmoVosQIu6StPkydnpS7Dq5ar9bJN8QlSmEHcPhyskYQGotawagMCRuTl7rOFeIhYwDn4Hnnau7tzbl/mObU8C197+nzBUC/BMh6bbsoyBS80QsjKomaebE1LcOJvFUL51//rPHj36mFuLfjRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2co5/rOsE00fTAmw0G6l6ePxmNfTTKvFhHjEQWydebY=;
 b=YK+qYwWyWZB6O8vd577+jbZNakD595pXSYL67mHw5cwBx3dhOb27Zj6aWrdhpjUZBDkPW8n6cptsg9ZTNryFUfwst/665SviZe/LJmG9wT93cVEwLojHRGmvVW0btr4pe4OmwrE7TQaq6PPYfrYyQ8fS0jHBgjCHZAsvlqKGG3s=
Received: from MW4PR03CA0135.namprd03.prod.outlook.com (2603:10b6:303:8c::20)
 by CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Thu, 31 Mar
 2022 21:12:06 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e9) by MW4PR03CA0135.outlook.office365.com
 (2603:10b6:303:8c::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Thu, 31 Mar 2022 21:12:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 21:12:05 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 16:12:02 -0500
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
Subject: [PATCH v3 1/4] crypto: ccp: cache capability into psp device
Date:   Thu, 31 Mar 2022 16:12:10 -0500
Message-ID: <20220331211213.2844-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331211213.2844-1-mario.limonciello@amd.com>
References: <20220331211213.2844-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b5297ea-cde4-4f28-055b-08da135b1bd0
X-MS-TrafficTypeDiagnostic: CY4PR12MB1494:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1494F051AECD001CCA3A28C6E2E19@CY4PR12MB1494.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fGZ0mW5RzgSXTosNQhLSxW8IMIT/MOpL3q1LrDTTAEYqjSFi/UtRB2pKgkpMzBWU58Y+9spZvbh+INqDh0Lkcl5GD5YLRbEhzXuPjW85JQqxqd2/SQ2bTHmpRkaD0MlMrzbHwzIof7fNJ4lm1ByL9sPbwkZd5HnvVbkUBPq7vmSQRz3lFIyf8eLCSDwNL+EdYLw/UteSkFyruRBuC6iX76WX3Mc6f9/ovPVXET3L9VzOvTQTFW2UjbSRyME1M2WQL0TeOz0R81snIesYwrX0sKH8n9ySQq3hKIQkKzPGbYe/V+Fdqe/dNp/at64xYCdSNpfMqEJqerTegFzVlOzu1jPQgN7gvHdsz62vELR5DaBbLhhKnFxTsMGTi03zg8zZfgIVk3mjvN+q+PtPL/9fLthLfwpSagWrn+18tQsClSVrHzr+RtY/8KKX3vo/iCDo1J+zvSYlTi//j1ceXH39hqQOXoqa7f1jtpS8fVOrfWlesPRUlv4kIKdp9HmPgmzyUigGvVlY3qkhF0XQIPWO3CLrn5LHtibztmh3ilMU/Rovjw7kHJcdPbOx3exU7bt66296lb+zOipuWs2QC8d3CbwRPh2ycUk/hD8xzMabPjPMRHy34ea7FaB21p6eXP6z93vtDky4XsafYqWfcQPVca/vpWsH7eldjQdjWSMrEMG+EJR1pUNGcXG9KR7viPMm1Xxl0gHNcwqhZGrT1ko5Jg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(82310400004)(110136005)(316002)(54906003)(36756003)(7696005)(2616005)(16526019)(1076003)(186003)(86362001)(26005)(336012)(426003)(6666004)(36860700001)(70586007)(8936002)(5660300002)(83380400001)(44832011)(8676002)(356005)(70206006)(2906002)(508600001)(81166007)(4326008)(40460700003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:12:05.4040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b5297ea-cde4-4f28-055b-08da135b1bd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1494
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The results of the capability register will be used by future
code at runtime rather than just initialization.

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add Tom's tag
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

