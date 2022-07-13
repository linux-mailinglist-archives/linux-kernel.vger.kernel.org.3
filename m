Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16D76573CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiGMTE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbiGMTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:04:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849C9237FE
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:04:54 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id x18-20020a17090a8a9200b001ef83b332f5so5344725pjn.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 12:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1orxwhYNH5PiwyrYB0jyJkSIuY50nnqFfbHuh/ZL7I=;
        b=avb4PGJ1zBsFoRe1sUbNQUk/5H40v79kEO41b/cB8Y3KDaw0uoWwdHSxo8foiAqSyF
         c3nd6rgs1AtHaBeTbLVrqgMhuedITlxZ/3CDrPHRXwvwh+NSsPilGM3Y+i5cOA3izKlb
         L0pwabVVZfAIZzHmYYB/C54/gjBO6Fc5ky2l/NtJIyleXHl/8uVuSAQkQlTfFYaQ5HHq
         YON5CcFCNXpU9YEPjpg2K68LF3fnK9RQ0+kuSWFFb3V5gQCbQremwHcMisF6PWYI70+I
         Z99mJt5L5eyVzLKWRcD0DyITR6ESuePoIXny2YcZF67zmzGUisVvKou+VrewOW5NjQuI
         2OGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1orxwhYNH5PiwyrYB0jyJkSIuY50nnqFfbHuh/ZL7I=;
        b=XtWQmrcT/YWWW7S0dWUJ0eZxenOYllHcvpz5lIpN07eSWTGWNDsmuHLGp+I11id2MB
         nbG1hU7xNzzPQbKnf6nUsSEGHyD3lIIcO5ugPqZhDSRi4wrIFwY+1xYu7qdujk8PHffY
         iNifyULjYP2MpnD0DMalHODWFZSAAf3ZXHh2+VoNYiM5uiZVSMqbTjxlXAx7+CPUrloF
         bDjq9Ytx8dkFsT2tVfDNThtXRzgMoQwViBfony4h4bcY0LterKTy/lPXzEFWUE+7NQYj
         Qxy8dMk2WDnpN4f+G7e0QhXRegvH6IXh/JgxZWFa+ka8n9AqKQZJorQUIhYdKy43vyDq
         kCjg==
X-Gm-Message-State: AJIora8CAUx1cgsL5HBl8lVmDH7w7AnIrybo3o0oj4q7W4ZtHQXlpZKA
        So93j+3675s9aPi4nla/LdQYNuAWUbq3/jc3BEs=
X-Google-Smtp-Source: AGRyM1t1jNZ022cdlgbDx+/v4pQmnO3rHve+6Eq+6Dvus6xTKagAqGsmxS1nUlYMnWRogKMt/6UHg+YFTA6fzL+U3hU=
X-Received: by 2002:a17:903:2405:b0:16a:8010:1e16 with SMTP id
 e5-20020a170903240500b0016a80101e16mr4544761plo.87.1657739094012; Wed, 13 Jul
 2022 12:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <202207100715.TBIYQ4fc-lkp@intel.com> <CAHbLzkoFjZoX0WFy9YaOO1rEC+=yyytgDimapeTEyuNyMNTHLg@mail.gmail.com>
 <Ys7Vjt5QXz8XK1LZ@google.com>
In-Reply-To: <Ys7Vjt5QXz8XK1LZ@google.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 13 Jul 2022 12:04:41 -0700
Message-ID: <CAHbLzkq4QJ0exWDxaSfAJ0sW0GmrwbDg1w1oEi00i9rKa8UZQA@mail.gmail.com>
Subject: Re: [akpm-mm:mm-unstable 284/293] mm/khugepaged.c:2409
 madvise_collapse() warn: possible memory leak of 'cc'
To:     "Zach O'Keefe" <zokeefe@google.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:24 AM Zach O'Keefe <zokeefe@google.com> wrote:
>
> On Jul 12 10:02, Yang Shi wrote:
> > On Tue, Jul 12, 2022 at 5:36 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-unstable
> > > head:   0e9f775fb0b4adf1a4ef50ea156ead09a0fc5194
> > > commit: 9f626ffb1d1c5c26b4a8e0fdffec784a5f773274 [284/293] mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse
> > > config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220710/202207100715.TBIYQ4fc-lkp@intel.com/config)
> > > compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > >
> > > smatch warnings:
> > > mm/khugepaged.c:2409 madvise_collapse() warn: possible memory leak of 'cc'
> > >
> > > vim +/cc +2409 mm/khugepaged.c
> > >
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2387  int madvise_collapse(struct vm_area_struct *vma, struct vm_area_struct **prev,
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2388                 unsigned long start, unsigned long end)
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2389  {
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2390    struct collapse_control *cc;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2391    struct mm_struct *mm = vma->vm_mm;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2392    unsigned long hstart, hend, addr;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2393    int thps = 0, last_fail = SCAN_FAIL;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2394    bool mmap_locked = true;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2395
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2396    BUG_ON(vma->vm_start > start);
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2397    BUG_ON(vma->vm_end < end);
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2398
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2399    cc = kmalloc(sizeof(*cc), GFP_KERNEL);
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2400    if (!cc)
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2401            return -ENOMEM;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2402    cc->is_khugepaged = false;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2403    cc->last_target_node = NUMA_NO_NODE;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2404
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2405    *prev = vma;
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2406
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2407    /* TODO: Support file/shmem */
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06  2408    if (!vma->anon_vma || !vma_is_anonymous(vma))
> > > 9f626ffb1d1c5c Zach O'Keefe 2022-07-06 @2409            return -EINVAL;
> >
> > It seems better to move the cc kmalloc after the anonymous vma check?
> >
>
> Agreed - something I only noticed when fixing this. I've cleaned up some
> ordering here, now looks like:
>
> ---8<---
>         BUG_ON(vma->vm_start > start);
>         BUG_ON(vma->vm_end < end);
>
>         *prev = vma;
>
>         /* TODO: Support file/shmem */
>         if (!vma->anon_vma || !vma_is_anonymous(vma))
>                 return -EINVAL;
>
>         if (!hugepage_vma_check(vma, vma->vm_flags, false, false, false))
>                 return -EINVAL;
>
>         cc = kmalloc(sizeof(*cc), GFP_KERNEL);
>         if (!cc)
>                 return -ENOMEM;
>         cc->is_khugepaged = false;
>         cc->last_target_node = NUMA_NO_NODE;
>
>         mmgrab(mm);
>         lru_add_drain_all();
>
>         hstart = (start + ~HPAGE_PMD_MASK) & HPAGE_PMD_MASK;
>         hend = end & HPAGE_PMD_MASK;
>
>         for (addr = hstart; addr < hend; addr += HPAGE_PMD_SIZE) {
> ---8<---
> out_nolock:
>         mmap_assert_locked(mm);
>         mmdrop(mm);
>         kfree(cc);
> ---8<---

Looks good to me.

>
> > >
> > > kfree(cc);?
> > >
> > >
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://01.org/lkp
> > >
> > >
