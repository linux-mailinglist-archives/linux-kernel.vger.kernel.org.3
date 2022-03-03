Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1F4CBEA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbiCCNQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbiCCNQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:16:29 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8784186BBB;
        Thu,  3 Mar 2022 05:15:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWOzRhCX/gaTOTJRdZnWuCm3367ZmY7r/fXQzehWXN280NKzTMQnrmGJWdsDafzaK17Uy/JYWVxGnAs9AUnoinGnZOTIyE3xtudNFRRlZoq2Ol7g3uDzEvGv/vSerzBOR0yhQ27LrJ5f6QJIeyl176bGVUxaZo/Kk5a9I0i9zWZ/ZjzAKjKRfNMsZegGBgiqqI8qlHfRmZcMTvfencVuu/1UY7khG9lpX8bc1cTMGzryBOubOxRlVIiukRQT26uHS/MKtr/A3+2MXqF4XgxdQCalQIg3g0Rra5Rhltzq1RTCwpgx5UShavHimP+kdEYRIcpYKXPrsciebG5QuA+z4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ05rl+Hv+LLvILKjU3bXgpTJeLdmAPTWW+XWCJQjSk=;
 b=N4Kv3Hd46lnwqphIxPC+Nxya0P6u3oTWietVLc4fcFwqQBd/RL09TrivqD3PDY3cGvQRv5Mi4jmjtrb3+V6X0YB2SsWj7iGfLJ6sYk4f+vD7f/TG7CdRAFldnX5Gvo+ThPwHlKxwVXlFTIW2jgoVHoK1WrsY6BNeg4ExdD62NZiuShNVIcygnHuAXp6mBDGxWrgBaWtVLBQaB/WS6rcdEhxJEalmfGAgC2Ta2YcfyRW51mwtWJGzSeQCHtjix4pA88i8c70Z6IW9XA8/j5K+wWRq68Ap9HveOOy6rOeRdCUVWIJ5iFuno69jDvxHANjvGOaEOmb2THbQZGj1h5h8KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ05rl+Hv+LLvILKjU3bXgpTJeLdmAPTWW+XWCJQjSk=;
 b=C7J0qklia8hHMGkU8NSqoS63Sb/73GI1ijXCcupAr2YZ5j+hQnZKjrFt3jk2133OkXZWg88AX08l9UuY3vi74tn3qhJnkNrU2/+nEAi5otUW4v9JEOl+GSHmRxQFt1j6XUThkCJQnCFIBu++V6MyLTCLEVEJNisGr1OaWYnkuRQ=
Received: from DM5PR20CA0034.namprd20.prod.outlook.com (2603:10b6:3:13d::20)
 by MN2PR12MB3615.namprd12.prod.outlook.com (2603:10b6:208:c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:15:41 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::a3) by DM5PR20CA0034.outlook.office365.com
 (2603:10b6:3:13d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 13:15:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 13:15:41 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 07:15:39 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 3/5] thunderbolt: Do not make DROM read success compulsory
Date:   Thu, 3 Mar 2022 07:13:26 -0600
Message-ID: <20220303131328.4150454-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220303131328.4150454-1-mario.limonciello@amd.com>
References: <20220303131328.4150454-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403384a4-8e65-4ebd-faca-08d9fd17eaaa
X-MS-TrafficTypeDiagnostic: MN2PR12MB3615:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB3615936E81678A85038201C7E2049@MN2PR12MB3615.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X38axaovnNXuzOsH8hokB6cbFaeH189wZAxjpTBLxOGlWajUhatrjb27xMalZKov3pnX/0rqeuFLYn2pURc381/ZlXCeCen2dSyGaXd/DDG/5XwnBAJ0nfycYlOvkBpjZVUhsCsYYheMqV2IHd4gLeAxAYC2tpyr3Atnsk9A4xLcAOtIWv80shtNZcZZUt19IDHtKEUFQLao9oh54XMtvFVye4bSFOUz65SqVSBjtpr45UtpFAFoRwt7UeYQ977ZxTaiLaxpD29E5c0T0oaqTpZBGQxnimO+MErjvuTOLBUw3HSddjhE2geEMc+QTnGUl7zr1PIz2E5B5He/VPYY/qhA0qNMgfNnY81UWUOCMgIIUJ+GP7AaXA+QRylI1NCsPKi7Tv1QDbVlIzyMWGED/mj+LMjTOAO1wkEmcr/lZ2Yb+8YrmRz5ghUQ6iSBvQimfsI6S5fujawJE6LgwoNBPALEOc2rw6/P4WxUmnz3767Xdp1Kc5XQM44sJ4zPHnu7S3upMwUBzcfMINlk7tVhXqVoemUVH4uCsn07WcBJMzELlMN3tdM7FinpnfSp5RbMyvlu4f05czHCTyiQ8PrjjKyx90bH//H2nz8qmkh0kLJ+8yQzmQf9036eI1gMZSc/y5Gr8ix9N8kBRc/EDxsl8Lw1xIXL2PBAsmQCLVVR2KvVObg8r9rYE1TiZ47hmTZnTxP8aSrJ+GdTyhpSmwkwbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(426003)(66574015)(83380400001)(8936002)(336012)(2616005)(44832011)(54906003)(86362001)(6916009)(36756003)(508600001)(47076005)(16526019)(40460700003)(1076003)(186003)(26005)(5660300002)(316002)(6666004)(81166007)(36860700001)(8676002)(4326008)(70586007)(356005)(2906002)(70206006)(82310400004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:15:41.1691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 403384a4-8e65-4ebd-faca-08d9fd17eaaa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3615
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB4 specification doesn't make any requirements that reading
a device router's DROM is needed for the operation of the device.

Other connection manager solutions don't necessarily read it or gate
the usability of the device on whether it was read.

So make failures when reading the DROM show warnings but not
fail the initialization of the router.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
 drivers/thunderbolt/switch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index 294518af4ee4..ac87e8b50e52 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -2784,10 +2784,8 @@ int tb_switch_add(struct tb_switch *sw)
 
 		/* read drom */
 		ret = tb_drom_read(sw);
-		if (ret) {
-			dev_err(&sw->dev, "reading DROM failed\n");
-			return ret;
-		}
+		if (ret)
+			dev_warn(&sw->dev, "reading DROM failed: %d\n", ret);
 		tb_sw_dbg(sw, "uid: %#llx\n", sw->uid);
 
 		tb_check_quirks(sw);
-- 
2.34.1

