Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C64AF57F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiBIPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiBIPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:38:01 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9CC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:38:04 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id b35so1900685qkp.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZgbfcwbgPkpuM7mu7HCH+WaELpgN95UWkk6kyDoy9Hs=;
        b=aYR8VVj/esZ2WkexXOmm9y9DPE8VyMMI0FOey13akjZ1BkVAAuRt4xnBSn+lOfeYaU
         8Jb1p4pmPSt4tUAnv0xHqvOL7Ek4nCzna8r4uyfTBwjSxCyfxBZt2gViR4RiUH6qPhVt
         HoCsE1LipfiY2VESbBTlg6frx3/isAyZhCerV41PfWTIyfaHT/CYFOzDlm7Pa19Ta7KM
         epC9+xEKe8YuGE5W85BpFvQXXyxI4b2CNSRKQ/sxn5XVv04evB9jcJd+WDbZDw2ZopbF
         KH7+e7ZbGjRCHocJyI6FAe28b4CzR5SNfMB1jUjMuMh1L1Zq06Tzka8OI+WYyDRFGpqT
         FMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZgbfcwbgPkpuM7mu7HCH+WaELpgN95UWkk6kyDoy9Hs=;
        b=hcDuu1mxpJYB8abPiXjW+Md91ej4rDnjcc+zM/XF30RvrjNQ+2LPszfne3RfdiNwTN
         8g0y5cGh0ZMU0wNNDVdbaiKhfw1e8TyP9qXf6JTaILj4gOEUw3XkfEHaUC51WAd/eWiF
         xJo0EL9294gMadu11VGoz19Jh1au3EUjR1lHCIn48cifMNpx9wDqa7LXKbMVnodG8uqI
         0q4VW5R1l41d0fGxhY0oI3tgmTX7NyyjAIuOLSf9NmpKb+eZVkN9F9q7N1zpCgv1G0VB
         NGJHVlfnZTj68f3kFIQ4cdGHHMbTrZWeZ6jKgvpK/qJiVizPCueLBQMjfCQsuhML+LEH
         8HRg==
X-Gm-Message-State: AOAM530nHZJ3sXzB08JY+GbEWht8DvDKq9LdHYtkH0gWvv3C6+mnhQCl
        u9XXxqLmg2igruuRWvnyoHnRFw==
X-Google-Smtp-Source: ABdhPJzwtcw9nIRGIq1isTErfCEla/NZnsAxu9/ntX5lA3PPv7aS8xZYOD5xUEgmbMVV0UZcRK8THQ==
X-Received: by 2002:a05:620a:2087:: with SMTP id e7mr1380444qka.554.1644421083468;
        Wed, 09 Feb 2022 07:38:03 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n19sm8881100qkp.52.2022.02.09.07.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 07:38:02 -0800 (PST)
Date:   Wed, 9 Feb 2022 07:37:50 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     SeongJae Park <sj@kernel.org>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, hughd@google.com,
        geert@linux-m68k.org
Subject: Re: [PATCH for-mm 1/2] mm/internal: Implement no-op mlock_page_drain()
 for !CONFIG_MMU
In-Reply-To: <20220209094158.21941-2-sj@kernel.org>
Message-ID: <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com>
References: <20220209094158.21941-1-sj@kernel.org> <20220209094158.21941-2-sj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Feb 2022, SeongJae Park wrote:
> Commit 4b3b8bd6c8287 ("mm/munlock: mlock_page() munlock_page() batch by
> pagevec") in -mm tree[1] implements 'mlock_page_drain()' under
> CONFIG_MMU only, but the function is used by 'lru_add_drain_cpu()',
> which defined outside of CONFIG_MMU.  As a result, below build error
> occurs.
> 
>     /linux/mm/swap.c: In function 'lru_add_drain_cpu':
>     /linux/mm/swap.c:637:2: error: implicit declaration of function 'mlock_page_drain' [-Werror=implicit-function-declaration]
>       637 |  mlock_page_drain(cpu);
>           |  ^~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors
>     /linux/scripts/Makefile.build:289: recipe for target 'mm/swap.o' failed
> 
> This commit fixes it by implementing no-op 'mlock_page_drain()' for
> !CONFIG_MMU case, similar to 'mlock_new_page()'.
> 
> [1] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-munlock-mlock_page-munlock_page-batch-by-pagevec.patch
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/internal.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 0d240e876831..248224369b34 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -508,6 +508,7 @@ static inline void mlock_vma_page(struct page *page,
>  static inline void munlock_vma_page(struct page *page,
>  			struct vm_area_struct *vma, bool compound) { }
>  static inline void mlock_new_page(struct page *page) { }
> +static inline void mlock_page_drain(int cpu) { }
>  static inline void vunmap_range_noflush(unsigned long start, unsigned long end)
>  {
>  }

Thank you, SeongJae, and thank you Geert for reporting.

This patch is good as far as it goes, but Andrew, please don't add
it right now: I need to think a bit more, and will send another
(or Ack SeongJae's) later in the day.

The thing is, SeongJae's patch makes me wonder, why did it not need a
!CONFIG_MMU definition for need_mlock_page_drain() too?  That's because
mm/swap.c's call to it is under an #ifdef CONFIG_SMP, and I imagine that
CONFIG_MMU=n usually goes along with (but does not necessarily imply?)
CONFIG_SMP=n.  It'll be safer to add a need_mlock_page_drain() stub too.

But more seriously, is the mlock_page_drain() going to be called when
it's wanted, when CONFIG_SMP is not set?  I had forgotten how mm/swap.c
goes in different directions (for some things but not for others)
according to CONFIG_SMP.  I'll look into it and come back later.

Thanks,
Hugh
