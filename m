Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8521C4EA5D2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 05:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiC2DRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiC2DRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 23:17:41 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2067.outbound.protection.outlook.com [40.107.95.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5C618CD29;
        Mon, 28 Mar 2022 20:15:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMAwN5i9cq2j3VtewPqjWRxCMXEcrQndqYIfkz/ydhSsWgj/Rz4u6CpqJ6bVT8AhdT8JPyfIJvqJbVnb4z5W3u5AV4rnD/dcYEDbamGw6tPTf5D/35hHqAM3FPTJOp5ztA40Hnt85pv6zGol7DwIp3giVpuNH2Wlns79DKs3exQpMPasttLG5m8nsX60qnM5u/tj6Qmu02GUgd0jkBkbIUQ7FLAkRF9Kq41m0fyshnUHBxflM8VY8g2t3MRwpVf1gRQZ1wCXhF4kXNgh6PjJe77sDSS9+aNau//FRUfWDFZ9GgiSF1xVdog+xOxUuxpLAqvmf8gcKmvKiHu4VNylzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TkoavJ7f4fXuIz37liTxxcX7CuLAd6PxDS5IB59J2w=;
 b=WNUWgLXGGgo2FG9uQnLhBWuIihIgkbPfnNNmi8Fc7A9Jr0tlOmWwD2sGUo8fUxB78VgU23fpgkQbJaqUit9Oo9wg8ZqL0Pgr9bAL4KhKOzG2R1dxKdL52myHnE0djxc3D4v8BHcb/Fb7cRy+tWc0SsWL2F9BnjJj7uTUUhUZOWrJdXCUjOnNvaX5q+JqX/UirsMl9mCM2F5BslKAyU47c33VQsw/JTH+GnY3DDgrw0qXWTJDNvFmrbh4n5tO0oXWZ/S9sLbhPMTqkR12sENbNT4cFc+17YSxaQr2vPUJW8DutXksXWO3+HY+E+/5LrORaIkyBD9kSUYLUdVRvF9Mzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TkoavJ7f4fXuIz37liTxxcX7CuLAd6PxDS5IB59J2w=;
 b=ubZyanHyqxYYqRbbzB97uVRuMcD7fJJKqI35E7RR1OLOUxVEX0p5kx9ZyuYOFBwAlvcKfmRP/tosSdSBpNngRz0R6hGGJqXvyg1Wc3ftx8BIoeiG74pHsUXMc+rtRgWnmzCE0zG/UZOhsdXPy30lGiEjtp/GzZhQD0uaa0PJer4=
Received: from DM5PR19CA0036.namprd19.prod.outlook.com (2603:10b6:3:9a::22) by
 MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.19; Tue, 29 Mar 2022 03:15:58 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::d1) by DM5PR19CA0036.outlook.office365.com
 (2603:10b6:3:9a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23 via Frontend
 Transport; Tue, 29 Mar 2022 03:15:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5102.17 via Frontend Transport; Tue, 29 Mar 2022 03:15:57 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 28 Mar
 2022 22:15:55 -0500
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
Subject: [PATCH 3/4] crypto: ccp: Allow PSP driver to load without SEV/TEE support
Date:   Mon, 28 Mar 2022 22:15:52 -0500
Message-ID: <20220329031553.798-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329031553.798-1-mario.limonciello@amd.com>
References: <20220329031553.798-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13c2c790-cc78-4512-f4a6-08da1132719d
X-MS-TrafficTypeDiagnostic: MW3PR12MB4569:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4569B5ECD87AAE1008D5B7E7E21E9@MW3PR12MB4569.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: weUet0QyA6D2/LerxGahijoYCqpmRa7Sdu9bGf4SUzxyedYWDy0w5Waex4FpY/yBPIhoSiU1y06d/a81aq3X4sn4KNM3QyJm5ITv1EKYe/5WJ7tKnnmSPSiWkdk/Sd7E104Nf2iH4UO/oz9J6OBCEVnmP4glDGRwyqRieYQmH2f0puhBl3CkclDeZr/wwrtLhxNTnm1JouvC3MGv4f0ucYvmiIxoBeWjB7vEElx/Yfmy9hAQmxFintjIuLe2rEIE6l+gM6niDDmXALSKPtvr2g5JQteTJu0wAF8QucOMrEpSodf4vKAxeNpwWWW4e3lZsrHheO2A61g3vStjlwSr/au/CgmM/H8ydQ6mkdb4+vQTj06IYKyZlFVjBC7NVQfEubq7p7sgRByz7lmuzotz8s+U1BhnYn/5k3K+PDrr4pyumyxZZK2KhoXRYhKhj3+9IPf1fwNANJRsvjtLvwlrHukz6A909Ad+lXCEsGmRa+4v1Fhjx38ow3AG0p9dFfsJ9b2HDm4O6ACB4k6Z4Jxzm5VEmkTJyTwYpWWQGyV7upYtYP8JsZxx+aMwrZPsOQF5gc4DV53A2kdgMt4UepbdEtR+o0yU+84sHaQgL9D3f3otDUDD2H3fuxaNTOS+4ZM+ZHS30jXougOER2d9BZ8F3QNb6dBBp0qRrAm3tipu3lU+CeybVmrSol+eNCZcf+AmqLZeFNcAGy89Jq9yiQnIYQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(5660300002)(356005)(8936002)(81166007)(82310400004)(2906002)(44832011)(316002)(16526019)(1076003)(54906003)(26005)(186003)(110136005)(336012)(6666004)(508600001)(7696005)(426003)(4326008)(8676002)(70586007)(70206006)(36860700001)(47076005)(83380400001)(2616005)(36756003)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 03:15:57.7467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c2c790-cc78-4512-f4a6-08da1132719d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
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
 drivers/crypto/ccp/psp-dev.c | 2 +-
 drivers/crypto/ccp/sp-dev.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

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
index 7eb3e4668286..77cf533b0db0 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -132,6 +132,8 @@ int sp_request_psp_irq(struct sp_device *sp, irq_handler_t handler,
 
 void sp_free_ccp_irq(struct sp_device *sp, void *data)
 {
+	if (!sp->irq_registered)
+		return;
 	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->psp_vdata) {
 		/* Using common routine to manage all interrupts */
 		if (!sp->psp_irq_handler) {
@@ -151,6 +153,8 @@ void sp_free_ccp_irq(struct sp_device *sp, void *data)
 
 void sp_free_psp_irq(struct sp_device *sp, void *data)
 {
+	if (!sp->irq_registered)
+		return;
 	if ((sp->psp_irq == sp->ccp_irq) && sp->dev_vdata->ccp_vdata) {
 		/* Using common routine to manage all interrupts */
 		if (!sp->ccp_irq_handler) {
-- 
2.34.1

