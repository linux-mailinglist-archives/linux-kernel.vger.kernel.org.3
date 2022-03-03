Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FA4CBEA1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiCCNQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbiCCNQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:16:28 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2057.outbound.protection.outlook.com [40.107.100.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03BF13CA3C;
        Thu,  3 Mar 2022 05:15:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oog8VwjLrvMqAQO94EZZd4F0ad9DaXgWqIqaTk9KJIBVrez+KarbmzKz3HWUuDbff/k+Ug77UZckq7N6lb5dwKfllQvK0S3z8MnGTXzUZVaxD6SH4Cgeh1ajqzgrdGuNH80w2ACl+wiER4v/0wobz1Q0saio1fdf0BS+5XPnge430Klhn5SmleHgXVdhLRidGimlgk+PKbZQ5SSJ31ruNaBHVxJIo/cdEmRlUoMgO2zOPLmoPd9Oyq0hdKE5ve8WCKbQltevQyCzCJeloeD6GrxWNl7TLAec+fKRW94tq0zGYJ/tFreLm2vEsjPOHt7w1GgWMRPBMg+hhijiig2cUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JU2JwBMrtcTuzgLoFzarmFiY+HfUTLTIsfMWE2hKFc=;
 b=d1FQa7yeMtNOuV+WETsuHXYtgw7tihupCm7HSApK/hgETSE5/bnA2TuJpXyaoBxsM4VZn9GH56t9cZWGo1mglVjOVAIsHAtV9NqlpOuM58XlFu9YfGmV3GfjQ74PWMPpnRN2JRXKkVptpE9XmTXfbKXPBYRCzcX2Yz4mt605MaWNeyYtIZZRA2AK0Rx7xCfwou2/d8pffkD5yscYGv25beq+n9eh0YrAn3WNxSQD7MEc+KxVHYvokcGAGPTnB4grMAQR93gaSn+aSgHbOG9zeESFKGdoqyBHuMKZxdzAawOnbJ5Yrjha/4q2rjaMKCMbAqgH0eb4w3YhxKnb6Qf9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JU2JwBMrtcTuzgLoFzarmFiY+HfUTLTIsfMWE2hKFc=;
 b=jtnYmMSd2DloiKqdeKV98gBF4SnJ8UvYsjUJSg9tBBLOYiMW6o+lKs9gsRM9N3aK3ZZZoOCy85eY0IJJl36MSkMrSEthvmFaHwpfqULXiPrQhtIEN61bmbgMCyM5wYZ2UhU3AK2AsouM+qeHqTpOInNjZBBbdkekrUGxntLY8NU=
Received: from DM5PR20CA0040.namprd20.prod.outlook.com (2603:10b6:3:13d::26)
 by BN6PR12MB1268.namprd12.prod.outlook.com (2603:10b6:404:1a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:15:39 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::66) by DM5PR20CA0040.outlook.office365.com
 (2603:10b6:3:13d::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Thu, 3 Mar 2022 13:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 13:15:39 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 07:15:38 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 1/5] thunderbolt: Retry DROM reads for more failure scenarios
Date:   Thu, 3 Mar 2022 07:13:24 -0600
Message-ID: <20220303131328.4150454-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b5c9b4a-725e-4c7a-0de6-08d9fd17e994
X-MS-TrafficTypeDiagnostic: BN6PR12MB1268:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1268725C04CB278860B89A2FE2049@BN6PR12MB1268.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSMUzhU3d6lJI0yf3cfG7hOYasEWON3nmzR/+Ya/zG5VBhz4gqbGlYe8r5AVyLtY4QngzUJYnoWLfrf7X40LQ2FLNww8wrvpdA0y+NH6C2Y+yDtVDZ+MVHNmRvCX/xK7sPoqMf59PUXP3go+MQw36SNxbG7feTh04pWRdAgSh1Ijor1EKl4W7+3MIfc0jweZpj7PAOdzSvE8OfOJBtSk1fsBymTMptahoU8MMFjuzQhNViW3FocKBB5tdbmDKJtTRO1CjUOej5J2yrkllx7P8zAMDwbuYr7p+Kj7NgBdlOYwXnXKKlnt3N+BYmYc9jr97qvrbRwN/UjJygJO/O4IFHgEm/E7GythQ5VWJdZToZiR4hZ8evdA7QMVZK1hnm78Bz42EZVxaeQGozZsy96Kr79fFWo+yRMDJ5M4vPvXgnDHUZfA2SHzrAJCyXmHd6Isblr1ESd4AWplhYXtpoQyZTIeCRMMVx1GsO5Ga7dCDTneczJho6IfpglOJvKCTtNELVBDDM1aKJPOqnBzRDd88jgbpJPh9aq+X07OrgsFutIIoFLsm8I/9XCTyfD000mqvRS9/Flh7mnT/RRiXJ21zakQvBAFVoS6ArCarFZL9aA6jDVrEv5IdrC56Y7S25m0VXddV5HeXCPo2ZwiHBr2em5YbE5/E/Z6TZTd9yv6edR72zvAfLcC4d4XA+QbVRlMEeA4NifDppoxmQ1XXDTYqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(186003)(26005)(2906002)(36756003)(6916009)(44832011)(1076003)(81166007)(336012)(426003)(47076005)(4326008)(8676002)(36860700001)(508600001)(83380400001)(70586007)(70206006)(16526019)(2616005)(6666004)(86362001)(40460700003)(54906003)(5660300002)(316002)(82310400004)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:15:39.3411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b5c9b4a-725e-4c7a-0de6-08d9fd17e994
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1268
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently DROM reads are only retried in the case that parsing failed.
However if the size or CRC fails, then there should also be a retry.

This helps with reading the DROM on TBT3 devices connected to AMD
Yellow Carp which will sometimes fail on the first attempt.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
 drivers/thunderbolt/eeprom.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 470885e6f1c8..10cdbcb55df9 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -553,9 +553,9 @@ static int tb_drom_parse(struct tb_switch *sw)
 	crc = tb_crc8((u8 *) &header->uid, 8);
 	if (crc != header->uid_crc8) {
 		tb_sw_warn(sw,
-			"DROM UID CRC8 mismatch (expected: %#x, got: %#x), aborting\n",
+			"DROM UID CRC8 mismatch (expected: %#x, got: %#x)\n",
 			header->uid_crc8, crc);
-		return -EINVAL;
+		return -EILSEQ;
 	}
 	if (!sw->uid)
 		sw->uid = header->uid;
@@ -654,6 +654,7 @@ int tb_drom_read(struct tb_switch *sw)
 	sw->drom = kzalloc(size, GFP_KERNEL);
 	if (!sw->drom)
 		return -ENOMEM;
+read:
 	res = tb_drom_read_n(sw, 0, sw->drom, size);
 	if (res)
 		goto err;
@@ -662,7 +663,11 @@ int tb_drom_read(struct tb_switch *sw)
 	header = (void *) sw->drom;
 
 	if (header->data_len + TB_DROM_DATA_START != size) {
-		tb_sw_warn(sw, "drom size mismatch, aborting\n");
+		tb_sw_warn(sw, "drom size mismatch\n");
+		if (retries--) {
+			msleep(100);
+			goto read;
+		}
 		goto err;
 	}
 
@@ -683,11 +688,9 @@ int tb_drom_read(struct tb_switch *sw)
 
 	/* If the DROM parsing fails, wait a moment and retry once */
 	if (res == -EILSEQ && retries--) {
-		tb_sw_warn(sw, "parsing DROM failed, retrying\n");
+		tb_sw_warn(sw, "parsing DROM failed\n");
 		msleep(100);
-		res = tb_drom_read_n(sw, 0, sw->drom, size);
-		if (!res)
-			goto parse;
+		goto read;
 	}
 
 	if (!res)
-- 
2.34.1

