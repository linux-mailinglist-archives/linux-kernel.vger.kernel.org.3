Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4CD474259
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhLNMTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:19:15 -0500
Received: from mail-psaapc01on2105.outbound.protection.outlook.com ([40.107.255.105]:1384
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231873AbhLNMTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:19:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkL9Qk/tdefTqjlgNJ5S9rPNyuB9Sj64ZkYMI2KRThrkYkMS/+fviOF4DC6ilxwepaFoUYPdsr7jIa9U96Z561biVn8iZ6p4pcoNE2kUHBUDOQveisBLAHTbG7GqnNzg3H0M6xOcZY7RjBBWGrfPi749fAPF8mWJBl/o6fjJ40m6u56VcGDH5Bv40IzfhDV/RbHHqPW8NU5MWO4W9zKilvU7Iq8C9lyGZkbMG4TNCVg92wkxrAFKV4BTEZSSTp9z02motKhUh/BGZGiTC65LYap4oAKPJm9c5ktnb5gPOO1MytsHRDL1YQJT0/TbD0fjJ4iuvXQJcXRtjYVxAVC3mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T66GUk7ke+/ZNgpdm3a54rbSRx6KCJEC2uK9LxtB0uo=;
 b=JRk3dSOgSsU7bjoEFRm6k8sAkhS5HBcpNGtGOaOlH8KHZVEApaQ6TpTJz0/9/EajQl9ChGHFWJ1I1M7O6ggnRlqvvPoWmAY7bYT4fyTuDf4NK8ggp8M67f66vapsYMLge6Qgq+0l9ym+I8sXicYyOnKbLIhNs+/D+uPNYEI2Jwa274WjQNYUJctlgaRuJ/+epuDAHjcXTWW3gBZ1x6Ka+rk6HGILw2HAKE8iToiDNB0+bNh6a9dn0AG3JR3s+4PDJiN5Vsh7YjYGU1vxDJEYH+4c6oLfXwO4Zso/C0m7Pu9KYLfkFIN9s+JjlqVWySCz8/lotZsgzXMmoQolLMXSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T66GUk7ke+/ZNgpdm3a54rbSRx6KCJEC2uK9LxtB0uo=;
 b=ItPjDQP1mzeWHeWAXprZ/b07OcoAV7is8eS3Xyhvm8/osi3lw8pvvX3WYJ/vqCUlse+eC/hfCh92hhBYSoN0xbh1Wc3jp0nDrRbOEUyjN4Jm0G8V/NFaecPi5ijytUXIKUzXfb1WZIQaT3RjjdEehA8VkDs3bSj5hpv+VhM9ZLc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3084.apcprd06.prod.outlook.com (2603:1096:100:32::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 12:19:11 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:19:11 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] power: supply: fix check_bq27xxx_data.cocci warning
Date:   Tue, 14 Dec 2021 04:19:04 -0800
Message-Id: <1639484344-75960-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0071.apcprd04.prod.outlook.com
 (2603:1096:202:15::15) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7360cd3f-3c9b-47ef-f16f-08d9befbef67
X-MS-TrafficTypeDiagnostic: SL2PR06MB3084:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB308441CAB071D04D812FF7B3BD759@SL2PR06MB3084.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:324;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5aWeH78nLoCRdek8D6J4ZpdgDIbcpNYW3sSXn3aZRbkrSsTAVx7KpI1SzL6ZrS2EoGocx+y30qlVh8ACjNVG0lSUQ/AX/QtPLiNlK22gmVTh7qlxZ8vfqzrAW4RTPO3cQOCbtcKnShE02czED+ENw3TtDHhysLzbByv1XklRrJc23Ovh2CsmApzeE5e3MNWjDjtlh2OJJWuIyybnlVDbHLP7j7YmsfluYD7rnkNukyqNNfpPo+D99Ww4B+1tmgoFA7FwIZL2fWAGBRWQS3bVWZIxMXH3gk2gvqUh3jFTRl2+x53noMfVfhhPe4iAglcYWzjgjIinzxq/LIJgnJJNn3LbODZh1jykszaq+w12EkEmbFdQK11xzedX4MrmPNpOGMAB3uKYnvRSnOqi63YBPpkNlhtYKczNS+OjxCYpufdEpKOAAimDhvPU7NhX/ucx4YnSyw8cSR0VGlt7sJzQuERE89O3I8Ex3Z1wkB0mCNGnM1Yiw/6RBR9zj5vfjN+Ni86A4YSwc6/JfXvjr2+qZSsiXIXSD6tD/TxnjtarR5lphRFjFvdjA9yNMVxRaNBV0YSx08OhVW9ZTp6dBhJTeihTyy40Z0nF4ilacGYI/5paUaIwQy7r/ZsJEyksN5KomF/wZ5Ey58DXaEjSGjqBf6T4aqy5E1bV/QmbY8/uLJsowFSLryiQateTzwrNt9nEnwKEnhE9SIUwGUqiEQq65w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(107886003)(4326008)(316002)(186003)(6666004)(8936002)(2616005)(66946007)(66556008)(66476007)(6486002)(83380400001)(26005)(508600001)(5660300002)(6512007)(86362001)(52116002)(36756003)(6506007)(38350700002)(38100700002)(110136005)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?poZRrCudxxL5SfkiWQvcJ+n5ohwSOcnI5oy9S3zlGkktbzcuNz9HiuXIJHUD?=
 =?us-ascii?Q?yAgEsV4JueSNAEclTd4PNb+cyEo9jtEruwk7/sj7I5W+T1p+2kLStHMJK6rG?=
 =?us-ascii?Q?svTbz1aLTzxDS6WT7YkWM6rag2sYiwKuwXDSOdr6ZP2JNnNcjetoL1ibDrKs?=
 =?us-ascii?Q?YsY36WrPbjgLvNQCMYt6u06G8LIuI4d2HeHEEoxkj/TXuTHvR6eu2BpY7GD1?=
 =?us-ascii?Q?CSXBrYOSppJ9QkBGTwne2NC+qxcYbEHNM7FGz0tNHVmpvMFwDt/tGCrATqdu?=
 =?us-ascii?Q?TBLCKLAbVk2ufxv3wusUcLQ4zMLIlh98xmfI5GGZWBgJviOGOWBklx+6s4EY?=
 =?us-ascii?Q?6c+LG2KE8z5Wlp95FW1yaAIV9ELIcwuXA+1ThiQykXpWmtylk42lta4xAET+?=
 =?us-ascii?Q?UdJ+9xUReQPwTYjWvEiHXHPOmJLNRDfwIHsheJR0uUMQLslaPBE/NOe0ZmIf?=
 =?us-ascii?Q?9ekpCPl2UEaRk0/sXzCFHM4K9/b6kt+ypqvmYpVIHyAn5iSNO9UizjzKeWrz?=
 =?us-ascii?Q?INqdob6aiudhhzyj3DU+od+RyP8/VfPf/xsT7wA9g8pSdXL7km80bw1bmnt0?=
 =?us-ascii?Q?P5AlBgmDg4zfYHwqV9Bl+G0GJLBiNcylz0+8t045IWwH48JYlxHPJKDH4eCp?=
 =?us-ascii?Q?cSPd3Z9fPZI2Jv/ZeejVSsnllnNm93VC+8kGd5CS+95EBhfOlCERfJEj7RAx?=
 =?us-ascii?Q?UbUNLhccwKL8d4hn2gRdtOSNxspTN5O3FdL6BqrqPryJCXgq+/6SlxQsgPln?=
 =?us-ascii?Q?DZOfDi2TUcphsnZAquxsZPyOhwME1wPfj8WrP52mO8maHbG3vxDXMVzdj7fG?=
 =?us-ascii?Q?oe+GeqJ+V3eyRGG0PQ9ljF+Ul31B+2WpBGdoDY2eguA2cHT5l718yQzaFtRw?=
 =?us-ascii?Q?TvCgBMjYbdaXDrHhLvZ8siYM6eqt6k8t0D0XMLLEgtyndzsDqNRGbISeAej7?=
 =?us-ascii?Q?0U9y2iUMkBOJ1w8I6Cnwo+Ot9c9FaGoXuC7bcwuZSYgBdJyouNv6ffVHcKJi?=
 =?us-ascii?Q?2cNAAH7xgs+DdPCgtdqMwN7okvP2yfHTWaTGOaZ6XmzY9lrmQZ1boVkC+NPo?=
 =?us-ascii?Q?ANEGCQZ7txSsUuB3+8YQAssjsTDs2I8+E1+IxmdOngFTxWKpKaT03j4DwVyn?=
 =?us-ascii?Q?QWCKkEo8AII3nSQB/NAIww3svqU3NEdTszHcu8RPCmUlD9XjcGWpfaWAgere?=
 =?us-ascii?Q?z5/dpHMFbFfsmSpbyNHeCpdTSr5S1bmxWByDTeEDmT+db9TFr4zLQA7QtvFe?=
 =?us-ascii?Q?FwBQ+sZCy28jivRfrnDlW5+FeDAzLxhwzLoC4w/pXzhS/n9GRXne/67Lg3pz?=
 =?us-ascii?Q?eS8FVZmtVe04CbqVzzppyKDu0ZLcA1qfBMbOCGJEYrTmJeTmdKkU7ACn2V43?=
 =?us-ascii?Q?pcdGko8zcZsyBASxON/9K40TMUgx7tlm+9Q3SJ3wVaf716uj7CRv5JbhhMVo?=
 =?us-ascii?Q?Bs63fp7XEYgqymRzq/08OMVrc60f1vdMbrj83h4ovA9IxP2CZwwJWYxQ8V1u?=
 =?us-ascii?Q?XMM/cvCMqNM710rTjAWiP+gKszVZ1K9SVbcwhOCMMOinAzExiWSomc6se3JH?=
 =?us-ascii?Q?W5XEWU6qr5Jjwrtrcr6tt9BPNCndS2yLEcmB5SQySerOYPzTx8zQhpaT9ZhZ?=
 =?us-ascii?Q?1lyGVi+4quOkdm4cW1+hNyc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7360cd3f-3c9b-47ef-f16f-08d9befbef67
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:19:11.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZA78pdi6F5I7/tK7ITrRqI5KUYuzOpcChaX6gkof+6JpXhpU1JKnxc4t85MhuPiw/2Grm5rGQJNXfidkQFJP8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3084
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

fix check_bq27xxx_data.cocci warning:
WARNING bqXXX_regs and bqXXX0_regs are identical

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/power/supply/bq27xxx_battery.c | 86 ++--------------------------------
 1 file changed, 4 insertions(+), 82 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 7e5e24b..757eaf7
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -475,27 +475,7 @@ static u8
 		[BQ27XXX_REG_AP] = 0x22,
 		BQ27XXX_DM_REG_ROWS,
 	},
-	bq28z610_regs[BQ27XXX_REG_MAX] = {
-		[BQ27XXX_REG_CTRL] = 0x00,
-		[BQ27XXX_REG_TEMP] = 0x06,
-		[BQ27XXX_REG_INT_TEMP] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_VOLT] = 0x08,
-		[BQ27XXX_REG_AI] = 0x14,
-		[BQ27XXX_REG_FLAGS] = 0x0a,
-		[BQ27XXX_REG_TTE] = 0x16,
-		[BQ27XXX_REG_TTF] = 0x18,
-		[BQ27XXX_REG_TTES] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_TTECP] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_NAC] = INVALID_REG_ADDR,
-		[BQ27XXX_REG_RC] = 0x10,
-		[BQ27XXX_REG_FCC] = 0x12,
-		[BQ27XXX_REG_CYCT] = 0x2a,
-		[BQ27XXX_REG_AE] = 0x22,
-		[BQ27XXX_REG_SOC] = 0x2c,
-		[BQ27XXX_REG_DCAP] = 0x3c,
-		[BQ27XXX_REG_AP] = 0x22,
-		BQ27XXX_DM_REG_ROWS,
-	},
+#define bq28z610_regs bq27z561_regs
 	bq34z100_regs[BQ27XXX_REG_MAX] = {
 		[BQ27XXX_REG_CTRL] = 0x00,
 		[BQ27XXX_REG_TEMP] = 0x0c,
@@ -793,67 +773,9 @@ static enum power_supply_property bq27z561_props[] = {
 	POWER_SUPPLY_PROP_MANUFACTURER,
 };
 
-static enum power_supply_property bq28z610_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_POWER_AVG,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
-static enum power_supply_property bq34z100_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_AVG,
-	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_ENERGY_NOW,
-	POWER_SUPPLY_PROP_POWER_AVG,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
-
-static enum power_supply_property bq78z100_props[] = {
-	POWER_SUPPLY_PROP_STATUS,
-	POWER_SUPPLY_PROP_PRESENT,
-	POWER_SUPPLY_PROP_VOLTAGE_NOW,
-	POWER_SUPPLY_PROP_CURRENT_NOW,
-	POWER_SUPPLY_PROP_CAPACITY,
-	POWER_SUPPLY_PROP_CAPACITY_LEVEL,
-	POWER_SUPPLY_PROP_TEMP,
-	POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
-	POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
-	POWER_SUPPLY_PROP_TECHNOLOGY,
-	POWER_SUPPLY_PROP_CHARGE_FULL,
-	POWER_SUPPLY_PROP_CHARGE_NOW,
-	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
-	POWER_SUPPLY_PROP_CYCLE_COUNT,
-	POWER_SUPPLY_PROP_POWER_AVG,
-	POWER_SUPPLY_PROP_HEALTH,
-	POWER_SUPPLY_PROP_MANUFACTURER,
-};
+#define bq28z610_props bq27z561_props
+#define bq78z100_props bq27z561_props
+#define bq34z100_props bq27000_props
 
 struct bq27xxx_dm_reg {
 	u8 subclass_id;
-- 
2.7.4

