Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249905066DA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349953AbiDSIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349948AbiDSIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:25:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A2A93299A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650356563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ptyc/nwnssd7QfxCHQ6oXajiLqE1vMeJ+5Yl6y1S+s=;
        b=MN5xA/1q8OFvSlWDjRM8yhV38AcsUcQ/0mSzKJ33BvxtWL2YLG4u8btRCEoivpmSQIEqJm
        KT+o8hXNePCOibwjMeHCpwhLzdkLkEJ0ZSRPJ1aqxPUZUQZs3rU/vwFS23uspHGvbYFJ7U
        2WyakWDPufDSfR8vu45NPjAtFTl1lgs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-lUkPiOEDPQK-yl215jLkPA-1; Tue, 19 Apr 2022 04:22:39 -0400
X-MC-Unique: lUkPiOEDPQK-yl215jLkPA-1
Received: by mail-wr1-f71.google.com with SMTP id e2-20020adfa442000000b0020a91fa37b9so486567wra.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=3ptyc/nwnssd7QfxCHQ6oXajiLqE1vMeJ+5Yl6y1S+s=;
        b=4RIS8i9/UKRvpmabs9j6b/vqeP2CCHFHRxD+693S2xWppYKEUOuvL029WHDJXtjVEL
         JFyJCvllehaxsiAjB2z5lyQmJfzo9IuoI1knfQrFEOHtZeIAC6UdrmelkZUFKc4k+DEK
         VKECaCqQQrI/n6upePHu2B3t9ofxJJmO052B0mDEUSwhvTTti7I7oGNLQE6mEXapL+P1
         Wo5qPnMvzPTY3vNTF6Ui2oI6gdXC/cuDxLXOSPRQ5V6OYOsyX/TWII3Vt1bnNsaxfWK6
         77NeDQSrjP1ueVIdwcQfCgTLPqLBFB0Ef09V5Dh7v/c6+bd0o2ti5QF6A+D3wajnUj9g
         GM3Q==
X-Gm-Message-State: AOAM5308gaQCkTo2cHBcD3gcc7nQBmxQdHSxTPztoyMG4UKvqWI3AIx8
        Y7wUy1GOXkDEeIsDkqXsmqdk2hD3E0J9l7x3Fy+OOb9VQ1DxYpjCcRifmiozzSFcxGhAcv6dK+X
        o3fMM0586RG2RcZJNQ8m9ixEr
X-Received: by 2002:adf:eece:0:b0:20a:7bc8:d51 with SMTP id a14-20020adfeece000000b0020a7bc80d51mr11377319wrp.339.1650356558258;
        Tue, 19 Apr 2022 01:22:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDBITLe9aeF1KWDuFJFf1I//q3THBWsnqvuSa8/AeFIYWqZxs3jb5VjViGxbfb+qiemkehBA==
X-Received: by 2002:adf:eece:0:b0:20a:7bc8:d51 with SMTP id a14-20020adfeece000000b0020a7bc80d51mr11377299wrp.339.1650356557941;
        Tue, 19 Apr 2022 01:22:37 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600c354d00b003928fd158a4sm7999492wmq.29.2022.04.19.01.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 01:22:37 -0700 (PDT)
Message-ID: <3dfc5379-3ca8-243e-e11c-782599863fcc@redhat.com>
Date:   Tue, 19 Apr 2022 10:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [x86/pgtable] d1ec551f87: BUG:Bad_page_map_in_process
Content-Language: en-US
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220419075954.GA4699@xsang-OptiPlex-9020>
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

On 19.04.22 09:59, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with clang-15):
> 
> commit: d1ec551f874e1663bfe76b994c0010a4566cf936 ("x86/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE")
> https://github.com/hnaz/linux-mm master
> 
> in testcase: trinity
> version: trinity-static-i386-x86_64-1c734c75-1_2020-01-06
> with following parameters:
> 
> 	runtime: 300s
> 	group: group-01
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   40.201103][ T5099] BUG: Bad page map in process trinity-c7  pte:1713003a pmd:7ff71067
> [   40.201999][ T5099] addr:096e7000 vm_flags:00100073 anon_vma:bff0aa00 mapping:00000000 index:96e7
> [   40.202718][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [   40.203229][ T5099] CPU: 0 PID: 5099 Comm: trinity-c7 Not tainted 5.18.0-rc2-mm1-00053-gd1ec551f874e #1
> [   40.203952][ T5099] Call Trace:
> [ 40.204195][ T5099] ? dump_stack_lvl (??:?) 
> [ 40.204581][ T5099] ? dump_stack (??:?) 
> [ 40.204970][ T5099] ? print_bad_pte (memory.c:?) 
> [ 40.205384][ T5099] ? unmap_page_range (??:?) 
> [ 40.205843][ T5099] ? unmap_single_vma (memory.c:?) 
> [ 40.206271][ T5099] ? unmap_vmas (??:?) 
> [ 40.206647][ T5099] ? exit_mmap (??:?) 
> [ 40.207032][ T5099] ? __mmput (fork.c:?) 
> [ 40.207405][ T5099] ? mmput (??:?) 
> [ 40.207751][ T5099] ? exit_mm (exit.c:?) 
> [ 40.208121][ T5099] ? do_exit (??:?) 
> [ 40.208497][ T5099] ? do_group_exit (??:?) 
> [ 40.208905][ T5099] ? trace_hardirqs_on (??:?) 
> [ 40.209345][ T5099] ? get_signal (??:?) 
> [ 40.209750][ T5099] ? arch_do_signal_or_restart (??:?) 
> [ 40.210287][ T5099] ? exit_to_user_mode_loop (common.c:?) 
> [ 40.210778][ T5099] ? exit_to_user_mode_prepare (common.c:?) 
> [ 40.211302][ T5099] ? syscall_exit_to_user_mode (??:?) 
> [ 40.211808][ T5099] ? ret_from_fork (??:?) 
> [   40.212268][ T5099] Disabling lock debugging due to kernel taint
> [   40.231123][ T5097] BUG: Bad page map in process trinity-c5  pte:171e0a3e pmd:0a8d3067
> [   40.231770][ T5099] BUG: Bad page map in process trinity-c7  pte:1713023a pmd:7ff71067
> [   40.231883][ T5097] addr:36ed5000 vm_flags:000000fb anon_vma:00000000 mapping:485d0d80 index:1
> [   40.232611][ T5099] addr:096e8000 vm_flags:00100073 anon_vma:bff0ab18 mapping:00000000 index:96e8
> [   40.233429][ T5097] file:dev/zero fault:shmem_fault mmap:shmem_mmap readpage:0x0
> [   40.234271][ T5099] file:(null) fault:0x0 mmap:0x0 readpage:0x0
> [   40.234971][ T5097] CPU: 1 PID: 5097 Comm: trinity-c5 Tainted: G    B             5.18.0-rc2-mm1-00053-gd1ec551f874e #1
> [   40.236510][ T5097] Call Trace:

This is 32bit (i386) I assume. I wonder if something about the 32bit swp
layout is special and we have to restrict it to 64bit here.

-- 
Thanks,

David / dhildenb

