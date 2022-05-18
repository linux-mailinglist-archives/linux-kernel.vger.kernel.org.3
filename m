Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26C152B06B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 04:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbiERCQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 22:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233364AbiERCQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 22:16:39 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2108.outbound.protection.outlook.com [40.107.255.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41BE2185
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 19:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A8ZRn+9aY+Y+cYQvl6t/aj3sU1aAp786zY1xNMsdSZJ+UIoUyfur+IJbdYK0Nuy22wVXgPaVjzYLEjqxnl9U5sR3cQX7/pkL7k6GIqqiq9N4SJMKDxk7WLo2dAVXBiyRFKypy8HifVO6jne7AEJKPfmy8voMVh5c8uU3GTLAp0UfGWBbOtYVtwVgV4yneiEV3ti9m4YuBNcdVkHY3aJrdkhU4MgdcqT1fU25ZHu/TUSgqmkGp26CNKOc7UGdyE6ldJGaSs8NTwDvILnAQIW92HTkQVC5Rd45vT64tbYaiYZ8gLe7HHLRDLA/UAX+sKPSLC7/VIImxI/Qz1r++K5b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XsE58IKnAb3BKSAYYBFxTVT6EQnXu2MJ2p534pvYh8=;
 b=M/EfYZLTlJZqW/LA0xHzXlwv7UHxZqBmAy4nPrgzT2fSMep4YLRqv2XGQpmwOxoFoK9HIuBtzStvjtwDAQLq4z3JKN+R0JSfBMhBG6/bUmKzRzEnRcEFt1cYmhPbTmcJ+JrxK9NjDtfVxYTxHRocPlCzOhXpGad6FkmiPwd0jgzuhOpD2AGrLpaoyIiWnJ+roCWDG+mr8V533eF7VJ/6I65OR7sGf7ex/9ZIEOSVGxwGd7d+LcBHdhzV97u40quf3l7yM3CXl00h7ii6jJz/xeGZwYNrIBf2TO6nsK/BunsYwn0haBfsznP66OJLrNWAm/YADWcaL//ptAc1E9v+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XsE58IKnAb3BKSAYYBFxTVT6EQnXu2MJ2p534pvYh8=;
 b=QsqPw9kxn8VMj4a6jOG0qKxSgUX9nn8FrsO4b2c0tBDeOnWli7s9mUFKlqZc8b/MaNc3TpcCOerSLzV5PffGFPFqPolYCflx4lEMPjAdG6dDbzHqbJCgSdas94xmIfDx1SVTlNhVVfiQDNMK+VC8isUPYe+Pxnu2EpF52GeQnfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4525.apcprd06.prod.outlook.com (2603:1096:400:88::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Wed, 18 May 2022 02:16:34 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::ccb7:f612:80b2:64d5%4]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 02:16:34 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        gushengxian <gushengxian@yulong.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Fix wrong kfree issue in snd_usb_endpoint_free_all
Date:   Wed, 18 May 2022 10:16:16 +0800
Message-Id: <20220518021617.10114-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0018.apcprd03.prod.outlook.com
 (2603:1096:202::28) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8912ffea-101a-4e5a-3831-08da38746d8e
X-MS-TrafficTypeDiagnostic: TYZPR06MB4525:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4525EF593C4D3455CD8DBE94ABD19@TYZPR06MB4525.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0/aRQSHs/iqgDuvzoYhbZ8188g/uDo+whKNhH2BK2EvDVMmgBJl7mOCiguR7+1ndE8xD7QVtqW0EEAX6MzZ3MahE3elOfJMxdKIG0p+5p/QryG6qLN4SZFsVa04esDpyeQoNC5VdqBP1YVroyre8ZgqH8MNuSZGu1zNJPtPRHeWdHuICrpe/8/d5Nseo6+lTSkk1CHIEo5ImuiamWI6OhPN1QcCyG5TqlNh2bAHMrW0M56TV53u3rZMxB6qOdAvpV2CebJM4C2wo3t6lS1DpMzPJH51rWZh+HjHag2xXYxksTxl701nsK/pEteHLvnTHVehGzGvps6Dj3y9NnG+Fa2d3D5NcShZzH79a9b1mMHOaDKLZDIMYei4nxnUtrMPRw7t/ZIGJWv3JYq6RmlssZilS4M6NrqmR5ta+PI8qNg9J76UGOiJb3uXoAkXeOFUKS0XgXwLwnDbPdVY6nI2ZFfrpUpwG9SQ77tAyFH7Fl9E7k2UNLa89kCe960J3wLra5oTXEju11uTDyAfVJH+4xrGrHVMuO0bLJuhQG/tGKHI8O1yZY0fhS+65k7aQ9ote1G+fg4vKAUKlZD9CBCsWonbRxOpQcOe/j7qV0BuKllbNsiGUcrjfiiuvIgbcEMOyS8d/nywyWPQ9kDGTbpuKTtg48IBSWN7btSATy/0Xe59Gum/Ec5yKAjWHEgFFzxyTK89ltBBHPXyE0n1Vbco0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(26005)(86362001)(186003)(2616005)(38100700002)(1076003)(38350700002)(4744005)(52116002)(6506007)(6512007)(66556008)(36756003)(110136005)(66946007)(316002)(83380400001)(8676002)(5660300002)(6666004)(8936002)(66476007)(508600001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o7yOdzth9hkr21/jTxAE1E9iYbiN4rphs1rPH4SBa1P8l96vLVxBemD1E8p6?=
 =?us-ascii?Q?x2eWO03EBJHSncGNZm6psQMroUgwAvp9EyiLWns6fXTWCutR0SnZMLIwBxhu?=
 =?us-ascii?Q?6kg5dCxRXIDRTjXmPCrJG0jTlF1+O75IL/NnVnzDm1t5ywt126oeTVBu/LYv?=
 =?us-ascii?Q?CE8pbrYuB1QfDulvEc+9xrjXP9nm+3gnu1rciliTpo8MQqI4wLg3QcEI9hLr?=
 =?us-ascii?Q?uKxyJKmFiKrmnRHa3a6pPulIRA3RBQDJf7SqFlt6AZqIpyR7AOumUrT5zJUd?=
 =?us-ascii?Q?+AHI8CKO0H1jTGZx8iVQtCEjYuNkIgqKw7POxtbt1DAbGgllsRXU68U/y0sU?=
 =?us-ascii?Q?nObAiQilWRpRbS9xg6Cenm/FddGnx8SenZ2bTuQ8bJZRqafvruX3yh+O/7XQ?=
 =?us-ascii?Q?gb6LtPQHC+JWdQi66SAyrRVGdmwriN9/k34nZpsh35NmhjObzvrt8LC/rWyF?=
 =?us-ascii?Q?M8Fo/qEJzxf81RIOz4O/SRu+lEb4Rz6upu+GwoNYyNpGr19J0Schqvujl1hk?=
 =?us-ascii?Q?6DOwRZlvs9nYilTBK+71zaW7NMi1WiXz4yiSnDHBSWyd/C6zbaLBoJfWsTk0?=
 =?us-ascii?Q?k+H15Wom0ao0OOleVXd2n9sAiUH8T9IAkTqWNEsYraeAOy4eYzgRee9CmW1t?=
 =?us-ascii?Q?BNic3SISqlzUSg28/BX87kJTHpNB4TteiNRJIfIF40TS43WXcpvRZfnpUVYp?=
 =?us-ascii?Q?V9U6Xp5bGPt/rSILosWNIN4StGjcLwFX1VRQeVZlEzhOhY3jQpB9HTzXUGCV?=
 =?us-ascii?Q?slcqKcyN9eoB5lYWk4gNdzmtFu/DE4zcH+y8Q3t2uqlQXfYHIewsz3/XeoZa?=
 =?us-ascii?Q?LKK62MOdKxgUt3cHpWjnfT6Y3I8mQ98KJV+CdsBEor1bow/gFSkMwENoyBrw?=
 =?us-ascii?Q?vcKylgmWsf94U/5w+yFioHM7ykyKkR/pggQyNc0ibF22BJq3qWo/33+0pPvq?=
 =?us-ascii?Q?a4kzGUgLEXnYj8dK5Gr6ocqupobQIF2HqpuPGS3on18wlsaJwWPW3EjYb676?=
 =?us-ascii?Q?YkoLV+16+dTWv4yFgheOG89D8uBcyqbZUgLnaH2H6kb+6qfDCTtRe/vsY8hx?=
 =?us-ascii?Q?DLYKN05mSuGpoxJUKIQBkWKqqQu75go9JHGRiyptmMulqxuwce8CJJ92bEC6?=
 =?us-ascii?Q?+zqyVvaz3RsnR2Tchm+oejOnQtDA6cF7mI3yjHDIfKzDwSvYQZjFuZA2UFeR?=
 =?us-ascii?Q?vobfut+eVkt767CI1PaNCdY2TL+cYCh62qZbIe5Xhw7jWvFurNV86F/rYULO?=
 =?us-ascii?Q?n2QlwjEUy9dLVo8zOMkw43R07+qMMZvnaZ8t2vOcL5vyNeDKnM1c2aW/bElk?=
 =?us-ascii?Q?qywnGDzeM4qG3zyYNaSm2U08XqyqNKy0kNosBhtewQHvhmiJTJDv1upgtsrq?=
 =?us-ascii?Q?N9i+YozcskpbfEhdmIF7fSDon/s9cETNT11XOmDxBV5eY+qu4e44euUZkC91?=
 =?us-ascii?Q?uhDSUHUkzdK8s2hEMhzJN6xJ6gtq8cwOQKDqfI7ql3Y7/R9KKvtnFqHsDwgo?=
 =?us-ascii?Q?Ke3ed5FuReZehRPtSnSn9jKNeBXK/1R/D2p0Kd/3XdeLrR5SQRRaMetn0QPk?=
 =?us-ascii?Q?xXis2VE87vWSBBNLfb0XzeWsrg/U1B2mrfPX+vEdFzJN0CG901bE8+O2X8Q7?=
 =?us-ascii?Q?ZeG6TdiVEgr6B3WxohYHyRLRF0eRTJZjriELC/oeni13HBZ81vNrcn8f7yHT?=
 =?us-ascii?Q?CsfihxTUOHMQBl6mcii5HBVlKmCklZbaYFnZ/K7+Gm6NbROkfiqE4lFsp+u2?=
 =?us-ascii?Q?KCkQJjYoOQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8912ffea-101a-4e5a-3831-08da38746d8e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 02:16:33.4401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w12OCxASwuUC8mbFGxP3vLzTUYrbI/8Za9ULUnhokb+fhP95amCa8NS/7yzRr1+F7oMIouM9K2zICD50O1YoOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4525
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck error:
./sound/usb/endpoint.c:1671:8-10: ERROR: reference preceded by free on line 1671.

Here should be 'cp' rather than 'ip'.

Fixes: c11117b634f4 ("ALSA: usb-audio: Refcount multiple accesses on the single clock")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 sound/usb/endpoint.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index df5a70013a85..f9c921683948 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -1668,7 +1668,7 @@ void snd_usb_endpoint_free_all(struct snd_usb_audio *chip)
 		kfree(ip);
 
 	list_for_each_entry_safe(cp, cn, &chip->clock_ref_list, list)
-		kfree(ip);
+		kfree(cp);
 }
 
 /*
-- 
2.36.1

