Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B027949605F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348417AbiAUOE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380975AbiAUOEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:04:25 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0372CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:04:25 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id l5so26032013edv.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 06:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oZlpT6bzEx+qiA4VrfBHEX+BsLOoUB2LaTYuoQqCfn0=;
        b=okG8OHX4PTHLv68X8Pq6F87DoY05RbdGKJSzY+LhnQnJMJ1hVuAxcTomJb/z+kSSXz
         axX0eNt0JufAlwkTzml6kplHNCGOhVn0+oIAj1tTxJUqSh2VLGkqMt9+23/U6qDbtFW+
         M5+yYhUHJaORcmHcn4HxiYPHe94cyrtzq7GRSVgrY/ITXV91Ck1Xy900eSraHZ7I5GDo
         UQrmcw4klm6C+pg7pAV4CnfQ739O5YJKcljiXJHL1P9UyW4CgyEq3KxCIU9DdyQITmdM
         I6KNMur1he8AsOx+fPupvCxpn9wAgv78qmTXqVbGZTueAU5fnzDa8yy00sL5rKe/gMgc
         WDbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oZlpT6bzEx+qiA4VrfBHEX+BsLOoUB2LaTYuoQqCfn0=;
        b=R2qptmjXuFo7KUCz9NXGmhqIA4ss17Vkt4Re1foLihDlUBHOFXGTYidlRRKsZ8X/hp
         /EixQZKDFqpm0ydHoDlTOHMhCnPESpk6YPaGzvp/hY7LTuDnMMZRx+EZsi3iBN0XorjH
         uYbxQqytzrI7o/msnuyfTnVrgVa7hfqGFUAsXORTWjNGq/TxUR9Dwi/2kv33o4VIWxVj
         4QNr0LeyMJD1h8Y8zrJX/+czdeihVUW/Ixtr2vWy0XrH9DcnPW1a6D4t20Jau7y4PIwK
         G6pr2bBEaoiyJezWgLLsV2QUaAEX05HTAJh4QhfD3B1sNzjtsTca5w89ciPdvKlN9o2r
         QWFQ==
X-Gm-Message-State: AOAM5332gPO2Umf0IuSv4CaUHL/goe7rz+J+GCK2po4HDQxv0xJia+e2
        94KHhRHmqGJLdg8tbZzsuAya/Yh2M3D4pBFxlvLfww==
X-Google-Smtp-Source: ABdhPJxH4OQbNOq8+RE1qEL1KLot110tAQUNbO3ApDksEs7j9hUkSbQKR+kqEnp6RCxbzo32rJV5t0JS0dyfi1TcD0o=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr4440010edv.372.1642773863492;
 Fri, 21 Jan 2022 06:04:23 -0800 (PST)
MIME-Version: 1.0
References: <20220120191250.2671557-1-pasha.tatashin@soleen.com>
 <20220120191250.2671557-2-pasha.tatashin@soleen.com> <406f41ab-5ed9-7c2e-6bc8-afcae32164c5@arm.com>
In-Reply-To: <406f41ab-5ed9-7c2e-6bc8-afcae32164c5@arm.com>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 21 Jan 2022 09:03:45 -0500
Message-ID: <CA+CK2bAWHsgnrH=xKvwEX14J2cwaJ2PHRMK4LXt2f602Yamxtg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mm/debug_vm_pgtable: remove pte entry from the
 page table
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Fusion Future <qydwhotmail@gmail.com>,
        Hugh Dickins <hughd@google.com>, Zi Yan <ziy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thanks for looking into this. See my replies below.

> > CONFIG_DEBUG_VM_PGTABLE=y
> > CONFIG_PAGE_TABLE_CHECK=y
> > CONFIG_PAGE_TABLE_CHECK_ENFORCED=y
>
> Assuming this is on latest mainline.
>
> I could enable PAGE_TABLE_CHECK on arm64 after some hacks. It did not build
> on the platform otherwise. But enabling DEBUG_VM_PGTABLE afterwards did not
> create below mentioned problems. Is the problem x86 specific ?

This is not x86 specific problem, but page_table_check does not have
support for other arches yet. The arm64 support is on my todo list.
The patch for arm64 would look something like this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d283d422c6c4f0264fe8ecf5ae80036bf73f4594

>
> >
> > During the boot the following BUG is printed:
> >
> > [    7.483050][    T1] debug_vm_pgtable: [debug_vm_pgtable         ]:
> > Validating architecture page tabs
> > [    7.490930][    T1] ------------[ cut here ]------------
> > [    7.494926][    T1] kernel BUG at mm/page_table_check.c:194!
>
> Which BUG() is this ? mm/page_table_check.c:194 on latest mainline ..
>
> void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
>                                   pud_t pud) <----

It turns out I pasted the backtrace from the modified kernel. Here the
snippet of backtrace from the mainline:
[    2.276826] ------------[ cut here ]------------
[    2.280426] kernel BUG at mm/page_table_check.c:162!
[    2.284118] invalid opcode: 0000 [#1] PREEMPT SMP PTI
...

Which corresponds to:
152 void __page_table_check_zero(struct page *page, unsigned int order)
153 {
154         struct page_ext *page_ext = lookup_page_ext(page);
155         int i;
156
157         BUG_ON(!page_ext);
158         for (i = 0; i < (1 << order); i++) {
159                 struct page_table_check *ptc =
get_page_table_check(page_ext);
160
161                 BUG_ON(atomic_read(&ptc->anon_map_count));
162                 BUG_ON(atomic_read(&ptc->file_map_count));

I will update the bug log with the mainline backtrace.

>
> > [    7.499172][    T1] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > [    7.503610][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.16.0+
> > [    7.508600][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX,
> > ...
> >
> > The entry should be properly removed from the page table before the page
> > is released to the free list.
> >
> > Fixes: a5c3b9ffb0f4 ("mm/debug_vm_pgtable: add tests validating advanced arch page table helpers")
> I am not sure whether this really fixes an existing problem.

What is detected is that a page that potentially has a PTE entry in a
user page table was put on a free list. It is not an issue for this
test, but would be an issue if it happened elsewhere.

>
> >
> > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Tested-by: Zi Yan <ziy@nvidia.com>
> > ---
> >  mm/debug_vm_pgtable.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
> > index a7ac97c76762..db2abd9e415b 100644
> > --- a/mm/debug_vm_pgtable.c
> > +++ b/mm/debug_vm_pgtable.c
> > @@ -171,6 +171,8 @@ static void __init pte_advanced_tests(struct pgtable_debug_args *args)
> >       ptep_test_and_clear_young(args->vma, args->vaddr, args->ptep);
> >       pte = ptep_get(args->ptep);
> >       WARN_ON(pte_young(pte));
> > +
> > +     ptep_get_and_clear_full(args->mm, args->vaddr, args->ptep, 1);
> >  }
>
> Although I dont see any problem on arm64 after this change.

This is because page_table_check does not have support for anything
beside x86 at the moment.

>
> >
> >  static void __init pte_savedwrite_tests(struct pgtable_debug_args *args)
> >

Pasha
