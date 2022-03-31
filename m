Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD44EE31A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241767AbiCaVOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241676AbiCaVOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:14:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB7F223872;
        Thu, 31 Mar 2022 14:12:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OsT+PxDuIdvH/YSAkJIQ4mcEorYFFN2hAh6yJ4LV0L1p5GuoQ8+8JAnhoBN9864aprxhrLHdHt0rdxI1vFKizw8/6svoTgFWv67TAf4cB8QB2OyM7+04VbYd6GqwHOp1ltk4awpvex5CheiM34S0Yzo2rWKlGlsrjx5YZJYDmElVb5ze1Kwh0BiNHw4XR1fTV4erqIw8OcQ0ggnmOncA2r9knuHOjnMWMlbRTztkge4Tlhybxp+3+aFSGTNbprZlheJ08k19ucGDs21VUx0M0bWm1+BoRo5SueOVx84oz45aJWXK35VgF6kG1w63/gVcBnxE+I7fKmUu0Jw1Ua8FkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYPIHBx2LmPULSamdRNsWiXpJcuExp/yHCz09gERJV4=;
 b=R/CqF9RlWL1cXfkYUYGBj7+o7dw+omKgqmSrUklZRHVCiBmZDDbOQ24PRKDMCleQGbxzeYB4Qp0VNw/09gSTeT9jJ1phlh/n2SfB3q1b9kHxVnkjNpsCong4oADJsIMvxwzQw1JZX8WxxbkxZhRJDQFXvrnVWWhsddN/lT2YClwU5S8gU2US1QVrmbgCurQfPejSyKI2vVGkC0Y+rZNEHuOepKBt8ySSUAtEyVor69QLblquBDr/a6nVkELfEOssbCX4JzX2BrFDNmktCUL3cYnmlbWxDwVSMsLa7QdX7ItApUWUHzV4pT9yVveCKCK+aFn9VIFql2UlUMM9gnqInA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYPIHBx2LmPULSamdRNsWiXpJcuExp/yHCz09gERJV4=;
 b=b3riI43I74YRLU49N2AizMy96gxbbab9CDadLQunKAa/L5mp/Lzrtr/3UUiwIVrunGAZGjd0CYCsn2Ywt3CFScqrR7D0nkhQMEcNDiXW1ERjmI5JQzb91/GPhgYP9Mx/0w1jbYUQhthEneGYQezOpxMJsbC/4gZrtnbHxh6Ki7Y=
Received: from MW4PR03CA0146.namprd03.prod.outlook.com (2603:10b6:303:8c::31)
 by MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 21:12:08 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::e2) by MW4PR03CA0146.outlook.office365.com
 (2603:10b6:303:8c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23 via Frontend
 Transport; Thu, 31 Mar 2022 21:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 21:12:08 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 16:12:05 -0500
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
Subject: [PATCH v3 4/4] crypto: ccp: When TSME and SME both detected notify user
Date:   Thu, 31 Mar 2022 16:12:13 -0500
Message-ID: <20220331211213.2844-5-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1ec53764-f551-483d-5ea0-08da135b1d97
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5667521CE2ADF15587FC3574E2E19@MW4PR12MB5667.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ugyLLP5KjQD2hpraRkwsM9Mh1O7zajardXrtiuvQTQoDZBcGojI0yzths49PhTp4QTVKcGjfJavZHuX09UYdh2p1Ih04aGaXcNUY4r9+DiWv9DVvuuKxzSsxLUHAT2B0Iyv1q07OOvl7DCBZKTOJNotyrqHY9SV7xOTgOV2tqtiigAJSVXswjoJjyeoB7nSpRd43u5K0LFcMECzO0kgN06SQRGtj4uPJSAgH18EMvMiPat1ygb5ewPg3bgwjTH0iI3okhHDYiC7Be9PPVCdYxMzxfkgOpIW3NRqlExjakmyjZfxSZmpihESwtKO6/sc7N3rmoV2RNBH7Oh63vxjUddFMAhmrVkn72jTqdwU+vQkOUZhfbjXUZQ0xqa1EpfbyErdrBaYCmqcQ8u5ogU3BH/vBS2Sl+2jtICysSJo+KWdfpda9fF8RsVqnz457IXuQe8UAaVQSiUMtS1JzMUyAz1Hx3LphtQ+dsp9G2v8pyRJuCEvEcnEk8AaaYUMqtWjNO7JigehycyU1Yu4NGEYPv9cj39+dY5cpWa4uJKwBPaiQ8VGBX2cBACIuub8KTbo+dxxuv9QaS+HbA2F7C5nRJSGkbgJlkvI1dZqg6PbTfJ6uYO/eFn88UqKNfjpEBO1gv3vHIBKyJvDag9hx40HeBQfra5ay7dvlo9o2R7zpX9ODeZcwK9WRJtiO/EtTa7iw43vHCcgYqaW/U6GAvcr2Rg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(2906002)(426003)(40460700003)(86362001)(8676002)(356005)(47076005)(82310400004)(54906003)(508600001)(110136005)(6666004)(316002)(70586007)(44832011)(83380400001)(70206006)(5660300002)(8936002)(7696005)(186003)(26005)(16526019)(336012)(36860700001)(36756003)(2616005)(4326008)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:12:08.4038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec53764-f551-483d-5ea0-08da135b1d97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5667
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC_ATTR_HOST_MEM_ENCRYPT is used to relay that memory encryption has been
activated by the kernel.

As it's technically possible to enable both SME and TSME at the same time,
detect this scenario and notify the user that enabling TSME and SME at the
same time is unnecessary.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Remove extra whitespace
 * Reword comment
v1->v2:
 * Reword notice about TSME/SME
 * Use cc_platform_has instead
---
 drivers/crypto/ccp/psp-dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index a3b7b5130be4..c9c741ac8442 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -74,6 +74,12 @@ static unsigned int psp_get_capability(struct psp_device *psp)
 	}
 	psp->capability = val;
 
+	/* Detect if TSME and SME are both enabled */
+	if (psp->capability & PSP_CAPABILITY_PSP_SECURITY_REPORTING &&
+	    psp->capability & (PSP_SECURITY_TSME_STATUS << PSP_CAPABILITY_PSP_SECURITY_OFFSET) &&
+	    cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+		dev_notice(psp->dev, "psp: Both TSME and SME are active, SME is unnecessary when TSME is active.\n");
+
 	return 0;
 }
 
-- 
2.34.1

