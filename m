Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBB0485EDD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbiAFCi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiAFCiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:38:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EC6C061245;
        Wed,  5 Jan 2022 18:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=IoUlGEH/xqrV07najlhYyl2fC5yKIy9uFAiZQwDiAD4=; b=bH8zsFsvZVmlTk7euNsOfQBiQy
        TQG3pk1XOSzYDEkc/ki9qtzAVIbGUWlaDz6Guy056ifz2+S4b9EvsiGgVeHzDk2rXHOJicCR9Fykk
        m0mbNZX5slU0SGxqmbPvJnjsrmKUxp/z0XUro94iOFwFGX69JSqqVO07MOJT5U3SxUejjO3lNgHOF
        6RZ8gdfKASIPL1KtKQ9VLKljlOdtgwO1sIzuUDM/udldJC09Tny1xFFSPWFhoemZ5lcVf+raH36Nh
        453Vs1AcAZSjN/t7jSR74ynziDELJ9m7sUg9hmSpP1vPDVOrTcj6rAXPiIfFlvNCJ8azuxUoEaICv
        vQC4Z+mA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n5Ifv-00F5zd-GZ; Thu, 06 Jan 2022 02:38:47 +0000
Message-ID: <8b423739-abe6-7e48-1a20-149ae56df108@infradead.org>
Date:   Wed, 5 Jan 2022 18:38:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [next] mm/shmem.c:3993:5: error: conflicting types for
 'shmem_unuse'; have 'int(unsigned int, long unsigned int *)'
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Juergen Gross <jgross@suse.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        lkft-triage@lists.linaro.org
References: <CA+G9fYvXfD3wS8eJV6A6GygqhJb3AUF9OROQAkBRRTN+thVo-g@mail.gmail.com>
 <YdXYHP5gPMRzmv0B@casper.infradead.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <YdXYHP5gPMRzmv0B@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/5/22 09:40, Matthew Wilcox wrote:
> On Wed, Jan 05, 2022 at 08:01:19PM +0530, Naresh Kamboju wrote:
>> mm/shmem.c:3993:5: error: conflicting types for 'shmem_unuse'; have
>> 'int(unsigned int,  long unsigned int *)'
>>  3993 | int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
>>       |     ^~~~~~~~~~~
>> In file included from include/linux/khugepaged.h:6,
>>                  from mm/shmem.c:37:
>> include/linux/shmem_fs.h:86:5: note: previous declaration of
>> 'shmem_unuse' with type 'int(unsigned int)'
>>    86 | int shmem_unuse(unsigned int type);
>>       |     ^~~~~~~~~~~
> 
> This is "mm: simplify try_to_unuse" in akpm's tree.
> 
> It needs a fix that looks something like this:

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.

> 
> +++ b/mm/shmem.c
> @@ -3990,7 +3990,7 @@ int __init shmem_init(void)
>         return 0;
>  }
> 
> -int shmem_unuse(unsigned int type, unsigned long *fs_pages_to_unuse)
> +int shmem_unuse(unsigned int type)
>  {
>         return 0;
>  }
> 

-- 
~Randy
