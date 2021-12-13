Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC35472608
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbhLMJst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:48:49 -0500
Received: from mail-eopbgr1300112.outbound.protection.outlook.com ([40.107.130.112]:14432
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235161AbhLMJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:44:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OpMVt4upiNcA3WsJ4E0MjIPMCd83kwJPVvw30yeZ5xN5Nyfqoje3x69FZ8E2gNDlLMaeGqexDxoUeFah3ESHwDusQtK6T6JtBmPWC8u2THavNRsOTWNKIgwOKeeVzQGj71MQ25xIAwK2Ms3cX/1o5kQNJIPLizYMWg3Q+1piRi2sKpia4YfaB6RxareHiAsh3HDoGHHI3O/BdVZq5bHDHyz7XsmotKk4Jf2T9/pcGkAqHYxmHWTPN0D/dNselsCCuskfZuTDqBUedY2HTCfoCm32VYFCd7BWitildus3iJotst/dyDdYJl1I72Snf7Wa4OW66RTzufMJvziJ4C4w+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhJrxzhf3syilMnfEqZH2jkxXJ1IpvnOgHUVEDnRurU=;
 b=WBwJOf3Me+SzKstnBHBvYwlusbw6IwO9xb0sNYKcfj4vH8O16fT9Tc4cKBnQEHWnCifu6B+lx0gnpMe/zXOp5bLXvEo9ewrsuPpemVR7Df/hIR78I5E1LIfnQL3JkSgNLB+O522uUvEceo7pZ73BzCkiOd4IBHtto21IJIuIpaHJLnYsyLedXlAXKFhxLdXK9AlHOAiUCHPvt0IG7oly9gxUvVYcoVlW+iy4/QAA9IX3HCUTrGXnCtxXU1HBbmroziK7no8JF8inLp3WPktxkuKtb2bSRkLMLtNk9fngiRR+ZrV5e+SfXJtND3aQqgmf0LbEoqHDairAwXWJIgBAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhJrxzhf3syilMnfEqZH2jkxXJ1IpvnOgHUVEDnRurU=;
 b=VX5/ZXXQ8HEDN+kORYRYKmlhrJEn7uHhqSIPywLrtEe6FKIMJCE8DE684dFm5jqdA10Gkk7uv0j2JAr5Et5G4lFuIrSudv+yNljpcuivv0TLQu9WKQcNW1T1P6HG+RX3yzGfIW1E9kcNxQXR1PWhI+vfpsARTeWWwsLX6ef0OrA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:43:42 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:43:42 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] bus: arm-cci: add missing of_node_put before break
Date:   Mon, 13 Dec 2021 01:43:29 -0800
Message-Id: <1639388609-63796-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR01CA0070.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::34) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b732578-be4a-4e2d-f003-08d9be1d0c7e
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB30500C162AB537C2A3AD9101BD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8scA9ZC/Uglv0JAVaCPOM8Uly7Gthn0zxR3uOH3uKN1bGskDp8bV+QIKsG4Nw0Zj0Hpw4WpVIiu3Cs9W1mqs1E2WhQ374pXPJl2XAlme/GP2DMdXG7MXtrRG+CFVnsTbYhqbxzsuOZaF98bNeNyk7GD2eWC9vG/K4/wbS+IaOvtElGoGdZeT5oqQJRBq3UO/03G3dfB9xFlUtdO/sVD52FAaTV2jOgCUUng9HatWL1OxKYu9AugIQSdbAVbJgLU4sv3mwsBOWNkMFsaxtsRWxRZW+6sZisiZp7/xfpKsYXC6ZcRpBxiWeaumLRU5BpvF0E9I+zV2RPebloQgGx/WBtoVmSIlTmbnnI8RRqVyn8xExZmuT9Ulxs+SosLqtPaILkUF2mQexxrt4+EtSVxurbSfwRWMwFSKKBUoJ4xehmd/VjsdNitEgZv4jaAp5lg0TfVXcsHjODk/Fo+52EX10ywOQHsPiUA65t40OQHGEMGM+CYszufhc0PCFQNbhH/AH+KFmXmFA2xWJgg6eYS31x+88UoQkGXGo7Wqf452M0yrI4PkIIOU7ehHWlduAkZN+DeiT0p6Kf7y79mcgon0cX4RIkDEpZUVkW0tRLMyg0pUsT25VJfaxDid/6qVA8xO3swaVTrlYE28N8N9c0KOX2SzH8mLQBVJDzex6l4r7mT6KRn2GVxpyRryt7k4u7XFMBLpbXlD24rxnz0Zz0RLsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(2906002)(316002)(508600001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(6916009)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gr3KAF8SldQ2gHVFFVPxZtsshnIyk6xtrg3m8YN0W/eRrvgummntMfh5Cwch?=
 =?us-ascii?Q?0LyCZziXN4epHxMekvGM2I/UM/Jwhvx1T8azetulOFfo5q/fchOXPgO9ugWo?=
 =?us-ascii?Q?nuDSWzZqCmxrDfx1leOiVNp6nH3FpjJDSs6Ttn2C/qwjKaCDplXIWF1uG+Wo?=
 =?us-ascii?Q?xPyJdjcxx52+a2QKWU3Y0wEDV7bm4FNdRjPOUTmoSQ0k/X6VIxFzOuoKGPfq?=
 =?us-ascii?Q?Husojhe2vJ2Qu96Pkix4AqX2z8ltYV2bewRgElA7PtqjtI2hzN959QpxU4F+?=
 =?us-ascii?Q?wVN2bFh39GAZ0i50X60N0lYnIPwB1SrkLw+e+5KF8+Qg8agtHQuctQB9FW/a?=
 =?us-ascii?Q?YlLLhIV8I2cFirmVeVTUTrgfsEHg4RJ0y2lsDGIdZUXHsjHcaUy7uSQzap7n?=
 =?us-ascii?Q?pUYa0tl0bozZWAYl1HnyogxKAaPKOlfKYrDGKvNiWuBg7LPNRVjMv48oay+s?=
 =?us-ascii?Q?t7YYn6oZCn+k0Uj+ngbV7aoo1F1VZ05yJrfyKObffjrJag1iE8JYL/m0bA2L?=
 =?us-ascii?Q?O0lUBiGNj97zsgP7AeUp8n8iU7q/AS28n8NVMVITq4fGti4tr0ktCoJuq8f3?=
 =?us-ascii?Q?fkZjkeoBYBV7h1EuqUPiHDYO/q73b0aExY9w0bc65e1QLovdKDH+8nJNH4L9?=
 =?us-ascii?Q?WDurk15iKiFyEwaPCBetZe9AQxZSZBsgfpZIPF21vnMJJeVFB9EJNBLUzVzh?=
 =?us-ascii?Q?VBSC1aYL1SDtnz9A8LTVe43nRyUPrCqShobcX0uP6QJ8O1dDzE6+uCt2tnCH?=
 =?us-ascii?Q?sZ5f2ljFW9wAXR97qsy9rd+qYHpK5KUFNaOGHWulu/623aL6ceo80AmHejtR?=
 =?us-ascii?Q?31nkOf83SrUkLDWZ52GndQ9IqLTrfHXO2DMIV0PhNZdG9Zeft/aIfefEh6rE?=
 =?us-ascii?Q?HRwWe8q9JCM4hrjIBuo7fySAP5SzYO4OaeEW/S2Jou6d/0RzUn0b7n0gKW5L?=
 =?us-ascii?Q?olujipowGEwDEbnaoa8b7s0UuvW9Yisam3pgO+jDur978DdfICuwD5zadQ4a?=
 =?us-ascii?Q?s35wvEPREKc9gEFa+rsMJnTpdmlIcfxY+4mAj9IPJ1sIRkR6Kk0DZZgn1T6d?=
 =?us-ascii?Q?pFONGNkgX3GIioMh2QK/FDquQbuZ3xxRCLbukQx/KiY1G8iNwYBRQMlCgoVg?=
 =?us-ascii?Q?yGw3TvBBE3ykbUUwM1ZNTykGxRO5klzei4GWfUfeL+559NJ/aydz9B2B1ukN?=
 =?us-ascii?Q?GnwRQAoHWckAtpc5rh+m6MzEpiec+jPPWNw9Wu7svWhw3dm2BTtPE00GFMHj?=
 =?us-ascii?Q?mJKEaB4XqnRpHR+MgMmK4+zQSWd8p/ZZaCBRdEFEk/O0ykEf52CN77R4iZJq?=
 =?us-ascii?Q?4KqA5PPbX25ywn2/RA4M217h0LBIfmJXyoP8Kc2rDv22sU5C0Rxgy2DqvD4a?=
 =?us-ascii?Q?EKmUM28nbQaR8e114TLEU5qZibVa6W9qKxZlSAsVThvlFKjITMqSaVz+C8wj?=
 =?us-ascii?Q?lEA8K/HdbVEY9OFgt38+mVOpRhm+Mu76kUMysJEpln8jfUMRdderxP7w8KQC?=
 =?us-ascii?Q?W/r/7y5DHsWhxIme0p0kFwV+Ndofe1xHlk4y4rVENHysaJ6G5ZxKS4a1lR/3?=
 =?us-ascii?Q?XjSOlukqyWVMYpCz2t+yBlNdlLeaUNcwNbOfinI1oFHec77yzLAMJfBah6Qo?=
 =?us-ascii?Q?DMTV9QAOBpIZdwe8PQpkm0E=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b732578-be4a-4e2d-f003-08d9be1d0c7e
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:43:42.4319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGC5hX1gRwj/l+9ankIMfKcrd8xtAc5SJ9nAU4oYMfheN4A12HwR+9WR7bq0KtktS/O/MQXL4nveSGp1NT5Yew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_available_child_of_node" 
should have of_node_put() before return.

Early exits from for_each_available_child_of_node should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/bus/arm-cci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
index b8184a903..1f84a55
--- a/drivers/bus/arm-cci.c
+++ b/drivers/bus/arm-cci.c
@@ -461,8 +461,10 @@ static int cci_probe_ports(struct device_node *np)
 
 		i = nb_ace + nb_ace_lite;
 
-		if (i >= nb_cci_ports)
+		if (i >= nb_cci_ports) {
+			of_node_put(cp);
 			break;
+		}
 
 		if (of_property_read_string(cp, "interface-type",
 					&match_str)) {
-- 
2.7.4

