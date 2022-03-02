Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 095024CB1E3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245413AbiCBWKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 17:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234152AbiCBWK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 17:10:26 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2057.outbound.protection.outlook.com [40.107.101.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AFFD109C;
        Wed,  2 Mar 2022 14:09:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kOYsVIQBbfs6UBuUsTsKLsU+cbQJjo4pCiPo1l/VZkJpy6R8PPVDzkL9p2qnrwpx3xonAhlp5RdPpcu8AGSfG207mTKfJtQMuprvn7XdhMLltfKYAZOEEbAJocg9vJru3QOjEN5ifXrnZGynWNDeF4QvTnvAC3IB8jFTD+XfIO4RQ6LXHTS8l9shJEEixuMGtn07o6D/JsW3Sndw/kQyHW5WjBIBBYZLY9ADX3A7h/xaYnaRsvtMRmx2Y9V1mo4V3FC8R7rVx35c797dOMByW5Sa3gNY639u9PohSLWHX1p3p31BH3wBuoNG58LgRNwNmAHeMugsU5rkLhMSEmnxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QxowHVgZdoZMhs9XiUyKIrhkZPWp+x3L7Wm7eDtKpHk=;
 b=jbgbKneM6j/Q7bzUql6q/fFK9AznLBa8JIE5UW7IpxAkNPx+3tn482uINeEWY9pfCak6QrmkzVyMnt1MSF3n5M7rBUrK6ff6wBdwFgavmepSmwM16JC94QU5WDs/xV87Oc1mJSTtu77rqdqkqMwzJggCpjYJlW/FZsiVLPeXAK+PVUtIxA9duVXpVzoAKK33oQ5RUITY0ziq1S5ocyZUe2zbnW59LjzECyrIv3nhX+pyhLw+xJPXwvxy/+J5KOUXlD9VwLKzoxDz5IchPurMwtfy8hKwqDDG6o/oZ6QSg8+wrT+vYuj8vb4DZS1etj4nfjD0QxRdkJYN8OW8ldS8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxowHVgZdoZMhs9XiUyKIrhkZPWp+x3L7Wm7eDtKpHk=;
 b=stDzonHoA8+KnZGlydxf1N3mjoVu5oqm9Di/5cqF4HOdrH1clviFr8e1WxW5Z2J87eQ9VnynrLsQ1W+GWbe1l0tahfyU6hLuCehBtfKVL/QQlTxlNbb70FQob51mEZKuqANA2i+v51kMPvMj5NyP+XzUVVWgFLDT6sivhP1UvB8=
Received: from BN6PR19CA0096.namprd19.prod.outlook.com (2603:10b6:404:133::34)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Wed, 2 Mar
 2022 22:09:23 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::ca) by BN6PR19CA0096.outlook.office365.com
 (2603:10b6:404:133::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 2 Mar 2022 22:09:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Wed, 2 Mar 2022 22:09:22 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 2 Mar
 2022 16:09:20 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5/5] drivers/thunderbolt: Rename EEPROM handling bits to match USB4 spec
Date:   Wed, 2 Mar 2022 16:07:09 -0600
Message-ID: <20220302220709.3138846-5-mario.limonciello@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 41470ac5-a27c-4248-86ae-08d9fc994e93
X-MS-TrafficTypeDiagnostic: DM6PR12MB3947:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB394797A3907E96E2CF596B38E2039@DM6PR12MB3947.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PYmb9m0mf8Jjh1GHdDDx6QW7UGDr2Kxx3rHB7GujOY9m3s8YEx0kIgatQS7hOeKiJk/91tOblrFuhiloM/+wH+6Z8AxpELidJplC/eb6tRwl+PKRPdo//EExsR/WB7g66g4mToizKOQE2FUyQDMR+SDOkWmm3emKmYM/xdGm42E8INp9l8MEK00q1TrnH64qEBzj1u0JwvypMIVxtwRBoH/xmpeEmuM3XaqXjzVA/mi5fAKN62dMoZ808UK23331/HQb4E42IcF/gFTCtie0bynaXV5KSTg+pGCOwNDkXv1pqd+1dhW2+RGfTcgCK8l6dX76xnmkYea5+1NJtNhhqnAwDgAdZe8wA+yzDRzXlUtoZkAJF/3QB2O6liIHE9ZnQldM8mnu5I9Bw1H+FUhD/3m3lweR0dgVtju80RsK1/knG56TJ8cjWUlyRNNgWZbxnApXT8ApDDkNIj+SDIWT4crNT1BCLBke+rGy49Azi3K4qBAcpNJ1zMRe1UFSGUgYY6eq1Xi1w5PGmmDXzNJBR3HU4Dhzt3BY689NnIK3K6lOOezgf9LdnYB0kQ+OXhKzcnfcYlIro6vQE7458+H74xuzJ+meVHhS9n0Jusan5bcEmoOwxvGuXM57iv614G0Qdp4oVkIT5N1WLsvZypXpL+MRxdXbsroqMNtNvAjUBnH9LA3DZaqWyCfsOJvWpOnq8umakHre9Exvtm1no5LSzw6KS1u9B/w1ch9MtpzGlNCtYoJQ4AUzeYFLzHf1J4XKCF+8M9pdwb/DnVI/L6qCCsRlA9O/EFMl/i7cn/caAog=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(66574015)(47076005)(70206006)(4326008)(70586007)(316002)(2906002)(86362001)(36756003)(36860700001)(6916009)(54906003)(44832011)(82310400004)(8676002)(8936002)(356005)(81166007)(5660300002)(6666004)(1076003)(2616005)(508600001)(186003)(16526019)(26005)(966005)(336012)(426003)(40460700003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 22:09:22.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41470ac5-a27c-4248-86ae-08d9fc994e93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
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

As this structure detail is specified in VSC_CS_4 on page 510 of the
USB4 specification in table 13-14, update the names and use of members
to match the specification. This should not change anything functionally.

Link: https://www.usb.org/sites/default/files/USB4%20Specification%2020211116.zip
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
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
index 8c42f8bc679e..872d8977d5e9 100644
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

