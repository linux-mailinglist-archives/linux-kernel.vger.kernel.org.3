Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B84FB9DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbiDKKnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239627AbiDKKnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:43:02 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA363DDDD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:40:48 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f3so14263893pfe.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qRHCFU3vsxOyCqqTuuci/uOq3jyLUilmY7vzgzXVdos=;
        b=sGt3N6d9Ho2buqWhnPF0ISSL3HrI3WHKB0aJ4B4ANbex7ngxZlD+qNeWa1bFBV6+ko
         MUtP0V2erl0anWMBYp7+5js9ODFfjHJ1e9fCN6JkKtKCfwlHT6cqgM1+YSCUP6cZeF8X
         K+JxNicNmgcxaucTFmU+kbvkpetByXuuI22y5oB8JWBizdjxtC1EMVS8MNv9/vh+Ncjl
         nIlfjFwnvjCgZrMZjTWN0Qu9lXQnX2vZsLR5oZPviv4mOvyGfWifrm5oVJ32z7txCRGQ
         K8/+ubqGzLReeXPLXdt9Zl/Qe6BZ6MEtb9ezcP8MNQ7lI1z+KqAkoBY/n32KpTP1hRAf
         94FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRHCFU3vsxOyCqqTuuci/uOq3jyLUilmY7vzgzXVdos=;
        b=o3zkUTpbrqI61mcXwPqRJkfQDaw6569kW3x8D7t8K1TKTizg96el+QRG1vmBrtOPp8
         tvEgCvL02L25ig4LdHfOnf47thHNqt9sxhnkj1YgaDIez+LHNMrbZWPQcXF4Yw521MQh
         0+77RHnzCC0tAfA+vPgmhA1Y6LKmdYKE+05b9+u8XWD0EGpiE6DqeruP8xdZJDwpoOAI
         ZOpAl+dbuC+Nhu8836j8AJN+D6xaKXj2FVZLshSBwnjplyfRAqGtwkvdz5MFJ+K9OOyN
         qJbTXHwOuf6I8ukBFkqXFg0a1JLtPagvZcpP6qGFWOPiBh90dMMWI9+DtNLiZ9rxCsN+
         WF4A==
X-Gm-Message-State: AOAM532TYcqzxxsEjtmlEND0SvGFPQbyaIL+HLLw46wblUlE14VX744j
        Qz9C2Hw1Um4u+9ZRrqDZxN+2CA==
X-Google-Smtp-Source: ABdhPJzDyOCCKORv1EINtcfr9u0Tb/fmUdZcJ7oRQZQPJAvs7DB2DtQYDBnPvm+y2Igq/BvLhorJ4A==
X-Received: by 2002:a65:4681:0:b0:382:b4f5:84c2 with SMTP id h1-20020a654681000000b00382b4f584c2mr25704425pgr.218.1649673647951;
        Mon, 11 Apr 2022 03:40:47 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id x124-20020a627c82000000b00505aece5638sm5003524pfc.130.2022.04.11.03.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 03:40:47 -0700 (PDT)
Date:   Mon, 11 Apr 2022 18:40:41 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Message-ID: <YlQFqf9/VSyiZVKG@FVFYT0MHHV2J.usts.net>
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
 <d6e2581e-a8ac-4848-2c64-4a221bd03bca@arm.com>
 <CAMZfGtWyXmPwZWsH_pP_M7p30uBww8BdP0DRXQRjBkT_VP=uUA@mail.gmail.com>
 <46a99793-2e24-f3c5-c63f-ab2ad88966ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46a99793-2e24-f3c5-c63f-ab2ad88966ea@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 02:47:26PM +0530, Anshuman Khandual wrote:
> 
> 
> On 4/5/22 14:08, Muchun Song wrote:
> > On Tue, Apr 5, 2022 at 12:44 PM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >>
> >>
> >> On 3/31/22 12:26, Muchun Song wrote:
> >>> 1st concern:
> >>> '''
> >>> But what happens when a hot remove section's vmemmap area (which is
> >>> being teared down) is nearby another vmemmap area which is either created
> >>> or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> >>> HugeTLB pages inside the hot remove section might be safe. But what about
> >>> other HugeTLB areas whose vmemmap area shares page table entries with
> >>> vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> >>> /use/free test cycle using memory just adjacent to a memory hotplug area,
> >>> which is always added and removed periodically, should be able to expose
> >>> this problem.
> >>> '''
> >>>
> >>> Answer: At the time memory is removed, all HugeTLB pages either have been
> >>> migrated away or dissolved.  So there is no race between memory hot remove
> >>> and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> >>> remove section is safe.  Let's talk your question "what about other
> >>
> >> HugeTLB pages inside the memory range is safe but concern is about the
> >> vmemmap mapping for the HugeTLB which might share intermediate entries
> >> with vmemmap mapping for the memory range/section being removed.
> > 
> > The shared page table level only could be PMD, PUD and PGD, the PTE
> > page table cannot be shared with other sections, and we only exchange
> > PTEs for vmemmap mapping.
> 
> Right, the shared entries (if any) are not at the leaf level.
> 
> > 
> >>
> >>> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> >>> entries for a section being hot removed ?", the question is not
> >>
> >> Right.
> >>
> >>> established.  The minimal granularity size of hotplug memory 128MB (on
> >>> arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> >>> then, there is no share PTE page tables between HugeTLB in this section
> >>
> >> 128MB is the hot removable granularity but, its corresponding vmemmap
> >> range is smaller i.e (128MB/4K) * sizeof(struct page). Memory section
> >> getting hot removed (its vmemmap mapping being teared down) along with
> >> HugeTLB (on another section) vmemmap remap operation, could not collide
> >> while inside vmemmap mapping areas on init_mm ?
> > 
> > The boundary address of a section is aligned with 128MB and its
> > corresponding vmemmap boundary address is aligned with 2MB
> > which is mapped with a separated PTE page table (or a PMD entry).
> 
> Even if these PMD entries split during HugeTLB remapping, they will not
> conflict with another memory section being removed simultaneously. Also
> any shared page table pages will not be freed, during memory hot remove
> operation as vmemmap remap does not delete any entries.
> 
> But just wondering if during PMD slit and PTE page table page addition,
> these PMD entries could not be empty, even temporarily ?
>

The pmd entry is either a PTE page table or a PMD leaf entry, it cannot
be a empty entry forever.  More details can refer to
__split_vmemmap_huge_pmd().

Thanks.
 
