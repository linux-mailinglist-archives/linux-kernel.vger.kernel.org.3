Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5204A6CC0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbiBBIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 03:14:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:27161 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244330AbiBBIO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 03:14:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643789665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2Rq6N4dNe/uLrGvcKxFQPZwRPXOX6fDs2MMCU1MQ9Tc=;
        b=W5LR27OJBae8uWnoMBT0EIbsrOMWeBlqi8GI8p+igHNzV3jCDS2SmlrSFeKn5gR3hCX7hO
        S1dRDBlCNAe6cpfoEaKGJYjLw+szwkMs/bR1WY7p7A531mJrxclEPC8QpE3WdX1V3WZvsv
        opp17ZCYz5ZwDXyBUf9SH1lVQ4csT6c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-ikBwpYNrN5iuVVgreWTKMA-1; Wed, 02 Feb 2022 03:14:23 -0500
X-MC-Unique: ikBwpYNrN5iuVVgreWTKMA-1
Received: by mail-ed1-f72.google.com with SMTP id i22-20020a50fd16000000b00405039f2c59so10008343eds.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 00:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=2Rq6N4dNe/uLrGvcKxFQPZwRPXOX6fDs2MMCU1MQ9Tc=;
        b=Vi+2enT/aKgs5RdKeUIp2x3pepqhyE5GLeqLqY4196ZZ3ox8xDodpDMZ6skJjmsATs
         IzKVhSmVG4nVxdDBpLChSWLEckRe15Y8fCekxvoEG0xCM3v3iQPQjRsTMJ2pFW0CayM7
         KIDp5jxiq5KkUBICwOI7NMsi/qOlvCvnNU5mESEMu9DU7jHGb87ePkuMDLctNlM6kBhZ
         3BbzAJLl0vtJ0hNXoMSE1WPNyhqq4KksOheK8EdqH78rkNmA+flmZLmsHG13VZPOLZuG
         wnAxTIe/W5mh7c6dIO/jOo6NhxXpZGDWrz5jQVwBG/lN5F7o5/ah0b0UQEzsQSUOYy5f
         v8fw==
X-Gm-Message-State: AOAM530G7WVsM8fG54PPQcFNbLZvbHx2iIXftRDQDKG8wSGsN/RPPdpu
        UAgUS2kOEbAPlEcgIVsk7rOtZvSJa82pGmoB0McW4RqdhC1a4z6XlABSCMJmejGJ2olTfApsYUz
        DNDN68elNLfY0YeriwhXOpMJ9
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr15847194ejy.448.1643789662478;
        Wed, 02 Feb 2022 00:14:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyqH3rVTg5DRRB8rQxbvHzgYDMg49Oc4tMCYxG37o/ZZRNCcg4Pgudybt6DPaMHv/Zy74LpvQ==
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr15847174ejy.448.1643789662268;
        Wed, 02 Feb 2022 00:14:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:f800:a55c:e484:3cd9:3632? (p200300cbc709f800a55ce4843cd93632.dip0.t-ipconnect.de. [2003:cb:c709:f800:a55c:e484:3cd9:3632])
        by smtp.gmail.com with ESMTPSA id d2sm15370010ejw.79.2022.02.02.00.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Feb 2022 00:14:21 -0800 (PST)
Message-ID: <20571829-9d3d-0b48-817c-b6b15565f651@redhat.com>
Date:   Wed, 2 Feb 2022 09:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
In-Reply-To: <20220202014034.182008-2-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.02.22 02:40, Mike Kravetz wrote:
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

So you effectively extend the range silently. IIUC, if someone would zap
a 4k range you would implicitly zap a whole 2M page and effectively zero
out more data than requested.


Looking at do_madvise(), we:
(1) reject start addresses that are not page-aligned
(2) shrink lengths that are not page-aligned and refuse if it turns 0

The man page documents (1) but doesn't really document (2).

Naturally I'd have assume that we apply the same logic to huge page
sizes and documenting it in the man page accordingly.


Why did you decide to extend the range? I'd assume MADV_REMOVE behaves
like FALLOC_FL_PUNCH_HOLE:
  "Within the specified range, partial filesystem blocks are zeroed, and
   whole filesystem blocks are removed from the file.  After a
   successful call, subsequent reads from  this  range will return
   zeros."
So we don't "discard more than requested".


I see the following possible alternatives:
(a) Fail if the range is not aligned
-> Clear semantics
(b) Fail if the start is not aligned, shrink the end if required
-> Same rules as for PAGE_SIZE
(c) Zero out the requested part
-> Same semantics as FALLOC_FL_PUNCH_HOLE.

My preference would be a), properly documenting it in the man page.

-- 
Thanks,

David / dhildenb

