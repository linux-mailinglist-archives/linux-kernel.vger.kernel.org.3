Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4F25AF0FC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiIFQpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbiIFQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:45:26 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE3126AC7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:25:08 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 286F2kGP004237
        for <linux-kernel@vger.kernel.org>; Tue, 6 Sep 2022 09:25:07 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=lO1LCWnS1yVG5gvCrMV1M10NtOqvjrS9p6wb+7+KQI8=;
 b=BVy/5ivLRt+mFaLZKoM6wAnLYSOWbY1D1xhFQQiulUdf7UXTXlSAZwSqMNSojGqaxbvn
 YIz/6tKKWfeocbZ1sAC8OyV6KcNxHGR+dmsghGEf1XYUvNESOAIa5GZ79SrETiPPXLXm
 R4C/9YIK6xg3jk6IsXs4kWPilwYAAlTxByQ= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by m0001303.ppops.net (PPS) with ESMTPS id 3je3j3tfex-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 09:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZJp08geRAE+tTBs7ZhyFn9341F0nM7fsdtDe3tFOq16ToSwZ8XWssCyzyq+kKjzMv6ooKZEa1gw9lmWZMDZQIY9JG1HhmCK0Xgf162YaczLx3db19VJP34v6STDDD2deBVNBgQoL0+QIJ+O0GQCulKsYbSSYLmjXyp0CRlSqTCjxMQtsxWyL5VaoKvMr1x2Uc0zIaAwWYdH1tJJ050dw833qb1aueSkSHPpGNtDbl74kI7Yp/V2NEHO0quLdWbMfm3SctorRy+nDZM4DA5s5yorullcUFyzeyoHicoHMSfpdNxz+GJalGTiMu0bA6/vTX2a2Y/Oc1yoJ3qNbUlesQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO1LCWnS1yVG5gvCrMV1M10NtOqvjrS9p6wb+7+KQI8=;
 b=c10jxwWPUHJ0jwWJZjkRZz1UrFoGxX1iftLDBX35yYKcrNxjFLBho64Dmi0f8p5IVjTDilOBmsTQzLgJl0pR5lWluiudJHOouqW8c6bO2wza3yReSuLj6GkGzaBScqjUQWTgvxnZhqqBu1YaWvzAlKpcegcSGZe1eopFiCmSL0C5PlVRQVwu3rRvqFLuhEJIV2LTYMbpjQ/7Pww+VuCmihN5K/oNDWOX0l+yY4mYjYZ7Hf1czFH10e5G3AgNjcmdGAbed0YRpU/xtZIRHufTCbJX1N0IzI6+HL8xX6rg8aauqLq+r8XJTPrIzOJEaR5G4TE3toGNYAsjwR+Zgg02mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MW3PR15MB3913.namprd15.prod.outlook.com (2603:10b6:303:42::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 6 Sep
 2022 16:25:04 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%8]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:25:04 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Song Liu <song@kernel.org>
CC:     Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Thread-Topic: [PATCH v2] mm/vmalloc: Extend find_vmap_lowest_match_check with
 extra arguments
Thread-Index: AQHYwba/hVvX1LqPTUiZhj3kW88u+a3SlwGA
Date:   Tue, 6 Sep 2022 16:25:04 +0000
Message-ID: <75CD7F46-F419-4D93-B59D-A8C0F942BB91@fb.com>
References: <20220906060548.1127396-1-song@kernel.org>
In-Reply-To: <20220906060548.1127396-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29898511-e06e-4ef7-b1c0-08da90245b1c
x-ms-traffictypediagnostic: MW3PR15MB3913:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7wIdvlDjBZlz5qA3zVa9lvX//GE1XnFJkqnPpvyzQ17wvT/Q85OggCG1uuBsOwWAOpimuD2nIdEllr0el+7dYO0HxX8AcHyFPQXl/OMqsgAyEk1HlEVQ19LVMnGBKk0DSDEQfjjz43S4v47AyiwHuw4KutQ2o7t9IxQIjJRIqj1NGTo8+hICCSVVGkQPF1HL+UMCgERVX511se0s/rPpV6bjVEyCnAER2xdeOvatlD/ZMbYmimmHhMjHJlQ8SJ2nXV5TrtIhmhZn9cluLDs51N3U8bt9aoNb6QhpjvOefcDoxOffC0W37Wfsn+ThxeHetUeBjZPi422lKQnWNi4LWrmJGDnnYO69Q87Ypu2Gk+s8ijvwNxrVCkTNWhGsWDAv8sZAXwJUFKwwjxaP2QO/xGqED3L1Br5d5i4v3F23n2VJx96mNkv2z5WPWATVgt/SoW2XAk2Mf+7Yo050nuLSS8SbgA6WhHaHU7krwhvPrkpl8n2HidXqPZr9VYO8N3PR+TGIbovlewQkNhpOvSTVpTGXe3CDWO7IzzG7GeZdAV2XrpkIXZ+MpM7jJaNGzRTM1sczZEAFra+cVTKfrM0JiFjiP1r7t6fn/tmIpf4dqg8jk8S74SD/5GfDyCVep87OV03P3MdzB7vjpVFlfNV1r9z09jIDjog1QkJVs513IpwCRmgaOZVzd+k3P3+c5nP19Xeit1rprwzu+8dn6cZuYGRUu2W4fz/IUWXW4xJi27pdfpLPj34WaeQ1GENaVDPDZH5EhcqGnO1Vvv0nRr7rhMmW3OwLTuYlWjyMImZaVKA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(71200400001)(41300700001)(6486002)(478600001)(6506007)(186003)(83380400001)(53546011)(66446008)(8936002)(2906002)(5660300002)(54906003)(316002)(2616005)(6916009)(66556008)(8676002)(64756008)(33656002)(66476007)(76116006)(91956017)(6512007)(4326008)(36756003)(38100700002)(66946007)(38070700005)(86362001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?R4UgOIWYfsNGY2gb0NQcgoc/OZN+yKvRq3VIPgC473nPUZ74jaI5HI3iu/ua?=
 =?us-ascii?Q?t+b1x2X/GOKUyHm1zMTPhYjgbfF+3QmqhwViUa1YPPpS5x31/AYBS7EjytG1?=
 =?us-ascii?Q?rpAhxmuU2Gn18Adti99+fWmlyZH+hZ2F39UGIcSNsdKz39ZnQg7bsMer/Dld?=
 =?us-ascii?Q?8R66Ii7eA8H+6K6y5vcehXgRrVWJfuhh0M6Y/lt+PlorWpmx+FLD3Gw81Wkc?=
 =?us-ascii?Q?aLtfWhSJmCBcJE5Kcc7POFJtoRnRGeEqVVx25TxbGgSXZbsjcb3VnRvu7cfp?=
 =?us-ascii?Q?x5v2veavybb/lP8QIbnIqwF5e8h3GL615Yyk6ah34Yj/LKf/+qbVevujIbBe?=
 =?us-ascii?Q?S2j/Bg4NIdD1k/isAMOKo6A34MG2tss+p2/4wyA70LlcaXzUU2syocFYOljW?=
 =?us-ascii?Q?FMAwmiA3HBYiDJMqhvbN0sXhvKAiJCmUgf5tDJtUY+4osGFnJ3r219kuAwX1?=
 =?us-ascii?Q?h3Wpmm7vrLurTgw6XE/Yu5K3JhkKMfoX+eDQ037UK3MzTbUdfgG0OuF1Dn2O?=
 =?us-ascii?Q?CTdwobZF+88htXLMAy++4UIKAnB7spK/hO2hr+qrfQyzaZOg5ORXhIRtO9TI?=
 =?us-ascii?Q?uuKYBpmdLXfVQc0AbjXc4BjJDxiCT2EowJy+ep5dugIIFztt2+PLLjYhRhyk?=
 =?us-ascii?Q?/SFyak1yNICDISdP4IPDfCkKq6MfF1LPUkP7+ml0oU954/+rz88WfQ4obMat?=
 =?us-ascii?Q?hy5VTGnyMk34TWkuJmFI1h87mH+89TMWFToQoVd6TIvD0+T4k0awB6erbs36?=
 =?us-ascii?Q?HQMLQWAZagAlFAC0EIS2FnVYZ2LJldC8NEgwj7Ov04OKrWNslKyT1dxEZDtJ?=
 =?us-ascii?Q?z3NROpGhTaGnJqO68egizbDi4KEd9IYhiSGd8jBNmbeyuzl7J9vXq2VAF6QG?=
 =?us-ascii?Q?26FiyD3hK+9yc78MIuoiASp4CT+I1yeS1zi7CdVtIdqzt2dG5R2M0wQAeOqr?=
 =?us-ascii?Q?A3tYWJnbFMWeNJBkgcHXvHVgINuGM9yLZNoMJkd/CdjL//y5MvpNi8QfrRQG?=
 =?us-ascii?Q?N8UU23gARZr1NmpBmt9lSKr/6JxuYxcxG7HY0wHPZ6t3HwFMzSYJWTX7oKv+?=
 =?us-ascii?Q?1IzhV+LXjhnqhSJFSIWi7e2CN91kihePTLwPQpA820LeaQA2NRsIe/fI/wOz?=
 =?us-ascii?Q?A5CCVIisXFg3Jc8uvWR81NX7DIKJ1gUVekQ8PAn7r7bRk2pJx2mu5Le9lJfF?=
 =?us-ascii?Q?7bsJ1s4WTZmti0yWRFA8Tn0+OvJ7KMan7eR07cDmy2RDU5C1dYcxWLMK/t1s?=
 =?us-ascii?Q?uVBPial02eJ5UV5bnQyPXkL3KU9LYVWD1VqJuvS6LZ35oXI/TX8LQ9mY59gD?=
 =?us-ascii?Q?ELOnC5jEhss/O4L5sWWQpojoX7R6gpP5bBZZ9NUVQDD6xxeyVLIQtpBMMCfa?=
 =?us-ascii?Q?PYdtcdEY7MbXUgQANuwoS8hjtRDfkuXtITb06JGM+tib7Mqh8eDo/M7RmXBf?=
 =?us-ascii?Q?OukUZNBuqTSayebhIJv1K7HkXy8GxrNO7OKoSIDyIgzzbDwE54OZqpu5YpEz?=
 =?us-ascii?Q?Tx32zv7QeVC+xZNh/WsODvHhNe1Gr4fqOEggi8Y61JJTmJgjo1yWtHH4XfKq?=
 =?us-ascii?Q?FJDi4qfitzOOxt5MWEcdoGz6+u6kghcP76Z3gveKVPUBo9CPjzeSReB1O6uj?=
 =?us-ascii?Q?xXCl+uPe/thYh+6HlPABRUs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A69ED13320AC9419DCFF642E8685134@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29898511-e06e-4ef7-b1c0-08da90245b1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 16:25:04.7863
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R4hZw5WBn+zG+JTvGZIdYwPEYZAnjdvFBIYDUMTpL+mbDE6X7PV++K+yeUymjS48jDYrjJhPgOMfpbx2zuokow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3913
X-Proofpoint-ORIG-GUID: BdFy5DcvjtbPiJDMnPo9GVGOUzj9Tx5V
X-Proofpoint-GUID: BdFy5DcvjtbPiJDMnPo9GVGOUzj9Tx5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 5, 2022, at 11:05 PM, Song Liu <song@kernel.org> wrote:
> 
> find_vmap_lowest_match() is now able to handle different roots. With
> DEBUG_AUGMENT_LOWEST_MATCH_CHECK enabled as:
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index e68c0081e861..7552f1f8350e 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -713,7 +713,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
> /*** Global kva allocator ***/
> 
> -#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 0
> +#define DEBUG_AUGMENT_LOWEST_MATCH_CHECK 1
> 
> compilation failed as:
> 
> mm/vmalloc.c: In function 'find_vmap_lowest_match_check':
> mm/vmalloc.c:1328:32: warning: passing argument 1 of 'find_vmap_lowest_match' makes pointer from integer without a cast [-Wint-conversion]
> 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
>     |                                ^~~~
>     |                                |
>     |                                long unsigned int
> mm/vmalloc.c:1236:40: note: expected 'struct rb_root *' but argument is of type 'long unsigned int'
> 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
>     |                        ~~~~~~~~~~~~~~~~^~~~
> mm/vmalloc.c:1328:9: error: too few arguments to function 'find_vmap_lowest_match'
> 1328 |  va_1 = find_vmap_lowest_match(size, align, vstart, false);
>     |         ^~~~~~~~~~~~~~~~~~~~~~
> mm/vmalloc.c:1236:1: note: declared here
> 1236 | find_vmap_lowest_match(struct rb_root *root, unsigned long size,
>     | ^~~~~~~~~~~~~~~~~~~~~~
> 
> Extend find_vmap_lowest_match_check() and find_vmap_lowest_linear_match()
> with extra arguments to fix this.
> 
> Fixes: f9863be49312 ("mm/vmalloc: extend __alloc_vmap_area() with extra arguments")
> Cc: Uladzislau Rezki (Sony) <urezki@gmail.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Song Liu <song@kernel.org>

Forgot to add the following from v1:

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

> 
> ---
> Changes v1 => v2:
> 1. Update commit log to show the error with
>   DEBUG_AUGMENT_LOWEST_MATCH_CHECK. (Uladzislau Rezki, Baoquan He)
> ---
> mm/vmalloc.c | 13 +++++++------
> 1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index dd6cdb201195..088b421601c4 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1300,12 +1300,12 @@ find_vmap_lowest_match(struct rb_root *root, unsigned long size,
> #include <linux/random.h>
> 
> static struct vmap_area *
> -find_vmap_lowest_linear_match(unsigned long size,
> +find_vmap_lowest_linear_match(struct list_head *head, unsigned long size,
> 	unsigned long align, unsigned long vstart)
> {
> 	struct vmap_area *va;
> 
> -	list_for_each_entry(va, &free_vmap_area_list, list) {
> +	list_for_each_entry(va, head, list) {
> 		if (!is_within_this_va(va, size, align, vstart))
> 			continue;
> 
> @@ -1316,7 +1316,8 @@ find_vmap_lowest_linear_match(unsigned long size,
> }
> 
> static void
> -find_vmap_lowest_match_check(unsigned long size, unsigned long align)
> +find_vmap_lowest_match_check(struct rb_root *root, struct list_head *head,
> +			     unsigned long size, unsigned long align)
> {
> 	struct vmap_area *va_1, *va_2;
> 	unsigned long vstart;
> @@ -1325,8 +1326,8 @@ find_vmap_lowest_match_check(unsigned long size, unsigned long align)
> 	get_random_bytes(&rnd, sizeof(rnd));
> 	vstart = VMALLOC_START + rnd;
> 
> -	va_1 = find_vmap_lowest_match(size, align, vstart, false);
> -	va_2 = find_vmap_lowest_linear_match(size, align, vstart);
> +	va_1 = find_vmap_lowest_match(root, size, align, vstart, false);
> +	va_2 = find_vmap_lowest_linear_match(head, size, align, vstart);
> 
> 	if (va_1 != va_2)
> 		pr_emerg("not lowest: t: 0x%p, l: 0x%p, v: 0x%lx\n",
> @@ -1513,7 +1514,7 @@ __alloc_vmap_area(struct rb_root *root, struct list_head *head,
> 		return vend;
> 
> #if DEBUG_AUGMENT_LOWEST_MATCH_CHECK
> -	find_vmap_lowest_match_check(size, align);
> +	find_vmap_lowest_match_check(root, head, size, align);
> #endif
> 
> 	return nva_start_addr;
> -- 
> 2.30.2
> 

