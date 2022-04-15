Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B73B502BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 16:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354449AbiDOOYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 10:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354411AbiDOOXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:23:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94E9319C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:21:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so8494807oix.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 07:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qiIw/AH4fmkT1kJ7yC5BcueKb8y1i79msEv4+Nx2QYE=;
        b=iCQm93R8dxN9ZMUPF7/q2kItqH8hGryG/F1Zcw+HAKEO1VlCeTromOmSkmE+UfGV36
         BT0wrdfT5lyeD1qJK/Sv5E1BkQLbEVEfy2byNXOASToLF2VyL4bUMDRzf6VVFjiRd/Pk
         Q3caUDv9c1rRuHipiiLYOzOA8JaCz9BZ9nOIIbNzuKp+kkVhuStSlEiVLlxE7cVJAzLL
         goLBdpzXLRKNKbt/m3b40uYVqqts4oNSAvBJqCjIk7azu1pa97EDyx5xs6Z1t2YVLLti
         9a7SLgaKSm/a+o+Cnm5hnlnEc5h1AjsywyfK2rolpT3OPk5VxLWWYdfLvi0Lzpxwq5bn
         2gNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qiIw/AH4fmkT1kJ7yC5BcueKb8y1i79msEv4+Nx2QYE=;
        b=PdMJrkOwmQq9r1cQVVchuXxSxIAvoODPmI9MDVyD1jduuAKyvJa3fjoqvuu4YH85uW
         343+eJJG3wBgGIoV1hPyuB2ZQInfngaQjWUYOXIy3EDdBujraOwTs/BJFtEZ653RqwuD
         o8SG+pYLDW5bef8eqS+NEE3xvXRoTvdwxlzTC+rmDHPw7JXmHV5cwlCJq7ott5SfJ4I4
         U1joKKdVZLoXg1XVgbfN9EAa7Fb+Uz/vPUbCyJM+aWnOmpYRi3G+7UC9UR4vrF/XOMSI
         GS1gS1tDONf5xGL02nrGWfLOuS/D4VKMFAVBgMQYBS7Qk5UORSsRS+LF+u6HHTc5eyMW
         +6+Q==
X-Gm-Message-State: AOAM530i9H6k9GxqFxzGDjmWmtI+tR4N5Uv5EcDPW731aOJeHTXVCABU
        NQqRONR/W578q+qqJ9HdWjQ=
X-Google-Smtp-Source: ABdhPJzNnIcTF4Fxw1VVObX+Ccg+c1x746obLrERKhRvQpYJ657YF3MoeI9ppfKah1ZhTwI9rOfyjQ==
X-Received: by 2002:a05:6808:128c:b0:2da:3751:7639 with SMTP id a12-20020a056808128c00b002da37517639mr1691286oiw.294.1650032476060;
        Fri, 15 Apr 2022 07:21:16 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p18-20020a056830131200b005ccf8ac6207sm1118827otq.80.2022.04.15.07.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:21:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 15 Apr 2022 07:21:12 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v8 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <20220415142112.GA2714323@roeck-us.net>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014836.14077-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014836.14077-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 04, 2022 at 09:48:36PM -0400, Peter Xu wrote:
> We used to check against none pte in finish_fault(), with the assumption
> that the orig_pte is always none pte.
> 
> This change prepares us to be able to call do_fault() on !none ptes.  For
> example, we should allow that to happen for pte marker so that we can restore
> information out of the pte markers.
> 
> Let's change the "pte_none" check into detecting changes since we fetched
> orig_pte.  One trivial thing to take care of here is, when pmd==NULL for
> the pgtable we may not initialize orig_pte at all in handle_pte_fault().
> 
> By default orig_pte will be all zeros however the problem is not all
> architectures are using all-zeros for a none pte.  pte_clear() will be the
> right thing to use here so that we'll always have a valid orig_pte value
> for the whole handle_pte_fault() call.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

This patch crashes pretty much all arm images in linux-next. Reverting it
fixes the problem. Sample crash log and bisect results attached.

Guenter

---
[   11.232343] 8<--- cut here ---
[   11.232564] Unable to handle kernel paging request at virtual address 88016664
[   11.232735] [88016664] *pgd=41cfd811, *pte=00000000, *ppte=00000000
[   11.233128] Internal error: Oops: 807 [#1] ARM
[   11.233385] CPU: 0 PID: 1 Comm: swapper Not tainted 5.18.0-rc2-next-20220414 #1
[   11.233564] Hardware name: Generic DT based system
[   11.233695] PC is at cpu_arm926_set_pte_ext+0x2c/0x40
[   11.233863] LR is at handle_mm_fault+0x4b0/0x11a8
[   11.233963] pc : [<8010e60c>]    lr : [<802944ec>]    psr: 00000113
[   11.234080] sp : 88015e20  ip : 88015e7c  fp : 00000492
[   11.234179] r10: 00000000  r9 : 00000000  r8 : 81167e50
[   11.234280] r7 : 00000000  r6 : 00000081  r5 : 7efffff1  r4 : 83034690
[   11.234402] r3 : 00000043  r2 : 00000000  r1 : 00000000  r0 : 88016664
[   11.234549] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   11.234691] Control: 00093177  Table: 40004000  DAC: 00000053
[   11.234816] Register r0 information: non-paged memory
[   11.235031] Register r1 information: NULL pointer
[   11.235127] Register r2 information: NULL pointer
[   11.235219] Register r3 information: non-paged memory
[   11.235316] Register r4 information: slab vm_area_struct start 83034688 data offset 8 pointer offset 0 allocated at vm_area_alloc+0x20/0x5c
[   11.235825]     kmem_cache_alloc+0x1fc/0x21c
[   11.235926]     vm_area_alloc+0x20/0x5c
[   11.236007]     alloc_bprm+0xd0/0x298
[   11.236082]     kernel_execve+0x34/0x194
[   11.236159]     kernel_init+0x6c/0x138
[   11.236235]     ret_from_fork+0x14/0x3c
[   11.236330] Register r5 information: non-paged memory
[   11.236432] Register r6 information: non-paged memory
[   11.236529] Register r7 information: NULL pointer
[   11.236620] Register r8 information: non-slab/vmalloc memory
[   11.236741] Register r9 information: NULL pointer
[   11.236833] Register r10 information: NULL pointer
[   11.236926] Register r11 information: non-paged memory
[   11.237023] Register r12 information: 2-page vmalloc region starting at 0x88014000 allocated at kernel_clone+0xa0/0x440
[   11.237253] Process swapper (pid: 1, stack limit = 0x88014000)
[   11.237388] Stack: (0x88015e20 to 0x88016000)
[   11.237518] 5e20: ffffffff fffffffe 81d29be0 00000000 a0000193 00000000 81d2a1e8 00007f7e
[   11.237670] 5e40: 816580a8 83034690 00000cc0 0007efff 7efff000 7efffff1 00000081 83199fb8
[   11.237814] 5e60: 83199fb8 00000000 00000000 00000000 00000000 00000000 00000000 0a363e34
[   11.237957] 5e80: 88015ea4 83034690 7efffff1 00002017 00000081 81f4dd00 00001fb8 00000000
[   11.238100] 5ea0: 00000492 8028d160 00000000 81d29be0 00000001 00002017 80deedcc 81d29be0
[   11.238241] 5ec0: 00000000 81f4dd00 7efffff1 88015f38 81f4dd60 00002017 00000000 8028d64c
[   11.238383] 5ee0: 88015f38 00000000 00000000 7efffff1 81f4dd00 00000000 00000001 00000000
[   11.238524] 5f00: 00000011 82d80800 00000001 7efffff1 81f4dd00 00000011 7efffff1 0000000b
[   11.238666] 5f20: 82d80800 802ca218 88015f38 00000000 00000000 000001d3 80e0b43c 0a363e34
[   11.238808] 5f40: 00000ffc 82d80800 81d73140 81d29be0 0000000b 802cb390 81d7315b 802ca0bc
[   11.238950] 5f60: 8110c940 0000000c 82d80800 81d73140 8110c8b0 8110c93c 00000000 00000000
[   11.239091] 5f80: 00000000 802cbf44 81107820 8110c8b0 00000000 00000000 00000000 80b05400
[   11.239234] 5fa0: 00000000 80b05394 00000000 801000f8 00000000 00000000 00000000 00000000
[   11.239376] 5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   11.239518] 5fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[   11.239770] Code: e31300c0 03822e55 e3130003 13a02000 (e5802000)
[   11.240097] ---[ end trace 0000000000000000 ]---
[   11.240307] Kernel panic - not syncing: Fatal exception

--
# bad: [40354149f4d738dc3492d9998e45b3f02950369a] Add linux-next specific files for 20220414
# good: [ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e] Linux 5.18-rc2
git bisect start 'HEAD' 'v5.18-rc2'
# good: [0f52e407eccb0f7ed62fdd8907b0042f4195159e] Merge branch 'drm-next' of git://git.freedesktop.org/git/drm/drm.git
git bisect good 0f52e407eccb0f7ed62fdd8907b0042f4195159e
# good: [22b1b3a579c91a6afa945711eac72ab740b8f8e4] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
git bisect good 22b1b3a579c91a6afa945711eac72ab740b8f8e4
# good: [cbb5c08b3182cb498f67fa547392191a1d5622dd] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
git bisect good cbb5c08b3182cb498f67fa547392191a1d5622dd
# good: [2acd94b759428825f0e8835fa24ad22c7b5c0e2c] Merge branch 'for-next/kspp' of git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good 2acd94b759428825f0e8835fa24ad22c7b5c0e2c
# bad: [d2d293faec99124d95590e88030ae3c8382fac7f] mm/shmem: persist uffd-wp bit across zapping for file-backed
git bisect bad d2d293faec99124d95590e88030ae3c8382fac7f
# good: [8cbcc910aec560e78e879cf82ed17e7e72d8a7d4] doc: update documentation for swap_activate and swap_rw
git bisect good 8cbcc910aec560e78e879cf82ed17e7e72d8a7d4
# good: [8c55a1ed1f9b95520b0307ba0ac6ff7f1aadfe9d] mm/page_alloc: simplify update of pgdat in wake_all_kswapds
git bisect good 8c55a1ed1f9b95520b0307ba0ac6ff7f1aadfe9d
# good: [3e68e467590511e2cf7f47194464a5512583f641] mm: hugetlb_vmemmap: cleanup CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
git bisect good 3e68e467590511e2cf7f47194464a5512583f641
# good: [3fb21f4e38824f4d8a183ffcccc03b357ad836d4] mm: mmap: register suitable readonly file vmas for khugepaged
git bisect good 3fb21f4e38824f4d8a183ffcccc03b357ad836d4
# bad: [fa600994916318341cf53e18769be547aa5975d2] mm: check against orig_pte for finish_fault()
git bisect bad fa600994916318341cf53e18769be547aa5975d2
# good: [1112411b72b5e9774897538260028a677d616779] fixup! mm: Introduce PTE_MARKER swap entry
git bisect good 1112411b72b5e9774897538260028a677d616779
# good: [1ae034d98f81a6cf8896b37c3dee9e099daeb3e7] mm: teach core mm about pte markers
git bisect good 1ae034d98f81a6cf8896b37c3dee9e099daeb3e7
# first bad commit: [fa600994916318341cf53e18769be547aa5975d2] mm: check against orig_pte for finish_fault()
