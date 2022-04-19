Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0B1506CFF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 15:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350741AbiDSNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345109AbiDSNDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 09:03:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 111ED369C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650373257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLOJ4F6pBmMwGa31B+998k0ukUEKp4XF0IndkeLpGJo=;
        b=ab5PpwPjILN8tjVV/d49HRC0pe2zf6Jsb2MIQIQdR+Vqy9uWhJ4czJXxBCOugFFUUENvUZ
        RZl3R964Rp25t4vHTLwo6z2A8gIDc7CNNXCNsYI0xOwPi+BZ8riyUSdk7+NJGuPvo0Btx6
        z8i+HtJDDvg3+Vqh6FXsaaH2eSx8QFw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-270-jphb6MMnNh2N7bGp-Mf9gw-1; Tue, 19 Apr 2022 09:00:56 -0400
X-MC-Unique: jphb6MMnNh2N7bGp-Mf9gw-1
Received: by mail-wm1-f72.google.com with SMTP id h65-20020a1c2144000000b0038e9ce3b29cso1315166wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 06:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:organization:in-reply-to
         :content-transfer-encoding;
        bh=OLOJ4F6pBmMwGa31B+998k0ukUEKp4XF0IndkeLpGJo=;
        b=aOt+k1yECUSwwp7MXtF64lxxubzR7vQ5YULcGXjsQ93E5xcNCPm1kURpyr4sqGbHtd
         C6CMK/S3Gj51GuDNFNp2vxnvbJc9fXsti8sIzmI7mTi68URjplIdqVx6aBFEm60sngdN
         MREjkwARyCUJSWbDLUUg/3pHo5zMVEa4G1JvOTqJM+QP9Vg7vpepEgqi2j0ewe3ttdsh
         femWC3Moqi7yqksiIMxVjuqyfj1LnkSGCbGwh5CreTZKHgmX2B5OwIXptMlVW4ss9Mfd
         BPYM2lHoX4KoniS2s23IUrR0RvKC49QZmOtkV/2fwLpJAqqrB8Tn/A5HCRwGAFLKLx+2
         uNZg==
X-Gm-Message-State: AOAM5317Q2kbYEPP3weE3jJoLuI3Yzi0oF/OVT3c5pXyxmjff7xNxDJn
        sLH1a9FaW08uPwCuJ+1JoQl8sqTxVQBJ0sjZODc+jE9VJ/wm+MGIE7Vc/FiibtOvzayxZkzc6B2
        FXwQkvkF3kLGVEe+f3X106au8
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id bh14-20020a05600c3d0e00b0038ff83be7dcmr19917664wmb.29.1650373254757;
        Tue, 19 Apr 2022 06:00:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyq6wKXGRTF8K8MWxDiaKsc1qPBwD4BcELS88q6h8ptYO3rNWRo0FTAGLYk1mE9amWocTrsBA==
X-Received: by 2002:a05:600c:3d0e:b0:38f:f83b:e7dc with SMTP id bh14-20020a05600c3d0e00b0038ff83be7dcmr19917631wmb.29.1650373254403;
        Tue, 19 Apr 2022 06:00:54 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id b1-20020a5d40c1000000b00207b49d3023sm12319989wrq.44.2022.04.19.06.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 06:00:52 -0700 (PDT)
Message-ID: <232bfdd0-4749-1c8c-3342-ece1c4b33fd5@redhat.com>
Date:   Tue, 19 Apr 2022 15:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [x86/pgtable] d1ec551f87: BUG:Bad_page_map_in_process
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
 <57e2e54e-ccdf-a2b8-25cd-72848359533c@redhat.com>
Organization: Red Hat
In-Reply-To: <57e2e54e-ccdf-a2b8-25cd-72848359533c@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.04.22 10:36, David Hildenbrand wrote:
> On 19.04.22 10:22, David Hildenbrand wrote:
>> On 19.04.22 09:59, kernel test robot wrote:
>>>
>>>
>>> Greeting,
>>>
>>> FYI, we noticed the following commit (built with clang-15):
>>>
>>> commit: d1ec551f874e1663bfe76b994c0010a4566cf936 ("x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE")
>>> https://github.com/hnaz/linux-mm master
>>>
>>> in testcase: trinity
>>> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
>>> with following parameters:
>>>
>>> 	runtime: 300s
>>> 	group: group-01
>>>
>>> test-description: Trinity is a linux system call fuzz tester.
>>> test-url: http://codemonkey.org.uk/projects/trinity/
>>>
>>>
>>> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
>>>
>>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>>
>>>
>>>
>>> If you fix the issue, kindly add following tag
>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>
>>>
>>> [   40.201103][ T5099] BUG: Bad page map in process trinity-c7  pte:1713003a pmd:7ff71067
>>> [   40.201999][ T5099] addr:096e7000 vm_flags:00100073 anon_vma:bff0aa00 mapping:00000000 index:96e7
>>> [   40.202718][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
>>> [   40.203229][ T5099] CPU: 0 PID: 5099 Comm: trinity-c7 Not tainted 5.18.0-rc2-mm1-00053-gd1ec551f874e #1
>>> [   40.203952][ T5099] Call Trace:
>>> [ 40.204195][ T5099] ? dump_stack_lvl (??:?) 
>>> [ 40.204581][ T5099] ? dump_stack (??:?) 
>>> [ 40.204970][ T5099] ? print_bad_pte (memory.c:?) 
>>> [ 40.205384][ T5099] ? unmap_page_range (??:?) 
>>> [ 40.205843][ T5099] ? unmap_single_vma (memory.c:?) 
>>> [ 40.206271][ T5099] ? unmap_vmas (??:?) 
>>> [ 40.206647][ T5099] ? exit_mmap (??:?) 
>>> [ 40.207032][ T5099] ? __mmput (fork.c:?) 
>>> [ 40.207405][ T5099] ? mmput (??:?) 
>>> [ 40.207751][ T5099] ? exit_mm (exit.c:?) 
>>> [ 40.208121][ T5099] ? do_exit (??:?) 
>>> [ 40.208497][ T5099] ? do_group_exit (??:?) 
>>> [ 40.208905][ T5099] ? trace_hardirqs_on (??:?) 
>>> [ 40.209345][ T5099] ? get_signal (??:?) 
>>> [ 40.209750][ T5099] ? arch_do_signal_or_restart (??:?) 
>>> [ 40.210287][ T5099] ? exit_to_user_mode_loop (common.c:?) 
>>> [ 40.210778][ T5099] ? exit_to_user_mode_prepare (common.c:?) 
>>> [ 40.211302][ T5099] ? syscall_exit_to_user_mode (??:?) 
>>> [ 40.211808][ T5099] ? ret_from_fork (??:?) 
>>> [   40.212268][ T5099] Disabling lock debugging due to kernel taint
>>> [   40.231123][ T5097] BUG: Bad page map in process trinity-c5  pte:171e0a3e pmd:0a8d3067
>>> [   40.231770][ T5099] BUG: Bad page map in process trinity-c7  pte:1713023a pmd:7ff71067
>>> [   40.231883][ T5097] addr:36ed5000 vm_flags:000000fb anon_vma:00000000 mapping:485d0d80 index:1
>>> [   40.232611][ T5099] addr:096e8000 vm_flags:00100073 anon_vma:bff0ab18 mapping:00000000 index:96e8
>>> [   40.233429][ T5097] file:dev/zero fault:shmem_fault mmap:shmem_mmap readpage:0x0
>>> [   40.234271][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
>>> [   40.234971][ T5097] CPU: 1 PID: 5097 Comm: trinity-c5 Tainted: G    B             5.18.0-rc2-mm1-00053-gd1ec551f874e #1
>>> [   40.236510][ T5097] Call Trace:
>>
>> This is 32bit (i386) I assume. I wonder if something about the 32bit swp
>> layout is special and we have to restrict it to 64bit here.
>>
> 
> Staring at arch/x86/include/asm/pgtable-2level.h, I think that's the case:
> The swp type effectively starts at "_PAGE_BIT_PRESENT + 1" which should be bit 1.

Updated patch in

https://lkml.kernel.org/r/d875c292-46b3-f281-65ae-71d0b0c6f592@redhat.com


-- 
Thanks,

David / dhildenb

