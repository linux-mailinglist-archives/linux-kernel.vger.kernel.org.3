Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282CF4EB1F7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239808AbiC2Qn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbiC2QnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:43:08 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7724D249C49;
        Tue, 29 Mar 2022 09:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=THO6q+oL+70G3LHAjbilTjbVPf3WOjsGlomHafvoIvaFkOyqU5C6+ps6OrU/YeCrIFpTyHWwhjUQCc+lo2afT9hXOpL8XwDO+yiaXcnw6hlQdfc0aOAgRzmrQ1GgVWJCt52vDbAx69E+Wj82wGzV+N+MpwjR9zV4SrNk0V0EUkRVf7AhbiV57SXarCoG89D6HRl8VsZsPYD6ITWM3CHrzwZdSEETCvSiM6rzJAyfkKgnioYC5DLiNmWwCgfVOftFpQjsn27I0WtGSSc5Fwk1tx6bOufynvHgIDkLjMBIhA/RmHHmCjKcAYvyFXrSAvXVfJ+qnf1iNNcslRXqqijuhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8hks3HxQLDFXpDW4m6YZMFUZa7UxVIGxvIJFib/pdZg=;
 b=K1nSp7L9/HmSHvzR5CAS2HNdMFdEsGSXekzWJNosZAIISHU4ls8ndOS/+fAXSxG4229AmAF0KiW9iBJQ9AJBXWWxn2pdgpLCshhod0xM4FLzS7lETOao2oZl3dJUmAE1lnlSX+cRfMpEAbdzH9nTKH8KhteDJXYtLGCGfo+tiVuISrFKDTc934krWK1KvpTrTEGvUT8wg0VZ+e0thLND5c01x6B6Q62ueWG1Fp+lpD1Q7G7J4AMDbNSFhlrJx13nVTz/flCdcx64Kbib/ZfBZI4BMvbn9luLam33klC8PQjXEsNMejC1xZwMH/VzfjAWI0qoP8DJ4+fkBaP37v/9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8hks3HxQLDFXpDW4m6YZMFUZa7UxVIGxvIJFib/pdZg=;
 b=VaTSJ1WTi3WZnAQVQJohe8N+67pMEruigOyPVvMl30ZNTe8n4kkcMfgKRhaS7xXO3qdySDf+5XW9tAKybJ1gI1r/v8dPb01rX0jkDnPb9CrnH3MtuBRRz9jBUZK1xN8AK8POLRsyQdoEQBrF9SuimR0j1Tx+g69mGLTVFChU2YE=
Received: from MW4PR04CA0084.namprd04.prod.outlook.com (2603:10b6:303:6b::29)
 by BY5PR12MB4308.namprd12.prod.outlook.com (2603:10b6:a03:20a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Tue, 29 Mar
 2022 16:41:23 +0000
Received: from CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5f) by MW4PR04CA0084.outlook.office365.com
 (2603:10b6:303:6b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.18 via Frontend
 Transport; Tue, 29 Mar 2022 16:41:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT066.mail.protection.outlook.com (10.13.175.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 16:41:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:20 -0500
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 29 Mar
 2022 11:41:20 -0500
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
Subject: [PATCH v2 3/4] crypto: ccp: Allow PSP driver to load without SEV/TEE support
Date:   Tue, 29 Mar 2022 11:41:16 -0500
Message-ID: <20220329164117.1449-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 276bd275-6677-4dfc-c584-08da11a2f511
X-MS-TrafficTypeDiagnostic: BY5PR12MB4308:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB43089F64F4B865C9C772256BE21E9@BY5PR12MB4308.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I2Oov3sYGstpuVS/AhKtGWLYQTU23BUSXaoLQ4va4/Exfc07qLoIxA1F7fVYs8WuDtRy8K3o5ADzHzAFXdJCdRrYZop1ORCJMxXaIonRmowUtq6fybI5IhKXKUpMcSwTr0rL/KEiOXdtmDMemMm9vtXLqvwW5ProvYoObxoa8WFCQYTR5vRX1zx8x21udbZfCb3lXuWHATgn10DSf5UkLtdahsQDdXxNRiOieFbXWnLneiu5MZMNFBiKsbq17PaIUZ+g2HVL5j65n8bk3D4q12ezUpotDl/bXUeENDF5DkRtfzUBWRN1qZK6WOfPRJlsWIdqKwuh/ubLvO8Pp2358eDBiFG0u08NJ8P36F0ldiu740X/BTstXJ5eKAdex53w38VWsKZ5WWi2wy6PTK9dz5ZJeTT3wvmHfvgJZqvBbm87pH73yBZxGJFqR4ENfjYHKT6K4i+IdzImfoLmoT0AqPcg/h0deOPkOVoIj5R1JupiKcQRE6Adlm8UcduB85BsiVvWA+OPEbar/3UjUil0EpFLwVJN1/TMRwmBpRGiKz8/x8U+vFyTf07MXolQ9L8cswJYEWIVf4WUj0t7zQntY/7fL9ExW6t8xESQNdWwl8JILQBfb/MoQQA0/Jq6bXiS64RjAa4lQPGaKCtVwAjBv2hPrhVr6+SSDOQpkB6FICTXjh1CQv8JJNijVr10/rlD8P8WSYYUOGozNKMjovGQiw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(83380400001)(8936002)(82310400004)(36860700001)(5660300002)(70206006)(6666004)(508600001)(40460700003)(47076005)(54906003)(8676002)(110136005)(70586007)(4326008)(86362001)(7696005)(36756003)(81166007)(2616005)(356005)(2906002)(316002)(1076003)(16526019)(44832011)(426003)(336012)(26005)(186003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 16:41:21.8428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 276bd275-6677-4dfc-c584-08da11a2f511
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4308
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously the PSP probe routine would fail if both SEV and TEE were
missing.  This is possibly the case for some client parts.

As capabilities can now be accessed from userspace, it may still be
useful to have the PSP driver finish loading so that those capabilities
can be read.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Whitespace fixes
---
 drivers/crypto/ccp/psp-dev.c | 2 +-
 drivers/crypto/ccp/sp-dev.c  | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 8cd404121cd5..3f47b2d81e3c 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -158,7 +158,7 @@ int psp_dev_init(struct sp_device *sp)
 
 	ret = psp_check_support(psp);
 	if (ret)
-		goto e_disable;
+		return 0;
 
 	/* Disable and clear interrupts until ready */
 	iowrite32(0, psp->io_regs + psp->vdata->inten_reg);
diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index 7eb3e4668286..3486ab2a8982 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -132,6 +132,9 @@ int sp_request_psp_irq(struct sp_device *sp, irq_handler_t handler,
 
 void sp_free_ccp_irq(struct sp_device *sp, void *data)
 {
+	if (!sp->irq_registered)
+		return;
+
 	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->psp_vdata) {
 		/* Using common routine to manage all interrupts */
 		if (!sp->psp_irq_handler) {
@@ -151,6 +154,9 @@ void sp_free_ccp_irq(struct sp_device *sp, void *data)
 
 void sp_free_psp_irq(struct sp_device *sp, void *data)
 {
+	if (!sp->irq_registered)
+		return;
+
 	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->ccp_vdata) {
 		/* Using common routine to manage all interrupts */
 		if (!sp->ccp_irq_handler) {
-- 
2.34.1

