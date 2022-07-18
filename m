Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672DB5782F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbiGRNA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbiGRNAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:00:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B4E126106
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658149191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K2UbXX8GfQDSH1G+l3mYd8piXh+YvuH3CKSjlZ6grsU=;
        b=CXjjsbp00/hvTH8YRuSSPgjffU2Kv0i13Rt7oTPu4a1i/C8QyxS0JpGsPQw56+ocPJ6YAR
        1p5rI7Zgj5MacnWGUrfaun7qC2+wbsR4kLT0E6Rbl3nvgLgEsQQsCJQ2ong75thjlR58uH
        vu9luExPGxLQNpknKdalIwauvqqJDDI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-8r1BkopBNeWeNxHduYkg7Q-1; Mon, 18 Jul 2022 08:59:50 -0400
X-MC-Unique: 8r1BkopBNeWeNxHduYkg7Q-1
Received: by mail-wm1-f72.google.com with SMTP id v123-20020a1cac81000000b003a02a3f0beeso8669128wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=K2UbXX8GfQDSH1G+l3mYd8piXh+YvuH3CKSjlZ6grsU=;
        b=svmmZgDd2kTXqPoxfUiwUmq/jj92r6a3ke2lBj12MzOxP4LIqdIDVL+S0Hv4S7kqQ2
         9hubJo+mOtnLVuFMBQLfnSLzd/4LtnY2AirdHcnuyyENsewNzO1rIviRODA70dok80PI
         TG+b33NXlrn6BCs4/dfVvhsbaQEAQyHSl4wrhKLGGO1X1jnP5J+BFO6b1J4GMMclAZch
         4XEdqQ+0bfDFOXJ1gaaqmXLE1H/u0YXJLT/yIJsW/dvaBEXBC8NVLylJBeIYUKZkqJPV
         jxFQ/uDNxRhMou7t2kYsU5CgTCuUNdm9tbXVQQ+wDanAQEp1LRcj2HXPCE4gQpEdVhjt
         r1XQ==
X-Gm-Message-State: AJIora/M/1S3WiuW5in9nhsKPRMNj2MmTTgZVI1cxH0yc315XlKxwExF
        WLHVoe5ru47N5co51iqyvskyMzaplM+PFT+rs6OgxfSd3vE7tUJ1TMPG+TvkWd3cnecXZ7uJ3cG
        reeKE4ThfBoLHDGOZD6x5FBMa
X-Received: by 2002:a05:6000:178c:b0:21d:b6d0:11a8 with SMTP id e12-20020a056000178c00b0021db6d011a8mr22145002wrg.547.1658149188884;
        Mon, 18 Jul 2022 05:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tMP0ObufMho649BUsTLfQYnTv6deddwkT8fZ1K0Baw8tI9SuX75xAwbOo4GXdS0x9jSXR1Eg==
X-Received: by 2002:a05:6000:178c:b0:21d:b6d0:11a8 with SMTP id e12-20020a056000178c00b0021db6d011a8mr22144978wrg.547.1658149188542;
        Mon, 18 Jul 2022 05:59:48 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:7400:6b3a:a74a:bd53:a018? (p200300cbc70574006b3aa74abd53a018.dip0.t-ipconnect.de. [2003:cb:c705:7400:6b3a:a74a:bd53:a018])
        by smtp.gmail.com with ESMTPSA id o3-20020adfeac3000000b0021d6ac977fasm10766939wrn.69.2022.07.18.05.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 05:59:48 -0700 (PDT)
Message-ID: <1d3cdad0-b3a7-ec25-1652-efa7c39d1705@redhat.com>
Date:   Mon, 18 Jul 2022 14:59:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     willy@infradead.org, aneesh.kumar@linux.ibm.com, arnd@arndb.de,
        21cnbao@gmail.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1656531090.git.khalid.aziz@oracle.com>
 <20220701212403.77ab8139b6e1aca87fae119e@linux-foundation.org>
 <0864a811-53c8-a87b-a32d-d6f4c7945caa@redhat.com>
 <357da99d-d096-a790-31d7-ee477e37c705@oracle.com>
 <397f3cb2-1351-afcf-cd87-e8f9fb482059@redhat.com>
 <bca034e9-5218-5ae4-79df-8c40e0aa6d3d@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 0/9] Add support for shared PTEs across processes
In-Reply-To: <bca034e9-5218-5ae4-79df-8c40e0aa6d3d@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[sorry for not being as responsive as I usually am]

>>
>> They share a *mm* including a consistent virtual memory layout (VMA
>> list). Page table sharing is just a side product of that. You could even
>> call page tables just an implementation detail to produce that
>> consistent virtual memory layout -- described for that MM via a
>> different data structure.
> 
> Yes, sharing an mm and vma chain does make it different from implementation point of view.
> 
>>
>>> A number of people have commented on potential usefulness of this concept
>>> and implementation.
>>
>> ... and a lot of people raised concerns. Yes, page table sharing to
>> reduce memory consumption/tlb misses/... is something reasonable to
>> have. But that doesn't require mshare, as hugetlb has proven.
>>
>> The design might be useful for a handful of corner (!) cases, but as the
>> cover letter only talks about memory consumption of page tables, I'll
>> not care about those. Once these corner cases are explained and deemed
>> important, we might want to think of possible alternatives to explore
>> the solution space.
> 
> Memory consumption by page tables is turning out to be significant issue. I mentioned one real-world example from a 
> customer where a 300GB SGA on a 512GB server resulted in OOM when 1500+ processes tried to map parts of the SGA into 
> their address space. Some customers are able to solve this issue by switching to hugetlbfs but that is not feasible for 
> every one.

Yes. Another use case I am aware of are KVM-based virtual machines, when
VM memory (shmem, file-backed) is not only mapped into the emulator
process, but also into other processes used to carry out I/O (e.g.,
vhost-user).

In that case, it's tempting to simply share the page tables between all
processes for the shared mapping -- automatically, just like
shmem/hugetlb already does.

[...]

>>
>>> suggestion to extend hugetlb PMD sharing was discussed briefly. Conclusion from that discussion and earlier discussion
>>> on mailing list was hugetlb PMD sharing is built with special case code in too many places in the kernel and it is
>>> better to replace it with something more general purpose than build even more on it. Mike can correct me if I got that
>>> wrong.
>>
>> Yes, I pushed for the removal of that yet-another-hugetlb-special-stuff,
>> and asked the honest question if we can just remove it and replace it by
>> something generic in the future. And as I learned, we most probably
>> cannot rip that out without affecting existing user space. Even
>> replacing it by mshare() would degrade existing user space.
>>
>> So the natural thing to reduce page table consumption (again, what this
>> cover letter talks about) for user space (semi- ?)automatically for
>> MAP_SHARED files is to factor out what hugetlb has, and teach generic MM
>> code to cache and reuse page tables (PTE and PMD tables should be
>> sufficient) where suitable.
>>
>> For reasonably aligned mappings and mapping sizes, it shouldn't be too
>> hard (I know, locking ...), to cache and reuse page tables attached to
>> files -- similar to what hugetlb does, just in a generic way. We might
>> want a mechanism to enable/disable this for specific processes and/or
>> VMAs, but these are minor details.
>>
>> And that could come for free for existing user space, because page
>> tables, and how they are handled, would just be an implementation detail.
>>
>>
>> I'd be really interested into what the major roadblocks/downsides
>> file-based page table sharing has. Because I am not convinced that a
>> mechanism like mshare() -- that has to be explicitly implemented+used by
>> user space -- is required for that.
>>
> 
> I see two parts to what you are suggesting (please correct me if I get this wrong):
> 
> 1. Implement a generic page table sharing mechanism
> 2. Implement a way to use this mechanism from userspace

Yes. Whereby 2) would usually just be some heuristic (e.g.,. file > X
MiB -> start sharing), with an additional way to just disable it or just
enable it. But yes, most of that stuff should just be automatic.

> 
> For 1, your suggestion seems to be extract the page table sharing code from hugetlb and make it generic. My approach is 
> to create a special mm struct to host the shared page tables and create a minimal set of changes to simply get PTEs from 
> this special mm struct whenever a shared VMA is accessed. There may be value to extracting hugetlb page table sharing 
> code and recasting it into this framework of special mm struct. I will look some more into it.

The basic idea would be that whenever a MAP_SHARED VMA has a reasonable
size, is aligned in a suitable way (including MAP offset), and
protection match, you can just share PTE tables and even PMD tables. As
page tables of shared mappings usually don't really store per-process
information (exceptions I am aware of are userfaultfd and softdirty
tracking), we can simply share/unshare page tables of shared mappings
fairly easily.

Then, you'd have e.g., 2 sets of page tables cached by the fd that can
be mapped into processes

1) PROT_READ|PROT_WRITE
2) PROT_READ

On VMA protection changes, one would have to unshare (unmap the page
table) and either map another shared one, or map a private one. I don't
think there would be need to optimize e.g., for PROT_NONE, but of
course, other combinations could make sense to cache.


PROT_NONE and other corner cases (softdirty tracking) would simply not
use shared page tables.

Shared page tables would have to be refcounted and one could e.g.,
implement a shrinker that frees unused page tables in the fd cache when
memory reclaim kicks in.

With something like that in place, page table consumption could be
reduced and vmscan/rmap walks could turn out more efficient.

> 
> As for 2, is it fair to say you are not fond of explicit opt-in from userspace and would rather have the sharing be file 
> based like hugetlb? That is worth considering but is limiting page table sharing to just file objects reasonable? A goal 
> for mshare mechanism was to allow shared objects to be files, anonymous pages, RDMA buffers, whatever. Idea being if you 
> can map it, you can share it with shared page tables. Maybe that is too ambitious a goal and I am open to course correction.


We can glue it to the file or anything else that's shared I think  -- I
don't think we particularly, as long as it's something shared between
processes to be mapped. And to be quite honest, whenever I read about
anonymous memory (i.e., MAP_PRIVATE) I hear my inner voice screaming:
just use *shared* memory when you want to *share* memory between
processes, and optimize that if anything is missing.


Having that said, I understood from previous discussions that there is a
use case of efficient read-only protection across many processes/VMAs. I
was wondering if that could be handled on the fs-level (pte_mkwrite). I
remember I raised the idea before: if one could have a
userfaultfd-wp-style (overlay?) file (system?), user-space could
protect/unprotect file pages via a different mechanism (ioctl) and get
notified about write access via something similar to userfaultfd
user-space handlers, not via signals. Instead of adjusting VMAs, once
would only adjust file page mappings to map the relevant pages R/O when
protecting -- if page tables are shared, that would be efficient.


Now, that is is just a very vague brain dump to get it out of my
(overloaded) system. What I think the overall message is: let's try not
designing new features around page table sharing, let's use page table
sharing as an rmap performance optimization and as a mechanism to reduce
page table overhead. I hope what I said makes any sense, I might eb just
wrong.

-- 
Thanks,

David / dhildenb

