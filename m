Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B95A47266E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbhLMJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:51:55 -0500
Received: from mail-eopbgr1300115.outbound.protection.outlook.com ([40.107.130.115]:11520
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234859AbhLMJny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:43:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WNUeTjfeAMGewPZteoTkP7aTOnxFsg/4IlhSI0wYy+h8RgmtkI1ZFTcwuac8PhsGqOAohcFBFciaNBN/uBkosEFToMA9XvLd4OjIgee7NUc8XQffVopJDaGR2gG2qAbx+Hv0KRp6Qyt4svx1rM82UyH0FHyZBXi9FknfhjXIm6u/I0k9lnacfcEHj1XSN+E0WPLQKtCL/sfcHoO3Y1buyym9t6bJ0OIfzvsg1+l3GS6dFriJZgePZLeoMweUCGbjoZugY79Sq8EhVXQIMkz44CGV/vSvttAxyUn2+RqKKlff2O6fbtGCn4v+BKY4kXSwV9/3KKqsPgRZouL8cZSCsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MC8FyeD3iQoWhoUru8gZdJjdRC1HLcu2KHv7VaqJ8w=;
 b=djKn2HjjGSozIrYSwxnX7moO8OQDawXIL9+x1+2FXNeUOFfGW/BtfAb8vUuTNEZimEu/v0sZqd3y7SEfD/7I3dFvcEZvBfgNl0dCsy8blDiycbOpCMzRf8OserreVThJgSlSyWkilDidQeUbG/qLhtrL1g4MQw229XOyHPvoYaOW0XjF/f29PomkbkQB9wfqWiQNNrF3c71tS9z6QkWREI4lVCsbN3PdBP3xHOaaUiYCeCfXnI+/9iQG5OBpdAKd8irL6yx98rdt19r6AVQjRHXO846l1NpgTBQSK81SV6N9D/x6qGeqrXRrmHahzxHnjYxFgFDnvsyseLtcnsAABw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MC8FyeD3iQoWhoUru8gZdJjdRC1HLcu2KHv7VaqJ8w=;
 b=e5NtZ3oULml5j9XnEIBbbmL9gb84lUBgRHRZOwz+x54vK+lO9GBKzlhsvUiJIimpru66RtUm0I4FNjpMfwymqxQOCRyWuiyh9Hv09iDJnCYFyq0daT1WM4CGnKV2t6ggFC5z3Xeb74UkIIMAh94ZppP4Zv2OS712GyO1+roCdiA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3050.apcprd06.prod.outlook.com (2603:1096:100:39::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.16; Mon, 13 Dec
 2021 09:43:19 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.017; Mon, 13 Dec 2021
 09:43:18 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] arch: sparc: add missing of_node_put before return
Date:   Mon, 13 Dec 2021 01:43:06 -0800
Message-Id: <1639388586-63750-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0145.apcprd02.prod.outlook.com
 (2603:1096:202:16::29) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb01015-5292-429d-f26b-08d9be1cfe70
X-MS-TrafficTypeDiagnostic: SL2PR06MB3050:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3050598A08274C3A8C33D608BD749@SL2PR06MB3050.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hj/QjeZvlfCzt0LQRUq9PvJHicXDLCCLbET6PZ1da7cP4XywKaqVpu5kvES4xJf7fkfDWbpqLYficn1tgcUBRviGBAKKnlrgxQTr6ca9n6RjI6WQGFG9Fd04r/b831Xl0rN+jhdeTxZofZGOMbuYnvQd4AcRsOf6pSRQ5hLg+2AZYCjxnNF7HB0ySL1Pce2b4/aniwghdkf1PXYMjooJdQMUiL8P3N9x1SoNlUQZCQ00zVKMNBY7j8XbnaihaFkceYy5XYg8eysZcf4xaPbRarDMPTQr4ldpuZmG1odqA3P7cZBru4BViODcNA+GuqrI+9nlFq4zwVjVbmFlkduePwociEJW03LXwsmpaFjyKF1xs9bIJ/I+opf4eYR35dHMyXg1ZHYeq+GQh5ySpugNM2mV/KfiaSs4DaBS4g5VnYea3PvAba5RuYmNWV+zj5E6Um/fsbPY5qEf6/sTjdVEjm0y0vHiDHDjlv7G2pyzkajVpjjPqIRkxM6h/QHrPL6o21Q4yCL7tTdlfZZafDcgur7tTDsXrpawaEziUYkBPa0NKIzgxWP6QjASxylm+m8HR7T9cqVyGX1fjTxtZ2IEaouBVk67Ceov0Yjo83+zhfrXCBzD3DTWir3opbnmADO5295cAIbeRlR1I00ifCB/gjYmGMjRoKe9vsIBTcPXwb4S+r+h2aclm5VDGGRhNXUiTVIdQnUPpkQZcwvj0JQLZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(83380400001)(52116002)(6506007)(2906002)(316002)(508600001)(26005)(186003)(66946007)(36756003)(107886003)(66476007)(2616005)(66556008)(8936002)(6512007)(8676002)(4326008)(5660300002)(6486002)(38100700002)(4744005)(38350700002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7w2J7QA7ABKDpR9nWlBUotvFfEX6Y6G0D9j65e7nY+YxD8kMOdomDMsKmeLT?=
 =?us-ascii?Q?sP6U8Thntt2F5OtJidNjJfzGaFxDrCZY1vQK9iLbH8r8rmVNM87qjo2UYWlr?=
 =?us-ascii?Q?sg3J/us/+bzJjPTRbzheSVbdcPKpkCs3OFxIzdaDMvL58YpObrb28Cwnaebv?=
 =?us-ascii?Q?0of6LxOqhtYfqv/rRlvpBcdCYloOmCWrrC998ZH1WkG3EJCfPN+LKDZt07cT?=
 =?us-ascii?Q?2MaFe+sYseRK5pubalgv/AkgOIGH16CSH5L6QdBcMZXtAvzq4JBIsvnmmbrf?=
 =?us-ascii?Q?PR+XX9ALRod7gN8RqUiz3HqqIkSXrzATFFyVeSHdoSx4iOweOHuluiF5NaC0?=
 =?us-ascii?Q?kY0waAuamoOWUJlYNc1LI7Xz78J3HExBzIRVMlxCJSwKOu2qGuzWEoFBgEz7?=
 =?us-ascii?Q?9xtX9ZNHYUQrp8XYNGlIx3FWxzdIfSaLjHrKGbqd585NS6Uu5RRLzzn6ERse?=
 =?us-ascii?Q?fzhp5bOV0ITE/FtqA1h0dBeE+biTyoWCMvoloNZEaTASuKNDH9McQPfU9aFH?=
 =?us-ascii?Q?C8nzr+9CK7mz3/AZyNbHKLZXWrzUD5rtOXVjjSPl1fgp860PKoTOxUPcpn7H?=
 =?us-ascii?Q?5CE3fbm53ZXh0WSwbF9o5pNZyS89lTae9/3MKGCoOwjnluNwOzOCg2ZKvXsx?=
 =?us-ascii?Q?z4iduRDbDtWfP28uoBvCjqMU94xS+vBnZZCd2vaZyUmCAUI0ayO4hrIN+wbv?=
 =?us-ascii?Q?ET/sVxp9mrFEm/wU/h9Qu8xQ7/m3kA7BhHxZO2D+8io9KKRVa8KkICESzSXq?=
 =?us-ascii?Q?f4E4aFgvcrJ9E2O2qCd2b/24BMHzOMMV++qyvKSQksyYMaNL0GlBnAJxk6pV?=
 =?us-ascii?Q?kQ1XyrEpRHiSZ7Txjm95146iGzSCYuCblS17/VVyPCGDaSWcFl3fM21Q68tb?=
 =?us-ascii?Q?zHxNinuFvaqV994cgpUMZNKcPtQgGLHk/JhtBzCPU1sIciSHHyWei3lY4Uly?=
 =?us-ascii?Q?F2Ys5u0J2ZDHAL7B1uP1gu7ATcVGVOfZjxylFptCuGlnIBVXQWfz2EVC/Qak?=
 =?us-ascii?Q?Y4hFVCqJnTjYaOvjdHWlRPPGdpGzOBYGGiWi5tMLzHQ6CU5XRs3cuJeT+vNj?=
 =?us-ascii?Q?IbqpgwgelJ0nvnrhC4Go9/UdKTOrSf2+VLeXgfpGh0qHrQuY75Lw5G9X2P+3?=
 =?us-ascii?Q?dYePDKr2IkesR2gEz7gnrvI2LFck9NJzkQ4kEE3lnLxlqQcabuW53Gan4Ciw?=
 =?us-ascii?Q?5BcAmoHlT0Zxwu2r5rWNgJdfVNtAjUa7Jy5Qe/QhOUkiKucKTgNVkwdxrp9g?=
 =?us-ascii?Q?wknF7TiUKEjMM1DAVQvDj6q5DY0kb8vflNji25s97934+DObS1AuWp0HivBg?=
 =?us-ascii?Q?1TnLZKVOtqglDd4IaTTufCffOP103ch+1lPEfBdB0EFIFzgahr22x9ghX1/O?=
 =?us-ascii?Q?EM40QqXOx/ZRnvnZQ5PXqWbA6jcaOXGrbACSxcvSnDFDNx33glWP+hWFy4mT?=
 =?us-ascii?Q?cIPNRRRl4+9yZJDLJybQ4PLxD03yMAawCcHET4OAzVye3IWRu1tU59+chn1G?=
 =?us-ascii?Q?4Fh/xzwLCeLRlRXXezVXSAbYPpTwjUkNDiU3ZCQKXKngOFuwPdEUsXbMyZeL?=
 =?us-ascii?Q?klGOQ3KV2lgvVhGYJuhv0z8YVXkQzZyq4kDvClxrBRm0xkUWmYt1GIRcqefO?=
 =?us-ascii?Q?lpbaejETRLNQ78qPexhu8AM=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb01015-5292-429d-f26b-08d9be1cfe70
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 09:43:18.8381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACkDbzZoH+Puy2amEW/6cTFFJYlCo3tOWmNWyyzsPbOhJ7tEC7rADYrbpkdvBS6RCLHb1p1DavXxdUwDdVBf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

Fix following coccicheck warning:
WARNING: Function "for_each_node_by_type" 
should have of_node_put() before return.

Early exits from for_each_node_by_type should decrement the
node reference counter.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/sparc/kernel/prom_64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index f883a50..ed3e987
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -460,8 +460,10 @@ static void *of_iterate_over_cpus(void *(*func)(struct device_node *, int, int),
 		}
 #endif
 		ret = func(dp, cpuid, arg);
-		if (ret)
+		if (ret) {
+			of_node_put(dp);
 			return ret;
+		}
 	}
 	return NULL;
 }
-- 
2.7.4

