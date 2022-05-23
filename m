Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEDB530751
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 03:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351982AbiEWBul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 21:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352046AbiEWBui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 21:50:38 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBAB1400B
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 18:50:37 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L60Zc6YgyzQk8W;
        Mon, 23 May 2022 09:47:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 23 May 2022 09:50:35 +0800
Subject: Re: [PATCH next] mm/shmem: fix shmem folio swapoff hang
To:     Hugh Dickins <hughd@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Matthew Wilcox <willy@infradead.org>
References: <c32bee8a-f0aa-245-f94e-24dd271924fa@google.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2e4d5ba4-3525-322d-2aa6-3387d9822f5e@huawei.com>
Date:   Mon, 23 May 2022 09:50:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c32bee8a-f0aa-245-f94e-24dd271924fa@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/22 10:53, Hugh Dickins wrote:
> Shmem swapoff makes no progress: the index to indices is not incremented.

Yes, there would be a infinite loop in the while loop in shmem_unuse_inode().

> But "ret" is no longer a return value, so use folio_batch_count() instead.
> 
> Fixes: da08e9b79323 ("mm/shmem: convert shmem_swapin_page() to shmem_swapin_folio()")
> Signed-off-by: Hugh Dickins <hughd@google.com>

This patch looks good to me! Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Tested-by: Miaohe Lin <linmiaohe@huawei.com>

BTW: When I try to fix infinite loop when swap in shmem error at swapoff time, I also found this
issue last Saturday [1]. ;)

[1] https://lore.kernel.org/linux-mm/0f6dc98b-88f4-c0c9-eb7b-5356ad0e08b1@huawei.com/

> ---
> 
>  mm/shmem.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1171,7 +1171,6 @@ static int shmem_find_swap_entries(struc
>  	XA_STATE(xas, &mapping->i_pages, start);
>  	struct folio *folio;
>  	swp_entry_t entry;
> -	unsigned int ret = 0;
>  
>  	rcu_read_lock();
>  	xas_for_each(&xas, folio, ULONG_MAX) {
> @@ -1189,7 +1188,7 @@ static int shmem_find_swap_entries(struc
>  		if (swp_type(entry) != type)
>  			continue;
>  
> -		indices[ret] = xas.xa_index;
> +		indices[folio_batch_count(fbatch)] = xas.xa_index;
>  		if (!folio_batch_add(fbatch, folio))
>  			break;
>  
> 
> .
> 

