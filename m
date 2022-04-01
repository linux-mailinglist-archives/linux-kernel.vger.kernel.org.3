Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B124EFA34
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351432AbiDAS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351441AbiDAS5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:57:55 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A6016E7DD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:56:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JFVXdFm5bGbJH1OewLGUr3mLCPx6daSVl///+qtGgjhTDmDBI6P51zqyPn6d4UvKqBCLkNpQb25yVEWevKgT6cfEXqirWmUlnvNRzL/6O1lq6TDJ+yxm8T/NxQvcLeMSIA4fJdqwt7Srp++dYzZBwGXrM2urrHmnraiC0eNm4TSQum1v6J7PlUTLlkwF9D0GFcoxuD4RipLMkVImqM+ymNlufL/eVD4Hnq3yDQ8YVlD3mMKcqHJbK8MP5sS3FCzBF1/ZtFDNVcFodQFYZnFNJGMpYUCTTC9NN5hkY5/xudS3IR6G8CznLcgJREikvTODRJ40rhVrfij3tOruVQlDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMJ8//rgdER/XrXY68/Ukia0FvIOYP7//D1ZwCcnep0=;
 b=YLsZ4CW3Oervvow327GcHoyCDNEARwIkjVNUjsjGtyAC6/Dgzf81XEW74at0KjXinZT140rQJ0fxF/lUBP1S2yRtAkzaphr80lCBJ5dS+TI9hDWJK7hQMY6t2vOvU6KsCAj1SknlzstMTattxyXz/x5XqBFB1nvUSqRGCajARPZirAC+Gb1lxjVJ0zYhqAghsakUpJddkzosu7yw595+6xvQVZCxEG4VFMo9sE/usEI0nZN4JQNkh4p3rctv6uAmNAdQ2GhEYRSC9H7gxcOFmoOCBXa90+tv9w3Ry2JBCRrH4/CD2lrG5mv94wbsmSr8AOPOD/EnVZjOKkEllU6Urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMJ8//rgdER/XrXY68/Ukia0FvIOYP7//D1ZwCcnep0=;
 b=lwuSkIpuSS11l6KYafuEqGA3OJBFivl5R+FLEN/bBA6QoBKSkmbv3TTJHAl/Zvkh8UBPNfUJe4j/Qk9xl+nCyC/BU4y9ai9dOk1dj4TnBrjNme+yYToaLbE249r5239mO1HR1RKLAm6VssOBj0cYEz20X9Tp2G6aQJV3zXQ/OesdWdsCy5YxARTT+C7FJf1e80K6yxLDLrrWJXX8USCFXUY2qyo/F+oFuR1v2v9BS4zPlh7ER+wRP/V7Sn18zqOnFmn8JLxNx4YDNimrY9nKSjmxsz2Ag/SOLhZN9CWNNBbCOA/2KIEszeFLHuz03aHhh1wP7uhseu0B01f7iUeiYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by DM6PR12MB3595.namprd12.prod.outlook.com (2603:10b6:5:118::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:56:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::69f1:dff6:826b:7d9c%5]) with mapi id 15.20.5123.025; Fri, 1 Apr 2022
 18:56:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy page validation.
Date:   Fri, 01 Apr 2022 14:56:00 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <ADC113C0-F731-4835-AE3E-87C2302877B5@nvidia.com>
In-Reply-To: <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
References: <20220401181109.1477354-1-zi.yan@sent.com>
 <20220401181109.1477354-2-zi.yan@sent.com>
 <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_7E592772-0EA7-46CA-9FA2-E329784FD3DB_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:c0::26) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0532b8a-23fd-46a1-0d59-08da14114475
X-MS-TrafficTypeDiagnostic: DM6PR12MB3595:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB35952BD3D50C589489694FFFC2E09@DM6PR12MB3595.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8Sm/eNCFyU26W5GO0xVnzDXIxlYKmMg12JLrIgXiY82UUpBBXF2I7O1vxXooRYVD7BoiArRo3iZKe1X4vEvphbwCADq++RDpPJNXdCbngRoZsk/50KjscfFAGxa6XCn//KzcjSM/7Z0e52xHMMegQ73uz/lzV1ACMgfeTq/6j9QbMURb/gOcKB/jwcr3rxgl783fYt9ZpOWxy3qJukEj6CJQwA9RhUdx7rUqy2jVyAm4zeJQBvjGnl8s7RYFyJK2AG5fJpGxurDOnj0rMdOCr5CbQ+0fUdC9UTDr0ACE7Bwh/oChA3NFQX41kq0jKV3kp2/TNaGgM24KukncRYpmHka/RtxRcSLRbrNTR8/hL4tYxrvr8VhhFiAXaduYuIPcgMuq6DicBqoUCTZd2zVs7Gz9Z+ObKfJPxtt4lE4oZLSq2Fi8gTpovUY1xL4xJ0O3xSWLrAZXjcBDpvE2FoszmQPcswYNlENL0zHfdgkG5hLswSZZmEKx0i4NNY5ZYVqTlTl/byKAfBPex9GfmLVUzMzdi0TKIQPGUlFs3Pnw8MNgX+CPCDuqsFgbkdJIczEhhC/jaMUJ6E/Xmuzkn3UXQ20SNndkBVzoCF2QKWzL0PoRP42x1cfd5XdubNSPPH2Xpo9ojheDibwlSjyHR24F5Yqa+F5d9FiKiTIsYO8jpXDV9gKuDuWesAJcGEjqZ5OJU3IDIRxYlkeL/MTUPfxlV1RbvONzTGjqUD5609GHao=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(66556008)(7416002)(6506007)(6512007)(66476007)(33656002)(53546011)(508600001)(6486002)(38100700002)(8936002)(2906002)(66946007)(4326008)(235185007)(36756003)(86362001)(54906003)(26005)(186003)(83380400001)(316002)(2616005)(5660300002)(21480400003)(6916009)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RYydQv5dVSSaNj4JsJGxl6YBZJVXq3LgYQ9jmEJyX99+pcob5pmL6n37qix/?=
 =?us-ascii?Q?T1N8N/zQOe2OlINJuV44+0fUqd4/aVQ5lFLNrM8afLFwY7GIChsHktmQsjbw?=
 =?us-ascii?Q?d9YYARryQ+S6iYkQ/rhajgJokWnz8ar1ZnIJSK/SFD1pVHLxjGg4RSFyyYFa?=
 =?us-ascii?Q?3JoF+2wth1VWhpWKC6dXDfSqoOFvYuXrl20pfjzzbOJsUk6/beFPhzgpU0RK?=
 =?us-ascii?Q?FOBewbYeJc3WEryXkfiBPhy1I+oIu29Kt4s4b5IJJjDFyxRkIkdK6Rh7+f79?=
 =?us-ascii?Q?7HdE3/c79b0ecMmMHEZrYxZdrAUFtVcrwr8eG6Z5A3fyOw9KIB9sZFk2S0nU?=
 =?us-ascii?Q?+dgdeFu3+8TOko4G0FGEqmM7lz9NpIFBBmu5yGPTAQ99jQvsQNn8W3MfP0ZO?=
 =?us-ascii?Q?LjKiGmATEXr6hfcVBEe955uYenBKQr3t/ojCXUys19qZZaTqjKuacWWRI+5r?=
 =?us-ascii?Q?tEf55+PzFTg9NKiztNizDFRxAGK/cu+5RncP2IUFM8F7VAQ8jMuPIabiSOtO?=
 =?us-ascii?Q?pdapTinwRnb272gvLYpOdotwoe/rTpxrG5OcWGti5lNmDgJrVn7N/naT5/Ub?=
 =?us-ascii?Q?xpaucWJft511X3i/9gJphxSH/WWYkxX+XyYOmhng6HwUPmuPaiiphmye6grl?=
 =?us-ascii?Q?foZYrLg8l7xC1TIp+IrLLnn+j0NGM6L4Y7KBeDgyR3KcVanbxrSyTEQMEWc6?=
 =?us-ascii?Q?H6T6f+I8GcjAqLd+4pd7sZqT1fyiyNwWH0gWbUejM6R8FpqW5iSWhYcFk4go?=
 =?us-ascii?Q?xTmhzXrzeH/GYREtysNZeH65z10QkOIZVnXbxjP/WGFvNWKSEVFBOn9YoxSs?=
 =?us-ascii?Q?zntDc7EzN//573ozDaAZztAr8KJs5V++E8S36MEiNYeX2sXVUnTM4HLgy4Fh?=
 =?us-ascii?Q?OaaetKTfPTSC/jCQ5hWj/uzAfzwtTWraId9vUufnFcqAYDtN0dnTN1OuaP/I?=
 =?us-ascii?Q?PSi+QTLjQzPBVbkLoYrR7t7iCxK6ScL8bwZHBSa/x/GHNn5sphPHLqDL68b5?=
 =?us-ascii?Q?PMpKTC0GYcSsSHeukMFh9EnfSAdQK1XqXUv2QZNJFiWl20WZXcx97yE2voy0?=
 =?us-ascii?Q?Owi8cR450jhMgoFoz7BR8TCNlbw+UPMP864/Q7Mvam3oeqAXhkUcp4FplDgi?=
 =?us-ascii?Q?q1RVj8uUmWRjY56TGxqj6Ei3gjUFxi7Klu1tZoS2L6T5dr8P/l5zyJoVaXTA?=
 =?us-ascii?Q?GdbEBfJ5QMMsPu6FdRHENb6jv+Xc4fMapJI+og8k1UmdPwl9XuPaRjD+qBHr?=
 =?us-ascii?Q?t9Me0lpliaslqCkZ4uWeBdCQkRvloUfaKVsub2e4PbZTnXsmmA9ekklmfwbc?=
 =?us-ascii?Q?uLS0DpTD+ylI4E34INjsoGD5r8BLq16mOrnXYw8pjsaCBWSBqujDcM9WXcTH?=
 =?us-ascii?Q?xXesrUCArJa4uo2GLZxGjH9grj7JBR7UrE68nCrSXSM5TgtvcjcsjYnavUUB?=
 =?us-ascii?Q?6KVk6JkI8B3/teb1GErpUrKszwUlPlskzx7gPGRjr4GU1peE4t0Vd9jjwVem?=
 =?us-ascii?Q?B5tUpDTRq29kkuqWXCwz3SsZ8ZmEBLruD5lXB1Sh0Xq0jU+D0Pw4Il7mZI4P?=
 =?us-ascii?Q?8GC5/XPOGxQwOHjYoIdT1ZCHFEeplUXsKKhGGuLD9BLHRWK9kCCis1KsYTLs?=
 =?us-ascii?Q?wL1ZuOvwecauo0wwtKcNcdwC2fzz7KmcGgjNw3FXznhzFXPqI9UjpIQU+JMQ?=
 =?us-ascii?Q?Ei3upBMc9nT+oQS6rY0EwM7LjpSCXac/WNRjvKoOiJefUgQr+rDo678B031d?=
 =?us-ascii?Q?jrh5TVH6dQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0532b8a-23fd-46a1-0d59-08da14114475
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:56:02.3430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2v/7sRVj3a5dw/bXNYjGvoB6JAyhlVAoLT2qf8/zlTpS8Nojacg96xQM5QGWVPs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3595
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7E592772-0EA7-46CA-9FA2-E329784FD3DB_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 1 Apr 2022, at 14:29, Linus Torvalds wrote:

> On Fri, Apr 1, 2022 at 11:11 AM Zi Yan <zi.yan@sent.com> wrote:
>>
>> Whenever the buddy of a page is found from __find_buddy_pfn(),
>> page_is_buddy() should be used to check its validity. Add a helper
>> function find_buddy_page_pfn() to find the buddy page and do the check=

>> together.
>
> Well, this certainly looks nicer, except now:
>
>> +extern struct page *find_buddy_page_pfn(struct page *page, unsigned i=
nt order);
>
> that 'pfn' no longer makes sense in the name, and
>
>> @@ -1075,11 +1118,11 @@ static inline void __free_one_page(struct page=
 *page,
>>                                                                 migrat=
etype);
>>                         return;
>>                 }
>> -               buddy_pfn =3D __find_buddy_pfn(pfn, order);
>> -               buddy =3D page + (buddy_pfn - pfn);
>>
>> -               if (!page_is_buddy(page, buddy, order))
>> +               buddy =3D find_buddy_page_pfn(page, order);
>> +               if (!buddy)
>>                         goto done_merging;
>> +               buddy_pfn =3D page_to_pfn(buddy);
>
> This case now does two "page_to_pfn()" calls (one inside
> find_buddy_page_pfn(), and one explicitly on the buddy).
>
> And those page_to_pfn() things can actually be fairly expensive. It
> *looks* like just a subtraction, but it's a pointer subtraction that
> can end up generating a divide by a non-power-of-two size.
>
> NORMALLY we try very hard to make 'sizeof struct page' be exactly 8
> words, but I do not believe this is actually guaranteed.
>
> And yeah, the divide-by-a-constant can be turned into a multiply, but
> even that is not necessarily always cheap.
>
> Now, two out of three use-cases didn't actually want the buddy_pfn(),
> but this one use-case does look like it might be performance-critical
> and a problem.

Yeah, I should have listened to your initial suggestion. Thanks for the
explanation.

How about the patch below? If it looks good, I will send v3.

diff --git a/mm/internal.h b/mm/internal.h
index 876e66237c89..754a666e5785 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -211,28 +211,8 @@ struct alloc_context {
 	bool spread_dirty_pages;
 };

-/*
- * Locate the struct page for both the matching buddy in our
- * pair (buddy1) and the combined O(n+1) page they form (page).
- *
- * 1) Any buddy B1 will have an order O twin B2 which satisfies
- * the following equation:
- *     B2 =3D B1 ^ (1 << O)
- * For example, if the starting buddy (buddy2) is #8 its order
- * 1 buddy is #10:
- *     B2 =3D 8 ^ (1 << 1) =3D 8 ^ 2 =3D 10
- *
- * 2) Any buddy B will have an order O+1 parent P which
- * satisfies the following equation:
- *     P =3D B & ~(1 << O)
- *
- * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
- */
-static inline unsigned long
-__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
-{
-	return page_pfn ^ (1 << order);
-}
+extern struct page *find_buddy_page_pfn(struct page *page, unsigned long=
 pfn,
+				unsigned int order, unsigned long *buddy_pfn);

 extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
 				unsigned long end_pfn, struct zone *zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ea106146686..8195b4f64ec5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -998,6 +998,57 @@ static inline void del_page_from_free_list(struct pa=
ge *page, struct zone *zone,
 	zone->free_area[order].nr_free--;
 }

+/*
+ * Locate the struct page for both the matching buddy in our
+ * pair (buddy1) and the combined O(n+1) page they form (page).
+ *
+ * 1) Any buddy B1 will have an order O twin B2 which satisfies
+ * the following equation:
+ *     B2 =3D B1 ^ (1 << O)
+ * For example, if the starting buddy (buddy2) is #8 its order
+ * 1 buddy is #10:
+ *     B2 =3D 8 ^ (1 << 1) =3D 8 ^ 2 =3D 10
+ *
+ * 2) Any buddy B will have an order O+1 parent P which
+ * satisfies the following equation:
+ *     P =3D B & ~(1 << O)
+ *
+ * Assumption: *_mem_map is contiguous at least up to MAX_ORDER
+ */
+static inline unsigned long
+__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
+{
+	return page_pfn ^ (1 << order);
+}
+
+/*
+ * Find the buddy of @page and validate it.
+ * @page: The input page
+ * @pfn: The pfn of the page, it saves a call to page_to_pfn() when the
+ *       function is used in the performance-critical __free_one_page().=

+ * @order: The order of the page
+ * @buddy_pfn: The output pointer to the buddy pfn, it also saves a call=
 to
+ *             page_to_pfn().
+ *
+ * The found buddy can be a non PageBuddy, out of @page's zone, or its o=
rder is
+ * not the same as @page. The validation is necessary before use it.
+ *
+ * Return: the found buddy page or NULL if not found.
+ */
+struct page *find_buddy_page_pfn(struct page *page, unsigned long pfn,
+			unsigned int order, unsigned long *buddy_pfn)
+{
+	struct page *buddy;
+
+	*buddy_pfn =3D __find_buddy_pfn(pfn, order);
+	buddy =3D page + (*buddy_pfn - pfn);
+
+	if (page_is_buddy(page, buddy, order))
+		return buddy;
+	return NULL;
+}
+
 /*
  * If this is not the largest possible page, check if the buddy
  * of the next-highest order is free. If it is, it's possible
@@ -1010,18 +1061,17 @@ static inline bool
 buddy_merge_likely(unsigned long pfn, unsigned long buddy_pfn,
 		   struct page *page, unsigned int order)
 {
-	struct page *higher_page, *higher_buddy;
-	unsigned long combined_pfn;
+	struct page *higher_page;
+	unsigned long higher_page_pfn;

 	if (order >=3D MAX_ORDER - 2)
 		return false;

-	combined_pfn =3D buddy_pfn & pfn;
-	higher_page =3D page + (combined_pfn - pfn);
-	buddy_pfn =3D __find_buddy_pfn(combined_pfn, order + 1);
-	higher_buddy =3D higher_page + (buddy_pfn - combined_pfn);
+	higher_page_pfn =3D buddy_pfn & pfn;
+	higher_page =3D page + (higher_page_pfn - pfn);

-	return page_is_buddy(higher_page, higher_buddy, order + 1);
+	return find_buddy_page_pfn(higher_page, higher_page_pfn, order + 1,
+			&buddy_pfn) !=3D NULL;
 }

 /*
@@ -1075,10 +1125,9 @@ static inline void __free_one_page(struct page *pa=
ge,
 								migratetype);
 			return;
 		}
-		buddy_pfn =3D __find_buddy_pfn(pfn, order);
-		buddy =3D page + (buddy_pfn - pfn);

-		if (!page_is_buddy(page, buddy, order))
+		buddy =3D find_buddy_page_pfn(page, pfn, order, &buddy_pfn);
+		if (!buddy)
 			goto done_merging;

 		if (unlikely(order >=3D pageblock_order)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f67c4c70f17f..4fbd27ba91c6 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -70,7 +70,7 @@ static void unset_migratetype_isolate(struct page *page=
, unsigned migratetype)
 	unsigned long flags, nr_pages;
 	bool isolated_page =3D false;
 	unsigned int order;
-	unsigned long pfn, buddy_pfn;
+	unsigned long buddy_pfn;
 	struct page *buddy;

 	zone =3D page_zone(page);
@@ -89,11 +89,9 @@ static void unset_migratetype_isolate(struct page *pag=
e, unsigned migratetype)
 	if (PageBuddy(page)) {
 		order =3D buddy_order(page);
 		if (order >=3D pageblock_order && order < MAX_ORDER - 1) {
-			pfn =3D page_to_pfn(page);
-			buddy_pfn =3D __find_buddy_pfn(pfn, order);
-			buddy =3D page + (buddy_pfn - pfn);
-
-			if (!is_migrate_isolate_page(buddy)) {
+			buddy =3D find_buddy_page_pfn(page, page_to_pfn(page),
+						    order, &buddy_pfn);
+			if (buddy && !is_migrate_isolate_page(buddy)) {
 				isolated_page =3D !!__isolate_free_page(page, order);
 				/*
 				 * Isolating a free page in an isolated pageblock

--
Best Regards,
Yan, Zi

--=_MailMate_7E592772-0EA7-46CA-9FA2-E329784FD3DB_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJHSsAPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUwlAP/1eFx2VsYpCbZ+6c3V8MMv6upKWP3qvaMbLE
WyzeNHoW+M8P0gX4HfgLJ2A0jik/WqY+Pgwnf86AJOBJ1ghWuoWwzQh3CwWHOtrx
GexjXqFUiNuWsDH3IIH8JB1qxRrHFLA4QucBh2OuEbXxuuk/KZNVG0Evt+SSLVRr
Ey8LDUVgLa2XYq0HM9NelK3sPKWVqI5mRFa69dDRQolsGhywYQwgm2EymcfXKXQ0
YuZ7ti8M8ic3diNaTs7qLhlPzhNMMlQt1SISFHzYyMvXlovoT8Jhp2WMaxEDu758
IOnxZ2l1Fz1F05tjGb3NBFUtP7+0Wq4264QqYu9Y66/CBSkgswzsiftLXfbpCQGi
hH8+bH7rT72dguaixHRgvMtzoMpqsLx6qqqlJbWvJuOjdlu4FNbNr+kZQDcSSpf0
I8f74U/R/GeFo6T18VlMKpQIR/wXecwovvRdy5/1QfI2N4CYE8azEZCpH8pHYw9+
5BzbQmCCvKkCHK+VomayBV7TrrnMEvpEYHrmtnxxeriCbs7S2YetluiAheLs7B8I
xrXUiz1zQrw6b1weoYH5MskmLY+/VuZ0V9Hp8PgUqSn5UJwbbyHYLUBGV4vMWsfU
HxTUgWtRjIbe+VqZURDuEEpNFYzY1HoeqA6tbwsDBvZDfOyWFpNeI80SmWjcY0lc
OWSIMThu
=wJUM
-----END PGP SIGNATURE-----

--=_MailMate_7E592772-0EA7-46CA-9FA2-E329784FD3DB_=--
