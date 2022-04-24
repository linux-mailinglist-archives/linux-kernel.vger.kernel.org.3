Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EC50CEF8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbiDXDbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiDXDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:31:06 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A91815D4
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 20:28:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WN78kriZbZpsSVFXC0gyiDlBbvwHe2ucP67NJzmffIrHLQ15PhHqIbtRarNbeWgoVKgMvwts7A/T6E6CumlgmHp8Q/eI1vR++yolprkhYunBNjyzX85yxrZrC7V+Cdpr1A304G0vykbMyB6KxkUh9gMu/6ErGUU3sZ1hbUBDOx66BGNnVs9E+PsMA9VMzOyGQmukEXTh6z1ZLwF0g2LRKF++Kbul6xcQ0VSoBKYg3Zit1Slpb7CqNDoHXBH+Uz4AL1fqAdHnqb7cHqWRyLe7K66gkxSzSxR40kXUM74J/owRSfhKx0ZHL9x3C19pTTszBdHu+HJ/fYRb/c+h048HFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHxqsDccDxmcC1wRN5mxcS73GIzXKkyHnLYJUW+G9W8=;
 b=FNNvrjuGXX9cY3+zcC5jZrYdYCILp3dc4y6U4pj5iglYsDCARi1FntDC24I54veWZuY05ax+vEX5kH+iULeuU9IM47Oydlx6n8EPD8hDJnQvDaf2TYwZCdkbjXWj7kfPXZLT+ctWGkXxYBCaymx9Ion8IBFpW7vUCjfc+NVT5HXW6OX7FhqWcjx0D/s5WYpikCr3CVr1cz+eCCqduyEk2lntg6StW0SKawZIPu8/eK73E7kkbBvO9VPCgvDvIiJrIFJ2mXIWVhliZY9c41NauOgBpF5kmypugvZLw3y9lk+v1oHXmmZwGOm5uqlHwoVUBE52zwrKOk8272UpjFqC1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHxqsDccDxmcC1wRN5mxcS73GIzXKkyHnLYJUW+G9W8=;
 b=uFlMjp8jyURyA2t/+N34+s6/07ic6+KLjIVFFIoCvMrcoXpAWYVazq2cXW8xdhXbsT0SL1Vq15yVwdUGu51m3BR5MvrVyS2TeYZhS+dy1c6n10Iqv7Trz8JcvYwrXd3uANpYiBdo9nRxwk8RqIA4gG4SqcBPESdkoNt++rw3Evk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by SEYPR02MB5797.apcprd02.prod.outlook.com
 (2603:1096:101:5d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 03:28:02 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998%5]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 03:28:02 +0000
From:   lipeifeng@oppo.com
To:     akpm@linux-foundation.org
Cc:     peifeng55@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, 21cnbao@gmail.com,
        zhangshiming@oppo.com, lipeifeng <lipeifeng@oppo.com>
Subject: [PATCH] mm/page_alloc: give priority to free cma-pages from pcplist to buddy
Date:   Sun, 24 Apr 2022 11:27:33 +0800
Message-Id: <20220424032734.1542-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.31.1.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYXPR01CA0052.jpnprd01.prod.outlook.com
 (2603:1096:403:a::22) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60966777-a3ca-4092-8d8e-08da25a26fc5
X-MS-TrafficTypeDiagnostic: SEYPR02MB5797:EE_
X-Microsoft-Antispam-PRVS: <SEYPR02MB57975E4A44A0EB8489CA89E9C6F99@SEYPR02MB5797.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LfatoxbP5fG4IEpxt3/TEY1sliCmoFh0lllBJLRREayf1Z/NajPnN1iu30At8GbpZ7IUCxmXF7KQXqxE2SwIhQLdh91Z0jEoJZl3iLyaRfexmFlLmJ3wanVkzFiVjAYoblefqq1oGTfNQ8N+Kthc3HoBwTOsOmbu+jdJKOzuXy7q+0hXrKd1AjCYgHozTQEiTGVF/V9wk6DiHA2paupxM30rkVz04MD48clOfh4M3Ve9aKT+avp8jyIBNTGt0b2NszgjY/ktBATp76A/zcytCAo0rFnzFefpTwkjzTsI4YL7OFUAElbldInkluQGe0Sp1GBMCc0ZTvGMwA0t4EBjyCMJvr7ZcuCRponFOKKc5KtffVe77ODx+dt36HrlqhvnmZcVmj4bL6wURbp2ogd2mdPZSIyI65KZCFCim7fir0uf1D5rIl1RziLhBbmU/jhE7Lf5S8FCWZI65lXDC6ygagsjxZJSO1i7EozWk+VR5edfRlGTk6AuWRhY/j6EIdyRIYZb6+6ZHUd5ZgIIF8X3xxClUjqdStUZurecCd7tEebUVylTglYZqZe3VRpWSTKR+prmwRj22v1ZzGfOVm3akfgypfTcfv2bmPDb369geb0RPhPf8DaLP0XRDXLhzmd/tGPr/4E/J36fkVEnQUS2ZiAlz+3eAk35+tpdfkxQwM//0H72DZaHLEJVdWbwv6RcvKLr4X78ZssFsG7/4y9ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(83380400001)(2906002)(508600001)(6486002)(5660300002)(8936002)(6506007)(52116002)(36756003)(1076003)(107886003)(2616005)(316002)(38100700002)(38350700002)(186003)(6916009)(26005)(8676002)(66946007)(6512007)(66556008)(66476007)(9686003)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecgpZcX7PCkO/mYrmRl0aQ/XGvEwWdNymSNsqLKBYSA3/2BQZLF4CX2i7QGW?=
 =?us-ascii?Q?dW+BlW4Kn2n9Tt82oid/6BCEMS7Ds4J15PqYNKOY1F1pPOQPlrmkoeODC1Ug?=
 =?us-ascii?Q?pRNL2JHise2leDnuTnf/tkisOtpdzE6UmVko8niXUKXhALlUlm4/uRCTJ5Ck?=
 =?us-ascii?Q?GXbBwzm3wkIVcUogT23lh0cpxmxx0ZXPo670VQtNcFQkBUF6ARQihCrd1Qyw?=
 =?us-ascii?Q?JbcLAEF8n9XT6cFPzTmCyUCORFqxw25AGjhMJsTbk70fXNFMPoQZDYW5Xj/m?=
 =?us-ascii?Q?Oa19Qec1UY7ek4SAEAfx4klg2GYSGyIKtSQACPOafgsn2RxamZhdv9U5PztZ?=
 =?us-ascii?Q?A/oHHeWT5VWepoTm6XlTJEsKK2pYgcewuZOY+bNBdLkXeXBCwHE0nh7ufusW?=
 =?us-ascii?Q?qWFcz2sJsqbTab+fvzWDjJ7DVFQvSOnNH3D2cfj2hvsh9goYgSuQGpEjDoxs?=
 =?us-ascii?Q?xQnEkDaqHYlSAb1hAPs30aq1QHfNJZ1aLUWlqXgHiuImTrExquoaOHQRIgL+?=
 =?us-ascii?Q?LJ1pLpZAdaVn4HpqA9b2rWd84n6V2KBE9OnseGDMgillA7mXxLRe6gLXr0Ps?=
 =?us-ascii?Q?mUfNG91sdJmYRpM4SgI2y+xuhrDCggllAnUdvA95Cv2/L0D7FiaJInyG61t3?=
 =?us-ascii?Q?7EHn1VnycEUNCjgfUUbogxRz9lIP1lcdqa1XKvr2HBtnJidVAAIwB+ECkC2b?=
 =?us-ascii?Q?kuoiMEieq35rT2Idh4qW4rtrnf6/GMjk2OvRgbX83AhGoIEm9MoLQ4Jm6bJU?=
 =?us-ascii?Q?OHyzZh4SljtZa2mU6+lNWaH0wn6qWqc+zaIJSg7A+hRjzrTCUkTEcXTbGxhV?=
 =?us-ascii?Q?/57uoTFXSDIE++Bply+5Vf3r16FlnMPsjMWKNcN6jtnivpWyRTYomMzRmPGt?=
 =?us-ascii?Q?7EaX8rCisnX6XE9lWAQHdXojs9tZPF7BzJnR84l1VyhO1mGWBh/WRi9BTJxE?=
 =?us-ascii?Q?OWP1iYCPCO6xXUqfHBVMDEpP0duoYnqzyafmkKGlNRAyDAPcbE5MgHk0QLCY?=
 =?us-ascii?Q?ytFoYKlFSLh5wp8I1/aRg0Mg9ZOcOPHgqcRHvr/ZMhUu060MOeW61EdxjtZc?=
 =?us-ascii?Q?YShzXcIOihZoaNvrh/nYlg25iymaL1p+lSq7q5M0L26VJvD3PhuPvK4HIfhj?=
 =?us-ascii?Q?xsJFvOTaMK2q7GKr4Yf0VyFCS3o4iIW6QTfkc48IKbOCddyncms/8/0JDqPr?=
 =?us-ascii?Q?Njv0s9M+NN3GAWjbHplspzvlhURIM9yIL3cNOd6yBJ63MpvRgwcppbLp+t0U?=
 =?us-ascii?Q?nigLDO/H6jj9P1hDZXgDOYE8MWR/dejJDfGjobEuDw3c4oh5JM3tJxHo0ZSH?=
 =?us-ascii?Q?P+wgYmm44bQZUzyOhdHU3ke6jStvGROoTufbyaoKGTLwuMBIJ4hn8UHN0ECC?=
 =?us-ascii?Q?ZO53KlYJVGKjbMreOvYB4ePAr27AYsgTKVTNW20vXU3549SUgPks4fEIHM/J?=
 =?us-ascii?Q?13rE/LyT2OnV30znbA/j8CGanbG/m2uwK1MFqM26zauC4BPn/dp0yfmbl5Un?=
 =?us-ascii?Q?rJHibvZVsREVPR5GsDm57wGtSoMK8caiax9sBMUj4gGMTWDK81s8I1lJ/yLK?=
 =?us-ascii?Q?4TOEuulcVZvLn1/ah6Gzft+oHm5UAsHsI6CSxa63LMCVu/d3DPgm6Hw5PCKG?=
 =?us-ascii?Q?qkuKoKSZbzIxJKVPB6dY/I0l/WhjC/s9IpvUHMFqWb2mPphCXRFowWPo8dLV?=
 =?us-ascii?Q?xmjSOeN2Z5wGkEXPOMHdMBHaibifGpCvPdZ0HrDyVeOMmpnMgsN8VTDATHb+?=
 =?us-ascii?Q?zl9eIYA2qAJtoC4JlfxUyobpNX6LLzc=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60966777-a3ca-4092-8d8e-08da25a26fc5
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2022 03:28:01.9150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCfj696N6ejORTUIsb9JPKt+TwZCCyI58810RUHrIssfltlRbNjq6uaZ3G/XF3RHauEise6fyefa5EvKZWvJSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB5797
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lipeifeng <lipeifeng@oppo.com>

Cma-pages will be fallback to movable pages in many scenarios.when cma
pages are freed to pcplist, we give priority to free it from pcplist
to buddy in order to  avoids cma-pages to be used as movable-pages soon
if there is enough free-movable-pages, which saves more cma-pages in
buddy to decrease pages migration when cma_alloc.

Signed-off-by: lipeifeng <lipeifeng@oppo.com>
---
 mm/page_alloc.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589feb..69369ed 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3372,7 +3372,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 }
 
 static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   int migratetype, unsigned int order)
+				   int migratetype, unsigned int order, bool fast_free)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
@@ -3382,7 +3382,10 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
 	__count_vm_event(PGFREE);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pindex = order_to_pindex(migratetype, order);
-	list_add(&page->lru, &pcp->lists[pindex]);
+	if (fast_free)
+		list_add_tail(&page->lru, &pcp->lists[pindex]);
+	else
+		list_add(&page->lru, &pcp->lists[pindex]);
 	pcp->count += 1 << order;
 	high = nr_pcp_high(pcp, zone);
 	if (pcp->count >= high) {
@@ -3400,6 +3403,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype;
+	bool fast_free = false;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3419,9 +3423,15 @@ void free_unref_page(struct page *page, unsigned int order)
 		}
 		migratetype = MIGRATE_MOVABLE;
 	}
+	/*
+	 * Give priority to free cma-pages to buddy in order to
+	 * decrease pages migration when cma_alloc.
+	 */
+	if (migratetype == MIGRATE_CMA)
+		fast_free = true;
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn, migratetype, order);
+	free_unref_page_commit(page, pfn, migratetype, order, fast_free);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3459,6 +3469,8 @@ void free_unref_page_list(struct list_head *list)
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
+		bool fast_free = false;
+
 		pfn = page_private(page);
 		set_page_private(page, 0);
 
@@ -3467,11 +3479,19 @@ void free_unref_page_list(struct list_head *list)
 		 * to the MIGRATE_MOVABLE pcp list.
 		 */
 		migratetype = get_pcppage_migratetype(page);
+
+		/*
+		 * Give priority to free cma-pages to buddy in order to
+		 * decrease pages migration when cma_alloc.
+		 */
+		if (migratetype == MIGRATE_CMA)
+			fast_free = true;
+
 		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn, migratetype, 0);
+		free_unref_page_commit(page, pfn, migratetype, 0, fast_free);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
-- 
2.7.4

