Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAA549F16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351248AbiFMU3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350975AbiFMU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:28:55 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E101D0CA;
        Mon, 13 Jun 2022 12:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fpnbv7G9dexiJ9qRpNZCYy+JozbM+yUn3BKYWXmdXE9XyJQYFUGg+dgavKxJiR+sn2y7kcbsHM2YDpDj+rS4Wu91VRYRJN/FpwiVgcG6hfN0xmIrqaHAcMIVzeabzY8LtL+JjTQhkx6idAKPvfEOH/Jc+0X+6GUIqg9tKTQpsIhcELW+/BXk3BUjvsQJ0IMuyCG7rrp2JsiAdFo26kF/6W2MKIYZlGDUmPXvMhq8xl1WXUjq8YQ5/p1xHrtFJ785ZfJGyPfPvyf0CUx8+RDJAyGRcqFzsGf4Pv2xP4aAJLxcnrXI9Fw/kfG16yhtceZV/OwCVnkbjXfYvr8M9IhfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvWh8MzFC/7vGVRe2qjwSgaT9BLKOuGbj732g6Dbt60=;
 b=iNuCmuZvWLlhj9Thw1lR+FcBx9PBJreFBHkThQGkYSbGkStfErF0xryccaMb4VDByN0W0OJVUaq6gk8VxfZOFuChKdiSVPEETw0OiI+g8OMIwjdMEH0oj6ruUckNj8prXp7u0M7Ywxyktkc0/CtyO3kXMmmMcQ18w8BbIztXFtXo0aPVxkHK6743L0mXkB4fbp0jUuGC7nqR9LBg8EfULJoZiY1a2uBOUSOIZXDx1dBnl5fRqQJpl8aFK7gddHaAxfcghZL7xdZ0axVJjfreDe8mPCQ0U7GT/kPgYUAPKmJyqGPaFCDc1PVwf1uzEONtijkg7mO3aOoYKXuwjFrD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvWh8MzFC/7vGVRe2qjwSgaT9BLKOuGbj732g6Dbt60=;
 b=XFaKJ4ymvJAdpvC5CHzcegfvF9riAsylfdHp3IKOOeYo+O0SjdCyk+nIhza+O1QyMGUyTQ1oBgRXiQM2oTFkBglphz3K6CCM8iqYg1LWXgS6d9wChe2R/A0Qx3CwIz5JeEziCDKyDnGYbmts6K25Ddh/R1vVAxAXLclPZMMMous=
Received: from MW4PR04CA0039.namprd04.prod.outlook.com (2603:10b6:303:6a::14)
 by SJ1PR12MB6340.namprd12.prod.outlook.com (2603:10b6:a03:453::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 19:16:40 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6a:cafe::2e) by MW4PR04CA0039.outlook.office365.com
 (2603:10b6:303:6a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 19:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 19:16:39 +0000
Received: from tlendack-t1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 14:16:38 -0500
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        John Allen <john.allen@amd.com>, Rob Herring <robh@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] crypto: ccp - Fix device IRQ counting by using platform_irq_count()
Date:   Mon, 13 Jun 2022 14:16:27 -0500
Message-ID: <bf04adfd1dae519cb9377bcc7222089399690a22.1655147787.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d908cf6-8f5c-47ac-5539-08da4d713e77
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6340:EE_
X-Microsoft-Antispam-PRVS: <SJ1PR12MB6340D872A34E6F8B51D70FD1ECAB9@SJ1PR12MB6340.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BS6+3bqu/rMXdUPcGNDGwK4rdvt+PszMuGMnJHe5joFXy479ZJJyij09L4bRSXQKMxwpsanjWxUMvYGS1KOzI7DP5mIPumc0aVDLqdtH0sYpvqEcVaHRRRacxX1/rXUeUq9CyZJ1EkGyw5cJjMNadi3Or+mnXCc9EvIAPg+ciIngbwbBiACq0YJnoVSWyZ6fbWN13fveW+w3pcMLRU+I3Eso9VNjqMMF2m5nwmG4uVNwsbeLuSwwUHqS1RvCvzZsJR95u8Jx3b82qA4Na0vIZB6krNvrv0eDyeaJ44OpIQCehfd14iq1gHqyEc4tP4Zb1GPqCEwFFmKeX7DHFkA+53JAre76R+bj9HCnBgjNkmfQj2RjqssO2lkvn8g+7MyoZwuT/dFEwFXc3/IgvUN6mf+LCBZyZORQB7wpbvEfR+ApS4y2K5dRxEprAUT64pZdPgA4+oRA5zQT4UPmFlr/cHENbtotbfqMzW8dfdDR2dTv6qZh2eFvfvom7o7kXMnULT9L4DkURuZayviM/5nrWbjrkNUK8itdh+7gZGssfl0b1aiS/UwshHmwxX1rRrg6seCq0BCFKBoyHCJv1qJF5AHnzOx4jWB6FmXOzhuaecqXWepApZzU/LtTwdAJcRgVF7k/Vose16AU0DKZBsjfYDNjza8UyY/GC2AnfqooTWyRkfxdiequGPm2qnchBKTP/uKla/cm5zgQrX44+WaaeQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(508600001)(5660300002)(8936002)(356005)(36756003)(81166007)(7696005)(2906002)(40460700003)(110136005)(86362001)(8676002)(70586007)(70206006)(6666004)(4326008)(54906003)(426003)(83380400001)(336012)(316002)(2616005)(186003)(16526019)(26005)(47076005)(82310400005)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 19:16:39.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d908cf6-8f5c-47ac-5539-08da4d713e77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6340
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ccp driver loops through the platform device resources array to get
the IRQ count for the device. With commit a1a2b7125e10 ("of/platform: Drop
static setup of IRQ resource from DT core"), the IRQ resources are no
longer stored in the platform device resource array. As a result, the IRQ
count is now always zero. This causes the driver to issue a second call to
platform_get_irq(), which fails if the IRQ count is really 1, causing the
loading of the driver to fail.

Replace looping through the resources array to count the number of IRQs
with a call to platform_irq_count().

Fixes: a1a2b7125e10 ("of/platform: Drop static setup of IRQ resource from DT core")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/crypto/ccp/sp-platform.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 9dba52fbee99..7d79a8744f9a 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -85,17 +85,9 @@ static int sp_get_irqs(struct sp_device *sp)
 	struct sp_platform *sp_platform = sp->dev_specific;
 	struct device *dev = sp->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	unsigned int i, count;
 	int ret;
 
-	for (i = 0, count = 0; i < pdev->num_resources; i++) {
-		struct resource *res = &pdev->resource[i];
-
-		if (resource_type(res) == IORESOURCE_IRQ)
-			count++;
-	}
-
-	sp_platform->irq_count = count;
+	sp_platform->irq_count = platform_irq_count(pdev);
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0) {
@@ -104,7 +96,7 @@ static int sp_get_irqs(struct sp_device *sp)
 	}
 
 	sp->psp_irq = ret;
-	if (count == 1) {
+	if (sp_platform->irq_count == 1) {
 		sp->ccp_irq = ret;
 	} else {
 		ret = platform_get_irq(pdev, 1);
-- 
2.36.1

