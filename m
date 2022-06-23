Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD13F5588B4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiFWT0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiFWT0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:26:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06A9954BD7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656009760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pPnDVr8A7fc4TlxGwEptvcXmBzoTYlHJlZ/bWXrkpw=;
        b=Gx7AcTQZbtEwb4MGNW4b/qwugOQrJG70TbvIPtJJeIHo5eY3zPSyPIqx1TcG+yd2XAkOfQ
        huznaDMuuoxrbId/nf7qzuRHd6+SQb3TIiTbETFpL7yXh7HVwOCSv21oi6yxdZpxRjH264
        7Do9N5AHq8sKeHb6wcqPNV/gnNgOpD8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-x6JlSD92O6iX6EnnRsJRvw-1; Thu, 23 Jun 2022 14:42:39 -0400
X-MC-Unique: x6JlSD92O6iX6EnnRsJRvw-1
Received: by mail-wm1-f71.google.com with SMTP id k5-20020a05600c0b4500b003941ca130f9so27548wmr.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 11:42:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=1pPnDVr8A7fc4TlxGwEptvcXmBzoTYlHJlZ/bWXrkpw=;
        b=OknbDqKROx6Wggv+qDdgtOWYoxH+Cf9OXNbXCyoNi3PnJ3KiRHkjjxHT7NSekZ4o+A
         L925OXIDdWD1KEyn/VuS5IFJntvA4CLugSgoOy7HRmXM7wbkZoktVXv7AqqDL/UYceAd
         5tLg+qRERWadrcV02qLV5G8vcnYaU7xYXbNCSjkU91Exof2mpj8413mcWBY0mdT6jUjV
         IVeHdt6vmbuOQnhCZTXjA+yihbgkaWM0H8Pl2/0kRKt+vF3Q8pchiPmEuc7SlIYuQq+n
         A2u8tcHT6seTus5dyBVDDRKHa4cgkQfNAezbYLjC/h+6o/viKESwWfoFojxOIlYfKzJ5
         Cirg==
X-Gm-Message-State: AJIora9gr7VFw+3sd5xPa+0nEfvqEb11WumcSjWJ/PZ1HiK/IqKkh9qA
        Hxm7lFFEkyuEuvLFkXktyamo/rNR0Lz7CEX11uY8BlZjvf1JUe9B9uEImnx3xEBK8mLyEwNnf/K
        wEEeJCDUZqOBIjqNQyYg4ghfK
X-Received: by 2002:a1c:27c6:0:b0:39c:34a5:9f88 with SMTP id n189-20020a1c27c6000000b0039c34a59f88mr5779165wmn.94.1656009757866;
        Thu, 23 Jun 2022 11:42:37 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vCYmS71wE+ogs05XCnQfh76mPTto8pHRA8OFiPThvd3cnvwh7U5PynNAXyZn0n0AvLY/OLCQ==
X-Received: by 2002:a1c:27c6:0:b0:39c:34a5:9f88 with SMTP id n189-20020a1c27c6000000b0039c34a59f88mr5779147wmn.94.1656009757628;
        Thu, 23 Jun 2022 11:42:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:b100:7694:f34e:d0dd:95e7? (p200300cbc704b1007694f34ed0dd95e7.dip0.t-ipconnect.de. [2003:cb:c704:b100:7694:f34e:d0dd:95e7])
        by smtp.gmail.com with ESMTPSA id e9-20020a5d4e89000000b0021a3a87fda9sm144112wru.47.2022.06.23.11.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:42:37 -0700 (PDT)
Message-ID: <5787e664-73c6-4ab0-451e-2b0f3becb6ae@redhat.com>
Date:   Thu, 23 Jun 2022 20:42:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v10 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
 <20220621204632.3370049-15-Liam.Howlett@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220621204632.3370049-15-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.22 22:46, Liam Howlett wrote:
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The maple tree was already tracking VMAs in this function by an earlier
> commit, but the rbtree iterator was being used to iterate the list.
> Change the iterator to use a maple tree native iterator and switch to the
> maple tree advanced API to avoid multiple walks of the tree during insert
> operations.  Unexport the now-unused vma_store() function.
> 
> For performance reasons we bulk allocate the maple tree nodes.  The node
> calculations are done internally to the tree and use the VMA count and
> assume the worst-case node requirements.  The VM_DONT_COPY flag does not
> allow for the most efficient copy method of the tree and so a bulk loading
> algorithm is used.

You could track the #VM_DONT_COPY per mm and optimize? Do you have that
planned or maybe it already is part of this patch set? :)

> 
> Link: https://lkml.kernel.org/r/20220504010716.661115-16-Liam.Howlett@oracle.com
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: SeongJae Park <sj@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>  include/linux/mm.h |  2 --
>  kernel/fork.c      | 12 +++++++++---
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f22c6f71a18c..27fa36a7c093 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2612,8 +2612,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
>  /* nommu.c */
>  extern atomic_long_t mmap_pages_allocated;
>  extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
> -/* mmap.c */
> -void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
>  
>  /* interval_tree.c */
>  void vma_interval_tree_insert(struct vm_area_struct *node,
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 1840da0732f6..4ecca79556eb 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -583,9 +583,10 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
>  	struct rb_node **rb_link, *rb_parent;
>  	int retval;
> -	unsigned long charge;
> -	LIST_HEAD(uf);
> +	unsigned long charge = 0;

^ why that change?

> +	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
>  	MA_STATE(mas, &mm->mm_mt, 0, 0);
> +	LIST_HEAD(uf);

^ why that reshuffling?

>  
>  	uprobe_start_dup_mmap();
>  	if (mmap_write_lock_killable(oldmm)) {
> @@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_struct *mm,
>  		goto out;
>  
>  	prev = NULL;
> -	for (mpnt = oldmm->mmap; mpnt; mpnt = mpnt->vm_next) {
> +
> +	retval = mas_expected_entries(&mas, oldmm->map_count);
> +	if (retval)
> +		goto out;

mas_expected_entries is a fancy function :)



> +
> +	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
>  		struct file *file;
>  
>  		if (mpnt->vm_flags & VM_DONTCOPY) {


-- 
Thanks,

David / dhildenb

