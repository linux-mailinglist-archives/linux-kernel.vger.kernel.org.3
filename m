Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1F493EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356371AbiASRXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356369AbiASRXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 12:23:15 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB6FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:23:14 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id n11so2833815plf.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 09:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bF3tKbMU5QVQDTVifm+lKCqatbJrIiXH+WWPjz7Qq3w=;
        b=JjrGCmyUCH3I8hhd9l9lD2qyJV/ERS1JapRXly0tjqC3Gmuxf8cgGGtQWuiCHD2Idq
         0/fQYQkcg0sNYqNxXmXcycmZawDELOouJ5fSgwbW4TCb5p2zXLMDQdjd24Rl7oEzYIiE
         OuGuYu9rlVKFPEgpxoBf19IkyEW1wlFI+k2PlGNzJ1cGZ25MwXaltEPQhXm0F/fdsYbZ
         9Kht9c0fW+j6oo1QhHSSliNV8FS6HnNY6SMfhQCX+cW0eBqO9vaCzJ4THMy6oRR0fTgL
         l0nfobhpA0+NLv628Tfqu/CI5esyxBrvlFbq0ybY//4Ce0E+odk7c1GqXA30x4/W2oYD
         mUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bF3tKbMU5QVQDTVifm+lKCqatbJrIiXH+WWPjz7Qq3w=;
        b=Et9iQSTDGWefwmqdYG3tr8eKl4QzYL7pRIE+Mz2p1wPNewG5nKFenbnGzjuGqURV3y
         GsNnlfL/0AUdGiMJUJOgVUPFZPuYRgW+ubqUOLL/Qig12WltHUOVUWhIL65DZ0CW70qj
         yZEl2aC8fGSONhbCsPirfh0i6fjD6Nbnj4fbRxkU/Eyfm8drmKYbAJY0xZu2OLbQa23s
         w1rI5jillQiN0harWtF70DKMDNUYLg9Gj3rCXpUnvx5RIE7gLr3OPLbCJUy05ZNfevc0
         cso6H0H4IwPAqJmQUClGE8yIRixT0MiGgcC128drdOQydLVolwe4aHEqetYKERwFGmf2
         6i7Q==
X-Gm-Message-State: AOAM5339tvfjd5K021IJZ5PpV1sL6fZdStmdkPvlmuN2x9jFYsXSfLxV
        Ww0zHg7qcLCHOZGvt96UllxiuUaIo3J0+yHQ1Js=
X-Google-Smtp-Source: ABdhPJwCSODjC9eZ1Qo1r6AW92wjOVcOiiwjQiGB2NqSTNa082BYY2apbaISDWUnv3uVerJr9HGl/z2wW+sXrmOVjWQ=
X-Received: by 2002:a17:90a:9104:: with SMTP id k4mr5514058pjo.87.1642612993756;
 Wed, 19 Jan 2022 09:23:13 -0800 (PST)
MIME-Version: 1.0
References: <20220118235244.540103-1-yury.norov@gmail.com> <Yedgj+Lo2eru8197@casper.infradead.org>
 <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com>
In-Reply-To: <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 19 Jan 2022 09:22:58 -0800
Message-ID: <CAAH8bW_=KtrwLpg4tx+1tdMjN2mUiuLOoZH6nvbn8qNjU6aB3A@mail.gmail.com>
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:17 PM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 1/19/22 6:21 AM, Matthew Wilcox wrote:
> > On Tue, Jan 18, 2022 at 03:52:44PM -0800, Yury Norov wrote:
> >> vmap() takes struct page *pages as one of arguments, and user may provide
> >> an invalid pointer which would lead to DABT at address translation later.
> >
> > Could we spell out 'DABT'?  Presumably that's an ARM-specific thing.
> > Just like we don't say #PF for Intel page faults, I think this is
> > probably a 'data abort'?
>
> Right, it is data abort.
>
> >
> >> Currently, kernel checks the pages against NULL. In my case, however, the
> >> address was not NULL, and was big enough so that the hardware generated
> >> Address Size Abort on arm64.
>
> Could you please provide the actual abort stack here with details.

[  665.484101] Unhandled fault at 0xffff8000252cd000
[  665.488807] Mem abort info:
[  665.491617]   ESR = 0x96000043
[  665.494675]   EC = 0x25: DABT (current EL), IL = 32 bits
[  665.499985]   SET = 0, FnV = 0
[  665.503039]   EA = 0, S1PTW = 0
[  665.506167] Data abort info:
[  665.509047]   ISV = 0, ISS = 0x00000043
[  665.512882]   CM = 0, WnR = 1
[  665.515851] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000818cb000
[  665.522550] [ffff8000252cd000] pgd=000000affcfff003,
pud=000000affcffe003, pmd=0000008fad8c3003, pte=00688000a5217713
[  665.533160] Internal error: level 3 address size fault: 96000043 [#1] SMP
[  665.539936] Modules linked in: [...]
[  665.616212] CPU: 178 PID: 13199 Comm: test Tainted: P           OE
   5.4.0-84-generic #94~18.04.1-Ubuntu
[  665.626806] Hardware name: HPE Apollo 70             /C01_APACHE_MB
        , BIOS L50_5.13_1.0.6 07/10/2018
[  665.636618] pstate: 80400009 (Nzcv daif +PAN -UAO)
[  665.641407] pc : __memset+0x38/0x188
[  665.645146] lr : test+0xcc/0x3f8
[  665.650184] sp : ffff8000359bb840
[  665.653486] x29: ffff8000359bb840 x28: 0000000000000000
[  665.658785] x27: 0000000000000000 x26: 0000000000231000
[  665.664083] x25: ffff00ae660f6110 x24: ffff00ae668cb800
[  665.669382] x23: 0000000000000001 x22: ffff00af533e5000
[  665.674680] x21: 0000000000001000 x20: 0000000000000000
[  665.679978] x19: ffff00ae66950000 x18: ffffffffffffffff
[  665.685276] x17: 00000000588636a5 x16: 0000000000000013
[  665.690574] x15: ffffffffffffffff x14: 000000000007ffff
[  665.695872] x13: 0000000080000000 x12: 0140000000000000
[  665.701170] x11: 0000000000000041 x10: ffff8000652cd000
[  665.706468] x9 : ffff8000252cf000 x8 : ffff8000252cd000
[  665.711767] x7 : 0303030303030303 x6 : 0000000000001000
[  665.717065] x5 : ffff8000252cd000 x4 : 0000000000000000
[  665.722363] x3 : ffff8000252cdfff x2 : 0000000000000001
[  665.727661] x1 : 0000000000000003 x0 : ffff8000252cd000
[  665.732960] Call trace:
[  665.735395]  __memset+0x38/0x188
[...]

TCR_EL1 is 34b5503510, and so TCR_EL1.IPS is 0b100. The pfn that caused
address size abort has bit#47 set, which is far above 16TB that is allowed by
ips == 100.

> >>
> >> Interestingly, this abort happens even if copy_from_kernel_nofault() is
> >> used, which is quite inconvenient for debugging purposes.
> >>
> >> This patch adds a pfn_valid() check into vmap() path, so that invalid
> >> mapping will not be created.
> >>
> >> RFC: https://lkml.org/lkml/2022/1/18/815
> >> v1: use pfn_valid() instead of adding an arch-specific
> >>     arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.
>
> This should be after the '---' below.
>
> >>
> >> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> >
> > Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> >
> >> ---
> >>  mm/vmalloc.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >> index d2a00ad4e1dd..a4134ee56b10 100644
> >> --- a/mm/vmalloc.c
> >> +++ b/mm/vmalloc.c
> >> @@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> >>                      return -EBUSY;
> >>              if (WARN_ON(!page))
> >>                      return -ENOMEM;
> >> +            if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> >> +                    return -EINVAL;
> >>              set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> >>              (*nr)++;
> >>      } while (pte++, addr += PAGE_SIZE, addr != end);
> >> --
> >> 2.30.2
> >>
>
> Why should not this just scan over the entire user provided struct page
> array and make sure that all pages there in are valid via above method,
> but in vmap() itself before calling vmap_pages_range(). Because seems
> like a single invalid page detected in vmap_pages_pte_range() will
> anyways abort the entire vmap(). This will also enable us to drop the
> existing NULL check above.

I can do this, but why is it any better than the current approach?

Thanks,
Yury
