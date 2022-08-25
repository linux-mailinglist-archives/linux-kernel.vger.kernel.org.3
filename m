Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033E5A0652
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 03:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiHYBkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 21:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiHYBjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 21:39:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0561B9AFBA;
        Wed, 24 Aug 2022 18:37:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3AA1RNLbn6BXWy5+AsAMkhTt44wz/viNd4oDZ/ZrGl/rG6sWDB/xssRWyyEYtcV7pyG+zNqh2eo/PpnsWFOyAs59eTvQbMgG0FRJ1PCI7QLaoXYzxqZ9Sx8Ih7XNeVlfHj+rZaCSxutVCCAkjt7+bNGifXMs+xMaj20C0xCr9vLwPGzwc7qy2u601TtkW9OADjkBhGJ3noPmWUPJ1JPVjhMa7flgbdp+BZVVSo91WzfcN8hhU7YK60MoC1VTIC5jsHcLfUm/TqNoMma88CKx2UU/UXg5emikT1sRVtoynwA5vNjqE9eMm3KWKcvZ5nsAxFN6q5jW373/jkrQtoTmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSXJTWJAkOevlkQOcdatUI/9iBx1ww+5Hfk1x3QVHPY=;
 b=Hd/My88i9oxuKNKTdjt+uRR6CfI3TXItHv/LDDzOPs9NjV6zZAiCpR8MVp6odkOqMzSQFQwTXpOqzb6IiqJSZ7A7+cMbDAxBqj1vqvj1dNyN55CrA+BUDGjp0f6PUrtrOu768ACHU/KIzaWHK4eUjxCE1e+AREK5640K7ncDchWX9nzzbq2E4c002A8Ude557Otip1ueu1bO0opFztYzuTlyKp56G8JWG9kXDCUDWfis9zxbplLgr50nlO5gCyWivd8M2i1YyTBZADE0+vjV7yCSyE2fI0CF55KflOfdDwKRIHnrSp8MnsCsP8+/pkHEXrrnO7iCgQGwtMAixHmylw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSXJTWJAkOevlkQOcdatUI/9iBx1ww+5Hfk1x3QVHPY=;
 b=czUIdv+/gRlW87A35WpEd553KcU9a1aWLhq1pmL+7ujvedGRdNCcvM8lBl6fU5/WVG43OoCDRxYU2qkBwxoUO8mH92JYivhWvxUSRkN/VWx3DD/SWhQODVcsvS4e4ffkvk0ioVqvvti24P0gV1IV3n07VrCHRCcodtjWRor+/5Y=
Received: from DS7PR03CA0165.namprd03.prod.outlook.com (2603:10b6:5:3b2::20)
 by BN8PR12MB3218.namprd12.prod.outlook.com (2603:10b6:408:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Thu, 25 Aug
 2022 01:36:50 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b2:cafe::3c) by DS7PR03CA0165.outlook.office365.com
 (2603:10b6:5:3b2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 01:36:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 01:36:50 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 20:36:44 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     <rafael@kernel.org>, <len.brown@intel.com>, <pavel@ucw.cz>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Subject: [PATCH] PM: wakeup: Add extra debugging statement for multiple active IRQs
Date:   Wed, 24 Aug 2022 20:36:30 -0500
Message-ID: <20220825013630.16311-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 844c85e6-da5f-4348-1846-08da863a4877
X-MS-TrafficTypeDiagnostic: BN8PR12MB3218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rkbDkycT6NZh1O39mTty/ylx8Hx0i+GjHtqwYy5LQa1KRAGje89ZQjnxDYJAXSUi31pk+XhUPNugagBD5/KmHjQe19PAuxiiBKR1KspKa33ZLUmlnz2XJTO+Xwj4C9p04yRhWPU/ysj+xYKJT0H/0QClhu+dQeghn/aLykqhocxAYV0zFNtd25rO/aMidn3qRn1ZWV/FNNIB9Q1oClcXJ9ZGOf38UV3Ty/Tt8S3zgROg3bP3/G3fYmvPv1gQLHo1ENTVVNgthwFFPIQYgLDRY+ei9CnPfzM4KjkuRq5ubsQJU5VcjVKqHsUmy2cAVbkZYV7iVfLEzCjVx9Imj/QmjZW0b60Rdf5UHj4PuCWUTjRkBzHqG2/EJZqHqtIRTFJ5UOZE0vnmAA1b4+YLIxKUDABqaccmHMCgA91t9r3euPfk2d+KOdvFGS5dk8fMHGQEbKRGOUA+e0i45XjU/6JAfeDcro5YzaEaIeVTsu8ynjbjkQW4bSBEXhXWz/KQum4pDS+wvFvMxz4VPrDMCI+vMk5uSNgYrbaH6DD3CXgAa2kPwh1bLolvdX7vRBoWktNfqozWkcJHWblKLW5H91aUPkQXRjcmU5B00gavMLw8UeqHOCuizR1ZqAvvPYfCIbdU9NIYLy9E5DCqtIu1BSnKNjNqVlL3+lGDf6AcaryI8viG3UKzz74bis0TkwVlNtSv3Fv1CAB3NwhyC+yStg5wBGMm+7ouuFlSPGlJM8tOADzP5OBLHZy9k9ssenEvu9tq/zBu8GppjHwD8Utl/7nsmaaXlYw/xXN3Ib/aXzPpO4/5HxncFiC4Py22uxYkdVNFWJfbHQvusYkzAe/oPZZTfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(2616005)(44832011)(1076003)(47076005)(8936002)(336012)(186003)(83380400001)(316002)(8676002)(16526019)(4326008)(70206006)(82740400003)(356005)(81166007)(70586007)(86362001)(40480700001)(2906002)(82310400005)(26005)(426003)(36860700001)(40460700003)(7696005)(478600001)(110136005)(6666004)(36756003)(41300700001)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 01:36:50.7242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844c85e6-da5f-4348-1846-08da863a4877
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cb1f65c1e1424 ("PM: s2idle: ACPI: Fix wakeup interrupts
handling") was introduced the kernel can now handle multiple
simultaneous interrupts during wakeup.  Ths uncovered some existing
subtle firmware bugs where multiple IRQs are unintentionally active.

To help with fixing those bugs add an extra message when PM debugging
is enabled that can show the individual IRQs triggered as if a variety
are fired they'll potentially be lost as /sys/power/pm_wakeup_irq only
contains the first one that triggered the wakeup after resume is
complete but all may be needed to demonstrate the whole picture.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215770
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/base/power/wakeup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index e3befa2c1b661..dcd06eac30afd 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -943,6 +943,7 @@ void pm_system_irq_wakeup(unsigned int irq_number)
 		wakeup_irq[1] = irq_number;
 	else
 		irq_number = 0;
+	pm_pr_dbg("Triggering wakeup from IRQ %d\n", irq_number);
 
 	raw_spin_unlock_irqrestore(&wakeup_irq_lock, flags);
 
-- 
2.25.1

