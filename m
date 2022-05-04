Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A219C51A216
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 16:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351277AbiEDOY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351282AbiEDOYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 10:24:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2090.outbound.protection.outlook.com [40.107.117.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D352C2ED62;
        Wed,  4 May 2022 07:21:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L3aIA20UXRRs9og5IqL4cPlq9IXI1PWRERfldf8cQ0gRwVfTAIWvJVF02ULH75UdV0yWRp/hGIEu6KvpsXplKb2k0WOQVJMmI9dnsDrY9sosL4f4MNusBVh8f8cvWQhnQcuVloqg3TOdrwrEvKoWOsfy3fR8cIkjUn8LEFmRY8AoA1rxzayLMMU8nzagcHnFCtKV0AF18C5NmwZcuErtOu3lR0ClcraHhQBGKlDh33k9EiGWqGOvQuNEH1yjJyjyFxWMs0LnuCtcvlpMdniNEjRtX6WmmrPfBVDFuC+dWZlAZWNw6jhBFuVGY97bc+aFxvDGTrEwrqR0qwzZAxzQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJVfs+56KwwfQPbj+ShccRmJEcqdojyGBLcP7HLmMwo=;
 b=EZI462ehkU7QMFkx7cb4Gxq8PRA/RYp/KsuGqxEbS4QFuptAMnctFyCSWdkZnD3c38ZEfnAjb+sqZHKGMCK6rkAHv0WKdnsZ8/w0pyx37NKMB9yTTPE//BgMoWkm+UssUCmoCcBGxz7FHMdiV18nWQEtJvSs2aag17L95Z0sk+weBLyCDoWiwTZrTigzDMmaqYz3eK7uZXilVG5HTCTBg3prhJJzE3eZrBJbltAyctGfHgg4Y2OMEEP1MiFlKlB0wRPYLsmDQI1KrEH4bNbh5N/f1jFpqykEQQpGx6id51XvQcuu6BPJdxFX0NkKPw0b1tHtNdziX1QTKc6BAd6l1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJVfs+56KwwfQPbj+ShccRmJEcqdojyGBLcP7HLmMwo=;
 b=D8sX4HA6kGVAnI/4YCa1zf69OesvJCdLRsAriaut9X4IgN2fAde4AjWciKlimkMqs8nuu/t3moWPtYhOYpcXdBTmyNVdbO1GiQTL77MPeFB7vRM5ksfMgZxDA7NtzZ9AfZQUD8z4c8UKy7/cs6Gb15QS7scTl+BpzY2POKXjYq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 PU1PR06MB2373.apcprd06.prod.outlook.com (2603:1096:803:30::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.19; Wed, 4 May 2022 14:21:11 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.028; Wed, 4 May 2022
 14:21:11 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] clk: renesas: rzg2l: Fix duplicate argument in rzg2l-cpg
Date:   Wed,  4 May 2022 22:20:57 +0800
Message-Id: <20220504142058.18704-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::23) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6be517b4-dd12-43af-8017-08da2dd956a7
X-MS-TrafficTypeDiagnostic: PU1PR06MB2373:EE_
X-Microsoft-Antispam-PRVS: <PU1PR06MB2373A4FC2FB8FD4C4954F570ABC39@PU1PR06MB2373.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n9Cr8m1HmZBT/hApHJIFHRm9mdlwu9Gf83MeDgpINS73L11sv//+b/i6tDuRjMa0ojWaNrYeDZ8Tz5Hp0u4lAnR1WI1fWTOdp4tRfCyDMrj+wxAjmDwwZ+aPFu+oeWfqZh1eH7a+3DkdnAHlqsDVBwouTjicRLbGV8ZhvJv+BHkZ9wOXBZ8BlzGW8+qrOnXPCEpfTof9OAN2j8zChRKO21Q7LSK7eOeMo//AuLdjgF8sAy3IjRhvfUdzwn7bcaf7+7H/4ZSZ6PwfFE3kPa77y5UWqrJdCuJSzJ7zGYi2zX5hNnLoej56KxfHMBMrLWf/FbDclE6GTrMXgfVZGYLTPmiEe+nUurVAAsDy4sPyGNyJzi4tgU2pX/5y8ZqYqw5V+11k7JZDn6mxC2m4ff1+Sa6F3kharl9WnLtwiiQPfLqW/LaBvTSYwMeyED8VjVarEcoG3p+8S1OvoliquKzHP6Ca4R7S59Nx133BdLzvk7j5nYz3upvGsn7zwCcqcBDU5xhqvDFwYaV+WXdYsONi09gyne2JxkNiws1nhi21RUv2wGNxXxjs4/CyJ5EYPMZgig8ZCk4YU9dFj39wFFEoqr+sa1bkydGOr7L3TXIetunBzcwIOT+2RmtwKEA6+hStYmch+guqyUgUz5GQ6PCKE+taKxX85HT8vGnkyM2aKcdF2GHAPH1MomQY1oSdGhc3CG2HGejzsm7RXlWgVx0x3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(6666004)(110136005)(6506007)(36756003)(186003)(107886003)(316002)(26005)(86362001)(66946007)(508600001)(1076003)(6486002)(4326008)(2616005)(8936002)(66476007)(8676002)(66556008)(5660300002)(6512007)(2906002)(83380400001)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qiq3rL8tGvY9gOC4uKR21MbUCo9LVXPxH9tUe6GuDtVcDl0tK1aE1dEgF+3G?=
 =?us-ascii?Q?XaHuwo2BaEPZKMDduaxeC/uPP/NmiFEuxCsDNshkq62+zSjGdkYAs0sPfyJN?=
 =?us-ascii?Q?C2cePZpHyKlx8tdrgfKyKXARYNh7UaS6pjxnYVgZ7uYxfsglNiAXASIIUboM?=
 =?us-ascii?Q?8xj8SGu0GUEerpvsGX7zQEuJQwdFnKWceOUJUk2A+lMlNuZu7zp8e7gdXPdn?=
 =?us-ascii?Q?FWHhwgjo7kKvYMOHRFAdWM4MWB+NUBe6o7niuM012CArFOtVe1/fOk+R9O+5?=
 =?us-ascii?Q?7dRX5QY6Z6X8HRy3hJzBicLfAlIywjhJRV5hWH1iMOUyUjx2MS5E20AojZUH?=
 =?us-ascii?Q?oZqQaTPRB/g80c2r9+1ATid6pmUSK4OW639TWaf8foFSU7hH9puZgkthjoFi?=
 =?us-ascii?Q?kkCS9R66hhzMr9bqkjj1CRmfkDZoXsaKJJd6D/zJQum5ABXP5KE6r2wXeZaF?=
 =?us-ascii?Q?WNlXmFKKpiXSB7l49TBV06XX3WlE2oiafgraFf1FsWoN9MkpcPGL2JO7jqxw?=
 =?us-ascii?Q?A/J7/wHCcm+oyrLU0ygr3JlDqz7VyHr+lTkCo7ELZ64qXX2EF7I1ZJHyT5OP?=
 =?us-ascii?Q?HOItc/+NSfmViYFm0wmMoxbRsAE8D81L1Vw4ApRTFuQZUBffeEMohPLeURDB?=
 =?us-ascii?Q?sQMvyYKLDc78OVGgOiargKrjLfO2aYkKcbZ0Mi7bn9OKYDi9Tt6PVR/uYXAS?=
 =?us-ascii?Q?M7znsX6/6uzBjhkG2z4agoO6XOyENciumsmZoiHCR1Xlbf1jAkxnNUMjNbjT?=
 =?us-ascii?Q?ToqES0lmvkdFBB3WXEeAs6+xy7MuhIFOlOTEwsgO12Fci0CXqUt9d/dw4LRC?=
 =?us-ascii?Q?Gf2R3XGU10wCba6OIpYOTbIR5cvU1Ro2sM7DrJ/0YDLcAn8FQAVX7Fr4+uwL?=
 =?us-ascii?Q?rowhyRZuYN+9OS9pWHzp1tOfkWwezVXMyg0RH6hHlq4FLZvrlBr1uKB64Z9t?=
 =?us-ascii?Q?3Rtml6MzXkuBQ3z+aLefgn/Kj5ZIHyoaPqf5Y6MU9d5NFOzz7c/jO+aXgxtQ?=
 =?us-ascii?Q?vn2qhFoyhuaY8+ihwxErr/GLd5ltoRzC1haZ9xwkD0BQx0mh+VDOQ4pLfUjG?=
 =?us-ascii?Q?vco1lUQPbhhgkhGnY6JY+O26hLtnFtNsnCjLC/yBQTYQIs9AGzteSa6IeBVL?=
 =?us-ascii?Q?SUtYlwjL8wwCxb/Q0CwAzfZauUGFmbsyo6G/q5/8EZwEnW2LQ6SFfUw2e+ZG?=
 =?us-ascii?Q?4EJKZxqTU/z10C8v/rJcTvRxx+vCgMJKasyFuIZTaCeBdMtF3QymfwWMQYJR?=
 =?us-ascii?Q?3YBhaoOjdj0JuPEMf9JJZX+nMBfRaUSJ+v81g/dTOoa+HCYVQDfgr4zj1Qkd?=
 =?us-ascii?Q?JjkzhdQOYNhChs9OVZDvAmrX15DUDv17iOosg/PWVGjme8eXrX86q33OFf5U?=
 =?us-ascii?Q?NO0Xa3w1B9aIj39koEXieGEu6uuPb1+NaLz3l6q5U+GX3voWBNAefQaMMH8Y?=
 =?us-ascii?Q?pVbjof91iZVLvyT3d1EEYV8wfiakkIaGfx7tP13/SfQ+j75WRj0hulDBiier?=
 =?us-ascii?Q?5XzLFqyFom+aBFvWz0SWR4QXbjb+pnjCj7wFczXwbVnXqKP2K85IyY9/VSXm?=
 =?us-ascii?Q?xBr/jch5zc4SsJ5zhRp1BFGsyVn3f792UeWHHna+LknQuUK364AwvQfLi3lf?=
 =?us-ascii?Q?Iy3+lJctt0g8lQ6AxeX+j750PKSae4gzsT8aDPCStqni4offgcUJeTobZFrx?=
 =?us-ascii?Q?jSmFUdXpFVzeM1T3odSIGhUPdU8o3+Y/f9a2Yb/YhHdnaP43/y0hd3kWLNkE?=
 =?us-ascii?Q?BcK1WvzDdQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be517b4-dd12-43af-8017-08da2dd956a7
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 14:21:11.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b31RFYzb+zGoQoDegK/Iw2Bt1NGTJflC9adqzgnAAauK19N9gfJXIl7bLRHVhn3vp/7WSEKzIqQxFcdURZbDgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1PR06MB2373
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/clk/renesas/rzg2l-cpg.c:603:39-65: duplicated argument to & or |

The CPG_SIPLL5_CLK1_REFDIV_WEN here is duplicated.
Here should be CPG_SIPLL5_CLK1_POSTDIV2_WEN.

Fixes: a16ed737e62b ("clk: renesas: rzg2l: Add FOUTPOSTDIV clk support")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 15412cc58337..a1e1fee9f483 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -600,7 +600,7 @@ static int rzg2l_cpg_sipll5_set_rate(struct clk_hw *hw,
 	}
 
 	/* Output clock setting 1 */
-	writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_REFDIV_WEN |
+	writel(CPG_SIPLL5_CLK1_POSTDIV1_WEN | CPG_SIPLL5_CLK1_POSTDIV2_WEN |
 	       CPG_SIPLL5_CLK1_REFDIV_WEN  | (params.pl5_postdiv1 << 0) |
 	       (params.pl5_postdiv2 << 4) | (params.pl5_refdiv << 8),
 	       priv->base + CPG_SIPLL5_CLK1);
-- 
2.35.1

