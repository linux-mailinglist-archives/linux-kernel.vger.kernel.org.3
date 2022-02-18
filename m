Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035E44BB049
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 04:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbiBRDlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 22:41:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiBRDlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 22:41:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E8EDF86
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 19:40:45 -0800 (PST)
Received: from kwepemi100019.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K0HWC075RzbkZg;
        Fri, 18 Feb 2022 11:39:34 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (7.193.23.74) by
 kwepemi100019.china.huawei.com (7.221.188.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 11:40:42 +0800
Received: from huawei.com (10.174.177.28) by kwepemm600012.china.huawei.com
 (7.193.23.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Feb
 2022 11:40:42 +0800
From:   liuyuntao <liuyuntao10@huawei.com>
To:     <mike.kravetz@oracle.com>
CC:     <akpm@linux-foundation.org>, <baolin.wang@linux.alibaba.com>,
        <dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <liuyuntao10@huawei.com>,
        <yaozhenguo1@gmail.com>
Subject: Re: [PATCH] hugetlb: clean up potential spectre issue warnings
Date:   Fri, 18 Feb 2022 11:40:25 +0800
Message-ID: <20220218034025.17687-1-liuyuntao10@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217234218.192885-1-mike.kravetz@oracle.com>
References: <20220217234218.192885-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.28]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Feb 2022 15:42:18 -0800, Mike Kravetz wrote:
> Recently introduced code allows numa nodes to be specified on the
> kernel command line for hugetlb allocations or CMA reservations.  The
> node values are user specified and used as indicies into arrays.  This
> generated the following smatch warnings:
> 
> mm/hugetlb.c:4170 hugepages_setup() warn: potential spectre issue 'default_hugepages_in_node' [w]
> mm/hugetlb.c:4172 hugepages_setup() warn: potential spectre issue 'parsed_hstate->max_huge_pages_node' [w]
> mm/hugetlb.c:6898 cmdline_parse_hugetlb_cma() warn: potential spectre issue 'hugetlb_cma_size_in_node' [w] (local cap)
> 
> Clean up by using array_index_nospec to sanitize array indicies.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/hugetlb.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 1f0cca036f7f..6b14d0791cb4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -31,6 +31,7 @@
>  #include <linux/llist.h>
>  #include <linux/cma.h>
>  #include <linux/migrate.h>
> +#include <linux/nospec.h>
>  
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
>  			}
>  			if (tmp >= nr_online_nodes)
>  				goto invalid;
> -			node = tmp;
> +			node = array_index_nospec(tmp, nr_online_nodes);
>  			p += count + 1;
>  			/* Parse hugepages */
>  			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> @@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
>  			break;
>  
>  		if (s[count] == ':') {
> -			nid = tmp;
> -			if (nid < 0 || nid >= MAX_NUMNODES)
> +			if (tmp < 0 || tmp >= MAX_NUMNODES)

Here tmp is unsigned, no need to check if less than 0.
Do we really have any automated checking? lol

>  				break;
> +			nid = array_index_nospec(tmp, MAX_NUMNODES);
>  
>  			s += count + 1;
>  			tmp = memparse(s, &s);
> -- 
> 2.34.1
