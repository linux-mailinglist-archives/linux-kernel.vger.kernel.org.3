Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4C4EE6C4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 05:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiDADgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 23:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243912AbiDADfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 23:35:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2100.outbound.protection.outlook.com [40.107.117.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFC31176;
        Thu, 31 Mar 2022 20:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6NlcG5BoNUozxF4dzX3qcVjo1XVt1t6GYd3SSWjTuCGJcps59R+5Ts5kVqH2cQkQKYweEoSFK3QT7KQVjmr5pjriH4vhQlEWfktsFlMHf8eo5luOo8fHhkP2ZAy62aP6TtSsplftfXoyXGUdwFJjLYeUjno1m8+5g85piOdbJ0i+inpHVrK+7QSehQ2e7W9JZbxdgj7ksXOG72rQX77rAlbgvhNXtDOWOfG/le500uykHa75aRDE/6Hy7sjL3DlAYe6bBlaF6Zsb4vsEREIfxKRDrQdoddfMFOYKqpo1TCQDX3EDMm/QxjJT+/3h1yDrKDzwxRPUNciqLl7a/MLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=had/OLc6xnWq1lOAStM76iOLocJ53eHRH7Uav2HhClU=;
 b=GejxQOkg/XWySPhC1Eu7ux4tKr7IBCdvArvHYaTp09EHMjh03t2cN+cWeDWxypv0GpcSgQCC4v+W/ZYq7d3li+0XkXRVPU3NqFmJY0h0IN7XyXg9g48WvtqwOKToTYdQLywuDBm/CZHEMBnsB1v/+eQiZ80qSKq6mekyt9A0jyxWJ5bAB5wnPjo6aHGGWDYxjRyu9GlY5FWq48TmibyoDnkcaBP0x7+omel8Sxo+GEg6UVaywucPw8UlhFOtQiPRMX0JcOujS2j4bukVr+oXi/Hr565brqedbzYl9lk5p8AJr5GUe+gXuEy6pRQp4cx58LkvKsktdAW1rTIew7oyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=had/OLc6xnWq1lOAStM76iOLocJ53eHRH7Uav2HhClU=;
 b=WysH90oZx/f8Sa0CLJdr35eO3QqYRjhrLvFRj9/+e2T4kfIUJ9xuP+WJ6X5vIFKGFEPsJ2HrbzbtgmTDuoLl4SFgGrvdNJ9MP7L22R2Zjo0+jsyci5WN1ia1AVZvQEk0gkURdGBM4VjfqmlrzQHkyKQTTO2Vil5yy/zoipXBME8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3575.apcprd06.prod.outlook.com (2603:1096:300:6a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.24; Fri, 1 Apr
 2022 03:34:02 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::5aa:dfff:8ca7:ae33%6]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 03:34:02 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-media@vger.kernel.org (open list:STAGING - ATOMISP DRIVER),
        linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] media: atomisp: simplify if-if to if-else
Date:   Fri,  1 Apr 2022 11:33:23 +0800
Message-Id: <20220401033335.16881-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::11) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf883ccd-e69e-4708-de1f-08da13907726
X-MS-TrafficTypeDiagnostic: PS2PR06MB3575:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB35750BC720DE08D9E2960E5CC7E09@PS2PR06MB3575.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S0nDJYMoHGewblc4xrHiT0Bp4b+xuqJnhcsV3x9x4qNGUs+yepcS7AD5vOJnnbmEN3+GH0GnWVRyWQS6FPuOduH5V3QIaNC0g8kP1vjEQGPe7k4J7UHiL4y/5yuFMd4smo+HX9HDrqyxE5BspveVsxGPwx89JjlCK1mLgjdSLnOUzn2IsPwzyprQThN0qXRe8N0NK19yAOq4vZmvsM8KauIaZqRQYNntXImLWQohekS25ivS35AG+L9iUhkZaxmh60QhS0dQe26XzNJmFc3rQsL6aVYhqmfTw5dmHrAFVYNpH682lEeP7QvzJ/IPF3Z3W0m5t8RJzyyvpN4Dr+G7v3QGfY7sTVJWyGDYYTjrwkvanEev6APgrDNBkSyfFkWKHZU48r6GvLNYqa4MWo6FrroSRKdk4mbwiYM2oss65Ejq4IlIMaZ9Z+XVZm1IcSnez+SsGaQWtcSqggDD79KhPbBLyVAWjPC0+PlbJk6V916vpQAtE5bFMRsr1LVBmZjXnss2EWtOyjmS6KObrxqsyy8I5K+09nDB9avZdUZrEAOH5rKNjnrE4/r/NExcgKPGW2AwfR2v9euLFeyKZk7AMywmrpzHLvxZNCms7TJlR8tWkFgfgDjilY00/ikxvk4WTWmwlhSeQQgFXB9tz1bcQrFQPLvDOUwXpGtvR6+IkfPRY8FO4ZQpcLmn4oo+5gKGoXXOpGwdv3CgdAZUn43LyxeSb/Py9fG2Uc/ttm8TDhSwIH6OiieRT0xah5dHm6+An/YiFwfsr28ClmkKA/gPKceQJ7KTJLVhuIz+MV6Z3k8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(86362001)(8676002)(508600001)(316002)(36756003)(966005)(6486002)(110136005)(66556008)(66946007)(66476007)(4326008)(2906002)(2616005)(1076003)(52116002)(6506007)(83380400001)(6666004)(8936002)(6512007)(26005)(38350700002)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gO72/fuh3VeM2EYPcmoBdhVrJ3wYarE7wz3L0p3jxSgStL0+QySZJuUePPQA?=
 =?us-ascii?Q?+lSpJch0+BV2Xbk3hD0ZDAfR3ps9IZ8XgN56oqnbJEcFThFhiFZd6eZQtlhJ?=
 =?us-ascii?Q?GoAQS2o964ARCqgVfum2E1g11STACWT3R5LlukZ4XDDFqtgteUOTmpAgmLlU?=
 =?us-ascii?Q?w1LsjCxJxVi5u5ihj559stBGJEL5DvEsOjl3jl9B+t2D1ND3UvTrYs96l/Nm?=
 =?us-ascii?Q?YnVUjGa6XqlSS8Ll4Uzx70j1v2raB+sGNC7oUdLOsuxRFX9ndF4ZdOQ7caZz?=
 =?us-ascii?Q?ur73jEe2vTqZPYrHe2Eub8DtqYsQ+r2TWlnqflIfrQk4nchqTzSvyTtFS/8K?=
 =?us-ascii?Q?Pw1FAMupK0Uaw1bBfSKN3uawBsMKNBkv+uCNPXpsm5Qddqozh1GqQmGfr7lW?=
 =?us-ascii?Q?mA8eBHmNqCXld1siBNAMRxeyQoZjJSfGFAJ1Jwhxx60wDPHWK46lmM+XA3UH?=
 =?us-ascii?Q?aXXt21wuzMcWv0dAtN9wVOvOrgVM/mbniYWRLMNkV1UKrAfoV8j2T1myGvLi?=
 =?us-ascii?Q?HsWetE4pmSJXG0GFekP5VagFHTDy2VhRDLJqjFTHEDbw3Kk87lVzjPoRvtac?=
 =?us-ascii?Q?KV4tieOfPntgAFpELNLC/3oGsSr70VtOEkofxuBC8aFPJBKMiaRxK23Uuk7H?=
 =?us-ascii?Q?oHOjV95EsoHtbnE28C8Vy/EQZ5ltA74vxsc0Rzty+zrC9Q5n8KRfrqpoV75c?=
 =?us-ascii?Q?lyyDfW6tFkValxEFriSzigKwOruKqtff8mHspPEQvO/qefrCNyEmvjWcNHLA?=
 =?us-ascii?Q?7iDUZ7E/uIG+DLw99um84Y+SvXVyjUjPad46KXykc8ucNYkepoNAwMZoYq7j?=
 =?us-ascii?Q?gTtg1SqsuWIfCosDAh9Hcoww+k7eAWBnsAwo/C3N+d9yvNrRhUN2Zrqjq7KJ?=
 =?us-ascii?Q?dTkGBBSRHkI/EG2r8FrdOs/6ivg2xsOeqQ/+qkZT5V17ZxWcL/t+/CfqmSG3?=
 =?us-ascii?Q?EOz3qttBKz6RZ7VGXckQ/lwKpEPkvNagYZd4WXynhpJTFMaI6dLaoU/P6YQx?=
 =?us-ascii?Q?3YYEwHVqjM25/JcCwJu/xyVi9b4VyN8ZU7O5TagvXdbGgk7mKCTbxPyS91XX?=
 =?us-ascii?Q?xFrWySBIzygVldpZsrftm2FYKkcJC477Y8qq2zS6tTRdAfYKdmZSXjJ9QzNs?=
 =?us-ascii?Q?g17RYiiI1vu9floDSrIZhLq58UK1X0EAphc0orUW3XEdPssbP3Svspzxr/+i?=
 =?us-ascii?Q?l6TdKbMBTOvYwDHz2a4Z4ueZH5/KskJjZ3vbaatDa9hp/LGv+BHtUXY5mqE+?=
 =?us-ascii?Q?Qa/1FMIm5SdaY1RKdmMwGUhDvm+hhMvauaRVAcMh4lThp62NzqWMMKHl1mav?=
 =?us-ascii?Q?qK9zR7qZDtW/C6/FZzWK5ouuUibxAoUm0WNHvFhmjkhu0G5zXcBKuBx4slvo?=
 =?us-ascii?Q?HaO8tlxbQkv3pXjVHtaejipScIVINkjDN/MsSCbCKSE0S5lqSvw4ex7Ducu7?=
 =?us-ascii?Q?g1Ci2T8uapCYijGhEId2R/5XNPqGBFEKcvW96EDbIJPnp3QUp8OJgiLOS30O?=
 =?us-ascii?Q?vEp41LAiSQwuw1RSMwwKQACQJnvv/24D/FvnO8G72KkYvSSl/zREHQaNByZX?=
 =?us-ascii?Q?RgjbMYP3RQpeNx3NhBH8kDaXrxedsQOcljHwrGwq+0bYqHMnklUBlNgB0OV7?=
 =?us-ascii?Q?nT4sntNHvddx9RaJEBf4FcHNw6yMeOFPPHV67Uh5bEErafH5oElIaW3db2qG?=
 =?us-ascii?Q?4V+6ncA8h9zudTjmA03iz9jiPYAW0mhBL3p/fh908a1YNxu0zwt9skk+kjGY?=
 =?us-ascii?Q?VPcAgVrwRw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf883ccd-e69e-4708-de1f-08da13907726
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 03:34:02.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3aXPZnPwZPsdsSMSfHrlWfoqWZYE7fGIhkvDNZB2Jf6qndNkDOqLKrceInXuds/5z5Rwb+sKLsciwzi92Odlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3575
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace `if (!ret)` with `else` for simplification and add curly
brackets according to the kernel coding style:

"Do not unnecessarily use braces where a single statement will do."

...

"This does not apply if only one branch of a conditional statement is
a single statement; in the latter case use braces in both branches"

Please refer to:
https://www.kernel.org/doc/html/v5.17-rc8/process/coding-style.html

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm_bo.c       |  4 ++--
 .../staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c | 12 ++++++------
 .../media/atomisp/pci/hmm/hmm_reserved_pool.c        |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
index 0168f9839c90..ee7805c9d4e5 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm_bo.c
@@ -668,7 +668,7 @@ static void free_private_bo_pages(struct hmm_buffer_object *bo,
 		 */
 		default:
 			ret = set_pages_wb(bo->page_obj[i].page, 1);
-			if (ret)
+			if (ret) {
 				dev_err(atomisp_dev,
 					"set page to WB err ...ret = %d\n",
 					ret);
@@ -679,7 +679,7 @@ static void free_private_bo_pages(struct hmm_buffer_object *bo,
 			then, _free_pages would panic; Do not know why page
 			address be valid,it maybe memory corruption by lowmemory
 			*/
-			if (!ret) {
+			} else {
 				__free_pages(bo->page_obj[i].page, 0);
 				hmm_mem_stat.sys_size--;
 			}
diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c b/drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c
index eaf97e5f3b68..44b05b87f3ea 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm_dynamic_pool.c
@@ -94,7 +94,7 @@ static void free_pages_to_dynamic_pool(void *pool,
 	if (dypool_info->pgnr >= dypool_info->pool_size) {
 		/* free page directly back to system */
 		ret = set_pages_wb(page_obj->page, 1);
-		if (ret)
+		if (ret) {
 			dev_err(atomisp_dev,
 				"set page to WB err ...ret=%d\n", ret);
 		/*
@@ -104,7 +104,7 @@ static void free_pages_to_dynamic_pool(void *pool,
 		then, _free_pages would panic; Do not know why page
 		address be valid, it maybe memory corruption by lowmemory
 		*/
-		if (!ret) {
+		} else {
 			__free_pages(page_obj->page, 0);
 			hmm_mem_stat.sys_size--;
 		}
@@ -115,10 +115,10 @@ static void free_pages_to_dynamic_pool(void *pool,
 	if (!hmm_page) {
 		/* free page directly */
 		ret = set_pages_wb(page_obj->page, 1);
-		if (ret)
+		if (ret) {
 			dev_err(atomisp_dev,
 				"set page to WB err ...ret=%d\n", ret);
-		if (!ret) {
+		} else {
 			__free_pages(page_obj->page, 0);
 			hmm_mem_stat.sys_size--;
 		}
@@ -194,10 +194,10 @@ static void hmm_dynamic_pool_exit(void **pool)
 
 		/* can cause thread sleep, so cannot be put into spin_lock */
 		ret = set_pages_wb(hmm_page->page, 1);
-		if (ret)
+		if (ret) {
 			dev_err(atomisp_dev,
 				"set page to WB err...ret=%d\n", ret);
-		if (!ret) {
+		} else {
 			__free_pages(hmm_page->page, 0);
 			hmm_mem_stat.dyc_size--;
 			hmm_mem_stat.sys_size--;
diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool.c b/drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool.c
index 57525fece921..8b424217095f 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm_reserved_pool.c
@@ -224,7 +224,7 @@ static void hmm_reserved_pool_exit(void **pool)
 		then, _free_pages would panic; Do not know why
 		page address be valid, it maybe memory corruption by lowmemory
 		*/
-		if (!ret)
+		else
 			__free_pages(repool_info->pages[i], 0);
 	}
 
-- 
2.20.1

