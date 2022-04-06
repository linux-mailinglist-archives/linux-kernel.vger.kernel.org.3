Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF124F62E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 17:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235880AbiDFPSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 11:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236023AbiDFPR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:17:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F046B64A614
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 05:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649247489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0bmAuHwXgos2Wij7gmsat2kTyYLHBrgF2WjqYuWz2Sc=;
        b=P0Bxqv8O4h7OnZE1U4twBEVSfSWUQt/EYzzWnMbNHgr0ve3voPZTpfqfAqKtJgXtASp0ZA
        xXZFyYT1bHJ5/vgHKii/+rJ7LkzlxBqAZA2pV8WbJ9f2jVK+4htQLdTNqC0KrIi5v/RLXv
        fJIjb1aDW4M1txJhvhsdB9eCohc/psI=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-GxFbdnPpPRygdb0ys2Xq7w-1; Wed, 06 Apr 2022 08:18:08 -0400
X-MC-Unique: GxFbdnPpPRygdb0ys2Xq7w-1
Received: by mail-il1-f197.google.com with SMTP id x6-20020a923006000000b002bea39c3974so1581972ile.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 05:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0bmAuHwXgos2Wij7gmsat2kTyYLHBrgF2WjqYuWz2Sc=;
        b=sHCEDwbyv4VHGkLtr5mRcPKZfYa0uMzWp4Mcreavroqbnj5kqDylIc3QjPgaKuSRrg
         wxZjm6zRXJp7IH2aHWuu8KjJ24dEdsgtaUwzaZF7Ymht247wzBKZ4+utqmC2Ug/sMVBf
         Zgv5Wdms2Es07UiubVTb8xXH2DW9VfbeDgkJrO9Vp1oYZteRV7fRq6+6n6NDbT84ZFBh
         w3jBpYZtgsWtQqwmcxQHvdVHDxPEKfpdXzsKNZM9o5vKZE6E1tGzBQZqE7lHemM4Qen+
         Uf81U1adRn3OGY2zyBSAj2dmkhVUSIHXp8DZQemUlpaHxasCFluJ6DE9vFUZ1CcGcMQo
         iMAA==
X-Gm-Message-State: AOAM531L2/ZthIwUvByihLTtnockta4S695mbcIPXVogqCLePxTJcQnY
        ux6blh9wLq9jVIRwOI4lD2CvmelQzA7t8wrGojd9DkDuLQlNPfaYm7/GI8HVkL+AP3NnqyXkaJ6
        sj/wsBi8NhqHAThOmTgFL3DPy
X-Received: by 2002:a05:6602:2d4c:b0:649:ea44:ffc2 with SMTP id d12-20020a0566022d4c00b00649ea44ffc2mr3847996iow.0.1649247487993;
        Wed, 06 Apr 2022 05:18:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9Zv00ZMRN4teiAygOVX8oJ6Q94mOYbCUb4viKhrBXLC6g+lgavyjgNP34MNTG3zrcnNiNMw==
X-Received: by 2002:a05:6602:2d4c:b0:649:ea44:ffc2 with SMTP id d12-20020a0566022d4c00b00649ea44ffc2mr3847984iow.0.1649247487719;
        Wed, 06 Apr 2022 05:18:07 -0700 (PDT)
Received: from xz-m1.local (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g7-20020a056e02198700b002c9f4289ef0sm10252505ilf.48.2022.04.06.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 05:18:07 -0700 (PDT)
Date:   Wed, 6 Apr 2022 08:18:05 -0400
From:   Peter Xu <peterx@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kbuild-all@lists.01.org, Mike Kravetz <mike.kravetz@oracle.com>,
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
Subject: Re: [PATCH v8 10/23] mm/shmem: Handle uffd-wp during fork()
Message-ID: <Yk2E/RcVyR/wismh@xz-m1.local>
References: <20220405014855.14468-1-peterx@redhat.com>
 <202204061453.OXOxSh6e-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202204061453.OXOxSh6e-lkp@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume below should be the same issue as the allnoconfig one Andrew
reported, IOW after the fixup squashed this report along with the other one
in patch 4 should go away.  Let me know otherwise..

Thanks,

On Wed, Apr 06, 2022 at 02:16:56PM +0800, kernel test robot wrote:
> All warnings (new ones prefixed by >>):
> 
>    In file included from arch/ia64/include/asm/pgtable.h:153,
>                     from include/linux/pgtable.h:6,
>                     from arch/ia64/include/asm/uaccess.h:40,
>                     from include/linux/uaccess.h:11,
>                     from arch/ia64/include/asm/sections.h:11,
>                     from include/linux/interrupt.h:21,
>                     from include/linux/kernel_stat.h:9,
>                     from mm/memory.c:42:
>    arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
>    arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
>      127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
>          |                                                ^~~~~~~
>    In file included from include/linux/mm_inline.h:9,
>                     from mm/memory.c:44:
>    include/linux/userfaultfd_k.h: In function 'pte_marker_entry_uffd_wp':
>    include/linux/userfaultfd_k.h:260:16: error: implicit declaration of function 'is_pte_marker_entry' [-Werror=implicit-function-declaration]
>      260 |         return is_pte_marker_entry(entry) &&
>          |                ^~~~~~~~~~~~~~~~~~~
>    include/linux/userfaultfd_k.h:261:14: error: implicit declaration of function 'pte_marker_get' [-Werror=implicit-function-declaration]
>      261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
>          |              ^~~~~~~~~~~~~~
>    include/linux/userfaultfd_k.h:261:38: error: 'PTE_MARKER_UFFD_WP' undeclared (first use in this function)
>      261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
>          |                                      ^~~~~~~~~~~~~~~~~~
>    include/linux/userfaultfd_k.h:261:38: note: each undeclared identifier is reported only once for each function it appears in
>    In file included from include/linux/mm_inline.h:10,
>                     from mm/memory.c:44:
>    include/linux/swapops.h: At top level:
>    include/linux/swapops.h:289:20: error: conflicting types for 'is_pte_marker_entry'; have 'bool(swp_entry_t)' {aka '_Bool(swp_entry_t)'}
>      289 | static inline bool is_pte_marker_entry(swp_entry_t entry)
>          |                    ^~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/mm_inline.h:9,
>                     from mm/memory.c:44:
>    include/linux/userfaultfd_k.h:260:16: note: previous implicit declaration of 'is_pte_marker_entry' with type 'int()'
>      260 |         return is_pte_marker_entry(entry) &&
>          |                ^~~~~~~~~~~~~~~~~~~
>    In file included from include/linux/mm_inline.h:10,
>                     from mm/memory.c:44:
>    include/linux/swapops.h:294:26: error: conflicting types for 'pte_marker_get'; have 'pte_marker(swp_entry_t)' {aka 'long unsigned int(swp_entry_t)'}
>      294 | static inline pte_marker pte_marker_get(swp_entry_t entry)
>          |                          ^~~~~~~~~~~~~~
>    In file included from include/linux/mm_inline.h:9,
>                     from mm/memory.c:44:
>    include/linux/userfaultfd_k.h:261:14: note: previous implicit declaration of 'pte_marker_get' with type 'int()'
>      261 |             (pte_marker_get(entry) & PTE_MARKER_UFFD_WP);
>          |              ^~~~~~~~~~~~~~

-- 
Peter Xu

