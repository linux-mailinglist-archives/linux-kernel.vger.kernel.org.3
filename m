Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27580525CB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 10:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378005AbiEMH4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377977AbiEMH4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:56:13 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2093.outbound.protection.outlook.com [40.107.255.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581DC56775;
        Fri, 13 May 2022 00:56:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So5+zVVg5HuHU+YUWdp0CtMQjoxhxMcIJTTdigvWlomHkHGdvXvjybl9u6A5UqEWiNkDrlYoyw1cMGIeVvAeIrWNc3hlud//eqW1zs7MHUSqnJtXrXVdQgl93ycdwgC/VHGQ5fSmLrHv8PvekXvdaq+KtJrzVNVzlfXQVES4R97CIec3LbyV3n2/z9Lk820tnCL0enu5b/HdQeSy5NzNfzr/89swMnVSMm4b3bJ3KwBqzcjJhJrwZqBKmqvek4qBHEqxkIFxoLAtjv0c6rbF37w+f/e0mE025nLKt2Xef10UHvFNwXULC8AOC7N+wXrQJTCu01rFsPZ95Ltmgt1lDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrwYH/dXZDTsr+q1rmO/5omlYC3Rvy3/el/yca/Fcxw=;
 b=ccFWq4kKvS9nzPyH/rbkIUJ0VeAP+26RYXUOIeUA4ZlwqKvtKDI4uKNRKMtxGFBr6JXF9glSMOG4mfCh6z4xmnMVsh/4wSl7qbfyFKEFYju6O6ZqPZMTnVQMYCm8fIsLvKWH+6RQHWv0vY9C7yTjpItaC8ApWQl7EHm8lgrdr3DBlHzW+jE96kiUc0V6A9YqxG2RJuw4eVcvA8l5vc+gWM9sCw57vZSg6uo+cZ2YqvRrW9mIf/3YQ9Xh2tdONzfHa7Q6/Y3MeSOdO6iOnR7ay/P8J4R0G+Bc8sXQZAsiLHMm8cMQDDEJ7ucPn9JKbx0fEpr3+3me4JD5wmVoWt/uVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrwYH/dXZDTsr+q1rmO/5omlYC3Rvy3/el/yca/Fcxw=;
 b=EnycBHdhZwI/cv4pdtU+lsGPo8Of41zKV8X4rJFQ/42f1gEIpYO8fs6wJlZJQGXL8ZaIpddq0WGxvBqJE+qiA8GFzCKzwis7LcBi49aQl7b6+GgGfl8+8nCHIXozyL3q8EQ0j/Lqn0tX4t49jEQMQoQr6DAcrdXx/+jIxCAImSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com (2603:1096:404:a4::10)
 by PS2PR06MB3495.apcprd06.prod.outlook.com (2603:1096:300:6c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 07:56:07 +0000
Received: from TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e]) by TY2PR06MB3374.apcprd06.prod.outlook.com
 ([fe80::b13e:aba1:b630:a14e%3]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 07:56:07 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] ata: Remove unneeded ERROR check before clk_disable_unprepare
Date:   Fri, 13 May 2022 15:55:54 +0800
Message-Id: <20220513075554.127677-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:202:16::18) To TY2PR06MB3374.apcprd06.prod.outlook.com
 (2603:1096:404:a4::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54530617-c08c-42d4-2784-08da34b60913
X-MS-TrafficTypeDiagnostic: PS2PR06MB3495:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB34954A8A861C7F5A302F787DABCA9@PS2PR06MB3495.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l+akvnDVpA6haOyob68VoLNwVddyAdTlENbY6CXdiBq7zwRA3yBQ3Amab7GXASVRslQIOrY8awGzmDL5wfMsUcSpbF7hfaI0hiFq3GkAiU21mDSD5fymdwfvSpb6EpqpgXvTdJ06f110g3kx2OhBT5axq2liMIyW8a/QV0TmKE6CdMaQNeWCWs7PADkWWyV7qMkz9aNQncRG6p6VnUapgJbj+qTfGF5ejHekcr2dwAWJ3KP6UUhhp6QvYufe+P1USs068DiyKao8uvKahZRfOhJ95w98hkWoZh+xqoJQ86ZwEsmACP2JGRhweOO1jHbTp6mKNjuL0r6mK5Go7slhDEZrgGDVQvSQTCh6f2GVBSNBtEUhEv9waRqtyGWL3IaKnNxE/mDMhVaggitK3saJ3/uN+toE4eOcUNmQ1VTl+KSkO98EBjPJd91O3QOfZ+O43NjbFh+3tHjxBGEcwDboRaCiez5/dV+4U37pjL4fHesZ0AelzLi3dxRmh//Trb2HZ9U1k51HXmQYPp2PO+nvWR7bW+1Fqvc9DZKe0oRedzKk+vGXARvWxBSKaahWGcSqOlF55MuihLG60csiGLcSf/lQsnTzkOrf/m9IiUEy06hhH81cVV71NUhCwG6OZMcAqUlwvbrQrDpp+iYQmtbB3zcLJnbHrJji/L5kSctxHIbn8ogKkiyV/r0p02bWLASAKxnx2/D2+8OQd2qoOxVohg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR06MB3374.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(26005)(6512007)(6506007)(2616005)(6666004)(36756003)(8936002)(38350700002)(4744005)(2906002)(5660300002)(508600001)(86362001)(66476007)(66556008)(6486002)(8676002)(4326008)(316002)(107886003)(83380400001)(1076003)(186003)(38100700002)(66946007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uEYYVfdizEAIaPd90kpYJDizMdFb+5FUaOH1gPAn2v6jfG+sK4dGqrOd/QWq?=
 =?us-ascii?Q?YSeRm/JXsVJcRhS03yn+Pn5jZt7lfJe6r9fzImV9tkxRDrDKvvgrPkJ20hIj?=
 =?us-ascii?Q?K+EIK3fCsbXYEvy7qkJRzDGPagt1Rdom0ahlMDUUFjYPrV9+Irm/jJnFsreY?=
 =?us-ascii?Q?0MHNFX/42NpeaQSeJCRXKq4uYoAyIYrk3idcMvjpxlqhJiJ/hTvUFREngBXl?=
 =?us-ascii?Q?KjbLr5dF3WEQCXwRtnf5GOIbjiLlrMsf1fqOJLswaf31NMbBYVnd9EFU4koZ?=
 =?us-ascii?Q?WSak0udKcrLNSpovrwlUfY+82FFSRrc55o1WwOt0PeaMZ9TfapwRnqUDGuuL?=
 =?us-ascii?Q?gl4M6FhwkeDNiEiwfIFVX0jd0X/7Kf8HGeZsrAfVOdwfZrKgGVZpe8O98Zka?=
 =?us-ascii?Q?w0n8MXXckv+bHnZTKrN/qA4/2/TYj1r3E4tsoeziNA4IiccqibdHTelHJntx?=
 =?us-ascii?Q?mLJV9gxRbWgvRRL+GhaBbil1nzzrrTo+5cNl4KDWbjKQtuTCwQEM4Lzmw5JD?=
 =?us-ascii?Q?kW8QlEpPhd6EaqOdU8AptKegb34/8f6atjUTomnQ+2sN+22Wtv5vp7E06SAL?=
 =?us-ascii?Q?AoqyOSwb4QsEVTjhUWk51pQa3BkY40sGThQrA5c5CXro/3rYbWUOHCh0citK?=
 =?us-ascii?Q?da9Pz1rGhMdOwjbhYqJFekvl3hxUZr7j7ekQx7NECLEMhk3ZBsbOOWJiTTIJ?=
 =?us-ascii?Q?yTIk9ZSSTjjnl5XIEKvfQb7IEesVee2PBSEaOfUgsTwXHo98XBS7McnFn381?=
 =?us-ascii?Q?oBo2sSe+MhSGwpscJNXqpGsSV8u3uVVyWRg5vbT2BO5XzA/kLO2umnDhAEIp?=
 =?us-ascii?Q?QHUJ/nCkzugBBd2hmK/9QxKmb3L945O+suixXNbra9wbyoEwUcd4+RISmAUL?=
 =?us-ascii?Q?x1QhbvWNU4q0Q6lMdRcK6lpI2vJYelwvacK1X2/LailOc0QW20dgylo1dZYU?=
 =?us-ascii?Q?njYocTkmzo/R2Ux4bYMA6U5L/AGl6Vqc9rbArQ/SaTkN2Nj1G7ih7DLaON2d?=
 =?us-ascii?Q?uQqtF38a5W081a5YkuUdC7CIliPfhQkIP+QpZnKz3JvITUhZ0bBo2rpF26Uk?=
 =?us-ascii?Q?Npo5Lg/bHffNOdCFTUD+QYZsEK2CSX2vecCKXWdMQyiCWQXruiO9qpyf01Wz?=
 =?us-ascii?Q?kjL6tVxcxOhmAFbk85XI8suMR/aFmwQNX3sXWzGLkNXAKIHAAVMfC12XKkgE?=
 =?us-ascii?Q?e/aCnnmVT9l+/SvP195IrgMWG3MFz9ZqZInWDFybp6AcnYTFylFtEELn35SS?=
 =?us-ascii?Q?BTgWbrPqgGuQ4yde7YIi0X+XzTXNIAsZG/deg4mgIa6e40vaqJmVdpei8SoY?=
 =?us-ascii?Q?/6vxw5mX9HUyB1NdZxq4g0EhwjtYXfpPin2ujrqRA0AC7CHIhIGzoL1XMTjy?=
 =?us-ascii?Q?SW/1mbOI+FJvAATz4FxiiD19Hj6SqUG0pwc49KG+iVDM2PGw8yfHCCXXA7hx?=
 =?us-ascii?Q?W4qZAMgCsroZjh7vVF3nfGwlVv3SLHEElMIxksMrQ0gAE/zkrWBqL13DH0yG?=
 =?us-ascii?Q?tqK1LO0X68sTz7FMv5hxJufvfpkZrAIeE+boLbuvuyvHs7antovha/rL4JTR?=
 =?us-ascii?Q?eatFXAV+gB11E+qmhbl3vpPYkubezfTkEc0wFj8vLsmxQzVHRVZwGY59zd75?=
 =?us-ascii?Q?YMJ4xEQb5owXAlzA2ZkrlVGaU5SVl6nPb4nU7SSXywp6O0Tc3oI+pYcxUpcj?=
 =?us-ascii?Q?kV7mNzfAy5xiI4lnOqxfiYpSe+OToXIayu73OvxHkpP5vl/h4i39mMeyptz1?=
 =?us-ascii?Q?hjY4CVsa2w=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54530617-c08c-42d4-2784-08da34b60913
X-MS-Exchange-CrossTenant-AuthSource: TY2PR06MB3374.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 07:56:07.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFAw8owzDgGbYACR4ajKz7PNwVTbnWBsknpKDoMlvXLkfnnNm24huivYi4nGC/wrkBOmGFnOfhurUMEUoe52xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3495
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ERROR check is already in clk_disable() and clk_unprepare() by using
IS_ERR_OR_NULL. Remove unneeded ERROR check for ftide->pclk here.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/ata/pata_ftide010.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/pata_ftide010.c b/drivers/ata/pata_ftide010.c
index 2e35505b683c..0117df0fe3c5 100644
--- a/drivers/ata/pata_ftide010.c
+++ b/drivers/ata/pata_ftide010.c
@@ -536,8 +536,8 @@ static int pata_ftide010_probe(struct platform_device *pdev)
 	return 0;
 
 err_dis_clk:
-	if (!IS_ERR(ftide->pclk))
-		clk_disable_unprepare(ftide->pclk);
+	clk_disable_unprepare(ftide->pclk);
+
 	return ret;
 }
 
@@ -547,8 +547,7 @@ static int pata_ftide010_remove(struct platform_device *pdev)
 	struct ftide010 *ftide = host->private_data;
 
 	ata_host_detach(ftide->host);
-	if (!IS_ERR(ftide->pclk))
-		clk_disable_unprepare(ftide->pclk);
+	clk_disable_unprepare(ftide->pclk);
 
 	return 0;
 }
-- 
2.35.1

