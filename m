Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E674474242
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbhLNMSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:18:48 -0500
Received: from mail-psaapc01on2134.outbound.protection.outlook.com ([40.107.255.134]:9441
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230161AbhLNMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:18:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGGhUlWxtMMIzaPSfvgkdU5MdPri0OVsxq/i6wtt/XZ4fno0muyV/LnL9+BMa0h06/cGOrjI6CU7D2B3NfiCgEaJqwb2Pv5zHPiwCWXPLN4WdX0QEudSOdLcpJjLUiubxlMrclfEaC8n3Y71N8uF/kFDO2EWb1W4VWoR8iVuuyTc72XXO3ItjYjpEfpvkhUFEruc1aify1jETlRILgkeMPAZ51FUWdUcoSCeqZei2ohqX1XkL4AQF95j/Pq4tcWLYOXESOBdDiK7NSysVX056uRMKGxxu12g62imoczVNfVUCpupx0zQgoQYI7fis67qcOdQarymOg4pBkyXRundKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/dtwqoNh+P29E92uAfW48l4L9CjNCK1PwKMoiKW5EM=;
 b=KlqhLmkdnHwiOLjkNnX8r7lWUAyWMrnHHJ8RhnQJ+PfGyRmw3ElQtt6EAsbJ8diJ+cCOqM62FF3aF9BNEDx0lbIX/icFKp5Obrk4y8LKq+BqSIWyWTcbpWoCD73YOnlW3FNujwyGfFxdHKIR3Z3B1LIycl1dre9guW5OvplhKOFv5K4tUVOW23pj3rmQ+5e5un34cFgvn6+7xESeMmeG9DzVtRcfW6GyoYAuTsofCvCa6EY+/KWT3b9kUibCEyHRh/uYLusKIptft1oKt9nEQcV0M9NVpnp6EC4bt+U8+ahozcWXlBLUUwtXtLZapNlmzzRBlpA8hyycTLKra3L0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/dtwqoNh+P29E92uAfW48l4L9CjNCK1PwKMoiKW5EM=;
 b=eF0U447RsUzO9hyGLvjni53V4d9lRWzCHI36wWOcCf+RiZGqGAZCwAtivuAgyInaZjeOv76PZeLYcO5HSAsGdAQlq7YbR1dLAGfkxxee6ZO/lzZLem/JXzUmJDRPxrLzTii5H6B0Yc9UazBSU4OTm1kQAesLHw/S3/p44SKzFk8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3003.apcprd06.prod.outlook.com (2603:1096:100:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.25; Tue, 14 Dec
 2021 12:18:45 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4778.018; Tue, 14 Dec 2021
 12:18:45 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] platform: x86: use resource_size() with res
Date:   Tue, 14 Dec 2021 04:18:36 -0800
Message-Id: <1639484316-75873-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0022.apcprd03.prod.outlook.com
 (2603:1096:202::32) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7fe2395a-3ca5-420c-7c94-08d9befbdff4
X-MS-TrafficTypeDiagnostic: SL2PR06MB3003:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB300391D41FFB66C2F9D57E54BD759@SL2PR06MB3003.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:128;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/1NQJK2pcG/+whHr9aNBQI7dZbWr9aEw0df0oKJJlfqWZVRVqIvbp5Gp4LfYr/VQXQvpD8p5z7WYty4+tchxdiCkWb2YiKM0B3enEan6eKsmUjh91LCumw7NToTpIes+ybx9Pa9YhsLRAbgQPZbWexmMcqnBmk429T+dxzGSvVYMT1OwEANgUmR30x0r3xELv5JJiqDUrHqJu+z+T2/QZbzPhNjCYGkbMPVB43QRPJuHBKtmBrbIZ5Qc3r4PHm6Eu0zpwAVBy1IX99LLBealN6cKXH6vanJ39+wbs3sKu1T3BRjoau4PgW2dLC8Ej8486npXnbADRqXLKtOyZeQPaPVkqw9TqmnTtiXLPQat15hbB6ubX99aeOBncXaET7U9r2l/KXI1qnOgf+TPDe3zRIz9KWo1OmJaRSP7gLfyp8sS3EVLSY/FqrKRUpeN+lLKiuXJBcgaXb83FqG53N++ZAwbWqOvAMv2AA+IazklZKR3+MqQqMY8izmimeHzsWJ+v+XHyMWElo+jvtUUZvl2Cq/HPX2v5m/OfgpgWPcpkWhfCCybMJ6uYbMAFh3r9ANJ7pvNIIVklp4h1jYSNKXCeiCliOVxIsrTP7TmOTutJNegLIcUHiGxwjvDxCqEu9JkcUqxu/K1/tXtXlVN+/LvtjpdpZDtq4bP77IjbgH+wRXSSJIOhjYeK9BW70NBdu82xPBm1mABixESN5E5hT/IQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(186003)(6506007)(83380400001)(6666004)(66946007)(6486002)(2616005)(4744005)(66556008)(66476007)(316002)(110136005)(8676002)(86362001)(5660300002)(8936002)(508600001)(6512007)(4326008)(2906002)(36756003)(52116002)(26005)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sObEP8xqZjwfZs1YHgAHcY35g9K1Q6X4htxke0by34dzHZWv7iVo0KE0RqXy?=
 =?us-ascii?Q?B9KoH6aVfLweSIA/3wSHOBohNQW11v1py6TBCzaVLVFbyIM9bS2vQ9X2LAxp?=
 =?us-ascii?Q?X4quWAHeJVaX+BqR5cY3V1yUwq9KtHocw7tfpJYBVZWpkCptccgEd0/doa4v?=
 =?us-ascii?Q?zKvF3O0Zx2nV2+DY4uxj17ndqJTcrZZjytZizs8FUHJdIovYyWbmtbJKjvwj?=
 =?us-ascii?Q?6PoC274UKM17VfEtaMisGfqfeOTprZiSy0+qNs8LeIzpdTzzFOtgyqedlda5?=
 =?us-ascii?Q?pOYZrOARyJjvhvCGxwD2e7Tez2hOe1fMGqg+T80CMb/QcDOOcDLklumxehV8?=
 =?us-ascii?Q?W5NqFMogaSRG0tPf9DurUgmgRvPw71V/WSrX1aESanJDM9+ONjvi5cff4Jv/?=
 =?us-ascii?Q?Q79s4vjKCHnG7wSTwjdEBgo0r5XhnVpKNLXcjQHC9W/aY9Vl/yZxpeHOVItA?=
 =?us-ascii?Q?S2ipKUYHHnuu7enLRuvHpIxLTWkFF3TWd5akxnus/VUFU76eUyElr93BBEtZ?=
 =?us-ascii?Q?rghbA+Jm/b4XGjnzlEx49X45Xyfs6TL5grItAt4GLahHKfKO5QbCkVj34YfB?=
 =?us-ascii?Q?PzdG0YPniP1G/1QpXOoElb8YJWiZsdnCAxCoQ+nzCZu+FA+7USB+Q2RPkEvm?=
 =?us-ascii?Q?mZ5QkONcciJNAp/XRY5lhAHXCvLHZdDiEf3ZNJc+PCMFbyAy+lgsYQgdOGrR?=
 =?us-ascii?Q?S7zWvvWqUfnFTAfhZ16I3pZ9Tf41TSD87Dx9YGFUN4/T0f17WVOxryuLrUK9?=
 =?us-ascii?Q?lZEsydGzhnyEUXLHNcQ60L1OtGL1JbBpOCOzGzBEnJd0M6oF3XKpJUva9V5k?=
 =?us-ascii?Q?nyUWJ0TmCUhdHcX9YxjujhHFN/otBUpPIOPxpyRm2+C7vsHn24n/uaXtgy51?=
 =?us-ascii?Q?SDayukXq7GhMZ9IVZWazpiYwgJJIYw6jALlon34TEx/5IkKuJtZ8+NpXqWLo?=
 =?us-ascii?Q?oaKakeBZ7WF4Od/fbWY0g8drBv01Afrqp1Fn/eYSpMEMjc7ve9gGRRE4T6Vp?=
 =?us-ascii?Q?UPZXpNA0WfazhJM+gzEod1sUO8oemD3w8uqyyGWXxOK1l/muice6gkprLRY1?=
 =?us-ascii?Q?fj2X+srTNxgxNJvSctqQ8rUPdD29180BzbiKM6EcnOGObVLi2Iiz2UvyZsfH?=
 =?us-ascii?Q?X6fGtX7j6OIDSUk7k7QCavEz62wUrz/P1HtoMIR7rlB133CmvD8ORBg5YTp6?=
 =?us-ascii?Q?E7rV89o7oyAIq5K/J5dca97u17Dl8896lIV5AdYIEKE9FlwDg5FPSlzvjMpY?=
 =?us-ascii?Q?bqC5P2oHk9/cEVPcNsAdq7CMc9lpbZzMl1kzlZmnE5prqZzFT5+xDKstktid?=
 =?us-ascii?Q?LrgcPvzIxVt6w38olGKE/zCv8OwX2v2/3vmW2E7jOzqZ9T+TXEpbrW5/CBUh?=
 =?us-ascii?Q?NGHu4U1AlRR2dWMuFKr/EvfUq+xfJukLOh+OTmerOO6kxj8HzQug5SP814u+?=
 =?us-ascii?Q?iv4njVpZ6ZLsumpvzV6Q77j0nLxG3hoaEErowLIL5Pv7+GMwDohk0WjbbRWR?=
 =?us-ascii?Q?1eMlr9R4vWOr8tNATTmTxxqzecsGAnpPiNK+VE7jU+9p87baCWWr4yOvYK88?=
 =?us-ascii?Q?8/fZyh7uJKWcajL4U0MhZZXPolUDup/5mmeHn7I0GU1JGW5pf4JkItHSD2od?=
 =?us-ascii?Q?vt1c75x9Wk61i/MPCOCb5w8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe2395a-3ca5-420c-7c94-08d9befbdff4
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 12:18:45.5045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zjMY8hzOEdZErelxtFJGTzsm4BWj1F7XbmyIwwyoIOCFOJf0AV3pA0eCX7wpsCVrU3BDUmn77P6f+BxKItQQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3003
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

This should be (res->end - res->start + 1) here actually,
use resource_size() derectly.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/platform/x86/apple-gmux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 9aae45a..57553f9
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -625,7 +625,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
 	}
 
 	gmux_data->iostart = res->start;
-	gmux_data->iolen = res->end - res->start;
+	gmux_data->iolen = resource_size(res);
 
 	if (gmux_data->iolen < GMUX_MIN_IO_LEN) {
 		pr_err("gmux I/O region too small (%lu < %u)\n",
-- 
2.7.4

