Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271C14F7C60
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241957AbiDGKK1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238176AbiDGKKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:10:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0D1023584C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 03:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649326100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrACxl9C2gOChjAyxZVhTY+qfXPOAdTm/ErunvhnUCc=;
        b=NHfRbhNd+pAosOEL6jQ6zwq2B+ZKC6QI9RiAd79BmR5FT2ioLx03kzSNNkrArXfwj38kxi
        9jck/yiV+DmSKwLubok5zB8gIeV46HesumFMqOCBxGJxUZaKs3+84jme/T2Zn+Ew3AVLwP
        mgbIilakFVakwS3y7LSmPRpgd77SaSg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-jfoh0PyGOMybbj5UXdMrrw-1; Thu, 07 Apr 2022 06:08:19 -0400
X-MC-Unique: jfoh0PyGOMybbj5UXdMrrw-1
Received: by mail-wr1-f72.google.com with SMTP id s13-20020adfa28d000000b00205e049cff2so1118903wra.17
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 03:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=DrACxl9C2gOChjAyxZVhTY+qfXPOAdTm/ErunvhnUCc=;
        b=0mns3nl07/5t5MAsM/meXPhePq7I+YWdLUL28wAH4sOfjLMplcV6xuofIMWh2zTPll
         i41o+q8mBGxUjw7AOpp4XMDJNu7MGb4S8nyF7y1xkqrZi29dea/I15vIQuL174EppMfw
         UMElkU0lBv3mLaBF+RsSNdH7StB92A7V7rEsc7WpVgzBgH0sCpb1B4ocGPqHb9+tQW1A
         BHWRgWSdtY6VswXB0n+nZd91igyLAclj6sPt9qj7Y5Q7OGMkkRCa9eYu58cQbrPQXP7V
         hLzfoFf8tYgsgs9Rsf4gvXk++u2iF9xwVQAxDNaK3LeuP3XiKQmlkCq2Tm4MfbJ/MZcv
         aFjw==
X-Gm-Message-State: AOAM532peqqCQEoJ9OSPIblJlXMli07rn006g2vVjZ62e4h8IETTRRoS
        0aCf+6ozAG8qDBgNv6kJzK4xWpzZN8Duj5mvPxxOWk72FYK9W68lVoDOADWBkYGFo/rbWV15DuN
        bbdbj6/3NCHWvbDDTI5xV7m/j
X-Received: by 2002:a5d:64eb:0:b0:205:d418:4798 with SMTP id g11-20020a5d64eb000000b00205d4184798mr10296694wri.11.1649326098319;
        Thu, 07 Apr 2022 03:08:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/CDCZaWyg95GLwbhj/qt39N+IZvaplfCwXnnSE4E74yjYE+B9+NkOc6BjdiTjCVvf14UJEg==
X-Received: by 2002:a5d:64eb:0:b0:205:d418:4798 with SMTP id g11-20020a5d64eb000000b00205d4184798mr10296667wri.11.1649326097983;
        Thu, 07 Apr 2022 03:08:17 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0038cbdf5221dsm7798149wmq.41.2022.04.07.03.08.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 03:08:17 -0700 (PDT)
Message-ID: <045a59a1-0929-a969-b184-1311f81504b8@redhat.com>
Date:   Thu, 7 Apr 2022 12:08:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220406204823.46548-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/5] hugetlb: Change huge pmd sharing
In-Reply-To: <20220406204823.46548-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.04.22 22:48, Mike Kravetz wrote:
> hugetlb fault scalability regressions have recently been reported [1].
> This is not the first such report, as regressions were also noted when
> commit c0d0381ade79 ("hugetlbfs: use i_mmap_rwsem for more pmd sharing
> synchronization") was added [2] in v5.7.  At that time, a proposal to
> address the regression was suggested [3] but went nowhere.
> 
> To illustrate the regression, I created a simple program that does the
> following in an infinite loop:
> - mmap a 4GB hugetlb file (size insures pmd sharing)
> - fault in all pages
> - unmap the hugetlb file
> 
> The hugetlb fault code was then instrumented to collect number of times
> the mutex was locked and wait time.  Samples are from 10 second
> intervals on a 4 CPU VM with 8GB memory.  Eight instances of the
> map/fault/unmap program are running.
> 
> v5.17
> -----
> [  708.763114] Wait_debug: faults sec  3622
> [  708.764010]             num faults  36220
> [  708.765016]             num waits   36220
> [  708.766054]             intvl wait time 54074 msecs
> [  708.767287]             max_wait_time   31000 usecs
> 
> 
> v5.17 + this series (similar to v5.6)
> -------------------------------------
> [  282.191391] Wait_debug: faults sec  1777939
> [  282.192571]             num faults  17779393
> [  282.193746]             num locks   5517
> [  282.194858]             intvl wait time 19907 msecs
> [  282.196226]             max_wait_time   43000 usecs
> 
> As can be seen, fault time suffers when there are other operations
> taking i_mmap_rwsem in write mode such as unmap.
> 
> This series proposes reverting c0d0381ade79 and 87bf91d39bb5 which
> depends on c0d0381ade79.  This moves acquisition of i_mmap_rwsem in the
> fault path back to huge_pmd_share where it is only taken when necessary.
> After, reverting these patches we still need to handle:
> fault and truncate races
> - Catch and properly backout faults beyond i_size
>   Backing out reservations is much easier after 846be08578ed to expand
>   restore_reserve_on_error functionality.
> unshare and fault/lookup races
> - Since the pointer returned from huge_pte_offset or huge_pte_alloc may
>   become invalid until we lock the page table, we must revalidate after
>   taking the lock.  Code paths must backout and possibly retry if
>   page table pointer changes.
> 
> The commit message in patch 5 suggests that it is not safe to use
> SPLIT_PMD_PTLOCKS for hugetlb mappings if sharing is possible.  If
> others confirm/agree then there will need to be additional work.
> 
> Please help with comments or suggestions.  I would like to come up with
> something that is performant and safe.

May I challenge the existence of huge PMD sharing? TBH I am not
convinced that the code complexity is worth the benefit.


Let me know if I get something wrong:

Let's assume a 4 TiB device and 2 MiB hugepage size. That's 2097152 huge
pages. Each such PMD entry consumes 8 bytes. That's 16 MiB.

Sure, with thousands of processes sharing that memory, the size of page
tables required would increase with each and every process. But TBH,
that's in no way different to other file systems where we're even
dealing with PTE tables.


Which results in me wondering if

a) We should simply use gigantic pages for such extreme use case. Allows
   for freeing up more memory via vmemmap either way.
b) We should instead look into reclaiming reconstruct-able page table.
   It's hard to imagine that each and every process accesses each and
   every part of the gigantic file all of the time.
c) We should instead establish a more generic page table sharing
   mechanism.


Consequently, I'd be much more in favor of ripping it out :/ but that's
just my personal opinion.

-- 
Thanks,

David / dhildenb

