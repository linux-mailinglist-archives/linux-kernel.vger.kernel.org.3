Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E701D504C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiDRF4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiDRF4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:56:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D6562DC
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:53:28 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KhbhL1GZ2zgYv2;
        Mon, 18 Apr 2022 13:53:22 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 13:53:26 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 18 Apr 2022 13:53:25 +0800
Message-ID: <932d2334-f29e-ff6a-71b6-1e9c973be0ee@huawei.com>
Date:   Mon, 18 Apr 2022 13:53:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v4] hugetlb: Fix wrong use of nr_online_nodes
Content-Language: en-US
To:     Peng Liu <liupeng256@huawei.com>, <mike.kravetz@oracle.com>,
        <david@redhat.com>, <akpm@linux-foundation.org>,
        <yaozhenguo1@gmail.com>, <baolin.wang@linux.alibaba.com>,
        <songmuchun@bytedance.com>, <liuyuntao10@huawei.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <dave@stgolabs.net>
References: <20220413032915.251254-2-liupeng256@huawei.com>
 <20220416103526.3287348-1-liupeng256@huawei.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20220416103526.3287348-1-liupeng256@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/4/16 18:35, Peng Liu wrote:
> Certain systems are designed to have sparse/discontiguous nodes. In
> this case, nr_online_nodes can not be used to walk through numa node.
> Also, a valid node may be greater than nr_online_nodes.
>
> However, in hugetlb, it is assumed that nodes are contiguous. Recheck
> all the places that use nr_online_nodes, and repair them one by one.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Fixes: 4178158ef8ca ("hugetlbfs: fix issue of preallocation of gigantic pages can't work")
> Fixes: b5389086ad7b ("hugetlbfs: extend the definition of hugepages parameter to support node allocation")
> Fixes: e79ce9832316 ("hugetlbfs: fix a truncation issue in hugepages parameter")
> Fixes: f9317f77a6e0 ("hugetlb: clean up potential spectre issue warnings")
> Signed-off-by: Peng Liu <liupeng256@huawei.com>
> ---
> v3->v4:
>   Make sure nid is valid before use node_online, and __alloc_bootmem_huge_page
>   is no need to check node_online, which is suggested by Kefeng.
  Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>

>   mm/hugetlb.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index b34f50156f7e..a386c5f94932 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2979,8 +2979,6 @@ int __alloc_bootmem_huge_page(struct hstate *h, int nid)
>   	struct huge_bootmem_page *m = NULL; /* initialize for clang */
>   	int nr_nodes, node;
>   
> -	if (nid != NUMA_NO_NODE && nid >= nr_online_nodes)
> -		return 0;
>   	/* do node specific alloc */
>   	if (nid != NUMA_NO_NODE) {
>   		m = memblock_alloc_try_nid_raw(huge_page_size(h), huge_page_size(h),
> @@ -3088,7 +3086,7 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>   	}
>   
>   	/* do node specific alloc */
> -	for (i = 0; i < nr_online_nodes; i++) {
> +	for_each_online_node(i) {
>   		if (h->max_huge_pages_node[i] > 0) {
>   			hugetlb_hstate_alloc_pages_onenode(h, i);
>   			node_specific_alloc = true;
> @@ -4049,7 +4047,7 @@ static int __init hugetlb_init(void)
>   			default_hstate.max_huge_pages =
>   				default_hstate_max_huge_pages;
>   
> -			for (i = 0; i < nr_online_nodes; i++)
> +			for_each_online_node(i)
>   				default_hstate.max_huge_pages_node[i] =
>   					default_hugepages_in_node[i];
>   		}
> @@ -4164,9 +4162,9 @@ static int __init hugepages_setup(char *s)
>   				pr_warn("HugeTLB: architecture can't support node specific alloc, ignoring!\n");
>   				return 0;
>   			}
> -			if (tmp >= nr_online_nodes)
> +			if (tmp >= MAX_NUMNODES || !node_online(tmp))
>   				goto invalid;
> -			node = array_index_nospec(tmp, nr_online_nodes);
> +			node = array_index_nospec(tmp, MAX_NUMNODES);
>   			p += count + 1;
>   			/* Parse hugepages */
>   			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
> @@ -4294,7 +4292,7 @@ static int __init default_hugepagesz_setup(char *s)
>   	 */
>   	if (default_hstate_max_huge_pages) {
>   		default_hstate.max_huge_pages = default_hstate_max_huge_pages;
> -		for (i = 0; i < nr_online_nodes; i++)
> +		for_each_online_node(i)
>   			default_hstate.max_huge_pages_node[i] =
>   				default_hugepages_in_node[i];
>   		if (hstate_is_gigantic(&default_hstate))
