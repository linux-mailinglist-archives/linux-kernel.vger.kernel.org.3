Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554794CB1E4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245461AbiCBWKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbiCBWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:10:28 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D8FD76D8;
        Wed,  2 Mar 2022 14:09:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLAmvqFwnzj08FkuDGLUMuhqnsN2hKn+e/qukp1xDzkXLNNBWN/+PTP9EwEH4C7hqOOngnqguJXMCgs8T+O35pyQFCAJ9Vk/L5EMaHHp71rVku5CaWa/Lp9bbGjwMp67StxjD1OcCIot4/7XM5ocjQgedIklQJsWSWmZ+V17HnUhMY9w6AWnPB2VDvEsVp4pI+FyP5rZW3M0hl+rv516L9ToPBU56qTA1zlby0ht0m6BuKNbyTgdBhgQnJAFPqvpjR/7SDWX/S3koF1mfanFveC7vmG9xuZu4gHvFxG0YVobwqIOSumImBmXuizqXpYiuhSTCc6w84adx2Yz3nCHHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iargjDpNmatEDQGnWAO2Dk+3PE3O4vlBH9Ssb40hmFM=;
 b=V2hdkxJTacUpWTooMv9WKXUYjsOY1ARxUnXxi1M6ToBm/WsPp60nm2W+IxLx2Ym7zScIGoQabyLKr8i/C4MXGBYB/nxf1hkMGlGutlwx5Ce0DJ4URTF6zwJr3vbrGKKy7ruGTnft2zOPgTFeupMNb+kcpQqq572/yuJlFe0LLf7DZuS4ANgmYBf/vfwxSsJAtF1/p1/eTsTtvTF4F0UxyJdjKNkYgZUuF0Rk+97cw0zSpdQhWLVR7MaItEQcp/R/LiYB1Iae3VWtnMdpHNNNBbT5B+oX1pTXSz5Wyjp2HKcp6jyTYaMGUyfgps8IzwAfuQIStWmjOowIlr50Zu+DjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iargjDpNmatEDQGnWAO2Dk+3PE3O4vlBH9Ssb40hmFM=;
 b=NeGC3cFeP+usGrmlVdtYOLj9kHrgfgrkflEg6oi04QMIMgoaMbQi+0mLUQK8Zn1/xoFUebZ7Xv/KtyXvUvVruI4I2Vf4gC4iSJDBKvT3Az+/dEE8HdMWLcyYS6XfPxDJGyvdc6k2XBR9AoM57Jvy7Zf23Gc5aaZUIX4t/wjiXuo=
Received: from BN6PR22CA0032.namprd22.prod.outlook.com (2603:10b6:404:37::18)
 by BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 22:09:22 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:37:cafe::ac) by BN6PR22CA0032.outlook.office365.com
 (2603:10b6:404:37::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13 via Frontend
 Transport; Wed, 2 Mar 2022 22:09:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 22:09:21 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 16:09:19 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 4/5] drivers/thunderbolt: Clarify/correct register offsets for tb_cap_plug_events
Date:   Wed, 2 Mar 2022 16:07:08 -0600
Message-ID: <20220302220709.3138846-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302220709.3138846-1-mario.limonciello@amd.com>
References: <20220302220709.3138846-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd764558-0fe8-4bdd-430b-08d9fc994dea
X-MS-TrafficTypeDiagnostic: BYAPR12MB3351:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33512C947EE4387FA269C6ADE2039@BYAPR12MB3351.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LWtV5Y2eAXIkUu615tieCBgbnLEKhEEre6iLM/vmTea6wdAFp97OuXoRM8+Kb1W4lv9FZC8NC9kS+3m3xREHA31HlEOjIRk3Nj33ZCQVXplx+aTE6oYvqNnABM6iAZK17ieF24fTlVMWmZ5yqsUMl1KXBKqrjPUrpDMpdofbsamSHLQZcCi9dXPj4j2C8PJpAvJljhiYBxpm2PBzsQDa1Z/Y7JGAomBsBuVJSoP8on6lZfTtUye7piyOllJkarbEI2xN9k/lWHwwh6/iQNiN/Y8USwqcJKlGCm+BYqcJI1kyptqO3wxRM4kmUY1XAr52jM6tCiae3zbOw3MnMYGvDMo6gS3s0UZ0zQJraz4o5f6vdjk+IOAfSTyiqDnB9IzsXin2IO+hGXNHWqg1cJliVfu4hXpQUVOaA+efAPmxW9b3mz3J0pEpv/rylkIGUl7lNPJIpnvjZyUQjiuOd1v+Xsja02/suqTDf7exBTlwLXbEelJGNipVJbN8w2HOJngYqdjEd78VMY9bMjbtoKClNf2MvVwr8R4xxeZQ2Aie3rktJRcMdedH18ezbmUIhs3LYnhEltVYi4ue64wOJeEYXCWiXlnMCqbjIBW9RSjEm1Sl1mTyge3Jszl7MxMrt/FICQJtoao7750Y9ABV+NMnJWH7Q1NM2cnkY5He0GtViih97k1VNr+9LO9AsPnSXf6y36EOcARjqS9CdX3wvYWYvwQdOs9AICT5Kprpmy5qj8MEosidbJIwBXckv4uwqgeHBl//UC/9l2+sZ0bPSzCtjo3g/qGiuUD7PHp7j1oXPRY=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(2616005)(8936002)(1076003)(86362001)(8676002)(426003)(5660300002)(82310400004)(44832011)(186003)(4326008)(16526019)(26005)(6666004)(336012)(316002)(81166007)(356005)(966005)(70586007)(508600001)(83380400001)(40460700003)(54906003)(36860700001)(6916009)(47076005)(36756003)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:09:21.6404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd764558-0fe8-4bdd-430b-08d9fc994dea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB4 1.0 specification outlines the `cap_plug_events` structure in
table 13-14 located on page 507.  This shows that there was a mistake
in VSC_CS_1 where plug events disable should be 4 bits and
"TBT3-Compatible" should be 3 bits.

While correcting the mistake, update the names and comments to more
closely match the specification.  This should not change anything
functionally.

Link: https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/tb_regs.h | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 70795a2aa9bb..8c42f8bc679e 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -146,14 +146,14 @@ struct tb_eeprom_ctl {
 
 struct tb_cap_plug_events {
 	struct tb_cap_extended_short cap_header;
-	u32 __unknown1:2;
-	u32 plug_events:5;
-	u32 __unknown2:25;
-	u32 __unknown3;
-	u32 __unknown4;
+	u32 __unknown1:3; /* VSC_CS_1 */
+	u32 plug_events:4; /* VSC_CS_1 */
+	u32 __unknown2:25; /* VSC_CS_1 */
+	u32 vsc_cs_2;
+	u32 vsc_cs_3;
 	struct tb_eeprom_ctl eeprom_ctl;
-	u32 __unknown5[7];
-	u32 drom_offset; /* 32 bit register, but eeprom addresses are 16 bit */
+	u32 __unknown5[7]; /* VSC_CS_5 -> VSC_CS_11 */
+	u32 drom_offset; /* VSC_CS_12: 32 bit register, but eeprom addresses are 16 bit */
 } __packed;
 
 /* device headers */
@@ -464,6 +464,10 @@ struct tb_regs_hop {
 
 /* Plug Events registers */
 #define TB_PLUG_EVENTS_USB_DISABLE		BIT(2)
+#define USB4_PLUG_EVENTS_LANE_DISABLE		BIT(3)
+#define USB4_PLUG_EVENTS_DPOUT_DISABLE		BIT(4)
+#define USB4_PLUG_EVENTS_LOW_DPIN_DISABLE	BIT(5)
+#define USB4_PLUG_EVENTS_HIGH_DPIN_DISABLE	BIT(6)
 
 #define TB_PLUG_EVENTS_PCIE_WR_DATA		0x1b
 #define TB_PLUG_EVENTS_PCIE_CMD			0x1c
-- 
2.34.1

