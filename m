Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24FC50670A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344055AbiDSIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239668AbiDSIjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B5F3BCAF
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650357421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnMJ9ywnBIFP4M8MuTgoMOK9AEp0ugOOoXrG4A3yfew=;
        b=Y2JrlzEbPf3+1LFbO9PDxaU6aubI8HcYj6jgGcHXq/DLW5xkm6+AnrWNIfDBOeyZTQ5u9i
        KzfP8gqdcuyZe4t0bQk5cKFFAsDMJXpB+04KqiS/mO3EiM1xVMYE0fi3mPshRGavkL1rQU
        GkZAxr6V0V6lWVA+NYq/gEJeVSSWFMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-M6FE-qsHPLWXSxxv5t7Zqg-1; Tue, 19 Apr 2022 04:37:00 -0400
X-MC-Unique: M6FE-qsHPLWXSxxv5t7Zqg-1
Received: by mail-wm1-f71.google.com with SMTP id q188-20020a1c43c5000000b003928f679c42so3850081wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:36:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=WnMJ9ywnBIFP4M8MuTgoMOK9AEp0ugOOoXrG4A3yfew=;
        b=Vz/ei+2z8yo/7eMCoOn0T84X+tn7F8PUmmjlcWy6T2e40am8pgyMDIUR/1zsIVPsEj
         Ho4dKhZwt6E+IjDJpGCYXr3BIVH0XuvikAh+WcidLhGXyXWdS30UWKwjNkWPzSwbBoyk
         odQ2Ap6cHUIF0A79ItaeeAWxBETqECrL/eAbvYeFApfnXqExJa4TOy7UXsYxOvQhfpyl
         TM/FcoVUSst7Sci+2/aZTT+x1A2mroOtWo//dIrj6Hv3WbmmzKajvlOdB99I0hZYZ3nn
         dRvdTuwrWisIMgnfwUShKebybXdavpt6Ijijg8rexPBQLjxKGqxwQvHhAaNgIg6z2Pu6
         wDag==
X-Gm-Message-State: AOAM532Gn5spXnYFQa8S9alv/DtpRBkgKrJCYxsGBRwZ/EW8EGx+4pxX
        tnm+B8wrKErDheMeDD47g1iHWuXXwjyjoTAwzbLRvy7A+Y4iHQcLUKCv/lsxeHMWuVpP13LVQbD
        jzAiNhHjSehibLzarQPJz65Br
X-Received: by 2002:a05:600c:6006:b0:38f:fb25:3bb4 with SMTP id az6-20020a05600c600600b0038ffb253bb4mr18659073wmb.78.1650357418842;
        Tue, 19 Apr 2022 01:36:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaPeRvsg+hm7qbcI0vbbUnTRkmhWKW9PLwuKhUeIxGzqU9k7DzwO7OWYuZ4hBvrjXSYC5sjw==
X-Received: by 2002:a05:600c:6006:b0:38f:fb25:3bb4 with SMTP id az6-20020a05600c600600b0038ffb253bb4mr18659021wmb.78.1650357418594;
        Tue, 19 Apr 2022 01:36:58 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600002cb00b0020a88c4ecb5sm7661533wry.3.2022.04.19.01.36.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:36:58 -0700 (PDT)
Message-ID: <57e2e54e-ccdf-a2b8-25cd-72848359533c@redhat.com>
Date:   Tue, 19 Apr 2022 10:36:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Don Dutile <ddutile@redhat.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Liang Zhang <zhangliang5@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Nadav Amit <namit@vmware.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        Peter Xu <peterx@redhat.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20220419075954.GA4699@xsang-OptiPlex-9020>
 <3dfc5379-3ca8-243e-e11c-782599863fcc@redhat.com>
Organization: Red Hat
Subject: Re: [x86/pgtable] d1ec551f87: BUG:Bad_page_map_in_process
In-Reply-To: <3dfc5379-3ca8-243e-e11c-782599863fcc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 10:22, David Hildenbrand wrote:
> On 19.04.22 09:59, kernel test robot wrote:
>>
>>
>> Greeting,
>>
>> FYI, we noticed the following commit (built with clang-15):
>>
>> commit: d1ec551f874e1663bfe76b994c0010a4566cf936 ("x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE")
>> https://github.com/hnaz/linux-mm master
>>
>> in testcase: trinity
>> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
>> with following parameters:
>>
>> 	runtime: 300s
>> 	group: group-01
>>
>> test-description: Trinity is a linux system call fuzz tester.
>> test-url: http://codemonkey.org.uk/projects/trinity/
>>
>>
>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>
>>
>> [   40.201103][ T5099] BUG: Bad page map in process trinity-c7  pte:1713003a pmd:7ff71067
>> [   40.201999][ T5099] addr:096e7000 vm_flags:00100073 anon_vma:bff0aa00 mapping:00000000 index:96e7
>> [   40.202718][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
>> [   40.203229][ T5099] CPU: 0 PID: 5099 Comm: trinity-c7 Not tainted 5.18.0-rc2-mm1-00053-gd1ec551f874e #1
>> [   40.203952][ T5099] Call Trace:
>> [ 40.204195][ T5099] ? dump_stack_lvl (??:?) 
>> [ 40.204581][ T5099] ? dump_stack (??:?) 
>> [ 40.204970][ T5099] ? print_bad_pte (memory.c:?) 
>> [ 40.205384][ T5099] ? unmap_page_range (??:?) 
>> [ 40.205843][ T5099] ? unmap_single_vma (memory.c:?) 
>> [ 40.206271][ T5099] ? unmap_vmas (??:?) 
>> [ 40.206647][ T5099] ? exit_mmap (??:?) 
>> [ 40.207032][ T5099] ? __mmput (fork.c:?) 
>> [ 40.207405][ T5099] ? mmput (??:?) 
>> [ 40.207751][ T5099] ? exit_mm (exit.c:?) 
>> [ 40.208121][ T5099] ? do_exit (??:?) 
>> [ 40.208497][ T5099] ? do_group_exit (??:?) 
>> [ 40.208905][ T5099] ? trace_hardirqs_on (??:?) 
>> [ 40.209345][ T5099] ? get_signal (??:?) 
>> [ 40.209750][ T5099] ? arch_do_signal_or_restart (??:?) 
>> [ 40.210287][ T5099] ? exit_to_user_mode_loop (common.c:?) 
>> [ 40.210778][ T5099] ? exit_to_user_mode_prepare (common.c:?) 
>> [ 40.211302][ T5099] ? syscall_exit_to_user_mode (??:?) 
>> [ 40.211808][ T5099] ? ret_from_fork (??:?) 
>> [   40.212268][ T5099] Disabling lock debugging due to kernel taint
>> [   40.231123][ T5097] BUG: Bad page map in process trinity-c5  pte:171e0a3e pmd:0a8d3067
>> [   40.231770][ T5099] BUG: Bad page map in process trinity-c7  pte:1713023a pmd:7ff71067
>> [   40.231883][ T5097] addr:36ed5000 vm_flags:000000fb anon_vma:00000000 mapping:485d0d80 index:1
>> [   40.232611][ T5099] addr:096e8000 vm_flags:00100073 anon_vma:bff0ab18 mapping:00000000 index:96e8
>> [   40.233429][ T5097] file:dev/zero fault:shmem_fault mmap:shmem_mmap readpage:0x0
>> [   40.234271][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
>> [   40.234971][ T5097] CPU: 1 PID: 5097 Comm: trinity-c5 Tainted: G    B             5.18.0-rc2-mm1-00053-gd1ec551f874e #1
>> [   40.236510][ T5097] Call Trace:
> 
> This is 32bit (i386) I assume. I wonder if something about the 32bit swp
> layout is special and we have to restrict it to 64bit here.
> 

Staring at arch/x86/include/asm/pgtable-2level.h, I think that's the case:
The swp type effectively starts at "_PAGE_BIT_PRESENT + 1" which should be bit 1.

Let's restrict this to x86-64 for now.

I think this is similar to CONFIG_HAVE_ARCH_SOFT_DIRTY, which depends on 64 bit.


The following should do the trick:

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e42e668153e9..a1c555abed26 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1291,7 +1291,7 @@ static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
                unsigned long addr, pud_t *pud)
 {
 }
-
+#ifdef _PAGE_SWP_EXCLUSIVE
 #define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
 static inline pte_t pte_swp_mkexclusive(pte_t pte)
 {
@@ -1307,6 +1307,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
 {
        return pte_clear_flags(pte, _PAGE_SWP_EXCLUSIVE);
 }
+#endif /* _PAGE_SWP_EXCLUSIVE */
 
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline pte_t pte_swp_mksoft_dirty(pte_t pte)
diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 54a8f370046d..95403ae1f2e5 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -83,10 +83,12 @@
 #define _PAGE_SOFT_DIRTY       (_AT(pteval_t, 0))
 #endif
 
+#ifdef CONFIG_64BIT
 /*
- * We borrow bit 3 to remember PG_anon_exclusive.
+ * We borrow bit 3 on x86-64 to remember PG_anon_exclusive.
  */
 #define _PAGE_SWP_EXCLUSIVE    _PAGE_PWT
+#endif /* CONFIG_64BIT */
 
 /*
  * Tracking soft dirty bit when a page goes to a swap is tricky.


Thoughts?


-- 
Thanks,

David / dhildenb

