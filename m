Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F814951BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 16:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376719AbiATPqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 10:46:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42206 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1376526AbiATPqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 10:46:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642693610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k/5oDSEKAI+/3TV9NwB0N2XtkiyuWHR+WNC36iPivc8=;
        b=ZCmtk2VqSW1hAwMJyxW1hySfKA9oVNMim0JNiQoCGkDkhWNK3d72WrUdDvQ6rwfkH/gWFE
        Xh1h/BYCx/yHRSSvb1aelz5q5qszYgv7NA3SD5khcc0ZMljCaDlhZZE06CQLPhA5lwQKvG
        eDRrTuZCRK+G0q87Ny6BNh7jzhDNcAc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-349-jCtfsRnkPReppT7H7rNiCg-1; Thu, 20 Jan 2022 10:46:48 -0500
X-MC-Unique: jCtfsRnkPReppT7H7rNiCg-1
Received: by mail-wm1-f72.google.com with SMTP id n19-20020a05600c501300b0034d7b01ae4dso2658166wmr.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 07:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=k/5oDSEKAI+/3TV9NwB0N2XtkiyuWHR+WNC36iPivc8=;
        b=uNmCWF4w3zTghZJNQOsnu17RgHnFojbwtuUUO3Yjd8F1lacONpFDcrj5wbcwIU9vu1
         eAOdZ7/ntuBT9in4pNtuoODDUl5qTrUKf23CGCfb9ipvsZRhhe3BWOk5Zx8+67sKTnmj
         XQOuKtmWoHZTCHLl823CnkhMIQ1qBlfALVZD9kkf7fC6GvJN1qhDcLjr7meVfiSmgI7o
         kZzPS5IBsZpTpltPsDKQAOnsuGqIq5FYwvG4jSN03JEen0SKs7HjwdxpM9WfYkUHqkHI
         d9g/NW7dm5ieuP+ZLKrHVquMH71dMj5MBB28m79SmZYiSiJL6x+Xi3MPrjKQF2exroVJ
         6Njw==
X-Gm-Message-State: AOAM530MnM1RilrU8ULpJ1bsHYgr0cTFRgYr/A0h2EQf9UnQrvnPQ3kR
        i2rUPKva+OjZcqdUsn+QcLvJSIzmG7KLdxCPQEWohL3fER4H05Y1YWmYMhbOirX83TuwUelZ7Zc
        jsDUuORB7DhKKEuuo4BaEcixb
X-Received: by 2002:a05:6000:1847:: with SMTP id c7mr26253101wri.208.1642693607426;
        Thu, 20 Jan 2022 07:46:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJohrkZNy/iWIo66cNGJER440aawNTMtsXKE1/AVsoCkjl/Oqm8OEG71FjJLWxut/ARKJHJw==
X-Received: by 2002:a05:6000:1847:: with SMTP id c7mr26253085wri.208.1642693607192;
        Thu, 20 Jan 2022 07:46:47 -0800 (PST)
Received: from ?IPV6:2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1? (p200300cbc70e58000eebdae2b1c0f5d1.dip0.t-ipconnect.de. [2003:cb:c70e:5800:eeb:dae2:b1c0:f5d1])
        by smtp.gmail.com with ESMTPSA id f8sm248927wry.46.2022.01.20.07.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jan 2022 07:46:46 -0800 (PST)
Message-ID: <43e41259-b228-2a75-e59d-0c6a1e81912f@redhat.com>
Date:   Thu, 20 Jan 2022 16:46:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com
References: <20220113140318.11117-1-zhangliang5@huawei.com>
 <YeA5oP/iaxtVPHb3@casper.infradead.org>
 <CAHk-=wjB0i-B=U-DhpAajQx3f6bp1X==neLOrg0jwq29mgz=3g@mail.gmail.com>
 <172ccfbb-7e24-db21-7d84-8c8d8c3805fd@redhat.com>
 <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <CAHk-=wjBFF_EJHVRe48jAjb7Xwu0aRNejyefzLOAGW_qnNu=-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.01.22 16:37, Linus Torvalds wrote:
> On Thu, Jan 20, 2022 at 5:26 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> So your claim is that read-only, PTE mapped pages are weird? How do you
>> come to that conclusion?
>>
>> If we adjust the THP reuse logic to split on additional references
>> (page_count() == 1) -- similarly as suggested by Linus to fix the CVE --
>> we're going to end up with exactly that more frequently.
> 
> If you write to a THP page that has page_count() elevated - presumably
> because of a fork() - then that COW is exactly what you want to
> happen.
> 
> And presumably you want it to happen page-by-page.
> 
> So I fail to see what the problem is.
> 
> The *normal* THP case is that there hasn't been a fork, and there is
> no COW activity. That's the only thing worth trying to optimize for
> and worry about.
> 
> If you do some kind of fork with huge-pages, and actually write to
> those pages (as opposed to just execve() in the child and wait in the
> parent), you only have yourself to blame. You *will* take COW faults,
> and you have to do it, and at that point spliting the THP in whoever
> did the COW is likely the right thing to do just to hope that you
> don't have to allocate a whole new hugepage. So it will cause new
> (small-page) allocations and copies.
> 
> And yes, at that point, writes to the THP page will cause COW's for
> both sides as they both end up making that "split it" decision.
> 
> Honestly, would anything else ever even make sense?
> 
> If you care about THP performance, you make sure that the COW THP case
> simply never happens.

I'm, not concerned about fork(), I'm concerned about other false positives.

Here is what I currently have, I hope that makes sense:

commit f8fe5e15e04f7563606d58daee795aa0cc0e454c (HEAD)
Author: David Hildenbrand <david@redhat.com>
Date:   Fri Jan 14 09:53:35 2022 +0100

    mm/huge_memory: streamline COW logic in do_huge_pmd_wp_page()
    
    We currently have a different COW logic for THP than we have for
    ordinary pages in do_wp_page(): the effect is that the issue reported in
    CVE-2020-29374 is currently still possible for THP: a child process can
    observe memory modifications of the parent process to MAP_PRIVATE pages.
    
    Let's apply the same logic (page_count() == 1), conditionally trying to
    remove the page from the swapcache after freeing the swap entry, however,
    before actually mapping our page.
    
    Note that KSM does not apply to THP and that we won't be waiting on
    writeback. In the future, we might want to wait for writeback in case
    the page is not swapped by any other process. For now, let's keep it
    simple.
    
    If we find a page_count() > 1, we'll have to split and fallback to
    do_wp_page(), which will copy the page.
    
    This change has the following effects:
    
    (1) Mapping a THP with GUP references read-only and triggering a write
    fault will result in a split and disconnect of GUP from the actual page
    table just as we know it for ordinary pages already: this will require a
    fix for all anonymous pages, for example, by marking anon pages exclusive
    to a single process and allowing GUP pins only on exclusive anon pages.
    
    (2) Additional references on the compound page, or concurrent writeback,
    will now result in the THP getting mapped via PTEs, whereby each PTE
    requires a reference on the compound page. Once we have a PTE-mapped
    PMD, do_wp_page() will always copy and never reuse.
    
    Signed-off-by: David Hildenbrand <david@redhat.com>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 406a3c28c026..a4f2754142aa 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1303,7 +1303,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
        page = pmd_page(orig_pmd);
        VM_BUG_ON_PAGE(!PageHead(page), page);
 
-       /* Lock page for reuse_swap_page() */
        if (!trylock_page(page)) {
                get_page(page);
                spin_unlock(vmf->ptl);
@@ -1319,10 +1318,14 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
        }
 
        /*
-        * We can only reuse the page if nobody else maps the huge page or it's
-        * part.
+        * See do_wp_page(): we can reuse only if there are no additional
+        * references (page_count() is 1). Try to free the swapcache to get
+        * rid of the swapcache references in case it's likely that we will
+        * succeed.
         */
-       if (reuse_swap_page(page)) {
+       if (PageSwapCache(page) && page_count(page) == 1 + thp_nr_pages(page))
+               try_to_free_swap(page);
+       if (page_count(page) == 1) {
                pmd_t entry;
                entry = pmd_mkyoung(orig_pmd);
                entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);


-- 
Thanks,

David / dhildenb

