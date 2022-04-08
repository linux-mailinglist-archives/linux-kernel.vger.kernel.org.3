Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142644F97F8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiDHO0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiDHO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:26:10 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2090.outbound.protection.outlook.com [40.107.255.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60277352E6F;
        Fri,  8 Apr 2022 07:24:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLck4YH2xMV47shKNvvmdfXdAthcq+WafwKhub0Sba50iGpch4B3q+nX+65cYoid98LyxOwtA/qqxpo954teBF3yx64W6bl79Shphat//U397m69ixn+o2PkhX7v/+1mQ18nxqCYbst4IYCgepRxdPepUUfgeGC7N+mFXGUhu+rZYN+bk2ITpZ3/dtP07vdSTHPcWN/sWkuvJS0McxHzWIhhAl4/tnkuf68ke3i2rMePpx8mZiAiNJzMt4GG/yRINMeVN4m8XrVo1wLENHrUJJVk+J3mfx+wB7VdDzQFzQ01IEY14YCRdUqjDyrk5loJt+HYY76JaLaa7WbRksbgIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t85DBAf5+R4Dg3hVtqs1caraSI5aBhrK1sNq4lkll/g=;
 b=LPPa7KGCKPZEub4thsrqLwMG2xq65xGzeGT5eOQa36eTJOB2ouR2zbDO7pnu70vlqwCqGtZPSIJdLfhfMMuNs5DHPRBTQK8zXySpYJuZZr8nwDYj2E/jkNwKq8++sLUJvRCOdfIRU+vkRW4ZwLH2taaV+GOdc4ZKohnrsm0uRlo1NjR0zGAqMJX7AnqGYCoOuv+AGBNV/C8/7AGkIMMpWONEcriZDrjdVfktSA85jK2N1XioLxsycEMzB4S00ABZizX5Sns7Uk+DTfbjAuLDJm07rknWYbyBCR4wWLw7Sq4X2g6rXbXzDaNzThbKTJ9jxW8O6WN2bP6Sjl/tgHvrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t85DBAf5+R4Dg3hVtqs1caraSI5aBhrK1sNq4lkll/g=;
 b=lTpQEzimFV0H6dYR1AWB7hUbB75yq3g65f/jZ9H+uvsyY+0gxejoDh+1bI9KNgm349hX7fVreyC28pyM2wl1q/LstQ6H9hqwFqCQND1gjtxjwMaWcAefgW8tApI78cEnsXflwBBgklN8ozuU0lyZWKKv1kcHrTsu58Ke+vYCv/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com (2603:1096:400:26::14)
 by SI2PR06MB4137.apcprd06.prod.outlook.com (2603:1096:4:f6::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5144.27; Fri, 8 Apr 2022 14:24:03 +0000
Received: from TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be]) by TYZPR06MB4173.apcprd06.prod.outlook.com
 ([fe80::2813:af2f:32d0:7be%9]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 14:24:03 +0000
From:   Yihao Han <hanyihao@vivo.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yihao Han <hanyihao@vivo.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com
Subject: [PATCH] crypto: ux500/hash - simplify if-if to if-else
Date:   Fri,  8 Apr 2022 07:23:49 -0700
Message-Id: <20220408142351.16961-1-hanyihao@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0221.apcprd02.prod.outlook.com
 (2603:1096:201:20::33) To TYZPR06MB4173.apcprd06.prod.outlook.com
 (2603:1096:400:26::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1176546f-b81f-4d74-fa7e-08da196b6ea0
X-MS-TrafficTypeDiagnostic: SI2PR06MB4137:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB4137948C533AACD4C643668FA2E99@SI2PR06MB4137.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ldKxe8Qd0CrdR+lxxVEepCBg0uT+urKTftPZ7DAL+5bR5wJ9myuamCZ7HupkLjUdgp/b1Q3zTomQlAi3cLSfN/yRA/vLCheARWRZB7FyOXHzIvG4yEMtzUqNbj053rCNdCnLouGOS79Bmv6UAJpcHgPoUeLCpQz+39WJbTZrTzEAlA7AFEbnQiQAsB/skgSNYTdRUoYHFGH/pWpDf6Dza3hKmuk6ie1g2kNwDcYJnnyUQ1lGU3ncAMYtLIGzZJiGvnpxXvGT1Fx3y3dooLThl+c38BNk1o1a/TIrD6AsCRa7JBlwXLM34Mv+LWIysQwkzSu3kEuC1LpluYaezO67Lb5Hu0U1GU87I8OYheOqvJH26TXAXqZkB/NObcmuqI8jHGoI3JEvMt7g005GHeMFC7OOrfo6Qp5nVernz4ODwLMawIY2awPjP/eh2dRY9G6hDPX6v2GwER+c8pUzndmEdPbFs+JTSWmZ5xZYpw5QA3UupW7Wf4k0nUB9zmx+zhwt0a2wtMTxVnjtP4196Ey5dXmTrcjGg0j96/YFwlq9zQjbk7lEO1JcI8IFYTPHV/UuPUHW6bhpHKmWQa3nTdLKiPR9olmEs5L/fUWxefh7btEuVwF5BmcZ0UzdaejgsAqz1xc2He9pzs+dwwfOvvBc5NnMyXXjxQEZFYpFpFtoO1JbHlFttezrbGk9nTrkVbWCnkuP6L1EPcx1nLcr4V24Bxj4QdepR6Ybn4xhFJRjGl7hb5U7RzRr7DQsz6UOMDgrVNvqxxexxpEY8SQLL57MQ57aWscaWMGELqe+wATAz8o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4173.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(83380400001)(26005)(186003)(110136005)(2616005)(36756003)(1076003)(107886003)(86362001)(5660300002)(52116002)(8676002)(66946007)(66556008)(4326008)(66476007)(2906002)(6506007)(6512007)(6666004)(508600001)(6486002)(966005)(38350700002)(38100700002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GaHIpYaFZg1yUQkmxM9crnAwWu7MEQZruEGX15LPiX0w+AJKoZfUM/Jk3C3X?=
 =?us-ascii?Q?ZiuEg9uqQHRntOT+yhNywkEClVa3GLA1OUyoa459DaGJ85UBUy12AFesqUT/?=
 =?us-ascii?Q?ncjBGHmGHotfTrbkTG60kKCL8xaqY7RCf2z1SAO+AuQL06EGBoZ5F5dwpoKa?=
 =?us-ascii?Q?GQb9T0gKAwcYctNDOq0jOVt09NfCROjzYRSqRVCvm6V1PN/6Zj+Zi9JV5B14?=
 =?us-ascii?Q?iVvV7kakF+qM6GQZboBqBPd4JB8onrz8dZfJkfEsF5bD5jXrnqkFBHUis3Hp?=
 =?us-ascii?Q?oF70B9xo1IFLwKOhKP/cp7getR5tQwjIy06ptP7TdlJ3ewZCFX3uqBzobv8+?=
 =?us-ascii?Q?+L0r7nQFrukADFtn3f/R3RCs53BtEUqGYgrh6UJy2DzC0JXFbXEK9ue9IXnX?=
 =?us-ascii?Q?YfePz4PEVauRk9ge9naFm1r/6Es6gi1LnJhDpL5pOJ33JBWuButWWbyvffdi?=
 =?us-ascii?Q?Mo/DhQ64PBSaCm7MTbDP6kP8PTb02LTU/kCaDTAXFS7DX3h/dn2OFqU044Tk?=
 =?us-ascii?Q?Z+JAhewEee2GIJVWS1b56s9K8U035InWO8NjDClMAPiT9WWJLsZVrmrBkWPY?=
 =?us-ascii?Q?InK2IrZ7mRRK70AIA5l4c8blp0aJaTWcoDRp6aLcvZ5h7vPfINxvIR0KMWfJ?=
 =?us-ascii?Q?vkN8Nuhu4d2i04HaqT9gwHFeEtdV3Jxnw6tbTEweLXbwMlLiwzE6szOn7Seu?=
 =?us-ascii?Q?TYViRMShdSUBNZiNw4FwpzWu505JDCmb5zXtULsdJ1TLx8i/ow+uzvj7QB+q?=
 =?us-ascii?Q?PkDRenHenMxXKMZNPgr9SXBbI41oCDoI/YQiWMrNMMYQaVn++KFmFbV9kx31?=
 =?us-ascii?Q?8vdgrUsS3iBngGiWiVaUu5QWaeIt0X3erjWei3lIDV6GbM8Nog0gmqi9sWZ/?=
 =?us-ascii?Q?HjDEV1B65YfZSG4il4yly+orc9YytCiNv5ZM9kCpZwjxto+NxEtKoXj23c9V?=
 =?us-ascii?Q?Mqwu5Y/bhZZdDxcgSC5SZJpK3f2pKJzvrlifQxpM5Ihwx1C7aDIkRU3SaceL?=
 =?us-ascii?Q?KmxS4jEog3+6PJQVtGk8cB6W+iSC6Wmmb8pbp1jnaUVb3fS6GyLyNIodlBE8?=
 =?us-ascii?Q?/mx91xJ1rB8k1OpeuI9cm/tNncWqLclCQdtxy2djcnBuZ0B06WwHxbaNCtz8?=
 =?us-ascii?Q?fYAnG19UbRAxmra8btJLgH7sWSIpFAxrld1PU9i09OlUbEIUKDQvo9BGD8WT?=
 =?us-ascii?Q?RYmkgBHN6y8wdo3SgQQAi79bfXGDnpmBuanGTRPWJ3snGQ5KtGfRccsBpNrz?=
 =?us-ascii?Q?QkJ65h4ouuzG+oA+OdDfKXZyBLcT/k6W50MkWIK1YYt+swGQXp53EBnnCglY?=
 =?us-ascii?Q?j9oWfAlMz6/omQQc8qkSrFOSH8DncCpZxvZ2MFl1xBPe49sR7A+X7+HTHyYy?=
 =?us-ascii?Q?CFWX7Eq+GH27jJGnMZFNas00go2QZzfr/O+1DH/CCnMIaDOItlIVN1HrcRzY?=
 =?us-ascii?Q?qqThit7dR9mYlVfLv/toYDF5Js7TyR0LAKMyG9orDxxNP5Iul24gYR4IWcR7?=
 =?us-ascii?Q?zbNirqVy9VpbyWVMhKq1xa2T2AxmfvOb0aNXOOPavq7hBrmINaRMiPtn1JO2?=
 =?us-ascii?Q?td+AGp601dvn7GTXTlGkXe4+iZ5z+QbmdDc7qWB5BbJoBiFAgnAKIqwaCaxk?=
 =?us-ascii?Q?Ckrsii3M+P7eqiDEEM1MnOmS9K96IImWjH4kLi48Zth2HiX/iO6aZD3sKhJL?=
 =?us-ascii?Q?TPCth+J8YLTGBn/daAEKRBI8HapGD5oednEblLVmyY4CMgni87ZPHLF4XcQA?=
 =?us-ascii?Q?kwiUfoyVpA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1176546f-b81f-4d74-fa7e-08da196b6ea0
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4173.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2022 14:24:03.5990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go7NoKkRIE+/zopqkuORF9VbCvebe1yrdTyuggSZIPSaovr0A7QHwgAr/JSrBRWSIPGHWN4nFxzOIt1R/7hB4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4137
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `if (!req_ctx->updated)` with `else` for simplification
and add curly brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Yihao Han <hanyihao@vivo.com>
---
 drivers/crypto/ux500/hash/hash_core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/crypto/ux500/hash/hash_core.c b/drivers/crypto/ux500/hash/hash_core.c
index 5157c118d642..265ef3e96fdd 100644
--- a/drivers/crypto/ux500/hash/hash_core.c
+++ b/drivers/crypto/ux500/hash/hash_core.c
@@ -877,9 +877,7 @@ static int hash_dma_final(struct ahash_request *req)
 				__func__);
 			goto out;
 		}
-	}
-
-	if (!req_ctx->updated) {
+	} else {
 		ret = hash_setconfiguration(device_data, &ctx->config);
 		if (ret) {
 			dev_err(device_data->dev,
-- 
2.17.1

