Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5DF546CA4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350041AbiFJSmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349922AbiFJSmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:42:10 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58271203D6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:42:08 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x4so149047pfj.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 11:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2h6QeJaNJ/l4Ap+MNJ9DmJJR14ra8zD82bDczXJvOPg=;
        b=HiwkAb7BfoZkeg4NEv/W2OaaZPE9d+Gk/Yw5FW3aUcRAzAp3Mucr0nJhaUhGn6HGCH
         cgeRrGXstQus6STOmurztQB9uXTdjM9win6gHdsdMDnpJvEreGBYyHVbKnnuo68Uu4fg
         LIIq/3kyVYLT2pMy+0ve9L53OCXoOPeJB0Yg7v8OQ1pqwRDzTTvpnJ/NX0VHM/v1CMkC
         hj9X1y9hpB2kJXIxXVeB00/eLvXbdLdHvfaOHC1/RNiNIHxy4YKh2JpUJzpgj0PYgt94
         gUTTV3JofLeMy5CWJX+DnR7vxWWj97iQZ3LCtbk95je4ai1UFwtMnqAPYx2Aef/Ua3BW
         gHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=2h6QeJaNJ/l4Ap+MNJ9DmJJR14ra8zD82bDczXJvOPg=;
        b=tIddxelQl112yArCmJ74zVEsbLN7x6NjHlm52l8a03EFkykWREVc7yP3aB6K8pQhlS
         lMD2cGeVdD9cFq8DiGCV4dgT1fmoaEpmZaOb2Pl/1tDHJzi1def1iB+YpCgqfRYqCwY2
         A8ZHQynZEJZ6e65Mdn3/howwO88GFhfH6L6T7Zb1WNxOIHV+RtcNxLc4xAH4HlMbTU2u
         IbkW/osFAKwXpfPbOOax8vFef+KhOtyPWaNlh6AoIqzG0+p3lfa49gLvvyfH5XBTqxi1
         AE357FNzsuPFgBXsvSBlnU+5zTuqOu6rV3Rojk0THh3RllA2PtomfpyOOkDY8QMf6C8V
         7esQ==
X-Gm-Message-State: AOAM532tw2UvU/Vy5xtI0zbFrfrXt9nnJtRlPxxb4OA9AMMPv+kYCon3
        LmRU3dfZuFHphLGjKhrbHaw=
X-Google-Smtp-Source: ABdhPJyoFDsLxAOfecE6ELepO0mzZc9lCt51m44axIKo3X/u7JuVQU/8QY+4YXTGI+02KUKOhScEdQ==
X-Received: by 2002:a05:6a00:1387:b0:51c:2712:7859 with SMTP id t7-20020a056a00138700b0051c27127859mr26113490pfg.38.1654886527983;
        Fri, 10 Jun 2022 11:42:07 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 21-20020a621815000000b0051b4e53c487sm19874600pfy.45.2022.06.10.11.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2022 11:42:07 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [PATCH v2] mm/mprotect: try avoiding write faults for exclusive
 anonymous pages when changing protection
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20220610181436.84713-1-david@redhat.com>
Date:   Fri, 10 Jun 2022 11:42:06 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>, Yang Shi <shy828301@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Transfer-Encoding: 7bit
Message-Id: <5DFB7262-6E32-4984-A346-B7DE5040B12F@gmail.com>
References: <20220610181436.84713-1-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 10, 2022, at 11:14 AM, David Hildenbrand <david@redhat.com> wrote:

> Similar to our MM_CP_DIRTY_ACCT handling for shared, writable mappings, we
> can try mapping anonymous pages writable if they are exclusive,
> the PTE is already dirty, and no special handling applies. Mapping the
> PTE writable is essentially the same thing the write fault handler would do
> in this case.
> 
> Special handling is required for uffd-wp and softdirty tracking, so take
> care of that properly. Also, leave PROT_NONE handling alone for now;
> in the future, we could similarly extend the logic in do_numa_page() or
> use pte_mk_savedwrite() here. Note that we'll now also check for uffd-wp in
> case of VM_SHARED -- which is harmless and prepares for uffd-wp support for
> shmem.
> 
> While this improves mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE)
> performance, it should also be a valuable optimization for uffd-wp, when
> un-protecting.
> 
> Applying the same logic to PMDs (anonymous THP, anonymous hugetlb) is
> probably not worth the trouble, but could similarly be added if there is
> demand.
> 
> Results of a simple microbenchmark on my Ryzen 9 3900X, comparing the new
> optimization (avoiding write faults) during mprotect() with softdirty
> tracking, where we require a write fault.
> 
>  Running 1000 iterations each
> 
>  ==========================================================
>  Measuring memset() of 4096 bytes
>   First write access:
>    Min: 169 ns, Max: 8997 ns, Avg: 830 ns
>   Second write access:
>    Min: 80 ns, Max: 251 ns, Avg: 168 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 180 ns, Max: 290 ns, Avg: 190 ns
>   Write access after clearing softdirty:
>    Min: 451 ns, Max: 1774 ns, Avg: 470 ns
>  -> mprotect = 1.131 * second [avg]
>  -> mprotect = 0.404 * softdirty [avg]
>  ----------------------------------------------------------
>  Measuring single byte access per page of 4096 bytes
>   First write access:
>    Min: 761 ns, Max: 1152 ns, Avg: 784 ns
>   Second write access:
>    Min: 130 ns, Max: 181 ns, Avg: 137 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 150 ns, Max: 1553 ns, Avg: 155 ns
>   Write access after clearing softdirty:
>    Min: 169 ns, Max: 1783 ns, Avg: 432 ns
>  -> mprotect = 1.131 * second [avg]
>  -> mprotect = 0.359 * softdirty [avg]
>  ==========================================================
>  Measuring memset() of 16384 bytes
>   First write access:
>    Min: 1594 ns, Max: 3497 ns, Avg: 2143 ns
>   Second write access:
>    Min: 250 ns, Max: 381 ns, Avg: 260 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 290 ns, Max: 1643 ns, Avg: 300 ns
>   Write access after clearing softdirty:
>    Min: 1242 ns, Max: 8987 ns, Avg: 1297 ns
>  -> mprotect = 1.154 * second [avg]
>  -> mprotect = 0.231 * softdirty [avg]
>  ----------------------------------------------------------
>  Measuring single byte access per page of 16384 bytes
>   First write access:
>    Min: 1953 ns, Max: 2945 ns, Avg: 2008 ns
>   Second write access:
>    Min: 130 ns, Max: 912 ns, Avg: 142 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 160 ns, Max: 240 ns, Avg: 166 ns
>   Write access after clearing softdirty:
>    Min: 1112 ns, Max: 1513 ns, Avg: 1126 ns
>  -> mprotect = 1.169 * second [avg]
>  -> mprotect = 0.147 * softdirty [avg]
>  ==========================================================
>  Measuring memset() of 65536 bytes
>   First write access:
>    Min: 7524 ns, Max: 15650 ns, Avg: 7680 ns
>   Second write access:
>    Min: 251 ns, Max: 1323 ns, Avg: 648 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 270 ns, Max: 1282 ns, Avg: 736 ns
>   Write access after clearing softdirty:
>    Min: 4558 ns, Max: 12524 ns, Avg: 4623 ns
>  -> mprotect = 1.136 * second [avg]
>  -> mprotect = 0.159 * softdirty [avg]
>  ----------------------------------------------------------
>  Measuring single byte access per page of 65536 bytes
>   First write access:
>    Min: 7083 ns, Max: 9027 ns, Avg: 7241 ns
>   Second write access:
>    Min: 140 ns, Max: 201 ns, Avg: 156 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 190 ns, Max: 451 ns, Avg: 197 ns
>   Write access after clearing softdirty:
>    Min: 3707 ns, Max: 5119 ns, Avg: 3958 ns
>  -> mprotect = 1.263 * second [avg]
>  -> mprotect = 0.050 * softdirty [avg]
>  ==========================================================
>  Measuring memset() of 524288 bytes
>   First write access:
>    Min: 58470 ns, Max: 87754 ns, Avg: 59353 ns
>   Second write access:
>    Min: 5180 ns, Max: 6863 ns, Avg: 5318 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 5871 ns, Max: 9358 ns, Avg: 6028 ns
>   Write access after clearing softdirty:
>    Min: 35797 ns, Max: 41338 ns, Avg: 36710 ns
>  -> mprotect = 1.134 * second [avg]
>  -> mprotect = 0.164 * softdirty [avg]
>  ----------------------------------------------------------
>  Measuring single byte access per page of 524288 bytes
>   First write access:
>    Min: 53751 ns, Max: 59431 ns, Avg: 54506 ns
>   Second write access:
>    Min: 781 ns, Max: 2194 ns, Avg: 1123 ns
>   Write access after mprotect(PROT_READ)+mprotect(PROT_READ|PROT_WRITE):
>    Min: 161 ns, Max: 1282 ns, Avg: 622 ns
>   Write access after clearing softdirty:
>    Min: 30888 ns, Max: 34565 ns, Avg: 31229 ns
>  -> mprotect = 0.554 * second [avg]
>  -> mprotect = 0.020 * softdirty [avg]
> 
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nadav Amit <nadav.amit@gmail.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> * Rebased on v5.19-rc1
> * Rerun benchmark
> * Fix minor spelling issues in subject+description
> * Drop IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) check
> * Move pte_write() check into caller
> 
> ---
> mm/mprotect.c | 67 ++++++++++++++++++++++++++++++++++++++++++---------
> 1 file changed, 55 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index ba5592655ee3..728772bf41c7 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -38,6 +38,45 @@
> 
> #include "internal.h"
> 
> +static inline bool can_change_pte_writable(struct vm_area_struct *vma,
> +					   unsigned long addr, pte_t pte,
> +					   unsigned long cp_flags)
> +{
> +	struct page *page;
> +
> +	if ((vma->vm_flags & VM_SHARED) && !(cp_flags & MM_CP_DIRTY_ACCT))
> +		/*
> +		 * MM_CP_DIRTY_ACCT is only expressive for shared mappings;
> +		 * without MM_CP_DIRTY_ACCT, there is nothing to do.
> +		 */
> +		return false;
> +
> +	if (pte_protnone(pte) || !pte_dirty(pte))
> +		return false;
> +
> +	/* Do we need write faults for softdirty tracking? */
> +	if ((vma->vm_flags & VM_SOFTDIRTY) && !pte_soft_dirty(pte))
> +		return false;
> +
> +	/* Do we need write faults for uffd-wp tracking? */
> +	if (userfaultfd_pte_wp(vma, pte))
> +		return false;
> +
> +	if (!(vma->vm_flags & VM_SHARED)) {
> +		/*
> +		 * We can only special-case on exclusive anonymous pages,
> +		 * because we know that our write-fault handler similarly would
> +		 * map them writable without any additional checks while holding
> +		 * the PT lock.
> +		 */
> +		page = vm_normal_page(vma, addr, pte);
> +		if (!page || !PageAnon(page) || !PageAnonExclusive(page))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +

Looks good in general. Just wondering (out loud) whether it makes more sense
to do all the vm_flags and cp_flags related checks in one of the callers
(mprotect_fixup()?) and propagate whether to try to write-unprotect in
cp_flags (e.g., by introducing new MM_CP_TRY_WRITE_UNPROTECT).

