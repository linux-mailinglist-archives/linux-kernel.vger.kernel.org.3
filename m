Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8FA4CBEA6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbiCCNQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbiCCNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:16:31 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48DF170D79;
        Thu,  3 Mar 2022 05:15:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oaTEVTJjqNJczV8KoARWHTwZ/9RxHMv9zQEOra8ZtnBpyN4ODTfdjhpfHUHoJeg2fFKFffEq+u+CUXy3uxNddTMaAJhaAUl4PN6QbPCt5UdSTMNyvC3KtjIlaiGFjp29KVaGSb1r4u91T+Qqev3IQbds/YBuyDMB1HAFUKwc4P46wHqiBbcUwzZUGYDJ1uGMU3wC2Xv1zzY5NrvxM+iZBHdQ6p1M+G1jxsj+pMiFzIa/kmhJJ+yItMAtZIg/z5AD3Cfq8Zvj6t+KDXsSlOVzOkdpaWWe+u/2zwdMSAsyOxa81ZnLbrC2T6zQg+WXBqp1KtJbZbPEWejcKhfvD3szmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2NRF3zG5GTlITHNDIEFEyDjbn3EZCXYSkaV3O9354A=;
 b=JRyxOK9A84qnfZ5gE/r8/YNzX/zE0sps3bnCnvLrRMUfEHZ+vM/vIXCde7kAQ1VSaHoAy8f9Na31yNjrvqSRcri3NwAURMg6+CI/r82UcTWTwj5FFhHAv/KiL9giYDVTz7kONFq9CPpRIsnZ776Kfiy435ah2LomAhqZVCru4+2DUfDpCYviI7YjRMP+0ckzc7hNlyzhu8MFEhUsa7NnejSQYVVWZ5mSdEwNMM2ZciKBBjMiGNmCDmyeWLg6mui7Zw2hKJeoi9C3w3sWAkafueWGtFbiQm3VlIJ3CoxpPuMWUlvJTMeShULBlmDEpPo1tMzt4TqzUltKbnnkicJmzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2NRF3zG5GTlITHNDIEFEyDjbn3EZCXYSkaV3O9354A=;
 b=veoQ1JT9iQLvAzYQff48q3DQugpGcaoyfVTRF3RYI/MHjyCDLNwCp2uvOIcBNQxXDnu7+/OO0jtdsvEX6uMTHLJoecWLInuOFqCEZegRkuIBeAfeLyOQJPb9PchNdpk71FN9AvZCX/4D1zQEKLRCZ0WtOQorJrDU/CeVoGVnSjE=
Received: from DM5PR20CA0032.namprd20.prod.outlook.com (2603:10b6:3:13d::18)
 by DM6PR12MB2810.namprd12.prod.outlook.com (2603:10b6:5:41::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 13:15:43 +0000
Received: from DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:13d:cafe::d2) by DM5PR20CA0032.outlook.office365.com
 (2603:10b6:3:13d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Thu, 3 Mar 2022 13:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT028.mail.protection.outlook.com (10.13.173.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Thu, 3 Mar 2022 13:15:42 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 07:15:39 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 5/5] thunderbolt: Rename EEPROM handling bits to match USB4 spec
Date:   Thu, 3 Mar 2022 07:13:28 -0600
Message-ID: <20220303131328.4150454-5-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3bfff270-3284-441d-796c-08d9fd17eb4f
X-MS-TrafficTypeDiagnostic: DM6PR12MB2810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB28109BB204388D847909C219E2049@DM6PR12MB2810.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TZZXV5bRR4MBMUposappupUu1nt3kSr+0nALr/WYBFM0NIliZTamDwhJZvPihi9eUMqPXliRSEbsPBMUbGTyii8iHKTlatJvu4DqtBcDlId00HiyfM3eokIRqLtIEyK/xmRN73/ZGXW9P4ebltYwXE1c4KI8O/n4GXxcPkdAGoWgY4ri90q/UmDKI0FIX62KVTCmV7FWIYteNf3qk1UcbeyTO0D7UjMimUfFq/j5Gtb54ywxFJ/rnzlWKb80D3hWrK5/6nvJ72tsqTdUZFKNeNJRz3m3m9nH0d0rvoHGbgoLTWN7wmLOO9wcRjeaR7Yw96hH7KGFj3lmFpQEnK7imlj6iCOmuLnr0FyxMC6PNiVNKs7153VqhOjBlpM7wrSzUfGsgghZuJXVKDl5smq03tt6aqlVaSFkLyPUni3YaofmxjehGc3jBbmQ39njloAlCkMePJCJv4jiRqDSmMjoeXvJJJ50nk2xH1AVFVTAX3g93+720LhlEznOb5opyL2sz4npUn3474ZRwTtEIajBKXPY6SdyMB+YDBEkrYjQln3j/+xho2NLtoDQDuZP0ooQ1S0SthTxVSEIMMp1zQeofQFLaDKLD1vFJgysLApsQaF3GlJ/bnjB0OCmqO7eNCT4KHb3t0lqxHTPGywtZUSps2n8wUeXJOoXzs/GYI8F53x5pcPFJzb1HoVQRLfpcE2L8tj+jfPicJxsdXREVqvjZA7vrsg1PK2/3vvQulXnV2s94bObKyNvTnVh9W5eCQOs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(356005)(81166007)(6666004)(82310400004)(186003)(16526019)(2616005)(1076003)(26005)(36860700001)(336012)(83380400001)(54906003)(66574015)(426003)(44832011)(36756003)(86362001)(47076005)(70206006)(70586007)(8936002)(8676002)(4326008)(5660300002)(316002)(40460700003)(6916009)(2906002)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 13:15:42.2471
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bfff270-3284-441d-796c-08d9fd17eb4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2810
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure `tb_eeprom_ctl` is used to show the bits accessed when
reading/writing EEPROM.

As this structure is specified in the USB4 spec as `VSC_CS_4` update
the names and use of members to match the specification. This should not
change anything functionally.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Update commit message
 drivers/thunderbolt/eeprom.c  | 24 ++++++++++++------------
 drivers/thunderbolt/tb_regs.h | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
index 10cdbcb55df9..c90d22f56d4e 100644
--- a/drivers/thunderbolt/eeprom.c
+++ b/drivers/thunderbolt/eeprom.c
@@ -17,7 +17,7 @@
  */
 static int tb_eeprom_ctl_write(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
 {
-	return tb_sw_write(sw, ctl, TB_CFG_SWITCH, sw->cap_plug_events + 4, 1);
+	return tb_sw_write(sw, ctl, TB_CFG_SWITCH, sw->cap_plug_events + ROUTER_CS_4, 1);
 }
 
 /*
@@ -25,7 +25,7 @@ static int tb_eeprom_ctl_write(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
  */
 static int tb_eeprom_ctl_read(struct tb_switch *sw, struct tb_eeprom_ctl *ctl)
 {
-	return tb_sw_read(sw, ctl, TB_CFG_SWITCH, sw->cap_plug_events + 4, 1);
+	return tb_sw_read(sw, ctl, TB_CFG_SWITCH, sw->cap_plug_events + ROUTER_CS_4, 1);
 }
 
 enum tb_eeprom_transfer {
@@ -46,18 +46,18 @@ static int tb_eeprom_active(struct tb_switch *sw, bool enable)
 	if (res)
 		return res;
 	if (enable) {
-		ctl.access_high = 1;
+		ctl.bit_banging_enable = 1;
 		res = tb_eeprom_ctl_write(sw, &ctl);
 		if (res)
 			return res;
-		ctl.access_low = 0;
+		ctl.fl_cs = 0;
 		return tb_eeprom_ctl_write(sw, &ctl);
 	} else {
-		ctl.access_low = 1;
+		ctl.fl_cs = 1;
 		res = tb_eeprom_ctl_write(sw, &ctl);
 		if (res)
 			return res;
-		ctl.access_high = 0;
+		ctl.bit_banging_enable = 0;
 		return tb_eeprom_ctl_write(sw, &ctl);
 	}
 }
@@ -65,8 +65,8 @@ static int tb_eeprom_active(struct tb_switch *sw, bool enable)
 /*
  * tb_eeprom_transfer - transfer one bit
  *
- * If TB_EEPROM_IN is passed, then the bit can be retrieved from ctl->data_in.
- * If TB_EEPROM_OUT is passed, then ctl->data_out will be written.
+ * If TB_EEPROM_IN is passed, then the bit can be retrieved from ctl->fl_do.
+ * If TB_EEPROM_OUT is passed, then ctl->fl_di will be written.
  */
 static int tb_eeprom_transfer(struct tb_switch *sw, struct tb_eeprom_ctl *ctl,
 			      enum tb_eeprom_transfer direction)
@@ -77,7 +77,7 @@ static int tb_eeprom_transfer(struct tb_switch *sw, struct tb_eeprom_ctl *ctl,
 		if (res)
 			return res;
 	}
-	ctl->clock = 1;
+	ctl->fl_sk = 1;
 	res = tb_eeprom_ctl_write(sw, ctl);
 	if (res)
 		return res;
@@ -86,7 +86,7 @@ static int tb_eeprom_transfer(struct tb_switch *sw, struct tb_eeprom_ctl *ctl,
 		if (res)
 			return res;
 	}
-	ctl->clock = 0;
+	ctl->fl_sk = 0;
 	return tb_eeprom_ctl_write(sw, ctl);
 }
 
@@ -101,7 +101,7 @@ static int tb_eeprom_out(struct tb_switch *sw, u8 val)
 	if (res)
 		return res;
 	for (i = 0; i < 8; i++) {
-		ctl.data_out = val & 0x80;
+		ctl.fl_di = val & 0x80;
 		res = tb_eeprom_transfer(sw, &ctl, TB_EEPROM_OUT);
 		if (res)
 			return res;
@@ -126,7 +126,7 @@ static int tb_eeprom_in(struct tb_switch *sw, u8 *val)
 		res = tb_eeprom_transfer(sw, &ctl, TB_EEPROM_IN);
 		if (res)
 			return res;
-		*val |= ctl.data_in;
+		*val |= ctl.fl_do;
 	}
 	return 0;
 }
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index db3005cba203..b301eeb0c89b 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -133,11 +133,11 @@ struct tb_cap_phy {
 } __packed;
 
 struct tb_eeprom_ctl {
-	bool clock:1; /* send pulse to transfer one bit */
-	bool access_low:1; /* set to 0 before access */
-	bool data_out:1; /* to eeprom */
-	bool data_in:1; /* from eeprom */
-	bool access_high:1; /* set to 1 before access */
+	bool fl_sk:1; /* send pulse to transfer one bit */
+	bool fl_cs:1; /* set to 0 before access */
+	bool fl_di:1; /* to eeprom */
+	bool fl_do:1; /* from eeprom */
+	bool bit_banging_enable:1; /* set to 1 before access */
 	bool not_present:1; /* should be 0 */
 	bool unknown1:1;
 	bool present:1; /* should be 1 */
-- 
2.34.1

