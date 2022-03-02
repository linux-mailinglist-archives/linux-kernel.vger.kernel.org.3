Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8B4CB1E7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245437AbiCBWKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239678AbiCBWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:10:24 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0CD0042;
        Wed,  2 Mar 2022 14:09:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDiBEWmBGjAq9xK5g5zZwn7VLXBkJoeZLyLdxjTzlGXPLglgH2dmp7A6a63OQUlB04PyWQ264qByL1keg63U7IT2MlXwfQqrQOzLd2vGNzcmVbo6jW33k5GP69SxWk1s2aGwiDQkBXxgnEVTWG94yh2ygbbCVpFrZE5ZohjM+C5G4hvPuI7vuyET21Bg8/PupbailxK76T53NYd7W7+yg++nJGIhdv490Va8pDt8pXE0uAsrwj3Llpl7EAUVzr3Sv9Blk/yV+xyOriwWM8zlYKoZOiW8HQht+P3WLDbJ9nxiUPahj9tFNqFEUZiGme2kYc7HDoSv6zKYh+IYV8l9Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hvvkz22cI/82moHwP8advDJCS98rfENENo3muQ1o8Z0=;
 b=aP3+lRS/i93/l7gzoDVfcBWT/GsCNiGob5ldpqUfG1PP4kcdDafojRfvkvtZ4uB1+5G0IkVmTvOe6i0ZHaHoyw3L43NiyvOixOTicpSei6eBWV7ndEZXNMrWXx7h40pszXvRMgYYSn7Db1GaqVULDfv5QxQ65yuPgnPqm23xZQwBAxzotzbGjx7UXHJnelJzAFcZ5ss8vCzYlswEic+/4JTsSCRNDkgUblaxmsw54CeCKcs+kBZSRQgjRpGcYnrIxS9YJMWOrem8KjxqvWUqqqGVIqfLLlbSuXBiThvc9yW0tuAcqumiheG5b2CV4kNFhA1Bd8Way4DkrbxiT1JWrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hvvkz22cI/82moHwP8advDJCS98rfENENo3muQ1o8Z0=;
 b=wzI0S9R43BnTJfgc4+RUP4umiv7IUfayPFBfd6vXM7VYRqoN6QvXk7UlB1epgX+VnCGujLIdJlV0GHh8VXDYJ8m9ndzJhaMQXZrEpJguXj2ZJ3OIVHcarU0IEVDl3HLzw9k3oWrMUnGC9PZJsv6gucskp5EWPyD4whxyxmAafP4=
Received: from BN6PR22CA0026.namprd22.prod.outlook.com (2603:10b6:404:37::12)
 by DM5PR12MB1564.namprd12.prod.outlook.com (2603:10b6:4:f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Wed, 2 Mar 2022 22:09:19 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::5) by BN6PR22CA0026.outlook.office365.com
 (2603:10b6:404:37::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 22:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 22:09:19 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 16:09:18 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/5] drivers/thunderbolt: Retry DROM reads for more failure scenarios
Date:   Wed, 2 Mar 2022 16:07:05 -0600
Message-ID: <20220302220709.3138846-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74af3e69-31c3-4b6f-2013-08d9fc994c7b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1564:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15644047ECAEDD08EC6F399FE2039@DM5PR12MB1564.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnu4x8tjpSUf5FZjc5iebXAlLYDsWJAAQtL8bIH96m5+uSK5mrkNrFFJMEdwQxm3+sldOrUxJEiM55OBQBqkqnDEor5ARmr5RAJxfk75Kbo6Oh1lAyv/FqkNAKyuya7MODM+1E1IHB5KgMlXGU/weoWOybA/PD2keuBYJ/Th38PPIJxl2EyLJPmH3f1driQw+NCtwlJGSHCubBAmnZIEmxk6k/x1g8CdlodWgb8DEwBY/a8rgyEAVGT0+leSRRkgNmESrixwzKyeFsTNeiXEfdjlLnATmOS8vbP+ZlcssjBITlTJqUcT/QPnnwD9ZzAmHfmarJ/Hi4fL3ygh7IITThMRSmkusq87Ul6hrbX1ifAKKQpCAZb7ep5xIgxA6t9LzEa9koLrZbuWUB5CT3MmUIxL83QT9QpJnMz0LCMq7/9kbAFYJ5hGYr1OOQKfI0g1h1oNMHt18qpJtdFKvT2gYCEhHf2dwpOfY/IKT2XHxWKxgSYCt32N7I492zz7vK6o+k089+abD0KEvp9z7U4v0Q3fNdWF5k4+yEk2Kg5iwo0XBHR9ncF+kFkjeHAvvWHAj1ZFcW4cI3yr/i640lhskkW1+eK34MSkMs1i7yEULqhU5+0926LYmKZrtMiD/Z0q11H08iIzzlLg0yzQagP9qPrwl1k3HffKKevI7SJICV68z7G/Vbq5uEZaLzKkKkdK6c8Fnf/hZGvY9CryrOeAdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(83380400001)(47076005)(36756003)(36860700001)(426003)(336012)(54906003)(6916009)(186003)(44832011)(2906002)(5660300002)(26005)(6666004)(8936002)(16526019)(1076003)(2616005)(316002)(82310400004)(508600001)(4326008)(81166007)(356005)(86362001)(8676002)(70206006)(70586007)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:09:19.2344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af3e69-31c3-4b6f-2013-08d9fc994c7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1564
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

