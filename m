Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC855DE8A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbiF0Hoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 03:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiF0Ho3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:44:29 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5712760DC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:44:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i64so8208856pfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 00:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ODWv5Qp+v1wLWRTVLVYAHP3LMEfiNE4P/O0zE55mdbE=;
        b=mzlbzZg+72CC06sy+TUkyVi2J1n0aKJWUeNMQd6lzJAxsFplgL5vLiQdpJpa09rMqw
         jTMVqc4UFP+qr1mylXnB9VypMRnaeD4cHuqqsFz+Q83qyXkV2VKTQz4Gz2lLucC2uhjY
         cDhlyTXMX0XH1AqMVCiP/qAxDScGS+Fa9+gI1zudGJSBaA0PxLKfroQVfqH8fEBJJLCg
         WHEAH1FlkeM5+G2jLeHpIYaOMQvpWA5u1j4pDzuDHI0J7K5LHiS0/KEMGKv5vo9z1CPT
         92bwatipHtAuZtfLpbnZR5HkMHYadAcIOqwRsM8MK6CLJjUNfWRtB7FJALRErOEJ8UCX
         U0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ODWv5Qp+v1wLWRTVLVYAHP3LMEfiNE4P/O0zE55mdbE=;
        b=MsUxUmXBFW2pWQJvvnRhu5VYcAhsY+PpCiprDao8XPcABle/4keEglgGGAO2NP1HK8
         uqIoUm9f1Dodk3kZkz4VThdmzWqeZaDNf/PuxcDQkJ+bicWQAaht3Er2ZF78BE9DGNYr
         Xckq212u3q9ZicZR3XJ74An3YCeSvAD/JJmR9CzyaSnjxLQjtQHj+eLhjuYT0dOENaiP
         C79t+LAZv6B7BZIjLMb4yCqWhig1kMpBgQOr913VAgkxe/JOWQmmStTEKd/tUWy30LZx
         w/0l7EMKrCeAc1ut28OKnxeG8e0X7UDv8YeUEPTlMDeIdHxnVuNjHu2YU7FQ3dMv6FKY
         VdmA==
X-Gm-Message-State: AJIora8I6IGxxSRix0tkL8nxHwrjR/b8mKnhpPYDOV8SLEmY9jd1nQ+9
        QzkbwPZxPJiFyYPINQFcq6+EDw==
X-Google-Smtp-Source: AGRyM1v35fx4BBtlSljUBRrN450QiFtQMRb1BaPEg/Oc7f4EypF6xlz+nJGnCOzfiwJejkdQ5+jPWA==
X-Received: by 2002:a63:af56:0:b0:40d:2430:8fa3 with SMTP id s22-20020a63af56000000b0040d24308fa3mr11987469pgo.376.1656315866287;
        Mon, 27 Jun 2022 00:44:26 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id p20-20020a170903249400b00168f329b282sm6395367plw.155.2022.06.27.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 00:44:25 -0700 (PDT)
Date:   Mon, 27 Jun 2022 15:44:22 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Message-ID: <Yrlf1iej4/BL2znu@FVFYT0MHHV2J.usts.net>
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
 <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
 <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:44:19PM +0530, Anshuman Khandual wrote:
> 
> 
> On 6/27/22 12:25, Qi Zheng wrote:
> > 
> > 
> > On 2022/6/27 14:18, Anshuman Khandual wrote:
> >>
> >>
> >> On 6/26/22 20:27, Qi Zheng wrote:
> >>> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
> >>> helper") add set_huge_swap_pte_at() to handle swap entries on
> >>> architectures that support hugepages consisting of contiguous ptes.
> >>> And currently the set_huge_swap_pte_at() is only overridden by arm64.
> >>>
> >>> The set_huge_swap_pte_at() provide a sz parameter to help determine
> >>> the number of entries to be updated. But in fact, all hugetlb swap
> >>> entries contain pfn information, so we can find the corresponding
> >>> folio through the pfn recorded in the swap entry, then the folio_size()
> >>> is the number of entries that need to be updated.
> >>>
> >>> And considering that users will easily cause bugs by ignoring the
> >>> difference between set_huge_swap_pte_at() and set_huge_pte_at().
> >>> Let's handle swap entries in set_huge_pte_at() and remove the
> >>> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
> >>> anywhere, which simplifies our coding.
> >>>
> >>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> >>> ---
> >>>   arch/arm64/include/asm/hugetlb.h |  3 ---
> >>>   arch/arm64/mm/hugetlbpage.c      | 34 ++++++++++++++++----------------
> >>>   include/linux/hugetlb.h          | 13 ------------
> >>>   mm/hugetlb.c                     |  8 +++-----
> >>>   mm/rmap.c                        | 11 +++--------
> >>>   5 files changed, 23 insertions(+), 46 deletions(-)
> >>>
> >>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> >>> index 1fd2846dbefe..d20f5da2d76f 100644
> >>> --- a/arch/arm64/include/asm/hugetlb.h
> >>> +++ b/arch/arm64/include/asm/hugetlb.h
> >>> @@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
> >>>                  pte_t *ptep, unsigned long sz);
> >>>   #define __HAVE_ARCH_HUGE_PTEP_GET
> >>>   extern pte_t huge_ptep_get(pte_t *ptep);
> >>> -extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
> >>> -                 pte_t *ptep, pte_t pte, unsigned long sz);
> >>> -#define set_huge_swap_pte_at set_huge_swap_pte_at
> >>>     void __init arm64_hugetlb_cma_reserve(void);
> >>>   diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> >>> index c9e076683e5d..58b89b9d13e0 100644
> >>> --- a/arch/arm64/mm/hugetlbpage.c
> >>> +++ b/arch/arm64/mm/hugetlbpage.c
> >>> @@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
> >>>       flush_tlb_range(&vma, saddr, addr);
> >>>   }
> >>>   +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
> >>> +{
> >>> +    VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
> >>> +
> >>> +    return page_folio(pfn_to_page(swp_offset(entry)));
> >>> +}
> >>
> >> Extracting this huge page size from swap entry is an additional operation which
> >> will increase the over all cost for set_huge_swap_pte_at(). At present the size
> > 
> > Hmm, I think this cost is very small. And replacing
> > set_huge_swap_pte_at() by transparently handling swap entries helps
> > reduce possible bugs, which is worthwhile.
> 
> Possible bugs ? There are just six call sites for this function.

I think it is easy to make mistakes (see commit 5d4af6195c87).
I usually think of why the swap entry is special for HugeTLB pages
compared to normal pages (why we do not have set_swap_pte_at?).
set_huge_swap_pte_at() make HugeTLB more special, killing it
can make HugeTLB more consistent with normal page. From the point
of view of code maintenance, I think it is better to kill it. What
do you think?

Thanks.

> Although this proposed patch is functionally correct, I dont see
> a valid enough reason to increase the overall cost in the path.
>


