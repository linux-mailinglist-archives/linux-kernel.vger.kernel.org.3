Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFC4B03DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiBJDVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:21:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiBJDVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:21:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B631EAFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 19:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644463302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17Oj7nthiIWNQvcRVQOrz83IgfpkiF/YXs0dTC+pb6Y=;
        b=EFSWy6DoRI4cP8obdIuNqZO/Oykeqh3OYic9YdVxWZ2gIuRnbc0EhZk6xsSiy56ImhDafH
        RP2GoPiQGr9BEkd2pTk8HIln9NV/M78yl0azKw3FAqTqG65D+J4uApz5S/fBzg8h0k5eHX
        ScU2uxAxPIZoJznuKgkjNOIn+ueWLnw=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-477-Tcy1CHFDMXS_5KM9IAwGUA-1; Wed, 09 Feb 2022 22:21:41 -0500
X-MC-Unique: Tcy1CHFDMXS_5KM9IAwGUA-1
Received: by mail-pl1-f197.google.com with SMTP id v14-20020a170902e8ce00b0014b48e8e498so580834plg.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 19:21:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=17Oj7nthiIWNQvcRVQOrz83IgfpkiF/YXs0dTC+pb6Y=;
        b=LJ1S1KcYF/+ZPfoiCdKQSf8WDToH6Jp4h/H9TovgXZxV5/MpkUZA3L7w/Q74TUOWLP
         YG1/BMKcDUdi9vtVYtAewT0bSiZ9GF+qORNtY8dm/ZPqgz4OaB6BAPabd9aynErsqGHw
         BpYNBePTJWn1BQm/GfvuNJ+Nd3zUMkFSxcAy5Pxn0nL1tgita9o3z4kfnHfpdSu4orDk
         Xwy+LhVr2Mjc7kl6TfiNB9tPEQ54DfK88HclIle3f4FvONseq/I20eiq1r0FB7qnpNKi
         CS8E2yZli5T1qpq+cflsEh7q4/N2Hrp4d/OJpcQiQg9xowSFZ+pLEOojSqKOKv6NTUav
         70+g==
X-Gm-Message-State: AOAM531TD8mJyKoyATUdTcobAzJoWTfoHFRL6RmEMo0Nbjw1FDxAab/7
        aWMH9ZiAsJ4CbS4BBoc5JbmckMk+1N5b+zCD/k08Qu9fXsS69GTuZiXs7Pc9pSi1UpHOmyK1lj/
        O+KXrYnn7oDpYLXTDr70KIWDk
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr5305529pls.67.1644463300121;
        Wed, 09 Feb 2022 19:21:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxy8H0sudq262065i30E8DJVWmFQT9Q0V7k6OqW7821GAtFa+RDZqCorSow+O0e3x2bAI9ILA==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr5305511pls.67.1644463299814;
        Wed, 09 Feb 2022 19:21:39 -0800 (PST)
Received: from xz-m1.local ([94.177.118.72])
        by smtp.gmail.com with ESMTPSA id z1sm21169985pfh.137.2022.02.09.19.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 19:21:39 -0800 (PST)
Date:   Thu, 10 Feb 2022 11:21:30 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Message-ID: <YgSDcmXya7vTvvZE@xz-m1.local>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220202014034.182008-2-mike.kravetz@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the late comment)

On Tue, Feb 01, 2022 at 05:40:32PM -0800, Mike Kravetz wrote:
> MADV_DONTNEED is currently disabled for hugetlb mappings.  This
> certainly makes sense in shared file mappings as the pagecache maintains
> a reference to the page and it will never be freed.  However, it could
> be useful to unmap and free pages in private mappings.
> 
> The only thing preventing MADV_DONTNEED from working on hugetlb mappings
> is a check in can_madv_lru_vma().  To allow support for hugetlb mappings
> create and use a new routine madvise_dontneed_free_valid_vma() that will
> allow hugetlb mappings.  Also, before calling zap_page_range in the
> DONTNEED case align start and size to huge page size for hugetlb vmas.
> madvise only requires PAGE_SIZE alignment, but the hugetlb unmap routine
> requires huge page size alignment.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  mm/madvise.c | 24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 5604064df464..7ae891e030a4 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -796,10 +796,30 @@ static int madvise_free_single_vma(struct vm_area_struct *vma,
>  static long madvise_dontneed_single_vma(struct vm_area_struct *vma,
>  					unsigned long start, unsigned long end)
>  {
> +	/*
> +	 * start and size (end - start) must be huge page size aligned
> +	 * for hugetlb vmas.
> +	 */
> +	if (is_vm_hugetlb_page(vma)) {
> +		struct hstate *h = hstate_vma(vma);
> +
> +		start = ALIGN_DOWN(start, huge_page_size(h));
> +		end = ALIGN(end, huge_page_size(h));
> +	}
> +

Maybe check the alignment before userfaultfd_remove()?  Otherwise there'll be a
fake message generated to the tracer.

>  	zap_page_range(vma, start, end - start);
>  	return 0;
>  }
>  
> +static bool madvise_dontneed_free_valid_vma(struct vm_area_struct *vma,
> +						int behavior)
> +{
> +	if (is_vm_hugetlb_page(vma))
> +		return behavior == MADV_DONTNEED;
> +	else
> +		return can_madv_lru_vma(vma);
> +}

can_madv_lru_vma() will check hugetlb again which looks a bit weird.  Would it
look better to write it as:

madvise_dontneed_free_valid_vma()
{
    return !(vma->vm_flags & (VM_LOCKED|VM_PFNMAP));
}

can_madv_lru_vma()
{
    return madvise_dontneed_free_valid_vma() && !is_vm_hugetlb_page(vma);
}

?

Another use case of DONTNEED upon hugetlbfs could be uffd-minor, because afaiu
this is the only api that can force strip the hugetlb mapped pgtable without
losing pagecache data.

Thanks,

-- 
Peter Xu

