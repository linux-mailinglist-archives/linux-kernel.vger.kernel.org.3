Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA350717D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353724AbiDSPQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244806AbiDSPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:16:34 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913213B296
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:13:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x24so3974633qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cBtrsK5BvMDys085W5coB5UFTML9DXLGcwarLFdTr3s=;
        b=uNNJ8Vq9kLmQc9I+6Hgo6a2ttNR/7rcwjnrlxgZh6WP66D8Gl96P+FCvWk5GaltbbE
         4086gsTDO1o5RLq/N4Tv//kIfyJHCkPGe9LgS4iJXKUXdolvMUsbPTA9kYeHQdMNG0EX
         pPUt9kp8AogyIQr0MazUTRtYVQ7Z2wicZP9Kfw9mbu0mGGAR90juLeEs51pfla/rYxWD
         7aEQRgndZzWlUxk6mh8fwTkwLzMyg9qoAgU44Bu3afhetoHhulQ9FHLS2U3cM/iyr4aF
         5aJBW7PjppKpZ5aO6zIEd7Q9bZRGoZNNqqdofEjvMD2KhdTvJS1PYeG4iJpj0Gn6D5VW
         HiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cBtrsK5BvMDys085W5coB5UFTML9DXLGcwarLFdTr3s=;
        b=FHbd+G2uYJYHmF/8WJ74dcFbNuZGG8k2BzfEEHVXKaBdYEpl/uB5/fX/W32CjWKAg6
         62c5utsHnYz+hVNCFwyJTmALb8PwGSLDddbv88EjV6WpI2dik1c90vh6lK0Z1bPFIjxB
         2EWbIMotrF4zJ4tbPvHboHUQfNyunHs3l6p+H/UqpYzM2b7UKME5Q4XQk798GGUQ/+JT
         Rg5b//NaYzNnGKvJlmda8+0DDpW6saFNLRoJzLD5uOSC2MvqlmRSaeAliUEIvcFMffVv
         QMpExROQ0wX8jH4aKPrXRqZfq27wxevpdVtP6pYp7gE4v3Qw2TquSZZYvghrufc9Anko
         ifdw==
X-Gm-Message-State: AOAM531GIXG8pfHWlOm/FtPhG02pUpDTDPImkPqaCcLda1/JNA+TvouU
        SUMGK7bZGbdm+vWpqKPzBno9cg==
X-Google-Smtp-Source: ABdhPJyQ7rJ74CQW1DHqBcmn1unezi1go+9dabDzf1fmtoet8jUZ2oPJDPi1cbfuHLGQ2XaZaegAQA==
X-Received: by 2002:a05:622a:10d:b0:2f1:d7bb:dd2b with SMTP id u13-20020a05622a010d00b002f1d7bbdd2bmr10773928qtw.90.1650381230159;
        Tue, 19 Apr 2022 08:13:50 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id i19-20020ac85c13000000b002f33d140da9sm180196qti.20.2022.04.19.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 08:13:49 -0700 (PDT)
Date:   Tue, 19 Apr 2022 11:13:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
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
Subject: Re: [PATCH v8 22/23] mm: Enable PTE markers by default
Message-ID: <Yl7RrKV5mXtNAAzi@cmpxchg.org>
References: <20220405014646.13522-1-peterx@redhat.com>
 <20220405014929.15158-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405014929.15158-1-peterx@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Mon, Apr 04, 2022 at 09:49:29PM -0400, Peter Xu wrote:
> Enable PTE markers by default.  On x86_64 it means it'll auto-enable
> PTE_MARKER_UFFD_WP as well.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 6e7c2d59fa96..3eca34c864c5 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -911,12 +911,14 @@ config ANON_VMA_NAME
>  
>  config PTE_MARKER
>  	bool "Marker PTEs support"
> +	default y
>  
>  	help
>  	  Allows to create marker PTEs for file-backed memory.

make oldconfig just prompted me on these:

---
Marker PTEs support (PTE_MARKER) [Y/n/?] (NEW) ?

CONFIG_PTE_MARKER:

Allows to create marker PTEs for file-backed memory.

Symbol: PTE_MARKER [=y]
Type  : bool
Defined at mm/Kconfig:1046
  Prompt: Marker PTEs support
  Location:
    Main menu
      -> Memory Management options
---

>  config PTE_MARKER_UFFD_WP
>  	bool "Marker PTEs support for userfaultfd write protection"
> +	default y
>  	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP

It's not possible to answer them without looking at the code.

But after looking at the code, I'm still not sure why it asks
me. Isn't this infrastructure code?

Wouldn't it make more sense to remove the prompt string and have
userfaultfd simply select those?

If this is too experimental to enable per default, a more reasonable
question for the user would be a "userfaultfd file support" option or
something, and have *that* select the marker code.

Thanks!
