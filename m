Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1973F509F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383924AbiDUM0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbiDUM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:26:12 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F10D92E09D;
        Thu, 21 Apr 2022 05:23:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODzyD93yc3nOc4F+olUFTnCGDjME0E0woCuDHiMnJ2YiG+J99uLq7s+wQ2aQOYwQ+EjpbvGid8GVwlXsbP/uwJVhfhJhE9MhAfY5lvi6545PGMKG3L06jmgShCb7KZ4GwQ04/qO/c8Ux3fR7VlAeOy2dqfWuxNrJp1csmrciY33il5UO6EOMXSe8pZ0t5QDiJudTIxz6Pot3iS2AfYC7GOfTsYku3MdnlzZKjbzviVzbf4yw3XgmRUHOWmZPqmJDoiU5k/OKFiqWRYeKO0ag/CezLEVgS4Oaj4gqAXCa1HxJJvwzI9IlNTAXrq6kcYjugKh3O2c2knF6clclbEZPXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VcdxtRTU2qyVDOIdy2e9aXE1mb6ol+kW5q0yPPXvqhk=;
 b=l6C21wfyHC0MdmsEPeAhNQwCpeqra1Ansl74Vrxn2ppaQC4JODdmTEPy/UFoQPfV5TM1GeD7dIlk/0mkYkcrFa3pb6qqji2+3u3+jmbb/eoaglP8TRjvhgTlOUQKvbWpy/9g9bfWe/mZSBq7elVu7Edd+NCOxoP0vqU/N/ubMqbzT0JmETRoGjzHAxP3MjlT2GOAc754QsaRAeyqxBD2PWKH8AvwBnvkp9v22suuhAGfBqk2dLhGPBxGapVm+O1oVfpUI8eOnAP0glxhoQ4IdPfShKtWUwWE3sTAWVoi3EcG5EPG0VOZ7IqlA+8j4VP1iDi1dzDriPLCX4IeSpGPwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcdxtRTU2qyVDOIdy2e9aXE1mb6ol+kW5q0yPPXvqhk=;
 b=EAg5IpVroDBgtJF61PvGfWvt8IicDnriGOlg/5x56CHZcEzyPLJwheL3zQ0nSP8zfacjvSiSEjIF+0f5o2sP+7rZ1vbOwI3VRl6pg78rsEeAWoXgZKLU44AVvXgLacVmvfaOjsaEUXPIJwEs3K04ij/PkVCGESb8vn+2zmx/ftU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB3031.apcprd06.prod.outlook.com (2603:1096:4:79::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Thu, 21 Apr 2022 12:23:19 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 12:23:19 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] of: Add missing of_node_put() before return
Date:   Thu, 21 Apr 2022 20:23:03 +0800
Message-Id: <20220421122303.111766-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09b3eae9-c1fe-4489-bdc2-08da2391b7a6
X-MS-TrafficTypeDiagnostic: SG2PR06MB3031:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB303113EC67936A9358C39F44ABF49@SG2PR06MB3031.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w3iJkfozhrNucO0PzAYH84noIfIHCE1Ao9KrZonSkK1x0Giu+RdrSKLbdXIiTLOZ/5+YElkRo47im5iLMcH7QiH2kSQbp1FAQa3M2cRm4c9OA7Ol+0uoG97g+R2P1flfOjrAoOIJECdF+FzkHgMm4rkSQEkQ4xVnpatHEPVW2pqevPwyLjuHA6R+qSBTYwz20Mtro0QflD3PbFtA6NnMKmsBkqo4tN0wnpsQGANUMV9airnqrL4GTA8qg52Bvjy4ovvlIl464TQimHaohFhFdpBJtbWdm8uSD/b3YSeIDB3RSQ1T82coC4wH8W/CiDEV27sZ792q7jiOzY1S/mLwHxfZ+gIYlFLELfQyekIlA+PmXfthY57rn0waa9zDfQYXinaEUw+sA1R62kMgMqp6RYwXWsngLo2o++MKc3R+AVCY9o1A0W+Qs2dBme/Tt1eU4Pq6fyglNbx9ovThcnsng0dcZbPIstxlNF6vL3cetbXuS55Jni64Ytn7wCA6WemUe2dy/VyMYCKaYf0GuqHO32nCHexXrNbtswzsOJ7ruYoWTMB9pwYtwzXKvlE/Xtp1Ws0fy1W60hVuMkK3C30y116rgCbfH9oczzUQSCJUsstkfoZTByn3gaZz1LDWXHJc2pByouVGySnhCS0Y11hyFWDcaieGuIb6m9XhCHe/tbWkRJe21rX+jH5Xs3T9ZSr19elGMZcLHAuB+p4Fl/NMVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6486002)(2906002)(4326008)(4744005)(8676002)(6512007)(52116002)(316002)(508600001)(83380400001)(1076003)(36756003)(86362001)(6666004)(110136005)(2616005)(26005)(186003)(107886003)(66946007)(8936002)(66556008)(66476007)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VMfwgfiy7F5tS0lk0pQ8mD5oSEKXKBeEnn3abBDtd8tdOmAgqM4yKoekbuiJ?=
 =?us-ascii?Q?T8uD1WAzwtUvyvLSVDTHX64IQXA0A/N0sbTy6QGY1mu6z2E6KXNatP57p35j?=
 =?us-ascii?Q?YSqWgvUDUs/igoWoakJzjh8iuGEi9Pqk9K1Mn5j6jMmTg17iX1eT/qO9Jpf/?=
 =?us-ascii?Q?BhmxRewLGHDVd00rdq/jtM7BXCpk7jgy+jcnhSf+uRFEIqGB3v75juZfvG5N?=
 =?us-ascii?Q?cs7lC/ctGhxlBD0NoRNNZMHnZBsoim0f/K9Po7Llqln4+ZQGOt8i5qcagVkq?=
 =?us-ascii?Q?jjyLggKA42sq/6ysLaEhhCK6aAl0vX2Yv3Wl02uUbUWJkm1bJuCTEIrhxWlM?=
 =?us-ascii?Q?DgCJ8bQiwG9aYeVM+5aw8JSlG0x9tY6mv1hFJ9qkQt1xJqznP+BGUIWKmSDv?=
 =?us-ascii?Q?ZZVQmor1e7MyQCFzYMrMcKKHT9gswFPiVqslUiITtz5TKU7+mQfRsQ96adsK?=
 =?us-ascii?Q?U3hZc1ItrN9jCcfjrJS8lo24vDZ6CQDNp7xETTGu5zOQCud71XKLRP9l2+t8?=
 =?us-ascii?Q?PLEGupbtkLB+jb5X9mSscLpJ85WuLhzm32K4s+AFn3OtCg+Au6QsPavbvXhk?=
 =?us-ascii?Q?ufRP/Swcd2tjf1t6/nJKoVF4+RUneu1u1aBhwTIezBdiJFqP3odZHFhR39Bw?=
 =?us-ascii?Q?bI5Yb3KrJWcMnDnFWu3T3ayjOYUT3mgkSc6TgypzgWXcwl7pBF/H1XX5F11I?=
 =?us-ascii?Q?hMTH5ERY69NfvX+9FI1yuUDzt9v8D8/pLb//yLz4sLgFor0r6TmV3aW5QaYT?=
 =?us-ascii?Q?eMEX9hYwbvD2a2XUufWXIA+2glH9uHTTE1jAjFJGh+1uVc91mXYzI5hx327r?=
 =?us-ascii?Q?ERLkZxR/D3ow+mIxsrEse8muE9XDL9OY9qzExpH0S6s8/JKkHo0sxheOIqGP?=
 =?us-ascii?Q?LJZRIENm5KV0eGv8KzSL4QfzMkqxADJX2APYAyfxVJx8LgO3mJZltN073WFk?=
 =?us-ascii?Q?H2C8saC+1zNkty4L7/Uu0h1DZvx4pHROtD+UXoPv8LorWNDl+2LS9v2GZ9hW?=
 =?us-ascii?Q?TOqU0O3UV4rkS09wE2PHYvqGbLUIJe3wVXL2Wp3NuYY1BHP0LbuMirYq/ogZ?=
 =?us-ascii?Q?Uhtj5jbMR93wtFbKr7BmGiw8DEOEnhaKYIhbtLTGLFSxlVo27kBpJHE2o59q?=
 =?us-ascii?Q?1wB+uvODRZHY1CN8DPqAi71fp4cG+qGO2WgLvz79wDF+VZW6Oa1fE4C2OlUt?=
 =?us-ascii?Q?yYLtpnXYKn0XvgbxrFgOum3WmAWQjt17oTmMmuLCX637GtYyWfexsBQHK9/y?=
 =?us-ascii?Q?F3QCYbMd9+aJOEidJYC2kG7nAIdZstW+Hqli/r29gYZFRtMjHTLP5MFLy1wC?=
 =?us-ascii?Q?p3r/qhofXc6YgeADKIWaBD4ym1iesM+s6qJKctb+FrU/OeQvSJXgMmO/+ayW?=
 =?us-ascii?Q?zWMuVO9WTWU5dNEfBvFPWEpxnq6cKbquYB/phrAHpNE3A83s7m7zvZpcyc3V?=
 =?us-ascii?Q?Azb51ReA24M8gB1BCLPJfE9bymWiK5lcrpqknZB3JU6gBcPBm8YOddXnyMxt?=
 =?us-ascii?Q?SvkkceiD5gzJzNXidDj10hq4sTxYZtLHgaJrOeeeFLB+SnaS0UDesWDHmOcp?=
 =?us-ascii?Q?gyvKVrWyICBHvrubeSqzQpoO0NmxYiR13hnJ13N5Rgx4Mc5MV+fiENJS2TM9?=
 =?us-ascii?Q?0fwRtSos8ZOUNfQX/ihgoqQwfidoJz9/ebv7uOrSbOd05iuXshQ99R6rv3ZB?=
 =?us-ascii?Q?dwBfZ8UzAijBD3HWDLe5XCcfWLaV30egN+4ywz3jOMIT8n7ULMkqsya61Ae7?=
 =?us-ascii?Q?Yqme/j6/KQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b3eae9-c1fe-4489-bdc2-08da2391b7a6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 12:23:18.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvh400hKHDlACbSfDFdOmqvhjmfnvvBvK1CTwGelNL125XIAxTcwnegjRVcviGoFyD/TIte3geFckcTpsXH/Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3031
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck error:
drivers/of/platform.c:554:2-23: WARNING: Function "for_each_node_by_type"
should have of_node_put() before return around line 560.

Early exits from for_each_node_by_type() should decrement the node
reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/of/platform.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 2dff3a3d137c..3c7ca6671716 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -556,8 +556,10 @@ static int __init of_platform_default_populate_init(void)
 			    !of_get_property(node, "linux,boot-display", NULL))
 				continue;
 			dev = of_platform_device_create(node, "of-display", NULL);
-			if (WARN_ON(!dev))
+			if (WARN_ON(!dev)) {
+				of_node_put(node)
 				return -ENOMEM;
+			}
 			boot_display = node;
 			break;
 		}
-- 
2.35.1

