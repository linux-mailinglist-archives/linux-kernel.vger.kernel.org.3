Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623804EBC38
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiC3IAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239731AbiC3H76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA20C201BA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648627091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BJeMjR38m0uG6JnLO8hPff6qq6W/GbB0IOxAnpHuaY=;
        b=aEGJJShang1T1lXmkwnlFjVRuBgySdzK5e30T54xvs1qXJ18JOoqCYCDfrrVbYBqGzIbzB
        KgGbymBGF8vO/VlhSdX62dtNw8kKBiQ4fZHNn0Mnvu90KJPAf/YT8H6brT8sFco/88VKJM
        Dz2o3qN8fOgsOo85Em62GdmN2M87UQc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-218-6tGW9MoiN-6q5gst2RXOIA-1; Wed, 30 Mar 2022 03:58:09 -0400
X-MC-Unique: 6tGW9MoiN-6q5gst2RXOIA-1
Received: by mail-wm1-f69.google.com with SMTP id q186-20020a1c43c3000000b0038ce534d9e2so5749441wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:58:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=2BJeMjR38m0uG6JnLO8hPff6qq6W/GbB0IOxAnpHuaY=;
        b=xZNJdynhKpuU7j5tVS0r3yivXRt/woWGlEsCKZf2iMBGzQxUxuzhawCb0YXYmW79Py
         Ni9G/NftwbBJNS3pAqUgfihT1FFMPtYCoI3P0K4NXseiezWOmd7Tp2I5DeCn7Y66ZLkm
         hOrnJPXaCtG1oyK0h6DV2AOFudDwta5d3Gf1ZJe44rk8X+Y9mwzLR3/DBOHhBRXkZApR
         Mb5Rzk1lcakvtLSRmaIqZfeTD5zbpLbbe5222ER2v1iZefvS872p+Q7MupZUvMHwC8ED
         NraSGYGW9uOg/HQQVRttaMaCO/xu+sQOGiulGRiGUZwV8SrBNzqrFdhX/WtC+9AwUV+0
         uzXw==
X-Gm-Message-State: AOAM530VPhRBBzRuTcMnMyYo5eDgIY0Nnfc0yD667cyy7ZmBOlU0fLbg
        X+vF1Csje24QuT2Veixvc8FBg4YGctX5rsDeDMBpizJx6o4e8PbsXNj9fSjqJTiBxC2K4gsCN03
        ztENf3ygexrP3WuvO5qJHcjKe
X-Received: by 2002:a05:600c:1c1e:b0:38c:b393:b357 with SMTP id j30-20020a05600c1c1e00b0038cb393b357mr3242309wms.66.1648627088315;
        Wed, 30 Mar 2022 00:58:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOMEBkhsEuDOTR+1z411zbQG4V/02arH7rYhvk/C8ETMGO0xtXQXjqktqHXMPBGMZ8pyfO2g==
X-Received: by 2002:a05:600c:1c1e:b0:38c:b393:b357 with SMTP id j30-20020a05600c1c1e00b0038cb393b357mr3242286wms.66.1648627088015;
        Wed, 30 Mar 2022 00:58:08 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:2200:178b:7244:2a1f:b5d8? (p200300cbc7052200178b72442a1fb5d8.dip0.t-ipconnect.de. [2003:cb:c705:2200:178b:7244:2a1f:b5d8])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm4129674wml.10.2022.03.30.00.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:58:07 -0700 (PDT)
Message-ID: <070407bc-9a35-db27-43ea-ed8baaa219c6@redhat.com>
Date:   Wed, 30 Mar 2022 09:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220324170600.16491-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH] hugetlbfs: zero partial pages during fallocate hole
 punch
In-Reply-To: <20220324170600.16491-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.03.22 18:06, Mike Kravetz wrote:
> hugetlbfs fallocate support was originally added with commit 70c3547e36f5
> ("hugetlbfs: add hugetlbfs_fallocate()").  Initial support only operated
> on whole hugetlb pages.  This makes sense for populating files as other
> interfaces such as mmap and truncate require hugetlb page size alignment.
> Only operating on whole hugetlb pages for the hole punch case was a
> simplification and there was no compelling use case to zero partial pages.
> 
> In a recent discussion[1] it was assumed that hugetlbfs hole punch would
> zero partial hugetlb pages as that is in line with the man page
> description saying 'partial filesystem  blocks  are  zeroed'.  However,
> the hugetlbfs hole punch code actually does this:
> 
>         hole_start = round_up(offset, hpage_size);
>         hole_end = round_down(offset + len, hpage_size);
> 
> Modify code to zero partial hugetlb pages in hole punch range.  It is
> possible that application code could note a change in behavior.  However,
> that would imply the code is passing in an unaligned range and expecting
> only whole pages be removed.  This is unlikely as the fallocate
> documentation states the opposite.

Yeah, some weird code could behave differently; an app would have to
pass in an unaligned range and expect that partially covered hugetlbfs
pages remain unmodified.  It's hard to think of reasonable apps that do
that, but of course, some buggy code might then be *actually* broken.
Like some messed-up align-up implementation that accidentally adds +1
too much.

> 
> The current hugetlbfs fallocate hole punch behavior is tested with the
> libhugetlbfs test fallocate_align[2].  This test will be updated to
> validate partial page zeroing.

This is in line with other fallocate() behavior and documented
semantics, so I think that's the right thing to do.

I think it's worth to give it a try, it's hard to imagine that this
actually breaks something.


"After a successful call, subsequent reads from  this  range will return
zeros." will work as expected with your change.

> 
> [1] https://lore.kernel.org/linux-mm/20571829-9d3d-0b48-817c-b6b15565f651@redhat.com/
> [2] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_align.c
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  fs/hugetlbfs/inode.c      | 67 ++++++++++++++++++++++++++++++---------
>  include/asm-generic/tlb.h |  2 ++
>  2 files changed, 54 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index a7c6c7498be0..f62ec4f71132 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -587,41 +587,78 @@ static void hugetlb_vmtruncate(struct inode *inode, loff_t offset)
>  	remove_inode_hugepages(inode, offset, LLONG_MAX);
>  }
>  
> +static void hugetlbfs_zero_partial_page(struct hstate *h,
> +					struct address_space *mapping,
> +					unsigned long start,
> +					unsigned long end)
> +{
> +	struct page *page;
> +	pgoff_t idx = start >> huge_page_shift(h);

I'm a fan of reverse Christmas trees :)

> +
> +	page = find_lock_page(mapping, idx);
> +	if (!page)
> +		return;
> +
> +	start = start & ~huge_page_mask(h);
> +	end = end & ~huge_page_mask(h);
> +	if (!end)
> +		end = huge_page_size(h);
> +
> +	zero_user_segment(page, (unsigned int)start, (unsigned int)end);
> +
> +	unlock_page(page);
> +	put_page(page);
> +}
> +
>  static long hugetlbfs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
>  {
>  	struct hstate *h = hstate_inode(inode);
>  	loff_t hpage_size = huge_page_size(h);
>  	loff_t hole_start, hole_end;
> +	struct address_space *mapping = inode->i_mapping;
> +	struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);

ditto.

>  
>  	/*
> -	 * For hole punch round up the beginning offset of the hole and
> -	 * round down the end.
> +	 * hole_start and hole_end indicate the full pages within the hole.
>  	 */
>  	hole_start = round_up(offset, hpage_size);
>  	hole_end = round_down(offset + len, hpage_size);
>  
> -	if (hole_end > hole_start) {
> -		struct address_space *mapping = inode->i_mapping;
> -		struct hugetlbfs_inode_info *info = HUGETLBFS_I(inode);
> +	inode_lock(inode);
> +
> +	/* protected by i_rwsem */
> +	if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> +		inode_unlock(inode);
> +		return -EPERM;
> +	}
>  
> -		inode_lock(inode);
> +	i_mmap_lock_write(mapping);
>  
> -		/* protected by i_rwsem */
> -		if (info->seals & (F_SEAL_WRITE | F_SEAL_FUTURE_WRITE)) {
> -			inode_unlock(inode);
> -			return -EPERM;
> -		}
> +	/* If range starts before first full page, zero partial page. */
> +	if (offset < hole_start)
> +		hugetlbfs_zero_partial_page(h, mapping,
> +				offset, min(offset + len, hole_start));
>  
> -		i_mmap_lock_write(mapping);
> +	/* Unmap users of full pages in the hole. */
> +	if (hole_end > hole_start) {
>  		if (!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root))
>  			hugetlb_vmdelete_list(&mapping->i_mmap,
>  						hole_start >> PAGE_SHIFT,
>  						hole_end  >> PAGE_SHIFT);
> -		i_mmap_unlock_write(mapping);
> -		remove_inode_hugepages(inode, hole_start, hole_end);
> -		inode_unlock(inode);
>  	}
>  
> +	/* If range extends beyond last full page, zero partial page. */
> +	if ((offset + len) > hole_end && (offset + len) > hole_start)
> +		hugetlbfs_zero_partial_page(h, mapping,
> +				hole_end, offset + len);
> +
> +	i_mmap_unlock_write(mapping);
> +
> +	/* Remove full pages from the file. */
> +	if (hole_end > hole_start)
> +		remove_inode_hugepages(inode, hole_start, hole_end);
> +	inode_unlock(inode);
> +
>  	return 0;
>  }
>  
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 2c68a545ffa7..4622ee45f739 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -562,6 +562,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>  	} while (0)
>  
> +#ifndef tlb_remove_huge_tlb_entry
>  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)	\
>  	do {							\
>  		unsigned long _sz = huge_page_size(h);		\
> @@ -571,6 +572,7 @@ static inline void tlb_flush_p4d_range(struct mmu_gather *tlb,
>  			tlb_flush_pud_range(tlb, address, _sz);	\
>  		__tlb_remove_tlb_entry(tlb, ptep, address);	\
>  	} while (0)
> +#endif

Was this change supposed to be included in this patch?


-- 
Thanks,

David / dhildenb

