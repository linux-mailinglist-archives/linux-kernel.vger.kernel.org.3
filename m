Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E48A49E1C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiA0L6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbiA0L5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643284670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqTgSqJnVrLVP8MoWTF2B7JIB+LN5M/sJxbL4amwDn4=;
        b=LCPDeDAtiA/PEPftCpxgS0HwgqLal9hO5L90gVyeECCZpZvxMw/sdmpDbQSVCUmI9b1hss
        R4SlyZY2yI9zbGdS1qmE7Q7dVDN/ZdrqzDqfMAQ0ratncTwe5RuTdNWQkXz6DcnRaBFJfG
        rBCnBDVxBHzDxIt+iZGlzk2OFogkCkU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-HBEBRmsDMDSwkTFqwdPCWA-1; Thu, 27 Jan 2022 06:57:49 -0500
X-MC-Unique: HBEBRmsDMDSwkTFqwdPCWA-1
Received: by mail-wm1-f72.google.com with SMTP id m3-20020a7bcb83000000b0034f75d92f27so1395972wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 03:57:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=GqTgSqJnVrLVP8MoWTF2B7JIB+LN5M/sJxbL4amwDn4=;
        b=iGGEb/vh2wIvN478tvra3WVZFu2JzoQdrTxYwlSWqTtbh0+Pa0nMN0EA/0CGoM9U7G
         Vabl0oLU+4OOmoze5v9LLC65dTsTXiUkiNnATPWftcOCmBb2mFI2TeckqKX8F8fnBI8z
         JJt35G1S1s6hHTik4o9G0axKeDA1bjSNpUjV1bx7cC0815JMDK+h9z0fcJUWuPDHSMU9
         MD0dABAyvflgAKIlZ1dCbNcEd37VaDoPmra+KlNBb0fcHMxsPFNo6HnEVPKZeMLq87OS
         lBXQ15octsKmgm49NtfBxCCTFcV7RnFvnXo44bLxMOAd4dkBbFM33HDuifpmjLmPpMrp
         HDfg==
X-Gm-Message-State: AOAM533iUvR6ejGyeVVV6Ejm/vGryYRESVxCDKAqUov52RV2sb62G71Y
        ElOZ77KuBhlXGfljT4SEg1XDUyFewXehGQtDF36WWp7wgRIViKpnMOJ1dBHzx8OI6xtORkLfCn/
        pN7mexIWaPMg+/64BPdmSpH7k
X-Received: by 2002:a05:600c:2d52:: with SMTP id a18mr4339141wmg.69.1643284667926;
        Thu, 27 Jan 2022 03:57:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7aKtyvGliXs6H0xr9fl7ALMHwt2lQzThUbe/NooyXhepg8VASewJoe2mr08jK+JCTPTHSAw==
X-Received: by 2002:a05:600c:2d52:: with SMTP id a18mr4339124wmg.69.1643284667709;
        Thu, 27 Jan 2022 03:57:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id o12sm2394747wry.115.2022.01.27.03.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 03:57:47 -0800 (PST)
Message-ID: <b476e461-aba9-e92b-d392-270029ab6b18@redhat.com>
Date:   Thu, 27 Jan 2022 12:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220113180308.15610-1-mike.kravetz@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH 0/3] Add hugetlb MADV_DONTNEED support
In-Reply-To: <20220113180308.15610-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.22 19:03, Mike Kravetz wrote:
> Userfaultfd selftests for hugetlb does not perform UFFD_EVENT_REMAP
> testing.  However, mremap support was recently added in commit
> 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed
> vma").  While attempting to enable mremap support in the test, it was
> discovered that the mremap test indirectly depends on MADV_DONTNEED.
> 
> hugetlb does not support MADV_DONTNEED.  However, the only thing
> preventing support is a check in can_madv_lru_vma().  Simply removing
> the check will enable support.
> 
> This is sent as a RFC because there is no existing use case calling
> for hugetlb MADV_DONTNEED support except possibly the userfaultfd test.
> However, adding support makes sense as it is fairly trivial and brings
> hugetlb functionality more in line with 'normal' memory.
> 

Just a note:

QEMU doesn't use huge anonymous memory directly (MAP_ANON | MAP_HUGE...)
but instead always goes either via hugetlbfs or via memfd. 

For MAP_PRIVATE hugetlb mappings, fallocate(FALLOC_FL_PUNCH_HOLE) seems
to get the job done (IOW: also discards private anon pages). See the
comments in the QEMU code below. I remember that that is somewhat
inconsistent. For ordinary MAP_PRIVATE mapped files I remember that we
always need fallocate(FALLOC_FL_PUNCH_HOLE) + madvise(QEMU_MADV_DONTNEED)
to make sure

a) All file pages are removed
b) All private anon pages are removed

IIRC hugetlbfs really is different in that regard, but maybe other fs
behave similarly.

That's why QEMU was able to live for now without MADV_DONTNEED support
for hugetlbfs and most probably won't ever need it.


...
       /* The logic here is messy;
         *    madvise DONTNEED fails for hugepages
         *    fallocate works on hugepages and shmem
         *    shared anonymous memory requires madvise REMOVE
         */
        need_madvise = (rb->page_size == qemu_host_page_size);
        need_fallocate = rb->fd != -1;
        if (need_fallocate) {
            /* For a file, this causes the area of the file to be zero'd
             * if read, and for hugetlbfs also causes it to be unmapped
             * so a userfault will trigger.
             */
#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
            ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
                            start, length);
            if (ret) {
                ret = -errno;
                error_report("ram_block_discard_range: Failed to fallocate "
                             "%s:%" PRIx64 " +%zx (%d)",
                             rb->idstr, start, length, ret);
                goto err;
            }
#else
            ret = -ENOSYS;
            error_report("ram_block_discard_range: fallocate not available/file"
                         "%s:%" PRIx64 " +%zx (%d)",
                         rb->idstr, start, length, ret);
            goto err;
#endif
        }
        if (need_madvise) {
            /* For normal RAM this causes it to be unmapped,
             * for shared memory it causes the local mapping to disappear
             * and to fall back on the file contents (which we just
             * fallocate'd away).
             */
#if defined(CONFIG_MADVISE)
            if (qemu_ram_is_shared(rb) && rb->fd < 0) {
                ret = madvise(host_startaddr, length, QEMU_MADV_REMOVE);
            } else {
                ret = madvise(host_startaddr, length, QEMU_MADV_DONTNEED);
            }
            if (ret) {
                ret = -errno;
                error_report("ram_block_discard_range: Failed to discard range "
                             "%s:%" PRIx64 " +%zx (%d)",
                             rb->idstr, start, length, ret);
                goto err;
            }
#else
...

-- 
Thanks,

David / dhildenb

