Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136AC559661
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 11:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbiFXJXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 05:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiFXJXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 05:23:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A56527CF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 02:23:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LTs7d0brFz1K9QT;
        Fri, 24 Jun 2022 17:21:33 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 17:23:42 +0800
Subject: Re: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in
 copy_hugetlb_page_range()
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <be99e9db-3fd0-67de-7776-e6c6e932b965@huawei.com>
Date:   Fri, 24 Jun 2022 17:23:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/24 7:51, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Originally copy_hugetlb_page_range() handles migration entries and hwpoisone

s/hwpoisone/hwpoisoned/

> entries in similar manner.  But recently the related code path has more code
> for migration entries, and when is_writable_migration_entry() was converted
> to !is_readable_migration_entry(), hwpoison entries on source processes got
> to be unexpectedly updated (which is legitimate for migration entries, but
> not for hwpoison entries).  This results in unexpected serious issues like
> kernel panic when foking processes with hwpoison entries in pmd.

s/foking/forking/

> 
> Separate the if branch into one for hwpoison entries and one for migration
> entries.
> 
> Fixes: 6c287605fd56 ("mm: remember exclusively mapped anonymous pages with PG_anon_exclusive")
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Cc: <stable@vger.kernel.org> # 5.18

This makes sense to me. Thanks for fixing this.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

> ---
>  mm/hugetlb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index c538278170a2..f59f43c06601 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -4784,8 +4784,13 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>  			 * sharing with another vma.
>  			 */
>  			;
> -		} else if (unlikely(is_hugetlb_entry_migration(entry) ||
> -				    is_hugetlb_entry_hwpoisoned(entry))) {
> +		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
> +			bool uffd_wp = huge_pte_uffd_wp(entry);
> +
> +			if (!userfaultfd_wp(dst_vma) && uffd_wp)
> +				entry = huge_pte_clear_uffd_wp(entry);
> +			set_huge_swap_pte_at(dst, addr, dst_pte, entry, sz);
> +		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
>  			swp_entry_t swp_entry = pte_to_swp_entry(entry);
>  			bool uffd_wp = huge_pte_uffd_wp(entry);
>  
> 

