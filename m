Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04034EE31C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241707AbiCaVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241646AbiCaVN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:13:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B672335CF;
        Thu, 31 Mar 2022 14:12:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEcuogOJykEwmVgjLC64wtEefSUcdTUB0qFhxzsiKeQ7cJBt6cG+NBI6Xjy/z432XROh3vl0E/bqAYQZ0/DvsHrx3ogQYFIyIfuCqbTXNFr8axrdb4ikRhjoBOp8Edm6baYRMCyn8UDthAVfaQ8ffhnzHSvG41gIvvJZhYgga1qMTS8jJBy14VBnByGtVrag4MIDGBn+MPvzPoMukV8wwswHto1u+fuCPEVB+NtiRByZX0XvQiJnoTMzP0tQOspp8JT8Sthv/tJ9p7kqkG4TGdcUi2R0W8WfTBNUTzSmBqoM6s51ZBjbR+pXrG/GvNUa+RPA5Jd54Onp31YLPDwixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ntjp/aedIsu6xGNCH6gycu57Z5n6dEx01U734rW34Y=;
 b=LzLmVA7RTBa1sXWpfwlkPXQbu1UMwSntuzb/jQIzesRZuGArsB/8xQInRj3rmjqAjbwQEzNVxi26IwhKMJN6gpLXNdJvVoaKxZq1hb6+ShBKEwgt/zL4ZI7728z4BSt6SIheuKNS+ZKaMqtjxGqQt9MfjgkbQOzKONTPZbn5vjXMcpE7FNpFVK79TygcQGIeMXgeSrkvkxKlQjwfORcpy13rUc5IKDf6NMlZzp6cqMxOhtwbdusMbhrOjC9JP0NcDYns95L2FX84IZwcEslaPUBZDEBYktUYJgT2ZIiNErUt6aZBp5hrRygXNrj0HI3/HDThUSMxrQux7ND7eX7J2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gondor.apana.org.au smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ntjp/aedIsu6xGNCH6gycu57Z5n6dEx01U734rW34Y=;
 b=nE2iv/LskJ8I9WiunAoOxXdfN+uJHcF/YoyTRfWBd0qiqpkRmUp9SYu/b+QcWci3nJOC39Pz1tXlLcym3RNTx9/wpr8+bhJ/b8yXBWkXIJLc4nizp3TAA5CSzKiBfyRIN3k+SV4uAUMRwE5DNCwp0UkShpNZF6shgNgJWkmxxNI=
Received: from MW4PR03CA0147.namprd03.prod.outlook.com (2603:10b6:303:8c::32)
 by BY5PR12MB3794.namprd12.prod.outlook.com (2603:10b6:a03:1aa::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Thu, 31 Mar
 2022 21:12:08 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::be) by MW4PR03CA0147.outlook.office365.com
 (2603:10b6:303:8c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.22 via Frontend
 Transport; Thu, 31 Mar 2022 21:12:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Thu, 31 Mar 2022 21:12:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 16:12:04 -0500
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
Subject: [PATCH v3 3/4] crypto: ccp: Allow PSP driver to load without SEV/TEE support
Date:   Thu, 31 Mar 2022 16:12:12 -0500
Message-ID: <20220331211213.2844-4-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7e9f94d4-b6b1-4c0d-b846-08da135b1ceb
X-MS-TrafficTypeDiagnostic: BY5PR12MB3794:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB37940A1056FC8FD8B9FA1B85E2E19@BY5PR12MB3794.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hs/8Tr3FZzTVt1WtS19gk5CoAcJ+16fQby7DbyuzQLJizKFvO9fzvNnSOigFuW1QdL9I5/DGTKmvdOBQDXvSA/2UvSrFIUp64ePgtCHTn76dIWRu0yOR46ziuaym2WoBrC0t9fGD5OWisxPPBph69/DUHy2YCYnKp32APrvbC9f2iZdBEHJEtgRluTvsAdytyeCOMiDlLqrNiBLPCjfXRHU+uXFWHlfJLUi28Bl0XdG1/3NdCNy+sShmcdzjgvvuh7W/zNotLHZdlB4rD+1ISJCiBDhbTqAlTLISTg2FnxqamDstwUOELNc4Og9ToT8AGtCLQuwEcS3epR8bGnR+45RSHkUWUqp7NdsOhmhIlNbUhRiOQa6JSjvkphRCZg09jnKPu3JU+MOCY4z6swqJkKE6m7aiPr1U8LaVMXV3o9ppMKa7qlzLPSQdLbH+/okdtfS3v+612tEcGbSlksTrLF91Dc6hRT+HCGGNnUZKWnan0QqVc4RjxglTWCY0unY2stT/Jh70RXTBinYmW0QBJ5lO0W9Jm0pELlc6C6wEJEAO6ZWIO8xcatlh3A/w7mfMME0jHwjvoChwcVfkJtpdwDBX6+4ShUUiuBx84/uzNRr11N52Up5nwzS4suUAH12F1zbZpKkNDOFAxqRWj5IZXMoCHJn8jkXKr4uP4qAH+eLt/Vth+xd8jns6cM242wZPQMQlO60rkYNCIC1UCaXRQQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(36756003)(44832011)(4326008)(508600001)(6666004)(70586007)(7696005)(2906002)(40460700003)(81166007)(70206006)(8676002)(5660300002)(47076005)(316002)(110136005)(54906003)(82310400004)(356005)(36860700001)(83380400001)(86362001)(426003)(336012)(186003)(1076003)(2616005)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 21:12:07.2789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9f94d4-b6b1-4c0d-b846-08da135b1ceb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3794
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
v2->v3:
 * Remove helper function, and still set up IRQs even in this case to keep
   cleanup process the same
v1->v2:
 * Whitespace fixes
---
 drivers/crypto/ccp/psp-dev.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 8cd404121cd5..a3b7b5130be4 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -99,18 +99,6 @@ static int psp_check_tee_support(struct psp_device *psp)
 	return 0;
 }
 
-static int psp_check_support(struct psp_device *psp)
-{
-	int sev_support = psp_check_sev_support(psp);
-	int tee_support = psp_check_tee_support(psp);
-
-	/* Return error if device neither supports SEV nor TEE */
-	if (sev_support && tee_support)
-		return -ENODEV;
-
-	return 0;
-}
-
 static int psp_init(struct psp_device *psp)
 {
 	int ret;
@@ -156,10 +144,6 @@ int psp_dev_init(struct sp_device *sp)
 	if (ret)
 		goto e_disable;
 
-	ret = psp_check_support(psp);
-	if (ret)
-		goto e_disable;
-
 	/* Disable and clear interrupts until ready */
 	iowrite32(0, psp->io_regs + psp->vdata->inten_reg);
 	iowrite32(-1, psp->io_regs + psp->vdata->intsts_reg);
-- 
2.34.1

