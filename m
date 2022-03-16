Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A109A4DABD0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354051AbiCPH2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiCPH2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:28:40 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2109.outbound.protection.outlook.com [40.107.255.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED75F8E3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:27:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op0W3AldICn8jN5ZxS/+1YSURmkqsNsxYtZUYH1Pl2c3FwBSqRLHGUS7J4s+1q0aLxmx0MjWt4LmaSVqsK0lDt/BwFWivM6IQFfrf40ln0RweqloiYGwgS8RhPwAbbis+9F7XUQycgrGg3kxKLegBFQIM9AwmiGtd3PNbxAvZSNYiZBZ6hzREFxh8uwP5KPuXHCYlT/ujtezYCtcUsRd/BjmfkxOskAepKjHaa5WN39xr2v4rtZvDXzkkRkEXFILoiul2Bxaq45/RdlDnVQHUrbnOl6+Z8XrkQo1Z2+GrcLSUx00DcS/i5tic4ECBfwMDmK4Dwne796917U1AFYULQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oDdUB9H1ITg5LNwSZTtXV5NTOXSzWAyd+ymcIfdmcC4=;
 b=XmOxWP+D+lG3D9v51hqighAoEm9qjvRI6wjhFYBsvuzm8ldwrceEoUJyiFRIspVaFetA8ui2ZxMTW0tIQslu+k5EgtfrPsm8mppqkhl60xDalu6xDv4nqXwlQlHU/kR1/g/U218tQuDTmnF8Wy5HCvDmUcA0I5f5iTUiMT81/5JCFxQjZys/3CdyQBgGn21WP2qjYapfmyjBp27hncm7JzTyKMyQZ7A2JmkiW5JklbXUhqZrZuK4sxIilU5xLszPS8UOfSfO9zllolnvVEm37//+WD04LtAIt/8+WASaMyftrmSG7J3jmIfjeVA+eow4loMsQ+gjonkNLzWyhrXLnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDdUB9H1ITg5LNwSZTtXV5NTOXSzWAyd+ymcIfdmcC4=;
 b=CPOvim9umMFPso57RXU+EkpNRuGuhtHPxj4M0IkXoU61AYt0O4dbsApWAeGSuSvl7rUJME3lg+abJ7v4+CQcZjlVQy73Xjn+cpO4vU+o8CnEVwRTsoLNQS/sv5qVBO7PmouhO7Q6LLSkVJzo4+iMcQ1tvaTiZ4iEnenzqmvSUm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TY0PR06MB4845.apcprd06.prod.outlook.com (2603:1096:400:142::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Wed, 16 Mar
 2022 07:27:24 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::d924:a610:681d:6d59%5]) with mapi id 15.20.5061.029; Wed, 16 Mar 2022
 07:27:23 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] lib: fix uninitialized_var.cocci warning
Date:   Wed, 16 Mar 2022 15:27:09 +0800
Message-Id: <20220316072709.4746-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::29)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08810625-598f-439d-3228-08da071e69dc
X-MS-TrafficTypeDiagnostic: TY0PR06MB4845:EE_
X-Microsoft-Antispam-PRVS: <TY0PR06MB4845202EB82599DEC69F471EC7119@TY0PR06MB4845.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7MKweHAo+orbSw2FvL1eBOw7d+Ma1I6D2Ky5jOoQ3CQMGMEDTbrczNIDTzW9kZgAm8qMi9FaitA11qV5del2fe08tFSgXThO3+QTT89Rzk8lKrxDlUBB/cOiKFiXuJeBapXmN52JfcSg4S8Ubk31/X12gqvUVApgjBJGAFnQQ6R49NH0ERFqHvU4WjMzkT4hNHkecS4D84jf75YvxY8zW0MdakggJ/aFvQxRT2EBRkBGDlchu+bX187HZvYSuGBgaonSlU4Mod2K+UKyYfLomDoXsVorn0xu1o1+jakrZ1L9dZAEY9kuszi2CJmrxSVgaEzkZ0eWJd67bUhLC8YPzK1w0avx4kenXZFQNZK4cm46Q2DtqKmqwEgtIbchDf7HyDdZvYvybr3w16eZ3rx1ZS1PoKzzY9cW7spjpBq49YB4CrEXt8TGlpR82wV4u7/lYndDduE5/ruXZlQQKFCgQ9h1qyMdtgPK5m6UOScHUzqcgSwkjIvHcq2+7XGFrsaIcAs2IgXb6CCs+6Y3qIBowLBKDVcVJe+J5hV0NWEI+nN+XyZjFL++/3A+SGqVXFJ5bshWx/GxZQunKpVrEPEsSbgbjo1l+3+wtl7utGT4AsVHSGMBwF3k1HBtJMMZRlav+li8vHX9m1Ge57XtxRgOnVlkJLGA33vla0z7sDWTEMMeOK19dK0c4TOQPY8d5fiW/bwfA9hwJAT/9PnFtDwLQ/dZxKN8XZTEvsRtGTwYbjFUGYVDVRYdtKnPJMBUG9jZMsXRDMwX6gOKTLfdh2y4EUF3/NHR+Tb+5jk6+iaIEAI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6916009)(8936002)(5660300002)(316002)(8676002)(66556008)(4326008)(86362001)(66946007)(66476007)(26005)(107886003)(186003)(1076003)(2616005)(6506007)(6666004)(52116002)(2906002)(36756003)(38350700002)(83380400001)(6512007)(966005)(38100700002)(508600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EDxgVaW0jGGZbeMZ4e3Z5EDZhyHkPE9rnwa44qgptnybH624NGHpbbW/uiHh?=
 =?us-ascii?Q?oDZgbRZf4Obe/ITh6m5/8NW08/tNhC0WGva9TayUSl40lRCLu3mqbpnmhdHw?=
 =?us-ascii?Q?963WHn1Br669g0lS6Z24xBPh/7ptfoMQlVKGIF0wCi6+wirCP133h51ki+P4?=
 =?us-ascii?Q?Pp8hy4tVBA3EMnusVDQXG+gi1o4o4yXBqYnU5aURZl7g2shhocc/v3waJace?=
 =?us-ascii?Q?rpoVjoAwQoQ7Z+PPpVNSYHKdgx4fDF+CftjaD1gonMK17uRfBju939fOvraZ?=
 =?us-ascii?Q?er6ZQJCJsL85ppl46hi2xU75fegEnwgOF2x9g01bUuIth9mLjYwsINpMHh8E?=
 =?us-ascii?Q?wMXVdC3N2nKSV0rWyS/HPItKTSDdYPHwriesmI7xxSVhMCarYG3BPR6904BA?=
 =?us-ascii?Q?sRxzWIdF4VLevlhrRapRO+8eqErClI/gl9Yxj4h0ZzbkkTTNbERYTG8pVUB2?=
 =?us-ascii?Q?675QsOpfK+lNhDumvjJ+S+6YtSqAKxVICFQUhfx8ucLYZjMCRX8zthVfp3NH?=
 =?us-ascii?Q?ofzF+TZgsv4urKREK9a0XKpziXe3wiLDr/njOin8X/wnJrVcM0KhDUvoAd9F?=
 =?us-ascii?Q?rR3YT+Dqxubk8fV2wksushcgXKF2PjCNAaEys16+K8h6IrH2G3i+aepBnb5H?=
 =?us-ascii?Q?PL/1a8tK/IxOt1aa9qhxAht52ehq8a6dwpWijto0iEWxr41HGTyuGD+xRiDD?=
 =?us-ascii?Q?hICyBjbBVV2LPTBcwsoKKc2EcKt4TyXAo7QiAl0fTrpLjdoy4tU4lki73DIt?=
 =?us-ascii?Q?dGJhL5Q8eclUuVl/HexG3TrjX6Y4Pngxu7xneol9rO2xilqoBR8XL9ox+/g5?=
 =?us-ascii?Q?Ka8fjkA+qiINEdzOwSPOtsE9kNgRCY0mvIsV16FPJnt9kgBwDWeC0fHgkyf7?=
 =?us-ascii?Q?/7Q6SJtHRuQx2u+G9z7tWlFb3c/uEoDPLUi/WUjKYz4C2u64/bcVRsOxat10?=
 =?us-ascii?Q?esVgGJOewArxVS9TAAK0uTnu3Va+vWKwt14HAuMP8Xdk8ME98WF/Xf+KzR1j?=
 =?us-ascii?Q?ngU5sv7OZmgD2fFXyFMk/gRKkYV8HERX5aUGY1SCgtjFBu7G/7pv1ba84MHT?=
 =?us-ascii?Q?ppG7ZCNnlYiQj4usaW28B0e8Olmyw4tvkOsaOTYxOyPFWWxDwiJjDTHXkQGe?=
 =?us-ascii?Q?64upUi2cSHGF+ATB7RId6di7uN8V7qJ2eyPu2h70B1jsWzTuXr6uKHQ0B+8T?=
 =?us-ascii?Q?9hsOQfHpwC4lAkq3oJ2O6W/qF08YBsfXcIQ3OeDPmYZbyK4GrUxpg/HB7IXN?=
 =?us-ascii?Q?B3cetKB2pWpXTga0vG6dqc51AjSMvmlPSg9p7wINWvGr7vXc7Z/WiwiWmO0a?=
 =?us-ascii?Q?nXRKjRb3ODCH3YvM5awNDlazBa2v+TFnvSXesLA0owpWUjd2b4pvo83J/o89?=
 =?us-ascii?Q?FvYFA1xK7DOs/O6cbsgUaM7xVeY2nmUBR2xEZ6rbRexNm2QFjLJuea+4MynV?=
 =?us-ascii?Q?VVNK3BVaB0CDqNOXC8lVl4VLDSMtCKFq?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08810625-598f-439d-3228-08da071e69dc
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 07:27:23.6079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXjgZasvjX3tVz81zLJP3yDNtcicS33dechkIYflPRjokpqOtCvDtWIR2hsaqLF8CETpNNTpLNfOj0iiLfnUUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4845
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix following coccicheck warning:
lib/glob.c:48:40-41: WARNING this kind of initialization is deprecated.

`char const *back_str = back_str` has the same form of
uninitialized_var() macro. I remove the redundant assignement. It has
been tested with gcc (Debian 8.3.0-6) 8.3.0.

The patch which removed uninitialized_var() is:
https://lore.kernel.org/all/20121028102007.GA7547@gmail.com/
And there is very few "/* GCC */" comments in the Linux kernel code now.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 lib/glob.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/glob.c b/lib/glob.c
index 85ecbda45cd8..15b73f490720 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -45,7 +45,7 @@ bool __pure glob_match(char const *pat, char const *str)
 	 * (no exception for /), it can be easily proved that there's
 	 * never a need to backtrack multiple levels.
 	 */
-	char const *back_pat = NULL, *back_str = back_str;
+	char const *back_pat = NULL, *back_str;
 
 	/*
 	 * Loop over each token (character or class) in pat, matching
-- 
2.20.1

