Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4791481EA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 18:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236155AbhL3RcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 12:32:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhL3RcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 12:32:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C72C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 09:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=FVxCiAm7knnCFp4Ex/JwHbySRDGua05m3qd2w6v9KHM=; b=r0/YctsTek+t+H2KmXn4sSX2/T
        QHq0YrO8fuQwBEeikf+D+aMNgvARCeM5Pa9DteuxULqUaJjfWf+PvsjfaXKMQzQaeHsmdjbYfPQ4z
        +Jh8peL8ebAD7pbQZ8YEetQ+ha0y3zOCbHPiPDGmmos3lae2yFIP07Ft1Zos0WPEWF8LHqJZ5f/WV
        ULIh2KpJb2zHczirJUoJ7rAWR5dfMUPPeJK6Esge6ssLhyVWNoV3vlWaBUSsrp8s8M/NbWXfue70U
        BEJZAB5P8XQexQeFSN80YIJT7fbcLf/MvS91W1cS03FOoSNpfbGH1FuoQP+zGdImmvC3JUeJpGVvQ
        ijBub2JA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n2zHY-009x2C-RT; Thu, 30 Dec 2021 17:32:05 +0000
Message-ID: <d810267d-1a70-4f3a-65f8-18f25965a58d@infradead.org>
Date:   Thu, 30 Dec 2021 09:32:01 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] mm/shmem: Fix a build error due to shmem_unuse() under
 !CONFIG_SHMEM
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, akpm@linux-foundation.org
Cc:     hch@lst.de, hughd@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20211230103844.15302-1-sj@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20211230103844.15302-1-sj@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/30/21 02:38, SeongJae Park wrote:
> A patch[1] in -mm tree that titled mm-simplify-try_to_unuse.patch[2]
> didn't properly change the type of 'shmem_unuse()' definition under
> !CONFIG_SHMEM, and therefore causing below build error when CONFIG_SHMEM
> is not set.
> 
>     linux/mm/shmem.c:3992:5: error: conflicting types for 'shmem_unuse'
>      3992 | int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
>           |     ^~~~~~~~~~~
>     In file included from linux/include/linux/khugepaged.h:6,
>                      from linux/mm/shmem.c:37:
>     linux/include/linux/shmem_fs.h:86:5: note: previous declaration of 'shmem_unuse' was here
>        86 | int shmem_unuse(unsigned int type);
>           |     ^~~~~~~~~~~
>     linux/scripts/Makefile.build:289: recipe for target 'mm/shmem.o' failed
> 
> This commit fixes the issue by fixing the type of the definition under
> the config.
> 
> [1] https://lore.kernel.org/linux-mm/20211224062246.1258487-9-hch@lst.de/
> [2] https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-simplify-try_to_unuse.patch
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  mm/shmem.c              | 2 +-
>  scripts/rust-version.sh | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  mode change 100644 => 100755 scripts/rust-version.sh
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 421b2459929a..a83c91282c1f 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3989,7 +3989,7 @@ int __init shmem_init(void)
>  	return 0;
>  }
>  
> -int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
> +int shmem_unuse(unsigned int type)
>  {
>  	return 0;
>  }
> diff --git a/scripts/rust-version.sh b/scripts/rust-version.sh
> old mode 100644
> new mode 100755

-- 
~Randy
