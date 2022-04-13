Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C934FF561
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiDMLEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiDMLEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:04:09 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878D49F38
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:01:48 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id z33so3022089ybh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lF5kt5jFogC6S7qxY754bNyuIo0w6PuBdFUJzlNflk4=;
        b=VXDVh+fDKwC3uuGO9jw6LeAEzVTJ9MafgNOZRbkW9CZlqFoRj9FEyK2UJkA9MElSmc
         Woz4x4sSi+ltgAYC+kwXOxbjkcCSqcZL2GlzwQtsyYm+HfclIKzi25tE1zIqQw+HDJlt
         yMCtSbEn4J9nTfww2cndozhkZahgRuKBMB766mqVzsHjcKoJeT4zbihbYDcyDQ06Vyqm
         ytLpL6yR5M3guyJ7J9BqvzlaIOCoVuvr255iHNYuylTKNWobJlsNSpUoQV1rrw66FAKT
         77FMMsKfedKFVD+onp1GnNWpShSGIPe+zVxO6xZWy8E+JY34YNUvZQFpPMfWGoWI6Lxj
         nfIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lF5kt5jFogC6S7qxY754bNyuIo0w6PuBdFUJzlNflk4=;
        b=cb/hWzkAhuBu6yVzrUrA/PV36LRijYAihBAhqiYgOgnWm3LO29E8pm+zKCHzy2nZRR
         5DNe5nnfl4cpRoC8Q9EOKsruQIq3lIInyeBSltwqWqwECE/DDFyte8/BNcWpIqmBva1L
         KUueq711HRHhiZG1tJiqKUl28v9hB7JggeDxr1uB0Uf6fcyuQS6ddt9GQbE9zz+vxo0G
         IpLYXTYw+/03/5KnbttdObb6RpzunNX7S6hIN58cthxxRHir81ncZkaKS5NrlaZICCP8
         jOBEREJX6/VlWUpL0T38eiuB1slry/bLdXk2Ah0A2lhjqVraBrK35QdNZSdinFv9KVoh
         cHsg==
X-Gm-Message-State: AOAM532mjBi1mUknGzX2C6/lgDFY+ozv1eKrvpyV/FWe9nqq7rLk9wpv
        rM0YUaGwV+A2yrR0PmfN4mYdz+j2X6POybrnuQip5W7qlFKaXSks
X-Google-Smtp-Source: ABdhPJx5whFXRNAmWiXTP4UVIi2kA1uqH5a5ihQWwBju6TkDBb7M6GgWXZ63y9AJ223kOYdVdHnWZIt7tmJEmA9fZtA=
X-Received: by 2002:a25:c094:0:b0:641:10e0:cfd8 with SMTP id
 c142-20020a25c094000000b0064110e0cfd8mr15800637ybf.88.1649847707317; Wed, 13
 Apr 2022 04:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYusMPEsFXhDd4BEMa0jy-qZxgRTCpxZ8E4gjdrpHdQGOQ@mail.gmail.com>
 <20220412140356.c0b382fe097cbf4fd040afcc@linux-foundation.org>
In-Reply-To: <20220412140356.c0b382fe097cbf4fd040afcc@linux-foundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 13 Apr 2022 16:31:36 +0530
Message-ID: <CA+G9fYvFsmCTZ6Np3ZFjTGPZGtCk2wCpqT39LiATxdFSnmkhBQ@mail.gmail.com>
Subject: Re: [next] next-20220412: BUG: Bad page map in process oom_reaper pte
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, LTP List <ltp@lists.linux.it>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mm <linux-mm@kvack.org>,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and Mike,

On Wed, 13 Apr 2022 at 02:34, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 12 Apr 2022 17:56:42 +0530 Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > Linux next-20220412 i386 LTP mm test case caused following kernel crash
> > however, test runs to complete successfully.

<trim>

> > [  952.018368] BUG: Bad page map in process oom_reaper  pte:06e7703e
> > pmd:0583f067
> >
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> I wonder if this could be 859a85ddf90e714092de again.  But the timing
> seems wrong.
>
> It seems repeatable.  Is it possible to run a bisection search please?

Thanks for looking into this issue.
Allow us sometime I will schedule this bisection and get back to you
with my findings soon. By running LTP CVE test case  "ioctl_sg01"
we are able to reproduce this problem [1] on qemu_i386.

- Naresh

[1] https://lkft.validation.linaro.org/scheduler/job/4876493#L29410
--
Crash log:
tst_test.c:1433: TINFO: Timeout per run is 0h 05m 00s
ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg1
[ 1135.167555] __swap_info_get: Bad swap file entry 6c009400
[ 1135.168577] BUG: Bad page map in process ioctl_sg01  pte:0128003e
pmd:06bfb067
[ 1135.169694] addr:289e2000 vm_flags:00100073 anon_vma:c2e29b28
mapping:00000000 index:289e2
[ 1135.171357] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[ 1135.172381] CPU: 2 PID: 31128 Comm: ioctl_sg01 Tainted: G        W
       5.18.0-rc1-next-20220411 #1
[ 1135.173914] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.12.0-1 04/01/2014
[ 1135.175263] Call Trace:
[ 1135.175662]  dump_stack_lvl+0x44/0x57
[ 1135.176274]  dump_stack+0xd/0x10
[ 1135.176785]  print_bad_pte.cold+0x82/0xd9
[ 1135.177407]  ? free_swap_and_cache+0x2e/0xe0
[ 1135.178138]  unmap_page_range+0x6b5/0x790
[ 1135.178833]  unmap_single_vma+0x6c/0xd0
[ 1135.179448]  unmap_vmas+0x71/0xe0
[ 1135.179997]  unmap_region+0x88/0xf0
[ 1135.180587]  __do_munmap+0x184/0x3f0
[ 1135.181162]  __vm_munmap+0x71/0x120
[ 1135.181750]  __ia32_sys_munmap+0x17/0x20
[ 1135.182358]  __do_fast_syscall_32+0x4c/0xc0
[ 1135.183086]  do_fast_syscall_32+0x32/0x70
[ 1135.183746]  do_SYSENTER_32+0x15/0x20
[ 1135.184317]  entry_SYSENTER_32+0x98/0xf1
[ 1135.184960] EIP: 0xb7f01549
[ 1135.185407] Code: 03 74 c0 01 10 05 03 74 b8 01 10 06 03 74 b4 01
10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 51 52 55 89 e5 0f
34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90
8d 76
[ 1135.188401] EAX: ffffffda EBX: 27d23000 ECX: 01000000 EDX: 27d23000
[ 1135.189405] ESI: 01000000 EDI: 000000a0 EBP: 09db9520 ESP: bfe3630c
[ 1135.190402] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000296
[ 1135.191558] Disabling lock debugging due to kernel taint
[ 1135.192604] __swap_info_get: Bad swap file entry 6c009401
[ 1135.193685] BUG: Bad page map in process ioctl_sg01  pte:0128023e
pmd:06bfb067
[ 1135.195104] addr:289e3000 vm_flags:00100073 anon_vma:c2e29b28
mapping:00000000 index:289e3
[ 1135.196640] file:(null) fault:0x0 mmap:0x0 readpage:0x0
[ 1135.197489] CPU: 2 PID: 31128 Comm: ioctl_sg01 Tainted: G    B   W
       5.18.0-rc1-next-20220411 #1
