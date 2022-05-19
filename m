Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBA052CC43
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 08:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234478AbiESGxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 02:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiESGxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 02:53:48 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C58B82CB;
        Wed, 18 May 2022 23:53:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq1UKNOxUxOQMmjeB+t2nA7HAnmvOwA0m82cr8FJlkrOAqxXTuh6TpbW6mwtNCE0Ctz/LHPMOxWN+2WaX/YB0sgr8oRsJra92RA36nFevwv2x8K2miGdfkp56yANKyTmYEof3LdTQdH6waOd+gEJxdqixthcBNcVXr9ajfjo9vXvySNVsQywp4pk8T9P7fjmsj+5POtXJOxDnmxW8THPSq+pr7A3mcTyggJA8h2mYYih7LbTH+LZu/Ej7Yk4xpgXr6ON9faAtthtma9eU+Zm6TCcTztvkRh2cD88FaZ4WEHC9VoJfCMcS6uHDzqlzKGVUzbURPFiXqFH7ZrkgAE3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBBDKg3sxToMFD6u2Ohw8dKcHPnGzFG3dkXR3dBHfxU=;
 b=kIySWHtcaCcH+Wav1G9pYtQ08rTRs9UV5CsS4FLIJp/UvNx7JagnmSuneUNOPnA+qCrXnccu0NIuwQ6KjPl+5KZS1Hb/iG64rlOTroSU3gB92twUib7gk/jtQcv9+3ZzE0C8KhOgyGxy2p179KUjjwQCUuZA975Kz8eckM1jDvhPqpvLtn6WyG4egpyPhAZFOPuXHrqS7oWMh6bcMIdPgqrc6LfCPyOTiRSDjh4QLYrhbgvd/a2yTSNAdFvZ6jgUPvZBDNdetgNRTVPjkZD1QfO9bEcT7zGWJc993M1DbXK87Yia+M/fzWcXd4uwYamJdE0FUDVE8Zt+ovqY3UyN2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBBDKg3sxToMFD6u2Ohw8dKcHPnGzFG3dkXR3dBHfxU=;
 b=ip617xlGAJVpLfrs74C+1rKQ8PZ/MLa1G4+CbX3Dn0kiKA3D8RwLkW/Qv0ZeOhaZo6b6gCSTlKU4moqlYZVvJm6xOlCu72nwW/BF7PJGE8KzVKK5Yr6LaortKYtEk7K4OIgGAb1gRGVBvVhCt2wunY98VnZX5/3c0Qi/RkBWP5A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TYZPR06MB3966.apcprd06.prod.outlook.com (2603:1096:400:22::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Thu, 19 May
 2022 06:53:44 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5273.016; Thu, 19 May 2022
 06:53:43 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Eugen Hristev <eugen.hristev@microchip.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-media@vger.kernel.org (open list:MICROCHIP ISC DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip
        (AT91) SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] media: atmel: atmel-isc: remove unneeded IS_ERR()
Date:   Thu, 19 May 2022 14:52:33 +0800
Message-Id: <20220519065234.127978-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR06CA0016.apcprd06.prod.outlook.com
 (2603:1096:202:2e::28) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e166f79-79c5-4e6a-bf18-08da39644fd4
X-MS-TrafficTypeDiagnostic: TYZPR06MB3966:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB396664E652E6E389A1C75F3CC7D09@TYZPR06MB3966.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F98S2/2HQkSyeAuO0MWZMzXoQxeo4qE1gsXW3e3Dp9jqdLG4yOxzFcabov/ITwk/gsxkQhMDr6UZcxl9yeXUI+pSyu13rpe1ErxMCGUCyERCAUoriqhCpcdeANfM1dBUhIc4CvxmgFJsgSrrLvQOKXYxfcBpGzPY6Jb/GztqSkvKSBXYQ3pzoP6fDfGf9ql3Ia0Nb/D8w1y1lKbMZmeaeNLC8b80JWKACasV75Tj3saDDqovcHnSzmxnMe9egr/zKcBLrKKgZHiTvL4XxXIILW+pfLhwhltN6O9k405XJqK/EaZ4GTzi7M1vYU+dTSk7l2XlBiqDbsP/py0BB69GvizOxbrEcUiPahE5V5tejiZkAdfzhsQPCx2tRFkiXV+oE7pNkyR442TFtbCwEABmMSMIDapVSSXwS+q5JMStBKHvx7jpeqBA9DGFYFMpwII/GCgZyJCK4GsJcBiGKysMeVbJz0tcEu9LWS0t5qgzJAk5yHwxd2n1jzkSGXXxIF0T8o+e2a/jyzTVJucN/5GcjTpgm4+Ul8KlSRNTWYx7gDH/gSMYnMckI5DFcHmQbdzmavSdUwx4i1FHDHisNHBAKSRfpZEH+OfbyN6TyQ31tn9xvwWzZwWcCnZLKXFSD9ahwphZoZxl4dh/HG1Zo3C3YkXHgvYk8LuEfnCSBfoEbTg0uaUBjPc3cYY5iJPPbcPj3Ex7C7gewk39vdTdCHQujw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(107886003)(38350700002)(186003)(83380400001)(1076003)(86362001)(4326008)(316002)(6486002)(66476007)(66556008)(66946007)(508600001)(8936002)(8676002)(6666004)(4744005)(6506007)(38100700002)(36756003)(2616005)(52116002)(6512007)(26005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NfLax/4b98LpVMsvbErVtrHtRMvndIQKW9fObAe7D8Q+r3r3hRusExEaIpLP?=
 =?us-ascii?Q?7WnzxvyAgJ0LLc2dm0V0EqEql9kmvaKm5W7M0x9xVxHgdGllcGxkyD1hnApT?=
 =?us-ascii?Q?lmqttT+4P+0OhujNClJjpD+KwdWqReqhXZyibFQUzHBZk2bkYXeCgl1xg/kd?=
 =?us-ascii?Q?P/E5VVbPkqybN+THmkoO29ai0QHxoemiU5rxEqkiRo87IShA6vj7RDMwLUjd?=
 =?us-ascii?Q?cOuZz4HoFqQ/BJljw1CNkOqbHLki8QsReEaNwQqKgpFugXC7hmEPctKnj9vs?=
 =?us-ascii?Q?u+6TzOMejo+BZU7adL6SY2DT2oNIX+dONrQmGhU7tBCe1WYdaJs0sj8b/X4J?=
 =?us-ascii?Q?DxSVqQzoYJEFtZRQ8ekSUHMuBqKQY5QJ+CUE5xD9Tvu52IrOwxtqAk7s18qQ?=
 =?us-ascii?Q?ZQpRMIXTp5uw8ibr1sC6nXDUQHENX7elcd5SjFrooWkydgzpyaUUED3C8Sw6?=
 =?us-ascii?Q?TtR2r/ZdM03jxuy2MFxvBAQh28iO4JUISOVe3xZbJ6qKOhrBSdd49l3/ug0c?=
 =?us-ascii?Q?ruPoMYGO8t9ktyfvbeuASS7dzRLcJ0KQLvgai55RWcoohC8sHLALxsmHBTO+?=
 =?us-ascii?Q?OojlHwSxrsyehT3wFQFgRATe3eceSlGouDI362ZjLWXgvMLTSzOCh2/p6Xx5?=
 =?us-ascii?Q?FPddsoD9s8NgPXAdWV/8LFGio9syH3n1eachYL63n6DVQyJUlJIm01j3N3qm?=
 =?us-ascii?Q?YSU7WdSAJTERaiCv0eDp5kmxI1zaM2jeS4h+agDi4vyOl+i53U9ZsgjzmjAp?=
 =?us-ascii?Q?KnRIf2ehBCxnRhTOHxK0BuLEdlHxhbtSUWL/zML5f0a2YhWs6cvkKeYDumdP?=
 =?us-ascii?Q?kFJl9Jc7uVgijfBN9ODDX5oqXTm2h7oES+O5HpWP3hkxU81SH1T73p//dUPb?=
 =?us-ascii?Q?g+ohOLQKpF/ITm3lhoFvy2EKirLOCG652dm/3UQJECqrfmdxzMf7Un8IFn0O?=
 =?us-ascii?Q?x1GBEjVsR/bDKUBt6ufuove7hUgZjbTTBbjJnSKD0+jDxMBDUCMC4yLdXa7G?=
 =?us-ascii?Q?4ALqbxbOVHnBS1JbXZZUCc1ARXPjxhoB72zyyozUeDjmz/y6+3dkrTajta5k?=
 =?us-ascii?Q?+9C0CEurHsyH+q1aP/vxlM37eHQKWTlrFI5aOEm+ByJAlHTvclX9cCoOMINi?=
 =?us-ascii?Q?s5Hj76OMhvTeINoSSUCLVdboZ0eCy6MinOz4mt4DlOOzKvancd+OlRGSj1C/?=
 =?us-ascii?Q?Ssl5EMFthYwt79UcIi8+9PmymDoTR9vk/X6/4SBF8eXC7aet4RXda4g1Ovnu?=
 =?us-ascii?Q?IAIc/PW2Tn04EM3B/vpmLoiAbw2DFruSXLMWDBOmJITbp3jFW9gWxLu0Xjn9?=
 =?us-ascii?Q?NLF5DjqpPidruCHOf38miWr6gcDQ9zwtE0St3nFaLW5/i7EEyslRUNjwN36Y?=
 =?us-ascii?Q?9lT82+Niubwc5foP7TIkkEV78DXW/okB/aJEtD9rjq6u/eFvlPv02hEbv4M4?=
 =?us-ascii?Q?PfDoq8CmifUB98Z8eYfUDcrmIcCUWm2s0zoKXiCLOWdz7dpQa02ldm12o868?=
 =?us-ascii?Q?VJmqFkZtKq8vgqk25eMp0jL0063YPHd1PBzZfHw/lYmcFLXu2gQSCPQ/SsjD?=
 =?us-ascii?Q?8dZlJvMTTjJLmZOziXJjnVlRBgD4BtiktJfWybPf+QsIls4Zvgpe4H0zxzxw?=
 =?us-ascii?Q?6kEPWjFRW0v8uOJGXiYSaJ9RSVg5LYmy7EgWr9nUwl88iB8JI5J0cgv9A6PA?=
 =?us-ascii?Q?qGS3tcP0Wfj3j7S3cf1z02a7O5Gwt1901zxXvsXhnUKC/BuOGMATkjB24MMv?=
 =?us-ascii?Q?tK755VAQbw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e166f79-79c5-4e6a-bf18-08da39644fd4
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2022 06:53:42.8795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k5wnaI8aDx3oR2yDMwcbzjYPC/MfcYWvlqk5sFP59ivuGjdRG9v2+63r626/Ux2OLwN/UN6ZrlfxAe9R5o+Dpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB3966
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There has already been error check in clk_unregister(), so remove error
check before calling clk_unregister().

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/media/platform/atmel/atmel-isc-clk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-clk.c b/drivers/media/platform/atmel/atmel-isc-clk.c
index 2059fe376b00..9decd8fb03d5 100644
--- a/drivers/media/platform/atmel/atmel-isc-clk.c
+++ b/drivers/media/platform/atmel/atmel-isc-clk.c
@@ -304,8 +304,7 @@ void isc_clk_cleanup(struct isc_device *isc)
 	for (i = 0; i < ARRAY_SIZE(isc->isc_clks); i++) {
 		struct isc_clk *isc_clk = &isc->isc_clks[i];
 
-		if (!IS_ERR(isc_clk->clk))
-			clk_unregister(isc_clk->clk);
+		clk_unregister(isc_clk->clk);
 	}
 }
 EXPORT_SYMBOL_GPL(isc_clk_cleanup);
-- 
2.20.1

