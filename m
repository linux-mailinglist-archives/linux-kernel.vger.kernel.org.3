Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D834CFD6A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbiCGLwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbiCGLwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:52:03 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F26E781
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 03:51:08 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBxZw6C8gzdfwr;
        Mon,  7 Mar 2022 19:49:44 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:51:05 +0800
Subject: Re: [PATCH 07/16] mm/migration: use helper macro min_t in
 do_pages_stat
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-8-linmiaohe@huawei.com>
 <20220306171400.a5cbab665b6338391447e541@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <f790b69f-f94d-72f9-ac58-765df9286f04@huawei.com>
Date:   Mon, 7 Mar 2022 19:51:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220306171400.a5cbab665b6338391447e541@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/7 9:14, Andrew Morton wrote:
> On Fri, 4 Mar 2022 17:34:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
>> We could use helper macro min_t to help set the chunk_nr to simplify
>> the code.
>>
>> ...
>>
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1858,9 +1858,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
>>  	while (nr_pages) {
>>  		unsigned long chunk_nr;
>>  
>> -		chunk_nr = nr_pages;
>> -		if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
>> -			chunk_nr = DO_PAGES_STAT_CHUNK_NR;
>> +		chunk_nr = min_t(unsigned long, nr_pages, DO_PAGES_STAT_CHUNK_NR);
>>  
>>  		if (in_compat_syscall()) {
>>  			if (get_compat_pages_array(chunk_pages, pages,
> 
> Getting the types correct is better than using min_t().
> 

Looks good. Many thanks for your suggestion. Will do it in v2.

Thanks.

> --- a/mm/migrate.c~mm-migration-use-helper-macro-min_t-in-do_pages_stat-fix
> +++ a/mm/migrate.c
> @@ -1844,14 +1844,12 @@ static int do_pages_stat(struct mm_struc
>  			 const void __user * __user *pages,
>  			 int __user *status)
>  {
> -#define DO_PAGES_STAT_CHUNK_NR 16
> +#define DO_PAGES_STAT_CHUNK_NR 16UL
>  	const void __user *chunk_pages[DO_PAGES_STAT_CHUNK_NR];
>  	int chunk_status[DO_PAGES_STAT_CHUNK_NR];
>  
>  	while (nr_pages) {
> -		unsigned long chunk_nr;
> -
> -		chunk_nr = min_t(unsigned long, nr_pages, DO_PAGES_STAT_CHUNK_NR);
> +		unsigned long chunk_nr = min(nr_pages, DO_PAGES_STAT_CHUNK_NR);
>  
>  		if (in_compat_syscall()) {
>  			if (get_compat_pages_array(chunk_pages, pages,
> _
> 
> .
> 

