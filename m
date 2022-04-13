Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316F24FEFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiDMGnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiDMGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:43:05 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7412B274
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:40:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0V9yAqdB_1649832040;
Received: from 30.47.203.83(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0V9yAqdB_1649832040)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Apr 2022 14:40:41 +0800
Message-ID: <7e7befd8-6558-d4c3-4d00-9b638a52d815@linux.alibaba.com>
Date:   Wed, 13 Apr 2022 14:41:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] hugetlb: Clean up hugetlb_cma_reserve
To:     Peng Liu <liupeng256@huawei.com>, mike.kravetz@oracle.com,
        david@redhat.com, akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        songmuchun@bytedance.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-5-liupeng256@huawei.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20220413032915.251254-5-liupeng256@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/2022 11:29 AM, Peng Liu wrote:
> Use more generic functions to deal with issues related to online
> nodes. The changes will make the code simplified.
> 
> Signed-off-by: Peng Liu <liupeng256@huawei.com>

Looks more consistent. Thanks.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

> ---
>   mm/hugetlb.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 2e4d8d9fb7c6..4c529774cc08 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6953,7 +6953,7 @@ void __init hugetlb_cma_reserve(int order)
>   		if (hugetlb_cma_size_in_node[nid] == 0)
>   			continue;
>   
> -		if (!node_state(nid, N_ONLINE)) {
> +		if (!node_online(nid)) {
>   			pr_warn("hugetlb_cma: invalid node %d specified\n", nid);
>   			hugetlb_cma_size -= hugetlb_cma_size_in_node[nid];
>   			hugetlb_cma_size_in_node[nid] = 0;
> @@ -6992,7 +6992,7 @@ void __init hugetlb_cma_reserve(int order)
>   	}
>   
>   	reserved = 0;
> -	for_each_node_state(nid, N_ONLINE) {
> +	for_each_online_node(nid) {
>   		int res;
>   		char name[CMA_MAX_NAME];
>   
